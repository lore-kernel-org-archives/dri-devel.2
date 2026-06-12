Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD9CCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DB110F3AD;
	Fri, 12 Jun 2026 09:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q9unA5HY";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4140010F3A9;
 Fri, 12 Jun 2026 09:11:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqFKXSdqn9Toy7sgLqTCPAmfENvBdlUcS8T6FI9Is4Zx1C3ciUdJXRIN0pSCQQOWpIqcUZb8TXJLOoANHZD/SzRJ3nbnlbLu+EnW+wrfF5XcONoIDtzf3TL65k1FWQX7pFPIMZ3+pUoUnWR8Qzs1BjQnpchfmokqxKpb2f3O7qumzMn3Rm2J+fD8QcBOHjv0Wvg8SLo1lqZ+OQcc03XKiun/Id/5vJH01APxmumaX3E/ixM1gTwb+qUhDmiEzxSpeqBbg0ZFfdXwhoeOAcmyi43ZGz8HXJaUYQwh0xGT++DMLs6mDSeThn0ySaIOkojFU8EUG7+1H3fw8cCOinsyAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw3hHU68Qi328JH144cCwtE4Io0UXEJ4UIz53+Sby6c=;
 b=sKvrr56Q0TYqxLTf1eGWeIR4pJ5T/9z8PQRtRnzC9pfJ8CxZceNb8dT7Vef6b6G3oykGDa4PVekaXNXUjefU4C0t+tL9ktrRGlWWKj1ubuKQRDIW0pQPwKvfR8+3c+3c9bdg0HqVEs5UCY8KdyFqK64uXMkxXnAmJjG3IzJcg6ArWqXjdS6MXKGlmZTiLKBEE/ZGyJ5ILBH+pPCrP/30T72UzkNZIbWRBgs2SZyUvDEZdBpIzOT8oTGFLM5L/3y46ouPi3jy6mUBKiANoO8p0t5uWWv6DdOz6Bj3ezIR7KjVo3soJU4yKEFJvzUGr2Or+2gZi+/dtuEnbRKsoWUNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw3hHU68Qi328JH144cCwtE4Io0UXEJ4UIz53+Sby6c=;
 b=q9unA5HYWqwHlNJpqVTpruFaMGzcxlHeieMaoRCRGSu+/5vnsaEFedJEaF7X5kMJt7pjHZfC6WNkOxoIsTW8SggNjPACmMgPxecI+IyUAW8Om682pHpeEXWd90oKAWqlzxD4KakY2eDtJI4LvnfTjQ+BfLxNTGpp9GnAPql2R9U=
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:11:25 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::3d) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 09:11:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:11:25 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:11:15 -0500
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
 <yiru.ma@amd.com>
Subject: [PATCH v8 17/18] drm/amdgpu: add SVM range migration helpers for
 drm_pagemap
Date: Fri, 12 Jun 2026 17:09:19 +0800
Message-ID: <20260612090928.29682-18-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c71978b-bf8a-48aa-1f16-08dec862945d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|921020|3023799007|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 0Cvxeb4akvWpUUcRuCoI/226VRWR/JY8IW5mSPPxhdI7MAPUzC+Qlht6lesxYRbzxjHG0lroPe/2QBWo8hTEGPL28mpxHUZOVyJ6zlXimZNOlWheFEmiKzHU/uQPJxHimLWIzzHB+npLpC1SPjiptkzF6ISpTCUgak+AYw0+xBOyXt+vVxFVBlfpbz+/6zJldzReiMZ7zOul/KoPG2eNDN1Y6DSfYOKgIL0q+DH+rb6V413EKxXTOxQAVEh9tMcHVeJc6eqljX2NwZ/4kQKYdBNSJH8/1Y3ti0RAEsUKdx3N/b/5RZYbr89fW9LOYiiUp3z8vQKbRU4voPw4dJEAys2v84mE91sOZOIct0LZ+SNSlJtfO1Xc38P8IJghVR3KNeqpfDlTrsxGf5M9ZgTBv8DSXI2E3jwRZp87luu7fKrMtGq3+TtbBHCrdpPWDNfRaw+oKJgN0QkpmlmkGTwMuhjsbVSlTiNDSZmD/scdlDWxJw1C1fbK70GGeq/xrOpHUIdNcOTNUWPwUg5XtsHLwdrmODVRDsSILBp7I/GqUl5bLovW8fyC1ZPergemD6kHH4cjQkxPI+pkNVO4WiWonUq1Pj8t0FN0tMJokrTgP0vgs+LkvkfSG9pDeVMA7OH6cULr8cHrNHd7mKbXRrormlpvZtTU0JUDjKREJBIUq+XAex05wljA58Io89ibf3CSnQ831nbfANKZ9znKIdxVdz/IfrnGaqz413/G/oCDCnKIwxKYdyq/RtclOhwlqQJgOOCJqN1UyNYR/7k4WfFnXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(921020)(3023799007)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EyVMYW4q31rGBdm/HHaME0uHWYosgCE0AsrFZSMsCMWfLJkoWa4X4ySiBUec+X1BuxH6bGvVP2nJBe0mXDwZNlfcET5Y1KzqvSk3B4DrjNP4PwPBOdE1VPq6Ldy18Shbv6U6i+/TR5ReEJuuvIZx8SS12+IeXUFBEpWKwdeoJS0Sgus4S+S8/xigetLVulkRltXSCc4qznvpDDg8VN+YfgQLhjEOrmvsfvp8qa/SFLJHpU3JN2wlkLVzNSZnORxKR8eAahkbn6wU3oflwXLFgH3J9DwQhbZw4cdUmMN3IOyhiJL9YETb2gPxJC3sVw3quQn5Ok1TV1xSaCqWApGzxp0HcApswEC2GMY+FescF+0/LDbOuc+N3G4V+lBRcUObiB1HewwL4l/rYtKkFpuyksud4sxPCooDYwFcgYu/oavw77PSMtIhh9LeyX5W3VyA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:11:25.4086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c71978b-bf8a-48aa-1f16-08dec862945d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

