Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568660A260E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=ChTSqXoO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF9410EB73;
	Mon,  2 Nov 2026 07:09:31 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFCD610E56B;
 Mon,  2 Nov 2026 07:09:21 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A26GB1s3838432; Mon, 2 Nov 2026 07:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=N
 1sCnUJZes2nWUPirOY9b0XhMayPBpKTCwjYpoDAMUg=; b=ChTSqXoO9Osj2KF3r
 K049uasMDAfFj29UCq5guzQKid19UK0xhFxVD3BOf5h12Nvm3N4AbCKZwRpJdoBC
 oKEs/NAnGRHoeUsnpV09T0LaSrAJDzAl6RwVANDZZ8YvRxOvVcbPTqk4zelZfAwC
 /y5rqIU3U5MVm77TBtQQxATaUbgaqMqS4MGwARMk8CxBmxu1jwtdWFYz35VwUO8x
 O/n4sVaumA3mBVFKhRiadl/uYz63+c47xKnRFl7PJ40ZIzWkSunHohgl2dNw569l
 KWl5hJBzEmDJi8eo30XISM8BZ+j/RPmkjkXV3bm/fH6xgO11hlRIf4lsrDEhgXVZ
 Oirvw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hn99whb6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 07:09:06 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 07:09:05 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 2 Nov 2026 09:08:35 +0200
Subject: [PATCH v5 3/4] drm/imagination: Improve some logging in error
 paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261102-b4-simplify-mips-pte-defs-v5-3-d5bcf7d95a1a@imgtec.com>
References: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
In-Reply-To: <20261102-b4-simplify-mips-pte-defs-v5-0-d5bcf7d95a1a@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793603340; l=2557;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=RojfA0ofXUa2gTm6g8B+3070zBumv7LmENgITU3pSG8=;
 b=auf0G4jjl9wdAjB5pAGTdP/WQasdY8Ri/ZdxdC6LWPX7A6s86n7HBn5kCK5YDIZIrUSJ7T/U3
 +nYcIRAHMkiCdOaauMMp8WwajmuwVxAtfx4QFy7/55x7QxQBnf6mGe3
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAyOCBTYWx0ZWRfXwolAwhoJcWKQ
 yfXgR5czRZOLQs4pDHwcpZmAUWGD9YhZ90QheVr2XJQwYtUFD2XLB5xII62xSZgfWEJDa7BZyEJ
 evObZr2vsXDXNwuaw1NaMoYisqGag1PEiRwEpsKv7mRBDUeOIm4C28DDJ9olyXjVta1tIMZg6Jg
 MzCkjLDmvlK/h1tsSsV2mXmZlB6jvhX3+2tUXG1hw0KZaG7ohgSn/Nz+4t1Vo4KaZz7ccJk5vJ3
 WiGmiukhVckxEsXSc0VucFbCyJoYd1GDvEX/qOHE8pc6XOAip7Dm56vnCkJFtv04Xe07syfTHq1
 3BgE7Rj6X+hZCkXybEqZVj9GaDwi3GUG10tL4UvgyTxxeMxpPsH7bVFKPUmN3KyGoZIErANus3K
 0OtwhfrpgsEir6iOu2T05uPdvO3Um+yRoyr95jUMI5d9ObACnHgk6jTSc2FIsf/2IWmBBioexqh
 ADuLWzc7zIbXncUI12w==
X-Proofpoint-ORIG-GUID: jCKCnIvSDJMRo4gdCkMVIKkA0oEvdPKx
X-Proofpoint-GUID: jCKCnIvSDJMRo4gdCkMVIKkA0oEvdPKx
X-Authority-Analysis: v=2.4 cv=BZlNQbt2 c=1 sm=1 tr=0 ts=6ae83712 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=CNbiELROydHnTOGMemMA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAyOCBTYWx0ZWRfX9lK8q/hTrAff
 pgdEV0U5aaI5og8pYeAfOlJIiwUOhi2Qfz8EgAnZrcqZAzsHY8LLM/a2hLhLyvTY+Boo4RTERZe
 /jox52LzZ5zi52+87R/zjSqLIPGCALA=
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

From: Matt Coster <matt.coster@imgtec.com>

Add error messages for attempts to map an already mapped firmware
object, unmap an already unmapped firmware object, and provide too few
DMA address slots for the firmware page table.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.c      | 6 ++++--
 drivers/gpu/drm/imagination/pvr_vm_mips.c | 7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index c6c77b152342..4f2b5c4df600 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1165,8 +1165,9 @@ pvr_fw_object_fw_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj, u
 	spin_lock(&fw_dev->fw_mm_lock);
 
 	if (drm_mm_node_allocated(&fw_obj->fw_mm_node)) {
-		err = -EINVAL;
-		goto err_unlock;
+		spin_unlock(&fw_dev->fw_mm_lock);
+		drm_err(from_pvr_device(pvr_dev), "FW object is already mapped!\n");
+		return -EINVAL;
 	}
 
 	if (!dev_addr) {
@@ -1232,6 +1233,7 @@ pvr_fw_object_fw_unmap(struct pvr_fw_object *fw_obj)
 
 	if (!drm_mm_node_allocated(&fw_obj->fw_mm_node)) {
 		spin_unlock(&fw_dev->fw_mm_lock);
+		drm_err(from_pvr_device(pvr_dev), "FW object is already unmapped!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index 726f900d3582..b74386032e6a 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -11,6 +11,7 @@
 #include "pvr_vm_mips.h"
 
 #include <drm/drm_managed.h>
+#include <drm/drm_print.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -278,8 +279,12 @@ pvr_vm_get_pt_phys_addrs(struct pvr_device *pvr_dev, u64 *phys_addrs, int max_nu
 	struct pvr_fw_device *fw_dev = &pvr_dev->fw_dev;
 	struct pvr_vm_mips_data *vm_data = fw_dev->processor_data.mips_data.vm_data;
 
-	if (ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs)
+	if (ARRAY_SIZE(vm_data->pt_pages) > max_num_addrs) {
+		drm_err(from_pvr_device(pvr_dev),
+			"Minimum %zu pages required for FW PT, but only %d DMA address slots were provided\n",
+			ARRAY_SIZE(vm_data->pt_pages), max_num_addrs);
 		return -EINVAL;
+	}
 
 	for (u32 page_nr = 0; page_nr < max_num_addrs; page_nr++) {
 		/* Firmware expects 4k pages, but host page size might be different. */

-- 
2.43.0

