Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A3ACD4F35
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 09:58:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF7D10EDB3;
	Wed, 13 May 2026 09:57:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IH50q6oa";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D41E10ED9C;
 Wed, 13 May 2026 09:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIZgTilL0RZyKsaakWqJuOuYzcjI/CTJNYYieWkc0tWq0v7/te/3HrpnVyt5LltHY2vlbLCtfffBetRLgypCp564pW1m76ecnM10tSdaBmWM9DyUj1Aps8YnbPhXG88hYwEiJAY5OZwcmsT+HSmmnHjkcjmWvtpQnfYd6oIKXQ8+GO38wd2iGRpJz7LHioKYP8Ik9gJ/NCsSjBcljxIRW8DiEJd7RoXd24/S/EqqJMXx1BwM/CyKuyM3YS59ZM+jzza3qGZL7Dm0kHbbywU6AlAM+dO8tWgvU1tzH7ngKUacMhYEQLrUF1/BqC8x4FjjUhfRvEU8DCcUI6THHs+How==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAXbf8M9PVkhaULKGNyEaC2xFM8eL+LeKtWRbo0vrd4=;
 b=DxofEg0yfKkCzjN72eTVelLjur7QJCneIytDHy/k55D7ZhkaGqPsOLW2Yq9ZrtD29w9Ci+OW6fOqIUQllsvpIPBBqYC/UJj93rXY63lRSCYWQnXAg5SXl7Sl3EsX+hLWP9DZPSTMpgL2wtsNhzfMeltFnygEMeLNP+LQHc1bO16ms/bEJLusU6pHtbWsd5RUm5U2rXxr3mBmr0w1dspy1BUrc2sanBZw4nIivLVH0F+h8Qxmjw7HFfUFg4ZxjnfFH4gj6J2yScZo2Z8GmH2yOSsvY+hRn6teQP2AbHRJCnLVYDXlswHpoT0J1kg7oWlF55ZjfXh0vxO0lehm2BDz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAXbf8M9PVkhaULKGNyEaC2xFM8eL+LeKtWRbo0vrd4=;
 b=IH50q6oaMbsvSQWuy/6lKFGbQ2WtysLRczgQfFarWlpAFlmbwWOqd+SGvlBe3ForYZ43XlPfC0QuMr40WmnuVflIyisH+jyGY6NDKBeKYxOzijNhhR+O8Uzt0pCYVZ4kVm6EqSKwpQRQW2x2Z1wiVlQ5+2Vs4eKXaeSdD19CjO8=
Received: from DM6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:5:100::43)
 by SAWPR12MB999116.namprd12.prod.outlook.com (2603:10b6:806:4e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 09:57:52 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::b5) by DM6PR03CA0066.outlook.office365.com
 (2603:10b6:5:100::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:57:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:57:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 02:57:51 -0700
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:57:48 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v4 4/6] drm/amdgpu: add SVM range migration helpers for
 drm_pagemap
Date: Wed, 13 May 2026 17:57:32 +0800
Message-ID: <20260513095734.69598-5-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513095734.69598-1-Junhua.Shen@amd.com>
References: <20260513095734.69598-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SAWPR12MB999116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b178cf6-a6ba-41d5-0d54-08deb0d6191c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|11063799003|3023799003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: wgZolxzdn9wfj/7D8rrb6rOZVt95KCnzU8Ul2IO+2kfT7HK4ynR13zlwexse29rWzNbQVieNo0tp7QkS0AUarHiHcfuApNMjI7RvdO//clfeM36wX/X/gCDnDGIDZGiJFDcgQZC9lo97r4SH3lvl69O/EJWUT4NTSEJm1IIBd00P/dTMka4vZy+rsYeU6x/kTtzseiLGzanup12cDgJBbtggdTGTve6GO3BwVV8EYbm3e9Z+Jm6yvQ0OxshAAUqfLKSJSrAKS7Y2jB0+OvE+gZgprD8ROBxAB0p9SXxC0H0TdTYj4Omw75STtW/yq68oeqZqIOYb4N1lnfbqmyjsPKR6OqplzL0MGU8H5R10t2B+q62HgJtv1t3syu+LSJWXl+x+vesPt9rPiXtNXNjR0CYYiXAZUxbUHLZzaOlAeotxDmYbhzr/xfB5O+I8QPn8XVZGitIr/DxicyCUaWSzcSfJ7yps/97kva5HjhJh7PcFGvAH1s2ZNEco9nwa49zieup4OZOjRZKwZdzzqHCTD8J77CnaXCSIevVyHODFrvBT4D8MY43SZQBvEH0coZitI7sSutT/2EoDPLDQ17kpEaLsvBZccKYCEw6FvLzW2BXGhzCv/26L8y2IhTHMBU138HZgWxJZYNiA0hAgHSVXUi7VeTNycy9MOMzR8l0YqWkK0CEWTPTXUCDI7IaCb+ew183iJrQ1jhZK7Q+UvfMf+5xt240mN2yXwfYTpXoyV4zURJTpJrf6DPpgDdhIpUv5Mg82JbLajZLNGwuABfPkfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(11063799003)(3023799003)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lKSwBBKDlK/v2oMgJJfUJk3Ib0Wo6FCK/kSk6LuPqTz6q0X+Bs1TglQtSaZ37VW+T6VDZspikh2hGGNQYxGVCPMOIhOigue+KsonL3ZjdoFjAcoAZHnfC64ckemIp9YGszHhCQ/jXQg8y2olkZRxLYpzcX1XUiv7cmKoBdFm+QcQgFeZnsE5x4B8TLEKX4GmfkMbL2/mUfrs2dTj0r0m69NuQ+y05Ejcf/Y7/+0wtMwps43VnuYFaE7oB3AlOhg/VhH0uZnYQTVziZHM1WXaXxWCMbv5v3UzUaHrRO9IWgW0iaykbG4e3NPGahc7i52KQfaRQOWMXfrxOCxf92oPRgmytQ4OIEA66ac1sfHe7zcGwlNsJkpOLy1H23NP4573iUyO5i4kMqrp6djl/3kzLlJstA7REGyLMfgKCQFovgBmoVG7GScf/hXYC0JkonPm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:57:52.3119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b178cf6-a6ba-41d5-0d54-08deb0d6191c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999116
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

