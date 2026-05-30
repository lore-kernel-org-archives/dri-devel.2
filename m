Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA4BCD6E52
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4FC10E369;
	Sat, 30 May 2026 14:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WGeHoVGa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DE410E368
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:00:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EED8540423;
 Sat, 30 May 2026 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571FD1F00898;
 Sat, 30 May 2026 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149621;
 bh=QlrmuC8EUIuO8rOzwfvNG23KeErNP4/CnCvZbc66z1I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WGeHoVGaIYQJox8plB1Q92zSs8+gztNlo9QOWuu3eUcDWqs6isw8eRFoemEpwup14
 IHK23yUAiLH9WgEUBIByEwdmfrCfmazoBzAVDUi/MZSLO0V70Xn6IzuQueXgaro0Zv
 ovL8Uzt+Nz5BSNpKa4oH7L4J75oGV6JFMWe1AraBfU+m+cC/64L6pI//Toj/YNi/tX
 clOjbxNgoq2Gmo0470AOFkLEOQLUQHLMvYTRplvAVQwLqTl/9h3+f1oz7GoP4W/Lnp
 pYD9N5Tf5s1kV7mqvG5eM7sfkwQ7EQodUo8I2fr7lVoNF05BqJZyR/F7OZMc+ufaxX
 jQ0lxO8XLGP9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 15:59:15 +0200
Subject: [PATCH 10/76] drm/bridge: display-connector: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-10-875d828d31bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=mripard@kernel.org;
 h=from:subject:message-id; bh=arqq8+Sz9fPndmB7jpd+oDkBircl+R1ZX124Hc2hLv0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSby33/nY22lo1k9NB+rbTi7ara/8eu2exd887+171Z
 aLvl9id65jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATkclnbJjb6psoMym9oiEl
 +0P/Yr/wFauYypx470V+nBMjzZP72/PaBc22jcGBr9VKVf0tpVN3MTb8yFq2tdXlWHlNjtKFLVe
 FuerzjL3yvB9cyJq3bPLLNRLvl/lGXSgOXPhTIX3dEwFhu7MA
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
 drivers/gpu/drm/bridge/display-connector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..e849037c64ea 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -181,11 +181,11 @@ static const struct drm_bridge_funcs display_connector_bridge_funcs = {
 	.edid_read = display_connector_edid_read,
 	.atomic_get_output_bus_fmts = display_connector_get_output_bus_fmts,
 	.atomic_get_input_bus_fmts = display_connector_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static irqreturn_t display_connector_hpd_irq(int irq, void *arg)
 {
 	struct display_connector *conn = arg;

-- 
2.54.0

