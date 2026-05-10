Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3570CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 12:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36C6D10E188;
	Sun, 10 May 2026 12:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xJHIpKYK";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6EB410E188
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 12:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778416978; bh=swdZ+u7Sa2gVzodUsUsScCzNIHbNmogFoetuhS14ZzM=;
 b=xJHIpKYK/YZpYWcn5NdBJ4udzrT6YlLFuWht6sYVGdg6pntfM1o7G6kT02aIgk5fgRauUHnzO
 i8KgCAblaxjS8LJVTdZWAF1BOjFgiMNTWk5QVy9MMPvqjVRVz9y9H9V6g4U0kBneeB8YVO5iPt7
 b9cZbHpvB6L0fIqy2SEmCUYQHOKsZGjZ7tgko+j7c1xCkYPO43xPVUFxni8EjXn/dLraMJCzXi1
 KDAEfZWbMdc4GdGQDZpi4iE6E+my6rlwJH3bWbM1hEzjktDv+ki9qm16kCNUSNsOGNuf4Acd5Ux
 iudAtYiP8Fc5ivalrzvP9BlBxHWYypej9hAMpazM/gMA==
X-Forward-Email-ID: 6a007d160d91f03a31a0bc3b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.0
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
Subject: [PATCH v5 09/21] drm: bridge: dw_hdmi: Invalidate CEC phys addr from
 connector detect
Date: Sun, 10 May 2026 12:40:53 +0000
Message-ID: <20260510124111.1226584-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510124111.1226584-1-jonas@kwiboo.se>
References: <20260510124111.1226584-1-jonas@kwiboo.se>
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

Wait until the connector detect ops is called to invalidate CEC phys
addr instead of doing it directly from the irq handler.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v5: No change
v4: No change
v3: No change
v2: Collect r-b tag
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 5fd26ff8f55b..aae1b890167b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2472,7 +2472,17 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
-	return dw_hdmi_detect(hdmi);
+	enum drm_connector_status status;
+
+	status = dw_hdmi_detect(hdmi);
+
+	if (status == connector_status_disconnected) {
+		mutex_lock(&hdmi->cec_notifier_mutex);
+		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
+		mutex_unlock(&hdmi->cec_notifier_mutex);
+	}
+
+	return status;
 }
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -3106,12 +3116,6 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 				       phy_stat & HDMI_PHY_HPD,
 				       phy_stat & HDMI_PHY_RX_SENSE);
 
-		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0) {
-			mutex_lock(&hdmi->cec_notifier_mutex);
-			cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
-			mutex_unlock(&hdmi->cec_notifier_mutex);
-		}
-
 		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
 		    (phy_stat & HDMI_PHY_HPD))
 			status = connector_status_connected;
-- 
2.54.0

