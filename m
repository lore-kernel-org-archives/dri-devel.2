Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D7606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=CR9VczUV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86D410E40C;
	Thu, 29 Oct 2026 06:29:58 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7169710E40C;
 Thu, 29 Oct 2026 06:29:53 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5nLs13019385; Thu, 29 Oct 2026 06:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=uuEVDIgbZf0bSssQ8k9hdal
 jgY8GdwL+ca2pghb6P4U=; b=CR9VczUV3/TJkeYuKMronC0utGzyGnsRt78RNoC
 6IRmeGHugvoAUUSYnNEJH+PI/K7mbcESeRhLTy7UnwtBBMq/1EAiRZBNzwmrbQFx
 Q0TUDq9/YDdMNJTHlQLRu7GD9GBSCyNkzTvKEMGlGtuzj9iwzF4TcR7xJj4r9KS9
 uQ44iB1FJRiJEbWALshqQCffmS+1cJhxRvOa0+U9cXsOPgY85viMCH99FwR/WKFy
 ia/mBwjIbolXvQc1KqtHPdD8LBoZeyKmWPB1/M06h3Mkf9ttcgHKheILiclB688l
 fDrxxF33bsxAhcK0j6iANXs/bTUfSvNpd0u73N6n18qQ32w==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hkvd104j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 06:29:42 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 06:29:41 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v2 0/5] drm/imagination: RISC-V and META firmware interface
 updates
Date: Thu, 29 Oct 2026 08:29:21 +0200
Message-ID: <20261029-prep-meta-fw-arch-independent-v2-0-b9f5d69b7a52@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLn4moC/42OQQrCMBBFr1Jm7UgyQiquvId0UZNJO0LTksSql
 N7dtF7AzcCDx/uzQOIonOBSLRB5liRjKECHCmzfho5RXGEgRUYrOuMUecKBc4v+hW20PUpwPHE
 5IaP3zjjrDBmnoDSK7eW992/Nj9Pz/mCbt+hm9JLyGD/7A7PevH+3Zo0K6xNrbbwiXdNVhi6zP
 dpxgGZd1y+a6NZ/3QAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793255380; l=2736;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=QH2paCe+vB1bSUQgP4/pJ/+jbIK3RY1rt4Lb0CassCI=;
 b=8wBqxmSHfr6uk/zDVuHay9Xyrio2xrCmE0LX0zfcuwD7MV0raJgr/vsRyj6k4B8n9Jg58n+e7
 VxjawpOnWh7ASkwpKXwvteUH/lC/3hxuPzktwAcjjBs7lPectw/Wjst
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfX5cQkNusAN8PG
 KYtLDLtHEt6JSovsQrrsikkk2MWP3/BbLwO0f76R6arp+YHSKCTC9YGe76WQBiQp4QxjxlA6OjY
 aVaxYJ9WRhzskOPK/+27MmuvnJqw5HpShu3zIdgDETArW72CzBJf8vWWmgOs+1DdwfltEDhZKlp
 A4T24gdIXH4EtYHCb2OKvRkUpEcjj91UWpdZOwXkkEBDJVSskbzNIjyoGu/x+/c1wE534yvO3vO
 oiMNhztE90LMckwjFfUZLlvgXcgaDo9QSNMfJrusLUzEteniAunwN1z+qMDvb2WQr5FSbNVTnCN
 MnAhEiA4n+pk2AeohzbVpuet9qMSn6wdUY0KcJGtsdc7kIoNBg0oabuQjikaNcFe7QGtnDDFhrG
 j//6YszA+hGpdpZ+VVvsZDhACbCToX9Z7TpEDkWSSBR84R9PJJZ2vJY0jvx7eMV3sBQhG0brPQB
 w9TbJYMTJzath9gIDnA==
X-Proofpoint-ORIG-GUID: r1C44_Jg5H93K0Em3-8lPogMQfSqTPgO
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6ae2e7d6 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=_O3DOGVWAAAA:8 a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8
 a=gXtLJ4WPg2CJrXxS_-4A:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: r1C44_Jg5H93K0Em3-8lPogMQfSqTPgO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXxlR3boUk1t0h
 l4b6/vExm0E7rj7MKkuEYUrDp2MB2XljKCdtAJAAMU3QSh84AW/LVDBSscolYrZF31qtJxptKMm
 VZ3uHgJiDK0oK33zuH3ozD7Zz5Znr6A=
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
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
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
 ...vr_rogue_riscv.h => pvr_rogue_riscv_internal.h} |  10 +-
 drivers/gpu/drm/imagination/pvr_vm.c               |  18 +--
 13 files changed, 296 insertions(+), 205 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261028-prep-meta-fw-arch-independent-ffd6dcd626d0

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

