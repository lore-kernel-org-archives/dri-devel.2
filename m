Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5251090255
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0389C10E516;
	Thu, 19 Mar 2026 16:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S3unhh/E";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D16510E516
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:48:38 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so6680015e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773938916; x=1774543716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIvSNKXz4qc5DB7Emu7Dw1mSZJPjUbF0QIFG+kNxKiA=;
 b=S3unhh/E4nOr4Mf3jhAkPiIScjwPrG+dPmZGGRbG4si1dvR3ZQJoerSrS3AfxGSG1C
 gaY1OZMYyIQg+cEvI9E3l4LHZ5z0lIWzBv7SoaAKJZfFICc/fOSr3izvvkfAouqPjCBN
 2mqcjRzu0icaGH+A8qD8xhMU7yumOSXioXoAGc5gxoQmPOqNHsGfALKkn5ZRJIRfbyUn
 xyvr8BFpbi1oIhqhET2O7bsE/tgN3K4gE+k+XkK1YGKDqZBD7FiNkVr91db88bg07t2E
 A2g45yv8+5GjPHO60IeRvQrAEuYRM7waByUm5VejFadWt5/cWjj7Cvy0koFGUNAepmFv
 73rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938916; x=1774543716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aIvSNKXz4qc5DB7Emu7Dw1mSZJPjUbF0QIFG+kNxKiA=;
 b=cZepdgmJsPDkJjQn0Ubm8/f3ifDLJfa9+e6H8ZBENkvHGv7mXtATP8Iv4ZITnWMpaz
 muy6nIqn5PMNWoOLFuTzBsWkJUEUxp3CFnqQAt88zxmvISDGcpBTqY9sIzHFM9t1LhUP
 sATVENclgqFbqeAEhC9e2BwWoIvkxKUKFcdmW+vVJlbPdKrMRN4LhC5+2LqwtffwNAFE
 YKiVkU2h+EiOOyHSKGsls9jbhvSQOPECjMqFNS84aOiq/xPWs/M0xJFIE24n6XPTP4ne
 1lWbGkNW9QJUOEKt4muYIAALytzUa/KoCkXhZ3sZh8nQNr8C40mhyYYRqju0XX5FI0SD
 Q4eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhc/l1EnO/JOfp1/AnVVqbI5NUk13S4I4jLup3jm/xtw64+YkUkk4iLAS49EIgYSBuT1CZy8uxCg8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxsiXlkS3P6U05KD+6/4BaYr/vSDQVWpVe/nbAsOao3hXN2NRr
 X33KJNPq1EL214Oa26qic/we87wWOrSg+8mGF/aafKjtPxeUdd4szvZ1
X-Gm-Gg: ATEYQzxsI8iiSbmSSAsOMEHlk4/pJIPB5/S4h4n2umVfGFJJoFRnIYhtI0DHniKtlhM
 3z9kbb535TR2qGVFTJoWvrcJf5+5K99T2H23rqglcEzGuw3ADm1eQ2yoLjdEEnhjg+V8bdUN0g8
 JG/FKcZ4vmxBj5/dCUfPeeoe2UOP/D+YiYG9qkthxTNohj0wt9wY4zEJP5uN6Ip8hui9JKmQT1D
 UUNqDAAPvmPQj7ugMGW849sLZObH/T8T2ADkK3SKvE+TvsHto1vFIfEj3O/TCCENdtn7sjTUqg2
 MkY0lPntxmL/E6+hFkTg/TVFWaPPf2Q4i2JQ5Eb7T3/munkkeSzyezXznQnYpUk5StOPbAqDOL9
 0DrykztOmIdeuMdRxQEv+jRsGkZsRGCMGnQJpUiz80YmLkuu8/9vh+iRzTQqidvIynP2Lbp5+9Z
 Bwu3AWKNzDzxpvDNcG8NAy6mVXolN4094W5N7rURhPMg==
X-Received: by 2002:a05:600c:3e10:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-486fe8b0073mr521675e9.4.1773938916334; 
 Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm: renesas: rzg2l_mipi_dsi: Move
 rzg2l_mipi_dsi_set_display_timing()
Date: Thu, 19 Mar 2026 16:48:25 +0000
Message-ID: <20260319164833.409126-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.4
Video-Input Operation, requires display timings to be set after the
HS clock is started. Move rzg2l_mipi_dsi_set_display_timing() from
rzg2l_mipi_dsi_atomic_pre_enable() to rzg2l_mipi_dsi_atomic_enable(),
placing it after rzg2l_mipi_dsi_start_hs_clock(). Drop the unused ret
variable from rzg2l_mipi_dsi_atomic_pre_enable().

Fixes: 5ce16c169a4c ("drm: renesas: rz-du: Add atomic_pre_enable")
Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index a87a301326c7..ff95cb9a7de5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1025,29 +1025,33 @@ static void rzg2l_mipi_dsi_atomic_pre_enable(struct drm_bridge *bridge,
 	const struct drm_display_mode *mode;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc;
-	int ret;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
 	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
 
-	ret = rzg2l_mipi_dsi_startup(dsi, mode);
-	if (ret < 0)
-		return;
-
-	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+	rzg2l_mipi_dsi_startup(dsi, mode);
 }
 
 static void rzg2l_mipi_dsi_atomic_enable(struct drm_bridge *bridge,
 					 struct drm_atomic_state *state)
 {
 	struct rzg2l_mipi_dsi *dsi = bridge_to_rzg2l_mipi_dsi(bridge);
+	const struct drm_display_mode *mode;
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
 	int ret;
 
 	ret = rzg2l_mipi_dsi_start_hs_clock(dsi);
 	if (ret < 0)
 		goto err_stop;
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
+
+	rzg2l_mipi_dsi_set_display_timing(dsi, mode);
+
 	ret = rzg2l_mipi_dsi_start_video(dsi);
 	if (ret < 0)
 		goto err_stop_clock;
-- 
2.43.0

