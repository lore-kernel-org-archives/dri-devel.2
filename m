Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5CFCD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA17F112834;
	Sat, 30 May 2026 14:02:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N1ibtgR6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0DF11281E
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:01:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81E90402A9;
 Sat, 30 May 2026 14:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C5E1F00898;
 Sat, 30 May 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149678;
 bh=wIKY5IXZwyD4tPMccW5mjz948YYg2SQvDuwZyEhqPMA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=N1ibtgR6CeP+hNbSimqS+9OQvNsnRygirKWEN0rT8oDV+pxNt6uner+r4dqOiqA15
 l0bOLSaS6I/p5XsMPKoCf30948xf9MEjBLRfx5MsddpwPfdPGxpksEZPbvZ2tb9bTQ
 rHPGLDpUe7fB5DUWgDVqgSbDYDQXhu2OzaM9J8e1Y0t3dFGRMd/lomWB6qPY13HffB
 EPorXboLaSIZ5R7PIf6AZFaRanJACE/1iko2R2W6f52Cdx7UGUBVvQmvlDs0bBQNHd
 lMI7gcAHOTEbat1eMKF7DPNRhzl3b8uystLn1C5lmDNBfkGu6LB0HipyAWOo8KTPA8
 l/GQbXrAy9bqg==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:36 +0200
Subject: [PATCH 31/76] drm/bridge: dw-dp: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-31-875d828d31bc@kernel.org>
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
 Maxime Ripard <mripard@kernel.org>, Andy Yan <andy.yan@rock-chips.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=mripard@kernel.org;
 h=from:subject:message-id; bh=AmFdfFyEykmmYKAyrtUsP/6z0WBogdw728z7CxNXfBo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb51ldju/rCpbeb/gP++OtUoiXy5E1QU29awN25MiX
 Dyjg+VUx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiITztjwwkBl4fT1J6ZmvyY
 4+W3kNvo4oliWwGpnFf+GgHc7P0S18/qqRy6vZnJYtE37hUhlSYfGRve/ldu9/lwQUSd7az1MdV
 5vdYch2x1dt/jNZ3C8mNpSO28e95/09M5XF6tPmJxdsHN5gAA
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
To: Andy Yan <andy.yan@rock-chips.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 21541be094c4..98437dc33d4d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1814,11 +1814,11 @@ static struct drm_bridge_state *dw_dp_bridge_atomic_duplicate_state(struct drm_b
 }
 
 static const struct drm_bridge_funcs dw_dp_bridge_funcs = {
 	.atomic_duplicate_state = dw_dp_bridge_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.atomic_get_output_bus_fmts = dw_dp_bridge_atomic_get_output_bus_fmts,
 	.atomic_check = dw_dp_bridge_atomic_check,
 	.mode_valid = dw_dp_bridge_mode_valid,
 	.atomic_enable = dw_dp_bridge_atomic_enable,

-- 
2.54.0

