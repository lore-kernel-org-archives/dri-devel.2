Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D96ACD4851
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 18:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDBC410E560;
	Sat, 16 May 2026 18:42:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="B/VbB05H";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD98D10E561
 for <dri-devel@lists.freedesktop.org>; Sat, 16 May 2026 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778956922; bh=w9gLcIjrWFUo1B9oSiBZ5ajnppXXlJddCFjM0GCTYiM=;
 b=B/VbB05HQakI4l6+6m+yrafLp1dAtbjeA9VfjSP/LJsoLroQoi1LoTeLvLs1wM5VWR3aj7r/n
 9mjZCsVn/nGNrDkyU/tNTdA6zaWl2gNkhU6x73poN8+L7i8/Qo1lzYFDQT4sPyS+XIE9BI4Dv3D
 9nE3+zqDkpXOVWUWgZ8oloY2iNSH4gYS3+H2HJ3HDG8d24BNBUpdLT2MlT3ELrlwLUKNBRtMDVp
 nL8bLOFdnKnbVYg919TQX7xrhLpTQnt7UFJEpA3ijmqQveBFf0/Qp7/oYHl48hUirX/31sGLsJ/
 9IsjLsRm6zF7uptuIFqYmj6GxffTigd0P+ondfxjYqTg==
X-Forward-Email-ID: 6a08b9f079c7625f20eeee89
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Liu Ying <victor.liu@nxp.com>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6 14/22] drm: bridge: dw_hdmi: Update EDID and CEC phys addr
 in bridge detect()
Date: Sat, 16 May 2026 18:38:24 +0000
Message-ID: <20260516183838.2024991-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516183838.2024991-1-jonas@kwiboo.se>
References: <20260516183838.2024991-1-jonas@kwiboo.se>
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

Update EDID and CEC phys addr in the bridge detect() func to closely
match the behavior of a bridge connector with a HDMI bridge attached
and the dw-hdmi connector.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v6: New patch

This is a temporary change until dw-hdmi is fully converted into a
HDMI bridge in a future part of this multi-series effort.
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 2bb043d64b65..3649ccf8d994 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2969,8 +2969,17 @@ static enum drm_connector_status
 dw_hdmi_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
+	enum drm_connector_status status;
 
-	return dw_hdmi_detect(hdmi);
+	status = dw_hdmi_detect(hdmi);
+
+	/*
+	 * Update EDID and CEC phys addr to match the behavior of a bridge
+	 * connector with a HDMI bridge attached and the dw-hdmi connector.
+	 */
+	dw_hdmi_connector_status_update(hdmi, connector, status);
+
+	return status;
 }
 
 static const struct drm_edid *dw_hdmi_bridge_edid_read(struct drm_bridge *bridge,
-- 
2.54.0

