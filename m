Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E1C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2FE10E1EC;
	Mon, 10 Aug 2026 12:33:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="RPJbl+Ze";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E6E10E1EC;
 Mon, 10 Aug 2026 12:33:14 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9RiM72030388; Mon, 10 Aug 2026 13:33:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=oUZvCmtOXPOypLF3e3z6uVU
 HjYcLuXvafk1VGuEVzNM=; b=RPJbl+ZepfTr4cqSLKCch9xffsNyRkQic1rllEw
 m3mZwisvWTDLIxS9HQkahrYsfhBINvy1oy/NjAPIKoWbqPWlRIInhdBePJS2NLQt
 o6gDTyrp34XaoHYhZtEjwOa8tWBtSWMcs29DJQRP1JE08pH4kl6vvPVvNW4sgJSg
 pgag2xOmoftUoZ0y+oZP31BzL6Odny4CUBar3D6zN+2I0g0osbTsQfvw97s3cE1m
 yqjCGJ3LAiYBfUpcBBgDTBW4ynwqNFmCl6/abv6aWrdZiK5beotNCUvX4aueMvsA
 D923IxTn+3AMMqurGGaZYR2s2AxE8MqsR+ZY5ez1K42ZCBg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fwvhtsp6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 13:33:03 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 13:31:42 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 10 Aug 2026 15:31:26 +0300
Subject: [PATCH] drm/imagination: Manage FW VM context from its init and
 fini callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260810-b4-upstream-manage-fw-vm-context-from-init-and-fini-v1-1-2c6229e36e5e@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAJ7EeWoC/yWNQQrCMBBFr1Jm7UBStKhXERfpZKIjZFKStBZK7
 27U3X/weW+Dwlm4wLXbIPMiRZI2sIcO6On0wSi+MfSmH8zZGhyPOE+lZnYRo1PXHuGNS0RKWnm
 tGHKKKCoVnXoMbaG9nMh7Y4kGA808ZQ6y/qq3+5/LPL6Y6jcF+/4BmMNSvpcAAAA=
X-Change-ID: 20260810-b4-upstream-manage-fw-vm-context-from-init-and-fini-195cdd01cc60
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Paul Walmsley <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786365102; l=5570;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=C2e+L340zP0q8i9wzAJkeQrcy6Gd0cpDPGEkKEQ+voQ=;
 b=Ga+hVoe749netVN9cG8oN2rN8vAlMn+1bt33qc6fPJ1aqIDvju5uzQ2PcdczaI/otM02LC5av
 5um01RVox6tAJ8wV0+VD0Giv0L4b9wYOZmpCtAOP5YToNphweDY5mVM
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-GUID: lxQVhyrlLz8IxJG28pus3U--AZAQT0Ar
X-Proofpoint-ORIG-GUID: lxQVhyrlLz8IxJG28pus3U--AZAQT0Ar
X-Authority-Analysis: v=2.4 cv=Xt7K/1F9 c=1 sm=1 tr=0 ts=6a79c4ff cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=Ubvqm-L7-7mULy6RTAoA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNyBTYWx0ZWRfX1nJxi8ctN4+s
 RuRTFaJAcYuVJj/ktsIpIoRwl6ODAK+ZoYKqaqHR1EQ+iujxqHpb7x/1JGS0zggTsxptSga3Nlr
 PbQz/jYk8qh6xOHkOsi8WhIc25/F0H2pjRmwV0X6TAHoX6rWrgxCGmESDHbCVcEaXmtdRjqpBpQ
 JfAjcyrjq8S2gdtuYfOWlSzcA0Dilyao5QaUKeYQ5GMjag0kG4TC053NGee3nBn0yn27uiq7MHE
 ekufE+lh8LBmhlpVz4GQgqOIUwqwgAEHsX2KWKBJoAo2EH9AuQjG+8dokhd9BIrBxXkTedZ0zQo
 +8eloZlrrWEXkDm1UgQZByBSt7LfirxHyqtuDrCqpZwCqKya886yh4tofCPyzZf5OXEcrpCKLy2
 UD5SpowjXYUtKbe8wULumt2OSwevcJcPqDUqCGNd4NaCdMyOyQnnKYmVqc7pXTS01LQAQvm7aJu
 gUSc1btwjWoWnh3ePRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNyBTYWx0ZWRfXztPIyC+fMSOw
 76xapPmqGKbfmbFl80Ir1xXwztDuKwjaYI0oSMcwgGYfNm/b2aQzb51coSz0XNduOOlq2M4xcJA
 e4Vilkai+rbVvyvoYc+wJyph90FR3VU=
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

