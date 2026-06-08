Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D1CCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9F210F6B3;
	Mon,  8 Jun 2026 16:26:38 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F50910F6E2
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:26:36 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.101.15])
 by APP-05 (Coremail) with SMTP id zQCowAAXbhEy7SZqx5m4Eg--.4904S4;
 Tue, 09 Jun 2026 00:26:30 +0800 (CST)
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
Subject: [PATCH 3/3] drm/panel: himax-hx83121a: add backlight regulator support
Date: Tue,  9 Jun 2026 00:26:22 +0800
Message-ID: <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAXbhEy7SZqx5m4Eg--.4904S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4UWryxAw4fGFW3ury8Krg_yoW8tF15pF
 4vk343t3yrZr1Iqa9IyFnrW3Wa9w48tFyxJF97GanakwnFqF4YyrykJryYvFW7Xry8WF1a
 yrsFyFW3ua1Ik3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
 xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
 kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
 6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
 IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
 Ja73UjIFyTuYvjTRNiSHDUUUU
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

The backlight, when managed by the panel controller, could be powered by
an external regulator, and shutting down the regulator could power off
the backlight.

Add support for such a regulator. It's powered off when the backlight is
0 (either by setting brightness to 0 or setting bl_power), and powered
on when the backlight should be operating.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/panel/panel-himax-hx83121a.c | 26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
index 1a7e0125bced8..e31e2fba0a787 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
@@ -34,7 +34,9 @@ struct himax {
 	struct drm_dsc_config dsc;
 	struct gpio_desc *reset_gpio;
 	struct regulator_bulk_data *supplies;
+	struct regulator *bl_supply;
 	struct backlight_device *backlight;
+	bool backlight_enabled;
 };
 
 struct panel_desc {
@@ -195,7 +197,27 @@ static int himax_bl_update_status(struct backlight_device *bl)
 {
 	struct himax *ctx = bl_get_data(bl);
 	u16 brightness = backlight_get_brightness(bl);
+	int ret = 0;
+
+	if (!brightness) {
+		if (ctx->backlight_enabled)
+			ret = regulator_disable(ctx->bl_supply);
+		if (ret)
+			return ret;
+
+		ctx->backlight_enabled = false;
+
+		return 0;
+	}
+
 	/* TODO: brightness to raw map table */
+	if (!ctx->backlight_enabled)
+		ret = regulator_enable(ctx->bl_supply);
+	if (ret)
+		return ret;
+
+	ctx->backlight_enabled = true;
+
 	return mipi_dsi_dcs_set_display_brightness_large(to_primary_dsi(ctx),
 							 brightness);
 }
@@ -647,6 +669,10 @@ static int himax_probe(struct mipi_dsi_device *dsi)
 	ctx->panel.prepare_prev_first = true;
 
 	if (desc->has_dcs_backlight) {
+		ctx->bl_supply = devm_regulator_get_optional(dev, "bl");
+		if (IS_ERR(ctx->bl_supply))
+			return dev_err_probe(dev, PTR_ERR(ctx->bl_supply),
+					     "Failed to get backlight supply\n");
 		ctx->backlight = himax_create_backlight(ctx);
 		if (IS_ERR(ctx->backlight))
 			return dev_err_probe(dev, PTR_ERR(ctx->backlight),
-- 
2.52.0

