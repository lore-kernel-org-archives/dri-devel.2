Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889B606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256 header.s=protonmail header.b=6+RbfjSH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A1010E3BE;
	Tue, 27 Oct 2026 10:34:11 +0000 (UTC)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A60210E3BE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 10:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1793097243; x=1793356443;
 bh=zyHYjA31DuZghusM7MkgZ6KjeW0zjBMsh+d7uw7Mm2M=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=6+RbfjSHHdiTH/anRCtv3qs6gdsd1xsMxOVe0F3lL+9bYw0z+8PO+t7LmGYEiaF+u
 8LafM1y4ke11kk4HIuV10Dr6Zk1kAlniDcsskPser6fSDgdGeqK6a8iHTEY7p1h7Hh
 sldENg3yp4kKkLKkJDaTaKQwB5oWYce1N1Kv4kGecQIXwSCcvzzJ1uzXeDsxDkaVKH
 Td7d6ANYeoyHOEnkuj5oDYV9LdqwzHvFz7/AZlkjdxdyUUbo9yTNIkbWfch7Wwh/rV
 OPW25cMjrZ6zRUhLTcxj7Wak2AtebejcHwRKoXzEgzRiH0KAHk4px+e7VmBEXC0xV2
 I2lozUh2fwQRw==
X-Pm-Submission-Id: 4jDRgG545jz1DF5K
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 27 Oct 2026 11:33:50 +0100
Subject: [PATCH v5 2/4] drm/bridge: nwl-dsi: Limit LCDIF specific sync override
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-nwl-dsi-fixes-v5-2-b6d1d3d2d356@geanix.com>
References: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
In-Reply-To: <20261027-nwl-dsi-fixes-v5-0-b6d1d3d2d356@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, imx@lists.linux.dev
Cc: Esben Haabendal <esben@geanix.com>, Frank.Li@kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793097237; l=1511;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=rOPluOxC/V700cj1dVNGgWn0UwFTiiAxYBj8sDkXCYM=;
 b=4f/VGKcGhGs1kYzfd5vgr1hlVTxhmoTClXmJz2lkDPw2itdPOFLH7aK5mPOdpCmbeujbvh5LT
 mfmgJsz5F6pATbEW8Edh2FtPywqeEf4lpWXJ56/mJCfy0yS1XW3rVNl
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When using DCSS with NWL, overriding the mode flags to enforce active high
sync is preventing the use of active low with downstream bridges, such as
ti-sn65dsi83, which will not see such mode flags set by the panel.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 80e26a947ae6..1aab46e1a168 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -823,10 +823,13 @@ static int nwl_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 				       struct drm_connector_state *conn_state)
 {
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	struct nwl_dsi *dsi = bridge_to_dsi(bridge);
 
 	/* At least LCDIF + NWL needs active high sync */
-	adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
-	adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	if (dsi->endpoint == NWL_DSI_ENDPOINT_LCDIF) {
+		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
+		adjusted_mode->flags &= ~(DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC);
+	}
 
 	/*
 	 * Do a full modeset if crtc_state->active is changed to be true.

-- 
2.56.0

