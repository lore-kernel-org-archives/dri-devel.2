Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743ECCD37B7
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 742F410E618;
	Sun, 10 May 2026 10:07:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="OpZ2kqe1";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D9410E09C
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:MIME-Version:From:To:Subject:
 Message-ID:Date; bh=2bZWS7uJuE4xGLrY8DcRtxtEoAxGXioWLO6qqxg7ikw=;
 b=OpZ2kqe1QGguTne0u5uh5ocBkWXPvP4aWQwUody/xWBXWl3xK7JIAU3Uzh1pjC
 lpm00P2bUly55h66qMc0X6zKYPz1zm62hyIDIgZa1JUnT1SkFFp7sFdBdlo6yp36
 AETWBUiHqMA2/3O6nzxSX3Gthu6c0R57EX45CGCIGB9tI=
Received: from [127.0.1.1] (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3hNt28f5pKElvAQ--.45179S2; 
 Sat, 09 May 2026 16:33:59 +0800 (CST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Jiaqi <shijiaqi_develop@163.com>
To: dri-devel@lists.freedesktop.org
Cc: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] drm/rockchip: Fix leaked vblank event in
 vop_crtc_atomic_disable()
Message-ID: <177831563850.322716.2488834570802720729@163.com>
Date: Sat, 09 May 2026 16:33:58 +0800
In-Reply-To: <177831560568.322716.7926332149561323511@163.com>
References: <177831560568.322716.7926332149561323511@163.com>
X-CM-TRANSID: _____wD3hNt28f5pKElvAQ--.45179S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw15Ww1UKF13Cry8Ar1DJrb_yoW8AF1xpr
 s3G34Yvr40qFWjv3Z8Jr4vyFWfuw4Iv397Cr9rG343Z3Z3Krn8X3W8Cr93ZF45XrsrJa17
 Z393JryUZF18ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUfHbUUUUU=
X-Originating-IP: [42.63.126.112]
X-CM-SenderInfo: xvklyxpdtlsvxhyhz0rs6rljoofrz/xtbCzRezB2n+8XcnlAAA3M
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

In vop_crtc_atomic_disable(), there is a WARN_ON(vop->event) that warns
when an event is pending, but the event is never actually handled.

When vop_crtc_atomic_flush() has been called, it moves crtc->state->event
to vop->event and calls drm_crtc_vblank_get(). If atomic_disable() is
called before the vblank IRQ fires (e.g., due to a modeset or CRTC
disable), vop->event remains set but is never sent to userspace. This
means:

1. Userspace waits forever for the flip completion event, causing a hang.
2. The vblank reference acquired in atomic_flush() is never released,
   leaking the vblank reference count.

Fix by sending the pending event and releasing the vblank reference when
atomic_disable() detects a pending vop->event, matching the behavior
in vop_handle_vblank().

Signed-off-by: Jiaqi <shijiaqi_develop@163.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 8afabe2118a9..1234567890ab 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -700,7 +700,16 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct vop *vop = to_vop(crtc);

-	WARN_ON(vop->event);
+	if (vop->event) {
+		WARN_ON(1);
+		spin_lock_irq(&crtc->dev->event_lock);
+		drm_crtc_send_vblank_event(crtc, vop->event);
+		spin_unlock_irq(&crtc->dev->event_lock);
+		drm_crtc_vblank_put(crtc);
+		vop->event = NULL;
+	}

 	if (crtc->state->self_refresh_active)
 		rockchip_drm_set_win_enabled(crtc, false);
-- 
2.40.0

