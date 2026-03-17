Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491BAFF6E9C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 23:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB44110E691;
	Tue, 17 Mar 2026 23:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ROU3KBKY";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED12110E68B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 23:19:34 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 66D41B3;
 Wed, 18 Mar 2026 00:18:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773789501;
 bh=k3ZTJSuAUE4ZlJaeYMMQ/jM8ULAQ3DF1JYH+rCgaF7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ROU3KBKYIqlosSfKiAwpMjWN3pD1cZo/vam7YhM/fu64WfZqaOZLsu6v2N1SEMTLS
 uo9Cy67mWiPLxyhM2ZwyS2quTU4ujcKD6ztZ+tKAFb/c06BRHS1fzISHouiPu1l/jo
 0JPGR2zgO4S/GtukkQi0I4U21/P3JX1cl/fxdG7U=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH 1/4] drm: rcar-du: Ensure correct suspend/resume ordering with
 VSP
Date: Wed, 18 Mar 2026 01:19:27 +0200
Message-ID: <20260317231930.595719-2-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260317231930.595719-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260317231930.595719-1-laurent.pinchart+renesas@ideasonboard.com>
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

The VSP serves as an interface to memory and a compositor to the DU. It
therefore needs to be suspended after and resumed before the DU, to be
properly stopped and restarted in a controlled fashion driven by the DU
driver. This currently works by chance. Avoid relying on luck by
enforcing the correct suspend/resume ordering with device links.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c | 16 ++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
index 94c22d2db197..a4a49dcd8233 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.c
@@ -20,6 +20,7 @@
 #include <drm/drm_vblank.h>
 
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -458,6 +459,9 @@ static void rcar_du_vsp_cleanup(struct drm_device *dev, void *res)
 
 	kfree(vsp->planes);
 
+	if (vsp->link)
+		device_link_del(vsp->link);
+
 	put_device(vsp->vsp);
 }
 
@@ -482,6 +486,18 @@ int rcar_du_vsp_init(struct rcar_du_vsp *vsp, struct device_node *np,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Enforce suspend/resume ordering between the DU (consumer) and the
+	 * VSP (supplier). The DU will be suspended before and resume after the
+	 * VSP.
+	 */
+	vsp->link = device_link_add(rcdu->dev, vsp->vsp, DL_FLAG_STATELESS);
+	if (!vsp->link) {
+		dev_err(rcdu->dev, "Failed to create device link to VSP %s\n",
+			dev_name(vsp->vsp));
+		return -EINVAL;
+	}
+
 	ret = vsp1_du_init(vsp->vsp);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
index 67630f0b6599..a6731249db34 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_vsp.h
@@ -12,6 +12,7 @@
 
 #include <drm/drm_plane.h>
 
+struct device_link;
 struct drm_framebuffer;
 struct rcar_du_format_info;
 struct rcar_du_vsp;
@@ -26,6 +27,7 @@ struct rcar_du_vsp_plane {
 struct rcar_du_vsp {
 	unsigned int index;
 	struct device *vsp;
+	struct device_link *link;
 	struct rcar_du_device *dev;
 	struct rcar_du_vsp_plane *planes;
 	unsigned int num_planes;
-- 
Regards,

Laurent Pinchart