Add amdgpu_svm_range_migrate.c/.h implementing the per-range migration
helpers for SVM VRAM migration via drm_pagemap:

- Define amdgpu_svm_migrate_mode enum (TO_VRAM, TO_SYSMEM) to
  express migration intent from callers.
- Implement range_needs_migrate_to_vram() checking migrate_devmem
  capability and current backing location.
- Add amdgpu_svm_range_migrate_to_vram() wrapping
  drm_pagemap_populate_mm() for RAM-to-VRAM migration.
- Add amdgpu_svm_range_migrate_range() entry point dispatching to
  migrate_to_vram or drm_gpusvm_range_evict() based on mode.
- Add amdgpu_pagemap_capable() to check device memory support.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 122 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  47 +++++++
 3 files changed, 172 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3905a97795aa..f34d93389da3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -323,14 +323,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
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
index 000000000000..bc6f242b680b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
@@ -0,0 +1,122 @@
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
+static struct drm_pagemap *
+amdgpu_svm_get_dpagemap(struct amdgpu_svm *svm)
+{
+	struct amdgpu_pagemap *apagemap = svm->adev->apagemap;
+
+	if (!apagemap->initialized)
+		return NULL;
+
+	return &apagemap->dpagemap;
+}
+
+static bool
+range_needs_migrate_to_vram(struct drm_gpusvm_range *range,
+			    enum amdgpu_svm_migrate_mode mode)
+{
+	if (!range->pages.flags.migrate_devmem)
+		return false;
+	if (range_in_vram(range))
+		return false;
+
+	if (mode == AMDGPU_SVM_MIGRATE_TO_VRAM)
+		return true;
+
+	return false;
+}
+
+static int
+amdgpu_svm_range_migrate_to_vram(struct amdgpu_svm *svm,
+				  struct drm_gpusvm_range *range)
+{
+	struct drm_pagemap *dpagemap = amdgpu_svm_get_dpagemap(svm);
+	unsigned long start = drm_gpusvm_range_start(range);
+	unsigned long end = drm_gpusvm_range_end(range);
+	int ret;
+
+	if (!dpagemap)
+		return -ENODEV;
+
+	ret = drm_pagemap_populate_mm(dpagemap, start, end,
+				      svm->gpusvm.mm, 0);
+
+	if (ret) {
+		AMDGPU_SVM_TRACE("migrate_to_vram failed: ret=%d [0x%lx-0x%lx]\n",
+				 ret, start, end);
+		return ret;
+	}
+
+	return 0;
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
+ * amdgpu_svm_range_migrate_range - Per-range migration
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: The GPU SVM range to migrate
+ * @migrate_mode: Migration intent
+ */
+int
+amdgpu_svm_range_migrate_range(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       enum amdgpu_svm_migrate_mode migrate_mode)
+{
+	if (range_needs_migrate_to_vram(range, migrate_mode))
+		return amdgpu_svm_range_migrate_to_vram(svm, range);
+	else if (migrate_mode == AMDGPU_SVM_MIGRATE_TO_SYSMEM &&
+		 range_in_vram(range))
+		return drm_gpusvm_range_evict(&svm->gpusvm, range);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
new file mode 100644
index 000000000000..9cc80b8350c7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
@@ -0,0 +1,47 @@
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
+/**
+ * enum amdgpu_svm_migrate_mode - Migration mode for SVM range migration
+ *
+ * @AMDGPU_SVM_MIGRATE_TO_VRAM: Migrate pages to VRAM before mapping.
+ * @AMDGPU_SVM_MIGRATE_TO_SYSMEM: Evict VRAM pages back to system memory
+ */
+enum amdgpu_svm_migrate_mode {
+	AMDGPU_SVM_MIGRATE_TO_VRAM,
+	AMDGPU_SVM_MIGRATE_TO_SYSMEM,
+};
+
+bool amdgpu_pagemap_capable(struct amdgpu_svm *svm);
+int amdgpu_svm_range_migrate_range(struct amdgpu_svm *svm,
+				    struct drm_gpusvm_range *range,
+				    enum amdgpu_svm_migrate_mode migrate_mode);
+
+#endif /* __AMDGPU_SVM_RANGE_MIGRATE_H__ */
-- 
2.34.1

