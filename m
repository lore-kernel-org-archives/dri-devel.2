Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D00CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B82112828;
	Sat, 30 May 2026 14:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RCXv7HRk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3B6112814
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D17C43655;
 Sat, 30 May 2026 14:00:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A491F00893;
 Sat, 30 May 2026 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149651;
 bh=Z4RIcGkl+DQE5cM/ztX2rJ25aXpj99OGyJnfs9ZoFr4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RCXv7HRk3nKymBuiPFsWW9JS3+BDa09vzpHuzPJ3j+xLfmt892H+nLY96FdXTUGBE
 /YttSdzdayOOR0U8e0Gi97UPDWvN7zLAdM1x4YtsmrX7Mk00gBYcWVfO2oNL+hzDMt
 7MZIQfPO3Sl9uOgkp8YLkknC5QBIpJnFKLAzKS1pa1JdubTi9rZtgYFdBXuL48nwqO
 V09nfBQEtkf+v0cQoRBkLqDDl9QVRJG7bUl3XUKxLhl/MkLwqztOnQEDbiFGLxJjZi
 Hp/r1WIjA/+smco/GYSzWB5EZE0HOtar1nnG0AELQzqwT9DmgdL/3391HCwNGp/Yf/
 qxLCqxHHeHCyA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:26 +0200
Subject: [PATCH 21/76] drm/bridge: ite-it66121: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-21-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Phong LE <ple@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1338; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3jx/yfqGdheDv5Q+2tUm/LjobgaC0w98JU7XQ/Wn8Go=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb+3k53tdXn8zONKtO6Q7/UPLoUUL95U+myI61XjbX
 st70XOKOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEDiUyNuyavjjwr05UX91C
 hq96UV+Vnz5mvFH2ccfi5PaZ/Szlxfnm7a4Jqw8vecwU8mtW2COhWYz1XhoL8mWOnUs7t0LRtlH
 7rf3xuEyvQzKZS47V5bwT7z+bX7A05fHSy07dHg6q2wytN5gCAA==
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Phong LE <ple@baylibre.com>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index a2f48db369e3..51fc68ffdf8f 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1541,11 +1541,11 @@ static int it66121_hdmi_audio_mute_stream(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs it66121_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it66121_bridge_attach,
 	.atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
 	.atomic_enable = it66121_bridge_enable,
 	.atomic_disable = it66121_bridge_disable,

-- 
2.54.0

