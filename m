Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB74C98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 18:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28EC410F703;
	Thu, 24 Sep 2026 18:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Udyzymsm";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9594410F6FF
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 18:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790273448; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=McnGQpY+6XYneNEGQL29hTgeIITEtTVzgLlyIMu7vLhVJ+h+RBUntQ0cjS3PJycxVan1vL9AkeBe8J+p46bJgg2MF0hFNEIV8SADK/NZj5ZuL35EMupnXjtjxKNX5/8j6hfaOganxueiDExzVXMWX9IeOZYOdU4OnD7LLj/Te4Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790273448;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Z6RRS3cshQwsXc3rA/U7BvQ2XdAR4lAqGHrehoKydrQ=; 
 b=Bg4ZWdfE7f9s7MtFh8xrCxvXoy/xKyvgWXnw8E10XMqxMtlicvaUVx4IYKxdxa9/v2TrVtR4kk2ZCF8pM0bMInv9nVig82KFxNhS3f1Jx5u4KKJ/XV+FOUtiPKBhHXj5ERA8Jk5VUrYXmZGO1SEL2f6Mlp+HCs/gujncEMBLTLg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790273448; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Z6RRS3cshQwsXc3rA/U7BvQ2XdAR4lAqGHrehoKydrQ=;
 b=Udyzymsm4E2hQ1fHrRdvhdsOX7PMjPZynSGWZfWrvmh6eSaE6aIYYu4frt19CvxA
 rq4SHixRz4afnubhhGD0KDcn79bEmc5jjI+sQo7v6/hpRvecMVxCx30T1wFETgcaEs6
 axkEd0lj+yrIQmYXTWpdZOA0QWpLkPusYl4uYjWg=
Received: by smtp.zohomail.com with SMTPS id 1790273446941450.9724938594469;
 Thu, 24 Sep 2026 11:10:46 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 24 Sep 2026 19:09:29 +0100
Subject: [PATCH v10 12/15] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260924-claude-fixes-v10-12-755929b3cc19@collabora.com>
References: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
In-Reply-To: <20260924-claude-fixes-v10-0-755929b3cc19@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1716;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=t0pKAbH0SA2araO3s4z8ycC80JiA92CZd/FQ3/v+S5g=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtWdZjvyW3F2YcXi7lUVv8ElgN/A3cYLT55Izq
 DNlDkFvimiJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarVnWQAKCRAOJn5M7lND
 PQSKC/94MNfPevFpReWzuA27iTpvNNV67rCqn+2eSW2KOorPejYEo89L7+ho7jDvZs7iaIqkLfz
 qcadu7tRYDRVLtWu4n4Vd0VG2B7hjprS8y9Y0J4wLZS9VXXU5EkmDcAFAqqlsTvk8z2RPpokH04
 ny1YPnH4rX8MAS66EDELGt1yDVAw5Kje9QcPlSvjhGo/RYwA+SvYte/SVnCIGk2gKl1MIz46TZH
 +Ntb6wC8NpkAP4lyusyNXaws07MxnpIyfdYxLoru0YUWhbOtCppN4CUdqs4hKZL1HB911rXXG1w
 QWEWin7eVcuER8iGoyfK+iZ18KKm352C/V8pQQP4K7DeJCjdZtb7974nhWKI1XGVJb4bY1E1Tw+
 tl9VIMJC6RbldE0nQ5Vc/YWHlFv0pXx8XeAhlOZKgh4GMkVrGbnB3CKzPYARhhuZobWjmNLNLHm
 vAh+cPk0ERQm3n7PrYiJGpZg7HcJdQGUnyZsiya8mDAL0Le3sCsdiHexmDRGc/+OpgGAg=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

The GPU cache flush/invalidate operation is unnecessary. First off, the
GPU doesn't read off the perfcnt sample buffer, only writes into it, so
an invalidate doesn't make a difference. Then flushing GPU caches after
each sample has been written is enough for the CPU to see updated values.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index f71534e741b6..ffc77121070e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -124,21 +124,10 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
 
 	/*
-	 * Invalidate the cache and clear the counters to start from a fresh
-	 * state.
+	 * Clear the counters to start from a fresh state.
 	 */
-	reinit_completion(&pfdev->perfcnt->dump_comp);
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
-	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		goto err_vunmap;
-	}
 
 	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
 	if (ret < 0)

-- 
2.55.0

