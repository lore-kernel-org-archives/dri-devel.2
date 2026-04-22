Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57090F9EDF3
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 14:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74FF10EA45;
	Wed, 22 Apr 2026 14:52:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by gabe.freedesktop.org (Postfix) with ESMTP id E6E7610EA45
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 14:52:25 +0000 (UTC)
X-CSE-ConnectionGUID: ptICCgFaQaKV9hrs6FemJQ==
X-CSE-MsgGUID: Tzu1+mgJSmOWSetomb9haQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 22 Apr 2026 23:52:24 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 712E241ABE38;
 Wed, 22 Apr 2026 23:52:21 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Pavel Machek <pavel@nabladev.com>,
 Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH v2] drm: renesas: rz-du: mipi_dsi: Fix return path on error
Date: Wed, 22 Apr 2026 10:51:46 -0400
Message-ID: <20260422145146.1638998-1-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
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

In case of error, we should unwind correctly.
Switching to using dmam_ instead of dma_ and moving the code earlier
fixes the issue.

Fixes: 6f392f371650 ("drm: renesas: rz-du: Implement MIPI DSI host transfers")
Suggested-by: Pavel Machek <pavel@nabladev.com>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Acked-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

---
V1->V2:
 - Need to take into account mipi_dsi_host_register was already called (Geert)
 - Switch to using dmam_alloc_coherent to automate unwinding (Chris)
 - Added Acked-by (Hugo)
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 29f2b7d24fe5..b908e702b607 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1442,6 +1442,11 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 		return dev_err_probe(dsi->dev, PTR_ERR(dsi->prstc),
 				     "failed to get prst\n");

+	dsi->dcs_buf_virt = dmam_alloc_coherent(dsi->dev, RZG2L_DCS_BUF_SIZE,
+						&dsi->dcs_buf_phys, GFP_KERNEL);
+	if (!dsi->dcs_buf_virt)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, dsi);

 	pm_runtime_enable(dsi->dev);
@@ -1474,11 +1479,6 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_disable;

-	dsi->dcs_buf_virt = dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE,
-					       &dsi->dcs_buf_phys, GFP_KERNEL);
-	if (!dsi->dcs_buf_virt)
-		return -ENOMEM;
-
 	return 0;

 err_phy:
@@ -1493,8 +1493,6 @@ static void rzg2l_mipi_dsi_remove(struct platform_device *pdev)
 {
 	struct rzg2l_mipi_dsi *dsi = platform_get_drvdata(pdev);

-	dma_free_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE, dsi->dcs_buf_virt,
-			  dsi->dcs_buf_phys);
 	mipi_dsi_host_unregister(&dsi->host);
 	pm_runtime_disable(&pdev->dev);
 }
--
2.52.0