While the MIPS firmware virtual memory context is created and destroyed
from within the MIPS firmware init and fini callbacks, the META and
RISC-V firmware contexts are created and destroyed from within blocks
right before or after those callbacks.

Match the logic for all firmware processors by moving those blocks to
the META and RISC-V init and fini callbacks.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_device.c   | 25 +------------------------
 drivers/gpu/drm/imagination/pvr_fw.c       |  6 ++----
 drivers/gpu/drm/imagination/pvr_fw.h       |  2 +-
 drivers/gpu/drm/imagination/pvr_fw_meta.c  | 12 ++++++++++++
 drivers/gpu/drm/imagination/pvr_fw_riscv.c | 12 ++++++++++++
 5 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/imagination/pvr_device.c
index 54fe4180c73c..35eaa54f75ed 100644
--- a/drivers/gpu/drm/imagination/pvr_device.c
+++ b/drivers/gpu/drm/imagination/pvr_device.c
@@ -697,25 +697,7 @@ pvr_device_gpu_init(struct pvr_device *pvr_dev)
 	if (err)
 		return err;
 
-	if (pvr_dev->fw_dev.processor_type != PVR_FW_PROCESSOR_TYPE_MIPS) {
-		pvr_dev->kernel_vm_ctx = pvr_vm_create_context(pvr_dev, false);
-		if (IS_ERR(pvr_dev->kernel_vm_ctx))
-			return PTR_ERR(pvr_dev->kernel_vm_ctx);
-	}
-
-	err = pvr_fw_init(pvr_dev);
-	if (err)
-		goto err_vm_ctx_put;
-
-	return 0;
-
-err_vm_ctx_put:
-	if (pvr_dev->fw_dev.processor_type != PVR_FW_PROCESSOR_TYPE_MIPS) {
-		pvr_vm_context_put(pvr_dev->kernel_vm_ctx);
-		pvr_dev->kernel_vm_ctx = NULL;
-	}
-
-	return err;
+	return pvr_fw_init(pvr_dev);
 }
 
 /**
@@ -726,11 +708,6 @@ static void
 pvr_device_gpu_fini(struct pvr_device *pvr_dev)
 {
 	pvr_fw_fini(pvr_dev);
-
-	if (pvr_dev->fw_dev.processor_type != PVR_FW_PROCESSOR_TYPE_MIPS) {
-		WARN_ON(!pvr_vm_context_put(pvr_dev->kernel_vm_ctx));
-		pvr_dev->kernel_vm_ctx = NULL;
-	}
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw.c b/drivers/gpu/drm/imagination/pvr_fw.c
index 850a3ec8e775..58ee51cd65df 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.c
+++ b/drivers/gpu/drm/imagination/pvr_fw.c
@@ -1029,8 +1029,7 @@ pvr_fw_init(struct pvr_device *pvr_dev)
 err_mm_takedown:
 	drm_mm_takedown(&fw_dev->fw_mm);
 
-	if (fw_dev->defs->fini)
-		fw_dev->defs->fini(pvr_dev);
+	fw_dev->defs->fini(pvr_dev);
 
 	return err;
 }
@@ -1063,8 +1062,7 @@ pvr_fw_fini(struct pvr_device *pvr_dev)
 
 	drm_mm_takedown(&fw_dev->fw_mm);
 
-	if (fw_dev->defs->fini)
-		fw_dev->defs->fini(pvr_dev);
+	fw_dev->defs->fini(pvr_dev);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_fw.h b/drivers/gpu/drm/imagination/pvr_fw.h
index 3390c84e4fd3..4b25291135b6 100644
--- a/drivers/gpu/drm/imagination/pvr_fw.h
+++ b/drivers/gpu/drm/imagination/pvr_fw.h
@@ -86,7 +86,7 @@ struct pvr_fw_defs {
 	 * FW processor specific finalisation.
 	 * @pvr_dev: Target PowerVR device.
 	 *
-	 * This function is optional.
+	 * This function is mandatory.
 	 */
 	void (*fini)(struct pvr_device *pvr_dev);
 
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index 9ff03bc60a08..6c5dc711e81e 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -500,9 +500,20 @@ pvr_meta_init(struct pvr_device *pvr_dev)
 {
 	pvr_fw_heap_info_init(pvr_dev, ROGUE_FW_HEAP_META_SHIFT, 0);
 
+	pvr_dev->kernel_vm_ctx = pvr_vm_create_context(pvr_dev, false);
+	if (IS_ERR(pvr_dev->kernel_vm_ctx))
+		return PTR_ERR(pvr_dev->kernel_vm_ctx);
+
 	return 0;
 }
 
