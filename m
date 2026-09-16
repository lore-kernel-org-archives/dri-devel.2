Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69A5C88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF2D10E2A6;
	Wed, 16 Sep 2026 03:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GjMJsys/";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE7A10E2A6
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:33:57 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d747f0b25dso4477415ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789529637; x=1790134437;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kBFRPVKNIBD0KQtZ9pcxiREtmRb8PGXwbQL+UCfrWrI=;
 b=GjMJsys/0QnygrgFVIuOmoC2LklYYYFtUY3plg9R/MlKLvMmKZU7/eJRkR8hEct963
 jNmLVrpUAJD2ow5Rcvk4E0eTpPPk9kTqVycqRcleDUCUdUMMhbv/htyauZoLfpvLuFex
 pViFAY30jAKXrC5ULJt7dlizp3AHfTeewUZFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789529637; x=1790134437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kBFRPVKNIBD0KQtZ9pcxiREtmRb8PGXwbQL+UCfrWrI=;
 b=XcQZXfHxYzcm1zfSjOE2uxF0w4mI6hDETr3Xgee5rPFRKcFQYuDo4TSSQKZG918U2I
 jYFf4y7ovZstJCgT/cA67nUkG9+/Cp5NWR81ojTel2WSS7lBsuh/WZD2uLkv8Zwbr6V8
 sSDnu2Rc9lhWWyH98sdEreX2mBZZXWywKjmlnvYzl9eNIyVFWTktwAzLLZU8ywSJyemk
 S5ZbaW836TFb+QQW/u25BD1F/sXcExsgdDa5Kf4HxfZlVZDvXVv2oh6B90yL6beV7Yzs
 RjXQEL2uRMO/sqdVY3go+Wa/UwMnmi3nkt1I7XP9v9gVjPMZS1iVIMAhsF6wcLic3HfI
 LtSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTZYjRqXRYQwdYBT2TCUMtKFyOlXqgc6NeWmI+rarVCBZNxQTwVx1d/uX8G+a0tU5woaEqlv1XqCU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKNIM8YW8rnAkeX8n07bF//yZfNH42Jca5bfp+rsbtC+otC7Hn
 e6fQ3dUv44mTCijk0Gvp9uQI0FlXz93W2cw9nnHDXhLn+o9gRM2f1yzxcC5UvStmgw==
X-Gm-Gg: AYBFou2d0tYL+Vn1VUAvBHe4T9usvGv3h5FjM3WImhfyfIe1l4Aol5NUISU3QM55C9c
 gOfh3s+UTBRMdJHqOf5HomZY890BDplvcOFU29ImE5mLebcp61cNvswfa08ul9DvU2hlz9lRbxX
 VZLJzXcFgj3yGcrZuBXef4ZqE/O0iURv9vK2mTj3k2IgMf8zqHTDZBaW2R9yQbc/IVB9fzztDF9
 sdmEkyj9CdvYPP76kkKuiuV/yoqGiibauEtIYJdtqtHWPjakkvVxq2mmLt+/t33gcGylzszSPW6
 tTuaz6lYyuO4k9Fr9AcTmyC3N6sfyHw1sMcL6mEL8H2TFnY8Xsa+agbSw1cKjhEtEY+D1cOWApF
 /7F7bUPEEx5WvYgXASdzKBQoVknyk7u6F+MV6H8hgRwcFlqeAAV7HgrzyxwqHItMeE/s1LHOtXj
 rJcMpPCA15eib0UDyvLOELMy64MZp/hYFey5jitGhBtZqvs/ODQgvi4tfcBMo6aRXB55Tpg3q/j
 JYnLzDIH701nzE3vzwNmh5jRjg2s+odhrzPHr3qNfQtFiDVMkYtnYg5yw==
X-Received: by 2002:a17:90b:4c49:b0:39d:fd60:caba with SMTP id
 98e67ed59e1d1-39e1e485dddmr2368694a91.14.1789529637188; 
 Tue, 15 Sep 2026 20:33:57 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 20:33:56 -0700 (PDT)
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
Subject: [PATCH RFT v2 5/5] drm/imx/dcss: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Wed, 16 Sep 2026 11:33:26 +0800
Message-ID: <20260916033327.3054126-6-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916033327.3054126-1-wenst@chromium.org>
References: <20260916033327.3054126-1-wenst@chromium.org>
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
2.55.0.1032.g73a4cd73de-goog

