Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4541D58CCA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F47710E48E;
	Tue, 24 Mar 2026 12:53:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lZ68jPXJ";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4963710E48E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:53:26 +0000 (UTC)
X-UUID: 6faaae4c278011f1a39cd589f645bc18-20260324
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=qjXKHDvWv2Yv55wY5iexKsAEMXtOH0X9DZO/Du64aZY=; 
 b=lZ68jPXJ7ygAw4gMT47pJ6hjemAxzBg/spc3F2qh1egHpsZ+iZNb/Bcyi9KiEIELDgOOhbxe5xzbMzBqIx5Y+ZNRPEIgvH0hX+35FA2h7zztMAKqkS1XJjUwMZuGSNcZ1dbYNpdqE5h8iyixnXnf4fFG9cImylXZg4H432tXyVo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:6576fc28-4c4c-45ad-b3d2-36c7b20af83c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:439a2794-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
 0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA
 :0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6faaae4c278011f1a39cd589f645bc18-20260324
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <jay.liu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1937458855; Tue, 24 Mar 2026 20:53:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 20:53:19 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 24 Mar 2026 20:53:18 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, Jay Liu <jay.liu@mediatek.com>
Subject: [PATCH v4 0/6] porting pq compnent for MT8196
Date: Tue, 24 Mar 2026 20:51:57 +0800
Message-ID: <20260324125315.4715-1-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Change in v4:
- Address coding style comments for disp-tdshp binding. 
- Rebase ccorr driver patch on top of latest linux-next to fix conficts.

Jay Liu (6):
  dt-bindings: display: mediatek: gamma: Add support for MT8196
  dt-bindings: display: mediatek: dither: Add support for MT8196
  dt-bindings: display: mediatek: ccorr: Add support for MT8196
  dt-bindings: display: mediatek: disp-tdshp: Add support for MT8196
  drm/mediatek: Support multiple CCORR component
  drm/mediatek: Add TDSHP component support for MT8196

 .../display/mediatek/mediatek,ccorr.yaml      |  1 +
 .../display/mediatek/mediatek,disp-tdshp.yaml | 46 ++++++++++++++++
 .../display/mediatek/mediatek,dither.yaml     |  1 +
 .../display/mediatek/mediatek,gamma.yaml      |  1 +
 drivers/gpu/drm/mediatek/mtk_crtc.c           |  5 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       | 52 ++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  8 +--
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     |  6 ++-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +
 10 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,disp-tdshp.yaml

-- 
2.46.0

