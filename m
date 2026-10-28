Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D45606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=iJe4ykAk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A89B810FC8A;
	Wed, 28 Oct 2026 13:30:30 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E9D10E4E1;
 Wed, 28 Oct 2026 13:30:22 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBfAnK4125914; Wed, 28 Oct 2026 13:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=i
 E3jkDrgO5CnBrcoM0r9FFl+l4m7NOoxZg4vNkqlxqk=; b=iJe4ykAk03uTNytdH
 mOmq4JCDeKtgw1hsorq+QWPSF4lvikC8TC+SXZSDh9XWyL2TPaOeBu6FLGS+ZpFc
 c5SP0YOZ173AKYsKNfYsAS1sopyHyjg5AWulXEPt3DbXhrMc85RUwqkkUtW+cnGc
 7hbQBdKP2aEhoKXnpOTTltA56Vub51WJnFS3BKXyZOuDyH74R52K5jpWUa0sUJZP
 t1GOes/06YKB4Q5S6Tfhh1+QlkL5rEFvFUg3Nmt3nZz2/CyX9rAlkZzZS/4yMDmG
 ZGnpRHr3+QU3HCQWJg2hCuIDLjzWHAXmqAxrmSV7tCVcg8xKuo2+Nwqam09+UrDR
 rm33A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hk414ghyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 13:30:11 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 13:30:09 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 28 Oct 2026 15:29:36 +0200
Subject: [PATCH 4/5] drm/imagination: Limit access to the META firmware
 interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261028-prep-meta-fw-arch-independent-v1-4-73e116f02172@imgtec.com>
References: <20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com>
In-Reply-To: <20261028-prep-meta-fw-arch-independent-v1-0-73e116f02172@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793194203; l=11364;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=N8VZ755b5gzWXG/9RgySorm2ehMgH1rvaI87rjE8two=;
 b=9CEXmYrh/th6Ixm00vj2QzWTG7NL1XO+BVE3ruvcFMBxw4N0jHpt1cEFeY1TgKu96F0awegtT
 PZPvzmdYd8uCC2746VOzqCV2A77+uoUZpB2PAJj2DR2mP5OR6y9/q2v
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MyBTYWx0ZWRfX0hch6PAKvDNM
 NHbyWLwmd2G00xmuIJeG+nmv0eRmj8cSL7AG5SLOrqRlPMldqn+4xdxhb4t/8xTmA2Luc1giRa2
 cmeFq74JnWBvRJlnYJbsDxHEUT2NID8=
X-Authority-Analysis: v=2.4 cv=AMk9Hd7f c=1 sm=1 tr=0 ts=6ae1f8e3 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=v5vwIpuZDtUGK11seQkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: j9r5sj86mo75gMMBr89hXFMu6Zu9S9VN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MyBTYWx0ZWRfX3S9XoiQ7rKcN
 KaBLSNXry68tMeTbx4z1qGj9NtsVINR+9yIxdQImvTZ7R2I/++XoDldVjS4dCqR13qdkX6oK8Ck
 M5iZxFYno2mAuZOTK9ZUNqE2C1MFfl0XlfhQPrY++490H0KY5waEmk1Fhx5cqV3tzp2bWn8G8xJ
 EeKJrgg5Z3PRSwRjg2yB+eoy7UgPkf9hnMGXFj2VVumSsaeS2zl0UCutabTLg7uE760IAzEsZxu
 iwigw0anBJXCkuAFJxvHfoBUzjO3cp43c/q3Duxqghj+0LOh5fGd90VBF1p9VQBVznRtoidR3OH
 zjjJ9u74UFBZgMKU7e1CyUTm7cAkAoZIoiawAJcOM9AtbpeFvghWX3GeF+6UVlQKWmptI5mc1Gj
 5iCHzKgPK3B3tEqNBjc/clbXt+skg41zPjM3PFfWNQ6iqDQdBDOhaWcJpY8z/9BdvqDayiJ0ekv
 3ed60NhvaSpJ6DgIo9Q==
X-Proofpoint-GUID: j9r5sj86mo75gMMBr89hXFMu6Zu9S9VN
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

From: Alessio Belle <alessio.belle@imgtec.com>

