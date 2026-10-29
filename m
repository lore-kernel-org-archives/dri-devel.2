Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB38606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=DByi6SS2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 667D21121BA;
	Thu, 29 Oct 2026 10:19:27 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323461121B1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:21 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 00528177A;
 Thu, 29 Oct 2026 11:17:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269027;
 bh=1ZJIk3MMYPkxcIUxoo1Dwfx/x1T1CMx2EcXxeO5F6nY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DByi6SS28GMiBG6Np9slP84tQ4ND8PUcCgNdkTGTPyX0eSAdaULSRszbeHvRgkUFL
 BSdc5jyafBqSjEFJjFVHugSm2ci9MGDSOiSRhU3NQCofpA7pQog7in7ekE+W8P4XPV
 n1M9a14yL44eb/aTeOBhpZ5k9p5UWn3rBVrEWuuc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:18:56 +0200
Subject: [PATCH v4 10/14] drm/tidss: oldi: Move the setup of one OLDI TX to
 its own function
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-10-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10887;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1ZJIk3MMYPkxcIUxoo1Dwfx/x1T1CMx2EcXxeO5F6nY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2Y9U97DKAwivHLGBgoebK0ng7aV10CuUWvM
 PyhXMlEwcqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdmAAKCRD6PaqMvJYe
 9XLkEACcu4vR2Ura39GZ96u44s4ZYq9JZ8PDFS1bM/YDJ0I2FRkjIvmA05mvxf7AOvVUDI3Y8X9
 7z7Wk3upqVrdBAsyS2HD6lpiLBaT+lGbHfmud2aKhGk1dLfY7NSMkXkTschQ6DmRCCrUHHUmKML
 NpHDoWHWYWeEEoCNRYwM5AOWKDPWTsfEkKs0bUEjVAsuf5iP5gpNAJE46Qpa+R7rBYwjOdJ1KQs
 giWCl3JV/E1zl+WPl74nRqm+ErrywD4/4/gt+IQu9QGGbBpLuMgnoAB1ScaiGAHbk001PeVXQRc
 QvcgjSNdWLpL3O/37GlnDIVwErjzHG0Hz3KnvCCPue+k0YaYaEAx+NxT+aN7OrYb72JHeJ8ka48
 Zv++AagLxs2Il1oO3gGYXTyRl9geC/mIEO4W1dsBRSRP5J5Z8jI6v7zeFqhmxh5BKMcp0PxsCAi
 msM8kZ1Pjh+7Rei+RBK7HkQ1OMPQDAfm0MYdgPO5mev+yukIomSjYZLiaCoLcGzAMRyJCKN/Aun
 NBd5dcv90zYZJw+2fUiUZ9b0Rko6g4OrsfsVpL/62cfPFZreOlBS+M5dD+Jp/9HHTv0pFIG4TI+
 V6lBvDMI1EDeLEQg6v0tCDBfaLlY8xaCZWjvw2/UCCPjmCeoHyU1jQ34xtBgw++sQesqBzb+sVd
 uiTPX72JwIUw2dQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tidss_oldi_init() sets up each OLDI TX inside its loop over the OLDI TX
nodes, which is not a few lines of code and indents quite deeply. Clean
up the code by separating the setup of a single OLDI TX into its own
function.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 264 +++++++++++++++++++------------------
 1 file changed, 138 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 7344d86e1f13..5552c1c51074 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -479,155 +479,167 @@ void tidss_oldi_deinit(struct tidss_device *tidss)
 	}
 }
 
