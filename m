Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B827C54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56C4010EC50;
	Wed, 29 Jul 2026 14:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="nHOblW90";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6559310EC50;
 Wed, 29 Jul 2026 14:57:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TEL64L1014198; Wed, 29 Jul 2026 15:57:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=C
 zyN6MW7wAEK8X/4AZm0jkJ2IYQ4vW5dcE01yzHaGZs=; b=nHOblW90l+4vlrL78
 1RMh0Ufajow69SeBxFpY1da9t/iXJmskERy9f4Z8poB+XyUGna+LTNj0Aee0Y5rr
 gwxj0Ye7MnjOaXeyniIcSIIcAIeXEfqjgusbvC3/6gYhtD5BxgOnbqbhKMmvcKj8
 dMejoRRPvDHrgwpo/tG5GKrVkx8t5wuBdjQgMqemCOm2rggP+i6Gt4SaQfWyTbFo
 XeMLexqA7RGwAwuVnJS0f+hEwwRaXKcsL5J1UcPca2ympStH8qbWc67AJGMxiKXg
 aAvQi64wyWVQiaFP4BeQkdBMAzRrTWhqzDuh8inYbVD2j32ptlDQ4S4PXqsAsmyV
 sOwHg==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr0hvj-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 15:57:29 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:57:28 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Wed, 29 Jul 2026 15:57:07 +0100
Subject: [PATCH 2/2] drm/imagination: Reuse layout check macros for MIPS FW
 structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-fwif-checks-updates-v1-2-af65e9606a7e@imgtec.com>
References: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
In-Reply-To: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Alessio Belle <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5294;
 i=alessio.belle@imgtec.com; s=20260628; h=from:subject:message-id;
 bh=mqog3cmOzUCI6mPbvra6Hjq79ZX88fTzvJRFdXi5wTo=;
 b=owGbwMvMwCUm4nVW5aiD4lnG02pJDFlZItfdVFrZeYqK+5ga0hf+qrR4vqlq2/69yXs8Fr/lO
 XEx5IV6RykLgxgXg6yYIsuHfRv/2+p9qJVi2H4RZg4rE8gQBi5OAZjIzpMMPxmZrs/o+e52TfXN
 sf8beuqMCsvqe67cefJHbp/PST9R85sM/wMlRfuXzNBnOLmEu+rjjbA7woZ7TDMVJa4rRJtyFvx
 /xQ4A
X-Developer-Key: i=alessio.belle@imgtec.com; a=openpgp;
 fpr=F0BEB1FF3D2EF07D1A00B7D1144ACD24C54021CD
X-Originating-IP: [172.25.4.151]
X-Proofpoint-GUID: koUZssmtIvp1eW3ipg4a8YeabP2XXSth
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6a14d9 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=CPmu8f3oicuuQNJGAnsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX3m7utVeEObH+
 LfXCXO/Pmby4sfW3HsJbM6MAzwg0F5Ng8y7Z3bTByOi10H4wOFEy9OZ4SLCtZXnsSjviItG9ewk
 fAHkmSPFins4RgqEbNHUqAtg1PRJehjsWdhsVaockS7KfOcQGWBiZQ4M3naOssZltPEYa0XC0fr
 8InAiqrsvEA3Lf5VmX1IxC+Nma1ImfYNdj/lETX+TPxCo6t86XmYd5afb0cqKSGXL4GFsOrdflg
 VcFno8DLyvMqR/vPKSSb6hjgWuvVmiWLVEQmPdExIOvhgNRcHkqwIaz30XYLinstIBYG0XKiSqU
 FXMmp0m43MtmmNV89kOkgzlfd1Clr7wXyr8BCanNQxgclq/Kt/dXokJYhtRKYK0sGyErD71E0Ud
 yNIUgkDZmYI/QnpelGuiTzYFCWyOkbt7eLunNctxYeydyX+eDs2oDbceHivUnUVhCEJTT/6qTCY
 xCvFsNakVc6zt1x7gpA==
X-Proofpoint-ORIG-GUID: koUZssmtIvp1eW3ipg4a8YeabP2XXSth
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX5TcBTEuQ3oNL
 ke5aKkTbQ1AoT9LYCCL+SiwCVs52XcohxPD1lERZQkJ/teCvAcKXQrUWAxbsAwx0X4ZnVIrYHaZ
 dmNDHyoL0Ha1GdjT4giadYDHLfbQDdY=
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

Replace static asserts on MIPS firmware structures offsets and sizes
with more compact macros that are already used for similar checks on
common firmware interface structures.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_rogue_mips_check.h | 71 ++++++++--------------
 1 file changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_mips_check.h b/drivers/gpu/drm/imagination/pvr_rogue_mips_check.h
index 824b4bf33ac1..aebf231ce90f 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_mips_check.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_mips_check.h
@@ -4,55 +4,32 @@
 #ifndef PVR_ROGUE_MIPS_CHECK_H
 #define PVR_ROGUE_MIPS_CHECK_H
 
-#include <linux/build_bug.h>
+#include "pvr_check.h"
 
