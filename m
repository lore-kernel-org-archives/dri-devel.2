Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E58EF483E1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 756FA10E44F;
	Mon, 23 Mar 2026 18:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="hpov+fT/";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A730410E0A0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 18:32:00 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHN9Zn4033794; Mon, 23 Mar 2026 18:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=9
 IAfZM4d25jbjkXR97EeRhk3LkLze0xpdLTUAIi9yys=; b=hpov+fT/oWLHNbfXx
 Gimxn7dySCi/LhSjyFaXa2zBPdNX3a0tpfW/Vg5PwU9lXi+IO2tMgcTUvB+WzzZz
 pQCUamWmQ1jM+T8eQXpzVgZ+KEWD2Nux+C2LGQvb0CLYvUwCMgbPuU67DBYCEsMG
 ME0nrdeZRiTcQSk0VC00bkZqWDwmYeZwzKJl80U1rCk0EvEhoRuA90L9vonao2nM
 W64V67mtyZEy53P6D4lDdKGrDdmNcqPAnlw/ndrubkEQZSUB1J8pBMwpPLDjK92h
 yv7Yc9v1qgfAtG0D1CJDH13bUnPDvaPZGB9sDoEVHS2SBvLrRVyWmVTr/utCQK3t
 lcpPA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4d1jfqsrx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 18:31:47 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.37) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 23 Mar
 2026 18:31:46 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 23 Mar 2026 20:31:30 +0200
Subject: [PATCH v3 3/3] drm/imagination: Implement handling of context
 reset notification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-b4-firmware-context-reset-notification-handling-v3-3-1a66049a9a65@imgtec.com>
References: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
In-Reply-To: <20260323-b4-firmware-context-reset-notification-handling-v3-0-1a66049a9a65@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Alessio Belle" <alessio.belle@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Sarah Walker <sarah.walker@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774290702; l=6703;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=d/q652ra8aoN/inhIEgUaSGRKcICDmQWzssZvB3r0D8=;
 b=QRinmSRrHNDKomI3RXQI6n5IWYPCmFxIsz2kxLiOIGwTwg9nmZyhwIPCmkd/534gqemkPKtJr
 w54eDBpQr2yDIpPxDxacHq7XvGQQErMY5ndZikp/7pAl+b3roX4sFql
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.37]
X-Proofpoint-ORIG-GUID: VQJbfdYaIOHDGTOH5-CUG3vqUYy7mZKq
X-Authority-Analysis: v=2.4 cv=HJjO14tv c=1 sm=1 tr=0 ts=69c18713 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=7IANbbwssFwA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=eoAnicgNG9KoMJQc0cgA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: VQJbfdYaIOHDGTOH5-CUG3vqUYy7mZKq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzNiBTYWx0ZWRfX0EQV+cCyt/0T
 4Iqop+1VaOZHQzL4fbAYv6HAwFaEP2/IT3f4f5MzLsDlzVQoWpEzS4S4YumpGbHfjRU1yXfPruy
 1kCDM1VpJpSI3erWYTdfHbV6FTdB6VCL1nTyQHwCQS6S5rzFLshTepegmGqOzQjVx2nBX8Rl6bd
 G+M2A7zQkyKQj2QohYkOGkRUPXdRjzFAZjQ9hUC/NMGfUx5g7P8PwLpg/jDpqMXfYVifUbFsmPw
 dcpyDEaJ8dQJibFrkuXGZkoqx+ddrjNlwAeRHStb6LS40/qfnybjqWD8OjHwUwR8EC/CXYOe6s1
 NOgv4uya9OT3JlUQXXTEuGW6oRrSoke1eGQt77+MAFymHpR1hlNOBKwmzW40supI5CQfCEx/14D
 /BLx92DeEgXnzeQogXzbYl/w9YmPE0WBDc112si5DKp1rV+fIW09g3ih5xVKJCqKDbZRoNoxEdF
 Mq7+QR6d4cdT2mOgl2g==
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

The firmware will send the context reset notification message as
part of handling hardware recovery (HWR) events deecoding the message
and printing via drm_info(). This eliminates the "Unknown FWCCB command"
message that was previously printed.

