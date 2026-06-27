//
//  HomeScreen.swift
//  Utera
//
//  Created by Bee Wijaya on 27/06/26.
//

import SwiftUI
import SwiftData

struct HomeScreen: View {
    // MARK: - Storage
    @Query private var cycles: [CycleModel]
    @Query private var cyclesPredicted: [CyclePredictModel]
    private var cycle: CycleModel? {
        cycles.first
    }
    private var cyclePredicted: CyclePredictModel? {
        cyclesPredicted.first
    }
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    // MARK: - State
    @State private var currentDate: Date = Date.now
    
    // MARK: - ViewModel
    @State private var predictionCycleVM = PredictionCycleViewModel()
    
    
    // MARK: - Property
    var nextPeriodFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: predictionCycleVM.result?.nextPeriodDate ?? "") else { return "" }
        return date.formatted(.dateTime.month(.abbreviated).day())
    }
    
    func resync() {
        cyclesPredicted.forEach { modelContext.delete($0) }
        predictionCycleVM.result = nil
        Task {
            await predictionCycleVM.generate(modelContext: modelContext)
        }
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
                    .shadow(color: .black.opacity(0.1), radius:1)
            }
            .padding(.bottom, 30)
            
            WeeklyCalendar(cyclePredicted: predictionCycleVM.result)
                .padding(.bottom, 20)
            
            if !predictionCycleVM.isLoading {
                FertileWindow(currentDate: currentDate, cyclePredicted: predictionCycleVM.result)
                    .padding(.bottom, 20)
                
                VStack {
                    Button {
                        resync()
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
            } else {
                ProgressView()
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .onAppear {
            predictionCycleVM.load(cycle: cycle, cyclePredicted: cyclePredicted)
            
            if cyclePredicted == nil {
                Task {
                    await predictionCycleVM.generate(modelContext: modelContext)
                    
                    print(predictionCycleVM.result ?? "")
                }
            } else {
                Task {
                    try? await Task.sleep(for: .seconds(2))
                    predictionCycleVM.isLoading = false
                }
            }
            
            print(predictionCycleVM.result)
        }
    }
}

#Preview {
    ZStack {
        Color("Background")
            .ignoresSafeArea(.all)
        
        HomeScreen()
    }
}


