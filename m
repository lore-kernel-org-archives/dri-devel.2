Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F989CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C3B10F580;
	Fri, 19 Jun 2026 12:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hb65237u";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3F910F57E
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:25:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22D55401C5;
 Fri, 19 Jun 2026 12:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DC91F00A3A;
 Fri, 19 Jun 2026 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781871952;
 bh=13nPAIbgVGZZZAykSv0lySWdFKMgk9LG+TQfWIgRu/0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Hb65237u4hOypFPVA/xiaQHVb3Xk2Lt+c5I/cvtNJdar2qt+xXVIIMxK3IjFKEtny
 86fk3eMz75NkEv2Z7l6Y7jFrdm3Q2iuhOvbmKfdwXw6335oTUGvwSpINoRoTjh7/IU
 24SfbLnX6zMXcx7FdacFf7DU8okkaiHSMyoiH0g09Be63QtIgYcs93YMTUdK4wXlaX
 WfDpghvwDkYMef1iEDqID+3/iuQ4gkxkvHXwKEwe2pOU1p/bT1mEHhvfOV0n/XvLhE
 xT7xNwFi2MhEg4n+pZJJPYDMBh2x+rEFBJu598SFLFl3cWGyR+rLT3LXJcFjBkZqSY
 HL2X+QX2dkeQQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:24:29 +0200
Subject: [PATCH v3 24/78] drm/bridge: lontium-lt9211: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-24-ff399263111b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aqyxTKfFfiXP7d4Ph9PeRtJeZUQDexHNbW+6Up/YxE8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmJl+yDO/oPfAp7uW/diRar2HfZfkOhq7Ts08eUd94c
 8KvG1PvdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJTFnDWMP5sc6/cWMgT9+f
 OUw8qU5V32uqti2X5HhXHv3SVPDwxYmlF/f8jRGo3unYs9jEZ+vGAMaGq0zG0Tpz8xdNckzl3sT
 8eMcqHdN+DZmds1y+Rsi1nJ536+mvveVJCSapXt4TNaaaBx8FAA==
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

