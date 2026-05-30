Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1303CD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C8710E362;
	Sat, 30 May 2026 14:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UiCbf5xO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1215D10E355
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 479DF600BB;
 Sat, 30 May 2026 14:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD931F00893;
 Sat, 30 May 2026 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149603;
 bh=8ySUZyqoylZe3FBRiencx/+6tPruF278mTF4kjAn/nE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UiCbf5xOCxI5kw9Q7+Zgl8UxmCIdhoCaNYTZTm1YO9OMOdTzvsGjeTwF98a6ydeP/
 MsvFoQkvxV/W5ezE/w0El0q3yDfSPzdkIlnZTEqcRsVxMSJORbXUl7+LwMR5HqxZxl
 +SfLHzWsEw2j52anKCdOYstQpFkgWVtexhb9xuWVsybXmOu1KFYf9OJZdGAgXiHG5d
 8YZ9qFnZDMbAQrO8XL0VxaVmfbPicl3+N0ja3hqSZHapVqDjqmRoIa31IrR+RGd5SA
 WIR53ih/xUK6SVXux9fXDbcpSq1FLCxoUzkySjQtk8fn97WVPz3ozKPLPhhBz9vGV+
 eeNxtlGkKCXkQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:08 +0200
Subject: [PATCH 03/76] drm/atomic-state-helper: Drop memset from
 __drm_atomic_helper_bridge_state_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-3-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/afDpHihztm7KGDTzkXf/gbzO1SwA3BqXqC3UAJudgQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb81+L7vIzBLL32Fvce3GA9bIjk0iTCnPpp5eK8Afz
 6G4wl+0YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyE5TxjwwlDtYOikwoSvx/c
 aN4UNHHWn13+YQf/T5wodEhPO6JpV4vKDp2svvvPnxxxjfx6ZhbTTcZ6h43aX5RbWOXW6HtY6Gm
 VLZq5dW1uz7XNVp4v1pvtZ/+3//4RNzvXgl12m240Ri3kunAAAA==
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

__drm_atomic_helper_bridge_state_init() is always called on a freshly
kzalloc-ed state, so the memset is redundant.

Drop it and document the expectation that the state is already zeroed.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 8f04eae7a754..f0688f2d83fe 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -889,18 +889,19 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
  * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
  *					default
  * @state: bridge state to initialize
  * @bridge: the bridge this state refers to
  *
+ * @state is assumed to be zeroed.
+ *
  * Initializes the bridge state to default values. This is meant to be called
  * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
  * the bridge state.
  */
 void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
 					   struct drm_bridge *bridge)
 {
-	memset(state, 0, sizeof(*state));
 	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
 	state->bridge = bridge;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);
 

-- 
2.54.0