Ensure all accesses to the META firmware interface are done via the
generic firmware interface.

To achieve this:
- Introduce a new function to the firmware processor table to remove
  the last direct access to the META firmware interface from
  outside of the generic firmware logic.
- Remove the META firmware interface header.
- Rename the META firmware processor header adding an "internal" suffix.
- Add guard to the META firmware processor header to prevent accidental
  inclusion outside of the META firmware specific logic.
- Add a multi_dm_thread_assoc property to struct pvr_fw_defs to isolate
  that behaviour from the architecture.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw.h               | 26 +++++++++
 drivers/gpu/drm/imagination/pvr_fw_meta.c          | 28 ++++++++--
 drivers/gpu/drm/imagination/pvr_fw_meta.h          | 14 -----
 drivers/gpu/drm/imagination/pvr_fw_mips.c          |  1 +
 drivers/gpu/drm/imagination/pvr_fw_riscv.c         |  1 +
 drivers/gpu/drm/imagination/pvr_fw_startstop.c     | 61 ++++++++++++----------
 drivers/gpu/drm/imagination/pvr_gem.h              |  1 -
 ...{pvr_rogue_meta.h => pvr_rogue_meta_internal.h} | 10 ++--
 8 files changed, 93 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 4b25291135b6..610406668bbb 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -184,6 +184,23 @@ struct pvr_fw_defs {
 	 */
 	void (*irq_clear)(struct pvr_device *pvr_dev);
 
+	/**
+	 * @must_wait_fw_idle: Check if the FW stop sequence should wait for hardware
+	 *                     to report FW idle before proceeding.
+	 *
+	 * @pvr_dev: Target PowerVR device.
+	 * @wait[out]: Whether the FW stop sequence should wait for FW idle.
+	 *
+	 * This function is optional. The assumption is that we must always wait
+	 * for the firmware to reach idle; implement this function and return
+	 * %false to alter this behavior.
+	 *
+	 * Returns:
+	 *  * 0 on success.
+	 *  * Any appropriate error on failure.
+	 */
+	int (*must_wait_fw_idle)(struct pvr_device *pvr_dev, bool *wait);
+
 	/**
 	 * @has_fixed_data_addr: Specify whether the firmware fixed data must be loaded at the
 	 *                       address given by the firmware layout table.
@@ -191,6 +208,15 @@ struct pvr_fw_defs {
 	 * This value is mandatory.
 	 */
 	bool has_fixed_data_addr;
+
+	/**
+	 * @multi_dm_thread_assoc: Specify that all threads must be associated
+	 *                         with the DM separately rather than just the
+	 *                         first thread (the default behaviour).
+	 *
+	 * This value is mandatory.
+	 */
+	bool multi_dm_thread_assoc;
 };
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 84f568b5510f..f451f97a4f2f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -4,10 +4,11 @@
 #include "pvr_device.h"
 #include "pvr_fw.h"
 #include "pvr_fw_info.h"
-#include "pvr_fw_meta.h"
 #include "pvr_gem.h"
 #include "pvr_rogue_cr_defs.h"
-#include "pvr_rogue_meta.h"
+#define PVR_ROGUE_META_INTERNAL_H_EXPLICIT_INCLUDE
+#include "pvr_rogue_meta_internal.h"
+#undef PVR_ROGUE_META_INTERNAL_H_EXPLICIT_INCLUDE
 #include "pvr_vm.h"
 
 #include <linux/compiler.h>
@@ -32,7 +33,7 @@
  *  * 0 on success, or
  *  * Any error returned by pvr_cr_poll_reg32().
  */
-int
+static int
 pvr_meta_cr_read32(struct pvr_device *pvr_dev, u32 reg_addr, u32 *reg_value_out)
 {
 	int err;
@@ -563,6 +564,25 @@ pvr_meta_irq_clear(struct pvr_device *pvr_dev)
 		       ROGUE_CR_META_SP_MSLVIRQSTATUS_TRIGVECT2_CLRMSK);
 }
 
