Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65C60A2614
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mONMGTwp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F1DF10E824;
	Thu, 29 Oct 2026 13:53:13 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7773410E824
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:05 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1164391f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281984; x=1793886784; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V9LeGqPkcZkvMAaOCWRDZnBz0+KZqqx0idX6u318GH8=;
 b=mONMGTwplANvqqifWghswJidXrXh48l9iI/6vvlshJx58kygHE781hYGLeq7zxduJk
 MGcsnMMz/iB1LtROqCn1hpPRY/bj+CyObqI5LJEyNXcZNqbODqv+qZQybMqgu/00I4pA
 5HmrHcUa6XhiY5Hyc8Qf+zH4aROlDBD2itvQCbaM69UHvTUB/56gWczi6Lq+iFOAGhzi
 p2yWNT/KXa5tnZtK8u4tuBcu8mOkBk7ipaRw/ECqwJdjBHi9SA+7eMNH/4VoCZsLpNR7
 WQ4dwkXZ5xSYJ98GN7kax64t0gFcrzAr1LOY1cjX1YuT3rmyUTIsaLuO6Xp6/rIW3VwM
 W0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281984; x=1793886784;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V9LeGqPkcZkvMAaOCWRDZnBz0+KZqqx0idX6u318GH8=;
 b=a9aAo41KCtdel6pUID2tBsD7kBEOta/tO/pX5yq1Vjoi31HQvBApESKA9QxY924Lje
 7iew2II+lRHqigg4xE0qfj6lHUA4PojBTralXEX/GN7HO5s2OV5IQFKnMdy5ZCL0YZ/b
 97gF9b70XEMi267L3YtbxbooMh7YdQNDLy+su/AXBJ6+SAhBMERfpPfepHwCgaGMaY7B
 mRZoiR5PwbwtZ2zwT/qDjMBAlziv8a7l4R3C/EwxQZZtE/wdKDaqQi148OGsBvhGKOIP
 VcKKIviV5V8KdbWR7jeNSvN0R5cyILHNlJT2jtEffgrtsxTP5neGnQ4pEZqR/mDT2Nsj
 6dbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGx6oEp+zzPFGWJbZBe0LLWcwQ+dQdL17ISqui+sRTPA/Gk401EhBG2eicdUhBoB7TtZ9+GYdAam8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYINRLHJ1bnw00Soqe0PgN5vfQr0qEWontikKKffKgdmK6Yd+5Ib
 Ry/ti1aKUvdnBcAHY3sSzumQlmd8K8L3bwUPDmrtDYkSsol2loOBMto=
X-Gm-Gg: AYBFou0hGSkhHw+ug3S04odx/ruvgOin16TwtpJthJC5tnsl5td8GEn+tif/G+1nevP
 SzkGuPphYGKOtlAbhl5sKF2zh3XM50uSpTMNq7DYpGs0hZSB5Y/ZQK75K8sE9jeq5Y+0hKdBcoU
 nY/nQgJGcVLGTDAQhmVmvMi+wQAQrbRlaRY/dKhrZ2ML6Fwh3a1XFzZuqN+tyg8efMgEX5fu1Tv
 pCCxNA59HSfTVf6g9pGdhVq5TeGaNO7KTNcmNgfK5m76tRb/pjIlC3Q2TxLBau12DYoTs7TPGdP
 5Y53aFpc8hp6jzACury6+dFrbABVAiFZ7sFmX3ize4wD73q+MLfY+ZGPaL6fOkkmbhtaa7l9qfu
 ETBt8QjNtTS2+yl5Mi2BemLPZlNRdTa95jtLbdoqglQNpsOKFWYf69MGNqCKHkSqrG07CW+E8Ev
 Cudd55icqnjD9bKMzpp92r2wyfWH/0S+CBsYkVowsLECGM2hPV+24d01t+42DlG1beMW9ulU05m
 naik5wr0rK5n3DTU3tj2w1WI6mDmgN2celHEFTDvjwNVz+kW590Xm4gwZKe2Z4Fv/6wBurpunfl
 OENuJWI7w2niIAvJIl7/fV3QBYvjFFAalacalkrpOIR29g==
