Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC17110ED651
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1000A10ED33;
	Fri, 27 Mar 2026 10:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ONZHD4ni";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A42E10ED2B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:36 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C1C33026;
 Fri, 27 Mar 2026 11:21:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606875;
 bh=TmiIsUoOnSYn7v4FOtHaFJlsgHLUN95fq+hz7XO4ZaM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ONZHD4niOtR4V9zeT10ujVftRpoLDwJSIth4pJ8BpIKNnssh1m2mcxvZZcPzaM3zX
 w81w+Ib07Ew2LcKVj5Liok815HbGjTchwdLahGZNKiPGdhms3KbVCbLdYoN5B3Hisd
 gYBGL/CK7UAgklf4JEXgXKup/+BLRAxi/NYcQ2UU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:22:00 +0200
Subject: [PATCH v2 12/12] drm/bridge: tc358762: Set DE_POL and DCLK_POL
 properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-12-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TmiIsUoOnSYn7v4FOtHaFJlsgHLUN95fq+hz7XO4ZaM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpdwFKaJQnmLeAN+G/E87uUvWkLXU7Nf0J+i
 F2MLe41kT2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaXQAKCRD6PaqMvJYe
 9cq4D/9Xg1ouaDAnEPGQvrs7BtaCQ0sA4qjtRSnEwjYXl4fHIK87iNedUtTx3hdnI2ZnelZbZ9n
 Ri4EIafytPXH29cVq0jX0WYZswIYYsWOzgggFE1xxcEutNgBZX/O4DX/sGTNg3Ynzu0tPvluYaf
 m1Q8S8iveY0yU54t45j0hbFqGeMdeM7uBQVKq4KjDBckfN1a2eIprPhEnOG5gmnKyj3Tq2N7pbs
 gOwX8wai5FC6U99BgWxRq54eDzVCKxBnlolQ+niCZ4IPJiDBvgK8f6j38C9Xr0UvV29aBIWT2OF
 +LLdhtWG0X478FaCyzdy1tXgKjFo45x6bHawzYNKaaSE/lLsA9IRjnwmHpVT1kWLgbM+Ek6zRe1
 t6dMHMybh1p6bcwQrquMuuHDaMyWuWqnKQluzcEXOlnnBEYBgXRZEfSAmhfGgJlhGHaY52IHmLl
 0xyt/U87PRyL5QnV7/aMYBIZKuWtrXLvoil/Pd2YGVt0mnENpkTBS8LSI06XgdrKubeIBt6kEHq
 O40Thpi+g/8aRynyt391SaAPNa9sBXzvXuaHDkU0IRSr09ExHqgfIRF+zPbPMc3BqM2FbcQZAtq
 +1dEg1vyALOJtehQFSeCh4oKKwKh5KostfkK8KuS4LNYK3tMTA5snKRnqYMc5WQN4cZfHsY+Ob5
 9ZreSFqjWe5MrMg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

The driver hardcodes LCDCTRL_DCLK_POL and ~DE_POL, ignoring what the
panel actuall wants. Fix this by looking at the
bridge_state->output_bus_cfg.flags, and set the polarities correctly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index eba910ce8bd7..f81aac632eee 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -186,12 +186,15 @@ static void tc358762_enable(struct drm_bridge *bridge,
 {
 	struct tc358762 *ctx = bridge_to_tc358762(bridge);
 	struct drm_connector_state *conn_state;
+	struct drm_bridge_state *bridge_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
 	struct drm_display_mode *mode;
 	u32 lcdctrl;
 	int ret;
 
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	conn_state = drm_atomic_get_new_connector_state(state, connector);
 	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
@@ -243,7 +246,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (ctx->use_vtg)
 		lcdctrl |= LCDCTRL_VTGEN;
 
-	lcdctrl |= LCDCTRL_DCLK_POL;
+	/* Note: DCLK_POL affects pixdata, de and syncs */
+	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
+		lcdctrl |= LCDCTRL_DCLK_POL;
 
 	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
@@ -251,6 +256,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
+	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW)
+		lcdctrl |= LCDCTRL_DE_POL;
+
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);

-- 
2.43.0

