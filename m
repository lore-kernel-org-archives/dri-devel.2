Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F66DCDB466
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B55110F5B5;
	Fri, 19 Jun 2026 12:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DIKGLO82";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8D510F5AE
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0344601EF;
 Fri, 19 Jun 2026 12:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30791F000E9;
 Fri, 19 Jun 2026 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872091;
 bh=d8no9vO0xUCN5lmyfMfQLn/p95NgMjQpfiIyeC36spQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DIKGLO82jF8kvOyGHfT5oMA5wJigg9/j0ufXW6SQNFt8zpu3mWEt0OOLa8y0GOGql
 EohjqzzvbwPchXLejvaxBlCP8OBezpZveyStVNIk8P60cHMkUPojooXPi3IlXyDYiD
 OeW0afKleJE5CgV5LS7MF52S9rMQeAHQb1GndrxTXPkS6vjMA04I+jQ72sBzWtAiEc
 kqRoUWEUiP7wmZT/85mAHmryb71yTYvBlS9MmzGbPiVZXpqEyANLGTe5iUsNpzjHyi
 w7AEWSYHe+H+9rDk2gi9ul48hGVgZHf4sEX6Ww0hbofBM9zOqMLMVAMAQVherrWroP
 +Np2mKBp8O26Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:21 +0200
Subject: [PATCH v3 76/78] drm/bridge: cdns-dsi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-76-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tvYGpVrWKG2kvXqjL0abk4PUwEBYR3U0WWnKknAQ1Ek=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmptxCpisn1Fz5nPpoe4BprK/JOivXlyrykeq/y+57y
 yxbcmxWx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIAwPGOs0LF94ov/Ce/N8h
 p5qZYc4R85rnJ1mPtDFtaeix9np0WlBa7bqNnTh/+d4MhlnnvvhdYGzYGNZ8uNYoYg9L2r3C2Hk
 i6dOCao2iGeas3/tQ63rdshPrnjU99Dsg9HDX0usFLz8zX2UCAA==
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

The cdns-dsi bridge atomic_reset implementation is semantically an
atomic_create_state: it allocates and initializes a pristine state
without side effects.

Switch to the atomic_create_state callback, and rename the function
accordingly.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index ca946e755818..c3e466ded84a 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1007,11 +1007,11 @@ cdns_dsi_bridge_atomic_destroy_state(struct drm_bridge *bridge,
 
 	kfree(dsi_state);
 }
 
 static struct drm_bridge_state *
-cdns_dsi_bridge_atomic_reset(struct drm_bridge *bridge)
+cdns_dsi_bridge_atomic_create_state(struct drm_bridge *bridge)
 {
 	struct cdns_dsi_bridge_state *dsi_state;
 
 	dsi_state = kzalloc_obj(*dsi_state);
 	if (!dsi_state)
@@ -1026,11 +1026,11 @@ static const struct drm_bridge_funcs cdns_dsi_bridge_funcs = {
 	.attach = cdns_dsi_bridge_attach,
 	.mode_valid = cdns_dsi_bridge_mode_valid,
 	.atomic_pre_enable = cdns_dsi_bridge_atomic_pre_enable,
 	.atomic_post_disable = cdns_dsi_bridge_atomic_post_disable,
 	.atomic_check = cdns_dsi_bridge_atomic_check,
-	.atomic_reset = cdns_dsi_bridge_atomic_reset,
+	.atomic_create_state = cdns_dsi_bridge_atomic_create_state,
 	.atomic_duplicate_state = cdns_dsi_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = cdns_dsi_bridge_atomic_destroy_state,
 	.atomic_get_input_bus_fmts = cdns_dsi_bridge_get_input_bus_fmts,
 };
 

-- 
2.54.0

