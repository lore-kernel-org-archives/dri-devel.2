Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B5C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B07710F2F1;
	Fri, 28 Aug 2026 08:49:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="EHqGzJ5e";
	dkim-atps=neutral
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6C110F2ED
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1787906904;
 bh=bunO2t7dsNCTFo7jX/DDz1zCMJsJEq2YOzLyo3nYWTM=;
 h=From:To:Subject:Date:Message-Id;
 b=EHqGzJ5efiwiDjC0N4sXk1/oYUcOqrRS4fJmBrv1sfoa3bU+CSMQ7id9uaCWZ30yk
 B+2SNdc+/AyCCFb06W2XxpA8G1VOXXDsNjDR72eirNZeLUH9dkhseAUvtXvuIKxGgA
 6KrLyCq8jOgKRjtdiLpjTi9A9X8rm9SzvgMB9kOg=
X-QQ-mid: zesmtpgz6t1787906902t94a8ccf7
X-QQ-Originating-IP: ePzt+A5uepZSdMsOn0wfVfxlDaG2UaMeos7mmM/yUWg=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Aug 2026 16:48:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 339802763641425583
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
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org
Subject: [PATCH v7 6/7] drm/rockchip: cdn-dp: Support handle lane info without
 extcon
Date: Fri, 28 Aug 2026 16:47:36 +0800
Message-Id: <20260828084737.565-7-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260828084737.565-1-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MjZkc9TfnG+XExnOdI5HCJYyVbW/MNBOwNEcSF5ZIKzE5aODXaah7ezz
 bQZ94UUe2YrUx4JVCp7LO+l7sV25l9jpMLhC10cqhsEVfSxeZn9E47OgplY+bPDGVwqexIT
 CgpISDdHDRRsO2RI25yY655xP3k/vs7V7/WsuQgXV+ojvwJmQ8D5GjmDMdjtDf3mbVsqunL
 pUPjt5e9226NB6PzCwNelX5x5x7C8lNGJRzch7wzg6/p5ZNVfUCu6KvdT+BSCgG5e7N38M8
 5hPhwrFfJWQjlJn/iKbUMzcGXgsGwWMGK16BH5d/UKp4BGMpCU7DXWsCjnQJfZmc5tmlXK5
 /VMWlMllO51lV5IwzKLxG+MnqrH9gBjA0KCHPXt7ChkrqcOPXxYURt+efi9K+9oW13r3q9S
 q9cgMQr5+cmNTcDp2R8kgZd2BzzpWv8uqEJWb778TAGi11AtzOk0G3TZy8TmS35a07uv4Pv
 T/V8bNLGal4bKN7fFqDRISBY4ollFOT6KDd9ZObJ6vcxb/2VDXzTVh8/BLepHe7fTTkIOTs
 Bt+G8DzNRg0b1o/gExbctID7hMak5NYkvyPicPUWkmv7cuO42sTr8SZt5HK7ovp6vGhPpod
 PbeQilX61dOPoLTO29t31vfw22M1S7FZGdrmGfxtbYu6W5q3YmkubFzvkWgD8grXyMTO2RR
 6g1ZbONb/U6AA7C2HJJ1Mh9w/+MFIzOkjXOs9lf0S2/L55y0a5pTtEvv96I6MjEJmy9uoYA
 ulP4s25LHDLb6ax2RnYqa5RHJ8OCQ+A42SQZq9204TbtuSFqgWweHVzSWb5qpo8l+dGCiyQ
 Xhh6h7q8fzluEBNz8b7mEOC/93/Ih1Vy9rCXNDlPq9wSiscyaqywFN6zHwESxDhKL2CqS33
 DLEMZeAjgwknthCkO6iJGBdyxRfgUNc4LM+AcR49K8kf4Hk2HhzL7GW1AmVawFCtqmtJJcC
 qJPKmlEgFusbRM4BAx6Z19E7MU8IVamoGRK3XlewuFDqPz+b6R529F1ByLIJXCzL5w9UyKe
 jj3NXDYyWrMLihIvXNqoWkeEW24hg=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

