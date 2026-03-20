Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F55109879B
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C68D10E1D6;
	Fri, 20 Mar 2026 15:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="kzraq7K7";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E67710E1D6
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:22:47 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K7v2rB3934120; Fri, 20 Mar 2026 15:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=R
 oVNSXPTh3ShV/Rka5X5ncNUfStbDa7QFP1uSDlyxXE=; b=kzraq7K7M7SYwp6bE
 SFQkz8/X0Xzl4Tcoxxl3ChMlOc0rV61nDva9JliMJrU+fHcul8tfoBJhTfe1iPMi
 NH5Z9763Xx5hnHLHDLRnGWNPt8vagCJg6NHtiJSUzElohwgEpdlRHMxFvoG5Z5Tj
 ddP0TxnisVAO55Kx6qV8ioBAKhuq9g2McanOHDI1lXjY9WM/bWVHX1DLpNe3dOu7
 ovkf9LOL3q7hG8Osjmjks/sS7XEVxwLotj36Ppm/4YDR6SfPr6HrPI+zznfVyL1d
 vMl0EivzF01owtnoG1GWk2VdLa+G1cuMEcse81xtGL+YG0GBeuUxzVAfpVlC2fEx
 ZaaJg==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4cw0mwdjs3-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 15:22:24 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 20 Mar
 2026 15:22:24 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 15:22:24 +0000
From: Matt Coster <matt.coster@imgtec.com>
Date: Fri, 20 Mar 2026 15:22:13 +0000
Subject: [PATCH v2 2/2] drm/imagination: Add PVR_GPU_ID_FMT to format
 pvr_gpu_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260320-bvnc-cleanup-v2-2-49c3c1453289@imgtec.com>
References: <20260320-bvnc-cleanup-v2-0-49c3c1453289@imgtec.com>
In-Reply-To: <20260320-bvnc-cleanup-v2-0-49c3c1453289@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Matt
 Coster" <matt.coster@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3463;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=YUWdK7LYxhbWXK9a2EpIeO6Q108VfMMcPo6x5C6c4pk=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMWTuTdPfNXePiPXv0kOMU403rm2+JN5eE9F+wJxxo9KL5
 67mfilaHaUsDGIcDLJiiiw7VliuUPujpiVx41cxzBxWJpAhDFycAjCRMAVGho8cM7kuJBjfdSpK
 vbnz6Sd7vkvCMYdy8t5sVjGbZ5yXO5WRYZ3/SZmIH/89T/1+mes3TbK85NNHhq8tG66d6ly/cvf
 qYlYA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.4.249]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyMiBTYWx0ZWRfX30kFLWwymket
 9LsLg9rxaIjlF8WNxEGJ9yvhsysUvlErEW6qT+QleRTNsWOBMq+IQM/sTjWKzzNxk7xS+y1Nttv
 V4mM+3TdIIQroQk2jLrC7qX1MUlKoDmJ19T8dMdWNM5uIKlOPv8HZyOnNvCCnX5MQVmcvD08kHi
 kwBJaCmsdaI4RP8DItkQC2tzkeSD6SILSkYRKMvm1EcYr4il1BXXSLxyJvYNEYBlTl+piZrMHva
 IRPd17HTQHrr68QMEBd13abR4GOwC/KT0qOU4AjfQEBXlQaPuci+jLpuveUkz/oAUTXb2+XlNWQ
 Y0Gi8HrVfME+EKUB/i4liKgYUGhXkqZmZsx8ZshmSSH6yC1xS15bHwnVofgQEhRk33PP1WFR+ZN
 NSGNHcCSTbZdjs+uGsHwAVeUUTzztmDB+r3wRXKeIUrDzCvloltn3NH22+QVzIrCxXwbMH7ngdm
 mH+PcNLT3OqyEpWGTGw==
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69bd6631 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=zDq0utqy4rlx-ExxUQcA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: XwKlSLrx0AwTQjoIEzKRlfw5B7PL2gtw
X-Proofpoint-ORIG-GUID: XwKlSLrx0AwTQjoIEzKRlfw5B7PL2gtw
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

