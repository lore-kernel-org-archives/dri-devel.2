Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0CDCD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD1710F38F;
	Fri, 12 Jun 2026 09:10:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G5pAQQsv";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6211F10F38F;
 Fri, 12 Jun 2026 09:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rspb1xVqNTrhQaHAdynQwmgaDTq5VegpyytVJtDnVmQnnQ+f9NYoXFk9Yhk8fi6dm1AWz0uYrGjDrtYffARUTiOkfYNX6dYmH9BqR4v0fel1OAd+uxzU8C4wFjEJktlPIXPmeUapvQgET6WiUMUacFGuIXphqjwXZG/7pLrr3sv6XGvNn3vLFZc98h+PS9/vQmiGRZIioeUIFHpgJPc10vR0lNEpEc8HOD8cISsD8ruIK/2q0xLe3dxZFOEsK+PBCzMJh87uWgMDb1IdfA1DkenR5lBFwQ5tqd4/zuQObNyLQ3vPAjiP2LXDrKUPMDQ3BMU7TgLulrGcgJbaFLo46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An5v6gr1LcOH7lFrIZWGSUFQjjLsAW9AQwq8GG3dM48=;
 b=I8avNQ/TeCH404X5Mcgtj0X2o+PVzxY4+U/37VmQG988Ln7TowDDjxF+FroxrBWCjKr/9vQHQ2ZDTotdJiIRyRhDy4lIoC6HmIzuNBp+AEuykDkYPhfLkgXXONLhuLz3usSTfIho2KPHTY+9YkuV5bwmqJWNL9GEkHvfUbkYUGKpvCzvmdd0V8bwX3AxTC9MIvoUmlhnM0kYN0NXcQOLuCXxgSLhOtpkJYoEl9IUDYS7GTetDbm/3OlytGHvmmnK+hxQODAh9sFzycxR7h44alpvnlqtsaiIN5n9qCh9GsKss6hQJu6aAQuemnh0rpFV5ILHWtC/a38lGMkN52109g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An5v6gr1LcOH7lFrIZWGSUFQjjLsAW9AQwq8GG3dM48=;
 b=G5pAQQsvs3/LTyb4Xj68cdjKvABdnYgZ5+6pR+xVCsB8wfKDVAZuCg7tMmY6SUEhe+1bV+ijQWl3rTdmG893gRrQQf0m1cuc9z+oZODXs+QHvJVuWaW8L5LHfpx6XO2PmdjJQjUhCtMC/oM4Ictt6ZaYm0uXrtTRkjwlPmow46w=
