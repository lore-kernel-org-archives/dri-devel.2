Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FA3FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E68110ED80;
	Wed, 29 Apr 2026 10:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="F+zaBrsE";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2062F10E32B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:17:49 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so2068037966b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1777389468; x=1777994268; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RY/5ve0AYi87wKI8M4T8nphzcR95Syd1n7GrDKReYDI=;
 b=F+zaBrsE/cF13lQk5u4pJJsWDAaWESUrD3PHnbTWeBQlg3ixHvuSLWPHeAG4QNf9f0
 Q0BrLADuzeqPcGZFAI60Ok7HiZ3nC0uvFKUWKmULN+wrkLj/6UZ03Sz9K/wsODbqBYEg
 XWnU7OKJhpYd6ImRZ/pxLfccQE5thNnJNTrAfe1sodoycY/qA+U/x7oSIxKQFARbObbX
 UQiGcR0fnHXvO+MJdlywVLk3s/HGRwgqjIgjAWVSkzESSGOl7F0AMAvL08gwCm76e4UZ
 ZytUY/ToY/y2W9g2E5r58f4+CJj6kSKc5E4M9IGsX/KvZfmeaikNfQNaGTTLvmNHjLI9
 XVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777389468; x=1777994268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RY/5ve0AYi87wKI8M4T8nphzcR95Syd1n7GrDKReYDI=;
 b=NkcR4KXgXlG60bqpNhCN7ZqBNuaRXmymEVlvtt/c5IN3/1RezduwKUq9+k7nDfihUD
 UFruirdWY965y/xcvpu3pDNZ/prKizDeazlfcPmIoeBlpLp0saabXwQb2bPa+yjimTQK
 +44H8YEUM7rKdeeb60vFx+znsiwiAqs4mUgj+ngmHrGwJxV0qgyC8Uf2vEmEWw86pkP3
 VNq7HsnEjcZqJv87YWPCT9SoWruBnXlT8zjig5NEmUO55Abisfq+zkIJXfcnegZ6rMWb
 1Sp8q2bjtFhN6vgfjNVyxL/UY5fzHMkKmM4AfUxMGUezlW4YUZORsjZsKkr83M1CZS47
 Z0zg==
X-Gm-Message-State: AOJu0Yyg1SgusgobvPWAwg02516W5lHqBwWAs3PyKX8CDIBplus/jj0a
 HaQ3sRkB+bRUtHdblFCFV70MLZdEdJvS5xoYT3S/yAf6jBTtRvMvmhPJDD5QI9Hl/Ug=
X-Gm-Gg: AeBDievsmJGiaAy+BSYZMvexM4hXgEcPIPMgtlgr36kDPvyC56ATAHZQLBvhg6voRpX
 vBy1+ltVpzjXWLbDGeU2h1imY9QLbMlycGUh8qTtca3NhFcLxJN0ZjVXMjSg9kxKwvctqVXaER1
 z6Y4VR26+6kA0j5mc6aA3oQ+6zcdgPgYfjg7kPX5/NzpO+ddbAOs9YKt1CxnZapi3IdFS/zcyZ9
 SUhupObJe3Ev8uI9IWVhisGzyjQRS8MOne/TjzwnR7TPhSl0YRhDyl9M3R3x0p9cM5xFDUNEPUG
 BNCtQEabqmoFrDMazj6/OJHt3FFBAMs7XdpE7YZ080BlGJm5wvt768POaeg3xYWIuUjLFlUkbLO
 qHvVYpS22zItPcctSx+pJOoLCPAXXI3SNmbUMNmXuLBZf1akdP+gmww2pKLgHH371D7QjDhsA+C
 KNZWHr5TSXBphzSzYYSC0EoRn0T21KkRkgwljsoml5PM8ezBsE3AEYbevfB7JyfdDDArjrU99ZG
 /jq3FByg+V0det8T5Z6s77pmUKG5A==
X-Received: by 2002:a17:907:8b95:b0:bad:667f:efa3 with SMTP id
 a640c23a62f3a-bb8026bcbb7mr172309266b.11.1777389467428; 
 Tue, 28 Apr 2026 08:17:47 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80c0828d0sm115205366b.56.2026.04.28.08.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:17:46 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Tue, 28 Apr 2026 16:17:25 +0100
Subject: [PATCH v2 2/2] drm/panel: simple: Add Team Source Display
 TST070WSBE-196C panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-imdt-dsi-display-v2-2-cf7294b5d7d6@imd-tec.com>
References: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
In-Reply-To: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Add a dedicated panel driver for the Team Source Display
TST070WSBE-196C, a 7" 1024x600 MIPI-DSI TFT LCD panel
using an EK79007AD controller.

The DSI timings were calculated using
"linux-mdss-dsi-panel-driver-generator" [1], reading the downstream
file "dsi-panel-imdt-tst070wsbe165c-video.dtsi" [2].

[1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
[2] https://raw.githubusercontent.com/imd-tec/meta-imdt-qcom/refs/heads/kirkstone/recipes-display/displaydevicetree/displaydevicetree/0001-Initial-bringup-of-IMDT-Display-3.patch

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 236bd56208cc..0010bb3db484 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5936,6 +5936,39 @@ static const struct panel_desc_dsi osd101t2045_53ts = {
 	.lanes = 4,
 };
 
+static const struct drm_display_mode tsd_tst070wsbe_196c_mode = {
+	.clock = 52477,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 160,
+	.hsync_end = 1024 + 160 + 12,
+	.htotal = 1024 + 160 + 160 + 12,
+	.vdisplay = 600,
+	.vsync_start = 600 + 12,
+	.vsync_end = 600 + 12 + 10,
+	.vtotal = 600 + 12 + 10 + 23,
+};
+
+static const struct panel_desc_dsi tsd_tst070wsbe_196c = {
+	.desc = {
+		.modes = &tsd_tst070wsbe_196c_mode,
+		.num_modes = 1,
+		.bpc = 8,
+		.size = {
+			.width = 190,
+			.height = 121,
+		},
+		.delay = {
+			.prepare = 20,
+		},
+		.connector_type = DRM_MODE_CONNECTOR_DSI,
+	},
+	.flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM |
+		 MIPI_DSI_MODE_VIDEO_BURST |
+		 MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+};
+
 static const struct of_device_id dsi_of_match[] = {
 	{
 		.compatible = "auo,b080uan01",
@@ -5955,6 +5988,9 @@ static const struct of_device_id dsi_of_match[] = {
 	}, {
 		.compatible = "osddisplays,osd101t2045-53ts",
 		.data = &osd101t2045_53ts
+	}, {
+		.compatible = "team-source-display,tst070wsbe-196c",
+		.data = &tsd_tst070wsbe_196c
 	}, {
 		/* sentinel */
 	}

-- 
2.43.0

