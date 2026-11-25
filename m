Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0A3606A681
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=iMMCtZhf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5BB10FE6C;
	Wed, 25 Nov 2026 17:52:16 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5879010FE6F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:52:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 290651A17FA;
 Wed, 25 Nov 2026 17:52:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E8BEC60480;
 Wed, 25 Nov 2026 17:52:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 874D811E6B0D5; Wed, 25 Nov 2026 18:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629123; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vuh24Tz6QmyYkaBRVNh+qXgTNEqAkTxRwqr0CV9YLZo=;
 b=iMMCtZhfwLy9rRPhKznCaOarlESxJ8Lt/UfeRhqOHmXXYES7WjoHIRrzbO6p+LRwkl8+qG
 nDU3jX3WlXAw+ptVmr4cnbZJ9YxszxGTDCTHVR8i101HmKizRDPKjSut0PQz4oWMb5v4Rp
 Mij52wSj0ooK3fVXKl14hVy08+OfuSEDH4luOUyaECpZ6mG32F12HU1AJGaCT3NBxbersn
 aRGXw4k0hSTYKTPERDeMIQDXNROtJBmNaIUpmgVJc8oyvVaQj4tJMpCgvlu+LmH9f47SqI
 /G2ji+GvI3eMwBi4o+2OGIvFyI8LGwiNmiZMNLQjCO70AEvYov3+i80Htd2KiQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Nov 2026 18:50:24 +0100
Subject: [PATCH v4 11/32] drm/bridge: constify of_drm_find_and_get_bridge()
 device_node parameter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-drm-bridge-hotplug-v4-11-822722850492@bootlin.com>
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

The @np argument does not need to be modified. Similarly to what
of_drm_get_bridge_by_endpoint() already does, make it const. This allows
passing a const pointer.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

New patch in v3, needed for the v3 code of "drm: drm_hotplug_helper: new
helper to implement bridge hotplug"
---
 drivers/gpu/drm/drm_bridge.c | 2 +-
 include/drm/drm_bridge.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 3cd6757dffb8..76242165292f 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1663,7 +1663,7 @@ EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
  * RETURNS:
  * drm_bridge control struct on success, NULL on failure
  */
-struct drm_bridge *of_drm_find_and_get_bridge(struct device_node *np)
+struct drm_bridge *of_drm_find_and_get_bridge(const struct device_node *np)
 {
 	struct drm_bridge *bridge;
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 12ca7f6fb524..d6ef020c4cc9 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1274,7 +1274,7 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		      enum drm_bridge_attach_flags flags);
 
 #ifdef CONFIG_OF
-struct drm_bridge *of_drm_find_and_get_bridge(struct device_node *np);
+struct drm_bridge *of_drm_find_and_get_bridge(const struct device_node *np);
 struct drm_bridge *of_drm_find_bridge(struct device_node *np);
 struct drm_bridge *of_drm_get_bridge_by_endpoint(const struct device_node *np,
 						 int port, int endpoint);

-- 
2.56.1

