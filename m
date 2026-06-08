Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2942BCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A70A10F4D5;
	Mon,  8 Jun 2026 14:37:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="izyLNHLi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E657C10F4D5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:37:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A949601E8;
 Mon,  8 Jun 2026 14:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4691F00893;
 Mon,  8 Jun 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929451;
 bh=13nPAIbgVGZZZAykSv0lySWdFKMgk9LG+TQfWIgRu/0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=izyLNHLiH6ENXwuDoQ/XipLgcFFQSa43deRvvPCUTzW9zBDeyNbAUjdlX9xEI3cGc
 qmKaEMyvqp9ls5u51BC0AnAhnFBF0JF9Z3huuoNQO9psWwTNS442Y2G8uYfdnCNhAT
 qXaf44s4Jp9Am1nZQv+E5koihyaCT3FT67fP7XY1T9b3jm5fqkGk3uK/UImYSCrA1M
 fF6H35lS2J89Ja8s5WiXsHipq15k4HjhmFievwvmFWpCKoUqCGEMqA8UhoIM3g68kP
 6RYqZVOYhfPc3jDyIFvcQ15DkOqQbMNsbLdw72iyNyLAQmk5mp8vaPCGDhbLWF3ESq
 uBH8Txm0JZ7Mg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:36:06 +0200
Subject: [PATCH v2 24/78] drm/bridge: lontium-lt9211: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-24-0a91018bf886@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aqyxTKfFfiXP7d4Ph9PeRtJeZUQDexHNbW+6Up/YxE8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlql/0Z+p9vj4sU+ur9kffN3cfCW/+8u6Vl4iyrvknqm
 +r6V39kO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmcCGcHEKwEQ8lzI2PPvv1DzT4W9E66+r
 cfPdJi77bOXNcHJC/KLH6549joz8yi9vV/OmacYUm0US876/V0m5yFgrmPx+QzubU3G2zInac92
 Z+jvvTk/riyturOHSf63Tzing+LT5x9Obp6Yppq68Z7Fs/mIA
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
 drivers/gpu/drm/bridge/lontium-lt9211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 870175a84839..f39d83a5ae37 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -617,11 +617,11 @@ static const struct drm_bridge_funcs lt9211_funcs = {
 	.atomic_enable		= lt9211_atomic_enable,
 	.atomic_disable		= lt9211_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = lt9211_atomic_get_input_bus_fmts,
-	.atomic_reset		= drm_atomic_helper_bridge_reset,
+	.atomic_create_state		= drm_atomic_helper_bridge_create_state,
 };
 
 static int lt9211_parse_dt(struct lt9211 *ctx)
 {
 	struct device_node *port2, *port3;

-- 
2.54.0

