Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEE0CD6E5D
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB1F4112B80;
	Sun, 31 May 2026 13:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ehN3uCiq";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33CF10E5B7
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780220518; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=RpB/ofZVI8aYfi4QDy17DKJQX9fsUwx+3+WYjwsW/4E=;
 b=ehN3uCiqcOSuYTZ3TQ5JzW9JW+U0ESQmX6PLzrlj9E960HIWD5Mp4pkJ5pXBozVaBhmF/imjGr+4G2ZiHaDKnd3+Hk0t62ZhJKCpTn/wRyIc2c0WlUDdBpgVjnNj7YuTbt5tvZ/xEp7hGP6/NAnSZeHnPFNeoK+i8Ml3ZS+F+F8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=guanghuifeng@linux.alibaba.com; NM=1; PH=DS; RN=27; SR=0;
 TI=SMTPD_---0X3tRVr2_1780220214; 
Received: from
 VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com
 fp:SMTPD_---0X3tRVr2_1780220214 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 31 May 2026 17:36:54 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@shazbot.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, jgg@ziepe.ca, kevin.tian@intel.com,
 baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
 dwmw2@infradead.org
Cc: xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com,
 shiyu.zsq@linux.alibaba.com, wei.guo.simon@linux.alibaba.com
Subject: [PATCH 8/9] drm/gpu, iommu/io-pgtable: switch to iova_to_phys_length
Date: Sun, 31 May 2026 17:36:36 +0800
Message-ID: <20260531093637.3893199-9-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:32 +0000
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

Migrate remaining callers of io_pgtable_ops.iova_to_phys:
- panthor_mmu: use ops->iova_to_phys_length(ops, iova, NULL)
- panfrost_mmu: same
- io-pgtable selftests: use iova_to_phys_length with NULL

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c  |  2 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  2 +-
 drivers/iommu/io-pgtable-arm-selftests.c | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..b7c420eb76ec 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -514,7 +514,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
 
 		if (bo->is_heap)
 			pgcount = 1;
-		if (!bo->is_heap || ops->iova_to_phys(ops, iova)) {
+		if (!bo->is_heap || ops->iova_to_phys_length(ops, iova, NULL)) {
 			unmapped_page = ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
 			WARN_ON(unmapped_page != pgsize * pgcount);
 		}
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 75d98dad7b1d..05bc7ec95931 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -903,7 +903,7 @@ static void panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 			 * are out-of-sync. This is not supposed to happen, hence the
 			 * above WARN_ON().
 			 */
-			while (!ops->iova_to_phys(ops, iova + unmapped_sz) &&
+			while (!ops->iova_to_phys_length(ops, iova + unmapped_sz, NULL) &&
 			       unmapped_sz < pgsize * pgcount)
 				unmapped_sz += SZ_4K;
 
diff --git a/drivers/iommu/io-pgtable-arm-selftests.c b/drivers/iommu/io-pgtable-arm-selftests.c
index 334e70350924..d1d0529f711d 100644
--- a/drivers/iommu/io-pgtable-arm-selftests.c
+++ b/drivers/iommu/io-pgtable-arm-selftests.c
@@ -72,13 +72,13 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 		 * Initial sanity checks.
 		 * Empty page tables shouldn't provide any translations.
 		 */
-		if (ops->iova_to_phys(ops, 42))
+		if (ops->iova_to_phys_length(ops, 42, NULL))
 			return __FAIL(test, i);
 
-		if (ops->iova_to_phys(ops, SZ_1G + 42))
+		if (ops->iova_to_phys_length(ops, SZ_1G + 42, NULL))
 			return __FAIL(test, i);
 
-		if (ops->iova_to_phys(ops, SZ_2G + 42))
+		if (ops->iova_to_phys_length(ops, SZ_2G + 42, NULL))
 			return __FAIL(test, i);
 
 		/*
@@ -100,7 +100,7 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 					    GFP_KERNEL, &mapped))
 				return __FAIL(test, i);
 
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL) != (iova + 42))
 				return __FAIL(test, i);
 
 			iova += SZ_1G;
@@ -114,7 +114,7 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 			if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
 				return __FAIL(test, i);
 
-			if (ops->iova_to_phys(ops, iova + 42))
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL))
 				return __FAIL(test, i);
 
 			/* Remap full block */
@@ -122,7 +122,7 @@ static int arm_lpae_run_tests(struct kunit *test, struct io_pgtable_cfg *cfg)
 					   IOMMU_WRITE, GFP_KERNEL, &mapped))
 				return __FAIL(test, i);
 
-			if (ops->iova_to_phys(ops, iova + 42) != (iova + 42))
+			if (ops->iova_to_phys_length(ops, iova + 42, NULL) != (iova + 42))
 				return __FAIL(test, i);
 
 			iova += SZ_1G;
-- 
2.43.7

