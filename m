Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ECAC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7637210E8A4;
	Mon, 13 Jul 2026 09:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="S48uLbyZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8456510E8BA
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783936722;
 bh=L3vveFHarcM3rTKYGNiyk7oFljFUe8aHn+MiLlT0Lmo=;
 h=From:To:Cc:Subject:Date:From;
 b=S48uLbyZxCPaozPuYjE0+A1NfJSeB0WLmCZ9iJz8C3D3lgiGzr7Cn0ZKTkmucMhcc
 ih1OMnv3ufo3HUwYFy6EoRdWZ1iFPwyCVL/uiaf2OKgBtdU7DZOYtt9i3UUUB37AMu
 uk05NwFUyiopBcQEa4wtk6chCfIn1773Nupkq/DtH28OMCyNffdCSuJ6JnRnwrcv81
 TMiLLkzwkxUPbFVGg6yyxkPRdfnNo1Dnq+4gKA9j786FPzXSsNy3nXpAp7Egp6rYsa
 Clkj4SI3c+ACh2lbWGvyk1oB5/rATVQvHuqgpP/ILj2TFda/powNz6r5qrIGdYvHV+
 S0Mq4tZoYETsw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 18C2317E01AC;
 Mon, 13 Jul 2026 11:58:42 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, justin.yeh@mediatek.com, jason-jh.lin@mediatek.com
Subject: [PATCH v2 00/10] drm/mediatek: Add DSC, WDMA, MT8189/96 DSI support
Date: Mon, 13 Jul 2026 11:58:27 +0200
Message-ID: <20260713095837.16590-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
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

Changes in v2:
 - Rebased on next-20260706

This series adds support for:
 - Display Stream Compression (DSC) for DSI and DisplayPort for both
   legacy (8188/92/95 and others) and for Kompanio Ultra MT8196 SoCs
 - Write DMA (WDMA) Engine (for legacy only at this time) as a step
   to enable Writeback support (coming later with a restructuring of
   the entire mediatek-drm driver)
 - Newer MIPI DSI IP revisions, found in MT8189 and MT8196 SoCs

AngeloGioacchino Del Regno (10):
  dt-bindings: display: mediatek: dsc: Add MT8196 compatible
  drm/mediatek: Implement Display Stream Compression support
  dt-bindings: display: mediatek: dsi: Document MT8189 and MT8196
  drm/mediatek: mtk_dsi: Enable interrupt at component bind time
  drm/mediatek: mtk_dsi: Transfer register offsets to per-SoC const
  drm/mediatek: mtk_dsi: Add support for MT8189
  drm/mediatek: mtk_dsi: Add support for MT8196
  drm/mediatek: mtk_dsi: Enable PM Runtime on probe
  dt-bindings: display: mediatek: wdma: Add compatibles for more SoCs
  drm/mediatek: Add Write DMA (WDMA) Engine for Writeback support

 .../display/mediatek/mediatek,dsc.yaml        |   4 +-
 .../display/mediatek/mediatek,dsi.yaml        |   2 +
 .../display/mediatek/mediatek,wdma.yaml       |   5 +
 drivers/gpu/drm/mediatek/Makefile             |   2 +
 drivers/gpu/drm/mediatek/mtk_crtc.c           |  21 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       |  64 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |   9 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  29 +
 drivers/gpu/drm/mediatek/mtk_disp_dsc.c       | 435 +++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_wdma.c      | 611 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |   8 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   2 +
 drivers/gpu/drm/mediatek/mtk_dsi.c            | 733 ++++++++++++++----
 13 files changed, 1741 insertions(+), 184 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_dsc.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_wdma.c

-- 
2.54.0

