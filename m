Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D5F34C5C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5007210E4B7;
	Mon, 13 Apr 2026 15:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rVBJ1VdR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE7810E4B7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Aa08IHitC1bF9z036ArZ/9wZYdwz05hdGMX19GUgb2w=; b=rVBJ1VdRwSq+ykjbrsy/Gn/5vt
 gVl03/jm5TU8qJsPb1ISgU+pV7TebW9cYOwk7PucT1euPGV95sEch0rbHjyVVN9YMvSPG2BtsZuky
 j9U2vSfVdgRS6pugJolTyBiC8HOcoVXLpMCfWiw2pvf17igIDaIW4F9cJlD/Kz+w0F+Kp0b0o3KJ6
 o0DYo396AQB0OvFrc36qBfTfHx/cpfQvI5Qt74ppUzG0dtyBtzTUp/eM6ucph/Ge1x8vnvLs6IQmZ
 j4wPfv0JrG7YcbRUQaciBcTkt5DaLHUzA6EgF0xyZKJScw50/0JXcwfuwkDjeQBPF5ufEyWXsJN7v
 AlpdTKIQ==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIr2-00FSq1-C2; Mon, 13 Apr 2026 17:05:36 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:18 -0300
Subject: [PATCH 03/10] drm/v3d: Use inline lock for dma fence
 initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-3-bac63a8ceb6c@igalia.com>
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=2bYFA9W8CGZ3DxG+wn1lKDoSZ5x0dDHhTbaszZfRSFY=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYtBF8vpW1sXP6TQ1Xs46ltQih2QlG7IJEx8
 Xrb/vYKfruJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLQAKCRA/8w6Kdoj6
 qpdVCACy464oManrHp3HgdcgQOrWDD11Rf7KTCLioWAyDU4yv8LTzywRVq/kkIRV+xnAMRZy6z5
 W6kg0E/CXoElYiA1y6VpjiAzUmOYeelj6U4kRC0ETwuF4BTHgH56bOFAcv5Ab3Rn5ganTRHVSFE
 Qp3bjSD2A3ZMDM892zJLry3kJQGMa/hHoThx54wfsnuARo/KWJLFGdA57Np3BEGyTeCissZvZNZ
 34DQwyXa5lJ9x6pCBKd48PV10IbPB7EvSIxltx5Aci2hFBJtVbG7VD74HVtXHA3GoOo3cOeDmKR
 kLGisQzjG5mjuApaw8wDBBhwcdhbbuovkk5fA59qQKrU74Li
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

Since commit 1f32f310a13c ("dma-buf: inline spinlock for fence protection
v5"), dma_fence_init() accepts a NULL external lock and will fall back to
an inline spinlock embedded in the fence itself. The embedded spinlock
allows the decoupling the lock and the fence lifetime.

Pass NULL so each v3d fence uses its own inline lock. This will allow
queue_lock to use spin_(un)lock_irq() in all its uses instead of
spin_(un)lock_irqsave().

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fence.c
index c500136d0455..9b1a882a4c15 100644
--- a/drivers/gpu/drm/v3d/v3d_fence.c
+++ b/drivers/gpu/drm/v3d/v3d_fence.c
@@ -15,7 +15,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d, enum v3d_queue q)
 	fence->dev = &v3d->drm;
 	fence->queue = q;
 	fence->seqno = ++queue->emit_seqno;
-	dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
+	dma_fence_init(&fence->base, &v3d_fence_ops, NULL,
 		       queue->fence_context, fence->seqno);
 
 	return &fence->base;

-- 
2.53.0

