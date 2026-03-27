Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFE710F2862
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846EB10E259;
	Fri, 27 Mar 2026 17:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EcByUmB/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172A110E1BE;
 Fri, 27 Mar 2026 17:52:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A514443C4B;
 Fri, 27 Mar 2026 17:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7103C19423;
 Fri, 27 Mar 2026 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774633920;
 bh=zRvA02n55H6F0ORN5r8qynowYTw/58ttft03ZFRvRRY=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=EcByUmB/fhOaTUDVp1b/zq+k+LRyAaNVR6S4h9vSV8N/eofFsVaZC/p4h1A+jJNP3
 9rEIsTsYK+kG24THax9IbEikcfE3m5NRFmdwk6T8NP03bthRsa4BivZIuRjA2w8HGC
 cpBkb9abwr1Gxl6Wq0l2GFOxGRV39Z38P8Kew4q4FfPiuIvQK4eix5y07qCdOTZwTi
 lV4jmMWLqLErykoYKx78LUDOR7m3IxaBklGXU4Ej6Oeqwky7u2vdxYuTSqraAwgtpu
 6bXPg7JymaoTujsQjn2Zlg9PlLyOKbXSMSYxnxxsJvbNCL9LwQ5qIXzLPNBDR2RSQP
 Ov6vM4Kz7prBQ==
Date: Fri, 27 Mar 2026 12:51:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, devicetree@vger.kernel.org, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Alexander Koskovich <akoskovich@pm.me>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20260327-milos-mdss-v2-4-bc586683f5ca@fairphone.com>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
 <20260327-milos-mdss-v2-4-bc586683f5ca@fairphone.com>
Message-Id: <177463391769.3232558.4643402365403400713.robh@kernel.org>
Subject: Re: [PATCH v2 4/9] dt-bindings: display: msm: document the Milos
 Mobile Display Subsystem
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Fri, 27 Mar 2026 17:12:23 +0100, Luca Weiss wrote:
> Document the Mobile Display Subsystem (MDSS) on the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  .../bindings/display/msm/qcom,milos-mdss.yaml      | 283 +++++++++++++++++++++
>  1 file changed, 283 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:36.31-51 Unexpected 'DISP_CC_MDSS_AHB_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:37.28-47 Unexpected 'GCC_DISP_HF_AXI_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:38.31-51 Unexpected 'DISP_CC_MDSS_MDP_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:40.31-52 Unexpected 'DISP_CC_MDSS_CORE_BCR'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:42.42-61 Unexpected 'QCOM_ICC_TAG_ALWAYS'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:43.41-60 Unexpected 'QCOM_ICC_TAG_ALWAYS'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:44.41-65 Unexpected 'QCOM_ICC_TAG_ACTIVE_ONLY'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:45.43-67 Unexpected 'QCOM_ICC_TAG_ACTIVE_ONLY'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:49.38-60 Unexpected 'DISP_CC_MDSS_CORE_GDSC'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:69.32-51 Unexpected 'GCC_DISP_HF_AXI_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:70.35-55 Unexpected 'DISP_CC_MDSS_AHB_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:71.35-59 Unexpected 'DISP_CC_MDSS_MDP_LUT_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:72.35-55 Unexpected 'DISP_CC_MDSS_MDP_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:73.35-57 Unexpected 'DISP_CC_MDSS_VSYNC_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:80.44-66 Unexpected 'DISP_CC_MDSS_VSYNC_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:142.35-57 Unexpected 'DISP_CC_MDSS_BYTE0_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:143.35-62 Unexpected 'DISP_CC_MDSS_BYTE0_INTF_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:144.35-57 Unexpected 'DISP_CC_MDSS_PCLK0_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:145.35-56 Unexpected 'DISP_CC_MDSS_ESC0_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:146.35-55 Unexpected 'DISP_CC_MDSS_AHB_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:147.32-51 Unexpected 'GCC_DISP_HF_AXI_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:155.44-70 Unexpected 'DISP_CC_MDSS_BYTE0_CLK_SRC'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:156.44-70 Unexpected 'DISP_CC_MDSS_PCLK0_CLK_SRC'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:157.58-74 Unexpected 'DSI_BYTE_PLL_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:158.58-75 Unexpected 'DSI_PIXEL_PLL_CLK'
Lexical error: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dts:219.35-55 Unexpected 'DISP_CC_MDSS_AHB_CLK'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1614: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260327-milos-mdss-v2-4-bc586683f5ca@fairphone.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

