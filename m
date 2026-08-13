Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5541BC5DF6D
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A78A10F300;
	Fri, 14 Aug 2026 07:04:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aSZKJ3UE";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2166B10F483
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:55:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d01663d816so2343025ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786643723; x=1787248523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SF4su2A7LBkgNyuJx7QC3c3F7wOlkzt5ypMNp2gqA1w=;
 b=aSZKJ3UECIFvEx2724yDGH5B9wvsioMHXFqul2fG/86lsiPPpCTplMGFfgoPHeiiNN
 Uj4xBEdMGRBDcs96Yvz3FuMhHabC8x6XdTUs6tJcvHTpGlI/nABly4BsQFb+v1As/xNF
 Rq465a9xPcxAkpxIhvRSv2fD5Vw1uITTaDnZsi53X6OYi1GfHXN1K4el9zARjX5bhpqe
 cqPQPKNYVL6flNViqjAp51c9BfNXzNPO+ZinLVjbdfBfyxR0Uh/+a0sd5582JcdLxX3P
 Whw6sii5tyvtDa5UAH5+msG1ipHHVkfnTK9vrJx+RoaS5PZnLyRNTjTOShfTk+4ycLL1
 qcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786643723; x=1787248523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SF4su2A7LBkgNyuJx7QC3c3F7wOlkzt5ypMNp2gqA1w=;
 b=Vu8itt4azB+IsKMdCea/vKy6hJg+lINFgnpMiOru124PgRNs6TEbQM2/AyuvkRdx2p
 alNknd48wKQvZ0XQzjCsOOZ2pgLwHR0WIhbxoIhCE2VHHiJU6VcOfjTD0FX3CPY5aaD5
 XWFGQpL0Y/Fqy/1RVmOfQAaQJS/2tBe4fv0VdAdEsT8rdl1wP+um8r9Cru+Qv0LXXzCA
 YngzKzY1aE8wM+z1OiE1eZsrw/wWO9/MVFObflb0PxP2awtbBI4J0y9fqHAkYK+BrF6Q
 P7DvO0DD40uHfgWOBYXOPgWHm/Ivh9JBuYHWs4xqEH4gVAOLmyavbw7pE5mGTQs/kXoJ
 39ug==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkLE6v31rtUlc144Zlrg+f/DI9TUd9+R0zVf1W689e+V3UrrNkhrDAqW6HxzubxABaLVsYUl7q6VA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZjSoViGo2pTGV3B9wTjO/MUbPoLcrEbtxQhXSzk9jkbFtHdyY
 3UByfTqXsX1cFB1tC+oX6T/RKUCBxH+HG0CGaWoMRsd83vhblcbq4kj8
X-Gm-Gg: AR+sD11CM7GKERslg2tkO/bybOmjznWTtmB8qiRc7cN0D377JOjO9zNj9Hl9Rs+81QL
 WYU11FbiPa8BKXRAkV67juheG8odQ9GK1pcHPg5P5qcLT0ivw44UZXDfcYlIHVzV+HwyhXbHQ+U
 6DCRvm1Mj7s2sYoDLlKspEgILL1uS5o9jZ82bn/RNHaYKEd2JHYzZX+7i0yCZFS/3cjcMFMdlSM
 TMzSh5H5GpzCDJEqR3lLAkJXxmaciDZaNjTVLlsC0UppoTN4DDzX3E9qIOgL9ObrpqDLSHsV0f4
 v6ujAhqTJhvuSEJfBBr6wyp4A18bUshvEHWTL6bLbo/VScMHN1QWfFzzDVhOR5M8l0XgfsuAo8J
 dNUHKOAXHPrhHiG8TLB8VSqfJy0VFyTxC3D+fMo4atu/LqLXbT3Fk/bgQNYYHev9OhrFsaYheAo
 vbA8Th37//N9uLr2TYH9SV3+kVMLXMZ6lySDV+iw+3+vL+aOatK1x9LzHf4Wert1szEcE3KWSHt
 6JnoFVyyQsO0CkkM9UZZR4XiuXiiSr5fpUFwJj1UUrWp3MlepGsAZgkNaCLfp2k2XSu
X-Received: by 2002:a17:902:c948:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2d37d52e1d6mr84044455ad.5.1786643723510; 
 Thu, 13 Aug 2026 10:55:23 -0700 (PDT)
Received: from LAPTOP-M4N25KQ5.tail73068d.ts.net
 (1-160-237-124.dynamic-ip.hinet.net. [1.160.237.124])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3aec05197sm675935ad.81.2026.08.13.10.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 10:55:23 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v1] drm/mediatek: mtk_dsi: Open-code drm_simple_encoder_init()
Date: Fri, 14 Aug 2026 01:55:17 +0800
Message-ID: <20260813175517.156893-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

The drm_simple_encoder_init() helper is deprecated because it adds an
intermediate abstraction layer that only wraps drm_encoder_init() with
an empty or minimal drm_encoder_funcs struct.

Replace drm_simple_encoder_init() with explicit calls to drm_encoder_init()
and define driver-specific drm_encoder_funcs carrying the cleanup callback.

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 49dfc0f825cb..276d57f8407b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -226,6 +226,10 @@ struct mtk_dsi {
 	const struct mtk_dsi_driver_data *driver_data;
 };
 
+static const struct drm_encoder_funcs mtk_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
 {
 	return container_of(b, struct mtk_dsi, bridge);
@@ -918,8 +922,9 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 {
 	int ret;
 
-	ret = drm_simple_encoder_init(drm, &dsi->encoder,
-				      DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm, &dsi->encoder,
+			       &mtk_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		drm_err(drm, "Failed to encoder init to drm\n");
 		return ret;
-- 
2.43.0

