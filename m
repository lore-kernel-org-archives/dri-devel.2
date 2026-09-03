Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D12C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ACB10F55F;
	Thu,  3 Sep 2026 12:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i7+QzDf7";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C3310F558
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:28 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B81FA287E;
 Thu,  3 Sep 2026 14:08:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437335;
 bh=rFvZjO1RFhJRljXnqUwhl6cExIU48JcwgpRoC/z58aQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=i7+QzDf7wuclFjtyJjoL7/eDSpwuyq6LDNhTT2oDpKGKJSDJmEU0oxY8ybTPPXpWl
 MsCjUgJWB2sVQe27dTjJH58yqoynJOxQQIwcw6rsE8tBV02eDEaOia3tzY9k0DAO9A
 KN+SOjoUuns3MVlFF/vpsoCyDqGqJ6ZyvW9YlyXU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 15:09:58 +0300
Subject: [PATCH 08/10] drm/tidss: oldi: Fix OLDI signal polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-tidss-pre-beagley-v1-8-93928baa8b12@ideasonboard.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5041;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=rFvZjO1RFhJRljXnqUwhl6cExIU48JcwgpRoC/z58aQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOo6IPuNYueS1Ah/DIu22bFN89gjd9h/9P13
 gnmM7y3GxyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljqAAKCRD6PaqMvJYe
 9S8UEACpuDjIDQXdqmZfabUKJEe4wgXVh9aS9TbMwIdg1ve/ImEVnBhUjx2/OLXUBg7wl1qR++Z
 Vky4h4E53+R7Y8mT9SmBp+gi4DvGn2Ju3Tlfn+vU1MUZ/LvHgbCHByH0MdRFekqleKmrzikr+Zt
 JRY4UgP8oSzKQFg2XlEh3dQSNYhyBqWWthM6Na/V1ChxKzPlsIht4xb+M+9g6ry5tuK6vYMA9OE
 eTBD3oSO07bIP0rTuUU4rXaBXr+4Y4WwJ+Bp/+iAQF4WGEpaBzx5yATjMOjInNGLVypIaTP8Bx3
 CUK1ws0XQhaLAHSXpiKrDjklJseL5Iqqlq1+ZLcH4YVCryihO6aKbCMUZ3x2xWfxx4ivLHkgiNe
 9Lb86Xw27K1ZwmN+71CU3Las3IhPwj18u0Q29JiU2cw5K2qAb5RWsiV7MiDE6CacWAx+KrytKJb
 wGdrFgytq+WA68WGfXsKCG4+9esBDI1mmuc+TLkNRwyRPobdAq9PC9Iz8Un8Ad0iEFeWa1oGvrt
 CTrm41XO/9tps/jBhw7FykFqlzgIdCeY9/vynpCfxz0XAlfQ2Eisz4noI17jb5s1HtNkvecB3QC
 6wcpOBtKeRWFovgvM6Y8tqed7LSj1BPAtcdJSwX37s6ikZiX0/XdtmqBXfvExep/fhoJHb+IuFe
 G1AVfSzVFF4Ckkg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

OLDI has a few issues with how it handles the signal polarities:

- It always sets OLDI_DEPOL, which means DE active low
- It sets DRM_BUS_FLAG_DE_HIGH in struct drm_bridge_timings, i.e.
  reverse to the OLDI_DEPOL
- It sets DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE in struct drm_bridge_timings,
  but the TRM says "The DSS interface is clocked on the rising edge of
  OLDI_FWD_P_CLK pixel clock", which I read as "OLDI samples on rising
  edge".
- But the defined drm_bridge_timings is not actually used anywhere, even
  if it is set to bridge->timings, so the bus flags are just ignored.

However, based on my testing, OLDI_DEPOL bit or the edge on which data
and syncs are driven doesn't seem to affect the OLDI output. Possibly
it's not as robust, but I did not see any effect with an oscilloscope.

However, the code is still quite broken, so let's fix it:
- Remove drm_bridge_timings
- Set the correct input_bus_cfg.flags in tidss_oldi_atomic_check()
- Set OLDI_DEPOL based on the DE bus flag

