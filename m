Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E948606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1CA6yBKV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1DBF10FE59;
	Wed, 25 Nov 2026 17:51:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD0210FE3F
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:51:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B472F1A17F6;
 Wed, 25 Nov 2026 17:51:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7B1B460480;
 Wed, 25 Nov 2026 17:51:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FAB311E6B0AE; Wed, 25 Nov 2026 18:51:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795629065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3A5cjW5s6Vm9YexlzjVRgl0QgTWKhVvRpSlRJjfgWZs=;
 b=1CA6yBKVAq8sZAQ8KU+pXmBM+p/6F3rx+KOh79Vgstzg726iK4gp6c5SvZan88jxDuz0On
 lr9yEJXN9ytvidiRusLZr9sVNRQtBJ+A61Lkd0wzCfaT1ebpEiPnSqGNPu7WWzmpKBrsa6
 k3AiWy2Auo55wJCUexRoJ+z5R6vle71qRjUbYLh+ly8+rc6g7+y1MGkUftPi3QERU6ltCA
 PgL2cDm7L7GrE5PGWYuWCoShz+lym9GIcA8zy5JbzGHECXoc+RlrbvVth1GONZVUh/h7RR
 bykLFayrTiSnPT57mtgdssWSdoKK7yjSUaP79ljgMJ82DJqxvforJzpQDR+q5A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 25 Nov 2026 18:50:17 +0100
Subject: [PATCH v4 04/32] drm/display: hdmi-cec-notifier-helper: add
 non-drmm API variant
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-drm-bridge-hotplug-v4-4-822722850492@bootlin.com>
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

For bridge hotplug drmm allocations are not suitable because a connector
may have to be added and removed multiple times in the lifetime of a card.

In preparation to support hotpluggable HDMI bridges (and the
drm_bridge_connector) add a non-drmm variant of the CEC notifier
(de)registration API, with an explicit unregister API.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

New patch in v3.
---
 .../gpu/drm/display/drm_hdmi_cec_notifier_helper.c | 30 ++++++++++++++++++----
 include/drm/display/drm_hdmi_cec_helper.h          | 15 +++++++++++
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c b/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c
index 47662bdc5d08..2f30844fcdad 100644
--- a/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c
@@ -29,8 +29,7 @@ static void drmm_connector_hdmi_cec_notifier_unregister(struct drm_device *dev,
 {
 	struct drm_connector *connector = res;
 
-	cec_notifier_conn_unregister(connector->cec.data);
-	connector->cec.data = NULL;
+	drm_connector_hdmi_cec_notifier_unregister(connector);
 }
 
 static const struct drm_connector_cec_funcs drm_connector_cec_notifier_funcs = {
@@ -38,9 +37,9 @@ static const struct drm_connector_cec_funcs drm_connector_cec_notifier_funcs = {
 	.phys_addr_set = drm_connector_hdmi_cec_notifier_phys_addr_set,
 };
 
-int drmm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
-					      const char *port_name,
-					      struct device *dev)
+int drm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
+					     const char *port_name,
+					     struct device *dev)
 {
 	struct cec_connector_info conn_info;
 	struct cec_notifier *notifier;
@@ -58,6 +57,27 @@ int drmm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
 
 	mutex_unlock(&connector->cec.mutex);
 
+	return 0;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_cec_notifier_register);
+
+void drm_connector_hdmi_cec_notifier_unregister(struct drm_connector *connector)
+{
+	cec_notifier_conn_unregister(connector->cec.data);
+	connector->cec.data = NULL;
+}
+EXPORT_SYMBOL(drm_connector_hdmi_cec_notifier_unregister);
+
+int drmm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
+					      const char *port_name,
+					      struct device *dev)
+{
+	int ret;
+
+	ret = drm_connector_hdmi_cec_notifier_register(connector, port_name, dev);
+	if (ret)
+		return ret;
+
 	return drmm_add_action_or_reset(connector->dev,
 					drmm_connector_hdmi_cec_notifier_unregister,
 					connector);
diff --git a/include/drm/display/drm_hdmi_cec_helper.h b/include/drm/display/drm_hdmi_cec_helper.h
index 7e76a163e3a5..8d648532eeb7 100644
--- a/include/drm/display/drm_hdmi_cec_helper.h
+++ b/include/drm/display/drm_hdmi_cec_helper.h
@@ -63,10 +63,25 @@ void drm_connector_hdmi_cec_transmit_attempt_done(struct drm_connector *connecto
 						  u8 status);
 
 #if IS_ENABLED(CONFIG_DRM_DISPLAY_HDMI_CEC_NOTIFIER_HELPER)
+int drm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
+					     const char *port_name,
+					     struct device *dev);
+void drm_connector_hdmi_cec_notifier_unregister(struct drm_connector *connector);
 int drmm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
 					      const char *port_name,
 					      struct device *dev);
 #else
+static inline int drm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
+							   const char *port_name,
+							   struct device *dev)
+{
+	return 0;
+}
+
+static inline void drm_connector_hdmi_cec_notifier_unregister(struct drm_connector *connector)
+{
+}
+
 static inline int drmm_connector_hdmi_cec_notifier_register(struct drm_connector *connector,
 							    const char *port_name,
 							    struct device *dev)

-- 
2.56.1

