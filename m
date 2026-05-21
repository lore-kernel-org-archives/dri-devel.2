Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF0CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 03:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE97B10F1CA;
	Thu, 21 May 2026 03:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="p8PW0jMe";
	dkim-atps=neutral
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733B010F1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 03:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1779334355;
 bh=6Blt27VidEVpijM8X7bK9ygiXu5vv9uysAwWQfZr3MA=;
 h=From:To:Subject:Date:Message-Id;
 b=p8PW0jMe5xoyBb0gJG2VZm+QoxTdF3OG54ob/MG4Bn9AcgNP4Qj0RhVNspjk31NzF
 qGPSsjLTuOOvQMqqWtEg38HaZbEtgT0h0VrlgBSOaI7CX6ES6QekOB10EBubbTTfOp
 C1jQg2cK7lRXIPIS0/cdP53elWCryfes8rvOCBaQ=
X-QQ-mid: zesmtpsz7t1779334176t8f9eb7f1
X-QQ-Originating-IP: d9IETWuCTenKIZFLByWwMHwi0SPZNsWnhksHBq1ofsE=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 21 May 2026 11:29:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16407384103375472347
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH 4/5] drm/rockchip: cdn-dp: Support handle lane info without
 extcon
Date: Thu, 21 May 2026 11:28:53 +0800
Message-Id: <20260521032854.103-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260521032854.103-1-kernel@airkyi.com>
References: <20260521032854.103-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OezpMYl8oadHVc9pRaU1+zezVtjkEodWqwq1TUNsXpQYGaoK6PbLADaT
 Y0/rTu99jla4a/Gr8kg/Nj1aXqhIjbBId//VoRt+By9BijYwS1aFwKdOfZZIGMmj36PkQAv
 E7d4XOyofnC9Cr5CYGG4P394GBB+9VMnWJIuUVqpzEs82UOWwp5n3HWKe3U7L2yA04R+SG+
 8xk/D/D35XQsW3BGafHG/2ad68gJBpaH3VfaDBZMRdHPEPr6Ka5Et+P1rpmpbx7+ye9+ghK
 nJRDPLWgWRGqTVFtKWbi9U3bQwt0yOrM6DKVWymD7RGr5KjoTRb0ZxYMPVJ3PEtdQ+chYZ0
 gRDygOvd+H8GF03KuxOJAcdsLu3TXO1pAnGdkS1JWJ+lAbAglXiwHI0VDtpx/ir7lG5j+M+
 sIGgmy1a3L+yl8qiJ6M75MgdqOQFpr8X+mth71pVb5ZcceGUOU8MKODQemLZDfvle9CVeSf
 UUs2Crey6rHtYkPd3Mf5fHBU3gDk+4QtD694/nc6YUkHvvspgBTgO1i65GkOBtdsUNLAJnB
 DNVWdTVfgGi/b//6GU39jzhq3jlWhnXQ5m59c0ATtngNSfPubtjMYVpKny5deq2PpgrZmbO
 tCAmUduNCSko9KxWLcogxjl70HgI74CrgLREJtA165w5ItiC+JvXf+Wfonq3Pr3Cso4JVda
 rUiDQf+Ss99Tw0vAGgx8ZHK0Soh1IgPai/RklwCwW3c72f3lQdfqx+2AqMZHfRWtabMzqD0
 AF1GLAXvej67pYHTed2d1hebS3ByaGvafK1loieEFmpf5qAxaA7RbT8l0eo7h4FumarinfH
 hOz/H+u7Oqxy4HrK3lyIr1FUDdSEjcT8miRGFUzysWyqeIlXdOmGcGhrvrj2xkJ+aTBGbmq
 5Yuo9xUUXZGDgoMm4jE0c3KzX/YxrcyTiTRXWBr09/lJUidnCwZphV0YXM94+QYz6Lcmys6
 k/fDfrUjOOaJ6Fc3F2allpftaM/L/oePAC9i43L3JBHPr3h2IlFwKM8VCUPzgYMw5HNupxI
 IIa9f5iOkCxkE77cIt2n86KVwtbntPyYmTZrbJxJlpOCVLlmtf+4kV6uktZ6E=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This patch add support for get PHY lane info without help of extcon.

There is no extcon needed if the Type-C controller is present. In this
case, the lane info can be get from PHY instead of extcon.

The extcon device should still be supported if Type-C controller is
not present.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 177e30445ee8..9068118859e2 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -157,6 +157,9 @@ static int cdn_dp_get_port_lanes(struct cdn_dp_port *port)
 	int dptx;
 	u8 lanes;
 
+	if (!edev)
+		return phy_get_bus_width(port->phy);
+
 	dptx = extcon_get_state(edev, EXTCON_DISP_DP);
 	if (dptx > 0) {
 		extcon_get_property(edev, EXTCON_DISP_DP,
@@ -220,7 +223,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 	 * some docks need more time to power up.
 	 */
 	while (time_before(jiffies, timeout)) {
-		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
+		if (port->extcon && !extcon_get_state(port->extcon, EXTCON_DISP_DP))
 			return false;
 
 		if (!cdn_dp_get_sink_count(dp, &sink_count))
@@ -386,11 +389,14 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 		goto err_power_on;
 	}
 
-	ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
-				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
-	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "get property failed\n");
-		goto err_power_on;
+	property.intval = 0;
+	if (port->extcon) {
+		ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
+					  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
+		if (ret) {
+			DRM_DEV_ERROR(dp->dev, "get property failed\n");
+			goto err_power_on;
+		}
 	}
 
 	port->lanes = cdn_dp_get_port_lanes(port);
@@ -1029,6 +1035,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
+		if (!port->extcon)
+			continue;
+
 		port->event_nb.notifier_call = cdn_dp_pd_event;
 		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
 						    EXTCON_DISP_DP,
@@ -1121,14 +1130,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
 		    PTR_ERR(phy) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
-		if (IS_ERR(extcon) || IS_ERR(phy))
+		if (IS_ERR(phy) || PTR_ERR(extcon) != -ENODEV)
 			continue;
 
 		port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 		if (!port)
 			return -ENOMEM;
 
-		port->extcon = extcon;
+		port->extcon = IS_ERR(extcon) ? NULL : extcon;
 		port->phy = phy;
 		port->dp = dp;
 		port->id = i;
-- 
2.53.0

