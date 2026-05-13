Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1B2CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A855F10EE58;
	Wed, 13 May 2026 13:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e4cAPxk5";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA22510EE51
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:47 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8ACC223B9;
 Wed, 13 May 2026 15:10:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677838;
 bh=bGsU16PnfHUZUKFcdLSxXUytLC8RK1SYoTTCPWtBrT4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=e4cAPxk5MefRvrxv3ogR4+nEGHXuj4xwXIwl/pD8LSHF/HonhVfyBZVAPJ0ID/n2A
 FAPli3YWv8hRZYAQJYikqvzB/2ughnxQdCRRQgaph2cpwhkmyZTOIO+ejXumpa17HR
 wWZKShLH5Bb2TY4U05aKxs96Z/DPG35V21dOVAKo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:15 +0300
Subject: [PATCH v3 06/13] drm/bridge: tc358762: Improve DPI enable handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-6-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bGsU16PnfHUZUKFcdLSxXUytLC8RK1SYoTTCPWtBrT4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhMlfg9a3mr0GcykUQc1mvvw6dRO51DRjw+f
 kDY/RYu26qJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TAAKCRD6PaqMvJYe
 9WRhEACizursv9RIz9xKubsC0U+qYmJE8qg1fJ0OgpLpMUjqVuxT2ub6522ziWhWiipq3rzUoyr
 /NB2PEBfy5aNDPNyOgj4Ggs01kPWCNiRXgiXNCcjUABwqEtrrIjqFLU5FxYULHeFZZxsKk52rKT
 PzgSVmM4lgBSrwL7Y/z5Cnsc4/2dz/Xy1Xfwyob9UjDNgddZRTgfOEcAVG95itElw6QDHI+jPvN
 JpvFgo7ZhiVQemM44Qifg0xWx80KqBvCkBfaeUx0kDNdHIc2ObdY1Yv6IkDRs3pvAFMPn9bnWv0
 cSaPLS3/jUtx2a3kbdOW/+f8PBkWqFPlQzVtmLIyfZAaIzrmX6zNLwxoYhZyIfHeBYTROiB9TqS
 JqaWnxxoi71ZSe0SjkhFMo796vu/7jH6KtHUrJ8O0FkouGeXb+oOMqaW1f3MwX8RvuGax1v1mnr
 XmS6zf9CS8Qh56/qdhHL4zchP1u8Fh3bKZfAOdsR+bct8Kj8xDBITorPE663A9NHfbSCBvBVcYf
 9BI/sCF5rFSbE5uFaeOa9nUA9IZzM/Uh3jpUV3G6LCtqowAqX7qoW/Ybs0673TiBOi/qS6Hyh61
 z0uqVz9fnrcuHtR11fSQhCI5SsPqBWk52xYWLMnL0tblCvL2A9wlRbmvHj0Wyq0dWQQKPXXW1IE
 ponzYgZfEMZBekA==
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

The HW reset defaults has DPIENABLE bit as set. In the current driver we
configure and enable various things while DPIENABLE is set. This results
in a temporary DPI output with wrong timings, which may cause artifacts
on the panel.

Fix this by clearing DPIEANBLE as the first thing when we start to
enable the display. DPIENABLE is set later with the rest of the LCDCTRL
configuration, and at that time we have done all the other
configurations.

Also, for symmetry and possibly improving the DPI output at disable
time, explicitly disable DPIENABLE when disabling the bridge.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index a9c30acf1b14..7840ab3454f6 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -135,6 +135,12 @@ static int tc358762_init(struct tc358762 *ctx)
 {
 	u32 lcdctrl;
 
+	/*
+	 * DPIENABLE has reset default of 1. Make sure we don't output on
+	 * DPI until we have finished the coniguration.
+	 */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	tc358762_write(ctx, SYSCTRL,
 		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
 		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
@@ -186,6 +192,9 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 
 	ctx->pre_enabled = false;
 
+	/* Turn off the DPI output */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	if (ctx->reset_gpio)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 

-- 
2.43.0

