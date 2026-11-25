Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B8606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMo6dkY8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4D5210FC13;
	Wed, 25 Nov 2026 13:08:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1227F10FC05
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:08:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B153040A86;
 Wed, 25 Nov 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795612110;
 b=S14+LOKXjXiwDm1S5xZheMG5n1bLlxRB2IyAdVvagk6fgXCr0kFnzWgb1I8SrzFWVAXL
 7TQ82zzWZ94mBtvAPtMtJVIdE8iR/i7alYm+ImaTnBRzb0eowJAQnD3iTAO9l4c8wvtTS
 X/dGrrGihAKgXdAAdpr0KjpawN2vuRhG0WZHbzDKUipiLXw6ISP2oLu66H+GdtqTJycDP
 iO4plj400RxxZqHL2Zn9mkWq4rw6TsEfDbw8GLhJ6wR5Age2tKcdwZMSYeOcB8Rg80rJB
 xGLKSMXrpuW96R8OAtA61P/moAzV6r/Xow0si5IUDNIWueNDZ0K+pL/O1okIPemQ98A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795612110;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=fESytYguISeU3xk0blMtjiFLLdRNNzWhfJUl6e/2qf8=;
 b=yg3D0IpcUq2vKZ7jyZnjZYIGRtSNImygpP/zJ1KHotspP0oZaV8KioH7osfD2brFplwa
 Bj4R0X/4fZScj+xp3sYUmVRDOvN+Ho2+DBPSiw4H7zKAdv7VvYM9hdsPz0AGFMoyPNaPj
 gFDMQ78bik4pDy6Ktrs7BdVUiwbu7awIswyEqkbUOjFmnhZ54/wuTQedOQf+48HGVRcKb
 nnm+MkM9X9vjiaX82NUn+Gf5ud4P3R8kVtMbZfH1DNBEUZVPHKGmCGmgN5uV0nj6qb80L
 jKV5jHO8BCmKm12ZNZ7qQPxrPY8rHxRbYir6llWGhLpQU7RSw2riIw39ALTcHmK4daw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CE5641F000D8;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795612110;
 bh=fESytYguISeU3xk0blMtjiFLLdRNNzWhfJUl6e/2qf8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=YMo6dkY8NcpDUgpjzjzK53gQ4uUtUdrHr7KeIYVr5B3cZwcvI9jGWoFCWhCZYKTi3
 sBNwcpkYNjmztl8crJjlAihIfm8g8Oeh3ZbH7kdENfVP9zuQ1IA6tc1IwjPaGV5Wkj
 Q/e+WvtyYE0m4N+5zsXshsgijBm4ekwf6fX+tHp1xtZxrxb8LTmOfduGSwIuVyBF6D
 T8ftd2e+zQPxVhlXjcVef9Nkaf+yQE4p7Nk1Kz8UEfw5WxBP18W5xLpjK4BaxKtviW
 C3pwkMyIfGSy/2Gl2WLDgJ1St7p2kojzrb4R1/nzZI7kXxTIK3Pq0jtxUwIcbKKwPn
 WTeCv2e+A9jkw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 512C04CED9;
 Wed, 25 Nov 2026 13:08:19 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Nov 2026 14:08:15 +0100
Subject: [PATCH v3 4/5] drm/panel: lg-sw43408: keep VPNL paired with VDDI
 and reset deasserted
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-fix-blueline-panel-v3-4-914b4a30b73e@ixit.cz>
References: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
In-Reply-To: <20261125-fix-blueline-panel-v3-0-914b4a30b73e@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8066; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=sliVBym4W+p+eKezwMWh4+aHLg0af9CH5oOSuZc9UKg=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrBt3BRdZXFt13fHS1TxcxEIppnpPbnn1jWBWC6
 Phcx/3vFW+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawbdwQAKCRBgAj/E00kg
 cjWjD/0QzW4NVdUcwDOxfSmNIJrdH2xBMVnAt+FLwlGVtgbXKzXmEahtrsfvMzAkIw3PepZZWs5
 n0x2UEjSue3tDPUw4u2YthasaMnc+tbnlfWPBbSDEvx+W+c0tLXG1uZEZJNjf1RW8ugK07p1FJ0
 zieTgm4BbaEZ3UbVid/UeMWj2ILgC3Lk7gvJj++Lftk+m/q5zqS72KtaOuwldb8p+nrVPAA1QfJ
 pSK5hp19ILqtK5a+ysH9ai9F8qXJ9P442sxbRKwhPLCExWqW0aU2T22wHDwl77ukG4hNqkmAKDc
 WXTvbxMf2RxAZUH92IGj5S6/PVYrkBiBMUOoZWVzWPyCvjbSpUFzbHi3NOtMMO5991959PXYzL/
 Ayx9JHBKsPrBBTUIYPDzbHUHGdBcskSEc6EWIXvXcdt5uOnq+WbQBjeyridHfe9HrNxLsCM8hwc
 RG41IDamC86Ywo0rjDDMfitXg06Z1UJCo/tPxwpj2JdGX2FLx9FOXifU7Uxe/HDlUUn3Pqr/p2Z
 LSp5NG+e2M9prwZVrvh4n2tmnZn9LtfjwBhkmc8ggRVDNTjOHwqXxLqRktfmemMhjJ1CqJd7mpW
 BSFss6Nop8Ngcmpe6nZg05JPQcqkJXUYEvdW4C/q9R+dugytL8j2mWjsznbQTML6kRzH+RO64ta
 d+m/k+ggLnlP6/w==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Content-Transfer-Encoding: 7bit
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
Reply-To: david@ixit.cz
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Heidelberg <david@ixit.cz>

