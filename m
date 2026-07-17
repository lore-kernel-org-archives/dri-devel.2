Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD418C44517
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AC410F46E;
	Fri, 17 Jul 2026 07:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="TrDA4e86";
	dkim-atps=neutral
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CCCC10F46E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1784273316;
 bh=hfSDcA/VFf5O36XZ1jIbDeiIvlPOe5N0iYnQa5D5SVg=;
 h=From:To:Subject:Date:Message-Id;
 b=TrDA4e86OYhXOJ5eorq9vARqBrIqcXzkcRxf17spzzGPG0tW1ZiNzLnQbOMK/PPaK
 vk92bLvrinxUVCgkJp/eLIKmxw6ez4LgLQLJqzSLOJLJkS5GxlEqcnEg0+BcE4oDDX
 6F99Dxdx2qeFJeKwhlJgLxbKrt4VR31t8zOI6PGE=
X-QQ-mid: esmtpsz21t1784273037t8aa6d3dc
X-QQ-Originating-IP: 0D5wUK+GE2YIGxT4HuuhDJ2D57emU1+Gs34WtC5gClQ=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 17 Jul 2026 15:23:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8582860570799389207
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Vinod Koul <vkoul@kernel.org>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v3 4/5] drm/rockchip: cdn-dp: Support handle lane info without
 extcon
Date: Fri, 17 Jul 2026 15:23:22 +0800
Message-Id: <20260717072323.96-5-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260717072323.96-1-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NafziRg7Bx69Ky8gt3DQzRT+xGbXFBs9cRWJdnJvreS+EQ1D1fkWb3NJ
 7msIhaRgDOCnWwuiOSxOMPbjx0LivMosxYIU/FN3WwEDD6vgG8uCl9fPwat9pKprWlZt8RH
 SoaS9hyBisridUJdmQG7R9ZmYr/34hXGie7/QI/qfQ2rCrMs+3NAB5lo13WtQQIyro3myF8
 2VXMwzciX6t1K2oKtS8Utzni/Fr7UHd0VPWyu7GTP0fmL9r3o3snaFcGekrXMMlzX4EXs/M
 /V8E6T2q4bGl2quBcXjcqTJHQg35UlnDSjaOPOag7/iwW8SqvPSVnClvEVw2+KYjqIlCgpr
 n8hHQwKcCmx/+AQBsKrPvP/mf3b7Slsylazasal0nIBGEPc7VDO2IrjEWIg+8f1jfk1SeOF
 i/5du4syngtAvYE/DT4WNYOMu2hMTe/IwArPs7a5oX5NXaGLc0pwMdkql339uVEIbn8a5X2
 9cauSr6PX1FaW6XmE953Ajuy+t5iw6jhhHOFYYt5MzRdQ0owk5Q/BHMksWONCjjgIxmk1Oz
 vrQ4yI5vKnkTiKbA0q16gzQG0obcl9up3oHiUMk1sKQ2DrhGTHJVDgOsw6wXdgro+y3DtL+
 PMiQIHfKrT32dqAKL3TIxWWBO37tb03bccGwESJEh5X2G2+VSeVHTZqBAQYoT59i2rV3f1a
 xe6fuuIA9J3w12P8UjAUFbkBgt2QqtfucMak2qjDDerLvK4hhGrrGccUDCU4QJUTeuxbz2J
 xwtc/udP9giU8rj3gFxcx3Ix8jPma8r28xhUpwVVZ5MeWzNkqi6HaiiuPHCj/2O6KFkOKYu
 x2x/9WOhHSSG2rO8mzSOu3XMNtnEeDoyv1B/CYaFuBlQZVBVqX79ke9QV74VjEVyVS1L2c8
 wY5YeSV+XRlvMA8ZSCzYWTKjuhnFskULQN1SQHOODCW+RPk1Pl9vNiXjrcQ4nLOoWxhljAo
 8Yu0zrhz4aI1c8dlm31rChYTnDCyO85TZWlpULwgOKdg0KMCGkudHz+nCoyNMZP4rZy4N0F
 L99JX9t1ZUv95yKOyPhlwcwjEuSnZtjRi/O3UdKg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

(no changes since v1)

---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 190cce9530c8..74e1f5422a6e 100644
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
@@ -1027,6 +1033,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
+		if (!port->extcon)
+			continue;
+
 		port->event_nb.notifier_call = cdn_dp_pd_event;
 		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
 						    EXTCON_DISP_DP,
@@ -1119,14 +1128,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
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

