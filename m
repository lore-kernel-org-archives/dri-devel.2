Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF079C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F5610E23E;
	Sun,  5 Jul 2026 19:14:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMpvnd48";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CFE10E259
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:25 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so1499444f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278864; x=1783883664; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=56825qeGGlTN+/ozHQUtA7w6Jg/t8lgL+V6rDIROEUU=;
 b=DMpvnd48c6plAt8HJcHeGx+/Ldjjzx7aCwpsgL9CkxVqdm/pRmWIRkVf1kpdW834rp
 W/2kjAHNjvPmVQAl86ir/w/q/hY24qoE5qigIxkENjdFEI65+uPAQD57DDVod7mo1iFr
 qR7NIZ46rS/WMQw6mPBYQVb68q14na5aa0TZc2iw4Svqkd06M+0Ph8qasdXPakCRbNAY
 pAVGif/igW+2v56R6RXZDZG4FW70ATCLATmK9nbQDRhd70gxhwWXCks3u7HIylcLI9lL
 NcLtT5mZfEyAVKVSftBr1Uu84lCTA/8SpjACEIKdfFOcFKT5OoOjaDkPUpmP7iIEiXBP
 qTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278864; x=1783883664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=56825qeGGlTN+/ozHQUtA7w6Jg/t8lgL+V6rDIROEUU=;
 b=CzxMNk7i3mC6lFp7QDGolqOUdqhcbOf3gMX/OZCXwYvlRu/4zrLXhQdBACMoLpU1QD
 xRIFvcVVigMhLYwRLbtLiTd5h7CNqkGDeq73gk3UrS6gTgCmy0ni2kL+iKnxggs81IIO
 wch9MjLWWW3RcuzxFia5AuzNA+aU/Y79T12ivhm+RbL3JPVyjqePjT6SdhQV68EvWjZl
 nmURx1epz08YcDFKMAFh25teIkVpDu4Mhd8KAcE/vORM5SV3Ekam89vPXfeFfZzBA+O3
 6yhlVaZGGrEE/GTTZhFeGd6bNqdKhMmWZ8EcfA1iwhaLyFxDb8kZEJAIpSB9gMRrkKH8
 +1tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJOYTR1WI2G6Daw7IClfsGz2fO6pTmzhcKmzMdHAdnK+j7caf5ofR5NlkQISjFqifjHyYOSN945Do=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyVrsHAQuURLB9Z0H5Lken+xAWgSA/c9Mj02U9G02mMcYo5Yo2
 2gg1muQAw09kE+nOlmSJXIHQucXOJxV3umsIaSxoAfbGIAcaGIeXKbI=
X-Gm-Gg: AfdE7cmm4TYEGJITxDNJbZLsZPu2wOB8OXSRKaQD7Bii2DRZ6bGmkx1eTkp1Nd/mz25
 ghDwEDC+oaz7DpurVF5Fmmsbw7Eyh+vGnoETAlelwagXabcmmhCYWw8gB1pNWh5EGgBbcZDTsp8
 YLWBj0VhnmDJ9GADQAlTxaZoTa19L97A7V2ByStd9QJWDwp6Cqs96bRIU0v6lbIPvGfNsfUG1ua
 eCtJANCexBRMUqU+Kmvsdw74+KEB/Za84y2UaxHAdYI6SQAtZ+UGGDkrNRtgJgrswXaxugsQyxt
 JLl6CiT/WdXiHAwY1zpSl0gtCyKUDcCGM20vkh2secFEmDqNH/uozzs71BEKoWpCZmBeCWGU90B
 CH9HerKntEdenmxlm4rae4e778UVWUudVy2SPOH7+SIztkaU2j3QJcNURuhh8YxEpeZSz1qBgpw
 cHqOSkFEVg022QPvA=
X-Received: by 2002:a5d:64e3:0:b0:477:f5c:9bf2 with SMTP id
 ffacd0b85a97d-47aace8e983mr9385528f8f.51.1783278863594; 
 Sun, 05 Jul 2026 12:14:23 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:23 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:39 +0200
Subject: [PATCH RFC 05/13] firmware: qcom: scm: Configure LPAC aperture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-5-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=3104;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=xCTorTjZtBUEYbL6NZx5Fd5BNvNcYE4Jm0bT2+wByeQ=;
 b=JM9qT2757B3skDadThg2OlzWiKU5aLJo5x9qIqus/1JlX88Naikriu2+e98AC1wkrlG4Kxof/
 4ILHHS1V0i/AYzsBbF8lb5SHonjTx3ikmirYkFyCsdZyXrX0gQUGfCW
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

In order to be able to update the SMMU registers from CP for page table
updates we need to configure the LPAC aperture to include the context
bank that will be associated with SID 1.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/firmware/qcom/qcom_scm.c        | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  3 +++
 include/linux/firmware/qcom/qcom_scm.h  |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 9b06a69d3a6d..92093399f20d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1204,6 +1204,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg);
 
 #define QCOM_SCM_CP_APERTURE_CONTEXT_MASK	GENMASK(7, 0)
+#define QCOM_SCM_LPAC_APERTURE_CONTEXT_MASK	GENMASK(7, 1)
 
 bool qcom_scm_set_gpu_smmu_aperture_is_available(void)
 {
@@ -1229,6 +1230,23 @@ int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_aperture);
 
+int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank)
+{
+	struct qcom_scm_desc desc = {
+		.svc = QCOM_SCM_SVC_MP,
+		.cmd = QCOM_SCM_MP_CP_SMMU_APERTURE_ID,
+		.arginfo = QCOM_SCM_ARGS(4),
+		.args[0] = 0xffff0000 | (1 << 8 | context_bank),
+		.args[1] = 0xffffffff,
+		.args[2] = 0xffffffff,
+		.args[3] = 0xffffffff,
+		.owner = ARM_SMCCC_OWNER_SIP
+	};
+
+	return qcom_scm_call(__scm->dev, &desc, NULL);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_set_gpu_smmu_lpac_aperture);
+
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
 {
 	struct qcom_scm_desc desc = {
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 71ce4cbbf27a..be374cf209f4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -668,6 +668,9 @@ int adreno_hw_init(struct msm_gpu *gpu)
 		ret = qcom_scm_set_gpu_smmu_aperture(0);
 		if (ret)
 			DRM_DEV_ERROR(gpu->dev->dev, "unable to set SMMU aperture: %d\n", ret);
+		ret = qcom_scm_set_gpu_smmu_lpac_aperture(1);
+		if (ret)
+			DRM_DEV_ERROR(gpu->dev->dev, "unable to set lpac SMMU aperture: %d\n", ret);
 	}
 
 	for (int i = 0; i < gpu->nr_rings; i++) {
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 5747bd191bf1..70fb93e303e2 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -100,6 +100,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 bool qcom_scm_restore_sec_cfg_available(void);
 int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 int qcom_scm_set_gpu_smmu_aperture(unsigned int context_bank);
+int qcom_scm_set_gpu_smmu_lpac_aperture(unsigned int context_bank);
 bool qcom_scm_set_gpu_smmu_aperture_is_available(void);
 int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);

-- 
2.54.0

