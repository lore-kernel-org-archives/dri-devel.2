Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5AAC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 07:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D7210F3F0;
	Fri,  7 Aug 2026 07:17:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="RLlv2TtY";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EA1D10F3AC;
 Fri,  7 Aug 2026 07:17:44 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6775m9xv2406056; Fri, 7 Aug 2026 08:17:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=0
 JS3/8jpUwRxPwj2sVbXwToATJyEDNoiZDG+SijjyTU=; b=RLlv2TtYMCTOanral
 ZA9pnj5jATW+nc2raTnM17IsI7a3oEJTwzQhgzSdGYhxYnyW4JquHs/L7leyk4Cj
 Rqh6jP3tDR+9uJbf95vxX07J1E0LMASRJAh1OGgS3BWr4ytwoi0FACNzF4LBwzTi
 WwfF88bMzh30RgyEwVBcwKjssd2yC9Bl+wH9aKoB24p0r2fO8MS2xB7DCU9P4VNe
 DC7hyvJx6MvFSI573PyboeBoew2O9/GiOFgo9M8Fdr6myl4/TvkDD8vrP8drHkJK
 6BefVI3aliD1UIDCtbHoIRvjRPkWAtL+oIkQVvsX3gjeY6p4/FxFKnhSdpz9SmBI
 SPbtA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fvxy30hv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 08:17:35 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 7 Aug
 2026 08:17:33 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Fri, 7 Aug 2026 10:17:25 +0300
Subject: [PATCH 2/2] drm/imagination: Move FWCORE_* macros to reg defs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260807-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v1-2-375208fbb579@imgtec.com>
References: <20260807-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v1-0-375208fbb579@imgtec.com>
In-Reply-To: <20260807-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v1-0-375208fbb579@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>,
 Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786087050; l=3058;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=+JY0XSmeMC+TN1AA5vKAKrvbc9bndrFCsePO7u2TSws=;
 b=O0aT7YhqFdyjE2yh/DCDXu5xk6wv6yFcqlyPt4XoBYkrtBd3OL04D4/5zKGrAgOqC5F9ibGxZ
 LHATrAKdreeAXf3rwCM/KFoS/txe3aLFgsrcyiunBVP6NeBa9Rc3mxO
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.88]
X-Authority-Analysis: v=2.4 cv=cZ3iaHDM c=1 sm=1 tr=0 ts=6a75868f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=YP7Kpn5otooA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=-exMY5lep_6oQMwVnoQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1MyBTYWx0ZWRfX/8c4WPeklrtl
 Rm8MI6DCLVEmsvRfdZTzOUd0KCEjnnT4BPWlPdffI/6Z5Y+gZedv/mDo3WH/m+9cHACZkY6Q2Bv
 xzqHwqIJWdmbrwz+fw/Y5NQhDsAEan7zl8LLv815EiwA2I5Kv48jWDhh4Lz/xEG3c0nlEndKWoC
 DEJyAj8wQB96FamQkQp3i4HhYWhnJe1YtZVyVR88rBDJia04pJvFFNI8pPnC2r78Bf+joqi7iY0
 4N8rooUdxzdsQkuAQpdY7nUg7mfs2aHruuk9cr1EzgbNGGYYSpLL3a2hpfMjXA1xBXI/btgXQB+
 8jOU4wUj6Kx5tTZrAwrDDYwFSMojqwahXwFc++UZJq6D45EWWyrIiXfM8wcZjVdK+pm94YerQKN
 gjA1dPVPRO2P3PM+wqJu+eyG+xFF5cUN9f/FDL7InG1tHHyIT7UTXBZDWku3/mmlNlYMz5f0ly8
 01JWu7XBsTzAC+GojUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1MyBTYWx0ZWRfX29zu2eIwHaxM
 L0vSmyNKcye1EQmilncx4fQTCIgSiHNT0TXt5MmyEyUfGyuc3+lulld3NuHnqfil6QqDH6Lkovp
 wgSHTTzpAJo3tZu/oWK1GyocJfNd4qY=
X-Proofpoint-GUID: M0aezI1aiKxsbNNVuUzYXc-TCqzIWWT0
X-Proofpoint-ORIG-GUID: M0aezI1aiKxsbNNVuUzYXc-TCqzIWWT0
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

FWCORE_* macros moved to pvr_rogue_cr_defs.h

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

