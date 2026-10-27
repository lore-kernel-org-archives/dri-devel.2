Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC1606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Ed37GiXq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A9711205F;
	Thu, 29 Oct 2026 07:59:17 +0000 (UTC)
X-Greylist: delayed 544 seconds by postgrey-1.36 at gabe;
 Tue, 27 Oct 2026 09:58:51 UTC
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com
 [111.22.67.151])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6B68B10F372
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Ed37GiXqwNsqzNpJ5CXcuYDUd57ahg06bDk5s54HCenDaLHn3s4ms1Eiiz9yJcRGOx+mqh5BbQCct
 z0mBce5/wqHPSx3rru5d17/YNOU0Pjk5sf8U+Ul7UqxRmA58yrk2a0Zum6OTC5MOC9jjj9moVnuQTJ
 dPTGVutrj95ReGU4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae073b8630-24845;
 Tue, 27 Oct 2026 17:49:44 +0800 (CST)
X-RM-TRANSID: 2ee66ae073b8630-24845
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from FHA-W6400298 (unknown[10.55.1.71])
 by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ae073b5bb3-d716d;
 Tue, 27 Oct 2026 17:49:44 +0800 (CST)
X-RM-TRANSID: 2ee96ae073b5bb3-d716d
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
 simona@ffwll.ch, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 tangbin@cmss.chinamobile.com, stable@vger.kernel.org
Subject: [PATCH] drm/mediatek: mtk_hdmi_v2: NULL check curr_conn in pre_enable
Date: Tue, 27 Oct 2026 17:49:41 +0800
Message-ID: <20261027094941.1862-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mtk_hdmi_v2_bridge_pre_enable() calls
drm_atomic_get_new_connector_state(state, hdmi->curr_conn) which
dereferences hdmi->curr_conn (via drm_connector_index) before the existing
WARN_ON(!conn_state) check. Add WARN_ON(!hdmi->curr_conn) first.

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Cc: stable@vger.kernel.org
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index f0277fcf3..c94d22042 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1026,6 +1026,8 @@ static void mtk_hdmi_v2_bridge_pre_enable(struct drm_bridge *bridge,
 
 	/* Retrieve the connector through the atomic state */
 	hdmi->curr_conn = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	if (WARN_ON(!hdmi->curr_conn))
+		return;
 
 	conn_state = drm_atomic_get_new_connector_state(state, hdmi->curr_conn);
 	if (WARN_ON(!conn_state))
-- 
2.52.0.windows.1



