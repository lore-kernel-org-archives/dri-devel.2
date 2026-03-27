Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E45C10BA431
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 07:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC7B10E012;
	Fri, 27 Mar 2026 07:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lZHM1fGd";
	dkim-atps=neutral
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9994710E012
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 07:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=8ceAjtYEcr5YP6qK2DfT0mexWQaPQhTIrCc9rNsCQ/w=; b=lZHM1fGd5GFt0ixpjge8dsa4wA
 lM7fqZyQgwsK9Eh6RmLBouzUbQiBtp9RB/m+LArF1LT/Kbfib80bHkQMYx/7mUa/lezyzMh9nYbqW
 r9WInsXi+Nt5CWzCLjBlstnwCzuw+bYtykbT1QKcwARoVDcwZVVOf5lfLleTAec7fskHbmPcSBsMP
 gq2qEAzKOgRkuyzY7gMr1C/M7oaEYZty1+wTiwfN8fbAvAvxjvsiJdX62/Jr4s3GnFvlkqcdmI5d1
 yVIhMA4+T7y6ixwqx9Tnh6VwVzI3TWvDigOn+y2/FY2XLa8Aqt017Ww5A3fnXzMrrX1GtG12oia4R
 E7u2FIpg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w61CG-0004Wz-1W; Fri, 27 Mar 2026 08:01:32 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1w61CF-0001l6-2A; Fri, 27 Mar 2026 08:01:31 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] drm/bridge: fsl-ldb: Add dev_err_probe for some error
 paths
Date: Fri, 27 Mar 2026 08:01:21 +0100
Message-ID: <20260327070122.3551058-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27952/Thu Mar 26 07:24:52 2026)
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

There are code paths which can return -EPROBE_DEFER during probe. Add
missing error message for deferred probes.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 7b71cde173e0c..cd4b9f6e1ced4 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -315,11 +315,13 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 
 	fsl_ldb->clk = devm_clk_get(dev, "ldb");
 	if (IS_ERR(fsl_ldb->clk))
-		return PTR_ERR(fsl_ldb->clk);
+		return dev_err_probe(dev, PTR_ERR(fsl_ldb->clk),
+				     "Could not get ldb clock\n");
 
 	fsl_ldb->regmap = syscon_node_to_regmap(dev->of_node->parent);
 	if (IS_ERR(fsl_ldb->regmap))
-		return PTR_ERR(fsl_ldb->regmap);
+		return dev_err_probe(dev, PTR_ERR(fsl_ldb->regmap),
+				     "Could not get syscon regmap\n");
 
 	/* Locate the remote ports and the panel node */
 	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
@@ -342,7 +344,8 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 	panel = of_drm_find_panel(panel_node);
 	of_node_put(panel_node);
 	if (IS_ERR(panel))
-		return PTR_ERR(panel);
+		return dev_err_probe(dev, PTR_ERR(panel),
+				     "Could not get panel\n");
 
 	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"))
 		fsl_ldb->use_termination_resistor = true;
-- 
2.43.0

