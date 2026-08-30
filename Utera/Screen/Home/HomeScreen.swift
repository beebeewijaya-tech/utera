//
//  HomeScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftData
import SwiftUI

struct HomeScreen: View {
    // MARK: - Storage

    @Environment(\.modelContext) private var modelContext: ModelContext

    @Query private var cycles: [CycleModel]
    @Query private var cyclesPredicted: [CyclePredictModel]

    private var cycle: CycleModel? {
        cycles.first
    }

    private var cyclePredicted: CyclePredictModel? {
        cyclesPredicted.first
    }

    // MARK: - State
    @State private var currentDate: Date = .now

    // MARK: - ViewModel
    @Environment(SnackbarViewModel.self) private var snackbarVM
    @State private var predictionCycleVM: PredictionCycleViewModel
    
    // MARK: - Properties
    var nextPeriodFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: predictionCycleVM.result?.nextPeriodDate ?? "") else { return "" }
        return date.formatted(.dateTime.month(.abbreviated).day())
    }

    // MARK: - Function
    func resync() async {
        cyclesPredicted.forEach { modelContext.delete($0) }
        predictionCycleVM.result = nil

        // will call generate
        await predictionCycleVM.generate()
    }

    // MARK: - Init
    init(cyclePromptStorage: ICyclePromptStorage) {
        _predictionCycleVM = State(initialValue: PredictionCycleViewModel(
            cyclePromptStorage: cyclePromptStorage
        ))
    }

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(currentDate, format: .dateTime.weekday(.wide).month(.abbreviated).day())
                        .font(.caption)
                        .foregroundStyle(Color("TextSecondary"))

                    Text("Hi, Maya")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color("TextPrimary"))
                }

                Spacer()

                Image(systemName: "bell")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.caption)
                    .frame(width: 25, height: 25)
                    .padding(16)
                    .background(.white)
                    .foregroundStyle(Color("Primary"))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 1)
            }
            .padding(.bottom, 30)

            switch predictionCycleVM.state {
            case .loading:
                ProgressView()
            default:
                FertileWindow(currentDate: currentDate, cyclePredicted: predictionCycleVM.result)
                    .padding(.bottom, 20)

                VStack {
                    Button {
                        Task {
                            await resync()
                        }
                    } label: {
                        Label("Re-sync", systemImage: "arrow.clockwise")
                            .font(.caption)
                            .foregroundStyle(Color("TextSecondary"))
                    }
                    .padding(.bottom, 4)

                    Text("Next period predicted \(nextPeriodFormatted)")
                        .font(.caption)
                        .bold()
                }
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .task {
            await predictionCycleVM.load(cycle: cycle, cyclePredicted: cyclePredicted)
        }
        .onChange(of: predictionCycleVM.state) { old, new in
            if old != new, case let .error(error) = new {
                snackbarVM.showMessage(error, type: .danger)
            }
        }
        .snackbar()
    }
}

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)

        HomeScreen(cyclePromptStorage: CyclePromptStorage(context: PreviewContainer.shared.mainContext))
            .environment(SnackbarViewModel())
    }
}