+static void
+pvr_meta_fini(struct pvr_device *pvr_dev)
+{
+	WARN_ON(!pvr_vm_context_put(pvr_dev->kernel_vm_ctx));
+	pvr_dev->kernel_vm_ctx = NULL;
+}
+
 static u32
 pvr_meta_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 {
@@ -550,6 +561,7 @@ pvr_meta_irq_clear(struct pvr_device *pvr_dev)
 
 const struct pvr_fw_defs pvr_fw_defs_meta = {
 	.init = pvr_meta_init,
+	.fini = pvr_meta_fini,
 	.fw_process = pvr_meta_fw_process,
 	.vm_map = pvr_meta_vm_map,
 	.vm_unmap = pvr_meta_vm_unmap,
diff --git a/drivers/gpu/drm/imagination/pvr_fw_riscv.c b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
index fc13d483be9a..58bacc522e72 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_riscv.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_riscv.c
@@ -103,9 +103,20 @@ pvr_riscv_init(struct pvr_device *pvr_dev)
 {
 	pvr_fw_heap_info_init(pvr_dev, ROGUE_FW_HEAP_RISCV_SHIFT, 0);
 
+	pvr_dev->kernel_vm_ctx = pvr_vm_create_context(pvr_dev, false);
+	if (IS_ERR(pvr_dev->kernel_vm_ctx))
+		return PTR_ERR(pvr_dev->kernel_vm_ctx);
+
 	return 0;
 }
 
+static void
+pvr_riscv_fini(struct pvr_device *pvr_dev)
+{
+	WARN_ON(!pvr_vm_context_put(pvr_dev->kernel_vm_ctx));
+	pvr_dev->kernel_vm_ctx = NULL;
+}
+
 static u32
 pvr_riscv_get_fw_addr_with_offset(struct pvr_fw_object *fw_obj, u32 offset)
 {
@@ -154,6 +165,7 @@ pvr_riscv_irq_clear(struct pvr_device *pvr_dev)
 
 const struct pvr_fw_defs pvr_fw_defs_riscv = {
 	.init = pvr_riscv_init,
+	.fini = pvr_riscv_fini,
 	.fw_process = pvr_riscv_fw_process,
 	.vm_map = pvr_riscv_vm_map,
 	.vm_unmap = pvr_riscv_vm_unmap,

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260810-b4-upstream-manage-fw-vm-context-from-init-and-fini-195cdd01cc60

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

