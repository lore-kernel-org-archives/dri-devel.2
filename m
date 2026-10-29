Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146960A5BD7
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5mACiAU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A95411230E;
	Thu, 29 Oct 2026 13:53:19 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B3810E7FE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:03 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so17746385e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281982; x=1793886782; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rr4i7xRJAxgPG+93hBg/VQGAgwo9yxXU9tfEwt3+0E8=;
 b=s5mACiAUCbbSmS682WRAwQkQdawAqMEUgvMl2ap5c9qzk4UH9awbwsHptyMi2N51BV
 6Q+M2/2fcNZq5qM1J0Tg/H3JGtTTzZwnTT88I9p8yOWAcJCZ8H24J11OJQr8fIBekCv6
 KAc9NX0tAqbdpEgTKUGgiql9WBWN/zilVovhd487oYJhOBzuYo0ICDq3WyxInUUzCuCC
 HGGLwJRSp2scgjH4+o+J+BLI5eKKMciEKN4ERaio0lvKncVnuIhehxHmPp6IT2P9ZoYJ
 Gszfl5bsg7yAizMeZIcXBWJcmt0yWDIy+OIGmlb46vBqwwTEfzaRLZ7z6QZMhm1Qi9lB
 jdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281982; x=1793886782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rr4i7xRJAxgPG+93hBg/VQGAgwo9yxXU9tfEwt3+0E8=;
 b=qH0D8qyoHLL9BcZ1ygEXFTiJSyR7zeTyZNrM79kzVXTPu8XSU7Vzg2gV0K7QlkVWDG
 X8DurZnMNyZJv/IZOzHCEp8QcKzlz5ZuKqI01A6Br4O9coodQHF8GfIF3yBRKPdHtb/X
 5KGs26Lhj3sLsR1bz8gYB8StpkvRbLd3zqgp/plec0MnEdslIuLVgzo5kuE0PVoBfsF3
 FBx6Pd1kKwcL8jOF/8gtepuOPakLiT12pJqpz3rGx2uynZq/Vqz/N7jxSAyl4pAsKuyV
 kcSA6VIKW27sx5CQqe27UAzmO76LUtLucCj7dYZl2Eh5ECMDll/xi8hfgVfJkBfHcoHr
 yh1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/u68cUdWYRCotSlBVpymiUkAPeewkqzIOI6JDuNE0kS4a+zXKE1LZ6UActhpIiL7Y0d6/qsi+zQU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ8SBB4czC0DFMIaSbPhpP/09Ry75uLhPer1SKAVHEzliv++A6r
 7pZTZDkccHoZr2jV2sLGCayWvHCFw64DJ4a9CDx/j8qOaIeLBfXizY4=
X-Gm-Gg: AYBFou3tO2mkyTUsq33tMUqgkRVx1EgbF1/tTdLry8/yPPo5fhQRJ7RQfZJocT6MTcs
 92oe8Uc7peiTlIkWQ4XZ+fjTQce26BWZyx3hUDXuhGCwYs5yh/0zb32u0lBnkuZdDg+6V2OTIHY
 tVmLkGbVoRttuURoWSmWkbm+6E3o2U8ktSCb7tVFOLBHlyO0u2GQZkarOK2xFCcCOBSwDhURcLU
 WWqWzGV9DHZ5Dh9sU609w2VnbS3fY7Pk/aM6NRHnFLTTA6kxcYTbVgk62pHEoZ9IT8L+j6oZFOV
 pTUgrQQ2kZ0u/uRmam9lZEC8S913wyRdL91yS2BgRnUhxGm6X1x0JDHOEWYiH2R5VwDVYPHF72j
 v+SEVZK9Vsr4EdpLbThOo8l8Ex7QFivszH5roTJ+ewPUmQGBa+5kEXsQIXC98v9J4e0ov/uoLqu
 NOjeyp9dUgbc4D2XcK/cxOvsV3A6IGGUlvVy7YeKCc5yQ014cMMEdb9wpCmw9Etzr75lWVrzNHv
 h34Z/CJ2q4WbS7IAEWDJeRwwAIUdF2z6qmw5pmpHMg51Lt2KeEyKkmN//Za3gNrY9A0cqPMKXxQ
 4uvUHMpzfmLx+eL7Hvsb1FVSeEbRF1czJzPyJqOJNTPMLw==
X-Received: by 2002:a05:600d:8496:20b0:4a1:992f:d0e7 with SMTP id
 5b1f17b1804b1-4a96677324cmr86595655e9.16.1793281981611; 
 Thu, 29 Oct 2026 06:53:01 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:01 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:38 +0100
Subject: [PATCH RFC v2 01/14] iommu: arm-smmu-qcom: Configure lpac device
 with split address space
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-1-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2309;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=NJ73RVOWEiPlPH9Z7PnLGwHMRejJoPZBM69o25lxk5E=;
 b=gj8sBR9N8QG04JyrcmUt5R2oXuziVAr6kQLdSMm6i0TlFKl87Gop8V8EHKny6NTxmbotiGmJc
 fs65LYDtGd6Dd5piBIpN6ZzqbLECs9zGbUWlcBT96BceUkWcOkEDLhv
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We want the context bank used by LPAC (Low Priority Async Compute) to
use split address space just like GFX in order to be able to handle
userspace submissions with per context page tables.

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
2.56.0

