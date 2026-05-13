Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D67CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 203E710EE79;
	Wed, 13 May 2026 13:18:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RmqGVWdO";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E217D10EE78
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:05 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 92C9A2E6B;
 Wed, 13 May 2026 15:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678276;
 bh=MrAjka1D20dEvHeE79IK5H5AEJhNel9NxBpXOhee+Q8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RmqGVWdOu7q12709miAhB1xapZHlPyt2j+E9fZEOGkDJfaCvFCvqVouom0KupF3cV
 A2lLDKxZQI+lXyE6Ts90cUfnNrc+hapRJeOuZvniAm7pCh3u6OoMoCRLNfI8Grg0Uo
 zI0MdtmHdnAqZMY5T6y7iNdmEvcifLmcETsyZmu0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:30 +0300
Subject: [PATCH v2 08/16] drm/tidss: Add mechanism to detect DPI output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-8-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8450;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=MrAjka1D20dEvHeE79IK5H5AEJhNel9NxBpXOhee+Q8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn/32Szw/TlqUEhEHpyppXM04CluvkNOCVNd
 jHEEctIfHCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/wAKCRD6PaqMvJYe
 9UfMEACh7uiFdfBPA+bz5Dx9LsCTGd5Izs72YYN6XDdAG++M1MoQ7pqHel7uvh0FlCJQjURQI6Q
 cPXgZ35cLYkuoqGHq2oo1OoFKazi/yyTXh7+QqJJ9Y19T5/reFr8ZWR3lh+gVqBSoG3mDojTHr8
 gR8V6d0vLwaA7jcZf73umcVdfg5RuaT7nvE/SCbPx+6kv9Rfkn7wc+NkoSaEkAvKFCCpeLIAnXO
 DqvehT/BCymdIBrPDQ8yLgOfexBpg45Rr6KhIQAElTYmLcnFEatcAkjQKPsE110SC7W8v1J3akL
 wHPUalLfWx7jJX4mctuYnT+QsqMhvTLbA6AErnBLfcm78vLbpKhG+gwpLnt7NHt6uo3pPQerioc
 rmQXrZ2CIqG40zT2XSWEjax3AypXcjrv/bMnogWPr68GLMYxn3eQrXak6PKF/dLhiJXhrQinIoQ
 Eq0ckSD24Bc+lf3HD2xjponiM7q4bmofgw/EbQzr/kKjy4PLlNyAmp+gzBYwr+8Esv32o2LZq0G
 r5a4jIAoOD5UPn0LSAZE6kWJ99Fx4tKdt7+y4OD5gfAVEDx3DnNr8TvTm5HyJ/5zCHt9YpDpoZN
 NO7UilTu/6rXyBw8IzzNAsFdGWEvCcWGsC0c1lrWNI8ERIgorVCixvrCrczEdG2/glyEBL0RI95
 xaHvsFNp1wXXxCg==
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

There are situations where the driver needs to know if the output is
going to the DPI output or not. There is no trivial way to get this
information, as there is no "DPI bridge". We can only find this out in
reverse: check if the output is NOT DPI, and if that is negative, then
it must be DPI.

At the moment we have two non-DPI outputs: DSI and OLDI. DSI always has
"ti,j721e-dsi" DSI bridge connected to the DSI, so we can use that for
checking. OLDI doesn't have a compatible property, but we can check if
the DT node has "oldi-transmitters" node as a parent, and the dss node
itself as a grand-parent.

If the output is not connected to either of the above, it must be DPI.

Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  | 10 +++++--
 drivers/gpu/drm/tidss/tidss_crtc.h  |  4 ++-
 drivers/gpu/drm/tidss/tidss_dispc.c |  5 +++-
 drivers/gpu/drm/tidss/tidss_dispc.h |  3 +-
 drivers/gpu/drm/tidss/tidss_kms.c   | 55 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index a31c21c5f855..dfdf61b01dcd 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -192,7 +192,8 @@ static void tidss_crtc_atomic_flush(struct drm_crtc *crtc,
 		return;
 
 	/* Write vp properties to HW if needed. */
-	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, false);
+	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, false,
+		       tcrtc->dpi_output);
 
 	/* Update plane positions if needed. */
 	tidss_crtc_position_planes(tidss, crtc, old_crtc_state, false);
@@ -235,7 +236,8 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (r != 0)
 		return;
 
-	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, true);
+	dispc_vp_setup(tidss->dispc, tcrtc->hw_videoport, crtc->state, true,
+		       tcrtc->dpi_output);
 	tidss_crtc_position_planes(tidss, crtc, old_state, true);
 
 	/* Turn vertical blanking interrupt reporting on. */
