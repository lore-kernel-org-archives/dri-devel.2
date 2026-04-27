Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13D6FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D20D10E685;
	Mon, 27 Apr 2026 10:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Tc0U20q";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46DFA10E684;
 Mon, 27 Apr 2026 10:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRmJaqZMesP8Yy393Lje5l5rwxo4LvivxK/M551FYKe/WSTdrovz9yVttaUnwmlol1hYbpere6xSw4dcZVgFaWN0WAO6RgwiwLr1bXuvsCFY/l+4mFMHrTn7fbRe6ttH7rVZjXblWgsL9+skf2oBK+AXdG1jM3L4u32xmHCnN6IkZARL9sE/mYdm0lb1bNaeUIfd+Sb5qwr+FoYb03l4J4gaYxX18t4sJGXzTq/2jjO9PJs4fxAI0wUEHv675nYdk3SpqeLVpHKVsDtgKUM01ACtRATYSWZaf9dbaFfadoiP14lIg5iafDx+6VGYwBGNFySa8lavbbTKflOgKywWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAkdfZBqujZpEB1xS3FZdn/FhhyCBjGfHf80HZSDJWA=;
 b=oqHMZhV5a5BXbrRS61dlX69AnChp//9djziSEuDZi8/lxpJnae1Lb6c/RMpfVz5o3s3vbK+etqhVOuW9zEcKVrlFNts5s3BmJhYIwaI4EQLx4KSX4klDVzMrkAyt+idDBKYN//UEoQu0BmqRpZSxKqBXvjp5mHYa6yZTvAUMZw3G6+ufMo4Npk8fyb5XjnssQ3ejLQtBHYWdNNilrDg6l3TpNbbEbwXvwf+SyxwNXzHSrq5w5UjV5Ot9M74KYMAeV97n8Nu5C+v6Pre/eQEF5dvexKcZaVR1IPatuVFGx5hA5TTn85Ub8AtzOxUd74wU+3NOrRcTFuNxLJrtmpBSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAkdfZBqujZpEB1xS3FZdn/FhhyCBjGfHf80HZSDJWA=;
 b=2Tc0U20qIpH8IsSJahwD3ssTmCErjfZYRJe4JOUjJKrd3pWmg71akYPv5H6qonYcprbuV11DbtT9icafQgD8LuxFI7uGWUnrUfE/3znnaiaDK/Q4Gyrz9dMIvyf2Ldk0DMQMYV2CddrrICZC0cyXL4PGmDr20R/2UwEbg1MiTfY=
Received: from PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::6)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 10:05:47 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::50) by PH7P220CA0119.outlook.office365.com
 (2603:10b6:510:32d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 10:05:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 10:05:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 27 Apr
 2026 05:05:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Apr
 2026 05:05:40 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 05:05:38 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, Junhua
 Shen <Junhua.Shen@amd.com>
Subject: [PATCH v3 3/5] drm/amdgpu: introduce SVM range migration decision
 layer
Date: Mon, 27 Apr 2026 18:05:20 +0800
Message-ID: <20260427100522.7014-4-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427100522.7014-1-Junhua.Shen@amd.com>
References: <20260427100522.7014-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Junhua.Shen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bad223c-462f-446d-108d-08dea4448d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|18096099003|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: HG6B9Xoynav1l71nz139s5ObCblcmO8mSv3hvaI6aF5yjBwWljK0gyZqlUorIcqCXY548eY5mBKEUjC8Onyau4SApR8XOLQ5QbMht/nObZZZNS0P2Ru0imxqQg5FZ9CcSgnJksnQipMyEfUBttSSSBkrnHd403pZcQQnyFNusQwZ/nzf4OsCYtarQZDUf615bMEnyZH/NCSXhjGxk/NdsECCmqsTW6uvHE6WuN7a6fJ8Ut2dahc64RtOrIV6S05P6rcYfGT88KfDopxjgxCCXVYdaQwrfl87pfyNuKa+TG8hLeeACgATafCqQopW5Y54QYkBYnJpM2IiQawgNjHSFVLN+/5P84iHOKtUEbNwlwTJDzva/9yhmwJnIk7amXCYaYIfR0PeyAALH2AYo7ZIlpS4N2ORoFkMOoCkFK0rMAxu2NxwgUHEgPzLckztalsag4ENSS2B2otN/peOJVA2MTL/j8dhMHTHo5d6Lm87zGGq+r0OK66ZyGZSakrPuEuF1tQBzKZlT7g/p8MFI0iPqPtz/R7IXyTXNA89q28qxOWkqyxYT+pCHZSDmcamY0GhW6IXfGXfZxUri/MOqNOb/g892SOYv64icnjvl+nq9/YUo7oPQAG773/jVuI3lsB8ZeGXYhRN52Js+Ni/WZrKoFQ/CYxfWFp8fw+uXNFVxGCpUsbetBQkHpEMKy8FxwKYklYrA06wkPZEjdSiD6+IAHwcd375AtxSeJkvt7gllpcjiO55lyZfG197Ce1QwXe7c+Oe3k4LejqfLcgbQPTVBqujVdwbuF8kSDyYkq14E/Rd8D3ck3x90yX0h3cW8glZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18096099003)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M56UJ34+Gjh0s01yWEUnNUTv789IFljGl5UBhqybkm2S9FudzP9M0ysAW/vh8iAD6VJncFj5vsOTv3VpJnRvrxIyfsaflxCEGPoZSy1r0wR1OjKznTxVxWWdm3OH1ME9wQulYZMa/CWgna4lBkKLXnB7RpuBcFCBdX5pm856/1UfXC7sNOS6Nvcy6zn9zq4A794eUe/S4e7WXPXzeSHOP3UWPX6b64MALnRD+v+O4AXltzrZr6L4csfLaXFmvCh1ZuGu5HzV+hJ8/zVcH3MFFmbKCgwlYlExKjSgz4sroR8HD8+flGe6eBdF+2D/IQN48BlYWVZi8L/hMWOYLbhY5ystPY6NO40K+8t4PzozaeY5EgmoWjsk1vx0iQuTGDqVxa2S6DPnNG++gc+BlsMA4hnmnClkLUUOW3jNCzuZmzgJXpdYA3umCnwzM4vndqZS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:05:46.6163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bad223c-462f-446d-108d-08dea4448d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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

