Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2DCF436A8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB4C610EA18;
	Fri, 17 Apr 2026 14:08:14 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Fri, 17 Apr 2026 14:08:14 UTC
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2720910EA18
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:08:14 +0000 (UTC)
X-CSE-ConnectionGUID: 80k0bXSqSW+9rIoBkWeGQw==
X-CSE-MsgGUID: G2QPDk8mRdafwUHsb5VC8Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2026 23:03:11 +0900
Received: from lenovo-p330 (unknown [132.158.152.96])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 660D44002943;
 Fri, 17 Apr 2026 23:03:08 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Pavel Machek <pavel@nabladev.com>,
 Hugo Villeneuve <hugo@hugovil.com>
Cc: linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH] drm: renesas: rz-du: mipi_dsi: Fix return path on error
Date: Fri, 17 Apr 2026 10:02:31 -0400
Message-ID: <20260417140231.3972749-1-chris.brandt@renesas.com>
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

Fixes: 6f392f371650 ("drm: renesas: rz-du: Implement MIPI DSI host transfers")
Suggested-by: Pavel Machek <pavel@nabladev.com>
Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 29f2b7d24fe5..92ea26ce723f 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1476,8 +1476,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 
 	dsi->dcs_buf_virt = dma_alloc_coherent(dsi->host.dev, RZG2L_DCS_BUF_SIZE,
 					       &dsi->dcs_buf_phys, GFP_KERNEL);
-	if (!dsi->dcs_buf_virt)
-		return -ENOMEM;
+	if (!dsi->dcs_buf_virt) {
+		ret = -ENOMEM;
+		goto err_pm_disable;
+	}
 
 	return 0;
 
-- 
2.52.0

