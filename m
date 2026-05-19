Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9FCD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4390710EB20;
	Tue, 19 May 2026 08:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Qb9L4lJu";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F091510EB10
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:25:44 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5ER2J3731043; Tue, 19 May 2026 09:25:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=89b/WQgZPVipu8YV+3W1Dmg
 Bv96Ad0nCnlwR/sNytzk=; b=Qb9L4lJuxfO/ciBZTm9tEiY8uW6bg7+IZbqLOcP
 DX1jebI4zoyPU4xQTO7be1kz3kViTcWToNZCWqdgPnDogTz2vaME4j/MylQMqOgk
 IVmcJUGALsPMesoYWdAmafyoPLJB92QtzkqaBHSL6NTnSm6qxi90fxXdG5kPkeQv
 TAlZP+O42X5DBBEA8epkDB9BJTQC4gk1z1vQcMdDGSEYlTLmsaLollvMO3f6uPn7
 3wexmr4yFFctI3SjJxXMF+8WwXZ0P+U6WoOpH2iqgMhq0Sj1paaTECu+Ta6F3AJV
 Z3M2TQBqH6GVxgW3NMZLllbCI/TtCkd2LqgIZP0nVKGo0DA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e6eup26qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:25:35 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:25:32 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v2 0/4] drm/imagination: Multiple enhancement
Date: Tue, 19 May 2026 13:55:25 +0530
Message-ID: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUeDGoC/32NQQ6CMBQFr0L+2pq2IFpX3sMQI+UBfwElbdNgC
 He3cgCXM8mbt1GAZwS6Fxt5JA7s5gz6VJAd3/MAwV1m0lLX8qK0aCth3RyxxpdHQBR9baRBqa5
 Kd5Rni0fP65F8NplHDtH5z/GQ1M/+iSUlpKhK0wKmRncrHzwNEfZs3UTNvu9fgrrRsLEAAAA=
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779179132; l=1287;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=O7HSV7Gpei4WuMBJU167sYvZFrZzKhazPSFBHMOC37g=;
 b=ZPd0ZKKkJv/tkSKY930wMUnlfBpw/pvRciQNZDS+rDucosaNaOzquBgRW06rS5fQeqdZzCkJa
 IqFSDhFBELnAyHaI2fpCb16OL2QEwkyxc/+7Fm/LinjvRMYu8dT1Hqq
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-GUID: __m2UsPghru3C1rTBUroqbWhqqg3rkfw
X-Proofpoint-ORIG-GUID: __m2UsPghru3C1rTBUroqbWhqqg3rkfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MiBTYWx0ZWRfX4gBlEPgqFX87
 Y6VKNyp4G5b4QVGCKHlCy455jy4bafNSpvJVIF5K9JtsP/OTDxfQl0+cndhBb1GDe19Hv0rGim+
 MOf5baYR7mCtMm8YAbHxu/jg5TdXoAP3QN3jdwMLNCHFW3CVvPwX/OtJ1NME1Os0luaNJLnj/dx
 0xkw3kLHNCluYjlqWpUaPod/xxebJkVXKI0RG1me8nC+AdT52H5+FCHAzgVjNwCyFHF13r94qKX
 EK3EjgYCB9KLaLbb4WTehQVbhpcl9Df2CTjWuaCshNZgeRUUWmHPj+niBjUVytF02gwvzXPxazq
 O8KBwG/lvoJzA1KRHnQEw7HjphHZYtX5HJBTA6TNJ0pjcve41O9vi5x6hNY9NZi6AkUA6MmebP+
 7uF0eBt3yTx+F0uMrXN+J0f9RpOnUd8C/m9UVq3AZHCU0TmHEmNq5GaxTjQoWjm0sXdHz64Ryi/
 r4C4nlEJl7U/GRixutw==
X-Authority-Analysis: v=2.4 cv=BIiDalQG c=1 sm=1 tr=0 ts=6a0c1e7f cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=f7c8-jAbXVoTAZo7cbUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

General enchancements to improve driver reliability.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v2:
- Commit description updated to bette reflect the change.
- Dropped some superfluous comments. 
- Link to v1: https://lore.kernel.org/r/20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com

---
Brajesh Gupta (4):
      drm/imagination: Populate FW common context ID before passing to the FW
      drm/imagination: Don't timeout job if its fence has been signaled
      drm/imagination: Rename FW booted to FW initialised
      drm/imagination: Access FW initialised state with READ/WRITE_ONCE

 drivers/gpu/drm/imagination/pvr_context.c | 30 ++++++++++++++++--------------
 drivers/gpu/drm/imagination/pvr_device.c  |  2 +-
 drivers/gpu/drm/imagination/pvr_fw.c      |  4 ++--
 drivers/gpu/drm/imagination/pvr_fw.h      |  7 +++++--
 drivers/gpu/drm/imagination/pvr_mmu.c     |  4 ++--
 drivers/gpu/drm/imagination/pvr_power.c   | 14 +++++++-------
 drivers/gpu/drm/imagination/pvr_queue.c   |  7 ++++++-
 7 files changed, 39 insertions(+), 29 deletions(-)
---
base-commit: ddfbe68a14260aabce25322fac81f2d02501369a
change-id: 20260512-b4-context_reset-f6909e31712d

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

