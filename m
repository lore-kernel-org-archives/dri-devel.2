Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C734BC44501
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 532E610E250;
	Sun,  5 Jul 2026 19:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oSM94VIC";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DF1410E236
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:23 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so15359225e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278862; x=1783883662; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bPcQkNch1dlro+P09FAFemSnMdYXsI9mjXSoWgS8Puc=;
 b=oSM94VICPCUHPwPB8vQrZvltq9ZAlEm1acPqyBD45EWPszZBsNeZQfK6UU2ks8Pv4R
 NbOZjvVfeK8eoX0wmUfC+aEM6DRRPlwJNR2JQVUI7IiTgDZtjwGB3U8e8UcAu2ifOsaa
 p7/sAZcpbs3YD7vnxH5bHZSTHRI2dKnniV6HWVLiVcfjfknZg7R5ewzY6SzNZFsvUsmh
 Yhq7HT2hIK3/fr7FCVcyywvWKYbr6geYjjRNjy7SpTTQ+E1+do/0cikEjA7r9Y5+3zXS
 jHdstQ4ntGwuJ63Puh41qvMT28weuhewCD8eicBDV79loyWvwl//yBvlzEZrnT2RT+ec
 X43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278862; x=1783883662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bPcQkNch1dlro+P09FAFemSnMdYXsI9mjXSoWgS8Puc=;
 b=VtWYfxy733eQSzyQmz6eDecHkiZB4suFMEuVAFuIQnXzUghGQmI9h4HNRwZw6NtsA6
 Dx6c9TnHvaCCmUDJg4AhPoB/QI2+PWUspv/efVLLsJorO/7GIfi26EGUrCfuIzpjn4ej
 0de3u+1TvP9jdu05t3tj1ot4iVVjQwXMKh+OkF+8it/fz9s7Y585W/htwYJnH4vaU+Vy
 9KA2W3yXunSqaebdcO01ERgwvMerSQ5G6kP2D7lByVA4KojAwRNfCyIi2aH3vcI5jwAU
 A0ZY9ZGC5eq4C/piWq8o3wUudR3DCnkMGx2PE9MyWYxE+yM+ejugrGOvEKLW5p5Ya2bA
 d/2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUO6WW+jTWii6ynIPhF2+cQ+1YukqEE3feDMLp+gtxjN64nC03OQ1HgAZhpA2lSPG/6+yKRHPRKhA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdiqTWrdQZUqwXNk2R6lrio4npu4XtnJRdDFwi4rJ6Oa4kZxbe
 V+an2WsV9alNoJu4ca5gSyK70M7BNSJ/zLJuCPISFy2ZUTTGnugzz3Q=
X-Gm-Gg: AfdE7cl5zddhssB60UWyQaTW/FfM29mzBzVREUv5zP6F3JA6kEbxOXhJXE3iXWCXM/A
 LLBN7mjdlibT6iDC3MLSIJ9VfgarXBhTvRFS8AdP+wYdbNRgJycRSLxlKOZmU9u9LM+UZ0THMKR
 CB5Sr0yUq/5jMCQKINWuCp9PxThP1F8LacwbdEdMK5bn4bqFJUUr206XFehFOjCp8DqMpXU/oQC
 EfNecuP2LZ6UHH0XrJc+/w3nC0zuGfrhtF2g3VSL86JWrJsuKqeUWYcLe594VJlg3YHf00GMy82
 NFXPYRxluMS98uRym7qej59udPs4U3dQKLciZSsXXzxSwUgtqvqxH8HWvrd0HZ/to6QY9I+Ky6d
 Ru4O8hBU9GaSTFHRfhjGoHDHRYpwR/z6TobJ5f905otiOxWIYIf7AYP8cN9V6jfZ0FP3snY8tUr
 kcSqBVrGIbsxKlFRFNPFwZQz381mKreg==
X-Received: by 2002:a05:600c:3f0a:b0:493:bfad:9d99 with SMTP id
 5b1f17b1804b1-493d11db690mr80342755e9.13.1783278861616; 
 Sun, 05 Jul 2026 12:14:21 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:20 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:38 +0200
Subject: [PATCH RFC 04/13] arm64: dts: qcom: sm8650: move smmu sid 1 to new
 lpac device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-4-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1315;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=W9JuocKrQv+AohpUo+PmkcNR8I1xfDAl+4Cp7RFtojI=;
 b=kEwYPS/vxpnj4j1Y93tuTQI1VkpzxodgIkiDcPohzvaSRPC/w1pcsAEP4JHxHA84titeQ5f9H
 M3dIrUAZLjTC7VIAtRzh7eh4qQ+kjl3T5Nk55cOzsLMoPsgmplJk+HF
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

Previously both SID 0 and 1 where associated with the same domain.

When LPAC is not used this is needed so firmware can acces memory when
initializing using the same page table as GFX.

To use LPAC however we need to move SID 1 to a different device.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 1604bc8cff37..44e5f9d4b335 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -4133,6 +4133,13 @@ tcsr: clock-controller@1fc0000 {
 			#reset-cells = <1>;
 		};
 
+		lpac: lpac@3d00000 {
+			compatible = "qcom,lpac";
+			reg = <0x0 0x03d00000 0x0 0x61000>;
+
+			iommus = <&adreno_smmu 1 0x0>;
+		};
+
 		gpu: gpu@3d00000 {
 			compatible = "qcom,adreno-43051401", "qcom,adreno";
 			reg = <0x0 0x03d00000 0x0 0x40000>,
@@ -4144,8 +4151,9 @@ gpu: gpu@3d00000 {
 
 			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH 0>;
 
-			iommus = <&adreno_smmu 0 0x0>,
-				 <&adreno_smmu 1 0x0>;
+			iommus = <&adreno_smmu 0 0x0>;
+
+			qcom,lpac= <&lpac>;
 
 			operating-points-v2 = <&gpu_opp_table>;
 

-- 
2.54.0

