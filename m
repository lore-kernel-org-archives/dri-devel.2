Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KNRcOi4O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A5810FD2C;
	Thu, 26 Nov 2026 07:13:54 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD2C10FD2C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:13:48 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8a594d313a3so4453053b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795677228; x=1796282028;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s+aLuJucBwaSWJgFUDaZ/eOjRwoee806v+5/S5Iceo0=;
 b=KNRcOi4OUPermMPBeooeZ1eJh3DGa7OT/uQrSRBtSuTK4jkCXI5NBpeiJBbRVj32HS
 PWMSQqYV3QPd4vtGSITg9SifuH0eAcmchqCBqRwWLUncrTs2wJI0LcM8KsC3JgVHrPw1
 gKlJarzlRHe/iPHuqrwfVitFsq1QXoq2zUaOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677228; x=1796282028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s+aLuJucBwaSWJgFUDaZ/eOjRwoee806v+5/S5Iceo0=;
 b=K9KUcS4KxkBh3EqYOVRArHkH3W78F+yNW/slThCWcTZeI7bUG2yZomUgjfnfsh8WFo
 8DZ7raPT9OMtfOQxAqsCUlTkK27xGfBzcouFv1knteuKKzb+YxWDmkqvZsNsCGxofW6l
 UVOpq29l2ANhiMxAJcIuv2yoAmkTRflBnJjZ3a1PjM0MuIHxB9aIyqHqx+S0KT0cx+M8
 AzODhnXA6WRx9R32Kl7J0W7eJvtGpQeMC8L297CqJfOsgchL9/mI3wqUXGDMnVw5DXya
 PWupECTnv7cwOwlD8TqS1ataHH0jC7iN3ya+C7KkOs/MiYcV3eZ7DwfnLmJM+XqgV+gw
 3GVg==
X-Forwarded-Encrypted: i=1;
 AL+hErFHmOds7gHui4oKJhc2EsVDfyiyZJ39S7VF2T+luEO/9aO8gNB9wegb1IMVJPcACU630oc2cpqHo/I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/5Sbt8LHoQNxDR9dc9MEywkv7T6l2k6Ip0t7Rd3xEpFG15xQoe
 YQuIDLHsPY0Zsgd9rFpd/t/5BSmYrSAU9RoaC6I0ntGMD7zNhjhEPBp9JVHUgHO62Q==
X-Gm-Gg: AZFdTZdgBxwfILrGmgWuz2W1xUt7+mrWs4IlJc+Whmv+WqyL5FdU9IdFsX33MbMPtl1
 RMb9kuihKS2voqGOwU4lVyzkwbYuM3RcyfBgm4x5uK9LFM1/IccEoDOG59pqKvC4COW6fJcHjM5
 GFO5DUq6Rb2D7N+yHlF6mVHBgprxXvsQOSo6GRrclzY1a0qiCNB7osYRHyQux29w0P3ow0gXmo0
 s5fDp/rEqNFBJYLEbyuYjVVEq3a5DAFVGnEoS6oneGjOVAbVzSzwbdmJlT7BcMZcA6nsQd+XfmJ
 ZKrR1MZqeVCO+QaEZ5DpdNDnWn54ewtrLuVAOk0vgQVdT8SCI4ATnATBHIPnfog7opAVu3a1Xs/
 P4B1NMWFKweDMQIzItOAXWj1vT3RXE9IcE9ebuF1tuZ9ztG70jMD4/0LmHCGMIMAtMGV3t3GxRt
 fv3eYv2CpHDmpRX4ZsdfHAJwBkytWnkm6oPEZTjP/4MO/9qkHBFLN0B2wSVI24UnlTy2PYhvKg2
 vt1YuPnChqh/EJNZlkw5KfBT2JNeVSWzeJKM5WrkOGqffkOGtZrPWzv7QbCnWZz+wTwN5XZV8WI
 zdM8VBpHlFQmJDAarF9tTL8VTDgSI4oX3arucUbsHNjISqduM+syEBCTXFheTC4AmeTF7bPthFx
 EAuTCfg==
X-Received: by 2002:a05:6a21:3f94:b0:40a:56b8:2551 with SMTP id
 adf61e73a8af0-40a56b82debmr793737637.17.1795677227780; 
 Wed, 25 Nov 2026 23:13:47 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-8cdfd2d2fc4sm4664437b3a.49.2026.11.25.23.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 23:13:47 -0800 (PST)
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
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH RFT v4 4/5] drm/imx/dc: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Thu, 26 Nov 2026 15:12:52 +0800
Message-ID: <20261126071314.253890-5-wenst@chromium.org>
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

The hardware is programmed with clipped source and destination dimensions,
but the framebuffer address is calculated using drm_fb_dma_get_gem_addr(),
which uses the full source dimensions. This will not match the source
offset if the top and/or left sides are clipped.

Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
buffer address starting at the clipped boundary.

Fixes: 711a3b878366 ("drm/imx: Add i.MX8qxp Display Controller KMS")
Cc: <stable@vger.kernel.org> # Needs drm_fb_dma_get_gem_clipped_addr()
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/imx/dc/dc-plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/dc-plane.c
index 62dd0576fadc..35eb5039f5ac 100644
--- a/drivers/gpu/drm/imx/dc/dc-plane.c
+++ b/drivers/gpu/drm/imx/dc/dc-plane.c
@@ -65,7 +65,7 @@ static int dc_plane_check_max_source_resolution(struct drm_plane_state *state)
 static int dc_plane_check_fb(struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	dma_addr_t baseaddr = drm_fb_dma_get_gem_addr(fb, state, 0);
+	dma_addr_t baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
 
 	/* base address alignment */
 	if (baseaddr & 0x3) {
@@ -146,7 +146,7 @@ dc_plane_atomic_update(struct drm_plane *plane, struct drm_atomic_commit *state)
 	src_w = drm_rect_width(&new_state->src) >> 16;
 	src_h = drm_rect_height(&new_state->src) >> 16;
 
-	baseaddr = drm_fb_dma_get_gem_addr(fb, new_state, 0);
+	baseaddr = drm_fb_dma_get_gem_clipped_addr(fb, new_state, 0);
 
 	fu_ops = dc_fu_get_ops(dplane->fu);
 
-- 
2.56.1.839.g22a8290db9-goog

