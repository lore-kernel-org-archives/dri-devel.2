Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A787CD5BB1
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 10:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8557D10E2EB;
	Sat, 23 May 2026 10:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aZ8VRfqp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275FA10E2D7
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779532900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaLC69i13BPjVBegJ0y/4AtwLN5mHubHwSFs790g7Io=;
 b=aZ8VRfqpuf7UqIJXMg2vrXM0F0674KCb1vp7LmTgQkkjjgoAStKnDDm0c6KI+Z0gzwNNPX
 6q/wyZlI1r353pZ1bMox9lhkPibjks6BDeIMpBHucbl5r53nsYe2qF8yIvmqdhe5x2iz+p
 UbqKBhOFOFgD3BX7ocjUN17kIygdxSk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-flAGsuZfPsm3SpHjcuelAA-1; Sat, 23 May 2026 06:41:38 -0400
X-MC-Unique: flAGsuZfPsm3SpHjcuelAA-1
X-Mimecast-MFC-AGG-ID: flAGsuZfPsm3SpHjcuelAA_1779532897
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4904bbc6094so8433945e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 23 May 2026 03:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779532897; x=1780137697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BaLC69i13BPjVBegJ0y/4AtwLN5mHubHwSFs790g7Io=;
 b=WSuen0v/Ne9pOzMZLuj3vg/cX5UcR9RUb6Q0BjQH9Ia8iL+r/L78FJaYHfDndNU5Z1
 jPHHYLCMt1zfd7PGfnmNwI4ZPnZY8DPISl/314mmBsed8NfBpkdMh5JJ3qpbBTUUFi4A
 o1hR/qYP2g+OehouU+5mgAOpI8gTtQrNb4aFDkdn1fCS1sFPWHUesmARy7MTF6RDMVhe
 c5y/rAq2VfXi5EXdy59HGSSwmADui3uJF4odhRNogTmlSYd8dUFVI+IQQNzmQDkdpBAR
 Ritszz0z7QfXekfRGzF65tUX+jVX0wAh293XX98+yit71eSNf9+72dZ1iM5r702SXWr5
 ePdw==
X-Gm-Message-State: AOJu0Yw66kxYsHdqvESFdAgNCWcsTeMd+SETICoFuMcd2gWDtaZZTLvs
 ZQFrwaa1LrFXUYCWWoWvQWakgZeqiiJM/ENfPdq5xHMKT4OE3xAJtNtDvHtrd7lNQlIPFAU60Wh
 A3cqXzOS/XYaPjJ+/Viun7NsEGJqBHznxPCWeiuBIAkpY/OeExkmXoRp9xZSU2FBtBmVR/A==
X-Gm-Gg: Acq92OErcXgFsUxtARCD14grDjCDdi8BT2BjJqup9jNNusGQShhDu78jE/MQ2rKDUuA
 pwN+p7wYg4Q0ptkczeR7Kszut6VWoaaB74dOHrogjfVyw1HUZYAbgPmDHucNBtOGc1phSU1Rv68
 6Xo5OgETkIo9EqgxzhGJ2v2QbRDWTy8pAjSkWIHdGKx2vazHAcO9jyXVGgJeelzrJfJ8wj2XJn/
 YeYLyiholltpRqYdg8vqLJkjU92AHr/Ex2fa3sEa4bu+RXC95D51lAEPpwS2rgJN2MbdzK+J99D
 wSSWLA3KVM1T4UwJlHqrA1PxgZI3vYJHMGHxDIzibtDnCXJyo67ElWIv5ZPUQ0GT72zb403LW/b
 6aF1WLyfbOZD948gxKhohN7e1gA==
X-Received: by 2002:a05:600c:8684:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-4904248f5aemr71404675e9.9.1779532897004; 
 Sat, 23 May 2026 03:41:37 -0700 (PDT)
X-Received: by 2002:a05:600c:8684:b0:489:5022:39a4 with SMTP id
 5b1f17b1804b1-4904248f5aemr71404455e9.9.1779532896591; 
 Sat, 23 May 2026 03:41:36 -0700 (PDT)