+static int
+pvr_meta_must_wait_fw_idle(struct pvr_device *pvr_dev, bool *wait)
+{
+	u32 reg_value;
+	int err;
+
+	err = pvr_meta_cr_read32(pvr_dev, META_CR_TxVECINT_BHALT, &reg_value);
+	if (err)
+		return err;
+
+	/*
+	 * Wait for Sidekick/Jones to signal IDLE including the Garten
+	 * Wrapper if there is no debugger attached (TxVECINT_BHALT = 0x0).
+	 */
+	*wait = !reg_value;
+
+	return 0;
+}
+
 const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.init = pvr_meta_init,
 	.fini = pvr_meta_fini,
@@ -573,5 +593,7 @@ const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.wrapper_init = pvr_meta_wrapper_init,
 	.irq_pending = pvr_meta_irq_pending,
 	.irq_clear = pvr_meta_irq_clear,
+	.must_wait_fw_idle = pvr_meta_must_wait_fw_idle,
 	.has_fixed_data_addr = false,
+	.multi_dm_thread_assoc = true,
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.h b/drivers/gpu/drm/imagination/pvr_fw_meta.h
deleted file mode 100644
index 911ad700cba6..000000000000
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
-/* Copyright (c) 2023 Imagination Technologies Ltd. */
-
-#ifndef PVR_FW_META_H
-#define PVR_FW_META_H
-
-#include <linux/types.h>
-
-/* Forward declaration from pvr_device.h */
-struct pvr_device;
-
-int pvr_meta_cr_read32(struct pvr_device *pvr_dev, u32 reg_addr, u32 *reg_value_out);
-
-#endif /* PVR_FW_META_H */
diff --git a/drivers/gpu/drm/imagination/pvr_fw_mips.c b/drivers/gpu/drm/imagination/pvr_fw_mips.c
index 6914fc46db50..ec0dad1692c3 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_mips.c
@@ -196,4 +196,5 @@ const struct pvr_fw_defs pvr_fw_defs_mips = {
 	.irq_pending = pvr_mips_irq_pending,
 	.irq_clear = pvr_mips_irq_clear,
 	.has_fixed_data_addr = true,
+	.multi_dm_thread_assoc = false,
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index 2b24c40bc20f..ef2801276252 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -182,4 +182,5 @@ const struct pvr_fw_defs pvr_fw_defs_riscv = {
 	.irq_pending = pvr_riscv_irq_pending,
 	.irq_clear = pvr_riscv_irq_clear,
 	.has_fixed_data_addr = false,
+	.multi_dm_thread_assoc = false,
 };
diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index 98ca2692239d..9a617f78256e 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -3,10 +3,8 @@
 
 #include "pvr_device.h"
 #include "pvr_fw.h"
-#include "pvr_fw_meta.h"
 #include "pvr_fw_startstop.h"
 #include "pvr_rogue_cr_defs.h"
-#include "pvr_rogue_meta.h"
 #include "pvr_vm.h"
 
 #include <linux/compiler.h>
@@ -199,6 +197,30 @@ pvr_fw_start(struct pvr_device *pvr_dev)
 	return err;
 }
 
+static inline bool layout_is_mars(struct pvr_device *pvr_dev)
+{
+	u64 layout_mars_value = 0;
+
+	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value))
+		return layout_mars_value > 0;
+
+	return false;
+}
+
+static inline int must_wait_fw_idle_before_stop(struct pvr_device *pvr_dev)
+{
+	bool wait_fw_idle = false;
+	int err;
+
+	if (pvr_dev->fw_dev.defs->must_wait_fw_idle) {
+		err = pvr_dev->fw_dev.defs->must_wait_fw_idle(pvr_dev, &wait_fw_idle);
+		if (err)
+			return err;
+	}
+
+	return wait_fw_idle;
+}
+
 /**
  * pvr_fw_stop() - Stop FW processor
  * @pvr_dev: Target PowerVR device.
@@ -214,15 +236,9 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 				       ~(ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_SOCIF_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_HOSTIF_EN);
-	bool skip_garten_idle = false;
-	u64 layout_mars_value = 0;
-	bool layout_mars = false;
-	bool meta_fw = pvr_dev->fw_dev.processor_type == PVR_FW_PROCESSOR_TYPE_META;
-	u32 reg_value;
-	int err;
 
-	if (PVR_FEATURE_VALUE(pvr_dev, layout_mars, &layout_mars_value) == 0)
-		layout_mars = layout_mars_value > 0;
+	bool layout_mars = layout_is_mars(pvr_dev);
+	int err;
 
 	/*
 	 * For cores with the LAYOUT_MARS feature, SIDEKICK and SLC would have been
@@ -250,7 +266,7 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 		       ROGUE_CR_MTS_BGCTX_THREAD0_DM_ASSOC_MASKFULL &
 		       ROGUE_CR_MTS_BGCTX_THREAD0_DM_ASSOC_DM_ASSOC_CLRMSK);
 
-	if (meta_fw) {
+	if (pvr_dev->fw_dev.defs->multi_dm_thread_assoc) {
 		pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC,
 			       ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC_MASKFULL &
 			       ROGUE_CR_MTS_INTCTX_THREAD1_DM_ASSOC_DM_ASSOC_CLRMSK);
@@ -297,6 +313,8 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 	 * powered down by the FW.
 	 */
 	if (!layout_mars) {
+		int wait_fw_idle;
+
 		/* Wait for SLC to signal IDLE. */
 		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
 					ROGUE_CR_SLC_IDLE_MASKFULL,
@@ -309,24 +327,12 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 					sidekick_idle_mask, POLL_TIMEOUT_USEC);
 		if (err)
 			return err;
