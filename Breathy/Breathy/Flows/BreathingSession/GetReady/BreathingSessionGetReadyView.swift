//
//  BreathingSessionGetReadyView.swift
//  Breathy
//
//  Created by Andrei Olteanu on 30.05.2022.
//

import SwiftUI

struct BreathingSessionGetReadyView<ViewModel: BreathingSessionGetReadyViewModel>: View {

    // MARK: - Public Properties

    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Body

    var body: some View {
        ZStack {
            Image(Asset.imgMainBackground.name)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .background(Color(.primaryBackground))

            VStack {
                Spacer()

                VStack(alignment: .center, spacing: .padding3x) {
                    Text("\(viewModel.inputs.currentTime)")
                        .font(Font(.h1Bold))
                        .foregroundColor(Color(.progressBarColor))

                    Text(L10n.BreathingSession.getReady)
                        .font(Font(.h1Bold))
                        .foregroundColor(Color(.primaryText))
                }

                Spacer()

                VStack(alignment: .center, spacing: .padding2x) {
                    Image(Asset.icnWarning.name)

                    Text(L10n.BreathingSession.warning)
                        .font(Font(.tertiaryTextRegular))
                        .foregroundColor(Color(.secondaryText))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                }
                .padding(.bottom, .padding6x)
            }
            .padding([.leading, .trailing], .padding3x)
        }
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.outputs.onAppear()
        }
    }
}

struct BreathingExerciseGetReadyView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingSessionGetReadyView(viewModel: BreathingSessionGetReadyViewModelImpl(getReadyDuration: 3))
    }
}