Received: from localhost ([90.167.87.79]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e484sm11207236f8f.30.2026.05.23.03.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 03:41:36 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Sat, 23 May 2026 12:41:00 +0200
Subject: [PATCH v5 3/3] drm/bridge: ite-it66121: Select HDMI or DVI mode
 based on sink type
MIME-Version: 1.0
Message-Id: <20260523-it66121-fix-dvi-mode-v5-v5-3-33b4468162f9@redhat.com>
References: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
In-Reply-To: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Phong LE <ple@baylibre.com>, Sen Wang <sen@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357; i=javierm@redhat.com;
 h=from:subject:message-id; bh=leBrvbxMUKYjGUjfd12DhXg0zEYbgc4w/81RR+zUS3Q=;
 b=owEBbQKS/ZANAwAKAcdR5ZDWPz1pAcsmYgBqEYRT8H5EluVVUVnH6dfH2GVEAzPPpDr0JhH6R
 W+yMFf1aHmJAjMEAAEKAB0WIQTXXteqJOUM1kXG9FfHUeWQ1j89aQUCahGEUwAKCRDHUeWQ1j89
 aeqeD/sElyJeM426JOafGGMUP3MW2L9vZB/T55nCO5SIqEs1QoIy0NZSoqVjnL6Q5FD1zs0eEpA
 Iwh1nskLeFMzLgqCOeHwX8puQeRatPqRkHtoMKbEaD/8+rS+CCpKm4eIXnulcJgjCDmzMuKbaw5
 RP84hANPW6uUoGIOtXxQz9ZIJb5GPNMmollnZBlppsP1vkFQfDgPi6YnWm5S8ZEa9Yoa2ck1wex
 PLawQaS/KF4FnWzByYD1sJpPaIXpeKPIzeClhi/A2ZtK2WFdyjjVjbDF40gNz7iO0aMaRpFOMeO
 f3Ehdx3pJApvQp8mWLA/6xB8ZglRe7ViRPPbvuzFlDUmkDktZypYTty1G1WfYih5r5qEq2R7cyA
 MbX7IMLjMTCGCZci9wA8F0wgWoJyRuCvkJzMceXMMwSvtVtUm5563keZdIpWwSuVdrvizulwUTt
 xQ/qMHCpJ4MvJELGL4GrBtCnZcbhNTlcL3F9TiNl6k+hg63xsQE1CiQGLYzHNsjCWRL4Ie9LZ/j
 Ees86kFZgElxB+zDteg1VCGsl7LBl7c6VuEP52OIA2o6vjT+wBTtV4nv4uo+J60GKCq4SMeA2cR
 WfnIxDV5RXUNmfAlWh/Occ2fv3ljHxw8PO+1NGeqfAUDnysOpcUsVlsvZkH0oumM/g2sAIr5zA3
 vY5+x4M/Q3NvhSg==
X-Developer-Key: i=javierm@redhat.com; a=openpgp;
 fpr=D75ED7AA24E50CD645C6F457C751E590D63F3D69
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2NsLlAf10ROM7MwF0vanY208vqOEHgyfd9EKmOWh_oc_1779532897
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

The driver unconditionally sets the transmission mode to HDMI, which
leads to display output not working with DVI monitors. Check the
connector's display information sink type to identify the correct mode
to configure the bridge.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 9725e5db5db3..a469e8d9d2d8 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -199,6 +199,7 @@
 
 #define IT66121_HDMI_MODE_REG			0xC0
 #define IT66121_HDMI_MODE_HDMI			BIT(0)
+#define IT66121_HDMI_MODE_DVI			0
 
 #define IT66121_SYS_STATUS_REG			0x0E
 #define IT66121_SYS_STATUS_ACTIVE_IRQ		BIT(7)
@@ -692,8 +693,10 @@ static void it66121_set_mode(struct it66121_ctx *ctx,
 
 	mutex_lock(&ctx->lock);
 
-	/* Set TX mode to HDMI */
-	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
+	/* Set TX mode to HDMI or DVI */
+	if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG,
+			 connector->display_info.is_hdmi ?
+			 IT66121_HDMI_MODE_HDMI : IT66121_HDMI_MODE_DVI))
 		goto unlock;
 
 	if ((ctx->id == ID_IT66121 || ctx->id == ID_IT66122) &&

-- 
2.54.0

