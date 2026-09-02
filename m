Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B352C624D7
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5B2010E083;
	Wed,  2 Sep 2026 22:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mrFm7/mN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC7410ED63
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788389654;
 bh=YV4r8T3ojzOgJhZGbuAEwdatFZPup5YHCOGLl5x/T6E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mrFm7/mN0JwAAeta/LghL0JBsHJLcMeQwwUeJ0EVfdlCO9lUomKvRdiK0PhNHaUpB
 DRTzNVI7CUGig9f6bc7fRNn3RqznloydqPI9HBmtLcSOpCjBUP436PTbNoGAKp9PL8
 eMsE2zB8wX5UPJwW9/Rr3UWSeoBDU7la0cr7qa7G9I3a8sY1euBDhlNv+zrilhy8xL
 0Mlr7qAnqO5TeKvn6rwR49FwaUaruJawNCCjqY0XeRLy8PF9/hMejDJGK7Onml39pH
 gbLG4/KRosipSHKeWti+0K15uSC8wBXu2jUCd4Rk/N7NAS+ajNte8TNW/X9bgT4Q/S
 JRQCmm292A5AA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 90DFC17E0EB0;
 Thu, 03 Sep 2026 00:54:14 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 03 Sep 2026 01:54:11 +0300
Subject: [PATCH v4 04/14] drm/rockchip: vop2: Send pending event when
 atomic_enable() fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dw-hdmi-qp-yuv-v4-4-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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

vop2_crtc_atomic_flush() stashes the CRTC completion event in vp->event
and relies on the frame start interrupt (VP_INT_FS_FIELD) to deliver it
later via drm_crtc_send_vblank_event().  Since atomic_enable() runs
before atomic_flush(), bailing on an error path makes it skip
drm_crtc_vblank_on() and leave the video port disabled.  atomic_flush()
still traps the event in vp->event, but since the port never scans out,
the frame start interrupt does not fire and the event is not delivered.
Userspace waiting for the flip completion then blocks indefinitely.

Note the event cannot be flushed from atomic_disable(), as userspace
waits for the completion before committing the next state, so the
disable does not arrive and draining it there would deadlock.

Use the newly added vp->enabled flag to detect this in atomic_flush()
and send the event immediately when the port did not come up, rather
than deferring it to an interrupt that will never occur.  This also
avoids the spurious drm_crtc_vblank_get() WARN previously hit on the
failed enable path, where the vblank is not on.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260706194935.AC7601F000E9@smtp.kernel.org/
Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 060f9395a235..8755b614df34 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2083,8 +2083,19 @@ static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
 	spin_lock_irq(&crtc->dev->event_lock);
 
 	if (crtc->state->event) {
-		WARN_ON(drm_crtc_vblank_get(crtc));
-		vp->event = crtc->state->event;
+		/*
+		 * A failed atomic_enable() leaves the video port disabled with
+		 * no scanout, so the frame start interrupt that normally
+		 * delivers vp->event never fires. Send the event right away in
+		 * that case to avoid stalling the flip completion.
+		 */
+		if (vp->enabled) {
+			WARN_ON(drm_crtc_vblank_get(crtc));
+			vp->event = crtc->state->event;
+		} else {
+			drm_crtc_send_vblank_event(crtc, crtc->state->event);
+		}
+
 		crtc->state->event = NULL;
 	}
 

-- 
2.55.0

