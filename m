Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71457CD6E4C
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 08:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CFA10FB14;
	Fri, 29 May 2026 08:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="k2c0tiLM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC7B10FB09
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:47:26 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 56BC57B41;
 Fri, 29 May 2026 10:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780044425;
 bh=u7ub0LTq/LG3vy2G9rU1xYBZYiavDBGmr5fWkQDAfvw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k2c0tiLMtbj9x3ruTO1G5u+mQPy872fvMwsRLRPoWQbSOTziBYBmvosni7z6iaHxL
 VddCKR2s5RGHSnuj89m0LkmRplEkuUCS6zVfeNnroWT5klMtPdI334zBxmtXxhX1vX
 3sJ0M9LdTgZJaSLOw4OKSmCWdeCR9Zw91HhWG5qo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 29 May 2026 11:45:39 +0300
Subject: [PATCH v3 09/15] drm/tidss: Add external data and sync signal edge
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-beagley-ai-display-v3-9-7fefdc5d1adf@ideasonboard.com>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
In-Reply-To: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3376;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=u7ub0LTq/LG3vy2G9rU1xYBZYiavDBGmr5fWkQDAfvw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqGVKOpGTOrBpu7DnAvMn2vUXlqc+3UkJIlVwgh
 TJrA2Odpg6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCahlSjgAKCRD6PaqMvJYe
 9WiPEACqKzBs/FHRnaiJRIHKrPMjTlqh9eERaooXqiPUii4kISHReqEVLizSgI6QLgAsjAWBXLh
 esVVvhFkp2beNEKidE84COGKtvOR6UtuloOQlwjNBXIVfs2OavSORoKohn4YDTfqmw+6PB+q98z
 51TVpqUevuiUdSBM6V/A59/xbIPMYcP2AZbOr5mDooSVQR4zCrU54v8Ef2ZYQFF9DwiZhJ0hR6N
 X0NPxaoaBQyrCHHHyxC79+vCo5vAMGioyc90Qd7Cpdt7ZVru8V8aTyqobRNmhK1XXg/HPyG599F
 oz1Kfl+S853lKrt1f2BPj03/Edt/Jd7yFWJdF3i4RSgwp/KhZhVY7Y0cax0SX2UfOhOJJFJg2G4
 ySKNcsj6D2rvxNKGKntW0/8eukDgFlBxqdWgc4Kt30qMCzOT6BZHwv8myZAO2mClsjusQBhsmgS
 BEBt/l2Y1vi67CIx1/4vYjSA80/rsq+46z1gJ4LQi1EPg68qzWqkIMKaRnQDl5nc9Tb0ewrK5+k
 2gZO45XsF+d7+DpFayY84D4t8wrSF6vkp2Q5mCGtc7vnA4+KzLBpn5kK4hcdzkKBHfCoov8d3dU
 sDe+xu4VT79NiNCUKwle6aMb4YM5YX4a6YLENAUtdapaT+r4IHWEhwGKoUxmel4OvyNj8yju2Wp
 BIPur3rlO/Ptodg==
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

The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
which produces the in-SoC parallel video signal, and a DPI block which
adjusts the signal to the external MIPI DPI output.

The DSS IP has registers to configure whether the data and sync signals
are driven on rising or falling clock edge, and on some SoCs these are
automatically conveyed to the DPI block which needs that configuration
to properly output the MIPI DPI signal.

However, on some SoCs the DPI block configuration has to be done
manually, using an extra register outside the DSS, DPI0_CLK_CTRL from
MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior.

Add the support to get the regmap to the register via syscon, and
configure the bits before enabling the video output.

Original patch from Louis Chauvet <louis.chauvet@bootlin.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c      | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c21ac3f51720..08342a9a5e8c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -467,6 +467,8 @@ struct dispc_device {
 	const struct dispc_features *feat;
 
 	struct clk *fclk;
+	struct regmap *syscon_dpi_io_ctrl;
+	unsigned int syscon_dpi_io_ctrl_offset;
 
 	bool is_enabled;
 
@@ -1201,6 +1203,13 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 				  mode->crtc_hdisplay - 1) |
 		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
 				  mode->crtc_vdisplay - 1));
+
+	if (dispc->vp_data[hw_videoport].dpi_output && dispc->syscon_dpi_io_ctrl) {
+		regmap_write(dispc->syscon_dpi_io_ctrl,
+			     dispc->syscon_dpi_io_ctrl_offset + 0x0,
+			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
+			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
+	}
 }
 
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
@@ -2989,6 +2998,22 @@ int dispc_init(struct tidss_device *tidss)
 
 	dispc_init_errata(dispc);
 
+	dispc->syscon_dpi_io_ctrl =
+		syscon_regmap_lookup_by_phandle_args(tidss->dev->of_node,
+						     "ti,dpi-io-ctrl", 1,
+						     &dispc->syscon_dpi_io_ctrl_offset);
+
+	if (IS_ERR(dispc->syscon_dpi_io_ctrl)) {
+		r = PTR_ERR(dispc->syscon_dpi_io_ctrl);
+
+		if (r == -ENOENT) {
+			dispc->syscon_dpi_io_ctrl = NULL;
+		} else {
+			return dev_err_probe(dispc->dev, r,
+					     "failed to get 'ti,dpi-io-ctrl'\n");
+		}
+	}
+
 	dispc->fourccs = devm_kcalloc(dev, ARRAY_SIZE(dispc_color_formats),
 				      sizeof(*dispc->fourccs), GFP_KERNEL);
 	if (!dispc->fourccs)
diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
index 382027dddce8..4cdde24d8372 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
@@ -333,4 +333,8 @@ enum oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
 
 #define AM65X_OLDI_PWRDN_TX		BIT(8)
 
+/* Bits in the MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL register */
+#define DPI0_CLK_CTRL_DATA_CLK_INVDIS BIT(8)
+#define DPI0_CLK_CTRL_SYNC_CLK_INVDIS BIT(9)
+
 #endif /* __TIDSS_DISPC_REGS_H */

-- 
2.43.0

