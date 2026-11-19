Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D775606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJsyC+I0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B2110FCE1;
	Thu, 19 Nov 2026 07:48:53 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E932110E664
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:36:12 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-36eb1cb7aabso2627353eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795055772; x=1795660572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=r5vcTKCKH8w1c2blCWgaYBVv/4WCN3dPU6fSMD6S8fk=;
 b=PJsyC+I0Krn9JcjIdUmaUeexTDRaypwuLT9uvlmCY4nVB2BGrYo0CggufLonXXjIby
 znuzRq7mVbmKukwtRWbknMGbKb7e2lCn0I7gxa40qXGuZkaHbKyRESf+b4NL8KGflpTz
 VDJtPviix1Wao3EFStQN+nSw0qjLK5gYXB5gZL6Y3SPu89VWwPcpYn4IimZg0qGuYOSM
 rVBf1LI3nbb1g35UQzKuCXy+uZuY3Hrk34dOO0wFtcNE+Ev6zyCsMB/VYW5yBMFRiIgE
 3AYX9hDF4OcEWg/21AO487hLUsLVeOmKnssUJrIzTOZMHAjK/c8sQtZbx8YLw5WHotec
 Xppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795055772; x=1795660572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5vcTKCKH8w1c2blCWgaYBVv/4WCN3dPU6fSMD6S8fk=;
 b=YXBNU194kshlHMLpswmVHorveagtx/YaMdaHnJxc/a7GcAC2Hz83ZOf4AZ+grbP60R
 m06pQDlDmsGecX0D50L+R0UXtlxN8M/4LiCDh8ML20Df6TQGwThc1V2IKmud0N9Hf5uj
 TuA5ctBm5RddiLeHnQj4zgoMAE06UcUPzLlsBfLh+xm+QPT2zuDPpAIsG32UFrqtHpJ9
 LqXk9474FbfkrJR+5yehagdJ1+AJID2R1J+20efg8eNPwZYD3AraVT79R67Lb7VD5hh4
 Ej7invfhjfbfzd1aX4YFYFy5iZf6opzM2Tm53/o0wQKSImOIa40Aj6Tc+qq7XegzcS5x
 fTxw==
X-Gm-Message-State: APuU4Z+B6YpFguE31XwcVRisaTfLYZ/Yl7rnaFc7LklfCKqzW6Zm26RR
 Vx7h1Sh6tPCGsQm9pFUqQKX3NX6/AgvdsS6JluhJX3ZoXTo6egih/lPe
X-Gm-Gg: AZFdTZcqpZoEfmayXMECoDpaiQrjZItjddn9VhKrrojAqbPIkQJXs7IgrHVD70c5qwK
 fcw1WXqJkTt+hNUGP/cedrauVEZtB26HimQCWKubmlsnJ2QHfvGTESaRg0r8C2nIw4VZK9JhZdR
 071srlw3JItwU+PPhyVohKRUyIYFaU2dHITnEs3kQYMwUR/NozMvTJ/cMpiFfQlaLgCvVs6/uS1
 0+Mc2yswl2tv38wWW8MgkOjWWqVW0f9neqd45rHuF506j/9rtxLcc/ZhyyEqcEd4HC090BvsQkB
 Vxj/meoi19SPnZuIhHpwUmPsevJpWVsSRMLoNRcn2e0D0b8/mXHc1F7W3c0tX+NSD2dtXp5T6gU
 Ps+9VvnBi1mhvYQExG1/3xfSc+LT2OJn4Je6enyZVujcd+jhxICyl6+BwtBOvbeuO6VYnymDZCL
 2ePrm9yqH39Zp4ovVhwIxzS8loK0x2xm0OmdDEMcQE8v1adZMa/ra7P890sLxnaKTNFVlEtnP6I
 cAT61xlO65fczvWql5bnb7nEzt83rSm4UsoUTownXMSBJdtl8gOPTqaCuaBa6R1CG6AB2Q0WivA
 cFv+4V16jO8YUhb1DjP7WdZcKgNpSSee3ZYRpZNDwylEw42oeYGRS0oiJXapZQaXr4T4c+3oTMZ
 4FWSlfly0l0zoIgs80ZMMecQCtoFXwvsWyp4eA2R4
X-Received: by 2002:a05:7301:9e08:b0:379:7bb6:9c4b with SMTP id
 5a478bee46e88-38281bfc037mr3868548eec.39.1795055771985; 
 Wed, 18 Nov 2026 18:36:11 -0800 (PST)
Received: from lwq-System-Product-Name.. ([2602:feda:30:cafe:ec49:38a8:0:f6])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a80bc19bsm12160265eec.29.2026.11.18.18.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 18:36:11 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, hjc@rock-chips.com, heiko@sntech.de,
 andyshrk@163.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/flip: drain the flip work on cleanup
