Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253C8C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0604D10F52F;
	Fri, 11 Sep 2026 07:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cSrzMbST";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E31D910E1D0
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:51:02 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-8834d10a4e3so3823897b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789066262; x=1789671062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ze+3Q1Zghvt73AjvM76sYvoFHG3lXKdzLgSKzynkjs=;
 b=cSrzMbSTGRkQBX5sQJOvnm+bhve2p3BeG+oAPKBuPzJPdlYf5mJX3XTSsHNl5GR8tu
 HnLw8/S4+9LAmAIdOBD0VyWQxoBqXIzoJl9yBpvRgiR+etuW6QqyJb9VJKyTwcP0ImFp
 bN/Yq3BKYCil79RAM+0cC+6TKsiJOSs3SI1GK3jp00j4ADvw81rq500VVwQ5DhEsTGPL
 8+zQLf+pCDbBM7ycRIq+gNu1DHZ4mlYdmrpGOjln/+QmoeVmAB7Kn+xOmeTBrVRMZNF+
 fGXpAQfgn5ZOs30q9GWu09rB6AlSXMr8fWFtUaca/PQhloKX3JAYs+DXlqASJu0Du0Y4
 l5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789066262; x=1789671062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7ze+3Q1Zghvt73AjvM76sYvoFHG3lXKdzLgSKzynkjs=;
 b=FsPlYw6DYBCvSNu5PcFCe3LxaI+gsl13N2d1zcNC7ESAa+uLKrUlko5oayMz5AJZg0
 yJ1LUjk6LquZw4IubS9mWsUJboB5nEmTCBjmX7B/eRXADgjd4/leamNizPC3pB+Vqa/B
 6iKQzFwbByGeEZUXHZPMxv4A1WxGrxAIDX+tPNo7bvAP2sHOxuHj0i8kWq1DVVVCeLA0
 VYZJiaoGzOclsz8ymUXsur5uOweiRg9aoq9zTd6PEXYupFGhclaK0OylqTF9Erh6muBm
 9lN/+h1+nnQVYhPzWxBLj0P7zCPXeRnnzA2ABbzujUODPyrLLcvleeHd0wBmf2O6rGcu
 1aQg==
X-Gm-Message-State: AFuF++mI2HsY3dB0QG2H/9NKruLDICUghkd1mvjlqRBbrZZCbGNz0/dU
 /8tnSy/MIH9QgiAE+sgpgTmRZ1yl+JIMZik+RRmg4SN1QM5GmHMQYLciqAlaRp7j
X-Gm-Gg: AYBFou2u/g0n/tRVyeItoiD403cojtIZvmLmUKn4yCgOW1wzCyMMfkaKWu2bb3r4gYs
 dJEdB/fzx14+gvhERi2OAV57abwN+EIcei5zv6FHEM+CZb6BMUsk3O3gF6zc7RQTQc0Tglfiqum
 ryLSGJfaQzw2aYsgmRb+iwAnfBFmyEbSIO+e9YXSleJ4XxPy18X2Sfuiw3ZKvU4KUcHf1LcbQUi
 I1c/jt0znbwQvazvtd+e1pmpLEthVicrY/KzEXI7LOI6ERcT/5tTKU45U6TQK3cxymXniOsfTAO
 E34V3LzHS0kkzoz0DNqmZotD27Qq3UxkF8LSEiJrysSccKUmoE8MqZZ5lgDZAEvHlwQfqa1NdmL
 zHkBkEz7srY1OTiY2EZEpHtyNhuV06xLwVZ/ApkZ+kQAF6nrGKeTmtougQF9sITW9kFyBVeP3Id
 YGP9TXCmTa/33PnezjxXWPusITuY8SE910/TU2JaR+PK9yyDZ0lmuu2tqOlw+H8EGajnvNYMosY
 pJoIgwuEYo=
X-Received: by 2002:a05:690c:387:b0:873:5c7b:c13b with SMTP id
 00721157ae682-88206b7b4b9mr20143737b3.35.1789066261756; 
 Thu, 10 Sep 2026 11:51:01 -0700 (PDT)
Received: from DESKTOP-TLFH1MG ([76.255.203.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-88486086a50sm3291707b3.17.2026.09.10.11.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:51:01 -0700 (PDT)
From: Jonathan Frazin <frazinjonathan@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, linux-kernel@vger.kernel.org,
 Jonathan Frazin <frazinjonathan@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH v1 1/2] drm/mipi-dbi: honour the plane source offset when
 flushing
Date: Thu, 10 Sep 2026 13:48:56 -0500
Message-ID: <20260910185030.870-2-frazinjonathan@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910185030.870-1-frazinjonathan@gmail.com>
References: <20260910185030.870-1-frazinjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 11 Sep 2026 07:50:02 +0000
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

mipi_dbi_fb_dirty() takes the damage rectangle from
drm_atomic_helper_damage_merged(), which is expressed in framebuffer
coordinates and already clipped to the plane's source rectangle.  It
then passed that rectangle straight to mipi_dbi_set_window_address(),
which is correct only while the source rectangle starts at (0,0) - i.e.
while the framebuffer is exactly panel-sized.

If a driver allows a framebuffer larger than the panel and the plane
selects a sub-region with a non-zero src_x/src_y, the controller was
still addressed in framebuffer coordinates, so the wrong part of the
panel was written and an out-of-range window could be programmed.

Pass the integer plane source origin down to mipi_dbi_fb_dirty() and
subtract it when programming the column/page address.  The copy into the
transfer buffer still uses the framebuffer-coordinate rectangle, so it
keeps reading the correct pixels from an oversized source.  With a
panel-sized framebuffer src_x/src_y are zero and behaviour is unchanged.

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Jonathan Frazin <frazinjonathan@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 25cf04d02..38db45a9d 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -271,7 +271,8 @@ static void mipi_dbi_set_window_address(struct mipi_dbi_dev *dbidev,
 }
 
 static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
-			      struct drm_rect *rect, struct drm_format_conv_state *fmtcnv_state)
+			      struct drm_rect *rect, unsigned int src_x, unsigned int src_y,
+			      struct drm_format_conv_state *fmtcnv_state)
 {
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(fb->dev);
 	unsigned int height = rect->y2 - rect->y1;
@@ -298,8 +299,13 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 		tr = src->vaddr; /* TODO: Use mapping abstraction properly */
 	}
 
-	mipi_dbi_set_window_address(dbidev, rect->x1, rect->x2 - 1, rect->y1,
-				    rect->y2 - 1);
+	/*
+	 * @rect is in framebuffer coordinates and has been clipped to the plane
+	 * src rectangle by the damage iterator. The panel is addressed relative
+	 * to the src origin, so subtract it here.
+	 */
+	mipi_dbi_set_window_address(dbidev, rect->x1 - src_x, rect->x2 - 1 - src_x,
+				    rect->y1 - src_y, rect->y2 - 1 - src_y);
 
 	if (fb->format->format == DRM_FORMAT_XRGB8888)
 		dst_format = drm_format_info(dbidev->pixel_format);
@@ -390,6 +396,8 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
 	if (drm_dev_enter(plane->dev, &idx)) {
 		if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
 			mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
+					  plane_state->src_x >> 16,
+					  plane_state->src_y >> 16,
 					  &shadow_plane_state->fmtcnv_state);
 		drm_dev_exit(idx);
 	}
-- 
2.53.0

