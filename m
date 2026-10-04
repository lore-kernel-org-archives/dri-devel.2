Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1C7CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 762BA10E04F;
	Sun,  4 Oct 2026 15:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="G/FhnMeQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC1D10E0F1
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=O3A0/hZA3eP1vShgDl2OQXZSmjkwJUaSn0OOcDnWYX0=; b=G/FhnMeQHTpwoCpwbqj7ZyEJV2
 Y+ZH4abK547bnkvX/r8bHm4+NfTjaVXWpY+2wR5CZ9kUMPYniz+1BOPP0vtjMFm9mFcMNnrTCTC0b
 47GMKaxfdFVSjYex8wXMhV99bno/Um3T/yEkvtkuRUivck62woXpiHQBqntHsPH8OnYqQzhRmcRHq
 YQUTiDQJCd11Jx8FfFWhgBNsDBpmvDwXnt4pKWPr3JZtxljgl0+6cufjvq2dH3uSXu/eqnKi/Js5S
 +v4MkDdybC3lhwOhBCBmkubA6Xkb/5ynyIuMow3xdd6PtjejCY4U5zuyGedp/poFfyn8tYILZSMJ8
 vp3WY20w==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOM2-00BNsh-6R; Sun, 04 Oct 2026 17:42:22 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:01 -0300
Subject: [PATCH 01/11] drm/vc4: Publish the output fence outside of
 job_lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-1-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=2pG2I/lFnTQJeYLmCrcvedIba8zhyzU2yxVUVrTTuwQ=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPWHkU8+hYCvAVHbPSnPjF0JmAryFUqg1eRK
 GUB/EXL1deJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1gAKCRA/8w6Kdoj6
 quxkCACsbTeCd1ilPlXvSP23XMbSykS2IZGVppgroy27dZCdIxaou2AXpwbCoAtTvzmT/upsrdp
 qO6Kv/3XstCHClMu3+GgbxnHK0byxm5GMJrFQKAZKsi6Na04kXxL6pZKiNJ2Dc0gE3FDg2QADvP
 XXyHD1mkC68tkjKtDgtvfnm+oifAnIQu6YxmXaRTqvRbXc1qAY/f/HXo1/sPkUxtG6VHUH5Rii3
 LKLAByMWvN+x1Wh/KIFHEhPIXuoNMt6CQGkDVpmEeHe0w12yry0rya55CT8KHHGkeInyDkD7XV/
 4QL+/5A1XXNeYZJaaVrX9pbGfuQuqzsUGdR50In/e/+BYwnP
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

job_lock is taken by the V3D interrupt handler, so nesting an IRQ-unsafe
lock under it creates an inversion. drm_syncobj_replace_fence() takes
drm_syncobj::lock, which other paths acquire with interrupts enabled. For
example, a thread interrupted while holding it blocks the handler on
job_lock, and the handler can only make progress once the submit path
releases job_lock, which it cannot do while waiting for drm_syncobj::lock.

This is reported by lockdep:

[  188.139076] ========================================================
[  188.139086] WARNING: possible irq lock inversion dependency detected
[  188.139096] 7.3.0-rc3-00067-gc4f3feeaf60f #67 Tainted: G         C
[  188.139108] --------------------------------------------------------
[  188.139116] swapper/0/0 just changed the state of lock:
[  188.139125] ffff0000054f8ff8 (&vc4->job_lock){-...}-{3:3}, at: vc4_irq+0xa8/0x28c [vc4]
[  188.139234] but this lock took another, HARDIRQ-unsafe lock in the past:
[  188.139242]  (&syncobj->lock){+.+.}-{3:3}
[  188.139256] and interrupts could create inverse lock ordering between them.
[  188.139267] other info that might help us debug this:
[  188.139275]  Possible interrupt unsafe locking scenario:
[  188.139284]        CPU0                    CPU1
[  188.139291]        ----                    ----
[  188.139299]   lock(&syncobj->lock);
[  188.139312]                                local_irq_disable();
[  188.139320]                                lock(&vc4->job_lock);
[  188.139335]                                lock(&syncobj->lock);
[  188.139350]   <Interrupt>
[  188.139358]     lock(&vc4->job_lock);
[  188.139372] *** DEADLOCK ***

Hand the fence over after job_lock is dropped. The job can complete and
drop exec->fence in that window, so take a reference first and publish
through the local pointer, as exec may already be gone.

Fixes: e84fcb95e074 ("drm/vc4: Export fence through syncobj")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 6ee4bd77d433..f4be154d4eb0 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -639,8 +639,11 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 	fence->seqno = exec->seqno;
 	exec->fence = &fence->base;
 
+	/* The job can complete and drop exec->fence as soon as job_lock is
+	 * released, so hold our own reference.
+	 */
 	if (out_sync)
-		drm_syncobj_replace_fence(out_sync, exec->fence);
+		dma_fence_get(&fence->base);
 
 	vc4_attach_fences(exec);
 
@@ -662,6 +665,11 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 
+	if (out_sync) {
+		drm_syncobj_replace_fence(out_sync, &fence->base);
+		dma_fence_put(&fence->base);
+	}
+
 	return 0;
 }
 

-- 
2.55.0

