Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE228CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 18:38:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1084D112977;
	Sat, 30 May 2026 18:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kn1a1W/n";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438F3112976
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hlI3+kkUXcm8644y79R2iZfBtnQSzX/EKAaqMiWVRpA=; b=kn1a1W/nutL1zB1PSbsgf7uwEz
 ERyIos/nzyhL3eW63En34eyFmWA8PMl6phx8dXf0qOzG/woIO7iiTXVwCbMWuz2ioNwA3cVTOhexK
 HGx/c+aACBFATrUUVHvRJA3UQnc8drnKXrdzD4Dk+KyFSM8hZLUKjfbsKQUVj7HtUXJtAxGPECHte
 oRN5i/hCZAZG4yIHU13sLu2Gzr9y1v1K1hB+HVT35MtSCPIXXgSPR3BjLX8oBTCPtPVTOsbB5t6P2
 uQuqp7UHxADHtpLPHVvHgEkzpMUTvvHKzD7pi7mIcj4+UtqyAbfRLjstv0Ts9uIyOYBvYX6k8x9wJ
 yMsS3dsA==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTOZU-00ALNh-BC; Sat, 30 May 2026 20:38:08 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sat, 30 May 2026 15:37:43 -0300
Subject: [PATCH 2/4] drm/v3d: Flush MMU TLB and cache during runtime resume
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-v3d-fix-rpi4-freezes-v1-2-c2c8307da6ce@igalia.com>
References: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
In-Reply-To: <20260530-v3d-fix-rpi4-freezes-v1-0-c2c8307da6ce@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3313; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=IoRNcJhf2h+uMICVGoSdgVpuTUpizOehyniHN97RZR0=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqGy6Ii5e5WtjJDkd+0FPPWaaEUPup/PMQiprl8
 UhRI/4xphKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahsuiAAKCRA/8w6Kdoj6
 qkITB/9Q1NPtMXiXKMz7z0IGm6ay3sHgnILmysfB0aME0X6ZHO6rb/TrQmt7YRunpvL25KuLUZe
 3M6Bd66mXQIoR8IBgjEQRcySTQMgExvkrR1gZKbrfGq7S+yajKl/pgdx5uHWKhoQa8oricyoU10
 GVJzyjX71DO7ePNnjc7/wMoCVeT6BJHhqDSbPVrg7wUTHeKDatXojm1hx5IcRUn566lif/TQnzn
 EA1GhoDjXclK2b0mgslfO8GhAVVssWMmNIzr9O7FjfiovQTlJp/jID2Fcy6wjISU773YnRkTtzk
 PMjxcN1vtJ3jmZ90uYIJ2dLEaO3BGqCIFAjz7y0UsI+/Wzep
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

v3d_mmu_set_page_table() ends by calling v3d_mmu_flush_all() to flush the
MMU cache and clear the TLB after reprogramming V3D_MMU_PT_PA_BASE.
v3d_mmu_flush_all() is gated by pm_runtime_get_if_active(), which returns
0 unless runtime_status == RPM_ACTIVE.

v3d_mmu_set_page_table() is called from two paths that *know* V3D is
reachable, but where the runtime PM status might be wrong:

  1. v3d_power_resume(): the runtime resume callback itself, where
     runtime_status is RPM_RESUMING.

  2. v3d_reset(): called from the DRM scheduler timeout handler with the
     hung job's pm_runtime reference held, so RPM_ACTIVE, but here we
     don't need to take an extra reference for the duration of the flush
     either.

In the first case pm_runtime_get_if_active() returns 0, the flush is
silently skipped, and V3D resumes executing with whatever MMUC/TLB state
happened to survive the last reset. This can leave stale translations
live across runtime PM cycles, manifesting as random GPU hangs.

Split the actual flush sequence into a helper that does the writes
unconditionally, and have v3d_mmu_set_page_table() call it directly.

Fixes: 458f2a712ab4 ("drm/v3d: Introduce Runtime Power Management")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_mmu.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_mmu.c b/drivers/gpu/drm/v3d/v3d_mmu.c
index 630c64e51d2f..94f6676d5633 100644
--- a/drivers/gpu/drm/v3d/v3d_mmu.c
+++ b/drivers/gpu/drm/v3d/v3d_mmu.c
@@ -37,13 +37,14 @@ static bool v3d_mmu_is_aligned(u32 page, u32 page_address, size_t alignment)
 		IS_ALIGNED(page_address, alignment >> V3D_MMU_PAGE_SHIFT);
 }
 
-int v3d_mmu_flush_all(struct v3d_dev *v3d)
+/*
+ * Issue the MMUC flush and TLB clear unconditionally. The caller must
+ * already know that V3D is reachable. In particular, this is used from
+ * the runtime resume callback.
+ */
+static int v3d_mmu_flush_all_locked(struct v3d_dev *v3d)
 {
-	int ret = 0;
-
-	/* Flush the PTs only if we're already awake */
-	if (!pm_runtime_get_if_active(v3d->drm.dev))
-		return 0;
+	int ret;
 
 	V3D_WRITE(V3D_MMUC_CONTROL, V3D_MMUC_CONTROL_FLUSH |
 		  V3D_MMUC_CONTROL_ENABLE);
@@ -52,7 +53,7 @@ int v3d_mmu_flush_all(struct v3d_dev *v3d)
 			 V3D_MMUC_CONTROL_FLUSHING), 100);
 	if (ret) {
 		dev_err(v3d->drm.dev, "MMUC flush wait idle failed\n");
-		goto pm_put;
+		return ret;
 	}
 
 	V3D_WRITE(V3D_MMU_CTL, V3D_READ(V3D_MMU_CTL) |
@@ -63,7 +64,19 @@ int v3d_mmu_flush_all(struct v3d_dev *v3d)
 	if (ret)
 		dev_err(v3d->drm.dev, "MMU TLB clear wait idle failed\n");
 
-pm_put:
+	return ret;
+}
+
+int v3d_mmu_flush_all(struct v3d_dev *v3d)
+{
+	int ret;
+
+	/* Flush the PTs only if we're already awake */
+	if (!pm_runtime_get_if_active(v3d->drm.dev))
+		return 0;
+
+	ret = v3d_mmu_flush_all_locked(v3d);
+
 	v3d_pm_runtime_put(v3d);
 	return ret;
 }
@@ -85,7 +98,7 @@ int v3d_mmu_set_page_table(struct v3d_dev *v3d)
 		  V3D_MMU_ILLEGAL_ADDR_ENABLE);
 	V3D_WRITE(V3D_MMUC_CONTROL, V3D_MMUC_CONTROL_ENABLE);
 
-	return v3d_mmu_flush_all(v3d);
+	return v3d_mmu_flush_all_locked(v3d);
 }
 
 void v3d_mmu_insert_ptes(struct v3d_bo *bo)

-- 
2.54.0

