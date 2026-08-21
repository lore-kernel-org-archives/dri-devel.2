Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FCAC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D7410F114;
	Fri, 21 Aug 2026 14:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YsCr6XBq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF0110EFD2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 742BA43978;
 Fri, 21 Aug 2026 14:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077AE1F000E9;
 Fri, 21 Aug 2026 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323201;
 bh=rRUq+VvJ/etmUgWyK2xS3eWWCKS9jPi2cmCnYxuyiKg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YsCr6XBqs5yGI7wUSZh3I+d3knbVEcUqZooG/uHyDkBf1MO4ZZnGmn1T6MP3wy92Q
 6vvT4BILCUvhv59tW/NpE8WzLZbllAeif3EeUMK1mfLiZ+NyizRiKM01OW7sksdrTj
 3G+asXfVgSouJ4IZRBggXKeZWKUJj/h9JWip2Xq6gVWJB0FOjNIS/bTfjXZ/GOY2/r
 9p4KtN+8K7kzi/RPq8SsJyMuRtdfLsxjuBKhk6XcyVlQ66gNRoxEXVIk8TD0nNsGvP
 UAIb3bNUuZyFamFDhRxN4rBKoAtFJH5Kmc1QInepuyawzmanewUF0c6vq9scrl6NGe
 pDI4saKpDeK5Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:52 +0200
Subject: [PATCH 16/70] drm/meson: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-16-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3klHU4QS+RdcUIWE+g3Eg/9StWd9YgI4ee4Mbcd0ZqU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSf9CJr+ZuGxztn0nt68Nc+E1K91H/Id+lG2OfFuvW
 SNwkvFVx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIC1PGhp1T58V2lvDKzbp2
 hTXiHdPPBbc5ZIo49yz5XNOSVNN8PMLriOXXqTql50L+z4/SmHZmJWPDz4U7o6KbZySd2yRo+rQ
 jYX3qkfBU6YuzBU+4q59gfmDvqsGp//jX7w+SQovT5W+HrnMBAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The meson crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org
---
 drivers/gpu/drm/meson/meson_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
index b77d2d24ead1..056dbea8deec 100644
--- a/drivers/gpu/drm/meson/meson_crtc.c
+++ b/drivers/gpu/drm/meson/meson_crtc.c
@@ -72,11 +72,11 @@ static void meson_crtc_disable_vblank(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs meson_crtc_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.destroy		= drm_crtc_cleanup,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.set_config             = drm_atomic_helper_set_config,
 	.enable_vblank		= meson_crtc_enable_vblank,
 	.disable_vblank		= meson_crtc_disable_vblank,
 
 };

-- 
2.55.0

