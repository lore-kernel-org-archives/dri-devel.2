Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5CACD6E57
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB860112818;
	Sat, 30 May 2026 14:01:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O+v3hhL9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F00AC112816
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56B69600BB;
 Sat, 30 May 2026 14:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F051F00893;
 Sat, 30 May 2026 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149673;
 bh=PspEh4Oi/RLTFZrRKE4ENqolk7oIwcH7ZK1MtDRXqf0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=O+v3hhL9krVp0x+A+U+92Sen6FKRfcrlYBZQieHZ1uvgVauLO8i2N6ZQ66hBpNMQj
 A8jcXufGRYYLhAs02eAvXuoxnmhUwoT1dG5NSU90Q3j5ZJEd6QXuMszr+u3LY12+Or
 VPVMX64IBEjCJAubyhcZVwmEhFTu7krf3M1kJPlLgbfVieYzhdeebKX8rvwaSTzBEj
 FafnUp6I0OfG+D5gd2CE0OVgEc6k3TaoSczuLJfkWUQjlnn/whpWEijO9agG52ckl+
 g7p4wLlivFWy3OqXx9c0chg8Kw4bXJ1yT57kDevQhRAyFF4ICzbfi5g2UXntF+Xrej
 DSYj2ifZOupiA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:34 +0200
Subject: [PATCH 29/76] drm/bridge: sii902x: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-29-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ME97fEjA9FS9LjAyeYOFeopdZeJRhulg+SzyfgStUHE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb51Op7bIPok68C24oueu3J2HMseeXpJz5Uh5pK9k9
 SxW95ZUx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhImCtjfZlmXqfIL/Grc/7W
 7+cuOnfseIz/trP9R3w2iPYpqhv7d6zy4HoayN0fdv5s7N5tGR+1GBu+NReZlxdxxa8KzyuZufq
 sZe72rNUl4Us+xs379rd85ZoTJjnrd82R5tThODNhQXzw/QMA
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
 drivers/gpu/drm/bridge/sii902x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index ea543be4ae3e..30d04324d8ce 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -542,11 +542,11 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.mode_set = sii902x_bridge_mode_set,
 	.atomic_disable = sii902x_bridge_atomic_disable,
 	.atomic_enable = sii902x_bridge_atomic_enable,
 	.detect = sii902x_bridge_detect,
 	.edid_read = sii902x_bridge_edid_read,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
 	.mode_valid = sii902x_bridge_mode_valid,

-- 
2.54.0

