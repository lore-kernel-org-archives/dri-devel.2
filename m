Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BDAFB3D17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265A610E5AD;
	Mon, 30 Mar 2026 10:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZXmH4MDR";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8BA10E1C8
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:44:55 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-486b96760easo47537455e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774867493; x=1775472293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Cmbluhj5GyyYqaF3P2muL1bB8tOOS7mRoOIdtU1n1U=;
 b=ZXmH4MDRgEvTQCvCD5FQVtp4ygBiZsipma9NZtdG+dIiudF+tZuS/U8SGX3JwMk8+E
 O/mp1OGpZO7ejx37rHHWscPKougv2OFFJuTv4e6hj+ZJWZQEyllAfWjlxtyV/TlSPsTT
 /5S8MHm9Cj44j07l2APHFUZ6elg6WFMNGGq6ZKOfY8VpZNf/JzhpshpXxYlC/7ZTfMXL
 nivBodiGCeF9DfxpqF/kdN0o9uFhQQQy3RYvkiGF8DMoRUMva/+lhCLZvgVWX+mqKpAL
 qWaJ571GuPKMJzwrQVRWMUKAQ7hLDKAN8LsLlC6iClSnDR26mcUGc5GFY22IgtRN8kW8
 FCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774867493; x=1775472293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Cmbluhj5GyyYqaF3P2muL1bB8tOOS7mRoOIdtU1n1U=;
 b=YTWz9RmhBnesbFjw1tnvHbpvpbxEUNAzNaBc7z2X6BxPOiWqhoR/kMryPQ8NWMm56o
 aiL53zWDQvxS6l3BQMFUdFe3NA+1bO7J4hFR3tc4+MSHrpcETOyY4xm6uVya1zFn3Cxe
 eIyccTum3wgrOLlzTP2JxaA7GLET3EWh+jxgt8PNhxijbs3OyVbg5TZ6Sw9Um+U94Xnl
 V0ShjdOH+ygRhZWgmm71YPEvlsNmwox+4QIoz/43ZobOutjcaGClUFttYmBYvAROaRSy
 dwbcuM1TxWKRYPqh97rJnZlEjCMH+wr+2X8K+oyTvksrwOQvSFnsogV3aDeTy7AZi23P
 AZLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+xWJ2k79resaG13rHYMWLm3Gp0US/mEhD45d322EbrvTLAuYW4lGPi/pG21OLUE13ZVyaZjA1vDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVyDfeYOSJOz2RssnyalCe3mF32eviZoDZ6OGuuxXZsxzWDvbZ
 pl3ZC82bCAzIh+gmYGkwA9dnCSv4PbJPvrU1qEy9or9N72PlIyFGgvBD
X-Gm-Gg: ATEYQzywfBMBlGQNQe/Ua5p4sif5oVf0ydeG/rlkWKmn23fktzRSmBYiJ9NDbxEsQiA
 8+5LrVhVPvaHmut0LMnmhXayfKoLhNyoSdRE8npjBjKCUx5h1IpErHHWoW8CnpAg/gRLJP6X1Ox
 VweVJE8HkWe2yqRVkbMgGmKZND/SHqY335QaelXGclVsb5jlI+3QKObBDbv0H+8fsBKkOaSNcL8
 NFBku6dVrAoF6SdLlYJBL6NdPZ5YpG53WuA3BvuEzWaQMEnUB1Nj8/tgj0BSITS07ripWDIF6Pe
 ImNHqaGdqkSiiPQDgmXUdYVXXcJ2cI90uiIPzxLXn2i5UxSmzEcJFMpaNJRjCoTLvCs7jvtREkX
 gy6oBVSKxpTVh9ySdRs2wH1McU++CjZj8P8bVWyyKURku7uWi7WWpApJ9qw0+GdJ7YX3uNyngyh
 ZRSj/icjtsFv5Qcvq8JG01Roe4LXBgUw==
X-Received: by 2002:a05:600c:c109:b0:486:f9d0:aac8 with SMTP id
 5b1f17b1804b1-48727ec776bmr151656035e9.18.1774867493375; 
 Mon, 30 Mar 2026 03:44:53 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:e60:2c8a:54bb:d692])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727bfc5ecsm185842685e9.1.2026.03.30.03.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:44:53 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm: renesas: rzg2l_mipi_dsi: Move
 rzg2l_mipi_dsi_set_display_timing()
Date: Mon, 30 Mar 2026 11:44:44 +0100
Message-ID: <20260330104450.128512-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
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

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
requires display timings to be set after the HS clock is started. Move
rzg2l_mipi_dsi_set_display_timing() from
rzg2l_mipi_dsi_atomic_pre_enable() to rzg2l_mipi_dsi_atomic_enable(),
placing it after rzg2l_mipi_dsi_start_hs_clock(). Drop the unused ret
variable from rzg2l_mipi_dsi_atomic_pre_enable().

Fixes: 5ce16c169a4c ("drm: renesas: rz-du: Add atomic_pre_enable")
Fixes: 7a043f978ed1 ("drm: rcar-du: Add RZ/G2L DSI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
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

