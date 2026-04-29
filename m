Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB5FF8864
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5330210EE51;
	Wed, 29 Apr 2026 04:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ezOUC28C";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D89B10ED27;
 Wed, 29 Apr 2026 04:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeZOuN1l1iVSW+JXMU5QaILiZg//Dtpc5pjlyFEwEimgcfc9Yxf3q3eKBbyqw7duJ9opaxlb2OJQFNL4QDiQubR6lvmcKoGS1y5hLV//Elhl5zr1C0fCO8RdkqajhfToX1s+t1MgmwsSjiazeQkx51X9cM+NljYp/W0eUHy2AKcYHMQ0ySBJF6vnC1JE/IKWgOAbk2uTqTCFpYJz/z0Cm1sLILZ0/+lapdV8vHoAjfVm6Dka9RXR5/zXF2P8uLQGiTKk0wEFyurNqPcDzMJ5lBPODlVD4EAAmVBIs9elf6YP6cgs7df6hlOMMwnaXrsx46cZVDDTEK2uBdu014W5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeNuYsy1CxMxCl28DmGPJAGDLyW1H14fxVDWcqnia6o=;
 b=aTqp94IjtiBG/tUzq9thxaZFfGlN4+S+D+2pYMgGEE1+wwgW+a9Eiit/v1GCmHACTgiEm6asoWmH65VTY+nBgDECDsBWYh8bnVzXCSiQJcDZN0RKKwY/YGdRncsEkFw4lltAbcsg+s0FwLxKueyg+vXZDuZFScQJ7bnclzFuRQhM4jdTo3sDY5Zcr9pXep1icEEWnfwZr2S6SXXoax5Hvl0WCYR0hrnXPY0fq07/IXC8m95CwUlOcvz9QdmnhA9hnDf2BLo/eipkhQ9ndLVycQgnwply5b0JEAWZV/QbB3ae1pSxEB2vtHmfFPWeChvnS3cM19CsZkmMIHdGUHeiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeNuYsy1CxMxCl28DmGPJAGDLyW1H14fxVDWcqnia6o=;
 b=ezOUC28CudlHA5HrBm1oJ099/tzsMhgjTWVKygq3edq+dECwhaVCV026Xe7/7Kv0Xh+EPh2MJ3JLa3wLJ6PlQh4EXrCdzoNDXwexb+3DLcsPRFsqhMvTFwU4eNFXa1PR91s/ucSxS/9hPATSTzup6qtzqAgHrYr/V5YbeSY8E9A=
Received: from SN7PR04CA0171.namprd04.prod.outlook.com (2603:10b6:806:125::26)
 by IA1PR12MB8223.namprd12.prod.outlook.com (2603:10b6:208:3f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 04:10:41 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::b6) by SN7PR04CA0171.outlook.office365.com
 (2603:10b6:806:125::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 04:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 04:10:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:10:36 -0500
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 21:07:17 -0700
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <sima@ffwll.ch>,
 <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V4 07/12] drm/amdgpu: implement SVM range GPU mapping core