@@ -417,7 +419,8 @@ static const struct drm_crtc_funcs tidss_crtc_funcs = {
 
 struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
 				     u32 hw_videoport,
-				     struct drm_plane *primary)
+				     struct drm_plane *primary,
+				     bool dpi_output)
 {
 	struct tidss_crtc *tcrtc;
 	struct drm_crtc *crtc;
@@ -430,6 +433,7 @@ struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
 		return ERR_PTR(-ENOMEM);
 
 	tcrtc->hw_videoport = hw_videoport;
+	tcrtc->dpi_output = dpi_output;
 	init_completion(&tcrtc->framedone_completion);
 
 	crtc =  &tcrtc->crtc;
diff --git a/drivers/gpu/drm/tidss/tidss_crtc.h b/drivers/gpu/drm/tidss/tidss_crtc.h
index 040d1205496b..65df220698f6 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.h
+++ b/drivers/gpu/drm/tidss/tidss_crtc.h
@@ -20,6 +20,7 @@ struct tidss_crtc {
 	struct drm_crtc crtc;
 
 	u32 hw_videoport;
+	bool dpi_output;
 
 	struct drm_pending_vblank_event *event;
 
@@ -44,5 +45,6 @@ void tidss_crtc_error_irq(struct drm_crtc *crtc, u64 irqstatus);
 
 struct tidss_crtc *tidss_crtc_create(struct tidss_device *tidss,
 				     u32 hw_videoport,
-				     struct drm_plane *primary);
+				     struct drm_plane *primary,
+				     bool dpi_output);
 #endif
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 58d5eb033bdb..c21ac3f51720 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -448,6 +448,7 @@ static const u16 *dispc_common_regmap;
 
 struct dss_vp_data {
 	u32 *gamma_table;
+	bool dpi_output;
 };
 
 struct dispc_device {
@@ -2770,8 +2771,10 @@ static void dispc_vp_set_color_mgmt(struct dispc_device *dispc,
 }
 
 void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
-		    const struct drm_crtc_state *state, bool newmodeset)
+		    const struct drm_crtc_state *state, bool newmodeset,
+		    bool dpi_output)
 {
+	dispc->vp_data[hw_videoport].dpi_output = dpi_output;
 	dispc_vp_set_default_color(dispc, hw_videoport, 0);
 	dispc_vp_set_color_mgmt(dispc, hw_videoport, state, newmodeset);
 }
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 739d211d0018..6f53d554259c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -131,7 +131,8 @@ void dispc_vp_disable_clk(struct dispc_device *dispc, u32 hw_videoport);
 int dispc_vp_set_clk_rate(struct dispc_device *dispc, u32 hw_videoport,
 			  unsigned long rate);
 void dispc_vp_setup(struct dispc_device *dispc, u32 hw_videoport,
-		    const struct drm_crtc_state *state, bool newmodeset);
+		    const struct drm_crtc_state *state, bool newmodeset,
+		    bool dpi_output);
 
 int dispc_runtime_suspend(struct dispc_device *dispc);
 int dispc_runtime_resume(struct dispc_device *dispc);
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 8bb93194e5ac..bc8b10af9a48 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -122,6 +122,50 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static const char * const tidss_internal_bridge_compatibles[] = {
+	"ti,j721e-dsi",
+};
+
+/*
+ * Detect whether the bridge is internal to the SoC or not. This is needed
+ * to find out whether we are using DPI output (thus no internal bridge).
+ * We detect this via two means:
+ * - If the bridge's of_node has a compatible, compare to known internal values.
+ * - If the bridge is a grand-child of DSS, and has "oldi-transmitters" parent.
+ */
+static bool tidss_is_bridge_internal(struct tidss_device *tidss,
+				     struct drm_bridge *bridge)
+{
+	struct device_node *parent, *grand_parent;
+	struct property *prop;
+	bool is_internal;
+
+	if (WARN_ON(!bridge->of_node))
+		return false;
+
+	prop = of_find_property(bridge->of_node, "compatible", NULL);
+	for (const char *cp = of_prop_next_string(prop, NULL); cp;
+	     cp = of_prop_next_string(prop, cp)) {
+		for (unsigned int i = 0;
+		     i < ARRAY_SIZE(tidss_internal_bridge_compatibles); ++i) {
+			if (strcmp(cp, tidss_internal_bridge_compatibles[i]) == 0)
+				return true;
+		}
+	}
+
+	parent = of_get_parent(bridge->of_node);
+	grand_parent = of_get_parent(parent);
+
+	is_internal = parent && grand_parent &&
+		      tidss->dev->of_node == grand_parent &&
+		      of_node_name_eq(parent, "oldi-transmitters");
+
+	of_node_put(grand_parent);
+	of_node_put(parent);
+
+	return is_internal;
+}
+
 static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 {
 	struct device *dev = tidss->dev;
@@ -133,6 +177,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 		u32 hw_videoport;
 		struct drm_bridge *bridge;
 		u32 enc_type;
+		bool dpi_output;
 	};
 
 	const struct dispc_features *feat = tidss->feat;
@@ -149,6 +194,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 		struct drm_panel *panel;
 		struct drm_bridge *bridge;
 		u32 enc_type = DRM_MODE_ENCODER_NONE;
+		bool dpi_output;
 		int ret;
 
 		ret = drm_of_find_panel_or_bridge(dev->of_node, i, 0,
@@ -160,6 +206,11 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 			return dev_err_probe(dev, ret, "port %d probe failed\n", i);
 		}
 
+		if (bridge)
+			dpi_output = !tidss_is_bridge_internal(tidss, bridge);
+		else
+			dpi_output = true;
+
 		if (panel) {
 			u32 conn_type;
 
@@ -199,6 +250,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 		pipes[num_pipes].hw_videoport = i;
 		pipes[num_pipes].bridge = bridge;
 		pipes[num_pipes].enc_type = enc_type;
+		pipes[num_pipes].dpi_output = dpi_output;
 		num_pipes++;
 	}
 
@@ -224,7 +276,8 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 		tidss->planes[tidss->num_planes++] = &tplane->plane;
 
 		tcrtc = tidss_crtc_create(tidss, pipes[i].hw_videoport,
-					  &tplane->plane);
+					  &tplane->plane,
+					  pipes[i].dpi_output);
 		if (IS_ERR(tcrtc)) {
 			dev_err(tidss->dev, "crtc create failed\n");
 			return PTR_ERR(tcrtc);

-- 
2.43.0

