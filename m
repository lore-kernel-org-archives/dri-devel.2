Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3C2CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B792610EE73;
	Thu, 18 Jun 2026 17:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="dVg6jt3S";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="cmdQIVWg";
	dkim-atps=neutral
X-Greylist: delayed 530 seconds by postgrey-1.36 at gabe;
 Thu, 18 Jun 2026 17:39:39 UTC
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD7D510EE73
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 17:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781803655; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=QQ91LeO8Xb0lrPY9jZ7YamoJchPftq5FRmuU3aLkJ7PMMR0kM8CbO1F718wjJ+z/D+
 yd6nYwYXXq45clh+++jCJnk19F9QeuEymHp/qvjog0M0a4IqwLereGGWwEUM/BRaReKp
 skCk4MT68lyPOzlcB/JukB82MXDUzJ4xnu6ZK3Bhp8//ScIyfgrX3PJi5XweA3WdBiPl
 U42InQl4Qx1j7u+ytBPqxejdB6vxvKdxwjyhtADtJKfvaSNXT7cfdeJXgWXmF7wU4Y1U
 9pE+7KMIkokxjT3n2DL/U0YEccTq1eWljnTPM8BEHNUanYDIzJjtJwSyUrf7kydugQGk
 9cmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1781803655;
 s=strato-dkim-0002; d=strato.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=ikiBomanN8IAQPmJ+lR3Eitmcc6sS32szl9hPRzpmYU=;
 b=NQqZ8UD56p8HP1zmPlpB0h+VBpqEOhLCeKyPpk4DmX7ZG+NjfKErzxVS6+j5PIbuXl
 k5D8dESLIC32IKXYPBv22TOKsgPduFa++u0M1lmwEnOKw2iRLpkk0x50VG6RUy239GOJ
 ow8ek2wr+sjvuvUdmRxGRwpqTNbIG2UijFwt9PePP+YnXSBFHv+nXmoUwe0sCqi6AiTm
 xD3dpGkUa5tqQCXnOWdELYrVGZg79u3grh225/cxZKJqcAVKHKaWAsnLyoERuecLCGrx
 yyBzVzgNQWyckMwnyP3hE+/Bo5LzjHGzwrnFJipjrVUHmJKUrm+IWw9Nai6yn9Kf3CB9
 +UAg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1781803655;
 s=strato-dkim-0002; d=goldelico.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=ikiBomanN8IAQPmJ+lR3Eitmcc6sS32szl9hPRzpmYU=;
 b=dVg6jt3Sf68jKf2mx9DPcA+BUMMHunFCJWym+HASUvjjMVdCh/CZLITSvcE5mgrI3Z
 kX6yQoErBL80i6Q19hX+++9tfVPSyuY/AoiRIeQffhUCwN24RZbA6qcsL2jVEgQNiX+7
 jPRYA+WqnUcNn18fJCqHTLrZASHd23JDC7RnjCMT9+fKVnzNMJ3qVdffYdG0hgljMv5s
 UHs+ilmYJTBAgHtbH6O0gcz8lAKFZ9ohaxUxdqv81RyVAjoxTStmjxkmGmaUH+6JksZd
 RFA1OpeR7trIczNy6CFF+RAGs7ZxxilAo6cgIJk9DJWsiJHChRAcTXPz1popo1PScozo
 +jHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1781803655;
 s=strato-dkim-0003; d=goldelico.com;
 h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=ikiBomanN8IAQPmJ+lR3Eitmcc6sS32szl9hPRzpmYU=;
 b=cmdQIVWgfs0DOAj6xNgcozLIf310ePfJ+wbgmr+2L8tR9VU6vbCB3+CgUsDV/b39et
 OWw9HgTgj32yIJp6OqAw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT0ZoOnciNQh0E54wP3opQ+1mzcazh2bvtQoZf"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.0.1 AUTH)
 with ESMTPSA id Qcf97c25IHRYfpA
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 18 Jun 2026 19:27:34 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
 akemnade@kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] drm/fb_helper: Determine proper crtc_index within
 drm_fb_helper_fb_dirty
Date: Thu, 18 Jun 2026 19:27:18 +0200
Message-ID: <5118b37e579cec220f2d2b6ab0bb1ecfb67f0d5c.1781803617.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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

The call to drm_client_modeset_wait_for_vblank() currently hardcodes the
crtc_index to 0. This is incorrect when CRTC 0 is inactive and not
generating vblank interrupts.

When this occurs, the console is flooded with vblank timeout warnings:

[   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at drm_crtc_wait_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
[   77.201354] omapdrm omapdrm.0: [drm] vblank wait timed out on crtc 0

This behavior was observed on a PandaBoard-ES when only the HDMI port
(CRTC 1) is connected, while the LCD (CRTC 0) and DVI port (CRTC 2)
remain disconnected. The root cause is the hardcoded crtc_index = 0.

Fix this by locating the matching CRTCs. If multiple CRTCs match, the
last active one is selected. If no matching CRTC is found, the vblank
wait is skipped entirely.

Fixes: d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with vblank")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 1541fc8a9ac2d..70999cdc98b32 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -232,9 +232,23 @@ static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
 	struct drm_clip_rect clip_copy;
 	unsigned long flags;
 	int ret;
+	unsigned int crtc_index = 0;
+	struct drm_crtc *crtc;
 
 	mutex_lock(&helper->lock);
-	drm_client_modeset_wait_for_vblank(&helper->client, 0);
+
+	drm_for_each_crtc(crtc, dev) {
+		if (crtc->primary && crtc->primary->state &&
+		    crtc->primary->state->fb == helper->fb &&
+		    crtc->state && crtc->state->active) {
+			crtc_index = drm_crtc_index(crtc) + 1;
+			break;
+		}
+	}
+
+	if (crtc_index > 0)
+		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index - 1);
+
 	mutex_unlock(&helper->lock);
 
 	if (drm_WARN_ON_ONCE(dev, !helper->funcs->fb_dirty))
-- 
2.50.1 (Apple Git-155)