X-Received: by 2002:a5d:5e8d:0:b0:48e:5ea7:b1b9 with SMTP id
 ffacd0b85a97d-48e5ea7b1camr12043233f8f.31.1793281983455; 
 Thu, 29 Oct 2026 06:53:03 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:03 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:39 +0100
Subject: [PATCH RFC v2 02/14] drm/msm: add support for lpac_domain in msm_mmu
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-2-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=15243;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=4jK+Yh74C6Kj+QYcgrcNq6xZY62RwgtQGRq7cSzR4eg=;
 b=rzDf6ctrxuLiYdo057e4nMKMqLWWUiyergAPmnnK+y0jGzW7fCLdOm1GOBX7W+iOQfS9N+7EU
 Z+neenOkVUYC7mvyJQPzgeYXrUinUYenUE/a/cHS7MypUUweyz0/1yE
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LPAC (Low Priority Async Compute) needs to use a separate context bank
in order to be able to update the page table independetly.

Add an iommu_domain for LPAC and keep it in sync with the main domain.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |   2 +-
 drivers/gpu/drm/msm/msm_gpu.h           |   1 +
 drivers/gpu/drm/msm/msm_iommu.c         | 170 ++++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_mmu.h           |   7 +-
 5 files changed, 160 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2e5d7b53a0c3..a91d9b03ca88 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1569,7 +1569,7 @@ static int a6xx_gmu_memory_probe(struct drm_device *drm, struct a6xx_gmu *gmu)
 {
 	struct msm_mmu *mmu;
 
-	mmu = msm_iommu_new(gmu->dev, 0);
+	mmu = msm_iommu_new(gmu->dev, NULL, 0);
 	if (IS_ERR(mmu))
 		return PTR_ERR(mmu);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index c62c45bb0ddb..f3fc7032fadc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -201,7 +201,7 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	struct drm_gpuvm *vm;
 	u64 start, size;
 
-	mmu = msm_iommu_gpu_new(&pdev->dev, gpu, quirks);
+	mmu = msm_iommu_gpu_new(&pdev->dev, NULL, gpu, quirks);
 	if (IS_ERR(mmu))
 		return ERR_CAST(mmu);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 6c83b8cbbb90..e2291dfe3ca8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -175,6 +175,7 @@ struct msm_gpu {
 	const struct msm_gpu_funcs *funcs;
 
 	struct adreno_smmu_priv adreno_smmu;
+	struct adreno_smmu_priv lpac_adreno_smmu;
 
 	struct msm_ringbuffer *rb[MSM_GPU_MAX_RINGS];
 	int nr_rings;
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 058c71c82cf5..0e770ec91a83 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -13,7 +13,7 @@
 
 struct msm_iommu {
 	struct msm_mmu base;
-	struct iommu_domain *domain;
+	struct iommu_domain *domain, *lpac_domain;
 
 	struct mutex init_lock;  /* protects pagetables counter and prr_page */
 	int pagetables;
@@ -127,6 +127,8 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 	}
 
 	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
+	if (to_msm_iommu(pagetable->parent)->lpac_domain)
+		iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->lpac_domain);
 
 	return ret;
 }
@@ -224,6 +226,10 @@ static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
 	struct msm_iommu *iommu = to_msm_iommu(pagetable->parent);
 	struct adreno_smmu_priv *adreno_smmu =
 		dev_get_drvdata(pagetable->parent->dev);
