Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0069DC79FAC
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E9B710EAC1;
	Tue,  8 Sep 2026 09:08:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D0zJxhAY";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895ED10EAC0
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:08:14 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so5015006a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1788858494; x=1789463294;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KZyOo+ygFnvVbouyZiGeNffeUNQ7tsTzDFqw1u+OtP0=;
 b=D0zJxhAYPbAVfhVsmvCaiB3zyj7Lxlgq/yCIXuUsLTwdJlQA1eX1zq0thCEjRgx9WY
 +Pg6I5+MkT7WJ4yp7wkuAiJxn77En3FlpRQA7mJgM8Noa0MspvFAukja2t1aEYFreEqu
 Rr8KDB5qmqerBFtidE8gnn6+o/D89cCyXlhiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858494; x=1789463294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KZyOo+ygFnvVbouyZiGeNffeUNQ7tsTzDFqw1u+OtP0=;
 b=ZUZjoVQWHXoSQCCAt/JrU2SXGVdKJDZWYEqjwTvS/ulffVn4uMZnpz5Qh0WV0+ZM5b
 GeKqHB0pibqUsiAfPG4LIoz/4dXaWyXMD0XIclsehoGYaFCVjxqw6+0jv96Vgr7j266W
 0teJ+0NvpyvSWYg/8YH0YClyUMbFAOddPcPXRRGR9Wl/DmUHEf7DSDnaeGEQ0zU36LKi
 5uXbhCubt7A66kgNG/928G96Qj6+d6EaOrI/VEc1uj0cZwQa/UyBSxJgSUeNhKYVZBAu
 8PLyuKj7ZW5R6KundIMwuvWfjj+jlmoycEsUVhJ89Z7y5ONekruL7OkgPvvnccuU3fpc
 cHXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBypw817qCDMmItw7w3ZGdi7EzzFxEuO/guILDuwE972hovYxy2D2G+qAB5u3YpOQ/GKRZ6hzq2UPGY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mjsryNrAF49uckeDGGYIcs/VvSxIOUm+n35fCGQNeiuhkNP8GD
 lC9h375rIr/We06PyCqCVtWivItYl7TAQeeEELWYmU9+HAiPp3HsqqN6BmCbDfTjBQ==
X-Gm-Gg: AYBFou135Lpbj/JCm3uzMy4QU5z8NOVpeVuOD9/8fXWq4jgAZ5fySyqxA7YoeJkI+0M
 Z4G8LVhyk1P+jVPlt7L/YRzNtwOJ1ow7J8oJ9QsEiSrkHWBrn3iQmF62iKAxFCEhiPl4cyUkjGC
 OFQZjGosPXCYwfYfG2LepF70EpE2PP7LwBOgVRoDXhqVEUoGeCcE7iJv+NF9i44/9G+PMFD5cNq
 HIqJFpbXDyK/mSi8ve6cDhOeD0AfpMe9re5r5ALKM4KbXfDoH6wOWWfZQxP+HOzpFE2bG5OAvwB
 iKGlDaingys2xEKdc4+NsaGzCv2i/sodYhuKCUL7/4fcZHCfByyQhwdXYbWEn3RwqT+0CDKl/wv
 JPYs06/I7+6WILiiOh7y0qYREIpYGxWPMVVYBDM3B7ylK6i085KX5ZWfsi0nGKy49eMk0uXs4eU
 0SiNkFq9LzlGTOe4CelniEHb2d8cENF2KR2MpUvh1lIFXmfkkY+m6nyqXjRpQlN66YJxG/jUmh3
 ZBpTQxR4QrsAmeLear4AN3OKEn3GB5NW/itwk2tJHqbwb8=
X-Received: by 2002:a17:90b:586c:b0:398:a2ed:7b5c with SMTP id
 98e67ed59e1d1-39b2623ef65mr47890193a91.24.1788858493952; 
 Tue, 08 Sep 2026 02:08:13 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:201d:8:e541:8c2f:4ce9:823a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b4b72f62esm19718804a91.5.2026.09.08.02.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:08:11 -0700 (PDT)
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
Subject: [PATCH 4/4] drm/imx/dcss: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Tue,  8 Sep 2026 17:07:43 +0800
Message-ID: <20260908090745.1089143-5-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
In-Reply-To: <20260908090745.1089143-1-wenst@chromium.org>
References: <20260908090745.1089143-1-wenst@chromium.org>
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
2.55.0.979.g7e5102b832-goog

