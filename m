Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFCBFF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A0610E6D4;
	Mon, 27 Apr 2026 11:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Z5uhpqSL";
	dkim-atps=neutral
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22BDA10E6CE
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:22:00 +0000 (UTC)
X-UUID: 4ae5c0a4422b11f19781c1a04af40193-20260427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=hp/LOs7np6ND1lS21LT7CpMba6xNwBLO8ADggjdbUzQ=; 
 b=Z5uhpqSLUmqs2Wd9SenG12cGXpcV6RSTweikftd/87nmr4yGnw40DcYRaWR3d/I1o+4bYev6L45k7eECwqkB9NZ7xx495cVQwhPc/hlO+IJzazb+2P21SRSUDeO1V2OTWX7y8ycqduhu6pKVhB3+/dzAZsxg3eip5DnW7QN5pcY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:bb8a9ac8-bd46-4435-a771-be79f4c90e66, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:0a65f88f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|865|888|898,TC:-5,Cont
 ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
 ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4ae5c0a4422b11f19781c1a04af40193-20260427
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <jay.liu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 555924782; Mon, 27 Apr 2026 19:21:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 27 Apr 2026 19:21:51 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 27 Apr 2026 19:21:51 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, Jay Liu <jay.liu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 3/6] dt-bindings: display: mediatek: ccorr: Add support for
 MT8196
Date: Mon, 27 Apr 2026 19:20:17 +0800
Message-ID: <20260427112131.23423-4-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260427112131.23423-1-jay.liu@mediatek.com>
References: <20260427112131.23423-1-jay.liu@mediatek.com>
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

Add a compatible string for the CCORR IP found in the MT8196 SoC.
Each CCORR IP of this SoC is fully compatible with the ones found
in MT8192.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jay Liu <jay.liu@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index 5c5068128d0c..a97e758f6571 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -34,6 +34,7 @@ properties:
               - mediatek,mt8186-disp-ccorr
               - mediatek,mt8188-disp-ccorr
               - mediatek,mt8195-disp-ccorr
+              - mediatek,mt8196-disp-ccorr
           - const: mediatek,mt8192-disp-ccorr
 
   reg:
-- 
2.46.0