Date: Wed, 29 Apr 2026 12:06:23 +0800
Message-ID: <20260429040628.853079-8-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429040628.853079-1-honglei1.huang@amd.com>
References: <20260429040628.853079-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|IA1PR12MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fdba33-2716-4b20-b4b9-08dea5a5471f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SNO7GaDhGf7prMRmn0tSTzF1YOwECGurOun53mOxD09rmJbn7Q/+Maz5kivzelH2XHuouNwZe+xpqMFSD7FIFGNbCdqpmngE5AJAihWfGYAFmPmNfKhG2cuJEmoxF/wEjH6SMKNLQilaGhk3SKg9qF52TSjHqn9YkEPZWthEYBpmCM7sjgXGJuRDpyl2qBeFpIVRXTEx4fyf+3r7bUpJGmKDT8fBU7tpHlXrZfW9fxt4dsdOkvWQzmbS4WIQuYbR4MW1TQBy52A7OMhct+3Cp5h15U/poitn2veeVMIkhXDuVr/+JNpi1W9LkIfEriAzqenBwnasFruQGu9xiMuyBoktMiGv5YQI8TxeseyHr1eiskbGkS0eGRtKYbFwIeerbLPQPH41MmcaBvHhE757aKdlG1Qqx7Zu20uco79TDEbpb+9NPeuizgwKsy7w83kkBrgo6wd9PyoatJ/rxEG1NBEANrX9Ye4c7SvJczgc52VrQ3PlTQRGb9+jUK5EncafwWK5PlWbmARbF5nv0iNNDwioH9fm9zBPKm+PJlEHWqrTA+LFczWGlfSLcJQ90kkMEXBaZXlwTZaL512btwo7DehGXebSH1EGstAYtpGJqoYM1UP6pl/LmFnUzf0sjWg1LSooVwIKl1saFoVMubB/haqw0PHWhWSYH5EXl2LI2DmilDSdChgGB8vqGPu9wq7ORXA6lqbxbRB8Tf4JeEV4YqwJ8vi1AkM3e82Y+YtaTbo3Xgl9z/JvkhhtJ+K6EuMf8xGwO/AGMoeEsTaxd+IpTkEA6/7vX0dfu4KWTahBkESP5ZM1ZKVRD2ft8IFVXD1M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s6A4Ht6cnhJXCGzVovFeWqTM/F8VUn/1vc/8wCklgLnJ7Z7f/KQTQmH3cbciz80WXSVu9/2AC6X8TGo8t8Rb5bXUPOsYnQ1Nf7zPZr1W1iRJmV6Ku2t7pRdI3iXichAF1czwAcWK2M8dwULPmWReX8g7tvNx782C9F9OQsy0M45wzSfwYjuQ0nW1SAzX+9BXcC5mVPFTEKgr3L1Ajhkgquf/kdXurPmH2xlqPzY8iJcXabaE1skyNeeTRZS6JRjkwIVGRPBkxnE4Cl4zYDG4fm6paEn4s/Ts/B8uCc4ypJTza/4pfrOn//FgA0oWkv0V3Qh3ML8iXcBN1o0LqW8c6JqQd6ChqDBFFFf5oJxxMdr14s5GlOQl6ybbf2vOh/A4dhzraEdagqPRxRuZ5iTfW7z5FTNgvO7qLye0wQww4pXxl/S8g+iT0gRJQ+JitSsJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 04:10:41.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fdba33-2716-4b20-b4b9-08dea5a5471f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8223
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

Implement GPU page table mapping in amdgpu_svm_range.c: PTE flag
computation per GC IP version, VM page directory locking, DMA
address coalescing, page get/validate, and full mapping pipeline.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 489 ++++++++++++++++++
 1 file changed, 489 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
