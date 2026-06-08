Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B0CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141C010F6E0;
	Mon,  8 Jun 2026 16:26:36 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1E710F6E0
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:26:34 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.15])
 by APP-05 (Coremail) with SMTP id zQCowAAXbhEy7SZqx5m4Eg--.4904S3;
 Tue, 09 Jun 2026 00:26:29 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH 2/3] drm/panel: himax-hx83121a: pass the panel pointer when
 creating BL
Date: Tue,  9 Jun 2026 00:26:21 +0800
Message-ID: <20260608162622.403713-2-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAXbhEy7SZqx5m4Eg--.4904S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1rAr18tF1kGw1fXr4UXFb_yoW8KFW7pF
 4kZasIyrWxArn7tFZYyFn7W3Wagws7tFyxtFyUGanakwnFqayYyFy8J34YvF43XrW8G3W0
 vwnrCFWfXFyIyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUQ0b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
 8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
 64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
 CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY
 1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
 8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCF
 s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFI
 xGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
 AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
 cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
 8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRUGYdUUUUU
X-Originating-IP: [112.94.101.15]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

As backlight powering on/off support will be added, more fields of the
panel context will be accessed in the backlight update function.

Pass the whole panel struct instead of the DSI device when creating the
backlight device.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-himax-hx83121a.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
index bed79aa06f46a..1a7e0125bced8 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
@@ -193,10 +193,11 @@ static const struct drm_panel_funcs himax_panel_funcs = {
 
 static int himax_bl_update_status(struct backlight_device *bl)
 {
-	struct mipi_dsi_device *dsi = bl_get_data(bl);
+	struct himax *ctx = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
 	/* TODO: brightness to raw map table */
-	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
+	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
+							 brightness);
 }
 
 static const struct backlight_ops himax_bl_ops = {
@@ -205,9 +206,9 @@ static const struct backlight_ops himax_bl_ops = {
 };
 
 static struct backlight_device *
-himax_create_backlight(struct mipi_dsi_device *dsi)
+himax_create_backlight(struct himax *ctx)
 {
-	struct device *dev = &dsi->dev;
+	struct device *dev = &to_primary_dsi(ctx)->dev;
 	const struct backlight_properties props = {
 		.type = BACKLIGHT_RAW,
 		.brightness = 512,
@@ -215,7 +216,7 @@ himax_create_backlight(struct mipi_dsi_device *dsi)
 		.scale = BACKLIGHT_SCALE_NON_LINEAR,
 	};
 
-	return devm_backlight_device_register(dev, dev_name(dev), dev, dsi,
+	return devm_backlight_device_register(dev, dev_name(dev), dev, ctx,
 					      &himax_bl_ops, &props);
 }
 
@@ -646,7 +647,7 @@ static int himax_probe(struct mipi_dsi_device *dsi)
 	ctx->panel.prepare_prev_first = true;
 
 	if (desc->has_dcs_backlight) {
-		ctx->backlight = himax_create_backlight(to_primary_dsi(ctx));
+		ctx->backlight = himax_create_backlight(ctx);
 		if (IS_ERR(ctx->backlight))
 			return dev_err_probe(dev, PTR_ERR(ctx->backlight),
 					     "Failed to create backlight\n");
-- 
2.52.0

