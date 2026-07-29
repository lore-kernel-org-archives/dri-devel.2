Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC73C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DDE310E62A;
	Wed, 29 Jul 2026 02:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Uw1cy1JE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74B6410E61E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=u2xZ37GFFdjmX4PRie3ucRRh7FlY9mAoqWOaCOjHIBk=; b=Uw1cy1JE9yeEO1FlfapVOfr6Cv
 i5VX8oP8TJ76+K8dIwt+vzlrUOc/CO0zthtMpVEVmesZgFN+t7IZF16yAQQ5mpLmDN9n4zwihl6GH
 7SfnEBoQitdeNPC0JPT4PGaKlDxpThus/zciail30I5g+76sWr0FPDf1MTn4YH7u0NN7Dw3z8CvHZ
 IuXtrENCCQ9NQzJHHL5iTN50ay0yh/doZau8EV2XjIUpbgPUFZezqjYWahajufjHr6+zcPc2R4RoF
 zxx6+5kahfQYeamclVJvU/9fcdCctHd6Ng+uH4zCn1l8VdKhaAyIeXQvO4vzyaK9ffTqXPoPJvLlV
 xREZ8VWw==;
Received: from [187.36.208.132] (helo=[192.168.1.221])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wotjg-007FxT-Pl; Wed, 29 Jul 2026 04:09:33 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Tue, 28 Jul 2026 23:09:22 -0300
Subject: [PATCH 1/2] drm/v3d: Serialize the scheduler timeout handlers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260728-v3d-order-global-reset-v1-1-e47be838158d@igalia.com>
References: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
In-Reply-To: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4500; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=mvkDmENKkzMG7HAEyLpHGVbvh1tZiWqOAvXRePvaT3c=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqaWDXL5b2fX6Q7OB/SKwJVY9PnoKNSu/ReW9/g
 92X0YBxoZWJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCamlg1wAKCRA/8w6Kdoj6
 qpGpCACJ7DeYJ+QQrY+Z7qfC1F9MEBIZWSszpVW+V8djwMUQu6Bqm3+1iSpgLx1mdDX6QRokPfb
 sJefJndVThcCLv6Dmz+2u/DFku6m83Q21A/Le1Z2PUz4TxnasaLiOnisLgokFe039w6oVrS0SYx
 ZnZP+POtlwdHJgDcG51tarfRgex/LUIacvqYyojkWWLM2Q6QPYJVxo1X4WuD87w4IXvxtS2nKTk
 yatbRP3UoqkikKrTXYkYVlO+7X1JUhDM7gUFrOKBdwCE8jb51cFyPR3ZWW1+RxlendoHY5jiSAP
 EOyu2Cr8UJeXE2FFy8oHPFkDl4VIdvyWYAI7IZwrL1n7rttv
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

V3D exposes several independent hardware queues (BIN, RENDER, TFU and
CSD) but has only a single, global reset. A timeout on any one queue
therefore has to stop, reset and restart the schedulers of every other
queue as well. That makes concurrent timeout handlers unsafe.

`reset_lock` was never able to make them safe, as a driver-side lock can
only cover the driver's &drm_sched_backend_ops.timedout_job callback.
The scheduler handles the timed out job and its pending list around that
callback, outside of the driver's control, so a global reset triggered
by one queue can still interfere with another queue that is in the
middle of handling a timeout of its own.

Consequently, if a reset happens in the CSD queue while a CL-intensive
application is running, the global reset stops and restarts the CL
queue's scheduler while that queue is handling a timeout of its own. As
drm_sched_stop() and drm_sched_start() subtract and add the credits of
every job sitting on the pending list of the scheduler they are called
on, and as the CL queue's handler concurrently takes its job off that
same list and puts it back, the stop and the start no longer see the
same set of jobs. The CL queue is left with more credits in flight than
its limit:

[  327.302739] ------------[ cut here ]------------
[  327.302744] WARNING: CPU: 2 PID: 43 at drivers/gpu/drm/scheduler/sched_main.c:102 drm_sched_run_job_work+0x238/0x4d0 [gpu_sched]
[  327.302884] CPU: 2 UID: 0 PID: 43 Comm: kworker/u16:1 Not tainted 6.18.39-v8-16k+ #3 PREEMPT
[  327.302889] Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
[  327.302893] Workqueue: v3d_bin drm_sched_run_job_work [gpu_sched]
[  327.302984] Call trace:
[  327.302987]  drm_sched_run_job_work+0x238/0x4d0 [gpu_sched] (P)
[  327.302997]  process_scheduled_works+0x180/0x3d0
[  327.303010]  worker_thread+0x268/0x3e8
[  327.303016]  kthread+0x140/0x250
[  327.303022]  ret_from_fork+0x10/0x20
[  327.303031] ---[ end trace 0000000000000000 ]---

From that point on, the credit count of the CL queue is broken, causing
a complete GPU hang and UI freeze.

The DRM scheduler already provides a mechanism to serialize the timeout
handlers of different schedulers: an ordered workqueue passed as
drm_sched_init()'s @timeout_wq parameter. By default, each scheduler
queues its timeout work on the system workqueue, which runs the handlers
concurrently. Give all of the queues a shared ordered workqueue instead,
as recommended by the DRM scheduler documentation for hardware that has
distinct queues but resets globally.

Cc: stable@vger.kernel.org # 6.15
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h   | 6 ++++++
 drivers/gpu/drm/v3d/v3d_sched.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 423bcfe331a0..8779a42c6508 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -182,6 +182,12 @@ struct v3d_dev {
 	 */
 	struct mutex reset_lock;
 
+	/* Ordered workqueue shared by every queue's scheduler timeout work.
+	 * V3D reset is global to all queues, so the timeout handlers must not
+	 * run concurrently.
+	 */
+	struct workqueue_struct *reset_wq;
+
 	/* Lock taken when creating and pushing the GPU scheduler
 	 * jobs, to keep the sched-fence seqnos in order.
 	 */
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index c35f9f70cf8d..63dd95b828c8 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -837,6 +837,7 @@ v3d_queue_sched_init(struct v3d_dev *v3d, const struct drm_sched_backend_ops *op
 	struct drm_sched_init_args args = {
 		.credit_limit = 1,
 		.timeout = msecs_to_jiffies(500),
+		.timeout_wq = v3d->reset_wq,
 		.dev = v3d->drm.dev,
 	};
 
@@ -851,9 +852,13 @@ v3d_sched_init(struct v3d_dev *v3d)
 {
 	int ret;
 
+	v3d->reset_wq = alloc_ordered_workqueue("v3d_reset", 0);
+	if (!v3d->reset_wq)
+		return -ENOMEM;
+
 	ret = v3d_queue_sched_init(v3d, &v3d_bin_sched_ops, V3D_BIN, "v3d_bin");
 	if (ret)
-		return ret;
+		goto fail;
 
 	ret = v3d_queue_sched_init(v3d, &v3d_render_sched_ops, V3D_RENDER,
 				   "v3d_render");
@@ -896,4 +901,6 @@ v3d_sched_fini(struct v3d_dev *v3d)
 		if (v3d->queue[q].sched.ready)
 			drm_sched_fini(&v3d->queue[q].sched);
 	}
+
+	destroy_workqueue(v3d->reset_wq);
 }

-- 
2.55.0

