Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E05606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E04rvIGb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B674111209B;
	Thu, 26 Nov 2026 07:14:00 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F74811209B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:13:54 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2f05b465cd1so36778695ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795677234; x=1796282034;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5KKQj+Grt6zgozyhH1Cn99N5gjYRol48Ra+q72Y3/4=;
 b=E04rvIGbmByxtqA253BQ01XHHH8U/x0eHDXfpct2njPEEyTv6yW8Ac82d8QHdP6Lxo
 YA6rj4UVQ+c040r8MGDIObUD/WpO/KNjWvnvP9O01o0jiE+IsqrJO14XuW/jfxCjtHLF
 tKXjQ56CipKkViucQ1k1SjzUWcoHcAA35OBL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677234; x=1796282034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5KKQj+Grt6zgozyhH1Cn99N5gjYRol48Ra+q72Y3/4=;
 b=FMUcey2D2z/nABVfSSrOSi86VKcFlakH+2y9Xvp8zqz1KEAT4e9iSJo5XvIaJnMJB+
 oUOTc4cN/z5kk7bVt2eUNn3lvZIeeIPQdsvknL1TamBHzRT0lRwKXhojm6vopCLhONlt
 x4GN7jwmnvu6xlJBn5DypIUtOcjkuNFOgiAZ9FMcDh4Jawo9kmOSt7Z5xN7Fnmtlgmr6
 HzkatqQa2lHmi44CXI6R8RvYxHc7DNiUG/88ZPCkAazf50E5ONh3fbH5dkl1VmUHza8P
 YiLkr3qJnO8t9h0i6CIh1tk0iNo2JRgUFbSkwT4hYxuDn9fDAxrUzaHN4PYR353RxyKT
 wqHA==
X-Forwarded-Encrypted: i=1;
 AL+hErECLsOp9UybKkuvfRjzDWt9+Ip+/k+XJea+b3sVMnzHGhIigDXWkC3GX0fxdeae81NkEnSeeR+uUp0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+QfxBGe7OzeBNsqOP0u95WLgoIORqRFzsi5/rr2Kj41ZQcKhqK
 XjK03isP/3iC4X2DlOOQH+SbYYkr7RxeFuvlm9cX8VbRKgE3dt3bAw9G4libLN/yQw==
X-Gm-Gg: AZFdTZfwYRQRHV3otOYgTLvo0in+URsTAZ9ebL4MsEzvus6YrP0mtGneuXPgdf4xqnl
 aihR8/R/+U4Mj2yKr8qUrFAk8CxI/g+JvMEKunJ7Lppckqglds6Q1vsbCFOq7hG8AYNOH3nwZwU
 0pqsgVQG6E66gHYdpWn1X3Lx0r3Kt/ePtLuuRihnB/AgkP1mLRCSiGaDC3yIGaAJrlpkmDRvECf
 7a4iiDE6Nf4QjjPUznFDt3xg3qEP0DKX3tX/SgsIoCbnBMehtNMVBuv+3s58TvvYuMFNeSZB33l
 SbD/xBGwC+YX214s6ekL4q70sKYhzbI/TQDK8jsHQZCi/gvTz0plcqYkfVjFM4UwftTfEKHLynj
 /AEvSp9HFhLkwNvyDUb+zb0innLagBCAFuQpZHfM7EwAcMhwiczYaZq2ZWh0DgFX818XTps2kix
 sUeQwpyiyBqhaE+zVP1ZgQOjzBiSl6qS8ymxatauvWlzNQssiK+03mUaRUdg31teHHAGEGU8U3w
 ZhU0P4UTL5RWZdInmfzKwg5OpqyHRTx1kqbnamTI/i/FkhQTaOclYEyah4e5HnhnDxla31h4dJg
 O78HyBsr7jXP9KyNvPQyvGNJYtL4Nlpg3tpCE2q309I/yV367occGGJD0l6uorLfsWv26+sg35g
 W0FWBOA==
