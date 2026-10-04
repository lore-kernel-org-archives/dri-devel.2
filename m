Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7852CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C90510EA75;
	Sun,  4 Oct 2026 15:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PXsOUAlG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7088410EA81
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=VOWcRZ2k3vfo8YWEUinddli3Ux2thWuw7ko8c3iGf08=; b=PXsOUAlG4U7uL6/IQShu7NMESW
 ebn/7+zZwZcCQHS4plQwCVBvQdLutExDToq+JS4uNakldvt1aiHnViO9b8UuS88NnaJrjtqGoHdap
 chRhHh8qwB3G8wh8h6YSV5CpkvYFEzi1eOjy+aieVuMrCcbsWxZFZXdV2Hc7PEkMRpFNpP3/FIUa/
 9rDTgU6TmjNIi1oVzSqEOryxQEc/BjHCH0QVlV/7CiJFUV1G+qI+1GyHZEUmcP68WiHJ9KWckUKeq
 ByA4+Iok3DyVPWYKA35/9E5MlNk1ocIphxpRGwN4HD5akUmGC8oLvCHS1cZEOL8yZBqXxQdINqtec
 W2ADZ8Mw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMW-00BNsh-0v; Sun, 04 Oct 2026 17:42:52 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:10 -0300
Subject: [PATCH 10/11] drm/vc4: Protect the hang state with a dedicated
 lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-10-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3624; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=R/Xl/kQoctXbrFz3Pf7OSzKyj2sXByaoiXdS+FqQdbM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPXORgZyh/xrLfP/5XmlZ5eBL1mICPM7zoiI
 ASsXrj5JeuJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1wAKCRA/8w6Kdoj6
 qiJqCACgWjYrpgyIAaOkdiwVNAILCd9Z4wOWvzHWt+TorGWPUyTN26TrTgkyjomnV5IbEC1LKJi
 DKE9decpwV1L8cvj5gbg6s+NwA6JkHgXjdRZ84KehSI2Mwker/xvp5avYTJx0ovyr3/Ap1IDpiu
 xuHPssEUvPDfQlB43VEcicGRq+I8X7GzujjQyyyYjlC9Tu+ZKx+ZfKfJJs3NnR84256w9hWeWKA
 IQjf/TgkgF1XdcIlsRDjnaLRmiyr0PJ1lyHolrmPJiHk5z5I5SrRpGxIP5sGL2ag4PBB/8ozoB/
 JLCDEPvz4fHYtpWh+0l/iL3N+VLBHik/x7MR5LZIIRFup44x
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

The saved GPU hang state is published by vc4_save_hang_state() and
claimed by VC4_GET_HANG_STATE, and access to the pointer was serialized
by job_lock. However, job_lock already has other attributions related
with the jobs currently executed on hardware.

The hang state has no invariant in common with the jobs programmed into
the hardware. vc4_save_hang_state() already drops job_lock between
reading those jobs and publishing the dump, so the two critical sections
are independent and nothing is made less atomic by separating them.

Give the hang state its own spinlock. The two locks are never nested, so
this introduces no ordering requirement, and neither hang state path has
to disable interrupts any more.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_drv.h |  2 ++
 drivers/gpu/drm/vc4/vc4_gem.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index 2fad8a489558..c6ae54d2e8b8 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -99,6 +99,8 @@ struct vc4_dev {
 	struct vc4_hvs *hvs;
 	struct vc4_v3d *v3d;
 
+	/* Protects @hang_state. */
+	spinlock_t hang_state_lock;
 	struct vc4_hang_state *hang_state;
 
 	/* The kernel-space BO cache.  Tracks buffers that have been
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 1f3cb3c2c7fc..230558b3f684 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -74,7 +74,6 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
 	struct vc4_hang_state *kernel_state;
 	struct drm_vc4_get_hang_state *state;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
-	unsigned long irqflags;
 	u32 i;
 	int ret = 0;
 
@@ -86,10 +85,10 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
 		return -ENODEV;
 	}
 
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
+	spin_lock(&vc4->hang_state_lock);
 	kernel_state = vc4->hang_state;
 	if (!kernel_state) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+		spin_unlock(&vc4->hang_state_lock);
 		return -ENOENT;
 	}
 	state = &kernel_state->user_state;
@@ -99,12 +98,12 @@ vc4_get_hang_state_ioctl(struct drm_device *dev, void *data,
 	 */
 	if (get_state->bo_count < state->bo_count) {
 		get_state->bo_count = state->bo_count;
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+		spin_unlock(&vc4->hang_state_lock);
 		return 0;
 	}
 
 	vc4->hang_state = NULL;
-	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+	spin_unlock(&vc4->hang_state_lock);
 
 	/* Save the user's BO pointer, so we don't stomp it with the memcpy. */
 	state->bo = get_state->bo;
@@ -273,13 +272,13 @@ vc4_save_hang_state(struct drm_device *dev)
 		mutex_unlock(&bo->madv_lock);
 	}
 
-	spin_lock_irqsave(&vc4->job_lock, irqflags);
+	spin_lock(&vc4->hang_state_lock);
 	if (vc4->hang_state) {
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+		spin_unlock(&vc4->hang_state_lock);
 		vc4_free_hang_state(dev, kernel_state);
 	} else {
 		vc4->hang_state = kernel_state;
-		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+		spin_unlock(&vc4->hang_state_lock);
 	}
 
 	return;
@@ -1177,6 +1176,7 @@ int vc4_gem_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&vc4->render_job_list);
 	INIT_LIST_HEAD(&vc4->job_done_list);
 	spin_lock_init(&vc4->job_lock);
+	spin_lock_init(&vc4->hang_state_lock);
 	spin_lock_init(&vc4->perfmon_state.lock);
 
 	INIT_WORK(&vc4->hangcheck.reset_work, vc4_reset_work);

-- 
2.55.0

