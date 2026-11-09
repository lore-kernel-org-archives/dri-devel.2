Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4A60A3834
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=FuAO0hzb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F85B10F253;
	Mon,  9 Nov 2026 12:33:02 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D21110F24A;
 Mon,  9 Nov 2026 12:32:53 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A97C2iI2074673; Mon, 9 Nov 2026 12:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=N
 1sCnUJZes2nWUPirOY9b0XhMayPBpKTCwjYpoDAMUg=; b=FuAO0hzbrkNQjwsHF
 fxE2YI1qQrvyfLWIAVnMZsRcbj81qrK3Gu7SwV1/0mhg+CJg6KMna1g9u+5gm01F
 tUbHN9MvrChI55/gKZ4TnXl7JD9JvE0Et9qSVhYKSwktjFXrtgHJBC5RJq+eucaq
 +Xb/IM97Ygn1bYrbIzV39Rap+/YWhzYNRGfuGf5wHPklmnN3DVdrlI/kbNSaQC6j
 bHOgWBMjcRLQ1i907mSnToKEeoUaj5G9O44MCENUcpxUEbuye2q4kkMn8CktNcsS
 umRmUhaHCq3SsX0uS1Uii7hAP6CCQ0P8YJp+svusjBSb62TibeAepCbtiaALkwYB
 CuMEQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hu8pn871n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 12:32:44 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 12:32:42 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 9 Nov 2026 14:32:17 +0200
Subject: [PATCH v6 3/4] drm/imagination: Improve some logging in error
 paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261109-b4-simplify-mips-pte-defs-v6-3-65153bc9a71c@imgtec.com>
References: <20261109-b4-simplify-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com>
In-Reply-To: <20261109-b4-simplify-mips-pte-defs-v6-0-65153bc9a71c@imgtec.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794227557; l=2557;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=RojfA0ofXUa2gTm6g8B+3070zBumv7LmENgITU3pSG8=;
 b=dgss276wZzECskmLcfbnwGPoAXk9kYAQU2SWKVkf/7ZY7m4ev9MQU4lRoSiSkdtXkVnlhQ/Lk
 CZQWL2a5gdsC+YiZVMjuCmZdZBwWGfty1njFFa1u2mddRkebuDbdaaT
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Authority-Analysis: v=2.4 cv=P46vFSAu c=1 sm=1 tr=0 ts=6af1bd6c cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=CNbiELROydHnTOGMemMA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0OSBTYWx0ZWRfX2n115MecieID
 zBOmBT+n4ZDs1TmpQe6nFjkgtam759/fR77yVTXCPS4345lXbuuGBAVLPsbe45BiJz7f4j3WtYc
 4tQZ8H+Gpu4LoSx7b/kYR67RNW/dg/XF145okL7/wOObKxivhCqAsHuih6Rx8ajLy2ECx0PY7Ll
 v0rsIwDvMoGBSVFUHbk6eEVZM1ESncK2VcJP6MCJWgKiT1RRtOrHLEU8hENSCTy91rXZYdcO5tn
 rnEID1I2TaTW7/K9y+8nyNQOMb1lX2OmMfyibKa4j/0bmBDXmghEANYN9l+xY8ffrcOUFljEzTb
 GLy2x6Ei5xQEMLSegf5ucaF8NAy/eL6n5X9F4xW6ZOG9lRCeYlS93nt3zAu4nYPts5vPntbdsJf
 U5X+cb7KNwfWTbEyTxO7X6RXyZEJYXweBExB9xFjobj6GCrRwgeLgAVBFlneKAw/82a0LTeWvyJ
 +MYfK2KvNDgFglt3/UA==
X-Proofpoint-ORIG-GUID: pnZQfCfs7QCe4QnlmBpNAle-ep-A0Bcs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0OSBTYWx0ZWRfXwJzRczqtqp7M
 z0rw1YWNL5u/8ZhQ1RA2Y6hwT0aERvN5wrLg/k0aEwsfadG5nHovpp3mFaTFQtgJWeBdZmjByVY
 3sxZMVRz9Gv8T2jM+a/8tvIy+y9nT/w=
X-Proofpoint-GUID: pnZQfCfs7QCe4QnlmBpNAle-ep-A0Bcs
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

