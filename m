Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F22AF483CC
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B048E10E495;
	Mon, 23 Mar 2026 16:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OcNwaZds";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2753510E457
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:45:33 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7D1F22673;
 Mon, 23 Mar 2026 17:44:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774284255;
 bh=KV8jqEFhaHfQRq9P+VG4/SCumEfR8TaE/ef//TFBllg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OcNwaZds3jR8UpKos26retc7eZRMMmkv9KxLY49ZZ+aZcZu/UUP58Ca+5jRDf76iN
 vI3OaSnQ1Jr8a3soegHjahRUrKBPDcSRCxgSBBjmTQqZezzBTui927JxCTiNNnf1ZR
 zD47DjegH3K11RdPABLgMkXPFSqNC9KnrpnP+x7I=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 3/4] drm: rcar-du: Use __free() to simplify device_node
 handling
Date: Mon, 23 Mar 2026 18:45:25 +0200
Message-ID: <20260323164526.2292491-4-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323164526.2292491-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260323164526.2292491-1-laurent.pinchart+renesas@ideasonboard.com>
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

Replace manual of_node_put() calls with __free(). This simplifies error
handling code and makes it less bug-prone.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c | 25 ++++++-------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
index f38e45d38ad2..9a53b5a86c82 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c
@@ -19,6 +19,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/of.h>
@@ -573,7 +574,7 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 				     enum rcar_du_output output,
 				     struct of_endpoint *ep)
 {
-	struct device_node *entity;
+	struct device_node *entity __free(device_node) = NULL;
 	int ret;
 
 	/* Locate the connected entity and initialize the encoder. */
@@ -588,7 +589,6 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 		dev_dbg(rcdu->dev,
 			"connected entity %pOF is disabled, skipping\n",
 			entity);
-		of_node_put(entity);
 		return -ENODEV;
 	}
 
@@ -598,15 +598,13 @@ static int rcar_du_encoders_init_one(struct rcar_du_device *rcdu,
 			 "failed to initialize encoder %pOF on output %s (%d), skipping\n",
 			 entity, rcar_du_output_name(output), ret);
 
-	of_node_put(entity);
-
 	return ret;
 }
 
 static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 {
+	struct device_node *ep_node __free(device_node) = NULL;
 	struct device_node *np = rcdu->dev->of_node;
-	struct device_node *ep_node;
 	unsigned int num_encoders = 0;
 
 	/*
@@ -620,10 +618,8 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 		int ret;
 
 		ret = of_graph_parse_endpoint(ep_node, &ep);
-		if (ret < 0) {
-			of_node_put(ep_node);
+		if (ret < 0)
 			return ret;
-		}
 
 		/* Find the output route corresponding to the port number. */
 		for (i = 0; i < RCAR_DU_OUTPUT_MAX; ++i) {
@@ -644,10 +640,8 @@ static int rcar_du_encoders_init(struct rcar_du_device *rcdu)
 		/* Process the output pipeline. */
 		ret = rcar_du_encoders_init_one(rcdu, output, &ep);
 		if (ret < 0) {
-			if (ret == -EPROBE_DEFER) {
-				of_node_put(ep_node);
+			if (ret == -EPROBE_DEFER)
 				return ret;
-			}
 
 			continue;
 		}
@@ -775,9 +769,9 @@ static int rcar_du_cmm_init(struct rcar_du_device *rcdu)
 	}
 
 	for (i = 0; i < cells; ++i) {
+		struct device_node *cmm __free(device_node) = NULL;
 		struct platform_device *pdev;
 		struct device_link *link;
-		struct device_node *cmm;
 		int ret;
 
 		cmm = of_parse_phandle(np, "renesas,cmms", i);
@@ -787,21 +781,16 @@ static int rcar_du_cmm_init(struct rcar_du_device *rcdu)
 			return -EINVAL;
 		}
 
-		if (!of_device_is_available(cmm)) {
+		if (!of_device_is_available(cmm))
 			/* It's fine to have a phandle to a non-enabled CMM. */
-			of_node_put(cmm);
 			continue;
-		}
 
 		pdev = of_find_device_by_node(cmm);
 		if (!pdev) {
 			dev_err(rcdu->dev, "No device found for CMM%u\n", i);
-			of_node_put(cmm);
 			return -EINVAL;
 		}
 
-		of_node_put(cmm);
-
 		/*
 		 * -ENODEV is used to report that the CMM config option is
 		 * disabled: return 0 and let the DU continue probing.
-- 
Regards,

Laurent Pinchart