new file mode 100644
index 000000000..d02a90b83
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c
@@ -0,0 +1,489 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
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
+static inline bool
+range_has_access(enum amdgpu_ioctl_svm_access access)
+{
+	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE ||
+	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
+}
+
+static void
+range_invalidate_gpu_mapping(struct amdgpu_svm_range *range)
+{
+	WRITE_ONCE(range->gpu_mapped, false);
+}
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
+			       const struct amdgpu_svm_attrs *attrs,
+			       uint64_t pte_flags)
+{
+	unsigned int flags;
+	bool valid;
+
+	flags = memalloc_noreclaim_save();
+	drm_gpusvm_notifier_lock(&svm->gpusvm);
+	valid = range->gpu_mapped &&
+		range->pte_flags == pte_flags &&
+		range->attr_flags == attrs->flags &&
+		amdgpu_svm_range_pages_valid(svm, range);
+	drm_gpusvm_notifier_unlock(&svm->gpusvm);
+	memalloc_noreclaim_restore(flags);
+
+	return valid;
+}
+
+
+static int
+amdgpu_svm_range_zap_ptes(struct amdgpu_svm *svm,
+				      struct amdgpu_svm_range *range,
+				      const struct mmu_notifier_range *mmu_range)
+{
+	struct drm_gpusvm_range *base = &range->base;
+	struct dma_fence *fence = NULL;
+	unsigned long start_page = max(drm_gpusvm_range_start(base),
+				       mmu_range->start) >> PAGE_SHIFT;
+	unsigned long last_page = (min(drm_gpusvm_range_end(base),
+				       mmu_range->end) >> PAGE_SHIFT) - 1;
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
+			AMDGPU_SVM_TRACE("notifier unmap fence wait failed: ret=%d [0x%lx-0x%lx]-0x%lx\n",
+					 ret, start_page, last_page,
+					 last_page - start_page + 1);
+	}
+
+	dma_fence_put(fence);
+	return ret;
+}
+
+uint64_t
+amdgpu_svm_range_attr_pte_flags(struct amdgpu_svm *svm,
+			    const struct amdgpu_svm_attrs *attrs,
+			    bool read_only)
+{
+	/* a simple pte flags func */
+	uint32_t gc_ip_version = amdgpu_ip_version(svm->adev, GC_HWIP, 0);
+	uint32_t flags = attrs->flags;
+	uint32_t mapping_flags = 0;
+	uint64_t pte_flags;
+	bool coherent = flags & (AMDGPU_SVM_ATTR_BIT_COHERENT |
+				 AMDGPU_SVM_ATTR_BIT_EXT_COHERENT);
+	bool ext_coherent = flags & AMDGPU_SVM_ATTR_BIT_EXT_COHERENT;
+	bool snoop = true;
+	unsigned int mtype_local;
+
+	switch (gc_ip_version) {
+	case IP_VERSION(9, 4, 1):
+	case IP_VERSION(9, 4, 2):
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
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
+		if (svm->adev->flags & AMD_IS_APU) {
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
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
+	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
+	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
+	case IP_VERSION(11, 5, 3):
+		mapping_flags |= coherent ?
+			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		break;
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
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
+	pte_flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM;
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+	if (gc_ip_version >= IP_VERSION(12, 0, 0))
+		pte_flags |= AMDGPU_PTE_IS_PTE;
+
+	amdgpu_gmc_get_vm_pte(svm->adev, svm->vm, NULL, mapping_flags, &pte_flags);
+	pte_flags |= AMDGPU_PTE_READABLE;
+	if (!(flags & AMDGPU_SVM_ATTR_BIT_GPU_RO) && !read_only)
+		pte_flags |= AMDGPU_PTE_WRITEABLE;
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
+				  uint64_t pte_flags,
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
+		unsigned long start_page, last_page;
+		bool is_last_seg;
+
+		if (entry->proto != DRM_INTERCONNECT_SYSTEM)
+			return -EOPNOTSUPP;
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
+				const struct amdgpu_svm_attr_range *attr_range,
+				struct drm_gpusvm_ctx *ctx)
+{
+	unsigned long gpuva_start = amdgpu_svm_attr_start_page(attr_range) << PAGE_SHIFT;
+	unsigned long gpuva_end = (amdgpu_svm_attr_last_page(attr_range) + 1) << PAGE_SHIFT;
+	struct drm_gpusvm_range *r;
+
+retry:
+	r = drm_gpusvm_range_find_or_insert(&svm->gpusvm, addr,
+					    gpuva_start, gpuva_end, ctx);
+
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
+	ret = drm_gpusvm_range_get_pages(&svm->gpusvm, range, ctx);
+	if (ret == -EOPNOTSUPP) {
+		AMDGPU_SVM_ERR("range get pages failed with -EOPNOTSUPP, evicting range and retrying: gpuva=[0x%lx-0x%lx) ret=%d\n",
+				drm_gpusvm_range_start(range),
+				drm_gpusvm_range_end(range), ret);
+		drm_gpusvm_range_evict(&svm->gpusvm, range);
+	}
+
+	return ret;
+}
+
+int amdgpu_svm_range_update_mapping(struct amdgpu_svm *svm,
+				    struct amdgpu_svm_range *range,
+				    uint64_t pte_flags,
+				    uint32_t attrs_flags,
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
+		range_invalidate_gpu_mapping(range);
+		ret = -EAGAIN;
+	} else {
+		ret = amdgpu_svm_range_update_gpu_range(svm, range, pte_flags,
+							flush_tlb, wait,
+							wait ? &fence : NULL);
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
+		WRITE_ONCE(range->pte_flags, pte_flags);
+		WRITE_ONCE(range->attr_flags, attrs_flags);
+		WRITE_ONCE(range->gpu_mapped, true);
+		range->validate_timestamp = ktime_get_boottime();
+	}
+
+	drm_exec_fini(&exec);
+	return ret;
+}
+
+static int
+amdgpu_svm_range_map_attr_range(struct amdgpu_svm *svm,
+		       const struct amdgpu_svm_attr_range *attr_range)
+{
+	const struct amdgpu_svm_attrs *attrs = &attr_range->attrs;
+	unsigned long start = amdgpu_svm_attr_start_page(attr_range) << PAGE_SHIFT;
+	unsigned long end = (amdgpu_svm_attr_last_page(attr_range) + 1) << PAGE_SHIFT;
+	unsigned long addr = start;
+	int ret;
+	bool devmem_possible = amdgpu_svm_attr_devmem_possible(svm, attrs);
+	bool need_vram_migration = amdgpu_svm_attr_prefer_vram(svm, attrs);
+	devmem_possible = false; /* TODO: add migration */
+	struct drm_gpusvm_ctx map_ctx = {
+		.read_only = !!(attrs->flags & AMDGPU_SVM_ATTR_BIT_GPU_RO),
+		.devmem_possible = devmem_possible,
+		.devmem_only = need_vram_migration && devmem_possible,
+		.check_pages_threshold = devmem_possible ? SZ_64K : 0,
+	};
+
+	while (addr < end) {
+		struct amdgpu_svm_range *range;
+		unsigned long next_addr;
+		uint64_t range_pte_flags;
+		range = amdgpu_svm_range_find_or_insert(svm, addr,
+							attr_range, &map_ctx);
+		if (IS_ERR(range)) {
+			AMDGPU_SVM_ERR("failed to find or insert range for gpuva 0x%lx [0x%lx-0x%lx), ret=%ld\n",
+					addr, start, end, PTR_ERR(range));
+			return PTR_ERR(range);
+		}
+
+		next_addr = drm_gpusvm_range_end(&range->base);
+		if (next_addr <= addr)
+			return -EINVAL;
+
+		range_pte_flags = amdgpu_svm_range_attr_pte_flags(
+						svm, attrs, map_ctx.read_only);
+
+		if (amdgpu_svm_range_is_valid(svm, range,
+							attrs, range_pte_flags)) {
+			addr = next_addr;
+			continue;
+		}
+
+		/* TODO: add migration */
+
+		AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - GET PAGES");
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
+		AMDGPU_SVM_RANGE_DEBUG(range, "PREFETCH - UPDATE MAPPING");
+
+		ret = amdgpu_svm_range_update_mapping(svm, range,
+						      range_pte_flags,
+						      attrs->flags,
+						      true, true,
+						      true);
+		if (ret) {
+			AMDGPU_SVM_ERR("failed to update gpu mapping for range [0x%lx-0x%lx), ret=%d\n",
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
+int
+amdgpu_svm_range_map_interval(struct amdgpu_svm *svm,
+				 unsigned long start_page,
+				 unsigned long last_page)
+{
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	struct amdgpu_svm_attr_tree *attr_tree = svm->attr_tree;
+	unsigned long cursor = start_page;
+
+	while (cursor <= last_page) {
+		struct amdgpu_svm_attrs attrs;
+		struct amdgpu_svm_attr_range *attr_range;
+		unsigned long seg_last;
+		unsigned long seg_start;
+		unsigned long next;
+		int ret;
+
+		mutex_lock(&attr_tree->lock);
+		attr_range = amdgpu_svm_attr_get_bounds_locked(attr_tree, cursor,
+							       &seg_start, &seg_last);
+		if (attr_range)
+			attrs = attr_range->attrs;
+		mutex_unlock(&attr_tree->lock);
+
+		seg_last = min(seg_last, last_page);
+		if (attr_range && range_has_access(attrs.access)) {
+			/* map may fail here cause no vma or access deny */
+			ret = amdgpu_svm_range_map_attr_range(svm, attr_range);
+			if (ret)
+				return ret;
+		}
+
+		if (seg_last == ULONG_MAX || seg_last == last_page)
+			break;
+
+		next = seg_last + 1;
+		if (next <= cursor)
+			break;
+		cursor = next;
+	}
+
+	return 0;
+}
+
-- 
2.34.1

