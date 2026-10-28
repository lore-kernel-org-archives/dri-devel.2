Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A1606A31F
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=jn9xmHTd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B47610FC67;
	Wed, 28 Oct 2026 13:30:24 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1B7C10E63F;
 Wed, 28 Oct 2026 13:30:17 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBfEn54125979; Wed, 28 Oct 2026 13:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=VJ/6NMjArldnd2LrCTUeK9F
 OgABgG5tf4SqsaACiUZM=; b=jn9xmHTdodrRwEm3EqLIXcf9SGpTeI//KJRFg2F
 yVgL9K68YldWykOAGUbCS1C1drwNL2ujmz26mQFqhXFB6lcl3+t27t9pCueG2i7i
 ZFRw/Zs7OitBV0+oTFmbQ0ipgfijxie2Yu8LtbKDeldHx+pqGNgUVQ291f1CIFNM
 OvXaQC2OZUqJAa1RmME0XAHvhw2X5TOblhRpDBBNOMUshESWMj8Kteu5LlSQhmPz
 eFHjufKyweAMno9k9sDI/WvctMJZGWicZpWYodQ3YKB5e0WIQyJ50GbxgyxG3xvH
 f4/QLmNmpa/CJPtaroTtjQmcNeNikFo4iiS3PENPaqbKTCQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hk414ghyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 13:30:05 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 13:30:03 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH 0/5] drm/imagination: RISC-V and META firmware interface
 updates
Date: Wed, 28 Oct 2026 15:29:32 +0200
Message-ID: <20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL344WoC/yXMSwoCMRCE4asMvbYhk0UQryIuYrritGAMSXzAM
 He31U3BB8W/UkdTdDpMKzU8teu9GObdRGmJ5QJWMZN3PszO77k2VL5hRM4vji0trEVQYVMG5yx
 BkgQfxJE17J31/esfT3/3x/mKNL5R2rYPFq82D4EAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793194203; l=1843;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=r3LQlFHpmdFnfQSRY534xyHfTuQ82MkeXdcVGI+ap8c=;
 b=nboDUwGV0y4I5xZveKaifiwwVLlaND7fRP/Xa9fZRf4TOa9tM1ggq9lEKGfGREOfro767VntG
 ajpQlRAeQAnCELkQ3zIjKaFGrlKnFSOxZiAZnu1mH/UCA/nvMVkQvKy
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MyBTYWx0ZWRfX/+7RNtA7+LV9
 O51yS2ySSAT0vu5KmLdY19hKFgZ1DGRZc83F/ksRLCUqGPzgklJ0RCViy/4Q4WC6J49ozM0fFJx
 HdTL3OGlwfSMn9NgfSpap1UWHro3p18=
X-Authority-Analysis: v=2.4 cv=AMk9Hd7f c=1 sm=1 tr=0 ts=6ae1f8dd cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=qumoa_GKI_aNSdBMfk0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 2rBl2Mtw_qRvhM9LRCPFgDQ9pEQi_yf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MyBTYWx0ZWRfX8o9jhNjAS1kC
 WU1Dz0UP4Y8ilnUE+j0HalMuglBrTq64Xw8cqQqftEKdrP/dWQpZkbVW/fUpqVvqcfCs4fmWXBT
 xFE3PHtuprBJpuSYnwKSVOCqEOkUDHyHCe84/DjIvskki1Z8RIBmu3brfk4VVXE0ne3azPsMRCf
 fZi7qDFBTt9zZtE4OxXkwPHv3QrizyLb9hfZIfoaa3F5nTsdu/7KZvL15I0FCNvpUUarnSYFJPx
 Qp7EdsHIyK926PjimrjT84SjBPUTiZd34trSfGsgPOch1q076Vhn1BwINgJKYcbYnSxH1FRPvOZ
 QVhraKlCL45R1cQ9AH1z7aF27VOMVqzEPqBO4BNgCjHSmzIDZ5Su1fUGJXyoP/S81Q/iM9rILwA
 jj+FgpFNJFQShO/5MTyr2FB0ZQ6kPLf6cKOHz3IQgm+nfPv/CnR+RlTyJo4TY3uh58sFgzJlMZw
 KO89I7SsXTP6ig3+PnA==
X-Proofpoint-GUID: 2rBl2Mtw_qRvhM9LRCPFgDQ9pEQi_yf8
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
Alessio Belle (4):
      drm/imagination: Limit access to the RISC-V firmware interface
      drm/imagination: Update RISC-V firmware header
      drm/imagination: Limit access to the META firmware interface
      drm/imagination: Update the META firmware header

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
 ...vr_rogue_riscv.h => pvr_rogue_riscv_internal.h} |  10 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |  18 +--
 13 files changed, 296 insertions(+), 205 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261028-prep-meta-fw-arch-independent-ffd6dcd626d0

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

