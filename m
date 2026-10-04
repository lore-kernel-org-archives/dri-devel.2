Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEBBCA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAABC10E1A2;
	Sun,  4 Oct 2026 15:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TbCK3VBn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6892A10E9C2
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=9oDZ5fV0vgEunvhL95o2c0lQ91XFUjN3vEZ4O+zur/I=; b=TbCK3VBnDd05ovQTaZRsWggE2K
 sqMDpIIDtlRCnNRyuMMNg1iZi4SJlWpHIz8tzu3RMfs4i2ulWB7xo8BVZVbRjMSiVIh7ev2TA2jVH
 C8dOi8LR/11u8hSm9o85J45u/M/V3CRUFqrTO+ihHpdFT99AOrOJCvTcpj7l38jc00VaaAq7HfmQj
 LWlolIUfeSXcMmOcHZcBKiPg9IAeMI/atJECFrQwIOuh7gW16zU15bQ+7OEwE4Icju9xVKMRNH/6E
 kDq1N4fma2BWTaUGDnLaiXQeO5WU9C+89i3MS33Rp2qmt4mP3m6ERLqutPDla1o7p+20qSEvWUwML
 5csQN5eQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOML-00BNsh-Uu; Sun, 04 Oct 2026 17:42:42 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:07 -0300
Subject: [PATCH 07/11] drm/vc4: Signal the render fence outside of job_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-7-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=JPRBVrCIkYEp3A6Wp6b10ODTbxZMHKvWKGAirT/RwU4=;
 b=owGbwMvMwMVo/5mvq6zj1yrG02pJDFmHiq+nMJaJXi918ysME0lv9D+/NFuf/+KUW+muXc5i8
 r3LePQ6GY1ZGBi5GGTFFFl+PImtZRQrZ9dcVn4RZhArE8gUBi5OAZhI1XIOhvO8d2yvnX5eInT6
 dhVj/o2/Bp7ZkxfsnMS2q+JH3mQ1SemFjC3sPimsFw8wswr7G6Rf2BfswhuzPTbNlCel6VlXase
 9gr8PTzhelFHriHlsbNoe/EzHfe02uZYdlZW7by9+57FrivWKTFnOOfdvyDeW3gtq+z3/75F3By
 6fPHr1Cveen2nXdnRv5eCvspobX7Tk3PL5cUoXAmyqxZV3X+ZOnufmH3vL2eB4beuyJ/lRt4NTp
 mTPcQ2/ysAcmSSm4n1BN9Ge0+Tn7t4Ul6DmyKkVuubB7v963y0Va1io8a9FeGekcFl6dkEzY/ji
 z9eXPOPml37wfJWzVOsDY9tV0yRLgt5v7/L9/6WFU5sLAA==
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

vc4_irq_finish_render_job() signals the job's fence, wakes the waiters,
and queues the job done work while holding job_lock. This increases the
job_lock contention as dma_fence_signal() takes the fence lock and runs
every callback attached to the fence. So, job_lock is held, with interrupts
disabled, for as long as those callbacks take.

Considering that these functions are unrelated to the job lists, hand the
fence out of the critical section and signal it, wake the waiters and queue
the work once job_lock is dropped.

In order to split the end of the render job and the fence signalling, take
a reference before handing it over, as the job done worker is free to
release the exec as soon as the lock is dropped.

On a Raspberry Pi 3, LOCK_STAT shows this section holding job_lock in
about three quarters of its contentions, showing the relevance of reducing
this critical section.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_irq.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index f87550f3e55d..dcee4a1e17ad 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -152,7 +152,7 @@ vc4_cancel_bin_job(struct drm_device *dev)
 	vc4_submit_next_bin_job(dev);
 }
 
-static void
+static struct dma_fence *
 vc4_irq_finish_render_job(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
@@ -160,7 +160,7 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 	struct vc4_exec_info *nextbin, *nextrender;
 
 	if (!exec)
-		return;
+		return NULL;
 
 	trace_vc4_rcl_end_irq(dev, exec->seqno);
 
@@ -193,8 +193,17 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 	else if (nextbin && nextbin->perfmon != exec->perfmon)
 		vc4_submit_next_bin_job(dev);
 
-	if (exec->fence)
-		dma_fence_signal(exec->fence);
+	return dma_fence_get(exec->fence);
+}
+
+static void
+vc4_irq_render_job_done(struct vc4_dev *vc4, struct dma_fence *fence)
+{
+	if (!fence)
+		return;
+
+	dma_fence_signal(fence);
+	dma_fence_put(fence);
 
 	wake_up_all(&vc4->job_wait_queue);
 	schedule_work(&vc4->job_done_work);
@@ -233,9 +242,13 @@ vc4_irq(int irq, void *arg)
 	}
 
 	if (intctl & V3D_INT_FRDONE) {
+		struct dma_fence *fence;
+
 		spin_lock(&vc4->job_lock);
-		vc4_irq_finish_render_job(dev);
+		fence = vc4_irq_finish_render_job(dev);
 		spin_unlock(&vc4->job_lock);
+
+		vc4_irq_render_job_done(vc4, fence);
 		status = IRQ_HANDLED;
 	}
 
@@ -328,6 +341,7 @@ void vc4_irq_uninstall(struct drm_device *dev)
 void vc4_irq_reset(struct drm_device *dev)
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
+	struct dma_fence *fence;
 	unsigned long irqflags;
 
 	if (WARN_ON_ONCE(vc4->gen > VC4_GEN_4))
@@ -346,6 +360,8 @@ void vc4_irq_reset(struct drm_device *dev)
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 	vc4_cancel_bin_job(dev);
-	vc4_irq_finish_render_job(dev);
+	fence = vc4_irq_finish_render_job(dev);
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
+
+	vc4_irq_render_job_done(vc4, fence);
 }

-- 
2.55.0

