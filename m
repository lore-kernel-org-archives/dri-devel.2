Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12734C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A9D10E43B;
	Fri, 17 Jul 2026 08:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ENkUMMN+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D232A10E43B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:58:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEC184338D;
 Fri, 17 Jul 2026 08:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7651F000E9;
 Fri, 17 Jul 2026 08:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784278699;
 bh=iv4uXxn+GKJb3u9fgDa2VmuoPL5Se5Dx66tyxt7nYps=;
 h=From:To:Cc:Subject:Date;
 b=ENkUMMN+Xz2YTZ748nkH3PnWLGGPbD9CFI+c3wqdLecWnhQEOmrD1woNldQuYGFsc
 q++5ZJ6dsbp8wQKF1mLltocvVIWNqNY60iLVWxutW9xtQWmFG1qSID6DWciVRzyFnx
 k5Gg8KnCF1TfTkC14ThkNiskgi+RMrZElqBQQE92hI6bvz31PsNNmJfxMZJ7Ks3xPM
 nH/0bWu5DymvXMM2aZZi2Kx8uihj5lHom89IPJLZq3Z1sTHV2/Ayb5VEsbjyUJEOb9
 9a0+tutH01GTphtAfNOsE97umLV6qDP0tDgp5vhMDeeJsBoDmbwCJKJPJ2P44ky1rT
 nFIMSAEOnuthA==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkeOe-00000006nGP-2uPl;
 Fri, 17 Jul 2026 10:58:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm/bridge: display-connector: fix i2c adapter leak on probe
 failure
Date: Fri, 17 Jul 2026 10:57:16 +0200
Message-ID: <20260717085716.1619275-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Make sure to drop the i2c adapter device and module references on failed
regulator and enable gpio lookup (and regulator enable) during probe
(e.g. on probe deferral).

Note that of_get_i2c_adapter_by_node() does not return error pointers,
but i2c_put_adapter() can handle a NULL argument so the error pointer
check at remove works even if it is misleading.

Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio support")
Fixes: 6eb6b6f0a012 ("drm/bridge: display-connector: handle hdmi-pwr supply")
Cc: stable@vger.kernel.org	# 5.12
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/bridge/display-connector.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 16c0631adeb1..c38de5518211 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -208,6 +208,13 @@ static int display_connector_get_supply(struct platform_device *pdev,
 	return PTR_ERR_OR_ZERO(conn->supply);
 }
 
+static void display_connector_put_ddc(void *_ddc)
+{
+	struct i2c_adapter *ddc = _ddc;
+
+	i2c_put_adapter(ddc);
+}
+
 static int display_connector_probe(struct platform_device *pdev)
 {
 	struct display_connector *conn;
@@ -328,6 +335,12 @@ static int display_connector_probe(struct platform_device *pdev)
 			of_node_put(phandle);
 			if (!conn->bridge.ddc)
 				return -EPROBE_DEFER;
+
+			ret = devm_add_action_or_reset(&pdev->dev,
+						       display_connector_put_ddc,
+						       conn->bridge.ddc);
+			if (ret)
+				return ret;
 		} else {
 			dev_dbg(&pdev->dev,
 				"No I2C bus specified, disabling EDID readout\n");
@@ -403,9 +416,6 @@ static void display_connector_remove(struct platform_device *pdev)
 		regulator_disable(conn->supply);
 
 	drm_bridge_remove(&conn->bridge);
-
-	if (!IS_ERR(conn->bridge.ddc))
-		i2c_put_adapter(conn->bridge.ddc);
 }
 
 static const struct of_device_id display_connector_match[] = {
-- 
2.54.0

