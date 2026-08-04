Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C68C55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2F610EAE0;
	Tue,  4 Aug 2026 15:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="kHdgtYOD";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE4E10EAE0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 15:19:04 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674CWqh93771746; Tue, 4 Aug 2026 16:18:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=E1r/MsEWyEvPDk55TEeT7qu
 Btsz4GUZAIhXlo9MuxV0=; b=kHdgtYODzLTc4i1UFbyZCgnxpqxajw58UiDTNGu
 PxWTJ/M1d/OeJdIaO44lsO+6MlgwJ2eQgJnebmKVFAWdHw5uvuSc+hGmcJNq3FDo
 G0B+5hg2u8TNarqFf6ynVPUpw8P31M/kkr4hbZb+BsfKWyMi3cfqSKrKE1IOwI1K
 3K8kpVg1OBw1nPN64ksrfp4TXX4eyDIaRrMZ5AUAGkC6DotBUk36qnhu8kuxxSBF
 EDoi2+4eOIS4F9MbzjyTwTBQhrznEgMpQOFT33RKPcNweWeErb9hnp6COgfHkyl0
 t3rn0Jo73Pkb350Yv+ZTbx9LFb+yJU4xrb6JZGZLWi0tKFw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4fs72pth1w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:18:51 +0100 (BST)
Received: from [127.0.1.1] (172.25.4.227) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 16:18:50 +0100
From: Luigi Santivetti <luigi.santivetti@imgtec.com>
Subject: [PATCH v2 0/3] drm/imagination: small series of fixes for the pvr
 documentation
Date: Tue, 4 Aug 2026 16:18:26 +0100
Message-ID: <20260804-staging-pvr-docs-fixes-v2-0-a5a9569a1c1d@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMICcmoC/4WNQQ6CMBBFr0K6dkxbDaAr7mFYlDKUMYGSTm00h
 Ltb8AAuX/5//6+CMRCyuBerCJiIyc8Z9KkQdjSzQ6A+s9BSl7KWF+BoHM0OlhSg95ZhoDcylDj
 Ug6lqc0MpsrwEPILsPtof86t7oo372t4YiaMPn+M5qb339yQpkCB7qa626nRZqYYmF9GerZ9Eu
 23bF9IvD6HPAAAA
X-Change-ID: 20260803-staging-pvr-docs-fixes-6ef8fa78a9e0
To: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
CC: Alexandru Dadu <alexandru.dadu@imgtec.com>, Robert Mazur
 <Robert.Mazur@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Matt Coster <matt.coster@imgtec.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785856730; l=1143;
 i=luigi.santivetti@imgtec.com; s=20260707; h=from:subject:message-id;
 bh=i6g6oyMdHeuRJR8hJpoovqydlwj6ZB6UrEg5gDcBLq4=;
 b=yD+9qkLa6vuk5HYl+Wyjn/jvsJ/IrxT7VlJ17gec6TYmUqbEo+OJ1Cu4sdGip37BFMa1+ZwOC
 Gskaf+NnJQ/AVEGHtZUMQK0C+vlARBLursKjFwuQyVjv5VrAUtu2+oH
X-Developer-Key: i=luigi.santivetti@imgtec.com; a=ed25519;
 pk=jS7sCDyWFMopn8iAXVN+AdJi+Z3fZPQKsS5NdQtI+sc=
X-Originating-IP: [172.25.4.227]
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX3xJnGbmoygRc
 bAWcFnn277v+M+ytXHrC+2H5PD6ZkNnvsjDh8YXerq62LZ7MLbGG+Qo2bvfuwg4tOREkxqSqB6t
 TUMx7IHaH3+yA7O3luvyUzyEuSq1mtY=
X-Proofpoint-ORIG-GUID: rGg8SLh-mwGEKMPZbOsuMWv_08p1k03x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX/UGYMWbzVZRK
 BHwPHPxe2PVFGTY1EhfGePdZhHoNOmuweKF/7apjLfcjk/q1CeiKwy81LngDt8CqPMel7cz11AI
 OXqhSP+BjKg6NeOzj/y73bMT7eks38lTekv2dXoi+QPhrMkC4D+w//iQdbQUgBHqGsj9LopeZJY
 8SmjpuczYYjavPyYa2T1E3hgtiqq2PnlKPeLnGS5kNJaCWZCM2qWF2mjMy27DHhoHYQHVdYSriW
 Ko0J7YZciUsvdVLtWysxR2gImsgLjQu8cGwhSgbQsZMMtC8MyRne/9fHKcKqZtvy5+Q79yaMoYz
 mFajuxY1jW3E4TsbasvC3BhVrRy2lGUo70LBnrxNe0AJfoMQoPM9O3WxWyceTHWg6RX0VYzXu6a
 E4Lc05/47KGwY+oyA7sM1rwCUclwm7sJZu/8cXqX4R248KzljuiWJISokHP8UICUbCvnGK78DX+
 dbe/c41je1jS5DvABsg==
X-Authority-Analysis: v=2.4 cv=auyCzyZV c=1 sm=1 tr=0 ts=6a7202db cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=eoBRZU4O7WcA:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=kVK--sJ9_GsM1Ll5LJAA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: rGg8SLh-mwGEKMPZbOsuMWv_08p1k03x
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

Small collection of fixes for out of date and incorrect comments
documenting pvr code.

Signed-off-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
---
Changes in v2:
- [PATCH 1/3], edit commit message.
- [PATCH 1/3], add new line to fix warning in kernel-doc.
- [PATCH 1/3], add Reviewed-by Alessio.
- [PATCH 2/3], add Reviewed-by Alessio.
- Link to v1: https://patch.msgid.link/20260803-staging-pvr-docs-fixes-v1-0-0d014c7b2671@imgtec.com

---
Alessio Belle (1):
      drm/imagination: Fix repeated typo in KCCB documentation

Alexandru Dadu (1):
      drm/imagination: Update Rogue heap comments

Matt Coster (1):
      drm/imagination: fixup some docs in pvr_gem.h

 drivers/gpu/drm/imagination/pvr_ccb.c               |  6 +++---
 drivers/gpu/drm/imagination/pvr_gem.h               | 12 ++++--------
 drivers/gpu/drm/imagination/pvr_rogue_heap_config.h | 10 +++++-----
 3 files changed, 12 insertions(+), 16 deletions(-)
---
base-commit: d6c075f797a672a6e3bd2fd44aee713801698ec2
change-id: 20260803-staging-pvr-docs-fixes-6ef8fa78a9e0

Best regards,
--  
Luigi Santivetti <luigi.santivetti@imgtec.com>

