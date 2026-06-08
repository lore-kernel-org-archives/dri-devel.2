Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA074CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C52C10F4FA;
	Mon,  8 Jun 2026 14:38:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W82K9nII";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1868910F4FA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:38:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E84B601FA;
 Mon,  8 Jun 2026 14:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69081F00893;
 Mon,  8 Jun 2026 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929534;
 bh=+JMMUJnOZpTITDM6oIihe3vGgCV3w7ccCufoOcsZaU4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=W82K9nIIBfmsZIah33myIT995pYdjp5fTFRdWcR2sWcOtKlJDoFVnEkVi8UKgjXtl
 GYB5t4nCF26pBSd/H0jIjEmoX4lTfIZs0ZjvqWSYQ7iyIsCA9Zq28elP9V68eq6vCT
 F6kg9B9gZDiWuZvJs0T864z57KDEktXN/v5x/UvD1XTVipu31fHQJd9q6m6dvnzZkO
 vxX2JQGL16hR7pb4bcSqEaJT0COcTDSb7Jw2uJxMcZcQSBy0jNqo7utVT2jyfPGvwh
 rTzKn307sKgqR8tWpUmeOOgFWGCbShg3KRllxZ1Qr82oEFcsCB62+vC4lYFwfUXHN4
 c6j9UCuuD86/w==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:37 +0200
Subject: [PATCH v2 55/78] drm/meson: encoder_dsi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-55-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sXx0wMZeYzHhXbB0JWwNwadgHy4wy9yVO5hFwPLtWHk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql2Pfs7Uout4RTeHdo1pd7FZmZM6rMvOow9FrEltWT
 +GpfyvWMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACaiLcRYKxx2ad/LW5MV5zo3
 Tu+4rmohH7Xiq/ssBdPHGX8198f8mZo4463b3037I6tfO8ZFnr7jyVhfFlaq4D4pgk1wEYPP04+
 OPDEbJnxgNAgR1vp9dJqSb8dktzuX9uz1P/by1GnPS9M/+vQCAA==
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index c1f4685073bb..3e422b612f74 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -94,11 +94,11 @@ static const struct drm_bridge_funcs meson_encoder_dsi_bridge_funcs = {
 	.attach	= meson_encoder_dsi_attach,
 	.atomic_enable = meson_encoder_dsi_atomic_enable,
 	.atomic_disable	= meson_encoder_dsi_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 int meson_encoder_dsi_probe(struct meson_drm *priv)
 {
 	struct meson_encoder_dsi *meson_encoder_dsi;

-- 
2.54.0

