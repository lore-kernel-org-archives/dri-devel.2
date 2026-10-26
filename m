Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EAC606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=RIt6sqRp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097EA10EFB9;
	Mon, 26 Oct 2026 12:49:43 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23CB610EF60;
 Mon, 26 Oct 2026 12:49:35 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QAso3W019260; Mon, 26 Oct 2026 12:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Z+YZ8BqpmlXiYIhL7M6oAlN
 a0NaTmE0SgzxsEse2KJs=; b=RIt6sqRp1U6JjVDqqSnFpg2h9oRTQGT4Yv1qysr
 hThZGkzRLHwpZkMFjyo3I1UtZfpYrLJU7BKXUzQbTFGkvyeWiDI1/182G7mRqKRE
 MEPjOBqZVvb25pnBZCLD4QRoVzOsXGagQp0LGcOcNb3SRq7KscX9f/jTGtTBZtvb
 5t7G/B5A0TlAsYeduuATN+D4j9RRYVdCSuc87kS9lKzyfIcxlNoktEvxBoEHyWN8
 jgeYAJQLGunxHfJbFJDF5HyHBwhMGZRjq2IyShPEX6HUT+O0Qst2BeW6mApJYhWZ
 ifwb3G5PIDNhAJhiQOEfV5xgJsuF3RVNxor8EunWJonT73Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hgjxpsha5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 12:49:17 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 26 Oct
 2026 12:49:15 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v3 0/4] drm/imagination: Clean up MIPS firmware interfaces
Date: Mon, 26 Oct 2026 14:48:32 +0200
Message-ID: <20261026-b4-simplify-mips-pte-defs-v3-0-587087d8a284@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACBM32oC/42NQQ6CMBBFr0K6tqYdGjSuvIdxQdspjBFoWmwkh
 LtbcKMb4/Jl/rw3s4iBMLJTMbOAiSINfYZyVzDT1n2DnGxmBgIqKaTiWvFInb+Tm3hHPnI/Irf
 oIkfQKF0lSysVy/8+oKPn5r5c3xwf+oZmXIXroqU4DmHa4kmuu386SXKRz7U9aF0dEeBMXTOi2
 ZuhY2sowYcK4JcKsgoRlAAjylrpL9WyLC+8pXQuIAEAAA==
X-Change-ID: 20261014-b4-simplify-mips-pte-defs-e2be1f613d14
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Alexandru Dadu
 <alexandru.dadu@imgtec.com>, Matt Coster <opensource@mtcoster.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793018955; l=2660;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=CL9humsYKTm7GpHS5ecLsfJESRZlSxqLnISaI+EKi3k=;
 b=PD3DqXJUIjpm19vwt1KBvhq02ghJacIlxTY1dtKyCQaSRoQi8gRQKirx4YAxrK9j09QefMSYP
 J9xR+k74rUhCaT2nqFWpvz5DJcbqSAXQ8cFj8p1bxdIGt8/I1oNysgU
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-ORIG-GUID: E_oVqL803MB9HfSf6Zf6c3B3h4VFp8CQ
X-Authority-Analysis: v=2.4 cv=XvhvqlF9 c=1 sm=1 tr=0 ts=6adf4c4d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=gXtLJ4WPg2CJrXxS_-4A:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
 a=2TKV-7w1aU1AVAwN0oqT:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1MCBTYWx0ZWRfX5B6J9EmBe7l4
 NeGFYIFh39yNiSZE1C9xSGrgF4WPBRHcXn2B0L1xG/MGQNV1NhWnnRH9yalfmm12X5dGT7rf7ff
 ZInxq1uq2+U7Y2VlfulKo5yp78RrKWiIkKXodLglBv24ctRZ/GhBg9PoXqKJ2TB7u4PqePkrg6/
 GxgQuPYQoSqFVRmL98ULyoVpZ/MmIfuj+E2BGRm27w2b62KzpWJKqtcgQV+J34o9Ssiv4+VK8Yb
 JTZhpzb5FpxU5rFKSdinypvXcRuDpqCskiJSkTaetmGkBK0ChKdEM0UQHWOmaafbVR7TmwYKkVe
 2tGkGx3KGcoLCZ2zdqajZ+ztZF5/gacxhuuA6xDUPO3nXhN60VDGzcQiomHyElHbiNkxq3/j3GB
 RkGbkm9uEflzwnhxtM57p70vY1Wau75bx8GOfwj5jBrfdfFT1+mnBKtyYLL351tDLc8fjP1CKpC
 lH3TCv56nnsBRkvikrQ==
X-Proofpoint-GUID: E_oVqL803MB9HfSf6Zf6c3B3h4VFp8CQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1MCBTYWx0ZWRfX54aY51hLUumC
 pcr+fGNPrjx0PAE1MEpNUcdaAoFl4b+CEEvAFOTrx3PrjaGrntCIdJH7gkQBHopWpMFBm5jNwAz
 FPn6XNZkkpum3OUpi0mQhu/KDl2e6Ug=
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

1. Limits access to the MIPS firmware interface, keeping its state
   within the relevant implementation.
2. Align MIPS firmware headers with the other processor headers and add
   "_fw_" component to the headers filename.
3. Improved logging in error paths.
4. Simplify MIPS PTE definitions.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v3:
- Squash a commit that ads "_fw_" component to the MIPS firmware headers filename. 
- Link to v2: https://patch.msgid.link/20261022-b4-simplify-mips-pte-defs-v2-0-ee2402c03a4b@imgtec.com

Changes in v2:
- propagate the commit update to PVR_MIPSFW_TLB_GET_PA().
- removed the RISC-V group from the target group of this update.
- Link to v1: https://patch.msgid.link/20261014-b4-simplify-mips-pte-defs-v1-0-b4ad7bb68e22@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org

---
Alessio Belle (2):
      drm/imagination: Limit access to the MIPS firmware interface
      drm/imagination: Update the MIPS firmware headers

Matt Coster (2):
      drm/imagination: Improve some logging in error paths
      drm/imagination: Simplify MIPS PTE definitions

 drivers/gpu/drm/imagination/pvr_fw.c               |   6 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |  11 +-
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |  79 +++--
 drivers/gpu/drm/imagination/pvr_fw_mips.h          |  49 ---
 drivers/gpu/drm/imagination/pvr_fw_mips_internal.h | 309 +++++++++++++++++++
 .../drm/imagination/pvr_fw_mips_internal_check.h   |  35 +++
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |   1 -
 drivers/gpu/drm/imagination/pvr_rogue_mips.h       | 335 ---------------------
 drivers/gpu/drm/imagination/pvr_rogue_mips_check.h |  35 ---
 drivers/gpu/drm/imagination/pvr_vm_mips.c          | 162 +++++++---
 drivers/gpu/drm/imagination/pvr_vm_mips.h          |   2 +
 11 files changed, 519 insertions(+), 505 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261014-b4-simplify-mips-pte-defs-e2be1f613d14

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

