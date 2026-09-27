Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263A4C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6116A10E482;
	Sun, 27 Sep 2026 10:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UtjjsSSr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7E1B10E47C;
 Sun, 27 Sep 2026 10:57:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 379C960D7F;
 Sun, 27 Sep 2026 10:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C1F1F000FF;
 Sun, 27 Sep 2026 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790506622;
 bh=7hec+lMEDGI9y3jbHt6Y6kArMIsxA69vRhR2rOPeIFE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UtjjsSSrWF+TFt54/0px6YzSyUYzlv91ip/Lcs/KQAoOamZa5b/L9bVLQr1c49pr6
 rZs4OMKT/daTgTbfTNw1O9OOYTok6mhb9QMqKwRJkiyCwrGaeY2p9A7BDpOqn8avNF
 3TP1auOS0UIXwjNVcGySRRnQGMJMgawY5M/zIAOgCmnhwJ1Bt7k37sKB9d+LAkdn0Z
 NDATEzOnvjtacpBm4OrfYt3I3wPneZcPuTpKUZT0UImruFzyG4vY1Me9Bv0gDjBBmV
 kDq88JrH5NETzKs4MczRZfcEJemq9gWx+kNPnBOGmMjtD5pKV1+f6629p/jwNuZ1Y0
 bEEYriCG4ctiQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/radeon: add a connector table for the Sun XVR-300
Date: Sun, 27 Sep 2026 12:55:55 +0200
Message-ID: <20260927105555.8771-3-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927105555.8771-1-kaloz@kernel.org>
References: <20260927105555.8771-1-kaloz@kernel.org>
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

The Sun XVR-300 is a FireMV 2200 PCIe (RV370) board with an
FCode-only Open Firmware ROM and no COMBIOS to parse, so the
generic connector table leaves both DVI-I outputs undetected. Both
XVR-300 SKUs report device ID 5b64 with an ATI subsystem ID rather
than Sun's, so match the OF node name prefix instead. The table
comes from the board's FCode.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/gpu/drm/radeon/radeon_combios.c | 51 +++++++++++++++++++++++++
 drivers/gpu/drm/radeon/radeon_mode.h    |  3 +-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index b3e7a747f11e..096f953c67be 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -25,6 +25,7 @@
  *          Alex Deucher
  */
 
+#include <linux/of.h>
 #include <linux/pci.h>
 
 #include <drm/drm_device.h>
@@ -1512,6 +1513,14 @@ bool radeon_get_legacy_connector_info_from_table(struct drm_device *dev)
 			rdev->mode_info.connector_table = CT_RN50_POWER;
 		else
 #endif
+		if (of_node_name_prefix(rdev->pdev->dev.of_node, "SUNW,XVR-300"))
+			/* FireMV 2200 PCIe with FCode-only ROM, no COMBIOS
+			 * to parse; both XVR-300 SKUs share device ID 5b64
+			 * with an ATI subsystem ID, so match the OF node
+			 * name instead.
+			 */
+			rdev->mode_info.connector_table = CT_SUN_XVR300;
+		else
 			rdev->mode_info.connector_table = CT_GENERIC;
 	}
 
@@ -2187,6 +2196,48 @@ bool radeon_get_legacy_connector_info_from_table(struct drm_device *dev)
 					    CONNECTOR_OBJECT_ID_SVIDEO,
 					    &hpd);
 		break;
+	case CT_SUN_XVR300:
+		DRM_INFO("Connector Table: %d (sun xvr-300)\n",
+			 rdev->mode_info.connector_table);
+		/* DVI-I - internal tmds, tv dac */
+		ddc_i2c = combios_setup_i2c_bus(rdev, DDC_DVI, 0, 0);
+		hpd.hpd = RADEON_HPD_1;
+		radeon_add_legacy_encoder(dev,
+					  radeon_get_encoder_enum(dev,
+								ATOM_DEVICE_DFP1_SUPPORT,
+								0),
+					  ATOM_DEVICE_DFP1_SUPPORT);
+		radeon_add_legacy_encoder(dev,
+					  radeon_get_encoder_enum(dev,
+								ATOM_DEVICE_CRT2_SUPPORT,
+								2),
+					  ATOM_DEVICE_CRT2_SUPPORT);
+		radeon_add_legacy_connector(dev, 0,
+					    ATOM_DEVICE_DFP1_SUPPORT |
+					    ATOM_DEVICE_CRT2_SUPPORT,
+					    DRM_MODE_CONNECTOR_DVII, &ddc_i2c,
+					    CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_I,
+					    &hpd);
+		/* DVI-I - sil164 dvo, primary dac */
+		ddc_i2c = combios_setup_i2c_bus(rdev, DDC_VGA, 0, 0);
+		hpd.hpd = RADEON_HPD_2;
+		radeon_add_legacy_encoder(dev,
+					  radeon_get_encoder_enum(dev,
+								ATOM_DEVICE_DFP2_SUPPORT,
+								0),
+					  ATOM_DEVICE_DFP2_SUPPORT);
+		radeon_add_legacy_encoder(dev,
+					  radeon_get_encoder_enum(dev,
+								ATOM_DEVICE_CRT1_SUPPORT,
+								1),
+					  ATOM_DEVICE_CRT1_SUPPORT);
+		radeon_add_legacy_connector(dev, 1,
+					    ATOM_DEVICE_DFP2_SUPPORT |
+					    ATOM_DEVICE_CRT1_SUPPORT,
+					    DRM_MODE_CONNECTOR_DVII, &ddc_i2c,
+					    CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_I,
+					    &hpd);
+		break;
 	default:
 		DRM_INFO("Connector table: %d (invalid)\n",
 			 rdev->mode_info.connector_table);
diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
index 031a3bf6fe0a..6a16d821915d 100644
--- a/drivers/gpu/drm/radeon/radeon_mode.h
+++ b/drivers/gpu/drm/radeon/radeon_mode.h
@@ -226,7 +226,8 @@ enum radeon_connector_table {
 	CT_MAC_X800,
 	CT_MAC_G5_9600,
 	CT_SAM440EP,
-	CT_MAC_G4_SILVER
+	CT_MAC_G4_SILVER,
+	CT_SUN_XVR300
 };
 
 enum radeon_dvo_chip {
-- 
2.47.3