On Google Pixel 3, VDDI (1.8 V) is shared with the STM FTS5 touchscreen
and remains powered while the system is awake or when double-tap wakeup
is armed, whereas VPNL (3.0 V) is exclusive to the panel.

Hardware testing on Pixel 3 shows the SW43408 DDIC only recovers cleanly
across unprepare/prepare when VDDI and VPNL stay paired and reset is not
held asserted while VDDI is powered:
- VDDI ON, VPNL ON, reset HIGH (Sleep-In): recovers cleanly.
- VDDI OFF, VPNL OFF, reset HIGH (cold POR): recovers cleanly.
- VDDI ON, VPNL OFF (with reset either HIGH or LOW): panel stays black
  on the next prepare even though DCS commands, TE, and LAB/IBB report
  normal status, until a full VDDI power cycle occurs.
- VDDI ON, VPNL ON, reset LOW: panel stays black on the next prepare.

Stop asserting reset_gpio in sw43408_unprepare() and sw43408_prepare()'s
poweroff error path, and disable VDDI first in sw43408_power_off(). Only
disable VPNL once VDDI actually powered down, checking both immediately
in sw43408_power_off() and from a late system sleep callback in case
a shared consumer drops VDDI later during system suspend.

Track whether the driver still holds VPNL enabled so sw43408_prepare()
balances the enable count without glitching VPNL, and register a devm
cleanup action to release VPNL if the driver is removed while
unprepared.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 119 +++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 7123ad18744cf..6854292bd99ca 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -15,28 +15,38 @@
 #include <video/mipi_display.h>
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/display/drm_dsc.h>
 #include <drm/display/drm_dsc_helper.h>
 
+enum {
+	SW43408_SUPPLY_VDDI,
+	SW43408_SUPPLY_VPNL,
+};
+
 static const struct regulator_bulk_data sw43408_supplies[] = {
-	{ .supply = "vddi", /* 1.8 V */
-	  .init_load_uA = 62000 },
-	{ .supply = "vpnl", /* 3.0 V */
-	  .init_load_uA = 857000 },
+	[SW43408_SUPPLY_VDDI] = {
+		.supply = "vddi", /* 1.8 V */
+		.init_load_uA = 62000,
+	},
+	[SW43408_SUPPLY_VPNL] = {
+		.supply = "vpnl", /* 3.0 V */
+		.init_load_uA = 857000,
+	},
 };
 
 struct sw43408_panel {
 	struct drm_panel base;
 	struct mipi_dsi_device *link;
 
 	struct regulator_bulk_data *supplies;
+	bool vpnl_enabled;
 
 	struct gpio_desc *reset_gpio;
 
 	struct drm_dsc_config dsc;
 };
 
 static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
 {
@@ -52,24 +62,90 @@ static int sw43408_disable(struct drm_panel *panel)
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
 	mipi_dsi_msleep(&ctx, 100);
 
 	return ctx.accum_err;
 }
 
