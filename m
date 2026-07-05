Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D97C43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF2E10E22D;
	Sun,  5 Jul 2026 19:14:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LaHvWV4h";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB8010E229
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:17 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so20592585e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278855; x=1783883655; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G3eyPuG/7N0ePFJ/qBb/yJdx1/OQTbqvhMmqlXZb7jM=;
 b=LaHvWV4hFv6FrdVrfEK8kthGWBOSy6YoXDHwZ8v5CDs6pmIyiVp31tkRcCyO2JLBwl
 2H18At3aaVBS0W7jCdiXzwtlBVrqNvP3N4NSXZ08FHfpv1/92OmWQRrk31r6DDLWq/V6
 ZpIQz/+8Ur+3u5UoXsvHFrVs1mkxmdQNPCJjx3OUfxxWRjMp/13J9ks+2qHcVsPADEZd
 X3h3iFuqJg9Zc/arpg8rNROsFqTOt7kH9KvZhY4cnizbrOf/HLo4Hh/76CFzlfgJjITX
 AZP0a47VTi4ojteH4Am7wsGQXe2HFu7HXyBS69NdHt4yUqfmJtDwUSa1Pz6uun/Leh1A
 9aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278855; x=1783883655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G3eyPuG/7N0ePFJ/qBb/yJdx1/OQTbqvhMmqlXZb7jM=;
 b=jOQ5/9lD/V8slHUuq8fGy0w0RPtyYbmKaxAvwzef7x+Te8ZqzZaFoDfjOiwM4uSwo1
 KPIDu6oQUKMzU3D65R2AkaW2VYmwp/LlQGGkztvEyefdx3QC8zzeDjLItsXT7HmcPPce
 QHmeX3wzZ84csSqKj1WJtFhK4Fx3xqGjxrviInXS851kKaJl2bZ7Vtga/KkIYPUi4eNV
 pZP/ZJQcQUi2ab/qobKRMK0YELf7Lq+OPBTxJmBfTWI0WnvPpFm01XVcDPyj5Z7f590U
 rL1tBwL5Q8paSilmIttYvLThn2JoiXT3fUPsmjebY1FfJhSkz/oceNZCf8wt7GNsjUiM
 Cm+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBwP6IiUfBuGqzCdeI2eOwScnz4Awj+JbaMxbOlH0Lfy3Me4OFDKpfj0FHNg3aaq5RTZEmYmEov30=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPZpokEzKYAioCb/wWOByjb9JJPH7itTUxohtQrZxiiFPZwNyw
 oO9fwNp4SqJolmmPSFMe+EMgesYUK3NREmdr36tN82b7rzX3KqymmQE=
X-Gm-Gg: AfdE7ckdEMjpvDtEieZ4VvqElRIsLhB5Ww/uoPV4b+qryQdwL6ZfXvYFPRGXP4Mf7mH
 1Yx7XjzA5go3eTcLn7m4voRxvs5IH1BRzlb2ntvyauUPLPlPq3rTz00e1M2tpSRfV0Q+Bb8kiL9
 DNBs3yjlDlOhD+dse3QpWn10hPXJHKEGMe+JeGOu8D9M4Y1ma1ixS117jCdOJ3/lCzj9bK56VPW
 opQe585KfTk6w/t17TARaWjxKkC7mlFsGGch7vzwXADj4SdmltNkRdedb4WcMS2hhXBhsWpQc3L
 WPQe9ugoUaEZMo5NJT2AWsRT63b7+RO/LPTXWNoZs9zJETeI8y9qOyhQ8AtLrllIwpK9FE3uScB
 yg0CjGDptzRWQNJiE5tJqaoQXiKBaCOxPKfr9W8agPaFziQ00qwXRU92aHC8C3BL5Eu5LziLhUA
 PTU7oMiJ0GRmHi/iNKVW3rkZjGy30Op7ttrjPlesNX
X-Received: by 2002:a05:600c:628f:b0:493:bf84:53d8 with SMTP id
 5b1f17b1804b1-493d11d7d55mr92320425e9.9.1783278855325; 
 Sun, 05 Jul 2026 12:14:15 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:14 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:35 +0200
Subject: [PATCH RFC 01/13] iommu: arm-smmu-qcom: Configure lpac device with
 split address space
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=2198;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=TOpopsFtZ1PPnGuz7Qdse1Rb2dSOsjvazts1+j2Qsuk=;
 b=swnPSg6jJwnfwPpO2lUtsliGm7jHo9gqL51QEmCML+oAIm1zPDuCFHYdt3TNVGcjeXVx38cVC
 13fGjbA8BMDAB0TZwyRx8GCJenaSAUzrSU2r89a5X2KYaRbtynBvrSe
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

We want the context bank used by LPAC to use split address space just
like GFX.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index edd41b5a3b6a..48a590aaeb5e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -35,6 +35,8 @@
 static const struct of_device_id qcom_smmu_actlr_client_of_match[] = {
 	{ .compatible = "qcom,adreno",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
+	{ .compatible = "qcom,lpac",
+			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,adreno-gmu",
 			.data = (const void *) (PREFETCH_DEEP | CPRE | CMTLB) },
 	{ .compatible = "qcom,adreno-smmu",
@@ -217,6 +219,7 @@ static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_a
 }
 
 #define QCOM_ADRENO_SMMU_GPU_SID 0
+#define QCOM_ADRENO_SMMU_LPAC_SID 1
 
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
@@ -230,7 +233,8 @@ static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 	for (i = 0; i < fwspec->num_ids; i++) {
 		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
 
-		if (sid == QCOM_ADRENO_SMMU_GPU_SID)
+		if (sid == QCOM_ADRENO_SMMU_GPU_SID ||
+		    sid == QCOM_ADRENO_SMMU_LPAC_SID)
 			return true;
 	}
 
@@ -305,9 +309,9 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	 */
 	if (qcom_adreno_smmu_is_gpu_device(dev)) {
 		start = 0;
-		count = 1;
+		count = 2;
 	} else {
-		start = 1;
+		start = 2;
 		count = smmu->num_context_banks;
 	}
 
@@ -394,6 +398,7 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 
 static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,lpac" },
 	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,glymur-mdss" },
 	{ .compatible = "qcom,mdp4" },

-- 
2.54.0

