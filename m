Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCC0CD6E56
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:01:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE4A11281B;
	Sat, 30 May 2026 14:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OldC4Uy/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07ACA112814
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EB2A60122;
 Sat, 30 May 2026 14:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC2C1F00893;
 Sat, 30 May 2026 14:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149654;
 bh=sHFtKnWrI34zpTkrRpQ+/JsWU511j9JIAZKi9kSqCQ0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OldC4Uy/blChrEIDa9GWuXthOQodytox/d34kPk33F2qs0wMC0l9SsIQWqc5UMbV3
 sqp0bIkD1PzsD2VXqQ2OkRBD0MbULuNZdWR9RfC2ZyoR0svJDpAnwn6XGZhth+Vzvg
 E/t9kZhku/bYDwHpqR/1IAmSB6Z1IoyuoxNr/x8uHLveomam1RBmh28MEtSDi2qWGL
 y2yp5qnl7EJzLV8q4FecM6KmT6s5DXu7MrKLNMIXU3G+xxmoybPKA8CDFUAI0gOkHm
 SPiA9L5SR9RYEOF16HGjlkti04PCTBWssHG2K2mtWZ/YsbNzCS5jdvu/2GNrHdp1uo
 mdX/Gfyy2OUIA==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:27 +0200
Subject: [PATCH 22/76] drm/bridge: lontium-lt9211: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-22-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xtdwlMTeBAZ566llkoYTc6gkeLfuXnRCIHNjSsEup80=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb+2fzIm9fmb+3eSEiS9WJ8gJzZxxQrx9LdOBMqvgz
 AfSF9kndExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJNDIz1tlKsS+SWPbgjtc0
 U2+nxgnJt3iZpl7nr3v2dw9D7XZZr2z590u0pdlMQnOnPfWsTO2PZ6yvv6memBq58+8dtfDFF2a
 W7GOqSztfINsaaX7g6CyJRhtz1cpXq6LjJz2u7/L95aRjqwAA
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

