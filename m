Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=CzNGIVmq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF1410F32F;
	Tue, 27 Oct 2026 09:32:11 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0675810E09A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1793051878; x=1793311078;
 bh=eN5G9Ls9ytaUpIc52dHNgLyCQKxcctTRzTTICGzufKU=;
 h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=CzNGIVmquSW6BfZMSXWq4zv2h80MFfs9R+EpCS7mSO1uuz0aWiNY+ZvtL2Xtdnvk3
 puFwa3oVFzJXqJdgZONh0R6S+dyEQefnZaQi2lDiGzEQdjF4fV61rJPqjPE4zXNV8j
 Ii3uWsPY1T0gSf0rPICpgqSGkfHDHa+eaBQB5prPvmpYMVa8dShCv0+f8529RF0g+X
 bSTUhdb1+HFF3TZCHkarDVsX07RrmiSu+i3CcZCWKmZ3FC2eHeyq3g4+kHCd3uE7/2
 W82j/Pod+rm2A/slyWehOktafQeWr4ELHB5jIoNnKQ06mX9U/Fe6JhAegQBEBFSh+j
 lWUaGYiDkNTOA==
X-Pm-Submission-Id: 4jD6tq1grjz2SccZ
From: Michael McAllister <me@michaelmcallister.org>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 21:46:23 +0000
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm6115: Add missing MDSS AHB clock
Message-ID: <179305118391.93309.8898668683371265381.sm6115-mdss-ahb-v2-2@michaelmcallister.org>
In-Reply-To: <179305118390.93309.15055947565850813746.sm6115-mdss-ahb-v2-0@michaelmcallister.org>
References: <cover.1792852079.git.me@michaelmcallister.org>
 <179305118390.93309.15055947565850813746.sm6115-mdss-ahb-v2-0@michaelmcallister.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MDSS node is missing DISP_CC_MDSS_AHB_CLK. Although the DPU child
already requests this clock, MDSS resumes before the child enables it.
The MDSS hardware-version register can then read as zero, causing
msm_mdss_enable() to skip UBWC configuration.

On the Motorola Moto G10 (SM4250), this results in garbled compressed
scanout after display power cycling. Adding the clock restores the
UBWC configuration and makes compressed and linear scanout agree.

Include the DISPCC AHB clock in the MDSS clock list so that its existing
bulk clock handling enables it before accessing the MDSS registers.

Fixes: 705e50427d81 ("arm64: dts: qcom: sm6115: Add mdss/dpu node")
Cc: stable@vger.kernel.org
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Changes in v2:
- Remove the blank line between commit trailers.
- Add the received Reviewed-by tag.

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 0f2af8aba..f7002b9eb 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1927,7 +1927,8 @@ mdss: display-subsystem@5e00000 {
 
 			clocks = <&gcc GCC_DISP_AHB_CLK>,
 				 <&gcc GCC_DISP_HF_AXI_CLK>,
-				 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
 
 			resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 
