Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F4606A68C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=trw7nSX0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E1510FBEC;
	Wed, 25 Nov 2026 11:49:41 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0018E10FBED;
 Wed, 25 Nov 2026 11:49:27 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6AP7p8ei1960842; Wed, 25 Nov 2026 11:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=4
 CfRCISKaUfvlxADLmdA9mSe+FQm0MkTvyy26GOlOBg=; b=trw7nSX04UiGvw7IR
 YP9uFSd1okWmDHDt+VZgCzD8LHe9plpVnjDKIvsOhEGl5suiAfuSWJPxyC7LYnSc
 N7YXQw6erUz1khv2ejHhjom7VB4Xq9zotKy9xVq5hFfJQFbFwl2btBCFKGGbFXZ+
 MqX4lVbQ+vV+QP7wKVegR5W40DMJI1vcvENC19l3rYM6En44yScizFEeJwXJ6XsE
 g3VYIAUIyKKY2gf26THAL1TdpFNx3yHhkijttgEDUAEeJpI1mcdQBNquT7iIDR2m
 Jw8IfTc8BW/JSHFeeLzJGngLkukyv020A5km7xdLNhzOqi2OWsJLj6c7la52BGtD
 kj9cA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4j3491kdys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Wed, 25 Nov 2026 11:49:07 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.203) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 11:49:05 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 25 Nov 2026 13:48:34 +0200
Subject: [PATCH 6/6] drm/imagination: Avoid loop in configure_seg_mmu()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261125-b4-commonize-fw-segment-loading-v1-6-69657fa52ac3@imgtec.com>
References: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
In-Reply-To: <20261125-b4-commonize-fw-segment-loading-v1-0-69657fa52ac3@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-hardening@vger.kernel.org>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795607333; l=2620;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=mH864ocXZNC25WYs2lKkZEbtfIlEtPaodCWW6jSS8bw=;
 b=pG8Z8ATSuSrkO3Oqr41DAy+xghqzGl+Lyijfvqv/L0wO4hZzQZ0vexU2zkNHKUUlZJ8Rfccag
 qqsmCGFfV7SBSEqWQPjYpH+UOJpMR9+V9dyKp3QQwgR9HZkSxo6qtRA
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX3X/zDx2aWuyu
 iHL/p9PdnGvAwrvYwklQHfBFEfuVRoZwZ+qHq8Dk9FDae2QQXz3Rzx/1Kfp4/1H8IZDzUKdO8BF
 YZN+dsYEUxNUrJr9twmlAbQ9+ceZ7ULDb3sYVnbIlvZbbFjtjUWHbK+o5bHSekM2o23aRRv1MYx
 +wU3g4WYwvF/MGhmsteeOxS1rw54xebSyf0RkddtilPJdQQkdhsV3NeIDP4tzF1F8JR3pKVvnhj
 6eYL+3R0m4J+R9oTOSnDjCSgQ6v/MmiZLkThYT6E5eN0JD4q2niP4TcLqGu7DmsPQkyHiqKMMST
 /7q1sqv2XHT9vYXNznTQTzh6LWnK0dLS25y/DUIyoZprncEUvJbnsev2wsYv3tjR5ojNCPcxwRZ
 tNPBXsb9wV+Ynd8Qe8Ya5fqmXgt6HySF9KYxvcnIsX41f9cvZRKiYqbxWSeuod9skP13CmSe9Am
 uTUOEqPiFQhJBkl8CGQ==
X-Authority-Analysis: v=2.4 cv=OaENnRTY c=1 sm=1 tr=0 ts=6b06cb33 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=4EFqt8Tv61wA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=RsU-mexvXcnqIS9unQEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0NiBTYWx0ZWRfX2sp8e2CMco+c
 LZ27dDLBqWOKDYIxFDrlDiru2J62p2Zz6YNXiDeJ2wAt2dum//wZuxn/PBIf4MMEBkXUIttYvH1
 2VIb3wIOsusfg4I9vZw5fnnMgdMwG/s=
X-Proofpoint-GUID: QNqZJqeBUj2jaWl1CS5X_0np2lIr9fvj
X-Proofpoint-ORIG-GUID: QNqZJqeBUj2jaWl1CS5X_0np2lIr9fvj
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

From: Alessio Belle <alessio.belle@imgtec.com>

Use recently added API to directly find the one section the code is
looking for.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_meta.c | 50 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 53143a6ad2ca..92f54c846169 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -353,32 +353,30 @@ configure_seg_id(u64 seg_out_addr, u32 seg_base, u32 seg_limit, u32 seg_id,
 static void
 configure_seg_mmu(struct pvr_device *pvr_dev, u32 **boot_conf_ptr)
 {
-	u64 data_seg_gpu_addr =
-		pvr_fw_obj_get_gpu_addr(pvr_dev->fw_dev.mem.segments[PVR_FW_SEGMENT_DATA].obj);
-	u64 seg_out_addr_top =
-		ROGUE_FW_SEGMMU_OUTADDR_TOP_SLC(MMU_CONTEXT_MAPPING_FWPRIV,
-						ROGUE_FW_SEGMMU_META_BIFDM_ID);
-
-	pvr_for_each_fw_section_desc(pvr_dev->fw_dev.metadata, desc) {
-		/*
-		 * FW code is using the bootloader segment which is already
-		 * configured on boot. FW coremem code and data don't use the
-		 * segment MMU. Only the FW data segment needs to be configured.
-		 */
-		if (desc->segment == PVR_FW_SEGMENT_DATA) {
-			u32 seg_id = ROGUE_FW_SEGMMU_DATA_ID;
-			u64 seg_out_addr = data_seg_gpu_addr;
-
-			seg_out_addr += desc->alloc_offset;
-			seg_out_addr |= seg_out_addr_top;
-
-			/* Write the sequence to the bootldr. */
-			configure_seg_id(seg_out_addr, desc->base_addr,
-					 desc->size, seg_id, boot_conf_ptr);
-
-			break;
-		}
-	}
+	const struct pvr_fw_section_desc *data =
+		pvr_fw_get_section_desc(pvr_dev, PVR_FW_SECTION_PRIVATE_DATA);
+	struct pvr_fw_object *data_obj =
+		pvr_dev->fw_dev.mem.segments[PVR_FW_SEGMENT_DATA].obj;
+	u64 data_gpu_addr = pvr_fw_obj_get_gpu_addr(data_obj);
+	u64 seg_out_addr = data_gpu_addr + data->alloc_offset;
+	u32 data_base_addr = data->base_addr;
+	u32 data_size = data->size;
+
+	/*
+	 * FW code is using the bootloader segment which is already configured on boot.
+	 * FW coremem code and data don't use the segment MMU. Only the FW data segment
+	 * needs to be configured.
+	 */
+
+	seg_out_addr |= ROGUE_FW_SEGMMU_OUTADDR_TOP_SLC(MMU_CONTEXT_MAPPING_FWPRIV,
+							ROGUE_FW_SEGMMU_META_BIFDM_ID);
+
+	/* Write the sequence to the bootloader. */
+	configure_seg_id(seg_out_addr,
+			 data_base_addr,
+			 data_size,
+			 ROGUE_FW_SEGMMU_DATA_ID,
+			 boot_conf_ptr);
 }
 
 static void

-- 
2.43.0