Date: Thu, 19 Nov 2026 10:36:04 +0800
Message-Id: <20261119023604.1495603-1-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_flip_work_cleanup() only warns when the queued or the committed list
is not empty.  Nothing cancels the worker and nothing runs the tasks
that are still queued, so the caller silently leaks whatever the tasks
hold (framebuffer references, vblank references, ...) and, if the
worker is still pending, it can run after the structure embedding the
flip work has been freed.

Cancel the worker and run the remaining tasks from
drm_flip_work_cleanup().  The work item is the only producer of the
committed list, so after cancel_work_sync() the two lists can be
spliced out and iterated without holding the lock.

The helper only drains the work items that exist when it is called, so
the callers have to make sure that no new item can be queued.  Both
in-tree callers already do:

 - Rockchip VOP: rockchip_drm_unbind() runs drm_atomic_helper_shutdown()
   before component_unbind_all(), and vop_unbind() calls
   pm_runtime_disable() before vop_destroy_crtc().  The CRTC is disabled
   and the device cannot be resumed when the cleanup runs, so neither
   vop_plane_atomic_update() nor vop_crtc_atomic_flush() can queue a new
   item, and vop_isr() returns early because
   pm_runtime_get_if_in_use() fails.

 - MSM mdp4/mdp5: msm_drm_uninit() destroys the KMS, which releases the
   interrupt, before drm_dev_put() runs the drmm actions.  The flip
   cleanup action is registered after drmm_crtc_alloc_with_planes(), so
   it runs before drmm_crtc_cleanup() and after the vblank interrupt
   that commits the work is gone.

Rockchip VOP called drm_flip_work_cleanup() after drm_crtc_cleanup(),
which memsets the CRTC.  Its worker calls drm_crtc_vblank_put() on that
CRTC, so the drain has to happen before the CRTC is cleaned up.

Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64 with aarch64-linux-gnu-gcc 11.4
and CONFIG_DRM_ROCKCHIP=m, CONFIG_DRM_MSM=m.  The affected hardware was not
available, so the teardown path was not exercised and no fault or
race injection was run.

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.
---
 drivers/gpu/drm/drm_flip_work.c             | 23 +++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |  9 +++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_flip_work.c b/drivers/gpu/drm/drm_flip_work.c
index 52c437746d48..b8ce3966fa9a 100644
--- a/drivers/gpu/drm/drm_flip_work.c
+++ b/drivers/gpu/drm/drm_flip_work.c
@@ -149,10 +149,29 @@ EXPORT_SYMBOL(drm_flip_work_init);
  * drm_flip_work_cleanup - cleans up flip-work
  * @work: the flip-work to cleanup
  *
- * Destroy resources allocated for the flip-work
+ * Cancel the worker and run the tasks that are still queued, so that the
+ * resources they hold are released even if the work never made it to the
+ * workqueue.  Must be called before the object embedding @work is freed and
+ * after the driver has stopped the code that calls drm_flip_work_queue()
+ * and drm_flip_work_commit(): only the work items that exist when this
+ * function is called are drained.
  */
 void drm_flip_work_cleanup(struct drm_flip_work *work)
 {
-	WARN_ON(!list_empty(&work->queued) || !list_empty(&work->commited));
+	struct drm_flip_task *task, *tmp;
+	LIST_HEAD(tasks);
+	unsigned long flags;
+
+	cancel_work_sync(&work->worker);
+
+	spin_lock_irqsave(&work->lock, flags);
+	list_splice_tail_init(&work->queued, &tasks);
+	list_splice_tail_init(&work->commited, &tasks);
+	spin_unlock_irqrestore(&work->lock, flags);
+
+	list_for_each_entry_safe(task, tmp, &tasks, node) {
+		work->func(work, task->data);
+		kfree(task);
+	}
 }
 EXPORT_SYMBOL(drm_flip_work_cleanup);
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 69e72727da24..38935ef08b70 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1990,12 +1990,19 @@ static void vop_destroy_crtc(struct vop *vop)
 				 head)
 		drm_plane_cleanup(plane);
 
+	/*
+	 * The flip work drops the vblank reference taken when the framebuffer
+	 * was queued, so it has to be drained while the CRTC is still valid.
+	 * The CRTC has been shut down and runtime PM disabled by the time this
+	 * runs, so no new work item can be queued anymore.
+	 */
+	drm_flip_work_cleanup(&vop->fb_unref_work);
+
 	/*
 	 * Destroy CRTC after vop_plane_destroy() since vop_disable_plane()
 	 * references the CRTC.
 	 */
 	drm_crtc_cleanup(crtc);
-	drm_flip_work_cleanup(&vop->fb_unref_work);
 }
 
 static int vop_initial(struct vop *vop)
-- 
2.34.1

