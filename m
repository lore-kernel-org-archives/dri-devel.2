Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB02C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 18:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A282710FC16;
	Fri, 25 Sep 2026 18:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="jGVlsM9F";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1037A10FC13
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 18:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790362002; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QRRZ845cVExKAOfca4ssSzQfLJKQdrmQSJe/9tUVRRe/2XtDUyE59OC8VpI5+ExXp8meNH34mIeHfCQ36hDtYz20IU18VR1MR9wY1AbOAD1ArzQwwvdh7GHEEaKn2deozdeyVlcJa757+dkoSs/lnUqote2hmoJP38T5IFPMexg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790362002;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Z6RRS3cshQwsXc3rA/U7BvQ2XdAR4lAqGHrehoKydrQ=; 
 b=lu40QZ6XV4uGV+LtIdlAsEibPACE+IW/8npWp0iOSTzg+5R14NKrje5mpoqYC4edxEE9gQhSKooJ8LPeb9JxH3S6bNJJ9V08nyj+vWmrCSOca2AQcYggPL3B9+gfkOuKg5dJUxhCawmQUpc/g5nKkcHjuTFacig9ARgtFKPjAng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790362002; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Z6RRS3cshQwsXc3rA/U7BvQ2XdAR4lAqGHrehoKydrQ=;
 b=jGVlsM9F+d/phPRkHKVM27PRrck8G7Iuzup1rH0twmk9K0YQn51qSmBBbjt57xxL
 3dD8bBh1MqtOFYJmuTt2rfrJH/I79QAVYSeyumkjYlv6HJwcpUoz/ekC+J7wG45EW78
 7NjRpiGS9F17x+RQddj/M0y0dtaBDZgJSWYWqvCg=
Received: by smtp.zohomail.com with SMTPS id 1790361999845716.5502045892146;
 Fri, 25 Sep 2026 11:46:39 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 25 Sep 2026 19:45:33 +0100
Subject: [PATCH v11 12/15] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260925-claude-fixes-v11-12-0dbf5a58e7ce@collabora.com>
References: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
In-Reply-To: <20260925-claude-fixes-v11-0-0dbf5a58e7ce@collabora.com>
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
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqtsFEnU8MaIxk/nlskpgiIVTgRr6KGp7uVdqN+
 hKKvUqrpp+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCarbBRAAKCRAOJn5M7lND
 Pd/ZDACDnWBy7gzQaFzmuxeIdYtp9mp1IgBSp/aUAzfyfT4q60T86kk/1Xdvt3sjAXnPtkp5aSi
 ctOUh7PcroYEo+VlqYRHDbEdZHA+Ew/NZ/aTL/WGBnjcoClflyfNI8dAJBxI0woFI1s3qzJQpk/
 mpefDR7/V+ZjmLoEKSRrFilaBQMM1zqgSFfP2onrdAMQGqeBSKgQN/sHb/w/Qv5aqkvOwOXoxTb
 kUVDFwmGyPtSCModcn4Cgzf/djzAkV3aDRLjkO7wwFUOXbiWIu7q4DB3mrH7hFyIE0ZxWQRv5QF
 VktaSr9oJHHOJ/rI5/htgF/BmQxBDI8i8QtDpzLy5YRv8MUNzA/YzqgXuvbfEoRo5SWRKy7g6QT
 9J39a6ODxN3g6FzJ4njRsqcRnvfwZ7fu+l9pEGaI1FRsLQ9EDAeWUssQ8K4XEXNVbEVLqwPgcol
 U5rqHU+CcmNkdWSxKu5XeWLjYRvq+kF9G1DJHvfyC9fPdLC9X1yBD5A62v8wbyb652rsE=
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

