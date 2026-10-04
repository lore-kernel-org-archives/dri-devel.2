Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B74CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FAF10E96F;
	Sun,  4 Oct 2026 15:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Kk7oWwcO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E41BD10E96F
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=Yhy+FH8J31MnwKO6m1IHj5SGpY0qbx4cewtMUEdLMeM=; b=Kk7oWwcOVNTDI/Nf600WNuLr4B
 mRNBo1IRK2lGkmG/uajGW8GgQu6exr+8wPs3ZXq6zXgtwUujV1g3UNGbikR2Yz5nc7Sa/QSza+qON
 mLGVnEHVQKrHCNTob6Pg2ZKCV/VAJE8EJ735jUYaANzDYUGUYseUDTgw1e/wfBcHUqxC3l1UxaPU2
 qbQnNLIn6Q2WU6vteEfXp879ODD5T1qE7TzQWtuCYUoSQRAcMDofaHHb95VtiV7CWq6NfGLVn+iMH
 4y71FhRhyvaLMxfra33LSnWMXnmWVul+VIdpvPtBQPjEf34VkHkgRpmHZpkh+kDh/51X6K0bG7BTY
 U87bmVYw==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMI-00BNsh-Gc; Sun, 04 Oct 2026 17:42:38 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:06 -0300
Subject: [PATCH 06/11] drm/vc4: Use the inline fence lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-6-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1693; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=3s+187/jy6pzBIn9MFPQOokVEz57GlhG9Xe8lg35GV4=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPXNmAsIxCsSOjLl+YmPYmmTc6rMY9wX9ZJa
 hondBlALoGJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1wAKCRA/8w6Kdoj6
 qjV8CAC3lHRinbug012tPWPdVHmllfOZDUADy/OlbvJq+drOSAnBi+Wl++Sd+cToztQ6PzgmCOY
 ZUCc6dlKn7gDp9CpFJv5opBvTkX4f74JzTdtScBbtdydaL3g9PvAEOv2dBY1ZXAKdWuW5W8UWXd
 0Gf69lIFlc6vRs4g7UUdlwTXNcC8M+1FfmfUpdib8wIVXDKHs6zwPEU8YbU4bhAMS6QiaFs3UtP
 boJDe69m3O4Y7IFWgimvX+b/5QS+GC1WvXAG3dy050PPB9xg5/FIoN9FbIS6pxau7TlIJLNVCT6
 069H/2kt6hID9BkYvY8k0ccxs5UHWlNIj1grKDZwZkCkIDjW
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

Passing job_lock to dma_fence_init() ties every fence to a lock embedded
in vc4_dev. A fence attached to an exported BO's reservation can be held
by another driver after vc4 is gone, leaving fence->lock dangling, and it
pulls DRM core paths such as dma_fence_add_callback() into the lock that
serialises the job queues.

Take a NULL lock in dma_fence_init() and give it a lock of its own, which
is what the external lock has been deprecated in favour of.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 2 +-
 drivers/gpu/drm/vc4/vc4_irq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index ae76868663ea..b65b3f62b098 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -632,7 +632,7 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	exec->seqno = ++vc4->emit_seqno;
 
-	dma_fence_init(&fence->base, &vc4_fence_ops, &vc4->job_lock,
+	dma_fence_init(&fence->base, &vc4_fence_ops, NULL,
 		       vc4->dma_fence_context, exec->seqno);
 	fence->seqno = exec->seqno;
 	exec->fence = &fence->base;
diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
index 241249b6582b..f87550f3e55d 100644
--- a/drivers/gpu/drm/vc4/vc4_irq.c
+++ b/drivers/gpu/drm/vc4/vc4_irq.c
@@ -194,7 +194,7 @@ vc4_irq_finish_render_job(struct drm_device *dev)
 		vc4_submit_next_bin_job(dev);
 
 	if (exec->fence)
-		dma_fence_signal_locked(exec->fence);
+		dma_fence_signal(exec->fence);
 
 	wake_up_all(&vc4->job_wait_queue);
 	schedule_work(&vc4->job_done_work);

-- 
2.55.0

