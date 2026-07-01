Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2619C44501
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC2710E1B6;
	Wed,  1 Jul 2026 12:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FWMa0Onq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDCC110E1B6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908476;
 bh=bouJrrAmvaCef0ljEylZ0CN770Hr5Qsn4ItcvLnxm7g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FWMa0OnqQ0lEFTe8z1u/M+eRNlY0XZE1P3HK+q9jM+QMd8styF+35vFxhXdJS9Gkx
 4A3dRRpJ9Mu1a+stnivyS1dW5XzsR6Fli3gDylqGLI7EpFYjpsw2tpQd1uj/H8pr5/
 Jxm5dpzK3Y0BNyWVI5IR3AFx/AqgfJx7GHoSxa1s4y4IOpBlpV3WEjkKa5vT/7AyyP
 caOImNhoWOrWQ0xl6Gi3BoUEfcqX39imRPLdpoQktQKSz+OsM74Ad2UqHDSUhNf/2o
 bhm1umDqmQgHswkVS274hoHAXnA4zLZl7/rocVCmXrltDL0uQdlOSVDnIUwRv3Debb
 fxFcShBdCPhmA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D194517E0FB0;
 Wed,  1 Jul 2026 14:21:15 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 12/42] drm/mediatek: ovl_adaptor: Add special MERGE component
 check
Date: Wed,  1 Jul 2026 14:20:27 +0200
Message-ID: <20260701122057.19648-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
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

On the legacy ovl_adaptor for MT8195 and MT8188, four MERGE IPs
from VPPSYS are used, and those shall be exclusive to the OVL
Adaptor driver.

For this reason, add a branch in mtk_ovl_adaptor_is_comp_present()
to check if the component that is being checked is MERGE and, if
so, iterate through the list of component matches to understand if
it is one of those that must be exclusive to OVL Adaptor.

This resolves a corner case happening when mediatek-drm retries to
probe after a probe deferral, where all MERGE components would get
added to both "normal" and OVL Adaptor pipelines.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index ed9a2e35ba8a..bbf1d8ccda05 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -519,6 +519,17 @@ bool mtk_ovl_adaptor_is_comp_present(struct device_node *node)
 	if (type >= OVL_ADAPTOR_TYPE_NUM)
 		return false;
 
+	/* Check if this is one of the MERGE components used in OVL Adaptor */
+	if (type == OVL_ADAPTOR_TYPE_MERGE) {
+		int id = of_alias_get_id(node, private_comp_stem[type]);
+
+		for (int i = OVL_ADAPTOR_MERGE0; i <= OVL_ADAPTOR_MERGE3; i++)
+			if (comp_matches[i].alias_id == id)
+				return true;
+
+		return false;
+	}
+
 	/*
 	 * In the context of mediatek-drm, ETHDR, MDP_RDMA and Padding are
 	 * used exclusively by OVL Adaptor: if this component is not one of
-- 
2.54.0

