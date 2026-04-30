Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D57CD3423
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 22:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC2A10E496;
	Thu, 30 Apr 2026 22:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RFCXMI5I";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5D510E494
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777587637;
 bh=tsS9dISdD7T3p6ZiiCSXuebXIVHjIVlaiPrtje9bEfY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RFCXMI5ImovvW8tZhRblR1PJXKnFmm+JLCjsn1u0wop0APVQmD9WzkXcJ1gnV59O3
 UycBgHrLXq+k5xaqup1y5rY8tzMuOyecjI9iTacvXTz3LgCfaHzSQEiZH8MAPr4N1B
 zAvhcoiUuv3QKAoqzswAYyVAIuGult0EuR+YYmmfnzGhCtvSdMEIW6lGwloPYPbb+e
 sRjFBmyQy9oPB8D0WuakEt43QMKTGYuF4hKEcuFfoRJ+WSHQ4sZwU82P5MYurBgSV4
 M7R7HGa/UxXhLtKYHnY8epkNJb27K+SPCLqXBHENrZvRp2H+ALWVx/gkxQI7wI4FtQ
 t9bH6Gk84BawA==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B32D417E1580;
 Fri,  1 May 2026 00:20:37 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 172B348003A; Fri, 01 May 2026 00:20:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 01 May 2026 00:20:33 +0200
Subject: [PATCH v2 06/12] drm/bridge: Add out-of-band HPD notify handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-synopsys-dw-dp-improvements-v2-6-d7e7f6bac77f@collabora.com>
References: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
In-Reply-To: <20260501-synopsys-dw-dp-improvements-v2-0-d7e7f6bac77f@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=tsS9dISdD7T3p6ZiiCSXuebXIVHjIVlaiPrtje9bEfY=;
 b=kA0DAAoB2O7X88g7+poByyZiAGnz1bSjKK+ZFzlrI+HgGknqc95+XU6w0OUVjRCQpXo9Mo1Q4
 4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJp89W0AAoJENju1/PIO/qa7RYQAJDt
 V9Rv3+k4gW/NqL5JWwukHRnM9+T1aEam6JHnCKBGyz9fbZxCRRtj95y2fMQ16EiP4UcgENKvbym
 GO1SifLoSY4pFtrleUaH+3ecqx9tbIOCofNNYvZrrd7I+MF9APoGTPhbUq4lFlYK5NLYRPiplLm
 csDRmRbY7Gxn2tp0e7cOhLnk2Ag4mIjvQoPBXHSWLEMPTekFP+MfsjkX00YcRgqg1ruV7eVkQ7K
 t18bakOoYRS93OD2d/g5qPXTceKa+neZYulXwYusaHo8a9G4LoJ+GMytq9X+0Ry7q2T7G8fCMJM
 sLxEcpq2MfoPKaipTRJJ7mWFb6F8T6/WkJHGPvCEaPxOWrmjaBDr4Com/T7unQRNqRIgmzTDVkw
 GnDr9IzaHu7i3S6OqCn9y1ILZTZ4DqfGbuTNaaxP63+02jRYTFwfH32FHZQ9KpEKue4+N1ndiW4
 fhqefqjdiwXwtRzS9uyeu4KX+KqpQOAeD6dLUwe9ulAX6Gue3SsXNLgueOafrNdN4n8jremczDm
 xidvpfjSi+Jv7S+DncGaAic6M1vsryfUPRrHqlrQQtQLRc2ZObhZBUIU+UFhN4G+ZRMklhR2Rh6
 rerOqehTKFqK9uVgqS9t5s84NC1jKZ1tYfYnfE4aSGIMxL3zKV1hiRUSLJTS132rO8DyDIod9yg
 +EedJ
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

For DP bridges, that can be used for DP AltMode, it might be necessary
to enforce HPD status. There is an existing ->oob_hotplug_event() on
the DRM connector, but it currently just calls into hpd_notify().

As DP bridge drivers usually also implement .detect and that also
generates calls into hpd_notify, this is a bad place to force the
HPD status as the follow-up detect call might force it off again
resulting in all follow-up calls to the detection routine also
failing.

Avoid this by having a dedicated function for OOB events.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c |  6 ++++++
 include/drm/drm_bridge.h                       | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index d85ceb80c137..e3c3c0bb0cf0 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -180,6 +180,12 @@ static void drm_bridge_connector_oob_hotplug_event(struct drm_connector *connect
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 
+	/* Notify all bridges in the pipeline of hotplug events. */
+	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
+		if (bridge->funcs->oob_notify)
+			bridge->funcs->oob_notify(bridge, connector, status);
+	}
+
 	drm_bridge_connector_handle_hpd(bridge_connector, status);
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d6cd0f5af045..bba355c1ce1a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -646,6 +646,20 @@ struct drm_bridge_funcs {
 	 */
 	void (*hpd_disable)(struct drm_bridge *bridge);
 
+	/**
+	 * @oob_notify:
+	 *
+	 * Notify the bridge of out of band hot plug detection.
+	 *
+	 * This callback is optional, it may be implemented by bridges that
+	 * need to be notified of display connection or disconnection for
+	 * internal reasons. One use case is to force the DP controllers HPD
+	 * signal for USB-C DP AltMode.
+	 */
+	void (*oob_notify)(struct drm_bridge *bridge,
+			   struct drm_connector *connector,
+			   enum drm_connector_status status);
+
 	/**
 	 * @hdmi_tmds_char_rate_valid:
 	 *

-- 
2.53.0