Tested-by: Swamil Jain <s-jain1@ti.com>
Reviewed-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 5eb749f495d5..624f1646fb07 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -164,7 +164,8 @@ static void tidss_oldi_tx_power(struct tidss_oldi *oldi, bool enable)
 	regmap_update_bits(oldi->io_ctrl, OLDI_PD_CTRL, mask, enable ? 0 : mask);
 }
 
-static int tidss_oldi_config(struct tidss_oldi *oldi)
+static int tidss_oldi_config(struct tidss_oldi *oldi,
+			     struct drm_bridge_state *bridge_state)
 {
 	const struct oldi_bus_format *bus_fmt = NULL;
 	u32 oldi_cfg = 0;
@@ -183,7 +184,8 @@ static int tidss_oldi_config(struct tidss_oldi *oldi)
 			 "OLDI%u: DSS port width %d not supported\n",
 			 oldi->oldi_instance, bus_fmt->data_width);
 
-	oldi_cfg |= OLDI_DEPOL;
+	if (bridge_state->input_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW)
+		oldi_cfg |= OLDI_DEPOL; /* 1 = active low */
 
 	oldi_cfg = (oldi_cfg & (~OLDI_MAP)) | (bus_fmt->oldi_mode_reg_val << 1);
 
@@ -220,6 +222,22 @@ static int tidss_oldi_config(struct tidss_oldi *oldi)
 	return ret;
 }
 
+static int tidss_oldi_atomic_check(struct drm_bridge *bridge,
+				   struct drm_bridge_state *bridge_state,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state)
+{
+	bridge_state->input_bus_cfg.flags &=
+		~(DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		  DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE);
+
+	bridge_state->input_bus_cfg.flags |=
+		DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE;
+
+	return 0;
+}
+
 static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
 					 struct drm_atomic_commit *state)
 {
@@ -228,6 +246,7 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_display_mode *mode;
+	struct drm_bridge_state *bridge_state;
 
 	if (oldi->link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK)
 		return;
@@ -245,10 +264,14 @@ static void tidss_oldi_atomic_pre_enable(struct drm_bridge *bridge,
 	if (WARN_ON(!crtc_state))
 		return;
 
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+	if (WARN_ON(!bridge_state))
+		return;
+
 	mode = &crtc_state->adjusted_mode;
 
 	/* Configure the OLDI params*/
-	tidss_oldi_config(oldi);
+	tidss_oldi_config(oldi, bridge_state);
 
 	/* Set the OLDI serial clock (7 times the pixel clock) */
 	tidss_oldi_set_serial_clk(oldi, mode->clock * 7 * 1000);
@@ -329,7 +352,8 @@ tidss_oldi_mode_valid(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
-	.attach	= tidss_oldi_bridge_attach,
+	.attach = tidss_oldi_bridge_attach,
+	.atomic_check = tidss_oldi_atomic_check,
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
 	.atomic_post_disable = tidss_oldi_atomic_post_disable,
 	.atomic_get_input_bus_fmts = tidss_oldi_atomic_get_input_bus_fmts,
@@ -440,11 +464,6 @@ static int get_parent_dss_vp(struct device_node *oldi_tx, u32 *parent_vp)
 	return -ENODEV;
 }
 
-static const struct drm_bridge_timings default_tidss_oldi_timings = {
-	.input_bus_flags = DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE
-			 | DRM_BUS_FLAG_DE_HIGH,
-};
-
 void tidss_oldi_deinit(struct tidss_device *tidss)
 {
 	for (int i = 0; i < tidss->num_oldis; i++) {
@@ -598,7 +617,6 @@ int tidss_oldi_init(struct tidss_device *tidss)
 		/* Register the bridge. */
 		oldi->bridge.of_node = child;
 		oldi->bridge.driver_private = oldi;
-		oldi->bridge.timings = &default_tidss_oldi_timings;
 
 		tidss->oldis[tidss->num_oldis++] = oldi;
 		tidss->is_ext_vp_clk[oldi->parent_vp] = true;

-- 
2.43.0

