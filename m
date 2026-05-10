Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8ADCD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 18:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AAE10E0BB;
	Sun, 10 May 2026 18:31:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QYMpxOtb";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447F310E0BB
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778437899; bh=z436gSSBTFhLoL9d5wdN6j/AQR4iFFTGFYZWVF5au/s=;
 b=QYMpxOtbEJEzR/n/OPe8GfHuylel9xiIlKJc28CiSTxjWNI302dMD7KVfJQQsjdhIqht7j7x0
 1IRCHIzD5NzGJyMFvWAZN0jit72t6fUBgUhEDPeUJUfElq2ueO+WPB5J+5a/jifW+0bIL81D02C
 6VWXuHQB77H6DdaHZA+d0Tp7mXDrX/0PzVrvp9VqN79k5Wc6NLSaZHcVhFWueRhEjA33kbNQLmW
 1DeF+vXeUn5UrC6FpqV1yxmqvacrQywiSg1FCWVulYCfiI9bqV3mYtDBUtMyodkU+xrIoamU4Ny
 agV+632tE1NqeyWBcGzfzjw9NksJPzXpWbmGwfA4BTZA==
X-Forward-Email-ID: 6a00cefc61db3ab145b0f226
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH 01/10] drm/rockchip: dw_hdmi: Use of_device_get_match_data()
 to get match data
Date: Sun, 10 May 2026 18:31:02 +0000
Message-ID: <20260510183114.1248840-2-jonas@kwiboo.se>
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

Change to use of_device_get_match_data() to get match data prior to
allocating private data. All current entries in the of_device_id match
table provide match data, so no functional change is intended.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 8c0e433fbda2..34a2248f6b4b 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -536,8 +536,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev_of_node(dev);
+	const struct dw_hdmi_plat_data *drv_data;
 	struct dw_hdmi_plat_data *plat_data;
-	const struct of_device_id *match;
 	struct drm_device *drm = data;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi *hdmi;
@@ -546,13 +546,16 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	if (!np)
 		return -ENODEV;
 
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data)
+		return -ENODEV;
+
 	hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	match = of_match_node(dw_hdmi_rockchip_dt_ids, np);
-	plat_data = devm_kmemdup(&pdev->dev, match->data,
-					     sizeof(*plat_data), GFP_KERNEL);
+	plat_data = devm_kmemdup(&pdev->dev, drv_data,
+				 sizeof(*drv_data), GFP_KERNEL);
 	if (!plat_data)
 		return -ENOMEM;
 
-- 
2.54.0

