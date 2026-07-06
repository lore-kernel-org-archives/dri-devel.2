Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EC8C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DC910F41C;
	Thu,  9 Jul 2026 07:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="TWSiEJVy";
	dkim-atps=neutral
X-Greylist: delayed 488 seconds by postgrey-1.36 at gabe;
 Mon, 06 Jul 2026 13:54:00 UTC
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D023D10E31A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:54:00 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260706134551euoutp0234a9f8164d91c87677114acc85ba989e~-t1Sl1Vav2955129551euoutp02K
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:45:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260706134551euoutp0234a9f8164d91c87677114acc85ba989e~-t1Sl1Vav2955129551euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1783345551;
 bh=+m1w1k12hN6oUJ9W0vrG2LgJSX0XlVCKjrRk8A+1o4Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TWSiEJVyzfVchTtp3wVeIL/weB+a7Ocal2F+DmM+WXbF4AwSLovkmC9OdpMSknuWM
 10wG4cSnwcdDZKW3mmIQQPmXokD67zqVLpSRLXKv8yQyEFhbZcE25krOCPMHMx0xWb
 ItQf8KPXK9c39CE41xqQXNNgq75egNreappYw15g=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260706134551eucas1p2699f145a53a0d5d8cd92d0a062c62ad9~-t1SPHGgy0259902599eucas1p2T;
 Mon,  6 Jul 2026 13:45:51 +0000 (GMT)
Received: from AMDC4670.local (unknown [106.120.77.38]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260706134550eusmtip1b975d77168bb84bb04e40cf13891bbea~-t1Rs_REN0593605936eusmtip1D;
 Mon,  6 Jul 2026 13:45:50 +0000 (GMT)
From: Jan Niedziolka <j.niedziolka@samsung.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 k.tegowski@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.fijalko@samsung.com, bartlomiej.k@samsung.com, Jan Niedziolka
 <j.niedziolka@samsung.com>
Subject: [PATCH 2/3] gpu/drm: Remove unused 'drm device *dev' parameter from
 drm_mode_create()
Date: Mon,  6 Jul 2026 15:34:40 +0200
Message-ID: <20260706134515.3369960-3-j.niedziolka@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706134515.3369960-1-j.niedziolka@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260706134551eucas1p2699f145a53a0d5d8cd92d0a062c62ad9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260706134551eucas1p2699f145a53a0d5d8cd92d0a062c62ad9
X-EPHeader: CA
X-CMS-RootMailID: 20260706134551eucas1p2699f145a53a0d5d8cd92d0a062c62ad9
References: <20260706134515.3369960-1-j.niedziolka@samsung.com>
 <CGME20260706134551eucas1p2699f145a53a0d5d8cd92d0a062c62ad9@eucas1p2.samsung.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Get rid of unused 'struct drm_device *dev' parameter from drm_mode_create()
prototype and definition.
Keep drm_mode_create() doc comment up to date - remove unnecessary *dev record.
Also, fix all drm_mode_create() calls where *dev argument is used.

Fixes: 0e691bc73026 ("drm: Remove use of drm_mode_object")
Signed-off-by: Jan Niedziolka <j.niedziolka@samsung.com>
---
 drivers/gpu/drm/drm_crtc.c                    |  2 +-
 drivers/gpu/drm/drm_edid.c                    |  4 +-
 drivers/gpu/drm/drm_modes.c                   | 11 ++---
 drivers/gpu/drm/exynos/exynos_dp.c            | 47 +++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dpi.c       |  2 +-
 drivers/gpu/drm/gud/gud_connector.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_tv.c       |  2 +-
 drivers/gpu/drm/panel/panel-edp.c             |  2 +-
 .../drm/panel/panel-olimex-lcd-olinuxino.c    |  2 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c  |  2 +-
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c |  2 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   |  2 +-
 drivers/gpu/drm/panel/panel-simple.c          |  2 +-
 .../gpu/drm/renesas/shmobile/shmob_drm_crtc.c |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_conn.c      |  2 +-
 include/drm/drm_modes.h                       |  2 +-
 16 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 22039a553a24..cda6dbadaa94 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -777,7 +777,7 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 			}
 		}
 
