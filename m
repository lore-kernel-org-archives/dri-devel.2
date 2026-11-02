Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8D6083629
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=pPlEyyNa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57F610E66F;
	Mon,  2 Nov 2026 16:18:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD1410E66F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
 bh=HlR6lStFz1vW1Jl2VraOlbQ01Ty2rTIMbWz1ck0zpcU=; b=pPlEyyNaQizzCiIyLNbiKT+vEh
 tQuW3gmYzi1pO8xjt3Fo4mBRJv+SIcyIda/prK343HRbZ/yPwQAcH803ISEEbwtcKHzgK4bgww8w9
 c/9rgAVeambhosmUtWMuJ14ATr3QLxfI+a0RdT/v9q+RcWjTWoKFNqSM5to4pU38xOX0spqmi5JK2
 wuvGN1AHspIJE8hxeU1kfiDq/qxLLy4KRKWNyrO7I15aVpWbU+jUB/+80qyg4K3kGii1X24SrIKnU
 CjdMpjDr1wrlSNQyJ7iqApar7vbfxkpIASP9/QtbLm04hbQyvyjLWE4OdLDjj1TFHyjmzQfJnKzXw
 n4qq5pqg==;
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 quentin.schulz@cherry.de, heiko@sntech.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2] drm/panel: ltk050h3146w: convert mipi_dsi_attach error
 message to dev_err_probe
Date: Mon,  2 Nov 2026 17:18:01 +0100
Message-ID: <20261102161801.102464-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The panel will happily report every defer during probe with an error
message.

Silence that to actual errors.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
changes in v2:
- adapt to drm_panel_remove removal

 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 8a02e92061f5..e95c99e28a09 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -588,10 +588,8 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 		return ret;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
-	if (ret < 0) {
-		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
 
 	return 0;
 }
-- 
2.47.3

