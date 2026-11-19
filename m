Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759C606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=IU4FWGHU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3D5112783;
	Thu, 19 Nov 2026 22:38:58 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB0611277D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:38:52 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261119223850euoutp0211f050b340290a51494f9b09cdc681be~pk1eb0WkJ0813808138euoutp02a
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 22:38:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261119223850euoutp0211f050b340290a51494f9b09cdc681be~pk1eb0WkJ0813808138euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795127931;
 bh=IyhCtPxAOxrGyki28nMoGyyI3HRHwoX1RJn1wNBIqdM=;
 h=From:To:Cc:Subject:Date:References:From;
 b=IU4FWGHUfl0DbtLGw1Na3Qy++KX80T0mhcLMEqek1pq0/ZLaHPfoFZ+3YUSwtE+SM
 bq+ndUzSxhESdi0b8fffe6T7oZcogSWx66Yd2x8GWKmHNoViWh3nC3XnjSnWEpfQTK
 i5nqhOm00bF8ZypYhZh2Wdt3pa8N11HBjf1LWZQM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261119223849eucas1p1ead1f9ecc9bab76245a4cb6cb91d8e00~pk1dY-Ne70286602866eucas1p1f;
 Thu, 19 Nov 2026 22:38:49 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261119223849eusmtip1b6e16b1a8f5c9c9b906a997dd4b263fd~pk1c-LZqP1774617746eusmtip1e;
 Thu, 19 Nov 2026 22:38:49 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Jingoo Han
 <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
 <alim.akhtar@samsung.com>
Subject: [PATCH] drm/exynos: dp: Enable pipe clock from encoder
 enable/disable callbacks
Date: Thu, 19 Nov 2026 23:38:42 +0100
Message-ID: <20261119223843.3694307-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119223849eucas1p1ead1f9ecc9bab76245a4cb6cb91d8e00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119223849eucas1p1ead1f9ecc9bab76245a4cb6cb91d8e00
X-EPHeader: CA
X-CMS-RootMailID: 20261119223849eucas1p1ead1f9ecc9bab76245a4cb6cb91d8e00
References: <CGME20261119223849eucas1p1ead1f9ecc9bab76245a4cb6cb91d8e00@eucas1p1.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FIMD -> DP video (pipe) clock is switched from the analogix_dp
runtime PM callbacks through plat_data->power_on()/power_off(). This
only works if the DP device runtime suspends while the encoder is still
attached to the CRTC, i.e. synchronously from the bridge disable path,
and runtime resumes from the bridge enable path. Otherwise power_off()
bails out with -EPERM because encoder->crtc is already NULL, the FIMD
driver keeps its cached dp_clk_enabled state set, and after FIMD loses
power during system suspend the clock is never enabled again. Enabling
the bridge on resume then fails on Exynos5250 Snow:

  exynos-dp 145b0000.dp-controller: Timeout of slave video streamclk ok
  exynos-dp 145b0000.dp-controller: unable to config video
  [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
  exynos-dp 145b0000.dp-controller: failed to set bridge, retry: 0
  ...
  exynos-dp 145b0000.dp-controller: too many times retry set bridge, give it up

This happens whenever the DP device stays runtime active across the
display disable, for example when runtime PM is blocked by writing "on"
to its power/control sysfs attribute. Since commit f2b556e3dad6 ("PM:
runtime: Update last_busy before calling rpm_suspend() in rpm_idle()")
it also happens by default, because pm_runtime_put_sync() in the bridge
disable path now only schedules an autosuspend after the 100ms delay and
the device is runtime suspended only later by
pm_runtime_force_suspend().

Tie the pipe clock to the display state instead of the DP device power
state: enable it from the encoder .enable callback and disable it from
the encoder .disable callback. The atomic helpers call them after the
CRTC is enabled and before the bridge enable, and after the bridge
disable and before the CRTC disable, so the FIMD is active, the clock
is running when the analogix DP configures the video input, and
encoder->crtc is valid in both cases. This also matches the other Exynos
DRM drivers, which switch the pipe clock from their enable/disable
callbacks.

Fixes: 3424e3a4f844 ("drm: bridge: analogix/dp: split exynos dp driver to bridge directory")
Fixes: 73f613908eb1 ("drm/bridge: analogix_dp: move platform and PHY power handling into runtime PM")
Closes: https://lore.kernel.org/all/av9AkwQDhB7O4wgl@google.com/
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch has been developed with LLM assistance and have been tested
on the real Exynos5250-based Snow Chromebook device.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/gpu/drm/exynos/exynos_dp.c | 41 +++++++-----------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 4db7400c8a23..8beae1132dfa 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -32,8 +32,6 @@
 
 #include "exynos_drm_crtc.h"
 
-#define to_dp(nm)	container_of(nm, struct exynos_dp_device, nm)
-
 struct exynos_dp_device {
 	struct drm_encoder         encoder;
 	struct drm_device          *drm_dev;
@@ -43,39 +41,20 @@ struct exynos_dp_device {
 	struct analogix_dp_plat_data plat_data;
 };
 
-static int exynos_dp_crtc_clock_enable(struct analogix_dp_plat_data *plat_data,
-				bool enable)
-{
-	struct exynos_dp_device *dp = to_dp(plat_data);
-	struct drm_encoder *encoder = &dp->encoder;
-
-	if (!encoder->crtc)
-		return -EPERM;
-
-	exynos_drm_pipe_clk_enable(to_exynos_crtc(encoder->crtc), enable);
-
-	return 0;
-}
-
-static int exynos_dp_poweron(struct analogix_dp_plat_data *plat_data)
-{
-	return exynos_dp_crtc_clock_enable(plat_data, true);
-}
-
-static int exynos_dp_poweroff(struct analogix_dp_plat_data *plat_data)
-{
-	return exynos_dp_crtc_clock_enable(plat_data, false);
-}
-
 static void exynos_dp_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
 {
 }
 
-static void exynos_dp_nop(struct drm_encoder *encoder)
+static void exynos_dp_enable(struct drm_encoder *encoder)
+{
+	exynos_drm_pipe_clk_enable(to_exynos_crtc(encoder->crtc), true);
+}
+
+static void exynos_dp_disable(struct drm_encoder *encoder)
 {
-	/* do nothing */
+	exynos_drm_pipe_clk_enable(to_exynos_crtc(encoder->crtc), false);
 }
 
 static const struct drm_encoder_funcs exynos_dp_encoder_funcs = {
@@ -84,8 +63,8 @@ static const struct drm_encoder_funcs exynos_dp_encoder_funcs = {
 
 static const struct drm_encoder_helper_funcs exynos_dp_encoder_helper_funcs = {
 	.mode_set = exynos_dp_mode_set,
-	.enable = exynos_dp_nop,
-	.disable = exynos_dp_nop,
+	.enable = exynos_dp_enable,
+	.disable = exynos_dp_disable,
 };
 
 static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
@@ -170,8 +149,6 @@ static int exynos_dp_probe(struct platform_device *pdev)
 
 	/* The remote port can be either a panel or a bridge */
 	dp->plat_data.dev_type = EXYNOS_DP;
-	dp->plat_data.power_on = exynos_dp_poweron;
-	dp->plat_data.power_off = exynos_dp_poweroff;
 	dp->plat_data.ops = &exynos_dp_ops;
 
 	dp->adp = analogix_dp_probe(dev, &dp->plat_data);
-- 
2.43.0

