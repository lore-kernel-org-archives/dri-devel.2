Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C004606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=w5KfxW97
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A1D10F467;
	Tue,  3 Nov 2026 09:01:21 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EFD410E7ED;
 Tue,  3 Nov 2026 09:01:15 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A37b7Mp2376363; Tue, 3 Nov 2026 09:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=EEjtUNdcd2sSgPAdSdYqU3/
 tgwhsnLCn+OYw3hVUQ0s=; b=w5KfxW970BM08tdYFLgVLJLDkh7pcUHLYfX0fJ1
 Vxb6PkF3R5OfU98aagA1luxu7aHVYQMAJNB//Iikc2JUOzbwyH5nnf7740ZH/tRv
 DtCntNlym+OdFWfdhg/jTCFhQmDMog04+Md+4yavu3ihWL4SeY/EKLqQIMF4Hi0P
 FqJyszBWgIqAi57gJJESF0bRBa4Uexz5x2VKpSSQvmSvaNn2wVvW7f1WQnwKgiVk
 rola14Nebiif7rz3K1VgXPE6IJiKLrAkOvPuwmgOtKjcVaELR7E5i1LrivQN1Hjl
 cpKqpQelGmojWGujeqDn6zIM+irpY1BYTPn0qRE9/eeKBEA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99wjacd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2026 09:00:53 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 3 Nov
 2026 09:00:50 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v4 0/5] drm/imagination: RISC-V and META firmware interface
 updates
Date: Tue, 3 Nov 2026 11:00:39 +0200
Message-ID: <20261103-prep-meta-fw-arch-independent-v4-0-513d1c51f458@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALei6WoC/43Oy2rDMBAF0F8xWmeCHrEUd9X/CFnoMYpV8ANJU
 VqC/z1ysmhLF+5m4MLl3LmThDFgIm/NnUQsIYVprOGwa4jt9XhBCK5mwimXjPIjzBFnGDBr8Df
 Q0fYQRocz1jNm8N5JZ53k0lFSjdr24fPpn86vnK7mA21e0bXRh5Sn+PV8oLC199+twoCCEsiY9
 JQzxd/DcMlo93YayDpW+E+u2+J45UznWyc7o3T7lxPfHKNiixOVa6VwRntmlOp+ccuyPABemT5
 NewEAAA==
X-Change-ID: 20261028-prep-meta-fw-arch-independent-ffd6dcd626d0
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793696450; l=3072;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=EAvT9X98qrcT/AXkHxRq+UXNuea3JwYqhvpp981bbhU=;
 b=Plftg2576zgO9LKcPoGw99CtH8S3vvm4LgeSqTrTJC6NiJJfID7oo/JQ85BAN/pyoX85vWKDQ
 d+XE6v904DdCm6zHTR2P2JTwxqXXRtW6isFFmLbhpsckDVwtZRfUBXS
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfXyZPBmV/7nhun
 mgoPuSNmFDAphM5qkOnnRd5q/rUxzwRRSuel9+CZNWaLfmBNPs28sKBZ6YeyYmbEZRRdxTSnoSw
 98irXpUI8NsdofJBoh6DVAzJm8alC8E232k2FTfgIkmJvhE91NrbSa3HMeT92O7m99wSq4USAbW
 NQtoVG+TlMYSiXWZLHgU9/XIzaUlvRd7eXWiRzNQiTLYIN7KoNJDxG47jeNoabZ+zFWxnOk3KRM
 MFNYAn/tT4WPlnvkw4ZED0kWGFncFGNRaPp16tWZybDK3wp19pI4qhMl+lCYFBDJA0XB0vBNx+m
 B+pHgxojmunYGDouBh+JlUQ9fx1+ruWBvmf9rc5aeA0ilmE88hzpHYZGr7nvACvFuLG201K6Y2x
 CV+UJULLvdQXIcTNwR9bFgfI5/Lmr1iwGIRi6KmRnneaxbHNK2ArkQybA6VQk8sbyDrX3dInT8r
 UzFnqttqmOfjo5eY3Wg==
X-Proofpoint-ORIG-GUID: 6BLIsESPGfzmXiIl2_dzCD2CLo1DpQGp
X-Proofpoint-GUID: 6BLIsESPGfzmXiIl2_dzCD2CLo1DpQGp
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6ae9a2c5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8
 a=37_Hhy9oBCt8YZBu8RgA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX0YPJPi5hUw63
 8ZPJQgvc8qm+i7CzZI/fZfzLQlW1wd6vQGap3MYw/GS3LRtVeTATwUNTA5LiO4ClmrBYRBcP302
 WKFrOkyaRja+YHi+MwQCR8+asgtyVMo=
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

Refactor RISC-V and META firmware interface headers to have a more
generic and architecture independent approach:
1. Limits access to the RISC-V and META firmware respective interfaces.
2. Aligns RISC-V and META firmware headers with the other processor
headers.
3. Add "_fw_" component to the headers filename.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v4:
- Fixed a bug introduced by the previous update to layout_is_mars().
- Link to v3: https://patch.msgid.link/20261103-prep-meta-fw-arch-independent-v3-0-563dbaf1b779@imgtec.com

Changes in v3:
- Fixed remarks raised by Sashiko in pvr_fw_startstop.c.
- Link to v2: https://patch.msgid.link/20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com

Changes in v2:
- Update the commit messages to better describe the changes.
- Link to v1: https://patch.msgid.link/20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com

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
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-riscv@lists.infradead.org

---
Alessio Belle (4):
      drm/imagination: Limit access to the RISC-V firmware interface
      drm/imagination: Make the RISC-V firmware header arch-independent
      drm/imagination: Limit access to the META firmware interface
      drm/imagination: Make the META firmware header arch-independent

Alexandru Dadu (1):
      drm/imagination: Prepare heap config header for multi-arch support

 drivers/gpu/drm/imagination/pvr_fw.c               |   7 +-
 drivers/gpu/drm/imagination/pvr_fw.h               |  26 +++
 drivers/gpu/drm/imagination/pvr_fw_meta.c          | 104 +++++++-----
 drivers/gpu/drm/imagination/pvr_fw_meta.h          |  14 --
 .../{pvr_rogue_meta.h => pvr_fw_meta_internal.h}   | 175 +++++++++++----------
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |   1 +
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |  13 +-
 .../gpu/drm/imagination/pvr_fw_riscv_internal.h    |  43 +++++
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     |  61 +++----
 drivers/gpu/drm/imagination/pvr_gem.h              |   3 +-
 .../{pvr_rogue_heap_config.h => pvr_heap_config.h} |  26 +--
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h      |  39 -----
 drivers/gpu/drm/imagination/pvr_vm.c               |  18 +--
 13 files changed, 289 insertions(+), 241 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261028-prep-meta-fw-arch-independent-ffd6dcd626d0

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