-static int sw43408_unprepare(struct drm_panel *panel)
+static int sw43408_maybe_disable_vpnl(struct sw43408_panel *ctx)
 {
-	struct sw43408_panel *sw43408 = to_panel_info(panel);
+	struct regulator *vddi = ctx->supplies[SW43408_SUPPLY_VDDI].consumer;
+	struct regulator *vpnl = ctx->supplies[SW43408_SUPPLY_VPNL].consumer;
+
+	/*
+	 * On Pixel 3, vddi is shared with the touchscreen and remains
+	 * powered while awake or when touch wakeup is armed. Dropping vpnl
+	 * (3.0 V) or asserting reset while vddi (1.8 V) stays powered leaves
+	 * the DDIC in a state no init sequence recovers from (until a full
+	 * vddi power cycle): it answers DCS commands and reports display-on,
+	 * but never lights up again.
+	 */
+	if (ctx->vpnl_enabled && regulator_is_enabled(vddi) == 0) {
+		int ret = regulator_disable(vpnl);
 
-	gpiod_set_value(sw43408->reset_gpio, 1);
+		if (ret < 0)
+			return ret;
+
+		ctx->vpnl_enabled = false;
+	}
 
-	return regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies),
-				      sw43408->supplies);
+	return 0;
+}
+
+static int sw43408_power_off(struct sw43408_panel *ctx)
+{
+	struct regulator *vddi = ctx->supplies[SW43408_SUPPLY_VDDI].consumer;
+	int ret;
+
+	ret = regulator_disable(vddi);
+	if (ret)
+		return ret;
+
+	ret = sw43408_maybe_disable_vpnl(ctx);
+	if (ret)
+		goto recover_vddi;
+
+	return 0;
+
+recover_vddi:
+	/* vpnl disable failed, thus we need to re-enable vddi */
+	(void)regulator_enable(vddi);
+	return ret;
+}
+
+static int sw43408_suspend_late(struct device *dev)
+{
+	struct sw43408_panel *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	if (ctx->base.prepared)
+		return 0;
+
+	ret = sw43408_maybe_disable_vpnl(ctx);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void sw43408_cleanup_vpnl(void *data)
+{
+	struct sw43408_panel *ctx = data;
+
+	if (ctx->vpnl_enabled) {
+		regulator_disable(ctx->supplies[SW43408_SUPPLY_VPNL].consumer);
+		ctx->vpnl_enabled = false;
+	}
+}
+
+static int sw43408_unprepare(struct drm_panel *panel)
+{
+	return sw43408_power_off(to_panel_info(panel));
 }
 
 static int sw43408_program(struct drm_panel *panel)
 {
 	struct sw43408_panel *sw43408 = to_panel_info(panel);
 	struct mipi_dsi_multi_context ctx = { .dsi = sw43408->link };
 	struct drm_dsc_picture_parameter_set pps;
 
@@ -144,35 +220,45 @@ static void sw43408_reset(struct sw43408_panel *ctx)
 	usleep_range(1000, 2000);
 	gpiod_set_value(ctx->reset_gpio, 0);
 	usleep_range(9000, 10000);
 }
 
 static int sw43408_prepare(struct drm_panel *panel)
 {
 	struct sw43408_panel *ctx = to_panel_info(panel);
+	struct regulator *vddi = ctx->supplies[SW43408_SUPPLY_VDDI].consumer;
+	struct regulator *vpnl = ctx->supplies[SW43408_SUPPLY_VPNL].consumer;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(sw43408_supplies), ctx->supplies);
+	ret = regulator_enable(vddi);
 	if (ret < 0)
 		return ret;
 
+	if (!ctx->vpnl_enabled) {
+		ret = regulator_enable(vpnl);
+		if (ret < 0) {
+			regulator_disable(vddi);
+			return ret;
+		}
+		ctx->vpnl_enabled = true;
+	}
+
 	usleep_range(5000, 6000);
 
 	sw43408_reset(ctx);
 
 	ret = sw43408_program(panel);
 	if (ret)
 		goto poweroff;
 
 	return 0;
 
 poweroff:
-	gpiod_set_value(ctx->reset_gpio, 1);
-	regulator_bulk_disable(ARRAY_SIZE(sw43408_supplies), ctx->supplies);
+	sw43408_power_off(ctx);
 	return ret;
 }
 
 static const struct drm_display_mode lh546wf1_ed01_mode = {
 	.clock = (1080 + 20 + 32 + 20) * (2160 + 20 + 4 + 20) * 60 / 1000,
 
 	.hdisplay = 1080,
 	.hsync_start = 1080 + 20,
@@ -255,16 +341,20 @@ static int sw43408_add(struct sw43408_panel *ctx)
 
 	ret = devm_regulator_bulk_get_const(dev,
 					    ARRAY_SIZE(sw43408_supplies),
 					    sw43408_supplies,
 					    &ctx->supplies);
 	if (ret < 0)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, sw43408_cleanup_vpnl, ctx);
+	if (ret < 0)
+		return ret;
+
 	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset_gpio)) {
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
 	}
 
 	ret = sw43408_backlight_init(ctx);
 	if (ret < 0)
@@ -313,20 +403,25 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
 	ctx->dsc.bits_per_pixel = 8 << 4;
 	ctx->dsc.block_pred_enable = true;
 
 	dsi->dsc = &ctx->dsc;
 
 	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
+static const struct dev_pm_ops sw43408_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(sw43408_suspend_late, NULL)
+};
+
 static struct mipi_dsi_driver sw43408_driver = {
 	.driver = {
 		.name = "panel-lg-sw43408",
 		.of_match_table = sw43408_of_match,
+		.pm = pm_sleep_ptr(&sw43408_pm_ops),
 	},
 	.probe = sw43408_probe,
 };
 module_mipi_dsi_driver(sw43408_driver);
 
 MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
 MODULE_DESCRIPTION("LG SW436408 MIPI-DSI LED panel");
 MODULE_LICENSE("GPL");

-- 
2.55.0


