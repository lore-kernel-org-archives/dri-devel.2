Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB1DC54F55
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D2410EC60;
	Wed, 29 Jul 2026 14:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Rw+VnBmf";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39910EC5F;
 Wed, 29 Jul 2026 14:57:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TEL64K1014198; Wed, 29 Jul 2026 15:57:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=P
 Ci3KG5zHKeU1V2T2tV1/AKr3dP1/pR+aCuPEG4hfDU=; b=Rw+VnBmf0E3xyepGi
 CE81l3liMkr7hogtEtsdkYihn1oE30xzd1beTJadfXUov+IVAjGPTCArJ936llfW
 g+DBjVebyKWCTNwpkEmkyPrP0wsitBLOjltCBMVDA2ADHbJv2PqCL/YzIKUFIQGr
 cYgcbZRSmE0lXgsAHAekhZhwkDjEobmOuQyOU613NT+tfUhM/i08fh6FZposhDT+
 J0vjLkTcojr41bSLh0HPAZWkGc5qxCl18aK36Flmt4qEsN6pKGRksEeb/ebTKIh3
 8pt4Rzz++9OPiF+k9MCTKCe7MTrQKS5qB061xDhkIZmJT7Op1Mb1DLnJhgizpHrg
 Oml0g==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fq8kr0hvj-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 15:57:28 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.151) by
 HHMAIL02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 15:57:27 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Wed, 29 Jul 2026 15:57:06 +0100
Subject: [PATCH 1/2] drm/imagination: Move all FW interface check macros to
 pvr_checks.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-fwif-checks-updates-v1-1-af65e9606a7e@imgtec.com>
References: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
In-Reply-To: <20260729-fwif-checks-updates-v1-0-af65e9606a7e@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <imagination@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, Alessio Belle <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5621;
 i=alessio.belle@imgtec.com; s=20260628; h=from:subject:message-id;
 bh=1F9H7Cc8L33YGeOvw+Sefr4A5oSUW6mJ8/gvmxIFUHs=;
 b=owGbwMvMwCUm4nVW5aiD4lnG02pJDFlZItfOPPPK+7OndbJ89eQlva/jrFdOVzJR/T/v155XS
 VO/XlpzrKOUhUGMi0FWTJHlw76N/231PtRKMWy/CDOHlQlkCAMXpwBM5Dwzw18Bx61bDFOdjBpb
 F9U4fHO+sqNhT4T5ygPv01zXb3T4LRLMyLCaa1OCTFXDrBMhd3UW+PlGXopyf2r8Wool0oVrffe
 LHZwA
X-Developer-Key: i=alessio.belle@imgtec.com; a=openpgp;
 fpr=F0BEB1FF3D2EF07D1A00B7D1144ACD24C54021CD
X-Originating-IP: [172.25.4.151]
X-Proofpoint-GUID: ea3G-E7cg-sfK4LoybhvQEIi1DX5e0pD
X-Authority-Analysis: v=2.4 cv=It4utr/g c=1 sm=1 tr=0 ts=6a6a14d8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=XqWWZq4ChBYA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=hXdH69DwIbJLhl_lwOEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXyBb3osx54xIL
 awnt37hSr2S4eyKJJe2LUa6XPCY2RcnuZPCpPh21kHP7PpMSLgfsZAuCvDdQnz4kYruBQR2Qqex
 LHJhezLUYYtEDolic3BnZyJQecTro8xdCdm2GjuXL4+1+NxSBk6tG6jPjclvexkTvSNUoxBIOs0
 ReR2Bdh72/p1cxVfll1yxwO7CxsSr47OLw1CCGCUsUPJa3J7KV3snoNa4J3eeKo8/ZjTzQzcnNH
 nQ4aMCigRkY9WHamt69rTbudBdSNosAqYGDnG2hP7FSldCoLoG/zR/vt84txtuiny8VVm3NCPqy
 b+6a3vEhpUyNNv8Z8O37VYImGXkl0BngqkobPixKMd6LogkSEzsGOGEJQNZMyFNXeG60HZvRPoY
 i/TG2xjnAOzbjSpIG8TlKlFZTqJkcYX2uOTSwSk1mF3jPrRzF37oouhPm5Bk9TQQrAnNxDld+7z
 xq4pxeDdGzPphL9IBWg==
X-Proofpoint-ORIG-GUID: ea3G-E7cg-sfK4LoybhvQEIi1DX5e0pD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX1lMLsalKXQ78
 3Oo16AcJtwb9GhG+gN9KOLbgA5JYBeUcWLPOfnOPYCeu1OhLiOg0cHypNdWRCsosRA6Ik6PH2pc
 2yFCFFz4Z3+YX9YWmZ5Y6W9GZxmjUio=
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

From: Alexandru Dadu <alexandru.dadu@imgtec.com>

The same macros are redefined in three places, so move them to a common
file to reduce duplication and make it easier to reuse them.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Co-developed-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_check.h            | 36 ++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h | 26 +---------------
 .../drm/imagination/pvr_rogue_fwif_client_check.h  |  9 +-----
 .../drm/imagination/pvr_rogue_fwif_shared_check.h  |  9 +-----
 4 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_check.h b/drivers/gpu/drm/imagination/pvr_check.h
