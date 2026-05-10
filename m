Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC67CD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 18:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628C110E271;
	Sun, 10 May 2026 18:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JWuxLNPl";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCF510E249
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778437899; bh=H1waIzTgCsXz9ZAL00Qf3J9pZA3q1fbfXo1eGGcAxvc=;
 b=JWuxLNPl+mLwdk0/Ya04pSX3Qn1iMcWV0hvO6jEXfc0DkPDUkU+R31gH9jd3kxhshQ/5AQUYZ
 vxY58by18pr0nwPlgjYFPUkoKWdHOzOW6/V7I/nxOUU3GL/YkpHsLMYE2cNMNPP9o00PxkhKwcV
 87F7QfDG2+tIE2YxY5rwu0lQ6hI0KcCEO35KdF0y7PAr3COoK+zduIwxPDeCa+GqtuRIIgfUS+y
 Dfoai1PqsTUGlZTw0fN+H8JGtxw3jHXcT/C/LSIjPb4ZC7x7lQH0TQtc+xA6trU4L6Ix70xuG5P
 rUGWJZnNfwqa4MCu1OnOfebDY+oShcvjT57QlkvhiRQw==
X-Forward-Email-ID: 6a00cf0061db3ab145b0f241
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/10] drm/rockchip: dw_hdmi: Use local dev variable
 consistently in bind()
Date: Sun, 10 May 2026 18:31:03 +0000
Message-ID: <20260510183114.1248840-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510183114.1248840-1-jonas@kwiboo.se>
References: <20260510183114.1248840-1-jonas@kwiboo.se>
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

Replace indirect struct device accesses via hdmi->dev and pdev->dev with
the local dev parameter already available in dw_hdmi_rockchip_bind(),
for consistency and readability.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 34a2248f6b4b..435352f91b88 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -550,16 +550,15 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	if (!drv_data)
 		return -ENODEV;
 
-	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
+	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	plat_data = devm_kmemdup(&pdev->dev, drv_data,
-				 sizeof(*drv_data), GFP_KERNEL);
+	plat_data = devm_kmemdup(dev, drv_data, sizeof(*drv_data), GFP_KERNEL);
 	if (!plat_data)
 		return -ENOMEM;
 
-	hdmi->dev = &pdev->dev;
+	hdmi->dev = dev;
 	hdmi->plat_data = plat_data;
 	hdmi->chip_data = plat_data->phy_data;
 	plat_data->phy_data = hdmi;
@@ -581,13 +580,13 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 
 	ret = rockchip_hdmi_parse_dt(hdmi);
 	if (ret) {
-		return dev_err_probe(hdmi->dev, ret, "Unable to parse OF data\n");
+		return dev_err_probe(dev, ret, "Unable to parse OF data\n");
 	}
 
 	hdmi->phy = devm_phy_optional_get(dev, "hdmi");
 	if (IS_ERR(hdmi->phy)) {
 		ret = PTR_ERR(hdmi->phy);
-		return dev_err_probe(hdmi->dev, ret, "failed to get phy\n");
+		return dev_err_probe(dev, ret, "failed to get phy\n");
 	}
 
 	index = of_property_match_string(np, "phy-names", "hdmi");
-- 
2.54.0