+	struct adreno_smmu_priv *lpac_adreno_smmu = NULL;
+
+	if (pagetable->parent->lpac_dev)
+		lpac_adreno_smmu = dev_get_drvdata(pagetable->parent->lpac_dev);
 
 	/*
 	 * If this is the last attached pagetable for the parent,
@@ -232,9 +238,13 @@ static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
 	mutex_lock(&iommu->init_lock);
 	if (--iommu->pagetables == 0) {
 		adreno_smmu->set_ttbr0_cfg(adreno_smmu->cookie, NULL);
+		if (lpac_adreno_smmu)
+			lpac_adreno_smmu->set_ttbr0_cfg(lpac_adreno_smmu->cookie, NULL);
 
 		if (adreno_smmu->set_prr_bit) {
 			adreno_smmu->set_prr_bit(adreno_smmu->cookie, false);
+			if (lpac_adreno_smmu && lpac_adreno_smmu->set_prr_bit)
+				lpac_adreno_smmu->set_prr_bit(lpac_adreno_smmu->cookie, false);
 			__free_page(iommu->prr_page);
 			iommu->prr_page = NULL;
 		}
@@ -450,14 +460,22 @@ static void msm_iommu_tlb_flush_all(void *cookie)
 	struct msm_iommu_pagetable *pagetable = cookie;
 	struct adreno_smmu_priv *adreno_smmu;
 
-	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
-		return;
+	if (pm_runtime_get_if_in_use(pagetable->iommu_dev)) {
+		adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+
+		pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
+
+		pm_runtime_put_autosuspend(pagetable->iommu_dev);
+	}
 
-	adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+	if (pagetable->parent->lpac_dev &&
+	    pm_runtime_get_if_in_use(pagetable->parent->lpac_dev)) {
+		adreno_smmu = dev_get_drvdata(pagetable->parent->lpac_dev);
 
-	pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
+		pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
 
-	pm_runtime_put_autosuspend(pagetable->iommu_dev);
+		pm_runtime_put_autosuspend(pagetable->parent->lpac_dev);
+	}
 }
 
 static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
@@ -466,14 +484,23 @@ static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
 	struct msm_iommu_pagetable *pagetable = cookie;
 	struct adreno_smmu_priv *adreno_smmu;
 
-	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
-		return;
 
-	adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+	if (pm_runtime_get_if_in_use(pagetable->iommu_dev)) {
+		adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+
+		pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smmu->cookie);
 
-	pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smmu->cookie);
+		pm_runtime_put_autosuspend(pagetable->iommu_dev);
+	}
+
+	if (pagetable->parent->lpac_dev &&
+	    pm_runtime_get_if_in_use(pagetable->parent->lpac_dev)) {
+		adreno_smmu = dev_get_drvdata(pagetable->parent->lpac_dev);
 
-	pm_runtime_put_autosuspend(pagetable->iommu_dev);
+		pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smmu->cookie);
+
+		pm_runtime_put_autosuspend(pagetable->parent->lpac_dev);
+	}
 }
 
 static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
@@ -504,12 +531,16 @@ static size_t get_tblsz(const struct io_pgtable_cfg *cfg)
 struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent, bool kernel_managed)
 {
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(parent->dev);
+	struct adreno_smmu_priv *lpac_adreno_smmu = NULL;
 	struct msm_iommu *iommu = to_msm_iommu(parent);
 	struct msm_iommu_pagetable *pagetable;
 	const struct io_pgtable_cfg *ttbr1_cfg = NULL;
 	struct io_pgtable_cfg ttbr0_cfg;
 	int ret;
 
+	if (parent->lpac_dev)
+		lpac_adreno_smmu = dev_get_drvdata(parent->lpac_dev);
+
 	/* Get the pagetable configuration from the domain */
 	if (adreno_smmu->cookie)
 		ttbr1_cfg = adreno_smmu->get_ttbr1_cfg(adreno_smmu->cookie);
@@ -528,6 +559,8 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent, bool kernel_m
 	msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
 		MSM_MMU_IOMMU_PAGETABLE);
 
+	pagetable->parent = parent;
+
 	/* Clone the TTBR1 cfg as starting point for TTBR0 cfg: */
 	ttbr0_cfg = *ttbr1_cfg;
 
@@ -588,6 +621,17 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent, bool kernel_m
 			return ERR_PTR(ret);
 		}
 
