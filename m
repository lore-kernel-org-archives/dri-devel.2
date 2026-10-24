Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D64606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=Poz2aMRi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8EA10E665;
	Sat, 24 Oct 2026 23:00:49 +0000 (UTC)
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E4910E038
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 14:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1792852127; x=1793111327;
 bh=eeV3+U5/yrctaUKSJ/PKpGOtHdLYEHHC9dwLeVDP3lg=;
 h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Poz2aMRiybGqje6dJX61E0vcxeWB4RF/bD6ruBGZuGc/6/PrXUfIejQfTT+M4CxIO
 wfbgs21HnYhwgpnS2rTLDXWay7xXop0WiV4FAbunpoUnHPj/V4uwnBytOGOpw1kbmQ
 c6M3AaaO2I/W2/+xrXQHxTsfHxYWhOxrdUi4yyqaNLYJgIpLazzSTwPCPHNYQ9l1RL
 gIdALN8BSHcSYT8pXr/Jb+lz/NbgCPWn/JYmqts5VONNdXlD9sn6HGK++YFXtY1EH3
 TZrofNj0ux1YiQrxceOKFlcZPybyqNm/vj+3k7HBPS5fNxsCrX0VGknOdQtVEc2RMe
 cpVf1JmY3qctQ==
X-Pm-Submission-Id: 4jBj1T284sz1DDnW
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
Date: Sat, 24 Oct 2026 15:27:59 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: sm6115: Add missing MDSS AHB clock
Message-ID: <7f99fda6f99d6053db240f2f1ba4d7b71da72261.1792852079.git.me@michaelmcallister.org>
In-Reply-To: <cover.1792852079.git.me@michaelmcallister.org>
References: <cover.1792852079.git.me@michaelmcallister.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 24 Oct 2026 22:59:01 +0000
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
---
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
 
