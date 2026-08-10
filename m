Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9724C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2214810E728;
	Mon, 10 Aug 2026 08:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="tRnl5CLv";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C71610E720;
 Mon, 10 Aug 2026 08:36:03 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A67ewL1670335; Mon, 10 Aug 2026 09:35:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=E
 ZUKpww7owbHu1r9O9AxvdUCCI5n7LLbvV+ZBHADpZ8=; b=tRnl5CLvdvU3E7Tfg
 t52yIJExs5xqymf1iF6G+CQnF3u5o1PxfQPcLLPSJFtezGJ1V5Js4Tpxpq99Cz1z
 gofFyH4iSlqkt9g+bzD2X7TTdXQ2voZpSaZfhvW2buxTzQQX9PQ20EYlmRPMHCOQ
 6PaNmjEVU8wsR24y6VOy5EucAB4dKUfP+iGMe0gIb9WQhVOGB1o9b4LNnxj+BV+T
 91ldsA7c1X9FrBopNXeCs759fyaFvP6fOfn+dDEvrKAP+e/bSE2LdRXbyRzPqeL3
 fQTBusf/1E1SNsaCBKA15WqNEyEkwcPjOthU+cxw3lQmQebEi6FvHIVB6k29RJK6
 XYONw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fwvhtsfy0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 09:35:48 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 09:35:46 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 10 Aug 2026 11:35:20 +0300
Subject: [PATCH v2 2/2] drm/imagination: Move FWCORE_* macros to register
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260810-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v2-2-991ae813fd88@imgtec.com>
References: <20260810-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v2-0-991ae813fd88@imgtec.com>
In-Reply-To: <20260810-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v2-0-991ae813fd88@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786350943; l=3107;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=Xmleamqy/H6fAIhM71TJZYc4E0fS4PYC9KvsWAY+9r0=;
 b=kcGHhU91ai49iYuguTSacPQdmfME6NMSvfmu6Uc9FXPAVCX0OHhj/4gGSommb18DSpZNyFfPN
 EwftZKXgfH8A5g3fz7B2PTVSb/d+0AoP/KpoiNQLoP5vDcgpm/MOOp6
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-GUID: TxH_HYMkkjWCuGflCLTTXOsPh2Yum4Zr
X-Proofpoint-ORIG-GUID: TxH_HYMkkjWCuGflCLTTXOsPh2Yum4Zr
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a798d64 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=-exMY5lep_6oQMwVnoQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3MyBTYWx0ZWRfX17BVCb13q9A7
 9wGGMY22nQm8j6nKiV2ThntMY3ssFThGF255xHV0Z7cvEvQbtIhT6OcEdqSwfusbzmBKbempa/L
 3KbXKQWyCwqivI12OWwIyP6quA5xqUQ2So7X0R7X03ZweyGuX615WD/ZMXGtdZJ68xXcGej7mg2
 op4O2lbpfN99B2PGWQKyjcSrdJLdtmPvt78e+bfgb4pFSWLURSAYo8ueAZ1JNQH2ITNzpeEfk2E
 X8MjZj6sDrS9CCBxJITd5ZpjYGuNemsCPLF6kdkiTnK1+KSIJ1HMkMSwm7oxVyKRPZEQzP7uV0J
 AdE5paQb9jNLt6fNSMpmO4k/HooQIKkWo6eXFDMtt/TcZz4/uh39vm4kDK+fc1Z6kxCMrLrgFby
 QrgNoRw4clhhUhs94DXqQWNCfddv3sE+AWpuLfMJ7VCL+QpYyOP+5pkcckBlpwws2XzGxW5zm8U
 60kNsSE/jZnbPNDv/iA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3MyBTYWx0ZWRfX/6Q2drnVHzOU
 LSmliqzxusw6yHzX8UDic/UXJd1ep0FmFJmoL2UscFh2GOYgKZl4ZnQBgeA1h8ggdrb9ltl/kAb
 6lmyDSk9GAfviJQXfOMgeCLNnQ3cTnI=
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

From: Matt Coster <matt.coster@imgtec.com>

FWCORE_* macros moved to pvr_rogue_cr_defs.h where they should have been
from the beginning.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_riscv.c      | 5 +++--
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h | 2 ++
 drivers/gpu/drm/imagination/pvr_rogue_defs.h    | 9 ---------
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index d2bd263aa25f..c160ec9e3ff2 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -23,10 +23,11 @@ static int
 pvr_riscv_wrapper_init(struct pvr_device *pvr_dev)
 {
 	const u64 common_opts =
-		((u64)(ROGUE_FW_HEAP_RISCV_SIZE >> FWCORE_ADDR_REMAP_CONFIGx_SIZE_ALIGNSHIFT)
+		((u64)(ROGUE_FW_HEAP_RISCV_SIZE
+		       >> ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_ALIGNSHIFT)
 		 << ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_SHIFT) |
 		((u64)MMU_CONTEXT_MAPPING_FWPRIV
-		 << FWCORE_ADDR_REMAP_CONFIGx_MMU_CONTEXT_SHIFT);
+		 << ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_CBASE_SHIFT);
 
 	u64 code_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.code_obj);
 	u64 data_addr = pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.data_obj);
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
index 5fbb1ffd0eb9..45d784f2a82c 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h
@@ -3029,6 +3029,8 @@
 #define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_FETCH_EN_EN 0x1000000000000000ULL
 #define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_SHIFT 44U
 #define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_CLRMSK 0xF0000FFFFFFFFFFFULL
+#define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_ALIGNSHIFT 12U
+#define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_SIZE_ALIGNSIZE 4096U
 #define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_CBASE_SHIFT 40U
 #define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_CBASE_CLRMSK 0xFFFFF8FFFFFFFFFFULL
 #define ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_DEVVADDR_SHIFT 12U
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_defs.h b/drivers/gpu/drm/imagination/pvr_rogue_defs.h
index 035e2ea39434..f09ab85e590a 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_defs.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_defs.h
@@ -96,15 +96,6 @@
 /* Utility macro for accessing instances of repeated registers */
 #define PVR_CR_REPEAT_X(REG, N) ((REG##_REPEAT_BASE) + (N) * (REG##_REPEAT_OFFSET))
 
-/*
- * FWCORE wrapper register defines
- */
-#define FWCORE_ADDR_REMAP_CONFIGx_MMU_CONTEXT_SHIFT \
-	ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_CBASE_SHIFT
-#define FWCORE_ADDR_REMAP_CONFIGx_MMU_CONTEXT_CLRMSK \
-	ROGUE_CR_FWCORE_ADDR_REMAP_CONFIGx_CBASE_CLRMSK
-#define FWCORE_ADDR_REMAP_CONFIGx_SIZE_ALIGNSHIFT (12U)
-
 #define ROGUE_MAX_COMPUTE_SHARED_REGISTERS (2 * 1024)
 #define ROGUE_MAX_VERTEX_SHARED_REGISTERS 1024
 #define ROGUE_MAX_PIXEL_SHARED_REGISTERS 1024

-- 
2.43.0