Add the migration decision infrastructure for drm_pagemap-based SVM
VRAM migration:

- Define enum amdgpu_svm_migrate_mode (NONE, TO_VRAM, TO_SYSMEM,
  PREFERRED) to carry migration intent
- Implement amdgpu_svm_range_migrate_range() which handles both
  directions: TO_VRAM via drm_pagemap_populate_mm(), TO_SYSMEM via
  drm_gpusvm_range_evict()

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 140 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  60 ++++++++
 3 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index e64abb5c8ab8..cf4f453b7e68 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -323,14 +323,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_range.o amdgpu_migrate.o
+	amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/amdgpu_migrate.o \
+	      $(obj)/amdgpu_svm_range_migrate.o $(obj)/amdgpu_migrate.o \
 	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
-	      $(obj)/.amdgpu_migrate.o.cmd
+	      $(obj)/.amdgpu_svm_range_migrate.o.cmd $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 000000000000..f29d4cdb5c64
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
@@ -0,0 +1,140 @@
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
+
+	if (mode == AMDGPU_SVM_MIGRATE_TO_SYSMEM)
+		return false;
+
+	if (range_in_vram(range))
+		return false;
+
+	return true;
+}
+
+/**
+ * amdgpu_svm_range_migrate_to_vram - Migrate a single range's pages to VRAM
+ * @svm: Pointer to the AMDGPU SVM structure
+ * @range: Pointer to the GPU SVM range to migrate
+ *
+ * Return: 0 on success, negative errno on failure
+ */
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
+ *
+ * NOTE: Only AMDGPU_SVM_MIGRATE_TO_VRAM and
+ * AMDGPU_SVM_MIGRATE_TO_SYSMEM are valid inputs. Passing any other
+ * migrate mode will trigger a WARN_ON() and the function will return
+ * -EINVAL. The caller should resolve PREFERRED/OTHER higher-level
+ * intents into one of the two concrete directions before calling this
+ * helper.
+ */
+int
+amdgpu_svm_range_migrate_range(struct amdgpu_svm *svm,
+			       struct drm_gpusvm_range *range,
+			       enum amdgpu_svm_migrate_mode migrate_mode)
+{
+	if (WARN_ON(migrate_mode != AMDGPU_SVM_MIGRATE_TO_VRAM &&
+		    migrate_mode != AMDGPU_SVM_MIGRATE_TO_SYSMEM))
+		return -EINVAL;
+
+	if (range_needs_migrate_to_vram(range, migrate_mode))
+		return amdgpu_svm_range_migrate_to_vram(svm, range);
+	else if (migrate_mode == AMDGPU_SVM_MIGRATE_TO_SYSMEM &&
+	    range_in_vram(range))
+		return drm_gpusvm_range_evict(&svm->gpusvm, range);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
new file mode 100644
index 000000000000..eba0b5f90e6e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
@@ -0,0 +1,60 @@
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
+ * @AMDGPU_SVM_MIGRATE_NONE: No migration requested. Callers use it to
+ *	skip the migration call and allow early-out for already-mapped ranges.
+ *
+ * @AMDGPU_SVM_MIGRATE_TO_VRAM: Migrate pages to VRAM before mapping.
+ *
+ * @AMDGPU_SVM_MIGRATE_TO_SYSMEM: Evict VRAM pages back to system memory.
+ *
+ * @AMDGPU_SVM_MIGRATE_PREFERRED: Follow preferred_loc to decide migration.
+ * Callers resolve this to TO_VRAM or TO_SYSMEM before calling
+ * amdgpu_svm_range_migrate_range().
+ *
+ * Only TO_VRAM and TO_SYSMEM are valid inputs to
+ * amdgpu_svm_range_migrate_range().
+ */
+enum amdgpu_svm_migrate_mode {
+	AMDGPU_SVM_MIGRATE_NONE,
+	AMDGPU_SVM_MIGRATE_TO_VRAM,
+	AMDGPU_SVM_MIGRATE_TO_SYSMEM,
+	AMDGPU_SVM_MIGRATE_PREFERRED
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

