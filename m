Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3544606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=F9Hoe0Jw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F35310FE99;
	Wed, 25 Nov 2026 17:54:29 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BC410FE91
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:54:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6F15D1A17FA;
 Wed, 25 Nov 2026 17:54:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3A0A560480;
 Wed, 25 Nov 2026 17:54:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F75411E6B0CA; Wed, 25 Nov 2026 18:54:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629254; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ASSBGT3kIF8HMn738GqJjgyGhYuB+a+EzuLMKqOT5K4=;
 b=F9Hoe0Jwv0B7vRuPw5GL/CXXP7rOF26K3c+pz4ybkcxhJFMexZ1uMKkVD0yHjA69iVdEMu
 HcTQ9476ysHSYMoKov+0hyrFJ8uBcQb2miISO/TNyePjfNJHt/Pi7nTkCALWsWaOdXi0p7
 HKl4rgjoaLkiVNXPoM4rUzg6/GmVUH6453HSNAfqhjpFUZ52ISNxgDzUjvWLCKmVsrRttD
 4PBI4aGnZjFeLi7L00k+W/A7vW6KMvQu427r7EBk7HikO+4YaLYIRKnRc5IG3smCBAaDsC
 FEFdAomMS6nLgv7aSZlpM6CcoQjg/64SEooOaW1OabDxzecUrFnNjay852f3bQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Nov 2026 18:50:43 +0100
Subject: [PATCH v4 30/32] drm/bridge: shutdown encoder and detach
 downstream bridges on bridge unplug
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-drm-bridge-hotplug-v4-30-822722850492@bootlin.com>
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

With the upcoming support for DRM bridge hot(un)plugging, bridges can be
removed at any time. When this happens, shutdown the affected pipeline
components and detach from the encoder chain the bridge being removed along
with all the following ones.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

changes in v3:
- do not shutdown the whole card
- adapt to use drm_bridge_detach_from()
---
 drivers/gpu/drm/drm_bridge.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index d82e81b26ace..d942c776db1a 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -29,6 +29,7 @@
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_debugfs.h>
@@ -547,9 +548,17 @@ static void drm_bridge_detach_from(struct drm_bridge *bridge)
  * it won't be found by users via of_drm_find_and_get_bridge(), and add it
  * to the lingering bridge list, to keep track of it until its allocated
  * memory is eventually freed.
+ *
+ * If the bridge is currently attached, also shut down the encoder pipeline
+ * and detach this bridge and the following ones.
  */
 void drm_bridge_remove(struct drm_bridge *bridge)
 {
+	if (bridge->encoder) {
+		drm_atomic_shutdown_encoder(bridge->encoder);
+		drm_bridge_detach_from(bridge);
+	}
+
 	mutex_lock(&bridge_lock);
 	list_move_tail(&bridge->list, &bridge_lingering_list);
 	mutex_unlock(&bridge_lock);

-- 
2.56.1