Received: from CH0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:610:11a::11)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Fri, 12 Jun
 2026 09:10:35 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::5d) by CH0PR03CA0360.outlook.office365.com
 (2603:10b6:610:11a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 09:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:10:35 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:10:30 -0500
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
Date: Fri, 12 Jun 2026 17:09:09 +0800
Message-ID: <20260612090928.29682-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d223280-e9f3-4e84-25d0-08dec862766f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|921020|22082099003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yn8bI8JLnm9xk/0/K2tiIg+yQSizbQlKMTfoyo5bjly23XvHdSVlOFSKiH5Th62bhHlhz58+/ZSlECopTxnjLf6QljUrvspsk/2mtgCh2nUccOII4extSX5Wn+fgIxYTAK5VAYFVuicl3lTh2LsM/IyxqgCdR9XqKZiB8x/G7tVM7vL66x2NIuf2IibGPguqb9WBsCxQQ/sizzO7omQq9O93dYsd/CNMzdt6xkElgixiLw9QWN9nimHgIu8HVWE+En4w0l/phsjDKD39mesAQNR65jC4jhkvz4ZMENS0NUmkkDKaAKRvhW9aoE3dOEhx8YFl1sv9YEU81Vs0Lmpi68tbs+OUbkAhmx9XigFnHOREmM8slZlRAsjs2X7Y81J+RvDb047ueoPfSF8fX95OUj7oPMuJ6fwxaUjZnMLCaj4CnEhV045lEcIDsunY9Y4/eoUiGz1pxnHIez9SWxQrQvauIg8BKKCIUc5dHT813dynXRXEN1D/359KMO5Ow17P+Zj0oSFsOG1KR0IFd8Fnt4C8g1q98RKp3wiQJD34vwUTr8H5+PGZvr0VCYlr/k9DXtZVr99ao8ZM6o4MWtOtQLHQx35gcFNIvBXsskewNBx+AVM7QjgSUttx1Jy9XxnMIxfAUEME2MCYNVADcOquKwDSf7XTQKrk2JKSCsLE5fxM6Um34oJcAlJBJznx68Ar7dnNsTUWQqWQ/icU0PPxIUa48EHQyzhhCXdnuNozkJsUnR7gBICCkQl16p9bDrqmYVtOqpFxohS3lLQtHZj61g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(921020)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nLKUbAvLuOMSsGIthVGXQaboErFVgoCpU5CiAL4+lNWTqOva7+bVsL340RDfIwVzGSBzwLoFmTYnDssmMZpQO+WH7riOkpbCUj20Vcf59S+LjlGyBDsROjq+cNH98of1giXlvd7o+ictCXXJkjLx9YGw7w/hduTl0NsXE3lzGMGdZeCWynx8Src7FwQ3wkJRLCRfCew6yROfnJNMgKquMtklUsXPNm7TGnlKfMEjJHv8AF8IorqOYARdD8BrPrXyDdKZ6wV8nOdeXLzvmJdlD0Peq25d7Qd4n+s/teqQp9rVKtheo/cToS9JXhf/AjbTjEoCvEp4Bk2vdxVEv9VcafgiQcZxFm//s5UeQrMifk8U7u5INRBvmPPTzLVTx05nn/HMLZGo4REvs3GGjGFoBYXFgNrdZ+T8WVJFf0OIpMMXl99Pa3X4uep/2nJBcb4O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:35.2240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d223280-e9f3-4e84-25d0-08dec862766f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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

From: Honglei Huang <honghuan@amd.com>

Implement GPU page table mapping in amdgpu_svm_range.c:
- amdgpu_svm_range_pages_valid: check notifier sequence validity
- amdgpu_svm_range_is_valid: validate gpu_mapped and attr_flags
  against the requested attribute set, under MMU notifier lock.
- amdgpu_svm_range_zap_ptes: clear GPU PTEs via amdgpu_vm_update_range
- amdgpu_svm_range_attr_pte_flags: compute PTE flags per GC IP version
- amdgpu_svm_range_lock_vm_pd: acquire VM page directory by drm_exec
- amdgpu_svm_range_update_gpu_range: DMA segment coalescing; recomputes
  PTE flags per segment from entry->proto via attr_pte_flags, then
  programs PTEs under notifier lock
- amdgpu_svm_range_find_or_insert: wrapper of drm gpu SVM find or insert
  API.
- amdgpu_svm_range_get_pages: wrapper of drm gpu SVM get pages.
- amdgpu_svm_range_evict: thin wrapper of drm_gpusvm_range_evict
- amdgpu_svm_range_update_mapping: full pipeline (lock PD, validate
  pages, program PTEs, update PDEs, flush TLB, record attr_flags
  and mapped state); takes attrs + read_only and forwards them to
  update_gpu_range
- amdgpu_svm_range_map_attrs: cursor based iteration across attr tree,
  creating/mapping ranges

- Add to amdgpu_svm.h driver private interconnect tags used in
drm_pagemap_addr.proto:
  AMDGPU_INTERCONNECT_VRAM = DRM_INTERCONNECT_DRIVER
  AMDGPU_INTERCONNECT_P2P  = AMDGPU_INTERCONNECT_VRAM + 1

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 488 ++++++++++++++++++
 2 files changed, 492 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
index 9884a1f834d67..ac84b80f750f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h
@@ -27,6 +27,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_gpusvm.h>
+#include <drm/drm_pagemap.h>
 #include <linux/atomic.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -44,6 +45,9 @@ struct amdgpu_svm_attrs;
 struct drm_device;
 struct drm_file;
 
+#define AMDGPU_INTERCONNECT_VRAM	DRM_INTERCONNECT_DRIVER
+#define AMDGPU_INTERCONNECT_P2P		(AMDGPU_INTERCONNECT_VRAM + 1)
+
 enum amdgpu_svm_xnack_mode {
 	AMDGPU_SVM_XNACK_OFF,
 	AMDGPU_SVM_XNACK_ON,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
new file mode 100644
index 0000000000000..e1b392b2cf56a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,488 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_attr.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_svm_fault.h"
+#include "amdgpu.h"
+#include "amdgpu_vm.h"
+
+#include <drm/drm_exec.h>
+#include <drm/drm_pagemap.h>
+
+#include <linux/mmu_notifier.h>
+#include <uapi/linux/kfd_ioctl.h>
+
+bool
+amdgpu_svm_range_pages_valid(struct amdgpu_svm *svm,
+		  struct amdgpu_svm_range *range)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	if (base->pages.flags.unmapped || base->pages.flags.partial_unmap)
+		return false;
+
+	return drm_gpusvm_range_pages_valid(&svm->gpusvm, base);
+}
+
+bool amdgpu_svm_range_is_valid(struct amdgpu_svm *svm,
+			       struct amdgpu_svm_range *range,
+			       const struct amdgpu_svm_attrs *attrs)
+{
+	bool valid;
+
+	drm_gpusvm_notifier_lock(&svm->gpusvm);
+	valid = range->gpu_mapped &&
+		range->attr_flags == attrs->flags &&
+		amdgpu_svm_range_pages_valid(svm, range);
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+
+	return valid;
+}
+
+
+int
+amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
+			  struct amdgpu_svm_range *range,
+			  unsigned long start_page,
+			  unsigned long last_page)
+{
+	struct dma_fence *fence = NULL;
+	unsigned int flags;
+	int ret;
+
+	if (last_page < start_page)
+		return 0;
+
+	flags = memalloc_noreclaim_save();
+	ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, true, true, false,
+				     NULL, start_page, last_page, 0, 0, 0, NULL,
+				     NULL, &fence);
+	memalloc_noreclaim_restore(flags);
+
+	if (!ret && fence) {
+		ret = dma_fence_wait(fence, false);
+		if (ret < 0)
+			AMDGPU_SVM_TRACE(
+				"notifier unmap fence wait failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
+				ret, start_page, last_page,
+				last_page - start_page + 1);
+	}
+
+	dma_fence_put(fence);
+	return ret;
+}
+
+uint64_t
+amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+			    const struct amdgpu_svm_attrs *attrs,
+			    bool read_only,
+			    enum drm_interconnect_protocol proto)
+{
+	uint32_t flags = attrs->flags;
+	uint32_t mapping_flags = 0;
+	uint32_t gc_ip_version = amdgpu_ip_version(svm->adev, GC_HWIP, 0);
+	uint64_t pte_flags;
+	bool snoop = proto != AMDGPU_INTERCONNECT_VRAM;
+	bool coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
+				 AMDGPU_SVM_ATTR_BIT_EXT_COHERENT);
+	bool ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT;
+	unsigned int mtype_local, mtype_remote;
+	bool is_aid_a1;
+	bool is_local = (proto == AMDGPU_INTERCONNECT_VRAM);
+	bool is_vram = is_local || (proto == AMDGPU_INTERCONNECT_P2P);
+
+	switch (gc_ip_version) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		if (is_local) {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
+			/* 9.4.2 local VRAM with XGMI keeps snoop */
+			if (gc_ip_version == IP_VERSION(9, 4, 2) &&
+			    svm->adev->gmc.xgmi.connected_to_cpu)
+				snoop = true;
+		} else {
+			mapping_flags |= coherent ?
+				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			/* TODO: migration: re enable snoop for same hive */
+		}
+		break;
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		if (ext_coherent)
+			mtype_local = AMDGPU_VM_MTYPE_CC;
+		else
+			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC :
+				AMDGPU_VM_MTYPE_RW;
+		snoop = true;
+		if (is_vram) {
+			if (is_local) {
+				/* local HBM region close to partition */
+				mapping_flags |= mtype_local;
+			} else if (!ext_coherent) {
+				/* TODO: add same hive check */
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+			} else if (gc_ip_version < IP_VERSION(9, 5, 0)) {
+				/* TODO: add same hive check */
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			} else {
+				mapping_flags |= ext_coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+			}
+		} else if (svm->adev->flags & AMD_IS_APU) {
+			/* On NUMA systems, locality is determined per-page
+			 * in amdgpu_gmc_override_vm_pte_flags.
+			 */
+			if (num_possible_nodes() <= 1)
+				mapping_flags |= mtype_local;
+			else
+				mapping_flags |= ext_coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		} else {
+			if (gc_ip_version < IP_VERSION(9, 5, 0) || ext_coherent)
+				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+			else
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		}
+		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
+		break;
+	case IP_VERSION(12, 1, 0):
+		is_aid_a1 = (svm->adev->rev_id & 0x10);
+		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
+				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
+				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
+		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
+		snoop = true;
+
+		if (is_local) {
+			mapping_flags |= mtype_local;
+		} else if (ext_coherent) {
+			mapping_flags |= AMDGPU_VM_MTYPE_UC;
+		} else {
+			/* system memory or remote VRAM */
+			mapping_flags |= mtype_remote;
+		}
+		break;
+	default:
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	}
+
+	if (flags & AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+		mapping_flags |= AMDGPU_VM_PAGE_EXECUTABLE;
+
+	pte_flags = AMDGPU_PTE_VALID;
+	pte_flags |= is_local ? 0 : AMDGPU_PTE_SYSTEM;
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+	if (gc_ip_version >= IP_VERSION(12, 0, 0))
+		pte_flags |= AMDGPU_PTE_IS_PTE;
+
+	amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE;
+	if (!(flags & AMDGPU_SVM_ATTR_BIT_GPU_RO) && !read_only)
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
+
+	if (gc_ip_version == IP_VERSION(12, 1, 0) &&
+	    svm->adev->have_atomics_support)
+		pte_flags |= AMDGPU_PTE_BUS_ATOMICS;
+
+	return pte_flags;
+}
+
+
+
+int amdgpu_svm_range_lock_vm_pd(struct amdgpu_svm *svm, struct drm_exec *exec,
+				bool intr)
+{
+	unsigned int exec_flags = DRM_EXEC_IGNORE_DUPLICATES;
+	int ret;
+
+	if (intr)
+		exec_flags |= DRM_EXEC_INTERRUPTIBLE_WAIT;
+
+	drm_exec_init(exec, exec_flags, 0);
+	drm_exec_until_all_locked(exec) {
+		ret = amdgpu_vm_lock_pd(svm->vm, exec, 1);
+		drm_exec_retry_on_contention(exec);
+		if (ret) {
+			drm_exec_fini(exec);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int
+amdgpu_svm_range_update_gpu_range(struct amdgpu_svm *svm,
+				  struct amdgpu_svm_range *range,
+				  const struct amdgpu_svm_attrs *attrs,
+				  bool read_only,
+				  bool flush_tlb,
+				  bool wait_fence,
+				  struct dma_fence **fence)
+{
+	struct drm_gpusvm_range *base = &range->base;
+
+	lockdep_assert_held(&svm->gpusvm.notifier_lock);
+
+	const unsigned long range_start_page = drm_gpusvm_range_start(base) >> PAGE_SHIFT;
+	const unsigned long range_end_page = drm_gpusvm_range_end(base) >> PAGE_SHIFT;
+	const unsigned long npages = range_end_page - range_start_page;
+	unsigned long mapped_pages = 0;
+	unsigned long dma_idx = 0;
+	int ret;
+
+	if (!base->pages.dma_addr || !npages)
+		return -EINVAL;
+
+	while (mapped_pages < npages) {
+		const struct drm_pagemap_addr *entry = &base->pages.dma_addr[dma_idx++];
+		unsigned long seg_pages = min_t(unsigned long, 1UL << entry->order,
+						npages - mapped_pages);
+		uint64_t pte_flags;
+		unsigned long start_page, last_page;
+		bool is_last_seg;
+
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+			return -EOPNOTSUPP;
+
+		pte_flags = amdgpu_svm_range_attr_pte_flags(svm, attrs,
+							    read_only,
+							    entry->proto);
+
+		start_page = range_start_page + mapped_pages;
+		last_page = start_page + seg_pages - 1;
+		mapped_pages += seg_pages;
+		is_last_seg = mapped_pages == npages;
+
+		ret = amdgpu_vm_update_range(svm->adev, svm->vm, false, false,
+					     flush_tlb && is_last_seg, true, NULL,
+					     start_page, last_page, pte_flags,
+					     0, entry->addr, NULL, NULL,
+					     wait_fence && is_last_seg ? fence : NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct amdgpu_svm_range *
+amdgpu_svm_range_find_or_insert(struct amdgpu_svm *svm, unsigned long addr,
+				unsigned long gpuva_start, unsigned long gpuva_end,
+				struct drm_gpusvm_ctx *ctx)
+{
+	struct drm_gpusvm_range *r;
+
+retry:
+	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
+					    gpuva_start, gpuva_end, ctx);
+	/*
+	 * UMD doesn't set RO for some RO VMAs, but the drm gpu svm framework
+	 * denies no RO flag range insert for RO VMAs, so treat
+	 * -EPERM as an indication of RO and retry if not set.
+	 */
+	if (PTR_ERR_OR_ZERO(r) == -EPERM && !ctx->read_only) {
+		ctx->read_only = true;
+		goto retry;
+	}
+
+	if (IS_ERR(r))
+		return ERR_CAST(r);
+
+	return to_amdgpu_svm_range(r);
+}
+
+int amdgpu_svm_range_get_pages(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       struct drm_gpusvm_ctx *ctx)
+{
+	int ret;
+
+retry:
+	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
+	/*
+	 * HMM returns -EPERM when write access is requested for a read-only
+	 * VMA. Retry as read-only so the eventual GPU mapping follows the CPU
+	 * VMA permissions.
+	 */
+	if (ret == -EPERM && !ctx->read_only) {
+		ctx->read_only = true;
+		goto retry;
+	}
+
+	if (ret == -EOPNOTSUPP) {
+		AMDGPU_SVM_ERR(
+			"range get pages -EOPNOTSUPP, evict and retry: gpuva=[0x%lx-0x%lx) ret=%d\n",
+			drm_gpusvm_range_start(range),
+			drm_gpusvm_range_end(range), ret);
+		amdgpu_svm_range_evict(svm, range);
+	}
+
+	return ret;
+}
+
+void amdgpu_svm_range_evict(struct amdgpu_svm *svm,
+			    struct drm_gpusvm_range *range)
+{
+	if (!range->pages.flags.has_devmem_pages)
+		return;
+
+	drm_gpusvm_range_evict(&svm->gpusvm, range);
+}
+
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
+				    struct amdgpu_svm_range *range,
+				    const struct amdgpu_svm_attrs *attrs,
+				    bool read_only,
+				    bool intr, bool wait,
+				    bool flush_tlb)
+{
+	struct drm_exec exec;
+	struct dma_fence *fence = NULL;
+	unsigned int flags;
+	int ret;
+
+	ret = amdgpu_svm_range_lock_vm_pd(svm, &exec, intr);
+	if (ret)
+		return ret;
+
+	flags = memalloc_noreclaim_save();
+	drm_gpusvm_notifier_lock(&svm->gpusvm);
+
+	if (!amdgpu_svm_range_pages_valid(svm, range)) {
+		amdgpu_svm_range_invalidate_gpu_mapping(range);
+		ret = -EAGAIN;
+	} else {
+		ret = amdgpu_svm_range_update_gpu_range(svm, range, attrs,
+							read_only, flush_tlb,
+							wait, wait ? &fence : NULL);
+	}
+
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	memalloc_noreclaim_restore(flags);
+
+	if (!ret && fence)
+		dma_fence_wait(fence, intr);
+	dma_fence_put(fence);
+
+	if (!ret)
+		ret = amdgpu_vm_update_pdes(svm->adev, svm->vm, false);
+
+	if (!ret) {
+		if (flush_tlb)
+			svm->flush_tlb(svm);
+		WRITE_ONCE(range->attr_flags, attrs->flags);
+		WRITE_ONCE(range->gpu_mapped, true);
+		range->validate_timestamp = ktime_get_boottime();
+	}
+
+	drm_exec_fini(&exec);
+	return ret;
+}
+
+int
+amdgpu_svm_range_map_attrs(struct amdgpu_svm *svm,
+		       const struct amdgpu_svm_attrs *attrs,
+		       unsigned long start, unsigned long end)
+{
+	unsigned long addr = start;
+	int ret;
+	bool devmem_possible = amdgpu_svm_devmem_possible(svm);
+	bool need_vram_migration = devmem_possible &&
+				   amdgpu_svm_attr_prefer_vram(attrs);
+	struct drm_gpusvm_ctx map_ctx = {
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	while (addr < end) {
+		struct amdgpu_svm_range *range;
+		unsigned long next_addr;
+		/* reset read_only every iteration, amdgpu_svm_range_find_or_insert may change it */
+		map_ctx.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO);
+
+		range = amdgpu_svm_range_find_or_insert(svm, addr,
+							addr, end,
+							&map_ctx);
+		if (IS_ERR(range)) {
+			AMDGPU_SVM_ERR(
+				"failed to find/insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
+				addr, start, end, PTR_ERR(range));
+			return PTR_ERR(range);
+		}
+
+		next_addr = drm_gpusvm_range_end(&range->base);
+		if (next_addr <= addr)
+			return -EINVAL;
+
+		if (amdgpu_svm_range_is_valid(svm, range, attrs)) {
+			addr = next_addr;
+			continue;
+		}
+
+		/* TODO: add migration */
+
+		AMDGPU_SVM_RANGE_DEBUG(range, "GET PAGES");
+
+		ret = amdgpu_svm_range_get_pages(svm, &range->base,
+						 &map_ctx);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to get pages for range [0x%lx-0x%lx), ret=%d\n",
+					drm_gpusvm_range_start(&range->base),
+					drm_gpusvm_range_end(&range->base), ret);
+			return ret;
+		}
+
+		AMDGPU_SVM_RANGE_DEBUG(range, "UPDATE MAPPING");
+
+		ret = amdgpu_svm_range_update_mapping(svm, range, attrs,
+						      map_ctx.read_only,
+						      true, true,
+						      true);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to update gpu map for range [0x%lx-0x%lx), ret=%d\n",
+					drm_gpusvm_range_start(&range->base),
+					drm_gpusvm_range_end(&range->base), ret);
+			return ret;
+		}
+
+		addr = next_addr;
+	}
+
+	return 0;
+}
+
-- 
2.53.0