From: Junhua Shen <Junhua.Shen@amd.com>

Add amdgpu_svm_range_migrate.c/.h implementing the per-range migration
helpers for SVM VRAM migration via drm_pagemap:

- Implement range_needs_migrate_to_vram() checking migrate_devmem
  capability and current backing location.
- Add amdgpu_svm_range_migrate_to_vram() wrapping
  drm_pagemap_populate_mm() for RAM-to-VRAM migration. On -EBUSY
  (partial migration due to races), evict conflicting pages back to
  system memory via drm_gpusvm_range_evict() and retry once.
- Add amdgpu_pagemap_capable() to check device memory support.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 120 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 +++++
 3 files changed, 158 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 75047adbdd57b..0d08561b4922a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -324,14 +324,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_migrate.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/amdgpu_migrate.o \
+	      $(obj)/amdgpu_svm_range_migrate.o $(obj)/amdgpu_migrate.o \
 	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
-	      $(obj)/.amdgpu_migrate.o.cmd
+	      $(obj)/.amdgpu_svm_range_migrate.o.cmd $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 0000000000000..91dfd0420c001
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
@@ -0,0 +1,120 @@
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
+#include "amdgpu.h"
+#include "amdgpu_svm.h"
+#include "amdgpu_svm_range.h"
+#include "amdgpu_migrate.h"
+#include "amdgpu_svm_range_migrate.h"
+
+static bool
+range_in_vram(struct drm_gpusvm_range *range)
+{
+	struct drm_gpusvm_pages_flags flags = {
+		/* Pairs with WRITE_ONCE in drm_gpusvm_get_pages() */
+		.__flags = READ_ONCE(range->pages.flags.__flags),
+	};
+
+	return flags.has_devmem_pages;
+}
+
+static bool
+range_needs_migrate_to_vram(struct drm_gpusvm_range *range)
+{
+	if (!range->pages.flags.migrate_devmem)
+		return false;
+	if (range_in_vram(range))
+		return false;
+
+	return true;
+}
+
+static struct drm_pagemap *
+amdgpu_svm_get_dpagemap(struct amdgpu_svm *svm)
+{
+	struct amdgpu_pagemap *apagemap = svm->adev->apagemap;
+
+	if (!apagemap || !apagemap->initialized)
+		return NULL;
+
+	return &apagemap->dpagemap;
+}
+
+bool
+amdgpu_pagemap_capable(struct amdgpu_svm *svm)
+{
+	if (svm->adev->gmc.is_app_apu)
+		return false;
+
+	if (!amdgpu_svm_get_dpagemap(svm))
+		return false;
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_range_migrate_to_vram - Migrate range pages to VRAM
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: The GPU SVM range to migrate
+ *
+ * Wraps drm_pagemap_populate_mm() to migrate system memory pages
+ * backing the given range into device VRAM. Skips migration if the
+ * range doesn't support devmem or is already in VRAM.
+ *
+ * Return: 0 on success or no-op, negative error code on failure
+ */
+int
+amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
+				 struct drm_gpusvm_range *range)
+{
+	struct drm_pagemap *dpagemap;
+	unsigned long start, end;
+	int ret, retries = 1;
+
+	if (!range_needs_migrate_to_vram(range))
+		return 0;
+
+	dpagemap = amdgpu_svm_get_dpagemap(svm);
+	if (!dpagemap)
+		return -ENODEV;
+
+	start = drm_gpusvm_range_start(range);
+	end = drm_gpusvm_range_end(range);
+
+	do {
+		ret = drm_pagemap_populate_mm(dpagemap, start, end,
+					      svm->gpusvm.mm, 0);
+
+		if (ret == -EBUSY && retries)
+			drm_gpusvm_range_evict(&svm->gpusvm, range);
+	} while (ret == -EBUSY && retries--);
+
+	if (ret) {
+		AMDGPU_SVM_TRACE("migrate_to_vram failed: ret=%d [0x%lx-0x%lx]\n",
+				 ret, start, end);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
new file mode 100644
index 0000000000000..6e4b6e45512e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
@@ -0,0 +1,35 @@
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
+#ifndef __AMDGPU_SVM_RANGE_MIGRATE_H__
+#define __AMDGPU_SVM_RANGE_MIGRATE_H__
+
+struct amdgpu_svm;
+struct drm_gpusvm_range;
+
+bool amdgpu_pagemap_capable(struct amdgpu_svm *svm);
+int amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
+				     struct drm_gpusvm_range *range);
+
+#endif /* __AMDGPU_SVM_RANGE_MIGRATE_H__ */
-- 
2.53.0