Co-developed-by: Sarah Walker <sarah.walker@imgtec.com>
Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
---
 drivers/gpu/drm/imagination/Makefile   |   1 +
 drivers/gpu/drm/imagination/pvr_ccb.c  |   5 ++
 drivers/gpu/drm/imagination/pvr_dump.c | 113 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_dump.h |  17 +++++
 4 files changed, 136 insertions(+)

diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/imagination/Makefile
index f5072f06b4c4..1222a14262e4 100644
--- a/drivers/gpu/drm/imagination/Makefile
+++ b/drivers/gpu/drm/imagination/Makefile
@@ -8,6 +8,7 @@ powervr-y := \
 	pvr_device.o \
 	pvr_device_info.o \
 	pvr_drv.o \
+	pvr_dump.o \
 	pvr_free_list.o \
 	pvr_fw.o \
 	pvr_fw_meta.o \
diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index f89db5e3baa2..a04520e7efc0 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -4,6 +4,7 @@
 #include "pvr_ccb.h"
 #include "pvr_device.h"
 #include "pvr_drv.h"
+#include "pvr_dump.h"
 #include "pvr_free_list.h"
 #include "pvr_fw.h"
 #include "pvr_gem.h"
@@ -165,6 +166,10 @@ process_fwccb_command(struct pvr_device *pvr_dev, struct rogue_fwif_fwccb_cmd *c
 		 * suppress the "unknown" warning when receiving this command.
 		 */
 		break;
+	case ROGUE_FWIF_FWCCB_CMD_CONTEXT_RESET_NOTIFICATION:
+		pvr_dump_context_reset_notification(pvr_dev,
+					       &cmd->cmd_data.cmd_context_reset_notification);
+		break;
 
 	default:
 		drm_info(drm_dev, "Received unknown FWCCB command (type=%d)\n",
diff --git a/drivers/gpu/drm/imagination/pvr_dump.c b/drivers/gpu/drm/imagination/pvr_dump.c
new file mode 100644
index 000000000000..bb52eea8b63a
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_dump.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (c) 2026 Imagination Technologies Ltd. */
+
+#include "pvr_device.h"
+#include "pvr_dump.h"
+#include "pvr_rogue_fwif.h"
+
+#include <drm/drm_print.h>
+#include <linux/types.h>
+
+static const char *
+get_reset_reason_desc(enum rogue_context_reset_reason reason)
+{
+	switch (reason) {
+	case ROGUE_CONTEXT_RESET_REASON_NONE:
+		return "None";
+	case ROGUE_CONTEXT_RESET_REASON_GUILTY_LOCKUP:
+		return "Guilty lockup";
+	case ROGUE_CONTEXT_RESET_REASON_INNOCENT_LOCKUP:
+		return "Innocent lockup";
+	case ROGUE_CONTEXT_RESET_REASON_GUILTY_OVERRUNING:
+		return "Guilty overrunning";
+	case ROGUE_CONTEXT_RESET_REASON_INNOCENT_OVERRUNING:
+		return "Innocent overrunning";
+	case ROGUE_CONTEXT_RESET_REASON_HARD_CONTEXT_SWITCH:
+		return "Hard context switch";
+	case ROGUE_CONTEXT_RESET_REASON_WGP_CHECKSUM:
+		return "CDM Mission/safety checksum mismatch";
+	case ROGUE_CONTEXT_RESET_REASON_TRP_CHECKSUM:
+		return "TRP checksum mismatch";
+	case ROGUE_CONTEXT_RESET_REASON_GPU_ECC_OK:
+		return "GPU ECC error (corrected, OK)";
+	case ROGUE_CONTEXT_RESET_REASON_GPU_ECC_HWR:
+		return "GPU ECC error (uncorrected, HWR)";
+	case ROGUE_CONTEXT_RESET_REASON_FW_ECC_OK:
+		return "Firmware ECC error (corrected, OK)";
+	case ROGUE_CONTEXT_RESET_REASON_FW_ECC_ERR:
+		return "Firmware ECC error (uncorrected, ERR)";
+	case ROGUE_CONTEXT_RESET_REASON_FW_WATCHDOG:
+		return "Firmware watchdog";
+	case ROGUE_CONTEXT_RESET_REASON_FW_PAGEFAULT:
+		return "Firmware pagefault";
+	case ROGUE_CONTEXT_RESET_REASON_FW_EXEC_ERR:
+		return "Firmware execution error";
+	case ROGUE_CONTEXT_RESET_REASON_HOST_WDG_FW_ERR:
+		return "Host watchdog";
+	case ROGUE_CONTEXT_GEOM_OOM_DISABLED:
+		return "Geometry OOM disabled";
+
+	default:
+		return "Unknown";
+	}
+}
+
+static const char *
+get_dm_name(u32 dm)
+{
+	switch (dm) {
+	case PVR_FWIF_DM_GP:
+		return "General purpose";
+	/* PVR_FWIF_DM_TDM has the same index, but is discriminated by a device feature */
+	case PVR_FWIF_DM_2D:
+		return "2D or TDM";
+	case PVR_FWIF_DM_GEOM:
+		return "Geometry";
+	case PVR_FWIF_DM_FRAG:
+		return "Fragment";
+	case PVR_FWIF_DM_CDM:
+		return "Compute";
+	case PVR_FWIF_DM_RAY:
+		return "Raytracing";
+	case PVR_FWIF_DM_GEOM2:
+		return "Geometry 2";
+	case PVR_FWIF_DM_GEOM3:
+		return "Geometry 3";
+	case PVR_FWIF_DM_GEOM4:
+		return "Geometry 4";
+
+	default:
+		return "Unknown";
+	}
+}
+
+/**
+ * pvr_dump_context_reset_notification() - Handle context reset notification from FW
+ * @pvr_dev: Device pointer.
+ * @data: Data provided by FW.
+ *
+ * This will decode the data structure provided by FW and print the results via drm_info().
+ */
+void
+pvr_dump_context_reset_notification(struct pvr_device *pvr_dev,
+			       struct rogue_fwif_fwccb_cmd_context_reset_data *data)
+{
+	struct drm_device *drm_dev = from_pvr_device(pvr_dev);
+
+	if (data->flags & ROGUE_FWIF_FWCCB_CMD_CONTEXT_RESET_FLAG_ALL_CTXS) {
+		drm_info(drm_dev, "Received context reset notification for all contexts\n");
+	} else {
+		drm_info(drm_dev, "Received context reset notification on context %u\n",
+			 data->server_common_context_id);
+	}
+
+	drm_info(drm_dev, "  Reset reason=%u (%s)\n", data->reset_reason,
+		 get_reset_reason_desc((enum rogue_context_reset_reason)data->reset_reason));
+	drm_info(drm_dev, "  Data Master=%u (%s)\n", data->dm, get_dm_name(data->dm));
+	drm_info(drm_dev, "  Job ref=%u\n", data->reset_job_ref);
+
+	if (data->flags & ROGUE_FWIF_FWCCB_CMD_CONTEXT_RESET_FLAG_PF) {
+		drm_info(drm_dev, "  Page fault occurred, fault address=%llx\n",
+			data->fault_address);
+	}
+}
diff --git a/drivers/gpu/drm/imagination/pvr_dump.h b/drivers/gpu/drm/imagination/pvr_dump.h
new file mode 100644
index 000000000000..1e3e68694f5f
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_dump.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/* Copyright (c) 2026 Imagination Technologies Ltd. */
+
+#ifndef PVR_DUMP_H
+#define PVR_DUMP_H
+
+/* Forward declaration from pvr_device.h. */
+struct pvr_device;
+
+/* Forward declaration from pvr_rogue_fwif.h. */
+struct rogue_fwif_fwccb_cmd_context_reset_data;
+
+void
+pvr_dump_context_reset_notification(struct pvr_device *pvr_dev,
+			       struct rogue_fwif_fwccb_cmd_context_reset_data *data);
+
+#endif /* PVR_DUMP_H */

-- 
2.43.0

