Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E28BC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA0A10E61E;
	Wed, 29 Jul 2026 02:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="heL47+p9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766B110E62A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=zaIRtogQtgAbv5gqpEUrxDtWcP3J3EUl/Q4CgSt564w=; b=heL47+p9RNwvAVjj2DuGAyiLdR
 2J+XSbj4+FQgLHgdel2UbcQdB/XSXpapWxvDPuvvYU/ScLMHYTfRUXx3OaS55xNA6PskppHB19lEQ
 BSlx1STxJJGhSWRyOFwzKMAWiLbXB2SGPlRBEX9bLBMgeWsdMw7DD3hm7SnnMK+pvmJkq2Y7dYFtV
 cU7xWNyR0THXaX3APRMez1LXEcQYf5SCbzoX3nbYaRY5gW7kGwcsus2jI4YgdlwyX+0ypEBQRVM/T
 V1bW2MDyYNe4wztuN9h/NCggVYF0NYs88L0ItfqHtBJO0Bgexa07sy3vxFMdmN+HYsDZlWvbRJWnf
 UWS6jLrw==;
Received: from [187.36.208.132] (helo=[192.168.1.221])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wotjj-007FxT-DN; Wed, 29 Jul 2026 04:09:35 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 28 Jul 2026 23:09:23 -0300
Subject: [PATCH 2/2] drm/v3d: Remove the now-redundant reset lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260728-v3d-order-global-reset-v1-2-e47be838158d@igalia.com>
References: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
In-Reply-To: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2483; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=bnDg6Q4bMZGurG/WyEDXVO9mxGFK4I9avKUucnYMbag=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqaWDXRmyHRg0GCj1VobS0Ov7Fh7ysl1hwYlGUj
 J3l8RfYRSSJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamlg1wAKCRA/8w6Kdoj6
 qr2HB/9dki54UkvRFMMy+Z3FfCRVrY14eDumwYl6dUhCaq2+7wLx+CO6Rele9Nrjxt8T0f5/GLD
 A5pNzV0hR8mFJfTWZlCQJYTRDRzRrTHvB+Y7hULVUN2rOYe0Qdp45B9uowXkg439tpFM/KHEfhs
 BapYY6TKtIQ/Hh8CEQuGlD7kIDMAoKai6HSyyEZkAeQAQH3G9E9unUoI+j83ETquyQ+QZJi8nH4
 kLLSs2htGVsXQbAWJitAcJ2VWHJ2K8leLHsQIMckRUjctnP6nbSSq60Zgx+JTJ5Hz+ZBfLF/lmE
 g55JNNGNOSjSO73NUnSttQxYyisIYkEYMn4Io/zc4au2TRIC
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

`reset_lock` was taken by v3d_gpu_reset_for_timeout() to keep the
timeout handlers of different queues from parking the schedulers and
resetting the GPU at once. Now that all of the queues share an ordered
workqueue for their timeout work, those handlers can no longer run
concurrently and the lock guards nothing.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h   | 6 ------
 drivers/gpu/drm/v3d/v3d_gem.c   | 3 ---
 drivers/gpu/drm/v3d/v3d_sched.c | 4 ----
 3 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 8779a42c6508..7b73929e5bba 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -176,12 +176,6 @@ struct v3d_dev {
 	/* Protects bo_stats */
 	struct mutex bo_lock;
 
-	/* Lock taken when resetting the GPU, to keep multiple
-	 * processes from trying to park the scheduler threads and
-	 * reset at once.
-	 */
-	struct mutex reset_lock;
-
 	/* Ordered workqueue shared by every queue's scheduler timeout work.
 	 * V3D reset is global to all queues, so the timeout handlers must not
 	 * run concurrently.
diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 23a0db9575a5..28ed9e847a8d 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -320,9 +320,6 @@ v3d_gem_init(struct drm_device *dev)
 
 	spin_lock_init(&v3d->mm_lock);
 	ret = drmm_mutex_init(dev, &v3d->bo_lock);
-	if (ret)
-		goto err_stats;
-	ret = drmm_mutex_init(dev, &v3d->reset_lock);
 	if (ret)
 		goto err_stats;
 	ret = drmm_mutex_init(dev, &v3d->sched_lock);
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 63dd95b828c8..b0a112e65915 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -700,8 +700,6 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job,
 	struct v3d_job *job = to_v3d_job(sched_job);
 	enum v3d_queue i;
 
-	mutex_lock(&v3d->reset_lock);
-
 	/* block scheduler */
 	for (i = 0; i < V3D_MAX_QUEUES; i++)
 		drm_sched_stop(&v3d->queue[i].sched, sched_job);
@@ -722,8 +720,6 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job,
 	for (i = 0; i < V3D_MAX_QUEUES; i++)
 		drm_sched_start(&v3d->queue[i].sched, 0);
 
-	mutex_unlock(&v3d->reset_lock);
-
 	return DRM_GPU_SCHED_STAT_RESET;
 }
 

-- 
2.55.0

