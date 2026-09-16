Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96498C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B946E10E1CC;
	Wed, 16 Sep 2026 03:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ygkm1fNT";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B365E10E253
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:33:53 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso460384a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789529633; x=1790134433;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nb71HvzDE3B3FVkEVJ/TFE9xXljAPx+xdoqH1xLqTX8=;
 b=Ygkm1fNTSzuwgPB5SGi3169nCbBq3OS6y+WPnZh+3/fKVJgydY3rhvCzaZ1S0p4f5O
 o991B1/HwQkh/Rzt+er6anRtvEYkQFWrpNEGzq9PQE8pAf46N3gN3mfHFDqbPK3O4ow3
 AiDXS8P2usHoQUA7jBMs5QaWjisDPOEEwMSZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789529633; x=1790134433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nb71HvzDE3B3FVkEVJ/TFE9xXljAPx+xdoqH1xLqTX8=;
 b=DPcX27xGqIlae8vJQh2SrpiPFSliLzLu56HwUsZ+BMvCPoWIAAHJd54Pr2ea4YWZjC
 jNPAAEKjOydph3zGswXwSTtCFS86qAA63xNFZ1vFrUDDqIZnA4bnTNui/bRkbLxajCa8
 OM2w56OOSvF5AZHyIM6xyipJAeCJXffvDAUQzkTxeCfNSNSyyQ8wKQIFJhV+2mkvzXPB
 GhHobGv7FRyuC3gsQjw6Zxt9NeE7mG7HW1r4qRl+Czasn5bNEHCFzHxchJweJqyBMy6p
 3Al/0fq6/U54wUtlxGFAKhbX9p+yoULYeHDOxfbVTQM7h5UDuanvAuss1oNxRctXeUFp
 HAGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuvVXheyn0XNFAjms/k/XCDxzDZgdFH9bJjkUvorM9hGQZ48B5GUBun257C9BjFYyOuQu9sZrobx0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kXAyFw00vhe9pPqbC7Xuj55Os5LihF6M1Dt+DSobpS2j08NRWc
 GXtwngUs3GzRtZH7gk9EZ0yK+GrleTUjfRL2yq6s+I5UYHinZbP8yGepksdRoz4T8w==
X-Gm-Gg: AYBFou3NqPyUmKV9u5wJ6nRd1Sie8Tzg8AbqDpC8uW98gC+ouoy2iiKWhk3SIsrQqAh
 7CrPnPTgYUakxOTOsj8hlO2mqFKU6ckF8mbD6U10Il3ts+5Ve33QRWjJyN3qbOxnveN1MYnooRB
 jVkZWE6g0KH9x6BB+LqMrULFjSgA+HJKqKHid15h37mh+871vovz239Nu79EGkDGLeM9yxSl+MH
 QX+3mWKy5cDzppyPAJoxliGhmGy9NoQzMfxdsEyQhBz1uvWrNDPL9uhTR1MvWhC8+FN+UC03i/k
 anmlq8voQY8RhkvLIeg0JhakU8DkvUwsROQ3yN9cTHawVzSwTGfya1pTm/Qz5IjEGJLlu69TuRg
 /LpZmatJ7J4X89WoCu5yPyLPvJfOclsWPKshAVL6SkYOnH5lraxDjzGsUMVb8IITIT4pFG9feB9
 jP3eoGzHs4YTD7P0HSnOpXdbdE4e9GJ+WW+6BCa4fSSCh8nF8lHa80fkOAbksaYVLaqs6fIEa1L
 0nzm6sAgckqLSbLWA0ONseesUELzBNWrvLEGTeNR17Sp8YCs+ZF+3O2eg==
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id
 98e67ed59e1d1-39e1e4c54fcmr2477670a91.20.1789529633211; 
 Tue, 15 Sep 2026 20:33:53 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 20:33:52 -0700 (PDT)
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
Subject: [PATCH RFT v2 4/5] drm/imx/dc: plane: Switch to
 drm_fb_dma_get_gem_clipped_addr()
Date: Wed, 16 Sep 2026 11:33:25 +0800
Message-ID: <20260916033327.3054126-5-wenst@chromium.org>
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
2.55.0.1032.g73a4cd73de-goog