-		mode = drm_mode_create(dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			ret = -ENOMEM;
 			goto out;
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 7f456e9c27a5..2a9a982da74e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3563,7 +3563,7 @@ static struct drm_display_mode *drm_mode_detailed(struct drm_connector *connecto
 		goto set_size;
 	}
 
-	mode = drm_mode_create(dev);
+	mode = drm_mode_create();
 	if (!mode)
 		return NULL;
 
@@ -6876,7 +6876,7 @@ static struct drm_display_mode *drm_mode_displayid_detailed(struct drm_device *d
 	bool hsync_positive = le16_to_cpu(timings->hsync) & (1 << 15);
 	bool vsync_positive = le16_to_cpu(timings->vsync) & (1 << 15);
 
-	mode = drm_mode_create(dev);
+	mode = drm_mode_create();
 	if (!mode)
 		return NULL;
 
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 175bf3eef14b..049d77e75ddd 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -63,7 +63,6 @@ EXPORT_SYMBOL(drm_mode_debug_printmodeline);
 
 /**
  * drm_mode_create - create a new display mode
- * @dev: DRM device
  *
  * Create a new, cleared drm_display_mode with kzalloc, allocate an ID for it
  * and return it.
@@ -71,7 +70,7 @@ EXPORT_SYMBOL(drm_mode_debug_printmodeline);
  * Returns:
  * Pointer to new mode on success, NULL on error.
  */
-struct drm_display_mode *drm_mode_create(struct drm_device *dev)
+struct drm_display_mode *drm_mode_create(void)
 {
 	struct drm_display_mode *nmode;
 
@@ -577,7 +576,7 @@ struct drm_display_mode *drm_analog_tv_mode(struct drm_device *dev,
 		return NULL;
 	}
 
-	mode = drm_mode_create(dev);
+	mode = drm_mode_create();
 	if (!mode)
 		return NULL;
 
@@ -646,7 +645,7 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
 	/* allocate the drm_display_mode structure. If failure, we will
 	 * return directly
 	 */
-	drm_mode = drm_mode_create(dev);
+	drm_mode = drm_mode_create();
 	if (!drm_mode)
 		return NULL;
 
@@ -881,7 +880,7 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
 	if (!hdisplay || !vdisplay)
 		return NULL;
 
-	drm_mode = drm_mode_create(dev);
+	drm_mode = drm_mode_create();
 	if (!drm_mode)
 		return NULL;
 
@@ -1458,7 +1457,7 @@ struct drm_display_mode *drm_mode_duplicate(struct drm_device *dev,
 {
 	struct drm_display_mode *nmode;
 
-	nmode = drm_mode_create(dev);
+	nmode = drm_mode_create();
 	if (!nmode)
 		return NULL;
 
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index b80540328150..78183809b4fb 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -68,6 +68,53 @@ static int exynos_dp_poweroff(struct analogix_dp_plat_data *plat_data)
 	return exynos_dp_crtc_clock_enable(plat_data, false);
 }
 
+static int exynos_dp_get_modes(struct analogix_dp_plat_data *plat_data,
+			       struct drm_connector *connector)
+{
+	struct exynos_dp_device *dp = to_dp(plat_data);
+	struct drm_display_mode *mode;
+
+	if (dp->plat_data.panel)
+		return 0;
+
+	mode = drm_mode_create();
+	if (!mode) {
+		DRM_DEV_ERROR(dp->dev,
+			      "failed to create a new display mode.\n");
+		return 0;
+	}
+
+	drm_display_mode_from_videomode(&dp->vm, mode);
+	connector->display_info.width_mm = mode->width_mm;
+	connector->display_info.height_mm = mode->height_mm;
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
+				   struct drm_bridge *bridge,
+				   struct drm_connector *connector)
+{
+	struct exynos_dp_device *dp = to_dp(plat_data);
+	int ret;
+
+	dp->connector = connector;
+
+	/* Pre-empt DP connector creation if there's a bridge */
+	if (dp->ptn_bridge) {
+		ret = drm_bridge_attach(&dp->encoder, dp->ptn_bridge, bridge,
+					0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static void exynos_dp_mode_set(struct drm_encoder *encoder,
 			       struct drm_display_mode *mode,
 			       struct drm_display_mode *adjusted_mode)
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 0dc36df6ada3..391c831c87f8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -69,7 +69,7 @@ static int exynos_dpi_get_modes(struct drm_connector *connector)
 	if (ctx->vm) {
 		struct drm_display_mode *mode;
 
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			DRM_DEV_ERROR(ctx->dev,
 				      "failed to create a new display mode\n");
diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index ea0cca58b7c8..50315175d6d9 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -264,7 +264,7 @@ static int gud_connector_get_modes(struct drm_connector *connector)
 	for (i = 0; i < num_modes; i++) {
 		struct drm_display_mode *mode;
 
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			num_modes = i;
 			goto out;
diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
index 0a926c6f25f4..071520565ddb 100644
--- a/drivers/gpu/drm/i915/display/intel_tv.c
+++ b/drivers/gpu/drm/i915/display/intel_tv.c
@@ -1807,7 +1807,7 @@ intel_tv_get_modes(struct drm_connector *connector)
 		    input->h > intel_tv_mode_vdisplay(tv_mode))
 			continue;
 
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode)
 			continue;
 
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index aa27d6cd932e..21651a16d1ba 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -262,7 +262,7 @@ static unsigned int panel_edp_get_timings_modes(struct panel_edp *panel,
 		struct videomode vm;
 
 		videomode_from_timing(dt, &vm);
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			dev_err(panel->base.dev, "failed to add mode %ux%u\n",
 				dt->hactive.typ, dt->vactive.typ);
diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 66f99982f360..fec0a29ce073 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -112,7 +112,7 @@ static int lcd_olinuxino_get_modes(struct drm_panel *panel,
 		lcd_mode = (struct lcd_olinuxino_mode *)
 			   &lcd->eeprom.reserved[i * sizeof(*lcd_mode)];
 
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
 				lcd_mode->hactive,
diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index c7f2241523a0..727d92dafd75 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -267,7 +267,7 @@ static int ld9040_get_modes(struct drm_panel *panel,
 	struct ld9040 *ctx = panel_to_ld9040(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_create(connector->dev);
+	mode = drm_mode_create();
 	if (!mode) {
 		dev_err(panel->dev, "failed to create a new display mode\n");
 		return 0;
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index 1b5c500d4f4e..4b11784a8416 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -925,7 +925,7 @@ static int s6e8aa0_get_modes(struct drm_panel *panel,
 	struct s6e8aa0 *ctx = panel_to_s6e8aa0(panel);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_create(connector->dev);
+	mode = drm_mode_create();
 	if (!mode) {
 		dev_err(panel->dev, "failed to create a new display mode\n");
 		return 0;
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 0935d83ee2db..cea5843c00ca 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -69,7 +69,7 @@ static int seiko_panel_get_fixed_modes(struct seiko_panel *panel,
 		struct videomode vm;
 
 		videomode_from_timing(dt, &vm);
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			dev_err(panel->base.dev, "failed to add mode %ux%u\n",
 				dt->hactive.typ, dt->vactive.typ);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c09bf3db5e78..811efddc29c1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -180,7 +180,7 @@ static unsigned int panel_simple_get_timings_modes(struct panel_simple *panel,
 		struct videomode vm;
 
 		videomode_from_timing(dt, &vm);
-		mode = drm_mode_create(connector->dev);
+		mode = drm_mode_create();
 		if (!mode) {
 			dev_err(panel->base.dev, "failed to add mode %ux%u\n",
 				dt->hactive.typ, dt->vactive.typ);
diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 1a2b9b68af6f..6c8f705b9541 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -489,7 +489,7 @@ static int shmob_drm_connector_get_modes(struct drm_connector *connector)
 	struct shmob_drm_connector *scon = to_shmob_connector(connector);
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_create(connector->dev);
+	mode = drm_mode_create();
 	if (mode == NULL)
 		return 0;
 
diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index a1ba6d3d0568..8051d8976efa 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -67,7 +67,7 @@ static int connector_get_modes(struct drm_connector *connector)
 	struct videomode videomode;
 	int width, height;
 
-	mode = drm_mode_create(connector->dev);
+	mode = drm_mode_create();
 	if (!mode)
 		return 0;
 
diff --git a/include/drm/drm_modes.h b/include/drm/drm_modes.h
index b1d1ecb15f02..94e846ef38be 100644
--- a/include/drm/drm_modes.h
+++ b/include/drm/drm_modes.h
@@ -452,7 +452,7 @@ static inline bool drm_mode_is_stereo(const struct drm_display_mode *mode)
 struct drm_connector;
 struct drm_cmdline_mode;
 
-struct drm_display_mode *drm_mode_create(struct drm_device *dev);
+struct drm_display_mode *drm_mode_create(void);
 void drm_mode_destroy(struct drm_display_mode *mode);
 void drm_mode_convert_to_umode(struct drm_mode_modeinfo *out,
 			       const struct drm_display_mode *in);
-- 
2.43.0