+		if (lpac_adreno_smmu) {
+			ret = lpac_adreno_smmu->set_ttbr0_cfg(lpac_adreno_smmu->cookie, &ttbr0_cfg);
+			if (ret) {
+				iommu->pagetables--;
+				mutex_unlock(&iommu->init_lock);
+				free_io_pgtable_ops(pagetable->pgtbl_ops);
+				kfree(pagetable);
+				return ERR_PTR(ret);
+			}
+		}
+
 		BUG_ON(iommu->prr_page);
 		if (adreno_smmu->set_prr_bit) {
 			/*
@@ -606,11 +650,16 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent, bool kernel_m
 						  page_to_phys(iommu->prr_page));
 			adreno_smmu->set_prr_bit(adreno_smmu->cookie, true);
 		}
+
+		if (iommu->prr_page && lpac_adreno_smmu && lpac_adreno_smmu->set_prr_bit) {
+			lpac_adreno_smmu->set_prr_addr(lpac_adreno_smmu->cookie,
+						       page_to_phys(iommu->prr_page));
+			lpac_adreno_smmu->set_prr_bit(lpac_adreno_smmu->cookie, true);
+		}
 	}
 	mutex_unlock(&iommu->init_lock);
 
 	/* Needed later for TLB flush */
-	pagetable->parent = parent;
 	pagetable->tlb = ttbr1_cfg->tlb;
 	pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
 	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
@@ -646,6 +695,26 @@ static int msm_gpu_fault_handler(struct iommu_domain *domain, struct device *dev
 	return 0;
 }
 
+static int msm_lpac_fault_handler(struct iommu_domain *domain, struct device *dev,
+		unsigned long iova, int flags, void *arg)
+{
+	struct msm_iommu *iommu = arg;
+	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.lpac_dev);
+	struct adreno_smmu_fault_info info, *ptr = NULL;
+
+	if (adreno_smmu->get_fault_info) {
+		adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);
+		ptr = &info;
+	}
+
+	if (iommu->base.handler)
+		return iommu->base.handler(iommu->base.arg, iova, flags, ptr);
+
+	pr_warn_ratelimited("*** lpac fault: iova=%16lx, flags=%d\n", iova, flags);
+
+	return 0;
+}
+
 static int msm_disp_fault_handler(struct iommu_domain *domain, struct device *dev,
 				  unsigned long iova, int flags, void *arg)
 {
@@ -660,9 +729,16 @@ static int msm_disp_fault_handler(struct iommu_domain *domain, struct device *de
 static void msm_iommu_set_stall(struct msm_mmu *mmu, bool enable)
 {
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(mmu->dev);
+	struct adreno_smmu_priv *lpac_adreno_smmu = NULL;
+
+	if (mmu->lpac_dev)
+		lpac_adreno_smmu = dev_get_drvdata(mmu->lpac_dev);
 
 	if (adreno_smmu->set_stall)
 		adreno_smmu->set_stall(adreno_smmu->cookie, enable);
+
+	if (lpac_adreno_smmu && lpac_adreno_smmu->set_stall)
+		lpac_adreno_smmu->set_stall(lpac_adreno_smmu->cookie, enable);
 }
 
 static void msm_iommu_detach(struct msm_mmu *mmu)
@@ -670,6 +746,9 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 
 	iommu_detach_device(iommu->domain, mmu->dev);
+
+	if (iommu->lpac_domain)
+		iommu_detach_device(iommu->lpac_domain, mmu->lpac_dev);
 }
 
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
@@ -689,6 +768,15 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	if (ret < 0)
 		return ret;
 
+	if (ret != len)
+		return -EINVAL;
+
+	if (iommu->lpac_domain) {
+		ret = iommu_map_sgtable(iommu->lpac_domain, iova, sgt, prot);
+		if (ret < 0)
+			return ret;
+	}
+
 	return (ret == len) ? 0 : -EINVAL;
 }
 
@@ -701,6 +789,9 @@ static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
 
 	iommu_unmap(iommu->domain, iova, len);
 
+	if (iommu->lpac_domain)
+		iommu_unmap(iommu->lpac_domain, iova, len);
+
 	return 0;
 }
 
@@ -708,6 +799,8 @@ static void msm_iommu_destroy(struct msm_mmu *mmu)
 {
 	struct msm_iommu *iommu = to_msm_iommu(mmu);
 	iommu_domain_free(iommu->domain);
+	if (iommu->lpac_domain)
+		iommu_domain_free(iommu->lpac_domain);
 	kmem_cache_destroy(iommu->pt_cache);
 	kfree(iommu);
 }
@@ -720,9 +813,9 @@ static const struct msm_mmu_funcs funcs = {
 		.set_stall = msm_iommu_set_stall,
 };
 
-struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
+struct msm_mmu *msm_iommu_new(struct device *dev, struct device *lpac_dev, unsigned long quirks)
 {
-	struct iommu_domain *domain;
+	struct iommu_domain *domain, *lpac_domain = NULL;
 	struct msm_iommu *iommu;
 	int ret;
 
@@ -753,6 +846,39 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 		return ERR_PTR(ret);
 	}
 
