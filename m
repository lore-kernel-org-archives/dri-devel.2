Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F5AFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795E710EB99;
	Tue, 28 Apr 2026 13:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bQ8xOVoH";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D162F10EB99
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:19:01 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-356337f058aso7178778a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777382341; x=1777987141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MTheo60b+CqFeDDjmC6dt+jGx2BkX7qwxObvabyif3I=;
 b=bQ8xOVoHUrbF8hWhja0Eo7UTBItGkPgs8bJM/ljJvcx9U5dmT16RiqKfkmuhGIG6vO
 WrdrExltOEoJfALVb+WVZXOGyop795geMJQdPGj+2PB9/W3L00kkdfJ+gNtQvDLtR5ZU
 hYNtNleiKnpbrXCxKF34aR4dHlSleUlzjHfqd7ACJGScJwvUoYsSmbUuyQTSDuyN3NGi
 XdKLlkJ1MysTifw/g3bKCuYhJr/neI2E5rUQnK2NmRvKR2/Kx3SC0w4UXqCyeDz3Rvyk
 Wt2nY4dSp3mDi5Vkir3+ZBeeqapND78nQjhjmPynpDCLjoDkNaWHRi+QWPBrRbpM713T
 imDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382341; x=1777987141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MTheo60b+CqFeDDjmC6dt+jGx2BkX7qwxObvabyif3I=;
 b=T1pJapEKy2PJ0L4/NQMxROQH1yBhH0eD2G7QbQPHRFve6/8qtipZ5DUG9IDnjsgIsN
 0X5xFeli/VC7Qz4tmxLevzNXuo6kXeFeIZSohi/9Laa5jCLMrdsAKSl8AHO6xlneikQR
 Y4AoEljnv6iBZNOp7LtxLpvhNc3ITyOHoyvHZzAhrXWntmzuWpGH2DpDU/UKD/1fLtJb
 c+3x9JytntBVVulnMlS2JHLDV1SDA5IY82AdrN7vpj9yFkUzjyCELzgnZ1GABn5EHK0c
 2tzqWUtEDYvBq9H0GoAyH/YYp6KEj2VKCElnlGa2D26JWQXKnBE7rNs1dlCn0/SR9KOV
 VFUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jz9+Ugl3DOUfsCn6UiHI6I/txWOafVlR9UVs+VKLqhWwAJp24LXRQiaAiRJfswLF4pVhYyJedPkY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM0gjtRyTwjMDiXjtV+wt5aThyVitCfmKYtWiVCnSDA7h7gZUg
 6GNlOJqxmOTV6MOqdquYWi2K1IWeEZlZiIuPUOKLEswtbOX/z7YbLM0=
X-Gm-Gg: AeBDievPYqZxvskN/0BffRp+7Dwv5sbEECMJqZ/es7jynfNNBsFZyHHYjpKzGtN08vD
 oHccLLB6MQSWfYa6rGfo4SUhJj2AfTgA9xxmrJs4/QrDUaJIxTw1vUr1yfPfwym6B7SE2OMR//n
 la6wIyL0cvtZJoe45jIlmhrHW4xfncEKwvkS1dI3XF4jx9pvouFQ7DCGC5gHKMZ0rt/NpaFBGFO
 N8+wncgz61ojJbGQcR62QXABZUPQ6BnG9kC+zCSqRGJACxrvIFz165tiFJy0n6I4rP2ofQrEo/H
 dzTJbq7oii0WWkGGrPre0OgsXn3iTfPnRvqJ+g8ycgSWaumNRXqPkDSeGXplF0B4djcnowNxXW4
 t6Y3wE/duJ0/YjFGjzxbazjHDs+eigE8aQDnRKLu24pf4RAX5goqYc//XWHV29MX9ZI/Y2p8Z/i
 VrKdQ+DbJdCJGp955PfjKP6j4NeP1aj8kyiXyju75a6YgNzn9dFmdoOek3yjYbPVwmV91uM0BsO
 VptjYKlthZtJV0M7U+bBmTRoQDI9kU2jBbI+iLZVrzyVcz6WY+5/W3gjSxk+lo=
X-Received: by 2002:a17:90b:590f:b0:35e:577a:73a9 with SMTP id
 98e67ed59e1d1-3649206917amr3685667a91.26.1777382340745; 
 Tue, 28 Apr 2026 06:19:00 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36490dbca93sm4180018a91.2.2026.04.28.06.18.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Apr 2026 06:19:00 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=
 <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/panel: tdo-tl070wsh30: Use devm_drm_panel_add()
Date: Tue, 28 Apr 2026 22:18:48 +0900
Message-ID: <20260428131855.3501-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Myeonghun Pak <mhun512@gmail.com>

tdo_tl070wsh30_panel_probe() registers the panel before attaching the DSI
device. If mipi_dsi_attach() fails, the driver's remove callback is not
called and the panel remains registered in the global DRM panel registry.

Use devm_drm_panel_add() so panel registration is automatically unwound on
probe failure and device removal, and drop the explicit drm_panel_remove()
from the remove callback.

Fixes: cf40c6600592 ("drm: panel: add TDO tl070wsh30 panel driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 227f97f9b..1cf3ca1c0 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -169,9 +169,7 @@ static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
 	if (err)
 		return err;
 
-	drm_panel_add(&tdo_tl070wsh30->base);
-
-	return 0;
+	return devm_drm_panel_add(dev, &tdo_tl070wsh30->base);
 }
 
 static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
@@ -207,7 +205,6 @@ static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
 
-	drm_panel_remove(&tdo_tl070wsh30->base);
 }
 
 static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
-- 
2.49.0

