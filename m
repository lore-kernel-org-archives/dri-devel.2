Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA18CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58BAE10ECCB;
	Tue, 28 Apr 2026 15:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="o5i2FGEw";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4189510EC8D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:32:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CA3DBC5EF12;
 Tue, 28 Apr 2026 15:32:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 218EA601D0;
 Tue, 28 Apr 2026 15:32:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A595210728E2C; 
 Tue, 28 Apr 2026 17:32:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777390329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=pOOUC/6IIIksC8MXl8RMQVMT+zs6jAuaGxEXoJvROdk=;
 b=o5i2FGEwZ9J4xEw406YB2Qry69Hbl4ztwna6UxopLMtqbuwvDWWBvpduxVugwnP5SZysyI
 32/TtKNdp//VVZlLckL5fkEMevwZC08FXZbPa5i01t9MLz2xhe8VUxy0SSdXvWrMylCV7N
 GJP9LCicRpK/x4FKlWOay3t40qh7QKMGb8OClKhyk+YsnqEs48ZrtxDTbmthmnGsMzmK1+
 NJgUkaJ9uVpG3qpJZwpkB/RGhos3KKuJUiMzBYYM70DswRcB13ZIjTKTEDhwR+gpBBFity
 zlucVzBmy5EHsouy0WKJpkEOiVRbNBUJHPW6M/cU/B5pmBTFTNlRxqDj5NZ6xg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 28 Apr 2026 17:31:00 +0200
Subject: [PATCH v3 11/11] drm: of: forbid bridge-only calls to
 drm_of_find_panel_or_bridge()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-11-a537b5567add@bootlin.com>
References: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-0-a537b5567add@bootlin.com>
In-Reply-To: <20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-0-a537b5567add@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

Up to now drm_of_find_panel_or_bridge() can be called with a bridge pointer
only, a panel pointer only, or both a bridge and a panel pointers. The
logic to handle all the three cases is somewhat complex to read however.

Now all bridge-only callers have been converted to
of_drm_get_bridge_by_endpoint(), which is simpler and handles bridge
refcounting. So forbid new bridge-only users by mandating a non-NULL panel
pointer in the docs and in the sanity checks along with a warning.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/drm_of.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index ef6b09316963..d03ada82eac9 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -225,15 +225,15 @@ EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
  * @np: device tree node containing encoder output ports
  * @port: port in the device tree node
  * @endpoint: endpoint in the device tree node
- * @panel: pointer to hold returned drm_panel
+ * @panel: pointer to hold returned drm_panel, must not be NULL
  * @bridge: pointer to hold returned drm_bridge
  *
  * Given a DT node's port and endpoint number, find the connected node and
- * return either the associated struct drm_panel or drm_bridge device. Either
- * @panel or @bridge must not be NULL.
+ * return either the associated struct drm_panel or drm_bridge device.
  *
  * This function is deprecated and should not be used in new drivers. Use
- * devm_drm_of_get_bridge() instead.
+ * of_drm_get_bridge_by_endpoint() instead when not looking for a panel, or
+ * devm_drm_of_get_bridge() otherwise.
  *
  * Returns zero if successful, or one of the standard error codes if it fails.
  */
@@ -245,10 +245,10 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	int ret = -EPROBE_DEFER;
 	struct device_node *remote;
 
-	if (!panel && !bridge)
+	if (WARN_ON(!panel))
 		return -EINVAL;
-	if (panel)
-		*panel = NULL;
+
+	*panel = NULL;
 
 	/*
 	 * of_graph_get_remote_node() produces a noisy error message if port
@@ -263,13 +263,11 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	if (!remote)
 		return -ENODEV;
 
-	if (panel) {
-		*panel = of_drm_find_panel(remote);
-		if (!IS_ERR(*panel))
-			ret = 0;
-		else
-			*panel = NULL;
-	}
+	*panel = of_drm_find_panel(remote);
+	if (!IS_ERR(*panel))
+		ret = 0;
+	else
+		*panel = NULL;
 
 	if (bridge) {
 		if (ret) {

-- 
2.53.0

