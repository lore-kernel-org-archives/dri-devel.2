Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A72BC44501
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E4210E225;
	Sun,  5 Jul 2026 19:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4CTZTS7";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2B810E225
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:29 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so422144f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278867; x=1783883667; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FOJQZsuitJv3y9s8sz3fzgy77bgdsy3S43prspkqpPY=;
 b=B4CTZTS74x8f4NZfk2pXREwCZQMV9oz2JBht2K5/qllqZHCUwogKhEFyiV2SuA3MQn
 t8VLDYEKPxFbzrBgORE2Ad1Ax5oO8/6o7dptHdud/vegFTyoaRX27xJ5Srm9lKFNX4I5
 gSwAYMS8E9gfIWj+FQJEQGIJns2OQYSvqXDNMUS4+0aZlbc6ORwy/9MGku9R0dEtBY1U
 0Bua6m8p+gGOzpbpIPs0w0R1H+eGh2aLFCehCQ94brTgkLBWgILSPgyxOSJVqkeBbg76
 9u1VYCnPwQK3ypdS8gzDyNqC3YgmQJpM+EZ8IoNRbUTfZ6HIxftDnfEs6TONBY560HJb
 9N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278867; x=1783883667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FOJQZsuitJv3y9s8sz3fzgy77bgdsy3S43prspkqpPY=;
 b=h7xxLPmjaCTbEXU/PfFKDnzNF+0O/kAN8C/AxTUuDtC7w0km/0YjEjDui3AmNe0jt+
 y0z2BqhU4XJVAOdD74oo/EcaCCzQjzW3dIZF9MpMGkUGRBeEUoV6S24blMzxxVfqg4Ik
 nqeUrktFbpoBde1pflxNJE43SzgSLXHeRz4d0jVmVAweamXfRemyUIGBxFnvtDttV/NR
 nP64nsHEze7SF1iy6v5YVhp29gDblLeyNBpn3seZMRpnZshmmwYqZmYP4NobYtLeUR3f
 2+ApQgjwHF1JN1uM2rAbeGyTU92rjjTPISoY/ghsurBAbD7Msc8NxSQXzs17vVPs9MmL
 7YUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTh3PnKUHqL6V77mrDWQbL3Ao+P/Lauhf1isK2aOvm4JK5sSccPq97hzzln2mx76Tw8EHK9lJXf70=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoMqJz1stcCe7BvmlPzylZpiLxy8ndHbDSdJGh+dny+bsL2c7y
 au2MfBEsbqlSQokiAnvPld5R8pU/Tfy3AI7uWpxcXHNPvlUHgOqM6hU=
X-Gm-Gg: AfdE7cks4jNhOdPHtF54myKYpO+LNlTucu1L+h1P0507/eRp7T4r7sTr3wnSG6lgcYW
 r0CM8MNh4ro5YiRe6b0tXVxJVLpr7VIZlRHFe/hoVk43LRwHJ7TCx6clRMBSmIkiSd6E2EmK4hY
 x6jiRiTsc40v0+cisLNcjD3CV4/rYJ0hEl8FLs3Cp7ThEidAvB7D4avJqLMRbxn9S1D5Ox7Bb7H
 ah6/FadHw77Db0GbSm2/0WpYwZMg58kKQl3XLNfffqvxOSW5U5tMx8ZaiVi0X/qT6T3PRLI1Iku
 OoBwWVsOYI95FKeN/Z83I3laWtzhiTO+4vV8CgQFWl4KTmjF+ksx01vIQ6foavNVEg+hL0VzV+5
 BvhUkZurvqP2kVHcdlgtd6sb2Z9cxu/emRa+7k1eHUMsmD1Yg3l4zIGHXEZdunA73OCMafacEu5
 wGYpDzkLGWQQyBaeItjL7ud4iaHfcBpQ==
X-Received: by 2002:a05:6000:2689:b0:477:6874:542c with SMTP id
 ffacd0b85a97d-47aab487abdmr8336510f8f.22.1783278867370; 
 Sun, 05 Jul 2026 12:14:27 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:27 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:41 +0200
Subject: [PATCH RFC 07/13] iommu: arm-smmu-qcom: Fixed mapping between sid
 and cb for gpu and lpac
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-7-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1792;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=CTSVd/0edKxTFOAN7N2IneJxadcZY86l85ROlQLsf6k=;
 b=N1CzOkGooWs0D7hEFfO64qs+XczQExJuyhhzPJnlf0WwJlRgmpU6QS/Q3PibSJHKmN1K6WJPv
 WALfNWTwDnSBfYHo0sDNPhrc2jlfRyjKisM+ctCA7C/dwWocYLjvP6b
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

We want to map context bank 0 to SID 0 and context bank 1 to SID 1 as it
makes it simpler to deal with.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index ae6152bddf8f..e605a535f328 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -225,6 +225,25 @@ static void qcom_adreno_smmu_set_prr_addr(const void *cookie, phys_addr_t page_a
 #define QCOM_ADRENO_SMMU_GPU_SID 0
 #define QCOM_ADRENO_SMMU_LPAC_SID 1
 
+static bool qcom_adreno_smmu_is_lpac_device(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	int i;
+
+	/*
+	 * The GPU will always use SID 0 so that is a handy way to uniquely
+	 * identify it and configure it for per-instance pagetables
+	 */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
+
+		if (sid == QCOM_ADRENO_SMMU_LPAC_SID)
+			return true;
+	}
+
+	return false;
+}
+
 static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
@@ -312,13 +331,12 @@ static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_doma
 	 * switch pagetables
 	 */
 	if (qcom_adreno_smmu_is_gpu_device(dev)) {
-		start = 0;
-		count = 2;
+		start = !!qcom_adreno_smmu_is_lpac_device(dev);
+		count = start + 1;
 	} else {
 		start = 2;
 		count = smmu->num_context_banks;
 	}
-
 	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);
 }
 

-- 
2.54.0

