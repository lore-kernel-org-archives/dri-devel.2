Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AE51061B28
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 00:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D498510E02D;
	Tue, 31 Mar 2026 00:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xd2hbLht";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F3910E02D
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 00:24:16 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1271195d2a7so2295185c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774916655; x=1775521455; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x6KkVZ6avnq5JZYkKR1K26BH30WGfxU6tLWicybER9M=;
 b=Xd2hbLht+chHb/V/t0ZflhJkHShukCN2PY/BIFJkuBgRi+CDkjOP0DVW9AmUrkgSgr
 gXWQVG/CD1Erq5YLn+Bq+VyLPIwDt/nEXs7xOFG0h4cKL6VqW/THZuqmS5NqYKNUCZ13
 fljp7MSm4sY/HxsI7zdEu5Ztxm4dcMt4A2fV45+kSZ2TpHataX455RhfgF/DxkbhC0IV
 B7hJW5VtUmJijyyFWP5LXeFvSeeGL5XZLIG/Cp2br9A/WQy9rwPBuQ5UGAn0oY29p1Hd
 J3jHbSiDmUedGKzdDOVgduSjgjpX5rbK5DG8VyfIFgBrpwwY/t+Pr+sK18A0w52b1o2I
 Cjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774916655; x=1775521455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6KkVZ6avnq5JZYkKR1K26BH30WGfxU6tLWicybER9M=;
 b=BgV5pFvaC09RatDZx9hSHl5wO533d/8vKsdlCTHBtHKKY7czgWvhwJVY8SzvYFTB9v
 mJ1uQjclFEO4WRgWrxPpXifoyFrY+g2NVoLlQJ48MslA1sZKG+vyDo0mrmV/ytxjfs8w
 sLYWMkVExI0fTxvfyzXXr4jPtSo/6DfMh7X8JDGMcnImr5c6gilr0YHuexwWavQuJ1lj
 NTwNawD/HHkkLseDThc219TQ2iRvrKuSYh11wlL8NxfaDuUf8805fH5E1lzG3zbQaOZB
 FkH9UgRXRWK1jslimk13yGdzWXzVZwP4ZgeKG3igIiTZb5rmpqG6GpFOty6zWqPQj6lG
 mbPA==
X-Gm-Message-State: AOJu0YxUhp5fkwHAEg9Nrx5btDmQNRWtY5j3glc+NvWiCPR35L+nVIkZ
 RyvwIWq1co8usNQcOTlewUC6/1GQ1WoXo796CfCyZWK7Yz/Y6l5wTLtyuG62+A7j
X-Gm-Gg: ATEYQzx6ydCrzAw9xERWckS+1A7CcEnzYTItwRevW7wUiZ2vOIp/ZJ9HAj1O1sq6wHA
 I7+dQ9Nh77+Y3yz8wlsCe4uDq5lpLFWPBcv/A2VbPVZlF7xgjlwBT6HpffiC/beqR9W/XdnOKfy
 o4x8Cns+aORSzqIGh7D2QuvVdsifQEwLsjeOuXTvbEGgqPuj5xpHzA94XCmSNyFucWHxr1jKvrP
 ZlWbPmBZGjE3DEWmlpoQSb0A1bvInbbI4U1/1aUJayZCHVSy/paD5DImKfAO3H2VxquiTRZLANy
 N6sbE9QcSGzfxf0i84+EJ8M/iEHFFozcUw4Dox0DY078HrEJIDeByp8gmLY+Tq/bLOnMmsShZLI
 7mNWLV8KqDcW+psn4G7c9Z/PRkkcHOSmpMGcCYmpQqHSUaBhcA35Ir8QTo+rTpP76PIGZkVBQLd
 2jU1DgmQylrHULBc8hJgWaMGaP5L8YBeLeabfug4RrFUSNnfBmbHstKIw=
X-Received: by 2002:a05:7022:2221:b0:128:d2a5:709c with SMTP id
 a92af1059eb24-12ab28f3331mr8407522c88.33.1774916655278; 
 Mon, 30 Mar 2026 17:24:15 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12ab983f9f3sm13195709c88.10.2026.03.30.17.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 17:24:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org (moderated list:DRM DRIVERS FOR MEDIATEK), 
 linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH] drm/mediatek: simplify mtk_crtc allocation
Date: Mon, 30 Mar 2026 17:23:57 -0700
Message-ID: <20260331002357.7995-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Use a flexible array member to combine allocations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index fcb16f3f7b23..914841d2396e 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -62,7 +62,6 @@ struct mtk_crtc {
 	struct device			*dma_dev;
 	struct mtk_mutex		*mutex;
 	unsigned int			ddp_comp_nr;
-	struct mtk_ddp_comp		**ddp_comp;
 	unsigned int			num_conn_routes;
 	const struct mtk_drm_route	*conn_routes;
 
@@ -71,6 +70,8 @@ struct mtk_crtc {
 	bool				config_updating;
 	/* lock for config_updating to cmd buffer */
 	spinlock_t			config_lock;
+
+	struct mtk_ddp_comp		*ddp_comp[];
 };
 
 struct mtk_crtc_state {
@@ -1048,18 +1049,12 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		}
 	}
 
-	mtk_crtc = devm_kzalloc(dev, sizeof(*mtk_crtc), GFP_KERNEL);
+	mtk_crtc = devm_kzalloc(dev, struct_size(mtk_crtc, ddp_comp, path_len + (conn_routes ? 1 : 0)), GFP_KERNEL);
 	if (!mtk_crtc)
 		return -ENOMEM;
 
-	mtk_crtc->mmsys_dev = priv->mmsys_dev;
 	mtk_crtc->ddp_comp_nr = path_len;
-	mtk_crtc->ddp_comp = devm_kcalloc(dev,
-					  mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
-					  sizeof(*mtk_crtc->ddp_comp),
-					  GFP_KERNEL);
-	if (!mtk_crtc->ddp_comp)
-		return -ENOMEM;
+	mtk_crtc->mmsys_dev = priv->mmsys_dev;
 
 	mtk_crtc->mutex = mtk_mutex_get(priv->mutex_dev);
 	if (IS_ERR(mtk_crtc->mutex)) {
-- 
2.53.0