-	}
 
-	if (meta_fw) {
-		err = pvr_meta_cr_read32(pvr_dev, META_CR_TxVECINT_BHALT, &reg_value);
-		if (err)
-			return err;
-
-		/*
-		 * Wait for Sidekick/Jones to signal IDLE including the Garten
-		 * Wrapper if there is no debugger attached (TxVECINT_BHALT =
-		 * 0x0).
-		 */
-		if (reg_value)
-			skip_garten_idle = true;
-	}
+		wait_fw_idle = must_wait_fw_idle_before_stop(pvr_dev);
+		if (wait_fw_idle < 0)
+			return wait_fw_idle;
 
-	if (meta_fw || !layout_mars) {
-		if (!skip_garten_idle) {
+		if (wait_fw_idle) {
 			err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
 						ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
 						ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
@@ -346,7 +352,6 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 					ROGUE_CR_MARS_IDLE_CPU_EN |
 					ROGUE_CR_MARS_IDLE_MH_SYSARB0_EN,
 					POLL_TIMEOUT_USEC);
-
 		if (err)
 			return err;
 	}
diff --git a/drivers/gpu/drm/imagination/pvr_gem.h b/drivers/gpu/drm/imagination/pvr_gem.h
index ae7af82b6f17..e84be25f8576 100644
--- a/drivers/gpu/drm/imagination/pvr_gem.h
+++ b/drivers/gpu/drm/imagination/pvr_gem.h
@@ -5,7 +5,6 @@
 #define PVR_GEM_H
 
 #include "pvr_heap_config.h"
-#include "pvr_rogue_meta.h"
 
 #include <uapi/drm/pvr_drm.h>
 
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_meta.h b/drivers/gpu/drm/imagination/pvr_rogue_meta_internal.h
similarity index 98%
rename from drivers/gpu/drm/imagination/pvr_rogue_meta.h
rename to drivers/gpu/drm/imagination/pvr_rogue_meta_internal.h
index 3020e6582daa..dd978988ed40 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_meta.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_meta_internal.h
@@ -1,8 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR MIT */
 /* Copyright (c) 2023 Imagination Technologies Ltd. */
 
-#ifndef PVR_ROGUE_META_H
-#define PVR_ROGUE_META_H
+#ifndef PVR_ROGUE_META_INTERNAL_H
+#define PVR_ROGUE_META_INTERNAL_H
+
+#ifndef PVR_ROGUE_META_INTERNAL_H_EXPLICIT_INCLUDE
+#error This file may only be included if explicitly defined
+#endif
 
 /***** The META HW register definitions in the file are updated manually *****/
 
@@ -353,4 +357,4 @@ struct rogue_meta_ldr_cfg_blk {
 
 #define ROGUE_FW_PROCESSOR_META "META"
 
-#endif /* PVR_ROGUE_META_H */
+#endif /* PVR_ROGUE_META_INTERNAL_H */

-- 
2.43.0

