Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766C606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nGhmE+SH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743E810FE97;
	Wed, 25 Nov 2026 17:54:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF5810FE91
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:54:11 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8BCE74E41796;
 Wed, 25 Nov 2026 17:54:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6109360480;
 Wed, 25 Nov 2026 17:54:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CEFA11E6B0AE; Wed, 25 Nov 2026 18:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629248; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uVOZcTNesWkxQue4smQ34ukC/TjgYibdayPA5A159MA=;
 b=nGhmE+SHu6Q6Yt6/Cq67MPgFEVQCPrG5iVyfi0K+Izo1bSo6FZVQKFWDro9im1XRLi8hkk
 jcpo35BEFslgmciJ0IPO+k/Qobg3K+W2ua5BtqtsCBKIrO6yVuHmTe7PvVgPuRygwcs8g0
 lgZrWdygCcCoBbI0bjRBtqr8j/f9L/+M+M6UYjagzIz9AOwRHLKDvoaaVjNAxgmdqOotkf
 v5uWMKmgwYzkdCPPgUZGSQOQ5uo+z49OjNQU6mPorVNBjb/AnEx8W4SBCO5jZu4Oxmz1/W
 0GwTUDc3q2dXB2VTMHoAvNZ6ZwKU1lXeDYjy52EnnfK6HbUdH7ylqy8OqIyF5w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Nov 2026 18:50:42 +0100
Subject: [PATCH v4 29/32] drm/bridge: clear bridge->encoder on detach
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-drm-bridge-hotplug-v4-29-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
In-Reply-To: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Attaching a bridge to an encoder rightfully sets bridge->encoder to point
to the encoder. It also sets it to NULL in the error management path.

However drm_bridge_detach() does not set bridge->encoder to NULL.

This will create a potential NULL pointer dereference in a following commit
(part of when introducing DRM bridge hotplug) because drm_bridge_remove()
will have to detach bridges attached to an encoder, so it needs to use 'if
(bridge->encoder)' to know whether the bridge is attached to an
encoder. For this to work, the bridge->encoder pointer must NULL whenever
the bridge is not attached to an encoder.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Issue found by sashiko:
https://lore.kernel.org/all/20261001131425.A001E1F000FF@smtp.kernel.org/
---
 drivers/gpu/drm/drm_bridge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c00d5276e55b..d82e81b26ace 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -751,6 +751,7 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	drm_hotplug_event_notifier_notify(DRM_BRIDGE_DETACHED, bridge);
 
 	bridge->dev = NULL;
+	bridge->encoder = NULL;
 	drm_bridge_put(bridge);
 }
 

-- 
2.56.1