There are currently two different combinations of format specifiers used to
print a struct pvr_gpu_id, one using %i and one using %d. Both of these
are technically incorrect since the components are stored as u16.

Introduce macros to simplify and correct the formatting of these values:
 - PVR_GPU_ID_FMT: A pre-constructed format string fragment, in the style
   of PRIu32.
 - PVR_GPU_ID_FMT_ARGS(): Accepts a &struct pvr_gpu_id and expands the
   fields into appropriate format arguments to be used with PVR_GPU_ID_FMT.
 - PVR_GPU_ID_FMT_ARGS_PACKED(): Accepts a packed GPU ID as a u64 and
   extracts the components directly into appropriate format arguments to
   be used with PVR_GPU_ID_FMT.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>

---
Changes in v2:
- Simplify the change made to pvr_fw_validate()
- Link to v1: https://patch.msgid.link/20260206-bvnc-cleanup-v1-2-f3c818541fbe@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_device.c | 4 ++--
 drivers/gpu/drm/imagination/pvr_device.h | 6 ++++++
 drivers/gpu/drm/imagination/pvr_fw.c     | 9 +++------
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 9b26585a42bf..263d1badacf3 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -362,8 +362,8 @@ pvr_build_firmware_filename(struct pvr_device *pvr_dev, const char *base,
 {
 	struct pvr_gpu_id *gpu_id = &pvr_dev->gpu_id;
 
-	return kasprintf(GFP_KERNEL, "%s_%d.%d.%d.%d_v%d.fw", base, gpu_id->b,
-			 gpu_id->v, gpu_id->n, gpu_id->c, major);
+	return kasprintf(GFP_KERNEL, "%s_" PVR_GPU_ID_FMT "_v%d.fw", base,
+			 PVR_GPU_ID_FMT_ARGS(gpu_id), major);
 }
 
 static void
diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index 55d8ff11d507..54e3e947e60e 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -53,6 +53,12 @@ struct pvr_gpu_id {
 	u16 b, v, n, c;
 };
 
+#define PVR_GPU_ID_FMT "%u.%u.%u.%u"
+#define PVR_GPU_ID_FMT_ARGS(gpu_id) (gpu_id)->b, (gpu_id)->v, (gpu_id)->n, (gpu_id)->c
+#define PVR_GPU_ID_FMT_ARGS_PACKED(gpu_id) \
+	(u32)FIELD_GET(DRM_PVR_BVNC_B, gpu_id), (u32)FIELD_GET(DRM_PVR_BVNC_V, gpu_id), \
+	(u32)FIELD_GET(DRM_PVR_BVNC_N, gpu_id), (u32)FIELD_GET(DRM_PVR_BVNC_C, gpu_id)
+
 /**
  * struct pvr_fw_version - Firmware version information
  * @major: Major version number.
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 288516dc2560..0b1c2a0d950c 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -126,12 +126,9 @@ pvr_fw_validate(struct pvr_device *pvr_dev)
 	}
 
 	if (pvr_gpu_id_to_packed_bvnc(&pvr_dev->gpu_id) != header->bvnc) {
-		struct pvr_gpu_id fw_gpu_id;
-
-		packed_bvnc_to_pvr_gpu_id(header->bvnc, &fw_gpu_id);
-		drm_err(drm_dev, "FW built for incorrect GPU ID %i.%i.%i.%i (expected %i.%i.%i.%i)\n",
-			fw_gpu_id.b, fw_gpu_id.v, fw_gpu_id.n, fw_gpu_id.c,
-			pvr_dev->gpu_id.b, pvr_dev->gpu_id.v, pvr_dev->gpu_id.n, pvr_dev->gpu_id.c);
+		drm_err(drm_dev, "FW built for incorrect GPU ID " PVR_GPU_ID_FMT " (expected " PVR_GPU_ID_FMT ")\n",
+			PVR_GPU_ID_FMT_ARGS_PACKED(header->bvnc),
+			PVR_GPU_ID_FMT_ARGS(&pvr_dev->gpu_id));
 		return -EINVAL;
 	}
 

-- 
2.53.0

