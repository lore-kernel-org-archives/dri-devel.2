Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC35CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DC010E14D;
	Sun,  4 Oct 2026 15:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="L2Ell8YS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714F710E0F4
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=5Aj0P0Hp5/AS/coYaisBYU6+vFkHvPxSeRmmCuf1XBc=; b=L2Ell8YS53X1JhbFVB7LZyXtl1
 8ghK/PJK2NIjgXo+gAFFgiKrdjXQWGwGsvUXNZ/ZGAamJ0T/LxfmrI+iW7JGREylBdoCgv6m3i2EJ
 0dR/SPh5yuQmOZE5zwi6SSi+ydbBSgTPRd8emM+ZqQd4ifzPNCGUtmo/PeBoK5qrQIeS1zEe1pzuL
 QrISImTFffLR+IFa+pxyJH8xbRzSrcMxjv/5y2lFsC2DJC+9xldRIklUFWifc9IKBDi2zNvgjE12V
 ZBJNcjRmyUD0vyyZJJcS3dqIBLawIK31FOb25Sfka66hdq23r6WxbcC/GBOTCyZRxBUMFFbvxOdB+
 cbCdR6HQ==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xDOMB-00BNsh-PU; Sun, 04 Oct 2026 17:42:32 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 04 Oct 2026 12:42:04 -0300
Subject: [PATCH 04/11] drm/vc4: Return the seqno of the submitted job
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-vc4-misc-fixes-v1-4-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
In-Reply-To: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
To: Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=hXBlxBJ2uUW8GCY0giKKE/L5DEtm6ORCRzgCFGl4Q5Q=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqwnPXKyAwoUY2z5R2sLQ2gyrbMLz+p0dEsfGin
 LN1IH1RBWKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCasJz1wAKCRA/8w6Kdoj6
 qqApB/9qPWlx0njAKD9mWZnXM0YpD6X8IqNYtcLMU2/AotJ1PX1oDyYQMuJMOAAPvvy3qLYvB4s
 nS6Bbi0fos8tc3FsboprjZP4Lv6TsR7oa1BfAnqEkpTfzFqS5cIAAIAzIDmrhWYU8exHTpse/WU
 Ie/FQ3R/1JYDjsdN7qMuoIkBYvvrku52Uky0wltxwMyC2/GjJ9aWyNtoLAXHFB1lRfpb6LoJD8x
 F0KnMYT1TqUuDP7vFo/LjONcRwEBdOv4r8amebdHB8SHLK3eDsWqKsNZM9/gd2sOXI9nbzZQc/k
 FAzHHqdRgRu/YECcW8dOquGRVrspUpTiVj1k4k2vKSzRBGuz
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

VC4_SUBMIT_CL reports the seqno of the job it queued by re-reading
vc4->emit_seqno once vc4_queue_submit() has returned. That counter is
shared by every submission on the device, so a job queued by another
thread in the meantime bumps it first and the ioctl hands userspace a
seqno belonging to a job it did not submit. Waiting on that seqno means
waiting for unrelated work.

Now that the submit path holds a reference to `exec` until it is done
with the job, report the seqno recorded in it.

Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/vc4/vc4_gem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index b56952bb6b97..9cf343297f83 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -620,7 +620,6 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 {
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	struct vc4_exec_info *renderjob;
-	uint64_t seqno;
 	unsigned long irqflags;
 	struct vc4_fence *fence;
 
@@ -631,8 +630,7 @@ vc4_queue_submit(struct drm_device *dev, struct vc4_exec_info *exec,
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
 
-	seqno = ++vc4->emit_seqno;
-	exec->seqno = seqno;
+	exec->seqno = ++vc4->emit_seqno;
 
 	dma_fence_init(&fence->base, &vc4_fence_ops, &vc4->job_lock,
 		       vc4->dma_fence_context, exec->seqno);
@@ -1170,7 +1168,7 @@ vc4_submit_cl_ioctl(struct drm_device *dev, void *data,
 		goto fail_unreserve;
 
 	/* Return the seqno for our job. */
-	args->seqno = vc4->emit_seqno;
+	args->seqno = exec->seqno;
 
 	vc4_exec_put(exec);
 

-- 
2.55.0

