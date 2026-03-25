Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74175FEA806
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 04:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5E7A10E74F;
	Wed, 25 Mar 2026 04:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="FCsSVkwi";
	dkim-atps=neutral
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E6010E750
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 04:05:06 +0000 (UTC)
X-UUID: caa7433a27ff11f1a39cd589f645bc18-20260325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=oVtXg1u//KQSDkG3AxcksQOdaQT8WeDudVdcXW7j2L4=; 
 b=FCsSVkwiMfovm4e4uDE5YPD4hts9SWBAUoYOGei/OtbKvXIPTkJ4hlWyArBFBM2UaDfnow1w2D3U4YCd/0BBmR3sqrG9unusriyRDGNGHVticAaKn21aSqsSWYwaReyLDNsqxePYhBr8m7diNO9zm8oHwijFf931ZrK6uflcr2Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:be801dfe-f9e8-4313-9543-a192d194e1eb, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:e053aa8e-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
 0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: caa7433a27ff11f1a39cd589f645bc18-20260325
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <jason-jh.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1087379403; Wed, 25 Mar 2026 12:04:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Mar 2026 12:04:58 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Mar 2026 12:04:57 +0800
From: Jason-JH Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Nicolas Dufresne
 <nicolas@ndufresne.ca>, Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Jason-JH Lin
 <jason-jh.lin@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Singo Chang
 <singo.chang@mediatek.com>, Paul-PL Chen <paul-pl.chen@mediatek.com>, Moudy
 Ho <moudy.ho@mediatek.com>, Xiandong Wang <xiandong.wang@mediatek.com>,
 Sirius Wang <sirius.wang@mediatek.com>, Fei Shao <fshao@chromium.org>,
 Chen-yu Tsai <wenst@chromium.org>,
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-mediatek@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>, 
 <linux-media@vger.kernel.org>
Subject: [PATCH v2 1/3] soc: mediatek: mtk-cmdq: Remove cmdq_pkt_jump() and
 cmdq_pkt_jump_rel_temp()
Date: Wed, 25 Mar 2026 12:04:20 +0800
Message-ID: <20260325040457.2113120-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260325040457.2113120-1-jason-jh.lin@mediatek.com>
References: <20260325040457.2113120-1-jason-jh.lin@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
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

Since all users have migrated to the new cmdq_pkt_jump* APIs without
shift_pa, the wrapper APIs cmdq_pkt_jump() and cmdq_pkt_jump_rel_temp()
can be removed.

Signed-off-by: Jason-JH Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/linux/soc/mediatek/mtk-cmdq.h | 30 ---------------------------
 1 file changed, 30 deletions(-)

diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
index 3d0de1a9cac1..be67bee043ce 100644
--- a/include/linux/soc/mediatek/mtk-cmdq.h
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -423,12 +423,6 @@ int cmdq_pkt_poll_addr(struct cmdq_pkt *pkt, dma_addr_t addr, u32 value, u32 mas
  */
 int cmdq_pkt_jump_abs(struct cmdq_pkt *pkt, dma_addr_t addr);
 
-/* This wrapper has to be removed after all users migrated to jump_abs */
-static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
-{
-	return cmdq_pkt_jump_abs(pkt, addr);
-}
-
 /**
  * cmdq_pkt_jump_rel() - Append jump command to the CMDQ packet, ask GCE
  *			 to execute an instruction that change current thread
@@ -441,24 +435,6 @@ static inline int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
  */
 int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset);
 
-/**
- * cmdq_pkt_jump_rel_temp() - Temporary wrapper for new CMDQ helper API
- * @pkt:	the CMDQ packet
- * @offset:	relative offset of target instruction buffer from current PC.
- * @shift_pa:	[DEPRECATED] shift bits of physical address in CMDQ instruction.
- *		This value is got by cmdq_get_shift_pa().
- *
- * This function is a temporary wrapper that was introduced only for ease of
- * migration of the many users of the CMDQ API located in multiple kernel
- * subsystems.
- *
- * This has to be removed after all users are migrated to the newer CMDQ API.
- */
-static inline int cmdq_pkt_jump_rel_temp(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa)
-{
-	return cmdq_pkt_jump_rel(pkt, offset);
-}
-
 /**
  * cmdq_pkt_eoc() - Append EOC and ask GCE to generate an IRQ at end of execution
  * @pkt:	The CMDQ packet
@@ -613,12 +589,6 @@ static inline int cmdq_pkt_jump_rel(struct cmdq_pkt *pkt, s32 offset)
 	return -EINVAL;
 }
 
-/* This wrapper has to be removed after all users migrated to jump_rel */
-static inline int cmdq_pkt_jump_rel_temp(struct cmdq_pkt *pkt, s32 offset, u8 shift_pa)
-{
-	return -EINVAL;
-}
-
 static inline int cmdq_pkt_eoc(struct cmdq_pkt *pkt)
 {
 	return -EINVAL;
-- 
2.43.0