+	if (lpac_dev) {
+		if (!device_iommu_mapped(lpac_dev)) {
+			iommu_detach_device(domain, dev);
+			iommu_domain_free(domain);
+			kfree(iommu);
+			return ERR_PTR(-ENODEV);
+		}
+
+		lpac_domain = iommu_paging_domain_alloc(lpac_dev);
+		if (IS_ERR(lpac_domain)) {
+			iommu_detach_device(domain, dev);
+			iommu_domain_free(domain);
+			kfree(iommu);
+			return ERR_CAST(lpac_domain);
+		}
+
+		iommu_set_pgtable_quirks(lpac_domain, quirks);
+
+		iommu->lpac_domain = lpac_domain;
+		iommu->base.lpac_dev = lpac_dev;
+	}
+
+	if (lpac_domain) {
+		ret = iommu_attach_device(lpac_domain, lpac_dev);
+		if (ret) {
+			iommu_detach_device(domain, dev);
+			iommu_domain_free(domain);
+			iommu_domain_free(lpac_domain);
+			kfree(iommu);
+			return ERR_PTR(ret);
+		}
+	}
+
 	return &iommu->base;
 }
 
@@ -761,7 +887,7 @@ struct msm_mmu *msm_iommu_disp_new(struct device *dev, unsigned long quirks)
 	struct msm_iommu *iommu;
 	struct msm_mmu *mmu;
 
-	mmu = msm_iommu_new(dev, quirks);
+	mmu = msm_iommu_new(dev, NULL, quirks);
 	if (IS_ERR(mmu))
 		return mmu;
 
@@ -771,13 +897,18 @@ struct msm_mmu *msm_iommu_disp_new(struct device *dev, unsigned long quirks)
 	return mmu;
 }
 
-struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsigned long quirks)
+struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct device *lpac_dev,
+				  struct msm_gpu *gpu, unsigned long quirks)
 {
 	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(dev);
+	struct adreno_smmu_priv *lpac_adreno_smmu = NULL;
 	struct msm_iommu *iommu;
 	struct msm_mmu *mmu;
 
-	mmu = msm_iommu_new(dev, quirks);
+	if (lpac_dev)
+		lpac_adreno_smmu = dev_get_drvdata(lpac_dev);
+
+	mmu = msm_iommu_new(dev, lpac_dev, quirks);
 	if (IS_ERR(mmu))
 		return mmu;
 
@@ -791,10 +922,15 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
 			kmem_cache_create("msm-mmu-pt", tblsz, tblsz, 0, NULL);
 	}
 	iommu_set_fault_handler(iommu->domain, msm_gpu_fault_handler, iommu);
+	if (iommu->lpac_domain)
+		iommu_set_fault_handler(iommu->lpac_domain, msm_lpac_fault_handler, iommu);
 
 	/* Enable stall on iommu fault: */
 	if (adreno_smmu->set_stall)
 		adreno_smmu->set_stall(adreno_smmu->cookie, true);
 
+	if (lpac_adreno_smmu && lpac_adreno_smmu->set_stall)
+		lpac_adreno_smmu->set_stall(lpac_adreno_smmu->cookie, true);
+
 	return mmu;
 }
diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
index 8915662fbd4d..1965b98d20db 100644
--- a/drivers/gpu/drm/msm/msm_mmu.h
+++ b/drivers/gpu/drm/msm/msm_mmu.h
@@ -52,7 +52,7 @@ struct msm_mmu_prealloc {
 
 struct msm_mmu {
 	const struct msm_mmu_funcs *funcs;
-	struct device *dev;
+	struct device *dev, *lpac_dev;
 	int (*handler)(void *arg, unsigned long iova, int flags, void *data);
 	void *arg;
 	enum msm_mmu_type type;
@@ -74,8 +74,9 @@ static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
 	mmu->type = type;
 }
 
-struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks);
-struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsigned long quirks);
+struct msm_mmu *msm_iommu_new(struct device *dev, struct device *lpac_dev, unsigned long quirks);
+struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct device *lpac_dev,
+				  struct msm_gpu *gpu, unsigned long quirks);
 struct msm_mmu *msm_iommu_disp_new(struct device *dev, unsigned long quirks);
 
 static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,

-- 
2.56.0