new file mode 100644
index 000000000000..94764ce9bbd1
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_check.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/* Copyright (c) 2026 Imagination Technologies Ltd. */
+
+#ifndef PVR_CHECK_H
+#define PVR_CHECK_H
+
+#include <linux/build_bug.h>
+#include <linux/overflow.h>
+#include <linux/stddef.h>
+
+#define OFFSET_CHECK(type, member, offset) \
+	static_assert(offsetof(type, member) == (offset), \
+	"offsetof(" #type ", " #member ") incorrect")
+
+#define SIZE_CHECK(type, size) \
+	static_assert(sizeof(type) == (size), #type " is incorrect size")
+
+#define ALIGN_CHECK(type, align) \
+	static_assert(__alignof__(type) <= (align), #type " has incorrect alignment")
+
+/*
+ * Where the last member of a struct is a flexible array member, using
+ * SIZE_CHECK() is pointless. If the structure is not already padded to
+ * alignment without the flexible array member, sizeof() will not match the
+ * offset of the flexible array member and the "correct" sizeof() value is
+ * completely meaningless.
+ *
+ * In those instances, use FLEX_ARRAY_CHECK() instead to assert that the final
+ * field is a flexible array member and that it behaves as expected.
+ */
+#define FLEX_ARRAY_CHECK(type, member)                               \
+	static_assert(flex_array_size((type *)NULL, member, 1) ==    \
+				      sizeof_field(type, member[0]), \
+		      #type "->" #member " is incorrect size")
+
+#endif /* PVR_CHECK_H */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h
index e72f4064af18..5048866359b9 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_check.h
@@ -4,31 +4,7 @@
 #ifndef PVR_ROGUE_FWIF_CHECK_H
 #define PVR_ROGUE_FWIF_CHECK_H
 
-#include <linux/build_bug.h>
-#include <linux/overflow.h>
-#include <linux/stddef.h>
-
-#define OFFSET_CHECK(type, member, offset) \
-	static_assert(offsetof(type, member) == (offset), \
-		      "offsetof(" #type ", " #member ") incorrect")
-
-#define SIZE_CHECK(type, size) \
-	static_assert(sizeof(type) == (size), #type " is incorrect size")
-
-/*
- * Where the last member of a struct is a flexible array member, using
- * SIZE_CHECK() is pointless. If the structure is not already padded to
- * alignment without the flexible array member, sizeof() will not match the
- * offset of the flexible array member and the "correct" sizeof() value is
- * completely meaningless.
- *
- * In those instances, use FLEX_ARRAY_CHECK() instead to assert that the final
- * field is a flexible array member and that it behaves as expected.
- */
-#define FLEX_ARRAY_CHECK(type, member)                            \
-	static_assert(flex_array_size((type *)NULL, member, 1) == \
-			      sizeof_field(type, member[0]),      \
-		      #type "->" #member " is incorrect size")
+#include "pvr_check.h"
 
 OFFSET_CHECK(struct rogue_fwif_file_info_buf, path, 0);
 OFFSET_CHECK(struct rogue_fwif_file_info_buf, info, 200);
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_client_check.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_client_check.h
index 54aa4474163e..467d1d2073a1 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_client_check.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_client_check.h
@@ -4,14 +4,7 @@
 #ifndef PVR_ROGUE_FWIF_CLIENT_CHECK_H
 #define PVR_ROGUE_FWIF_CLIENT_CHECK_H
 
-#include <linux/build_bug.h>
-
-#define OFFSET_CHECK(type, member, offset) \
-	static_assert(offsetof(type, member) == (offset), \
-		      "offsetof(" #type ", " #member ") incorrect")
-
-#define SIZE_CHECK(type, size) \
-	static_assert(sizeof(type) == (size), #type " is incorrect size")
+#include "pvr_check.h"
 
 OFFSET_CHECK(struct rogue_fwif_geom_regs, vdm_ctrl_stream_base, 0);
 OFFSET_CHECK(struct rogue_fwif_geom_regs, tpu_border_colour_table, 8);
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared_check.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared_check.h
index 597ed54bbd3a..59ef0a9aa395 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared_check.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared_check.h
@@ -4,14 +4,7 @@
 #ifndef PVR_ROGUE_FWIF_SHARED_CHECK_H
 #define PVR_ROGUE_FWIF_SHARED_CHECK_H
 
-#include <linux/build_bug.h>
-
-#define OFFSET_CHECK(type, member, offset) \
-	static_assert(offsetof(type, member) == (offset), \
-		      "offsetof(" #type ", " #member ") incorrect")
-
-#define SIZE_CHECK(type, size) \
-	static_assert(sizeof(type) == (size), #type " is incorrect size")
+#include "pvr_check.h"
 
 OFFSET_CHECK(struct rogue_fwif_dma_addr, dev_addr, 0);
 OFFSET_CHECK(struct rogue_fwif_dma_addr, fw_addr, 8);

-- 
2.43.0

