Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AF5606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rAcpPeqb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A30010EFCB;
	Mon, 16 Nov 2026 12:12:03 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A37810EFDB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:11:54 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso35462045e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831113; x=1795435913; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mh+ToPltBb8mnDHqsdQlNCdlhh90EXZrqETmJQ+oo/w=;
 b=rAcpPeqbtbwxJB8D6St2qaQ2ldEivm8+t5hZ2MedYg6TBr7IKAl9PIbOcP3A3TcHBx
 JvEEZxHop7zJD5Y5ushLuoBD2aH3WIdUbic+b5r422Y9H0o6QOTrZ6wOWBtB91x3YXQJ
 wBrnEEEVVbAjPH2sFC0Z9EgBE9Sj4pYGScRNJHQdVIPdiFywyUMQYOGey9naGuLEyaeD
 i/agE2GEWR8umM1iZnVV1ScQYODf82pMIi0YUI4QKpaT7j8u8VbLcbhcs/l40VnzgNPZ
 pFrH1i5KNNaEQh+zeYy0J7glbZqO03ZdiJPsve7ML/8JemEAPy9lMu7jCbmi4xEA2OZ/
 yBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831113; x=1795435913;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mh+ToPltBb8mnDHqsdQlNCdlhh90EXZrqETmJQ+oo/w=;
 b=gbnPW3fXJLivsIB2qE8/yR56KHM+icMf66WV92Zwvl5ZqUDUOG5TfcNFSAMYiQC5ft
 huYtic8p0Eh+MhszFWspEYcdlrN2OcXC0lgs7zFTm1TWOcV9T7WeFlwEAWq+8l0dYql6
 DViAnRnUQ5fo4bRNb8n3lU6V9+bsfu8/M8GzfmvPmzu3ALFsoNSj1MDC4ig9tidwpjF0
 krZFVrLnF9Tc0iIpUSMxcw+EsCuIrGkAs7ULPqBMhzC9cNWD0Q20X/BstQFOlzQ1RRYd
 su1V+FQOCvLgCUayfyCd3oLMJj+h1VIyryz4aiL4Wa5zRdOWaGL1TKVx9J1VNx9Lijt4
 FTtQ==
X-Gm-Message-State: APuU4Z8SzsYBfONDcDI8sezlv83YbDOwc9HBzUJBD66/CKl0qckjAVsX
 T8ee1crIw6fmqYpKwCrDXaaXR7NatttmfV3RCKlRJKtp8hxRMqjoYbDQ
X-Gm-Gg: AYBFou2zs4owrUd7EUW4ebSFK3X6ILPvwG3aYeXxrtk1oW7PMeYBIm4vWecEdCjLB5u
 t0wuJT38pzhK1qU5KR29TF8kMAnVJWvukci94d2nVE+lUtC63DQ6IbGj6ciJEQnplCXQqcrcfEP
 q9Lw+0AJ6a9OZDJdjJ67xtex9EmF0PQ5JaLjDLSRdTzW6ta9NpUhSlt9ZdlkbOjG2OfFCVjy4b8
 uuklodrCFSAolOGo+rPDOC91evur3IujbuFVKea2oUYJPdNVMAfO4EdF+TYQmKAQsTIKquE2m9s
 63z/D6SHlicQJ5sTYCwmVgWEAvNH75M3/ApIyPrQvd0TVH1CHTyeqNX/BXlqFn88nWqtLCfD1yK
 GjIUZ0aSAk4wkq934KTniA9BDJd7B5Y1bC4Ya0FqfI/0GIpImBlxbAMNBZ4lJXOJX1w5KrWEQgM
 FuaPav0yFEQ9FpiO/iTOdVelp495/izbRMYBWAZNHK0t45+L1fiiuqv0gs1uZTtT/bsT+ctEIOE
 e9oMNMYxNEgPug+FkCsKUO2IWqTektVFQvaQCShHy+9BWFF8JqA+NRfH6rIqVUXL328agQ/6XZl
 0F/JLPtIw/FGfwS4npP9pzm/3qYL1TzCT1ChzAhJJDRxG4zqam7wSBOAQ8zwMnMFtJSHTkXovoO
 3Vwaj0LEx2hwOK4Z+NeLFxio2Npx/oXUbZIC2RFUpNhlJ/Ic+vvpe1VSXaJOrx7LuKVlwxbLz
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb69b2d82fmr91695095e9.25.1794831112818; 
 Mon, 16 Nov 2026 04:11:52 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm61442005e9.5.2026.11.16.04.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:11:52 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 16 Nov 2026 13:11:48 +0100
Subject: [PATCH 1/2] drm/panel-edp: Fix Innolux N125HCE-GN1 mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-reform2-internal-panel-v1-1-765cf8d5ff4f@igalia.com>
References: <20261116-reform2-internal-panel-v1-0-765cf8d5ff4f@igalia.com>
In-Reply-To: <20261116-reform2-internal-panel-v1-0-765cf8d5ff4f@igalia.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

The mode has a pixel clock of 162 MHz, which is 70 Hz. The EDID of the
panel only has 60 Hz and 40 Hz. Output of edid-decode:

  DTD 1:  1920x1080   60.001038 Hz  16:9     66.721 kHz    138.780000 MHz
               Hfront   46 Hsync  30 Hback   84 Hpol P
               Vfront    2 Vsync   4 Vback   26 Vpol N
  DTD 2:  1920x1080   40.000692 Hz  16:9     44.481 kHz     92.520000 MHz
               Hfront   46 Hsync  30 Hback   84 Hpol P
               Vfront    2 Vsync   4 Vback   26 Vpol N

On the MNT Reform 2 with i.MX8MQ the picture flickers at 70 Hz. Use the
60 Hz timing from the EDID.

Fixes: a14c6b0eef77 ("panel-simple: add Innolux N125HCE-GN1")
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f7add22ccf69..0ebd756d14d0 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1364,15 +1364,16 @@ static const struct panel_desc innolux_n116bge = {
 };
 
 static const struct drm_display_mode innolux_n125hce_gn1_mode = {
-	.clock = 162000,
+	.clock = 138780,
 	.hdisplay = 1920,
-	.hsync_start = 1920 + 40,
-	.hsync_end = 1920 + 40 + 40,
-	.htotal = 1920 + 40 + 40 + 80,
+	.hsync_start = 1920 + 46,
+	.hsync_end = 1920 + 46 + 30,
+	.htotal = 1920 + 46 + 30 + 84,
 	.vdisplay = 1080,
-	.vsync_start = 1080 + 4,
-	.vsync_end = 1080 + 4 + 4,
-	.vtotal = 1080 + 4 + 4 + 24,
+	.vsync_start = 1080 + 2,
+	.vsync_end = 1080 + 2 + 4,
+	.vtotal = 1080 + 2 + 4 + 26,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 
 static const struct panel_desc innolux_n125hce_gn1 = {

-- 
2.56.0

