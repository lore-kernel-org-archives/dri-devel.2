Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86EF606A331
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=cmbi+LUo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF79A10FFA6;
	Thu, 29 Oct 2026 06:30:05 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC3A10FF87;
 Thu, 29 Oct 2026 06:29:53 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T652Wo3047993; Thu, 29 Oct 2026 06:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=a
 Iu6pEYpp53YfCiyYllM4lyrdWdbqBwyNFhZJ0QDrzY=; b=cmbi+LUoVo4M/bGzH
 7KDh+r0iDfyb0mrZtwYeKUnD4daHzlTXyaGcGpkoGgqG0Vq6ei+qxMpsy7zff/Lm
 Bgyt6S1eVMvmyr45801deH6BmxTudFnsaErg3b95K7sc8PT77SIJiKTBhAZ7kbfM
 m0NGQwrRh0C4BBbF8ewTIGTZZCebjzwr/ebEymJ358qZjAktnMcn7dke1tn1IS1j
 cgZEKJReNCNGiVd/Fi3zPlgI3ZYjqAMzp7ehqtmsoaPiUiX6dN9ldRfknwbn7R5W
 FPxhWeD97WnXlgo5nXVIo0KnqiidQaB0Q3S2myPOX4rKP3O0t3Tus2jWoE4zvJI0
 0sKdg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hkvd104j5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 06:29:45 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 06:29:43 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 29 Oct 2026 08:29:23 +0200
Subject: [PATCH v2 2/5] drm/imagination: Limit access to the RISC-V
 firmware interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-prep-meta-fw-arch-independent-v2-2-b9f5d69b7a52@imgtec.com>
References: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
In-Reply-To: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793255380; l=2210;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=wDgtp6LBF/C29pe2CVlQTKRn+Z/Fia+UZ37qNopawhs=;
 b=kMg3kwpjYK1km+18ZUvxtumAzByHKPXp6geVoC9DdWhc56ZmbL4s/BK5sHeq82KSqfbpCIq/a
 hNYeL4f7PXTDxDmJ/XPvsNWpFk1yYm17E1NtRHqTdikafsGyulPCZrJ
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX2tH/6toKLhSQ
 s5tjFYaIZy6XvRkBXkx+iZSe638T4N98s9IAdWUA1yy8UOGjr14u1/SmUIfXkyfEurPdGpFXDJ8
 YYyKZTo/Cu6Jggrj+X2RFFXvQ05LnSf7ZbtWpMGBJiDpaHuy/Atl1JiGWZ32jVsmAz2TCb92m45
 XuJNskETMr8m16ygYoh+puwYMzmuCHjJB+DH2ERGaWhOd9AIE0fAghFemNYxcDnl3nOSku02E3k
 PoKzC0qFDKipCuG0zESKE8WrqaabTknzDuXqV0wGt0Ns14WmTSoQXK6FnjojHS2m8Jyok0558/U
 djLbpe6WhkaXErYJlDMK8c1Hf/Jdj0EtGcMTu59179WCsZXcCjuOmzKbU8Odk868kCCmXuaIAIQ
 fRXcy00dxddkIPrFUYEitUFs0yT+DNFuYEZW49FnoENrnLCl1zps288V60d+vYKG0HDah2KTQvQ
 hZ8hlUf3ImH99vLuvMA==
X-Proofpoint-ORIG-GUID: yEf20eRPpt4aYxaISRQTbb1J8Sxk0l9G
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6ae2e7d9 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=xwwprR_ITuhyIuDbuUkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: yEf20eRPpt4aYxaISRQTbb1J8Sxk0l9G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXwnx4guI8eMZz
 D5G3QQVaca8wDv/LnF5u9xrpbVT+2L6BKIy1PQLWJAmRqTAvQEXQTRoAetISlo6h3x+lLQ0Lor4
 Ljpu6C9MTWgNif3oWIEpzw1LewCKkXM=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alessio Belle <alessio.belle@imgtec.com>

- Rename the RISC-V firmware processor header adding an "internal"
  suffix.
- Add guard to the RISC-V firmware processor header to prevent
  accidental inclusion outside of the RISC-V firmware specific logic.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_riscv.c                     |  4 +++-
 .../{pvr_rogue_riscv.h => pvr_rogue_riscv_internal.h}          | 10 +++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index cd84635bb88d..0d4dd45520a9 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -7,7 +7,9 @@
 #include "pvr_fw_mips.h"
 #include "pvr_gem.h"
 #include "pvr_rogue_cr_defs.h"
-#include "pvr_rogue_riscv.h"
+#define PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_rogue_riscv_internal.h"
+#undef PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm.h"
 
 #include <linux/compiler.h>
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_riscv.h b/drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h
similarity index 81%
rename from drivers/gpu/drm/imagination/pvr_rogue_riscv.h
rename to drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h
index d971729e18a4..ba18c2a82205 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_riscv.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_riscv_internal.h
@@ -1,8 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /* Copyright (c) 2024 Imagination Technologies Ltd. */
 
-#ifndef PVR_ROGUE_RISCV_H
-#define PVR_ROGUE_RISCV_H
+#ifndef PVR_ROGUE_RISCV_INTERNAL_H
+#define PVR_ROGUE_RISCV_INTERNAL_H
+
+#ifndef PVR_ROGUE_RISCV_INTERNAL_H_EXPLICIT_INCLUDE
+#error This file may only be included if explicitly defined
+#endif
 
 #include "pvr_rogue_cr_defs.h"
 
@@ -36,4 +40,4 @@ enum rogue_riscvfw_region {
 
 #define ROGUE_RISCVFW_REGION_BASE(r) ((u32)(ROGUE_RISCV_REGION_##r) << ROGUE_RISCVFW_REGION_SHIFT)
 
-#endif /* PVR_ROGUE_RISCV_H */
+#endif /* PVR_ROGUE_RISCV_INTERNAL_H */

-- 
2.43.0

