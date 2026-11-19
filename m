Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0E606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v7MhHTI5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81AE11217A;
	Thu, 19 Nov 2026 08:31:57 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DFD11217A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:31:51 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-382ecd5cf2cso733957eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795077110; x=1795681910; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QE7ZF+eIOkDqPsqdXYso0HkQT1OPcmclWJ4l96GctkY=;
 b=v7MhHTI5G8jFHwkASj0SH0YS3UoE2HHGCBvmew7fkkRZ/gcNdu/HXYhKbT0J1TyOLP
 Q6NZN9roe/xsd+lzFpQTgkSHd6oePJU6IqkhYTe2mVeA8QWDV6Dq5zubs5QTfMFGLWQ5
 BWJQwMBogP5jVrnFPZDt0Gon/t+ZLJ/dVdw+FvKF/wGeqi5GvZI4/suwoFzNJVcRenWW
 hDce2TQkH9cIk4de4Vma7cD+Rkx061T/9IrmtBJ6cPr5TDfQ9UcEMC/I/wRaVflu889x
 IwP0sV93cQQHwbHvxoCE9rHU08BTwrWw9FF4Y5VPlWILJcvbV2zJCGgS9+Iv1JP49HO4
 JAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795077110; x=1795681910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QE7ZF+eIOkDqPsqdXYso0HkQT1OPcmclWJ4l96GctkY=;
 b=kVctamXphFN/SrXNsvVBmzplVSY+1/3S7RXyoQrDPf30vVXi3kLHR+mFr7C5Hy2JuJ
 wZgMuuNhTXwcm3FqF6IWf8GpKrz5BXq8RfXYGsTzy25lAW56C2nqe6AjT01ojCVmMsW6
 QVZuALYxTAsrTMIKwonstsISlmcm8Rwbni+XoURpIN9WseYPShPDOKrFE+78EmNYS1Pt
 /9DW1x1VCpaxzJPijkbUd3wO6S4FKIgqiy63RcW5eDHxztK8qjmqszfXvKHNajSCu/Ua
 5/5GFT2y6njvRvnsGE8nEomMhg9aoy8zVmzC6/Bw3RXoVzfuDX4fTbugP4bnQxXlmQaW
 38UQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEo+XBITELd4ctrDHd5b4iy5fTID6NnKt3X+Lq1Lmv+hGqj94Y2iy+TO0JYKrLSGW5EG8S0zvY29KI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+9B6RbPXExsm5T36O1nl5kS1WW76b8W0NZmluFQ9h2m22o594u
 t9TjGrYTDRvmaAnNvrhNmkCaAVnrLETxq/TmTyzpCtXhKwzIdGQptMYF
X-Gm-Gg: AZFdTZf64TEcrVMUl36x/uCLueMh9meatieYwPTOMu1p/t/Knl6GWACdxOERdpbZC3P
 fJzU0ehDuZug8mN8eP01oXaLmI6pN7PqhogXGwgRIGiyFBFxNFmelHvhunskQhM3JvcH7QmfQHP
 +kenuaS4PYmaWHx6sg6L1p5kMW6qvRGOvXPEw5WxwUZMeynCedbyFU+weuyzgkWuu/Ezyq5f2NJ
 sHiUtBEsc+o/QYYHdm/d8iVLJa7G9QWFlSvCIlQdCtkv0x8KaGbJYhVRcxyNlMct4PFfGzaujgm
 Lk1YA9YmfQQR14UoPVssp2NCMMUcdrAJ5Y05/5JiugjVi95gSGqTwlpaH6gc17HwT2TPPfKeZpt
 NdYkvjI4KUFCLUaAaQegFs46M0t4/VXoAjq1YqzwWN+vPz1tBQ7C1so6kUj1KTRlgbButn8D/T2
 vujFQgvG4CqABj3AsTTCh++aHk6XOY5lzUlFh8F6/La6bpx4CWxC8ZT5SPNINlJ2tJEqtyqrZLa
 +dvzgJRKjjKyvbP9zQxZSXkBTF7BQjD999Pd5LBjR+oSPZScKvE2MqkW9lz4StWlI3QSdnpGoPN
 vsW8RQL2EzQ8/re/ppnkpO8+srNmUaWSLUdnrvSsaX99JCWmr28DvFF2x0DPmMSq27T+XJLs/Vd
 rXtNkmSLjVgcpO8kf+mfSJgTiAUJmqifTQad1aU7OGWdVKcYo
X-Received: by 2002:a05:7301:188e:b0:381:685a:e1ee with SMTP id
 5a478bee46e88-384b3e78a26mr413843eec.12.1795077110279; 
 Thu, 19 Nov 2026 00:31:50 -0800 (PST)