-int tidss_oldi_init(struct tidss_device *tidss)
+static int tidss_oldi_init_one(struct tidss_device *tidss,
+			       struct device_node *oldi_tx)
 {
 	struct tidss_oldi *oldi;
-	struct device_node *child;
 	struct drm_bridge *bridge;
 	u32 parent_vp, oldi_instance;
 	int companion_instance = -1;
 	enum tidss_oldi_link_type link_type = OLDI_MODE_UNSUPPORTED;
-	struct device_node *oldi_parent;
-	int ret = 0;
-
-	tidss->num_oldis = 0;
-
-	oldi_parent = of_get_child_by_name(tidss->dev->of_node, "oldi-transmitters");
-	if (!oldi_parent)
-		/* Return gracefully */
-		return 0;
+	int ret;
 
-	for_each_available_child_of_node(oldi_parent, child) {
-		ret = get_parent_dss_vp(child, &parent_vp);
-		if (ret) {
-			if (ret == -ENODEV) {
-				/*
-				 * ENODEV means that this particular OLDI node
-				 * is not connected with the DSS, which is not
-				 * a harmful case. There could be another OLDI
-				 * which may still be connected.
-				 * Continue to search for that.
-				 */
-				continue;
-			}
-			goto err_put_node;
+	ret = get_parent_dss_vp(oldi_tx, &parent_vp);
+	if (ret) {
+		if (ret == -ENODEV) {
+			/*
+			 * ENODEV means that this particular OLDI node
+			 * is not connected with the DSS, which is not
+			 * a harmful case. There could be another OLDI
+			 * which may still be connected.
+			 * Continue to search for that.
+			 */
+			return 0;
 		}
+		return ret;
+	}
 
-		ret = of_property_read_u32(child, "reg", &oldi_instance);
-		if (ret)
-			goto err_put_node;
+	ret = of_property_read_u32(oldi_tx, "reg", &oldi_instance);
+	if (ret)
+		return ret;
 
+	/*
+	 * Now that it's confirmed that OLDI is connected with DSS,
+	 * let's continue getting the OLDI sinks ahead and other OLDI
+	 * properties.
+	 */
+	bridge = devm_drm_of_get_bridge(tidss->dev, oldi_tx,
+					OLDI_OUTPUT_PORT, 0);
+	if (IS_ERR(bridge)) {
 		/*
-		 * Now that it's confirmed that OLDI is connected with DSS,
-		 * let's continue getting the OLDI sinks ahead and other OLDI
-		 * properties.
+		 * Either there was no OLDI sink in the devicetree, or
+		 * the OLDI sink has not been added yet. In any case,
+		 * return.
+		 * We don't want to have an OLDI node connected to DSS
+		 * but not to any sink.
 		 */
-		bridge = devm_drm_of_get_bridge(tidss->dev, child,
-						OLDI_OUTPUT_PORT, 0);
-		if (IS_ERR(bridge)) {
-			/*
-			 * Either there was no OLDI sink in the devicetree, or
-			 * the OLDI sink has not been added yet. In any case,
-			 * return.
-			 * We don't want to have an OLDI node connected to DSS
-			 * but not to any sink.
-			 */
-			ret = dev_err_probe(tidss->dev, PTR_ERR(bridge),
-					    "no panel/bridge for OLDI%u.\n",
+		ret = dev_err_probe(tidss->dev, PTR_ERR(bridge),
+				    "no panel/bridge for OLDI%u.\n",
+				    oldi_instance);
+		return ret;
+	}
+
+	link_type = get_oldi_mode(oldi_tx, &companion_instance);
+	if (link_type == OLDI_MODE_UNSUPPORTED) {
+		ret = dev_err_probe(tidss->dev, -EINVAL,
+				    "OLDI%u: Unsupported OLDI connection.\n",
+				    oldi_instance);
+		return ret;
+	} else if ((link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) ||
+		   (link_type == OLDI_MODE_CLONE_SINGLE_LINK)) {
+		/*
+		 * The OLDI driver cannot support OLDI clone mode
+		 * properly at present.
+		 * The clone mode requires 2 working encoder-bridge
+		 * pipelines, generating from the same crtc. The DRM
+		 * framework does not support this at present. If
+		 * there were to be, say, 2 OLDI sink bridges each
+		 * connected to an OLDI TXes, they couldn't both be
+		 * supported simultaneously.
+		 * This driver still has some code pertaining to OLDI
+		 * clone mode configuration in DSS hardware for future,
+		 * when there is a better infrastructure in the DRM
+		 * framework to support 2 encoder-bridge pipelines
+		 * simultaneously.
+		 * Till that time, this driver shall error out if it
+		 * detects a clone mode configuration.
+		 */
+		ret = dev_err_probe(tidss->dev, -EOPNOTSUPP,
+				    "The OLDI driver does not support Clone Mode at present.\n");
+		return ret;
+	} else if (link_type == OLDI_MODE_SECONDARY_DUAL_LINK) {
+		/*
+		 * This is the secondary OLDI node, which serves as a
+		 * companion to the primary OLDI, when it is configured
+		 * for the dual-link mode. Since the primary OLDI will
+		 * be a part of bridge chain, no need to put this one
+		 * too. Continue onto the next OLDI node.
+		 */
+		return 0;
+	}
+
+	oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
+				     &tidss_oldi_bridge_funcs);
+	if (IS_ERR(oldi)) {
+		ret = PTR_ERR(oldi);
+		return ret;
+	}
+
+	oldi->parent_vp = parent_vp;
+	oldi->oldi_instance = oldi_instance;
+	oldi->companion_instance = companion_instance;
+	oldi->link_type = link_type;
+	oldi->dev = tidss->dev;
+	oldi->next_bridge = bridge;
+
+	/*
+	 * Only the primary OLDI needs to reference the io-ctrl system
+	 * registers, and the serial clock.
+	 * We don't require a check for secondary OLDI in dual-link mode
+	 * because the driver will not create a drm_bridge instance.
+	 * But the driver will need to create a drm_bridge instance,
+	 * for secondary OLDI in clone mode (once it is supported).
+	 */
+	if (link_type != OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) {
+		oldi->io_ctrl = syscon_regmap_lookup_by_phandle(oldi_tx,
+								"ti,oldi-io-ctrl");
+		if (IS_ERR(oldi->io_ctrl)) {
+			ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->io_ctrl),
+					    "OLDI%u: syscon_regmap_lookup_by_phandle failed.\n",
 					    oldi_instance);
-			goto err_put_node;
+			return ret;
 		}
 
-		link_type = get_oldi_mode(child, &companion_instance);
-		if (link_type == OLDI_MODE_UNSUPPORTED) {
-			ret = dev_err_probe(tidss->dev, -EINVAL,
-					    "OLDI%u: Unsupported OLDI connection.\n",
+		oldi->serial = devm_get_clk_from_child(tidss->dev, oldi_tx,
+						       "serial");
+		if (IS_ERR(oldi->serial)) {
+			ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->serial),
+					    "OLDI%u: Failed to get serial clock.\n",
 					    oldi_instance);
-			goto err_put_node;
-		} else if ((link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) ||
-			   (link_type == OLDI_MODE_CLONE_SINGLE_LINK)) {
-			/*
-			 * The OLDI driver cannot support OLDI clone mode
-			 * properly at present.
-			 * The clone mode requires 2 working encoder-bridge
-			 * pipelines, generating from the same crtc. The DRM
-			 * framework does not support this at present. If
-			 * there were to be, say, 2 OLDI sink bridges each
-			 * connected to an OLDI TXes, they couldn't both be
-			 * supported simultaneously.
-			 * This driver still has some code pertaining to OLDI
-			 * clone mode configuration in DSS hardware for future,
-			 * when there is a better infrastructure in the DRM
-			 * framework to support 2 encoder-bridge pipelines
-			 * simultaneously.
-			 * Till that time, this driver shall error out if it
-			 * detects a clone mode configuration.
-			 */
-			ret = dev_err_probe(tidss->dev, -EOPNOTSUPP,
-					    "The OLDI driver does not support Clone Mode at present.\n");
-			goto err_put_node;
-		} else if (link_type == OLDI_MODE_SECONDARY_DUAL_LINK) {
-			/*
-			 * This is the secondary OLDI node, which serves as a
-			 * companion to the primary OLDI, when it is configured
-			 * for the dual-link mode. Since the primary OLDI will
-			 * be a part of bridge chain, no need to put this one
-			 * too. Continue onto the next OLDI node.
-			 */
-			continue;
+			return ret;
 		}
+	}
 
-		oldi = devm_drm_bridge_alloc(tidss->dev, struct tidss_oldi, bridge,
-					     &tidss_oldi_bridge_funcs);
-		if (IS_ERR(oldi)) {
-			ret = PTR_ERR(oldi);
-			goto err_put_node;
-		}
+	/* Register the bridge. */
+	oldi->bridge.of_node = oldi_tx;
+	oldi->bridge.driver_private = oldi;
 
-		oldi->parent_vp = parent_vp;
-		oldi->oldi_instance = oldi_instance;
-		oldi->companion_instance = companion_instance;
-		oldi->link_type = link_type;
-		oldi->dev = tidss->dev;
-		oldi->next_bridge = bridge;
+	tidss->oldis[tidss->num_oldis++] = oldi;
+	tidss->is_ext_vp_clk[oldi->parent_vp] = true;
+	oldi->tidss = tidss;
 
-		/*
-		 * Only the primary OLDI needs to reference the io-ctrl system
-		 * registers, and the serial clock.
-		 * We don't require a check for secondary OLDI in dual-link mode
-		 * because the driver will not create a drm_bridge instance.
-		 * But the driver will need to create a drm_bridge instance,
-		 * for secondary OLDI in clone mode (once it is supported).
-		 */
-		if (link_type != OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) {
-			oldi->io_ctrl = syscon_regmap_lookup_by_phandle(child,
-									"ti,oldi-io-ctrl");
-			if (IS_ERR(oldi->io_ctrl)) {
-				ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->io_ctrl),
-						    "OLDI%u: syscon_regmap_lookup_by_phandle failed.\n",
-						    oldi_instance);
-				goto err_put_node;
-			}
-
-			oldi->serial = devm_get_clk_from_child(tidss->dev, child,
-							       "serial");
-			if (IS_ERR(oldi->serial)) {
-				ret = dev_err_probe(oldi->dev, PTR_ERR(oldi->serial),
-						    "OLDI%u: Failed to get serial clock.\n",
-						    oldi_instance);
-				goto err_put_node;
-			}
-		}
+	drm_bridge_add(&oldi->bridge);
+
+	return 0;
+}
+
+int tidss_oldi_init(struct tidss_device *tidss)
+{
+	struct device_node *child;
+	struct device_node *oldi_parent;
+	int ret = 0;
 
-		/* Register the bridge. */
-		oldi->bridge.of_node = child;
-		oldi->bridge.driver_private = oldi;
+	tidss->num_oldis = 0;
 
-		tidss->oldis[tidss->num_oldis++] = oldi;
-		tidss->is_ext_vp_clk[oldi->parent_vp] = true;
-		oldi->tidss = tidss;
+	oldi_parent = of_get_child_by_name(tidss->dev->of_node, "oldi-transmitters");
+	if (!oldi_parent)
+		/* Return gracefully */
+		return 0;
 
-		drm_bridge_add(&oldi->bridge);
+	for_each_available_child_of_node(oldi_parent, child) {
+		ret = tidss_oldi_init_one(tidss, child);
+		if (ret)
+			goto err_put_node;
 	}
 
 	of_node_put(child);

-- 
2.43.0

