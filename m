Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6C0CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF78210E43B;
	Sun, 10 May 2026 22:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ksCEYLYj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4CE10E435
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m0h8XH6X2iYAEsxkPdoUPPkoiVsHuV40CK3jZ7XIWY0=; b=ksCEYLYj54Q1rncAheQsEgrqCh
 XYcJv/faF1Jua8ED4uu6c/S4ikDbxcaEmj03P/oHSPh0kLBuou0IuAbr2FLRDX+E8wiTtwY5ylGAa
 HkEiTmCAyh6k1Z1ZIXhFyccTHZbHsYYtWZedokUrONqXwzYcDoWUUO1mbBzCyyJ7HFfGcXJviKtRv
 +oxU2QCHmfrKlpqIiuscqRAi/GF2ObNOeJqDSxxw/UwUxKX82OwZG6Qp2QXj+WdAUszmy6GysGNuU
 kzb+fm0WS56n2EbUGC0dKJpKDDYEh1bZUcNkr1GYxkOBPfD5dcyqvm7ZhPQtzlsgtPluFKbEfHTMa
 oRrwlYbQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCNr-008k1J-UK; Mon, 11 May 2026 00:12:23 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:00 -0300
Subject: [PATCH v2 03/14] drm/v3d: Use inline lock for dma fence initialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-3-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Rn+Xcf9CduGJKlh8cWPR/XvfoQKOGtujoD06rJe2cwE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK0hM3k1H3MgMVN8+TCpqfU3U0+i+OGW8qEU
 vV8gsN2WzeJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 qlIoB/0SlxM/qbyMvhvfgFX1gZFGygOdAKqlSEBWciB9f2fg9Gmpn2OPhTgeJXu2MKLHJdte/QB
 bJv/r+92PIyAykKOVZ8w0jm6jYIv1rhN8aGrv+YQjPSGF6CDiD7P11EH3Ws1OQW4rDs1VzXiMur
 vPnri5BMJV1yVDvihpeXJGFiOhycRLbNfNg4paoFpGqvKc17XRvkDgUUhIDRjGmACRbuZKjtLFP
 VXpisYLGik/igkRrpRhMc0SGbg+DG2gnILT/q/wENQKJ/a2oSxSBs3pq2Nq+TafKRc05QAtOOiM
 t1m49KDR7jOYJxxB4TX30FT/wCFFBV2iWAXIhepJyahjYXwf
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
queue_lock to use spin_(un)lock() in all its uses instead of
spin_(un)lock_irqsave().

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
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
2.54.0

