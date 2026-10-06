Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5A0CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF97E10E012;
	Tue,  6 Oct 2026 11:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="sGEQF8Dt";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABCA810E012;
 Tue,  6 Oct 2026 11:51:25 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BQsQF1936503; Tue, 6 Oct 2026 12:51:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Xtq7rNOsnQVJuGcn4YaQ5/F
 L2iPdFssMf3hg7JFNf8c=; b=sGEQF8DtDikyjhZsjjg7DYT0O6Tzkc5nqVoJCy+
 Fxif5cU6SKwz8bbDsRZCXh/7d2ZgrLH89PPs7vyEdvrb8KqCXaxRWjp865oJRLVB
 5MzKBo4LuMjRBjk0qIJL8aptB8hB2n0+0MSoPF6rBp+DL+xLrF+ZhpsoLbcaNZXt
 uunWqJaG7NF9+GK7bHUbhUtlcLrEB9gkDfLypBrokbRdT63BfjgQSDKWgninbusd
 KWY4Df12Hk9gnavEyvDUDMQvypQGfcCZFEOqM+ZVGURASomYS6QzxgPnUJze4g1s
 trtNirIXMU5bj/M9Klbyn63IrCaGb5YiUT5qTvn4dZjlJLQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4h4brugve4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 12:51:17 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.23) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:51:09 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 6 Oct 2026 14:51:07 +0300
Subject: [PATCH] drm/imagination: Improve logging of unknown freelist IDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-b4-improve-logging-of-unknown-freelist-ids-v1-1-96ebcb132b80@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAKvgxGoC/yXNSw7CMAxF0a1UHmMpqaoE2Api0I8TDMWp4rYgV
 d07AYZn8N7dQCkzKZyrDTKtrJykwB4q6G+tREIeiqE2tbPGOOwa5OeU00o4phhZIqaAizwkvQR
 DJhpZ57JSPLbu5L0Pg7ME5XDKFPj9i12uf+vS3amfvwXY9w+93TJ5jgAAAA==
X-Change-ID: 20261006-b4-improve-logging-of-unknown-freelist-ids-8a69777fd61e
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791287475; l=2033;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=YoXn7ZGSK0nHT6KyXFNCQpqvyMqan3bSYYtygPWdxBw=;
 b=n9fdRkY6R3nXEDNxhcQY78Xs6j9KEiedIzb898PybGR7WslezPvMi1SMjvmhJ0oLjczqE07cZ
 1iEtYUJ4pElCMlkOeoU3PkpCBM3Ecp911cbLWzMGwXyUnre0MsgjYC4
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.23]
X-Authority-Analysis: v=2.4 cv=FNOOVOos c=1 sm=1 tr=0 ts=6ac4e0b5 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Vfs-8JXWiL0A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=x1D3FuINM0scMlP-4QwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NyBTYWx0ZWRfX00Z0UM/mEmg9
 fG7QmUa+zn1pZCR4XA8IlkRYt182NtvXKaoBBX6uAZvbzajzZqx4WRQGQGZBeByjvTqPhjFuJIW
 hF3Ulw0MullnpnM6tDYPf1S/oXkDuqQ=
X-Proofpoint-ORIG-GUID: I5mwjz5g5xGXkq9lVarr1X8Odn7EfOhL
X-Proofpoint-GUID: I5mwjz5g5xGXkq9lVarr1X8Odn7EfOhL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NyBTYWx0ZWRfXzDn+2E79jP77
 qRpIA2Nv7Qt0vpjTexqfdCgwIvrVAhmTX6g0/lxiKFLADIQJpib0XTu4mTjuGfq2mme9B8ZuGnL
 9zqKKUjok22MyiEsofv6I21L/lU9hnsJ6oMXGecabgeWmb57+w9jP0R7J/eTjo732oC73V+hSjW
 Qehwmtnofw3HhVfrSP4v8YiZ6/ppxPRvkRnbcg1K2LqRc7RTbHbU3wNm+xiIZUPDkxKCd/Mfbg3
 pdMqsJ5tBXqhagm/8QzZEqc/oprrZ9ximcATo0L3BGhDivNNJ5KCB9QMMmidXmozHt64hUxToye
 fI0XzWrtY0b6xpRjcxJoSttqJuFmnhbz+cEe+m2RCjI0975UxzVtlQExtS3vWRcqgX/n0spaV3o
 iHeLz00jxWQ6LPG/15IJlxB2hsxtVi4rPBWKCUN3zL4vzhLZi4DYT6Iw21a2jtraAatrjR7aYC1
 yBSwup527rV2qglQQmA==
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

From: Alessio Belle <alessio.belle@imgtec.com>

Log freelist IDs not recognised by the driver when processing freelist
grow or reconstruction requests from the firmware.

In the freelist grow request path, remove a WARN_ON() which is not
particularly useful since it is known where the request came from.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_free_list.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_free_list.c b/drivers/gpu/drm/imagination/pvr_free_list.c
index e85cac83834c..f8a333649933 100644
--- a/drivers/gpu/drm/imagination/pvr_free_list.c
+++ b/drivers/gpu/drm/imagination/pvr_free_list.c
@@ -8,6 +8,7 @@
 #include "pvr_vm.h"
 
 #include <drm/drm_gem.h>
+#include <drm/drm_print.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <uapi/drm/pvr_drm.h>
@@ -367,8 +368,12 @@ void pvr_free_list_process_grow_req(struct pvr_device *pvr_dev,
 	u32 grow_pages = 0;
 
 	/* If we don't have a freelist registered for this ID, we can't do much. */
-	if (WARN_ON(!free_list))
+	if (!free_list) {
+		drm_warn(from_pvr_device(pvr_dev),
+			 "Received freelist grow request for unknown ID 0x%x\n",
+			 req->freelist_id);
 		return;
+	}
 
 	/* Since the FW made the request, it has already consumed the ready pages,
 	 * update the host struct.
@@ -564,8 +569,12 @@ pvr_free_list_reconstruct(struct pvr_device *pvr_dev, u32 freelist_id)
 	struct rogue_fwif_freelist *fw_data;
 	struct pvr_hwrt_data *hwrt_data;
 
-	if (!free_list)
+	if (!free_list) {
+		drm_warn(from_pvr_device(pvr_dev),
+			 "Received freelist reconstruction request for unknown ID 0x%x\n",
+			 freelist_id);
 		return;
+	}
 
 	mutex_lock(&free_list->lock);
 

---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20261006-b4-improve-logging-of-unknown-freelist-ids-8a69777fd61e

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

