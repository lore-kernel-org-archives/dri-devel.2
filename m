Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E38C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 03:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF0A10F141;
	Fri, 31 Jul 2026 03:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tBebLptQ";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC4310F141
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 03:50:27 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84861fc51f5so407909b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 20:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785469827; x=1786074627; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J245gh4rq4b/rI+J3aFk9DcyIuY7iQE2e75oLHyF5B0=;
 b=tBebLptQ4K8WQ9OpswzWL+PQhliP4AfFscNY1B8C/Z6b9r2gO68PAoUjNXcNbvn9ZC
 D60DNYoS7I4KRExGpwt0/oTx7oP59O6mvA3YzxMGv1JnsSH9vGzX9RqMtlhPFFljBmwi
 JKr6RQqO9WrBH4A6MKMUWegxeyUtPILR+QnMDqqZkzXE7QAR0gCedNsGf3RrF/zgP7hu
 ydRl8jIwaFUO0x+ZKafv7lAoz1pVOYIFH3tWKUc6rjZYd2GPl/tR6qJWfAFOzrJbNKx0
 N35RX+QeyxJ9OOOJbWoyIPvsd2o5wvixXgPPMEXR5k04sGKw+dpLLBXJUv5udoJo6wdG
 PKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785469827; x=1786074627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J245gh4rq4b/rI+J3aFk9DcyIuY7iQE2e75oLHyF5B0=;
 b=o1l2PF3TVmuR4pXo9sIuxUA2rSb9uA3MM1kYq/77mXKFCI5G8ufQMZQaENFcFTVU3q
 KlJ9NeujGdPzI2bXOhdSwPlIsgLuVZSvrzL9RIGW1dyR+FS4WvUglgGfX4w+nzgO8Akh
 fYpdhRwBu3o+FbEoTimQYZD0SDANYyYmX9/ymGxBrYN5mYKyzaqr7oF9x7TpjI2v0DmX
 vsiqLDcUEm/ctDB6pt9DlAXNsMGEWLxF2HM/ih/CdIeTPRkh6f1O9KQzWFp+fRjOQV0n
 HIIqNNMfH2z87MCwTfM+PVfrWnANiAKBMi61dXo3K16eJ5QQkhyrDj8wJ009hCqKx1Ep
 K0mg==
X-Gm-Message-State: AOJu0YzRlEcW3WQ2yEzhAc89oHiGFzFkrpjoEVfo0Frr0CbdVYBKCgBW
 4fYtckKyPG/YGakYoq7cc4SnHuZSu5kQyvel4psUxe0qDKiMedqejmCD
X-Gm-Gg: AR+sD11y024Rfa6ggGwtyOCwbvrxWq7AQlMGoqvWM/Mz1L+3Sq2ngOZQaRr8h9fa4Cx
 siYVBmg9L5zMqexCOOkWjN07kMWfMHGzuyX7xzgZhCKKvaXeM2+iDWskKUZKoVsApy8Wh3v5z2N
 JGI4I9UT0XiJpgNKNYSr8RAkEBGKRO2ALo2Ta4xMEQ6GdqCXaB1FQZKvNoCwSrwidpQ3qq664Lu
 Yz1CRgItW/hxTNSsPyh6mcUtEqXHo5M20VhqUOV5uSA3cVx2/vNRxiycWENW/CjiHATKFNki1Jl
 Yxj17Wikof5oJDHmkxBj92lTrIRGLBHCfdnhIBTDQlDlyl2Tnhsqs2Yc89yXRM/C07pPvRQyF20
 H2BO+2+SCwhoEVeaOtQsOGNx6/AhyX4B6BNt5xy0Jclywmr7jUDm22hn1CEN6RiB/am8d0vYJwy
 BoVNfgu+pCVmdHBNsJLqHmZQ7Dnkd6PXk9oZAcwVS17Ek522/x14io8G/SWgjfGDZY+SeVh5Ji4
 WmoLnQFTbPiF2GkZLzIPLiFaOZkrh9GdaXPIHCR+WU7D0iSYV2A5fMnB9s=
