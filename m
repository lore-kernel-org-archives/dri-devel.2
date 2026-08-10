Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8BDC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 07:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A9F10E6E3;
	Mon, 10 Aug 2026 07:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="4LYKjDt8";
	dkim-atps=neutral
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706FD10E6EE
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1786346093; x=1786605293;
 bh=Ye4JFkY68c/ascoLMrZmHLG3qIWVYXCz02SBdw1hOZM=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=4LYKjDt8XsZCK80E51j1CVfVxMWMQtlyELporHB/XwTp/8biic1lIAN0fWCfRXGPk
 5sAn3X+4Y6JjcOT/5t33DiMImX6dtFzItRwKp7j9McOSrAq4BvkGIgQ25/fs+OyF+j
 Ua+8Fl7YajU4nhdo+8GnxHBJoeRaDzc9qRcXRCQ4jI2pExWRhODMyXS3ZvpyeFdcDD
 nAmAlwKYle7n58fSLg6jRCmL16UQKogQkXbG8MQPQuGCzcWDa3qtVQsEIG8WTsWGCy
 +84x4SDuQcHY+wymROnN6K2mqnO0Mn9vAPfFWFtdJ/XlsDuJx6jWAYuU8anXOMt6sW
 66FUwLivoXSBQ==
X-Pm-Submission-Id: 4hJQxQ517Gz2SchD
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 10 Aug 2026 09:14:40 +0200
Subject: [PATCH v3 4/5] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-nwl-dsi-fixes-v3-4-256da9d672e1@geanix.com>
References: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
In-Reply-To: <20260810-nwl-dsi-fixes-v3-0-256da9d672e1@geanix.com>
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
 Sam Ravnborg <sam@ravnborg.org>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786346082; l=910;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=JlqiY9bLAwlxULQ8mA0Pe0idjTV17gCgcQqBrj8zmx4=;
 b=Q246UBAXSJvY3Qxmk3u50Ea5XA0sNg6j4Pj3B+ANS5lJ3W0oKb87jQvYOJaU7qrVSx6cF/fcG
 p+lMGd5PR+fAu/Ptnn48gslddZr4u7y5Cb3SbVgXs0j5qwYCWmit/sv
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

There does not seem to be any good reasons for ignoring the return value of
the nwl_dsi_mode_set() function.

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 3fd41212933c..e90588299c5e 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -884,7 +884,9 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	}
 
 	/* Step 2 from DSI reset-out instructions */
-	nwl_dsi_mode_set(dsi);
+	ret = nwl_dsi_mode_set(dsi);
+	if (ret < 0)
+		goto runtime_put;
 
 	/* Step 3 from DSI reset-out instructions */
 	ret = reset_control_deassert(dsi->rst_esc);

-- 
2.55.0

