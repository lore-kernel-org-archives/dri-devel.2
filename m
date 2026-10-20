Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42416606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=airkyi.com header.i=@airkyi.com header.a=rsa-sha256 header.s=altu2504 header.b=WT6M/EEs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECFC10F2BE;
	Tue, 20 Oct 2026 07:30:07 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BB210F2BE
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1792481357;
 bh=6sfgVQRfPeZB9Hqtz18Dzql0K28fc/y+GbntbfCgIfE=;
 h=From:To:Subject:Date:Message-Id;
 b=WT6M/EEsTu+08B7cJ5zQbVxVyWnWuSfe9WH43N0wEmglhPh0ttjJ7HahuSjrfIzEo
 NgUKkIVnZQ0vZV+lHBUcrp/glzqZ2UJ6kYMydbzo6p5hNspsrBD9dONQ9MAJzkMG8G
 44M1tI/U4WdKJc2PqHxO6mNrZdNL36oxH4cX3BQQ=
X-QQ-mid: zesmtpsz4t1792481356t7b55ba3e
X-QQ-Originating-IP: PoqMp8+AGb8p9Ii/rbgBGbxueQB7iyGiD+n5xnkg/z8=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 20 Oct 2026 15:29:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9572358570521721433
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
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-phy@lists.infradead.org, Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v8 6/7] drm/rockchip: cdn-dp: Support handle lane info without
 extcon
Date: Tue, 20 Oct 2026 15:28:15 +0800
Message-Id: <20261020072816.180-7-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261020072816.180-1-kernel@airkyi.com>
References: <20261020072816.180-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mo8ayuSLF3j9OU6X1X94tpisK5yJqIjLovmg0uqQHW5buohGOUnXGJr3
 lteM3XNIu+4T3hQYuETSLYr4pV4ZJOSUjbxKerkb8MRLf5YorQemNLumi0FNj6S6pQ5htYl
 n4/6KGRnOFpKwSDNee52KlkAueR8z6R9G8ZkugtaakdbgXhT1FgDknN3ZS0uLXqdIc7HJw1
 aC7/mknGa8j3UNqgnDSF0vxllmQ6DQqkYigEdIEOtrf0dfpgTCpY5s/f8GxL71rcnseSUK2
 RPuil8XgzcvtvyGZqHhBPaqnnHKsmoHaeDlB92GgRoS5A4BRO9IGPRMZUpHNNkvR+vKEoBW
 xospj+TG32te1dx7h3ob4HiGLKX/qmlTcJfKqN6WduC1iYC5KbpKHz4nqUY2wRlvVEdHAaE
 1p/dbCO9/VdZ7ErWJa2/L0R04GL1gL/7F1EtbWBRROSMvkhGEefJFxV0VwEccipP2PB8XYB
 +DNh4CVonmqfdGzEyup7aoxJviLPLX62BDEdm9Xcxx0E7L0TGpxSBBQGKpr/vTKLrAv/pWI
 KXE+5jc6dVeWHvlKOjXRVGcXQqqlVkput4zM31JwGkJspKVzOnJfU1Xz/mcX8vtSDjIGwiY
 zhUZODc9RpuXP3QNFlACkYObc/MHzwKXI1yKb7EIEdlwteVNiyrz4Lz3Umsezy2HENhTqpQ
 43rGohlGSocStdWiW4YwVftDJFJ1I802ogG9f5h2QwPGXtlQm0qrlqZUOClxTHMXST8bBXF
 9GyJ9iO+E97LXppGIYg+fsoKnSqhLszpB7/DqdWHFbYq+sBT/UGmaO1YGHmXRhadUhR+SaI
 B5krZajV9hJ6AyZFqAZMh4HTzmpmfhXqKWSwNdVsv4FKRXka3CApbEawmch/mVYB91jKFNQ
 Bd+7wEFhiBpo06v8fLF9D7DO5tItK1eJBrlr/uApdXjJY5NroOd3BDEJNKsmSrUgkgSd2HJ
 j9E7GiESMoiXmEUtu88huymB8mTL3Jq5RsBXDTZ4OoF9SmucCCtjucfCXLlQzXzidQQF4Dd
 9Ustlk5WQO+1bmSddo
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
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
X-Archived-By: <archiver.kernel.org>

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
index 68aa66915e8a..1c1c1116b5eb 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -156,6 +156,9 @@ static int cdn_dp_get_port_lanes(struct cdn_dp_port *port)
 	int dptx;
 	u8 lanes;
 
+	if (!edev)
+		return phy_get_bus_width(port->phy);
+
 	dptx = extcon_get_state(edev, EXTCON_DISP_DP);
 	if (dptx > 0) {
 		extcon_get_property(edev, EXTCON_DISP_DP,
@@ -219,7 +222,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 	 * some docks need more time to power up.
 	 */
 	while (time_before(jiffies, timeout)) {
-		if (!extcon_get_state(port->extcon, EXTCON_DISP_DP))
+		if (port->extcon && !extcon_get_state(port->extcon, EXTCON_DISP_DP))
 			return false;
 
 		if (!cdn_dp_get_sink_count(dp, &sink_count))
@@ -385,11 +388,14 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
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
@@ -1030,6 +1036,9 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 	for (i = 0; i < dp->ports; i++) {
 		port = dp->port[i];
 
+		if (!port->extcon)
+			continue;
+
 		port->event_nb.notifier_call = cdn_dp_pd_event;
 		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
 						    EXTCON_DISP_DP,
@@ -1122,14 +1131,14 @@ static int cdn_dp_probe(struct platform_device *pdev)
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

