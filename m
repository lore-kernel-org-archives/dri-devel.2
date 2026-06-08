Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2EACD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14AEF10F4C4;
	Mon,  8 Jun 2026 14:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MrSM1BOU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C6810F4C4
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 14:36:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D094601FF;
 Mon,  8 Jun 2026 14:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8581F00898;
 Mon,  8 Jun 2026 14:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780929413;
 bh=NPO3FcIiWDfmeQJkzBV9bTYrsuTU87auHXDZIVN6Xu0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MrSM1BOUomLM/6H2ctk0Dfm9Hd0BSl5JbDI9UmLO/wQ0BNFkLUWX059vP5xngaKTp
 8Yz5m5EftzqXiem5yEieOoUHJrXMw6QPFcVsZbI6hTtBpR8iZkhCREIMTYZCbibP6b
 9YVsaaj+pIxBIyZ6TE4X6QAAUii017lEUsF0XARAmooJHQuV7G3E9VShczfCzq7Tdh
 YNdclM5a6HSPZa4ob8S7CH7EctA1w7+oEq2Gx2zyWrfucbzaeTHaxmH2E/huGpTY/L
 ONwSbth4W5oEKad4ghUvpjFN4330jfaP+adA4b8rbt3V3bas4G7xs9++DJfXbTJGeI
 s3fpMZjBha7rw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 08 Jun 2026 16:35:52 +0200
Subject: [PATCH v2 10/78] drm/bridge: anx7625: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-drm-no-more-bridge-reset-v2-10-0a91018bf886@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QFAEATal3+wjPn8ucBdTKyeRgZtJRXxn8AK1ehiK0MY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlqlz3TS5Zo/v7n+6lmj+JLyxfbG3XDIrOfBHmKKP2T2
 rPdnv9hx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiIeBxjw+V2qykln548XTCl
 nOP81xuz+O+9b9jANv1f1OkbRr7cmuGK0xMexT64eeH6xB21+3YJpDE2TGhlPFZb2/LE4wm/00u
 bZveYH/Pv3GYS2Rra7RYzx27Z7k7PRCPVngp23ydnK+xnm1cBAA==
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
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 513c11cdbc74..2e2c6d925506 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2677,11 +2677,11 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
 	.atomic_check = anx7625_bridge_atomic_check,
 	.atomic_enable = anx7625_bridge_atomic_enable,
 	.atomic_disable = anx7625_bridge_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.detect = anx7625_bridge_detect,
 	.edid_read = anx7625_bridge_edid_read,
 	.hpd_enable = anx7625_bridge_hpd_enable,
 	.hpd_disable = anx7625_bridge_hpd_disable,
 };

-- 
2.54.0