Received: from lwq-server.tail118c18.ts.net ([74.176.208.23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a63054ddsm16553792eec.4.2026.11.19.00.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:31:49 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/2] drm/flip: drain the flip work on cleanup
Date: Thu, 19 Nov 2026 16:31:33 +0800
Message-Id: <20261119083133.3437277-2-shunsheng1218@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119083133.3437277-1-shunsheng1218@gmail.com>
References: <20261119023604.1495603-1-shunsheng1218@gmail.com>
 <20261119083133.3437277-1-shunsheng1218@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
the callers have to make sure that no new item can be queued and that
the objects the tasks still use are alive:

 - Rockchip VOP: vop_unbind() unregisters the shared interrupt with
   devm_free_irq() before the runtime PM is disabled and before the CRTC
   and its flip work are cleaned up.  Disabling runtime PM is not a
   barrier: vop_isr() bails out when pm_runtime_get_if_in_use() fails, but
   that helper returns -EINVAL once runtime PM is disabled rather than a
   "not in use" value, and the line is shared, so another user can still
   get the handler invoked.  Removing it from the descriptor waits for the
   invocation that is running and keeps new ones from starting, which is
   what makes the drain that follows safe.  The bind error path that fails
   after the interrupt was requested frees it the same way, so every
   request is released exactly once.

 - MSM mdp4/mdp5: mdp4_destroy() and mdp5_kms_destroy() release the flip
   work from the KMS destroy path, after the interrupt and the KMS
   workqueue have been stopped and before drm_gpuvm_put() releases the
   VM the worker needs.  The DRM-managed action is removed there, so it
   cannot run later against a KMS that no longer exists.

Rockchip VOP called drm_flip_work_cleanup() after drm_crtc_cleanup(),
which memsets the CRTC.  Its worker calls drm_crtc_vblank_put() on that
CRTC, so the drain has to happen before the CRTC is cleaned up.

Fixes: cabaafc78935 ("drm: add flip-work helper")
Fixes: 47a7eb459777 ("drm/rockchip: Unreference framebuffers from flip work")
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

---
Changes in v2:
  - Split the MSM preparation out into patch 1; the generic helper keeps
    draining the queued tasks here.
  - Add the Fixes: tags for the flip-work helper and for the Rockchip
    ordering.
  - Describe the MSM callers by the new KMS-destroy call site instead of
    the managed action, which now runs earlier.
  - Rockchip: drop the pm_runtime_get_if_in_use() change.  Unregister the
    shared interrupt before the runtime PM is disabled and before the CRTC
    is destroyed, and release it on the probe path that fails after the
    handler was registered.
  - Checked as a series: both patches apply in order on msm-next
    (d024361c631b) and on drm-misc-next (fac7a5f16230).
Prepared against v7.4-rc1-1969-g666539eecdf4.

Compile tested only: arm64 with aarch64-linux-gnu-gcc 11.4
and CONFIG_DRM_ROCKCHIP=m, CONFIG_DRM_MSM=m.  The affected hardware was not
available, so the teardown path was not exercised and no fault or
race injection was run.

Checked as a series against the target trees: both patches apply in order on
msm-next (d024361c631b) and on drm-misc-next (fac7a5f16230).

AI assistance: the analysis, the change and its review notes were
prepared with Claude (Anthropic) as a coding assistant.  The author
reviewed the reasoning and takes responsibility for the content.
---
 drivers/gpu/drm/drm_flip_work.c             | 23 +++++++++++++++++++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 21 +++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_flip_work.c b/drivers/gpu/drm/drm_flip_work.c
index 52c437746d483..b8ce3966fa9ab 100644
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
index 69e72727da24f..c10ad16147a54 100644
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
@@ -2259,7 +2266,7 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 		vop->rgb = rockchip_rgb_init(dev, &vop->crtc, vop->drm_dev, 0);
 		if (IS_ERR(vop->rgb)) {
 			ret = PTR_ERR(vop->rgb);
-			goto err_disable_pm_runtime;
+			goto err_free_irq;
 		}
 	}
 
@@ -2267,6 +2274,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	return 0;
 
+err_free_irq:
+	devm_free_irq(dev, vop->irq, vop);
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 	vop_destroy_crtc(vop);
@@ -2280,6 +2289,14 @@ static void vop_unbind(struct device *dev, struct device *master, void *data)
 	if (vop->rgb)
 		rockchip_rgb_fini(vop->rgb);
 
+	/*
+	 * Unregister the shared handler before the runtime PM is disabled and
+	 * before the CRTC and its flip work are cleaned up: disabling runtime
+	 * PM does not keep vop_isr() from running, and the flip work the
+	 * handler commits has to be drained afterwards.
+	 */
+	devm_free_irq(dev, vop->irq, vop);
+
 	pm_runtime_disable(dev);
 	vop_destroy_crtc(vop);
 
-- 
2.34.1

