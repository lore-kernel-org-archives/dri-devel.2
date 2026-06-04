Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D966CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C271F10F823;
	Thu,  4 Jun 2026 20:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="AbCEjGkA";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7432310F823
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NaISZLqYtOJ8wM2d/WM1WaTdwrGS3CGHAqlu9K3v1dA=; b=AbCEjGkAC9jT0/vT3/JXaTDj5k
 hBPV5rSmT0GiFdPu3G0IRqiCDcwgidp5iaGOAG/NQL7RQUVxCceYQmMFXP0+T8szYlBdqOBaP0l8P
 pzCu+VH54D+G+jD+uDW12PgwzXfh0TUqNxejnh6Gs5hhTSrwKZTvEWy3fuYGXQHOQUEo1v/m/9FTD
 2k4YvovDV4PUIN38m0J+IiDO5IrpAeSIcpvIz2ZTWK7Rp4T/7t+bVdx+rh9yE7WrxlJwBexIdTSz+
 mIwAHdKmQZUcw1QOgwrsp49XNG6yJ+/BW8WaAFFwCYV3z/5n6mng9L9s1mZ/C0bZUEW016m1iKT6H
 crW+mluQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEkW-00CoGD-Hr; Thu, 04 Jun 2026 22:33:08 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 04 Jun 2026 17:32:23 -0300
Subject: [PATCH v4 10/12] drm/v3d: Split BO fence attach from syncobj
 output handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-v3d-sched-misc-fixes-v4-10-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=GfTfgPZhdQUMfBU4jjDEMYfPFYxPtHBqM5hCB+IlLSw=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIeDUgJC/w+0D+FDwnG4rId0t0wbKW0V3wxBIw
 RPmzag1NKOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiHg1AAKCRA/8w6Kdoj6
 qrZoB/46/maGVCFVAzfnZphA5w4GfrOOXKwUMK30jPfoFpCmTb0j1ZnqcV86mEyPNftV2Rc9Oa6
 Id1J1Sn4YqZXVz5VOsM0zDVESl9NuoOrR4+exYROzCWTxeE/IYuoyy2LJZ6N3bvdD+BeI5okFae
 uoE7j58YmYhzTNXXQExXha2lOG8imXkLhY1FHa4RQsNBsDb/VoEfyWa7aAkgNjGenQb2y/7V8k0
 09PA4vB4gi7Yn+l6vZv2+UeyR2Ytw1K+ZiR6oEcuwNJzobK3Yg6irPB5qLczyQaqT5EsNHY1wHL
 nge/cYQI0/smahrZcTJuB8KzC/4hvSnv9pt2y9Njx+byX6ZK
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

v3d_attach_fences_and_unlock_reservation() does three different things:
(1) attaches the submission's last fence to every BO, (2) releases
drm_exec, and (3) replaces the userspace out_sync syncobjs. Decouple
these three behaviors into different functions, so that each function
has a more self-contained behavior.

v3d_submit_jobs() now invokes the three steps explicitly, which makes the
submission sequence self-documenting and keeps each helper self-contained.

No functional change; just code consolidation.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index aab47fa72ad7..9ee59eddf63a 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -319,12 +319,9 @@ v3d_attach_perfmon_to_jobs(struct v3d_submit *submit, u32 perfmon_id)
 }
 
 static void
-v3d_attach_fences_and_unlock_reservation(struct v3d_submit *submit,
-					 u32 out_sync, struct v3d_submit_ext *se)
+v3d_submit_attach_object_fences(struct v3d_submit *submit)
 {
-	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
 	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
-	struct drm_syncobj *sync_out;
 
 	/* The submission's last fence covers the entire submission. Attach it
 	 * to every BO touched by any job in the submission.
@@ -338,8 +335,15 @@ v3d_attach_fences_and_unlock_reservation(struct v3d_submit *submit,
 					   DMA_RESV_USAGE_WRITE);
 		}
 	}
+}
 
-	v3d_submit_unlock_reservations(submit);
+static void
+v3d_submit_process_post_deps(struct v3d_submit *submit, u32 out_sync,
+			     struct v3d_submit_ext *se)
+{
+	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
+	struct v3d_job *last_job = submit->jobs[submit->job_count - 1];
+	struct drm_syncobj *sync_out;
 
 	/* Update the return sync object for the job */
 	/* If it only supports a single signal semaphore*/
@@ -400,7 +404,10 @@ v3d_submit_jobs(struct v3d_submit *submit, u32 out_sync,
 
 	mutex_unlock(&v3d->sched_lock);
 
-	v3d_attach_fences_and_unlock_reservation(submit, out_sync, se);
+	v3d_submit_attach_object_fences(submit);
+	v3d_submit_unlock_reservations(submit);
+	v3d_submit_process_post_deps(submit, out_sync, se);
+
 	v3d_submit_put_jobs(submit);
 
 	return 0;

-- 
2.54.0

