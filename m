Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4040CD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 10:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D37010EC23;
	Tue, 19 May 2026 10:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="mN29/H1d";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7731810EC23
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 10:38:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5F898C2B9E5;
 Tue, 19 May 2026 10:39:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 33FF4606E9;
 Tue, 19 May 2026 10:38:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 14C5C107E8AC3; 
 Tue, 19 May 2026 12:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779187127; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Di2t9C3Wga7u13endyDgbNt60je3EfQ2HxxTrMzvD30=;
 b=mN29/H1dlWQgyTgztrhOqG93sBuV28HHJ43/F+Zd/4GyUw6vHmmtlBG693qH6KjfCe9QYw
 OES8DUkhvsB+hi5YAUAP1XxlLr34ku+aUezCyP5G97iFnOddGtOuUhFf3SYDIw7Ndc0z1/
 lMquoJcTfROUqySTdyM3vAT/xD3WR5FKIgrx9ikqzPk004e7B66XSWxbmnS+lsCFZfkYCK
 hE8YhL0fFd485kmIbQ5Zb84nAJohjSJJgUeDg2XckAl7HIJFMmwUWr4VPUxB5oWE+ZqF1U
 dr8cwuM4Y52/4ZEwWkki9n4TAgU4O6OWJSuLEGz6/EYbLRdEFlfNJDJCb2oWPg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 19 May 2026 12:37:27 +0200
Subject: [PATCH 10/37] drm/display: bridge-connector: return int from
 drm_bridge_connector_init_hdmi_audio_cec()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-drm-bridge-hotplug-v1-10-45e2bdb3dfb4@bootlin.com>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
In-Reply-To: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

This function returns a struct drm_bridge_connector * because this was the
case in the origin of its code. In current code it does not make sense
anymore: it can only return either the same pointer it received as input or
a negative ERR_PTR.

Simplify up error management by just returning an int (0 or negative
error).

No functional changes.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index e6306e98a167..6066ca0c5624 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -930,8 +930,7 @@ static int drm_bridge_connector_get_bridges(struct drm_bridge_connector *bridge_
 	return 0;
 }
 
-static struct drm_bridge_connector *
-drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_connector)
+static int drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_connector)
 {
 	int ret;
 
@@ -954,7 +953,7 @@ drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_con
 						    bridge->hdmi_audio_spdif_playback,
 						    bridge->hdmi_audio_dai_port);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	}
 
 	if (bridge_connector->bridge_hdmi_cec &&
@@ -965,7 +964,7 @@ drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_con
 								NULL,
 								bridge->hdmi_cec_dev);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	}
 
 	if (bridge_connector->bridge_hdmi_cec &&
@@ -978,10 +977,10 @@ drm_bridge_connector_init_hdmi_audio_cec(struct drm_bridge_connector *bridge_con
 						       bridge->hdmi_cec_available_las,
 						       bridge->hdmi_cec_dev);
 		if (ret)
-			return ERR_PTR(ret);
+			return ret;
 	}
 
-	return bridge_connector;
+	return 0;
 }
 
 /**
@@ -1051,9 +1050,9 @@ drm_bridge_connector_add_connector(struct drm_bridge_connector *bridge_connector
 			return ERR_PTR(ret);
 	}
 
-	bridge_connector = drm_bridge_connector_init_hdmi_audio_cec(bridge_connector);
-	if (IS_ERR(bridge_connector))
-		return bridge_connector;
+	ret = drm_bridge_connector_init_hdmi_audio_cec(bridge_connector);
+	if (ret)
+		return ERR_PTR(ret);
 
 	drm_connector_helper_add(connector, &drm_bridge_connector_helper_funcs);
 

-- 
2.54.0

