Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18B8C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536CE10E720;
	Mon, 10 Aug 2026 08:36:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="lsaREowe";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A684A10E720;
 Mon, 10 Aug 2026 08:36:02 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A67ewK1670335; Mon, 10 Aug 2026 09:35:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=kapczULRL63Qtygo2fq/UX/
 +AwSNTQtF42aCFbD/j0w=; b=lsaREoweBQP4IRP9J92I4bG+sYRIVrE3OZ3EO1O
 lCkXbimF140MZX4WhqpwblK1cODLLaxH7SCQ7sBEnRQUqyoxGo6leRF7LehULve1
 aH5PrVhpql2lz9L6kY9/yH2eAu/YOJSHsfECU5SGrKCmuhCq6vaniBjTcvcczIK9
 7+hvE87+uhVKau5fjrN2L/pO5qWZNOGYSZxn6sndjn6s1w4emNnbCJybupKAnR8g
 5jlfhdBXNfxjldZ/QEwR2eVcTZVyM/niiUaDFWBXvOz3TQRiPTNqPhkwbfaI7UCr
 KGFKvh4ySKekishdxIRWfbROyYSxVj7aXOyNldM1WtVYIdg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fwvhtsfxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 09:35:45 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 09:35:43 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v2 0/2] Unify repeated register definitions and move FWCORE
 macros
Date: Mon, 10 Aug 2026 11:35:18 +0300
Message-ID: <20260810-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v2-0-991ae813fd88@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEaNeWoC/52OTQ6CMBSEr0K69pkCQtGV9zAs+vMKNSklbakSw
 t0FjBdwN18ymW8WEtAbDOSWLcRjMsG4YYPilBHZ86FDMGpjUtCipg2tQVxgGoyeweOIPKLaQgc
 KdQA+KLAuIeiXdB7BculdAFYyTanCRuiabLujR23eh/PRfjlM4oky7qK90ZsQnZ+PUynfez8/+
 8OfcqBQsqqgjRaiYte7sV1EeZbOknZd1w/0YGnuBQEAAA==
X-Change-ID: 20260806-b4-unify-repeated-reg-defs-and-move-fwcore-macros-737f00de8bf6
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786350943; l=1113;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=zlddPQ37jcuxRogEY5BiIsYD8uhHzWOJa3nVJ4pbMaQ=;
 b=n0HE9MTDaq40TbQJtuWXIHykmML6Gq/mU8MzZ00hK0xkjcfDgEsEV2ys1O80D/45v9kcVcVdg
 +G0KSbYavFTDP3ZCcoUVtVSlnQ9ltQp50V5RkIAAshVd0+/+SjSGEZK
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-GUID: PHmt_PR-2R16u2r3gXMfdigF7sgW2FPs
X-Proofpoint-ORIG-GUID: PHmt_PR-2R16u2r3gXMfdigF7sgW2FPs
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a798d61 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=ddMnfZDnR2p7o3-TKO4A:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3MyBTYWx0ZWRfXz+7FCBwMgWCf
 mEXknzjjnyDgGkqcSownFDoVJQ4IOcRDdUGC2HtEJGC9ygljyyvpde2EvTbdgz/3GE62l2rpSxE
 w1MieqKI3TsWu64H8lfjlmxASm22RepFFdyhOtPdopK1viDF3JsSpZPEZswRAxAXFMip3He0ajR
 RMczyrtFt+SmXMOhn1SOE3AjucLzJdvN8p0XBtWjat5TEUtWurCmYxEpK/xUTCoy1qsi3NiucuA
 8hPMWVVYnRVCxucFva5iDZKEFKMY+sNOKEksIZnlxGLOxJjXhltsS/09uax+7AJUKydKSyL6JzS
 6k8wQpAR49BagbvLSCMl2Ba3eHH86vnf2SaFiTgQBHHo15Pe/ATUmcLq8afx0DHExLS6Puwoc8Y
 LvPEXXCk5ORwNl6ZMm7wQSmND8WVPUmU1bo9CGCYrBypWxd33fIitePIY9T1b90Tvf4/2Bv7UKa
 uHWt04J/sjded8wLEaA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3MyBTYWx0ZWRfXwHHWmLHYiYQI
 gD8gY5S+DxPh1kjIzywKvhqj0GS2uJiVx9sq8UHkgJ8/tcTkmF1/rtKO0myt5uTAhiihI7j1OZr
 BAFeLtRZ+b0ueejkwgizZU9XYsCQw9M=
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

Refactor repeated register definitions into base/offset pair.
Move FWCORE_* macros to pvr_rogue_cr_defs.h.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v2:
- Commit description update for the 2nd commit of the series. 
- Link to v1: https://patch.msgid.link/20260807-b4-unify-repeated-reg-defs-and-move-fwcore-macros-v1-0-375208fbb579@imgtec.com

---
Matt Coster (2):
      drm/imagination: Unify repeated register defines
      drm/imagination: Move FWCORE_* macros to register defines

 drivers/gpu/drm/imagination/pvr_fw_riscv.c      |  28 +-
 drivers/gpu/drm/imagination/pvr_fw_startstop.c  |  24 +-
 drivers/gpu/drm/imagination/pvr_rogue_cr_defs.h | 920 ++++--------------------
 drivers/gpu/drm/imagination/pvr_rogue_defs.h    |  22 +-
 drivers/gpu/drm/imagination/pvr_rogue_riscv.h   |   2 -
 5 files changed, 155 insertions(+), 841 deletions(-)
---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260806-b4-unify-repeated-reg-defs-and-move-fwcore-macros-737f00de8bf6

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