X-Received: by 2002:a05:6a00:4518:b0:848:498b:e0d4 with SMTP id
 d2e1a72fcca58-84ed714d8fdmr326002b3a.38.1785469826687; 
 Thu, 30 Jul 2026 20:50:26 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57cdc73sm175536b3a.17.2026.07.30.20.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 20:50:26 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Fri, 31 Jul 2026 11:50:14 +0800
Subject: [PATCH 3/3] drm/tiny: ssd16xx: reject rotation changes without a
 matching mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-ssd16xx-pixpaper-rpi5-v1-3-18ffc0dbf59a@gmail.com>
References: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
In-Reply-To: <20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com>
To: Devarsh Thakkar <devarsht@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Wig Cheng <onlywig@gmail.com>, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785469814; l=2882;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=zRDUioZAVja4enGd4e+L5mlIFRB22prnDPYk8BYQg+o=;
 b=GBjaWRSQ3clKFBWceXVg7u+IKiNQ2/+zZC+kPa/VP225wiITbwkC5K+wMXGSuSI90yktG/i48
 Yup8u4SoZpSAC/do1TTHtkFOslpj3axRQVg4DHjF02gMdi9HUs4wm18
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

Portrait orientations are implemented by packing the framebuffer
column-major into the same physical RAM layout, so they need the
transposed mode that ssd16xx_connector_get_modes() reports, and a
framebuffer to match.

Setting the rotation property to 90 or 270 on its own provides neither:
the client keeps the mode and framebuffer it had while the driver switches
to portrait packing, and the result is displayed as garbage.  Nothing
reports an error, and data_size is identical either way so no size check
catches it.

Reject the combination in the CRTC atomic check, so userspace gets -EINVAL
and can re-probe and do a full modeset instead.  Rotation set through the
DT "rotation" property is unaffected, since probe() swaps the mode
dimensions before the connector is registered.

Tested on a Mayqueen PIXPAPER 4.26m (SSD1677, 800x480): rotation 90 at
runtime now fails with -EINVAL instead of corrupting the display, 180 still
applies, and DT rotation = <90> still comes up as 480x800.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/ssd16xx.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ssd16xx.c b/drivers/gpu/drm/tiny/ssd16xx.c
index d311720bbfbe0dd288dbd588be02c79b5eab3eab..1224a3d4ce2cbe70406dfa6e550fc85a2ea62682 100644
--- a/drivers/gpu/drm/tiny/ssd16xx.c
+++ b/drivers/gpu/drm/tiny/ssd16xx.c
@@ -1730,6 +1730,40 @@ static enum drm_mode_status ssd16xx_crtc_mode_valid(struct drm_crtc *crtc,
 static int ssd16xx_crtc_atomic_check(struct drm_crtc *crtc,
 				     struct drm_atomic_commit *state)
 {
+	struct ssd16xx_device *device = crtc_to_ssd16xx_device(crtc);
+	struct drm_crtc_state *new_crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_connector_state *new_conn_state;
+	unsigned int orientation;
+	bool want_portrait, mode_is_portrait;
+
+	if (!new_crtc_state->enable)
+		return 0;
+
+	new_conn_state = drm_atomic_get_new_connector_state(state,
+							    &device->connector);
+	if (!new_conn_state)
+		return 0;
+
+	/*
+	 * Portrait packing needs the transposed mode that
+	 * ssd16xx_connector_get_modes() reports; without it the client keeps a
+	 * framebuffer that would be packed with the wrong geometry.
+	 */
+	orientation = to_ssd16xx_connector_state(new_conn_state)->orientation;
+	want_portrait = (orientation == 90 || orientation == 270);
+	mode_is_portrait = new_crtc_state->mode.hdisplay <
+			   new_crtc_state->mode.vdisplay;
+
+	if (want_portrait != mode_is_portrait) {
+		drm_dbg(&device->drm,
+			"atomic_check: %u° orientation needs a %s mode, but %ux%u is set\n",
+			orientation, want_portrait ? "portrait" : "landscape",
+			new_crtc_state->mode.hdisplay,
+			new_crtc_state->mode.vdisplay);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 

-- 
2.34.1

