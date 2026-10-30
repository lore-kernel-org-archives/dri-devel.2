Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0089606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=D8772tbJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3172110E23A;
	Fri, 30 Oct 2026 11:59:02 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C81310E23A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 11:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
 bh=Ivg00JdviBn30Gck+VTTg0v9k4zTuLaSYs5fpGxHdUw=; b=D8772tbJAdkRNp2fqrbi2ZAyQA
 puPobldzp4SiDVB7HoJbYPBcN5WpIYQ2tVnASy/aXKc2e/JnT7pEI3EindGxdnGlU7TnEIhlesZjO
 lmenYDOKpozGbiLJRGg+7lOCPQypN/rF/WPDUc3MJt2JKNS3K80eM5lRVDfXpvD0O3+wp6JZGLc66
 GmzxUqbJMyBzhwiJp/P7u7sUyGWELdVraOKDNbXtQiRVWpRSL1DQReCPeW3scGx2Jvx7u/5KdUI7z
 Y/NcpVN0npVPbzGCiUnP0h3FTNn1zPKqDH6wItxLLZ/Re4H6UHLhGdhPD014OS5f5GaRWWq0mhDuw
 3/pgQT7g==;
From: Heiko Stuebner <heiko@sntech.de>
To: neil.armstrong@linaro.org
Cc: jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 quentin.schulz@cherry.de, heiko@sntech.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] drm/panel: ltk050h3146w: convert mipi_dsi_attach error
 message to dev_err_probe
Date: Fri, 30 Oct 2026 12:58:43 +0100
Message-ID: <20261030115844.3661099-1-heiko@sntech.de>
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
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 0856df5a6ee2..459d8a1ceab4 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -587,7 +587,7 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
-		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
+		dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
 		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
-- 
2.47.3