X-Received: by 2002:a17:902:f545:b0:2f0:585b:8d8e with SMTP id
 d9443c01a7336-2f0585b8e12mr169849155ad.60.1795677233916; 
 Wed, 25 Nov 2026 23:13:53 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2f0bc695f31sm41539205ad.49.2026.11.25.23.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:13:53 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFT v4 5/5] drm/imx/dcss: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Thu, 26 Nov 2026 15:12:53 +0800
Message-ID: <20261126071314.253890-6-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126071314.253890-1-wenst@chromium.org>
References: <20261126071314.253890-1-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The i.MX DCSS driver is open coding drm_fb_dma_get_gem_clipped_addr(),
with only a slight difference of rounding down the X offset for the
first plane if the format is packed, sub-sampled YUV. This is likely
to correct the buffer address to the first pixel of the 2-pixel group.
Otherwise the hardware will start the scan-out from the second pixel,
which leads to the U/V components getting swapped around, and the
chroma component of the next pixel group being used.

Switch to drm_fb_dma_get_gem_clipped_addr(), and offset the address by
a pixel if the X offset is odd.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dcss/dcss-plane.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/imx/dcss/dcss-plane.c b/drivers/gpu/drm/imx/dcss/dcss-plane.c
index 303e93fd036c..580d9cfb4053 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-plane.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-plane.c
@@ -219,28 +219,22 @@ static void dcss_plane_atomic_set_base(struct dcss_plane *dcss_plane)
 	struct dcss_dev *dcss = plane->dev->dev_private;
 	struct drm_framebuffer *fb = state->fb;
 	const struct drm_format_info *format = fb->format;
-	struct drm_gem_dma_object *dma_obj = drm_fb_dma_get_gem_obj(fb, 0);
 	unsigned long p1_ba = 0, p2_ba = 0;
 
-	if (!format->is_yuv ||
-	    format->format == DRM_FORMAT_NV12 ||
-	    format->format == DRM_FORMAT_NV21)
-		p1_ba = dma_obj->dma_addr + fb->offsets[0] +
-			fb->pitches[0] * (state->src.y1 >> 16) +
-			format->char_per_block[0] * (state->src.x1 >> 16);
-	else if (format->format == DRM_FORMAT_UYVY ||
-		 format->format == DRM_FORMAT_VYUY ||
-		 format->format == DRM_FORMAT_YUYV ||
-		 format->format == DRM_FORMAT_YVYU)
-		p1_ba = dma_obj->dma_addr + fb->offsets[0] +
-			fb->pitches[0] * (state->src.y1 >> 16) +
-			2 * format->char_per_block[0] * (state->src.x1 >> 17);
-
-	if (format->format == DRM_FORMAT_NV12 ||
-	    format->format == DRM_FORMAT_NV21)
-		p2_ba = dma_obj->dma_addr + fb->offsets[1] +
-			(((fb->pitches[1] >> 1) * (state->src.y1 >> 17) +
-			(state->src.x1 >> 17)) << 1);
+	p1_ba = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
+
+	/*
+	 * TODO fix address until helpers know packed, sub-sampled YUV format block size
+	 *
+	 * The buffer address for packed, sub-sampled YUV formats such as DRM_FORMAT_UYVY
+	 * need to be on the first pixel of each pixel group or block. Otherwise the first
+	 * pixel of the next pixel group is read and the U/V values get swapped around.
+	 */
+	if (drm_format_info_is_yuv_packed(format))
+		p1_ba -= ((state->src.x1 >> 16) & 1) * format->cpp[0];
+
+	if (format->num_planes > 1)
+		p2_ba = drm_fb_dma_get_gem_clipped_addr(fb, state, 1);
 
 	dcss_dpr_addr_set(dcss->dpr, dcss_plane->ch_num, p1_ba, p2_ba,
 			  fb->pitches[0]);
-- 
2.56.1.839.g22a8290db9-goog

