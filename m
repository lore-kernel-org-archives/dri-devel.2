Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD60C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08F110F558;
	Thu,  3 Sep 2026 12:10:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="er0/TQg8";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC1010F558
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:27 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BB01E2814;
 Thu,  3 Sep 2026 14:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437334;
 bh=TgaWdc2v14syQKTjd0P+G00v2RLl1wdAxEUGkvtCiXc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=er0/TQg86FDr7WZxXHtPjHYpR9s/ObtBUZ3WT/1pwQF8Ne+XDC6fZrme4a+D0+wXF
 76pHKNSs6cF0XIEQYQIy5kAzZQmrgsV77CVqQJUj/J7S1iKKpAx2RGYbEWjMkcPUqz
 WKVX76JS6+UpRuEIoeyiORPpQzsb+ynI7OF3KY/A=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 15:09:57 +0300
Subject: [PATCH 07/10] drm/tidss: Add support for DPIENABLE bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-tidss-pre-beagley-v1-7-93928baa8b12@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4387;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=TgaWdc2v14syQKTjd0P+G00v2RLl1wdAxEUGkvtCiXc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOojsM7Rr8jvQpvQ/LJr6PFpUfPukaw+TSEg
 MmpHK0RXheJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljqAAKCRD6PaqMvJYe
 9SBRD/4nOd5hscQqQLxM+TwYjW7H5HYCEKiCG7SF+R1G2EfRdrpmijRb3DjHkzqy8WK4GMRqKX8
 247p0MvdRELWT6RiWWCRKKawnc3l2TdMbH4XMe5FhxVrrehEpuUmOD2SpDVgyvNXXDmfNkcoB+t
 LfkSk5FAza5e4xOmvqaWXnr5LRpCV5S3Nh6KqD5+zT4X9PnCxZht2GY2Xf+s/Wd9AALzEd4WTj7
 dceAHgFaaD1bPsB1EexJ+IY0/zQVRiBhhDoehZWyJsRBscL2i20C/uYhl4z4UC6G9SmUn75EVuD
 SBLZU03O0219jFHiYScvAcRaJ7kGGiVd5K2My3fDmJs+Uc4mvkfAoDwM8kv6xF/pTDR7AgWOZsf
 CGh+omVOO8Cia16A0yGjPn6ZHMZekFwZ/EUFxRFm0J96YKNMARTqYL6EH2X7WF9uUvRNMzsg/5R
 oTgCCZ5Hc0laR9hc4upc//GPgS+XjwRaErq3SelxdvAdPm4avkMtYM2/NE2nGNqeLNXlX3UkBQ3
 MmoN8Zm1L2L09UMuTOd4FZd1HCGoJq4VJeYnRHWjf8zvdyVXB945H9vtFfE9FPmiPhAr5eVx+De
 Ap2FtoRQHxPBKjDAkkxsy27q3fU0cvgYLFIqD4jWpCEOADqjImppd7nrQsDV5l3UwpoRkx/MU8R
 BvQXSLsZ8T4yNdA==
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

Many (or even all?) K3 SoCs have DSS VP_CONTROL.DPIENABLE bit described
in their documentation. This bit controls whether the DPI block is
enabled, and is set to 1 by default (i.e. DPI is enabled at HW reset).

However, in almost all SoCs the setting does not actually do anything,
and at the moment the bit is not managed by the driver.

The exception is AM62L, which does have DPIENABLE connected, and
disabling the DPI block when it is not in use provides power savings.

Let's add a new feature flag for this, 'has_vp_control_dpienable', and
implement the support.  Disable DPIENABLE for all videoports at resume
time, so that it is 0 by default. Specifically enable and disable it in
dispc_vp_prepare() and dispc_vp_unprepare() for DPI output.

Tested-by: Swamil Jain <s-jain1@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c      | 23 +++++++++++++++++++++--
 drivers/gpu/drm/tidss/tidss_dispc.h      |  2 ++
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c21ac3f51720..7efcdf7679ac 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -442,6 +442,8 @@ const struct dispc_features dispc_am62l_feats = {
 	},
 
 	.vid_order = {0},
+
+	.has_vp_control_dpienable = true,
 };
 
 static const u16 *dispc_common_regmap;
@@ -1201,6 +1203,11 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 				  mode->crtc_hdisplay - 1) |
 		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
 				  mode->crtc_vdisplay - 1));
+
+	if (dispc->feat->has_vp_control_dpienable &&
+	    dispc->vp_data[hw_videoport].dpi_output)
+		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
+			       DISPC_VP_CONTROL_DPIENABLE_MASK);
 }
 
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
@@ -1217,6 +1224,11 @@ void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
 
 void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
 {
+	if (dispc->feat->has_vp_control_dpienable &&
+	    dispc->vp_data[hw_videoport].dpi_output)
+		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
+			       DISPC_VP_CONTROL_DPIENABLE_MASK);
+
 	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI_AM65X) {
 		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
 
@@ -2436,10 +2448,17 @@ static void dispc_vp_init(struct dispc_device *dispc)
 
 	dev_dbg(dispc->dev, "%s()\n", __func__);
 
-	/* Enable the gamma Shadow bit-field for all VPs*/
-	for (i = 0; i < dispc->feat->num_vps; i++)
+	for (i = 0; i < dispc->feat->num_vps; i++) {
+		/* Enable the gamma Shadow bit-field for all VPs*/
 		VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONFIG, 1,
 			       DISPC_VP_CONFIG_GAMMAENABLE_MASK);
+
+		if (dispc->feat->has_vp_control_dpienable) {
+			/* Disable DPIENABLE for all VPs */
+			VP_REG_FLD_MOD(dispc, i, DISPC_VP_CONTROL, 0,
+				       DISPC_VP_CONTROL_DPIENABLE_MASK);
+		}
+	}
 }
 
 static void dispc_initial_config(struct dispc_device *dispc)
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
index 6f53d554259c..0fbfb86adfbf 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc.h
@@ -92,6 +92,8 @@ struct dispc_features {
 	u32 num_vids;
 	struct dispc_vid_info vid_info[TIDSS_MAX_PLANES];
 	u32 vid_order[TIDSS_MAX_PLANES];
+	/* The DSS has VP_CONTROL.DPIENABLE bit */
+	bool has_vp_control_dpienable;
 };
 
 extern const struct dispc_features dispc_k2g_feats;
diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
index 382027dddce8..13ff00696c2e 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
@@ -230,6 +230,7 @@ enum dispc_common_regs {
 
 #define DISPC_VP_CONTROL			0x4
 #define DISPC_VP_CONTROL_DATALINES_MASK			GENMASK(10, 8)
+#define DISPC_VP_CONTROL_DPIENABLE_MASK			GENMASK(6, 6)
 #define DISPC_VP_CONTROL_GOBIT_MASK			GENMASK(5, 5)
 #define DISPC_VP_CONTROL_ENABLE_MASK			GENMASK(0, 0)
 

-- 
2.43.0

