Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EC606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=michaelmcallister.org header.i=@michaelmcallister.org header.a=rsa-sha256 header.s=protonmail2 header.b=tkn9Y4FK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A18510F346;
	Tue, 27 Oct 2026 09:32:34 +0000 (UTC)
X-Greylist: delayed 659 seconds by postgrey-1.36 at gabe;
 Mon, 26 Oct 2026 22:08:54 UTC
Received: from mail-106109.protonmail.ch (mail-106109.protonmail.ch
 [79.135.106.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E679D88284
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 22:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=michaelmcallister.org; s=protonmail2; t=1793051877; x=1793311077;
 bh=GMPgA3EBxmbirXr7ioFEKqqBpPi8WSoOiSXXleNvfNw=;
 h=From:To:Cc:Date:Subject:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=tkn9Y4FKFi8kckoT3QItqsbKbJ3gq4xQoSZL7RSrig9nHxDNF8yiE+KjoK/Lt0VXU
 /bz9tdFjDf3O9EBZBQYQxFMbFxNe88VdMI9VPegrTL0V0WpVDhuxvCMsQZ02gm1+nH
 APxqgo+lJ5FbwIxpyT/v4gSRdowBT3bdOJQLV0PJmvEhxTGYcx+eKJ7AaD08c0flX2
 0wteMDMbQipX/mWWvAKDN3tPcwfKA7pE/VaD+kTKHpSv7GqzShWOBDksBtFY9e+Qit
 Q4q/u+IcfXVYQ4bmBTwTBycdjLgGfNuXhgh24ySVU8ccTT/pVzHAqyDr1pSujtpMVL
 E3eWqWAthg/GQ==
X-Pm-Submission-Id: 4jD6tm1dNZz2ScNH
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
Subject: [PATCH v2 1/2] dt-bindings: display: msm: sm6115-mdss: Add missing
 AHB clock
Message-ID: <179305118391.93309.11849204023910016023.sm6115-mdss-ahb-v2-1@michaelmcallister.org>
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

MDSS register access requires the AHB clock supplied by DISPCC, in
addition to the GCC bus clocks and the MDP core clock already listed.
The DPU child also uses this clock, but MDSS needs it before the child
resumes so that it can access its own registers.

Add the missing clock to the end of the list and update the example.
Keep the existing three-clock descriptions valid for compatibility with
older device trees.

Fixes: b93bdff44a85 ("dt-bindings: display/msm: add support for SM6115")
Signed-off-by: Michael McAllister <me@michaelmcallister.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
- Remove the blank line between commit trailers.
- Add the received Reviewed-by tag.

 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
index 309de1953..d4fac93d9 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
@@ -21,10 +21,12 @@ properties:
     const: qcom,sm6115-mdss
 
   clocks:
+    minItems: 3
     items:
       - description: Display AHB clock from gcc
       - description: Display AXI clock
       - description: Display core clock
+      - description: Display AHB clock from dispcc
 
   iommus:
     maxItems: 2
@@ -92,7 +94,8 @@ examples:
         power-domains = <&dispcc MDSS_GDSC>;
         clocks = <&gcc GCC_DISP_AHB_CLK>,
                  <&gcc GCC_DISP_HF_AXI_CLK>,
-                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc DISP_CC_MDSS_AHB_CLK>;
 
         interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-controller;