-static_assert(offsetof(struct rogue_mips_tlb_entry, tlb_page_mask) == 0,
-	      "offsetof(struct rogue_mips_tlb_entry, tlb_page_mask) incorrect");
-static_assert(offsetof(struct rogue_mips_tlb_entry, tlb_hi) == 4,
-	      "offsetof(struct rogue_mips_tlb_entry, tlb_hi) incorrect");
-static_assert(offsetof(struct rogue_mips_tlb_entry, tlb_lo0) == 8,
-	      "offsetof(struct rogue_mips_tlb_entry, tlb_lo0) incorrect");
-static_assert(offsetof(struct rogue_mips_tlb_entry, tlb_lo1) == 12,
-	      "offsetof(struct rogue_mips_tlb_entry, tlb_lo1) incorrect");
-static_assert(sizeof(struct rogue_mips_tlb_entry) == 16,
-	      "struct rogue_mips_tlb_entry is incorrect size");
+OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_page_mask, 0);
+OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_hi, 4);
+OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_lo0, 8);
+OFFSET_CHECK(struct rogue_mips_tlb_entry, tlb_lo1, 12);
+SIZE_CHECK(struct rogue_mips_tlb_entry, 16);
 
-static_assert(offsetof(struct rogue_mips_remap_entry, remap_addr_in) == 0,
-	      "offsetof(struct rogue_mips_remap_entry, remap_addr_in) incorrect");
-static_assert(offsetof(struct rogue_mips_remap_entry, remap_addr_out) == 4,
-	      "offsetof(struct rogue_mips_remap_entry, remap_addr_out) incorrect");
-static_assert(offsetof(struct rogue_mips_remap_entry, remap_region_size) == 8,
-	      "offsetof(struct rogue_mips_remap_entry, remap_region_size) incorrect");
-static_assert(sizeof(struct rogue_mips_remap_entry) == 12,
-	      "struct rogue_mips_remap_entry is incorrect size");
+OFFSET_CHECK(struct rogue_mips_remap_entry, remap_addr_in, 0);
+OFFSET_CHECK(struct rogue_mips_remap_entry, remap_addr_out, 4);
+OFFSET_CHECK(struct rogue_mips_remap_entry, remap_region_size, 8);
+SIZE_CHECK(struct rogue_mips_remap_entry, 12);
 
-static_assert(offsetof(struct rogue_mips_state, error_state) == 0,
-	      "offsetof(struct rogue_mips_state, error_state) incorrect");
-static_assert(offsetof(struct rogue_mips_state, error_epc) == 4,
-	      "offsetof(struct rogue_mips_state, error_epc) incorrect");
-static_assert(offsetof(struct rogue_mips_state, status_register) == 8,
-	      "offsetof(struct rogue_mips_state, status_register) incorrect");
-static_assert(offsetof(struct rogue_mips_state, cause_register) == 12,
-	      "offsetof(struct rogue_mips_state, cause_register) incorrect");
-static_assert(offsetof(struct rogue_mips_state, bad_register) == 16,
-	      "offsetof(struct rogue_mips_state, bad_register) incorrect");
-static_assert(offsetof(struct rogue_mips_state, epc) == 20,
-	      "offsetof(struct rogue_mips_state, epc) incorrect");
-static_assert(offsetof(struct rogue_mips_state, sp) == 24,
-	      "offsetof(struct rogue_mips_state, sp) incorrect");
-static_assert(offsetof(struct rogue_mips_state, debug) == 28,
-	      "offsetof(struct rogue_mips_state, debug) incorrect");
-static_assert(offsetof(struct rogue_mips_state, depc) == 32,
-	      "offsetof(struct rogue_mips_state, depc) incorrect");
-static_assert(offsetof(struct rogue_mips_state, bad_instr) == 36,
-	      "offsetof(struct rogue_mips_state, bad_instr) incorrect");
-static_assert(offsetof(struct rogue_mips_state, unmapped_address) == 40,
-	      "offsetof(struct rogue_mips_state, unmapped_address) incorrect");
-static_assert(offsetof(struct rogue_mips_state, tlb) == 44,
-	      "offsetof(struct rogue_mips_state, tlb) incorrect");
-static_assert(offsetof(struct rogue_mips_state, remap) == 300,
-	      "offsetof(struct rogue_mips_state, remap) incorrect");
-static_assert(sizeof(struct rogue_mips_state) == 684,
-	      "struct rogue_mips_state is incorrect size");
+OFFSET_CHECK(struct rogue_mips_state, error_state, 0);
+OFFSET_CHECK(struct rogue_mips_state, error_epc, 4);
+OFFSET_CHECK(struct rogue_mips_state, status_register, 8);
+OFFSET_CHECK(struct rogue_mips_state, cause_register, 12);
+OFFSET_CHECK(struct rogue_mips_state, bad_register, 16);
+OFFSET_CHECK(struct rogue_mips_state, epc, 20);
+OFFSET_CHECK(struct rogue_mips_state, sp, 24);
+OFFSET_CHECK(struct rogue_mips_state, debug, 28);
+OFFSET_CHECK(struct rogue_mips_state, depc, 32);
+OFFSET_CHECK(struct rogue_mips_state, bad_instr, 36);
+OFFSET_CHECK(struct rogue_mips_state, unmapped_address, 40);
+OFFSET_CHECK(struct rogue_mips_state, tlb, 44);
+OFFSET_CHECK(struct rogue_mips_state, remap, 300);
+SIZE_CHECK(struct rogue_mips_state, 684);
 
 #endif /* PVR_ROGUE_MIPS_CHECK_H */

-- 
2.43.0

