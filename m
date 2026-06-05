Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43B5CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC5811A53F;
	Fri,  5 Jun 2026 07:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iTZ45cuK";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013005.outbound.protection.outlook.com
 [40.107.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D2C11A540;
 Fri,  5 Jun 2026 07:54:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQv6ing4mGWyJysxzRZFvYrFiM6vbl9b1Nl0r+mkGaSd0CT61/yAkqX9W/NPbIWA4vEuldx1TzV5AVWSqd9+tjsITvw12biBFLzo2HOwkC3307cMfEeYdgfDT8K6Ij+/Pv0nD1ZrHPnX4speCJ8IrQdAH1tr9pwGAIJl6xlVte4i0rVNS7mi2OIXTLLPHB7RVpIqiokBnLaaX4avjjeBkruYLwenT4NJ/WbM08Y3semSNwVJSaFbySX2BzdhfGdw11iB49d14+Z+tsdfiwKsZhgAvlx2y12yMJYHfWM1ThtuxrpEAfaJ/ou/Yy7YHMBIJZLbHmZ7TBiXLLiwSvnddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFcdaVDDmNY7nSvk8ddJm4gTPyF8vY1WqlQEzB5vNIM=;
 b=AXsY09wVhLmgUYj6aRN2XOJUftX36nE4O4Zyb2Vw0127n0VvQrDImJuXOoxJEXuK6cJheHfSY3WiExIxcHQly+RfbZiDozoTN2BzYX1swm2p8raMXiBSNSJt0ywSWY2L9os45KCIV+TsGrBCUF7c/ymcCD4PNya9a8M3wLkVJqq9RSPVUely2TaFwU8TGMYX1gyjOLVNpvcAbdjxq+hK25+i5+EM53FsOAbJ2etrWt5VBUqQAWX45uortAK44y2RrPpT62e/yZzDzQDM48PZ2RjHw73WrHqWPnrJisDrxCAlukn7OnNB6Lb7fuA6Doi2PMijovlzGLGTdMrDd1iPEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFcdaVDDmNY7nSvk8ddJm4gTPyF8vY1WqlQEzB5vNIM=;
 b=iTZ45cuKcmb2giypOo4uNf5wwOX9u6fKQwFTjNy1Hz4gDZ+YlCB76xeWXm3tRQ6FfK6ZCjrvAL1JXGuRn0p3GTkM3mhZ+CgePKHAd9prMp8BpYE1IzEseBzLetWhACvjfSG1xmZtI7pnW8Kq/ZIcF9QQA1aV2HLX+K8+Zz+PLbY=
Received: from BN1PR12CA0001.namprd12.prod.outlook.com (2603:10b6:408:e1::6)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 07:54:02 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::ac) by BN1PR12CA0001.outlook.office365.com
 (2603:10b6:408:e1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 07:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 07:54:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:01 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 5 Jun
 2026 02:54:01 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 5 Jun 2026 02:53:58 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>, <simona@ffwll.ch>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Junhua.Shen@amd.com>
Subject: [PATCH v5 5/8] drm/amdgpu: add SVM range migration helpers for
 drm_pagemap
Date: Fri, 5 Jun 2026 15:53:37 +0800
Message-ID: <20260605075340.20199-6-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605075340.20199-1-Junhua.Shen@amd.com>
References: <20260605075340.20199-1-Junhua.Shen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd839fd-6a5c-449a-7a22-08dec2d79bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|3023799007|56012099006|5023799004|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: kMWhB5j6bEVJaZHf0J7t9kWudW8XtXr+3UFTIXdA1TLsvnKlS0NeFsx5NDQm6kcvwPoppvdFMvxwk7aZ36O7MeHUO+H4h6v6Aew+2tAoEjZJKTA8McKd8Of10s1bvXG9cAGh0Fv9XGm+YvdayIiiZgblPa5XnOihwnI+qJYT+H3FDdwiBMszku3nHbCwvbyulfw43Xy9013yI/T7K1k/8h527mb7f6IPoIhwws/qnJdX3/gMxHD9Pm29AvkUx/sekpvnWgG04cIOlGGk5d4WApLB38Np6QUPMIy/8OEHjaA94CA0Ss/qFHcECwDehPWK++lOQs0HkjgP1KTafWycUSsJt30p0AbMoZgeiXziO9lAhXedlA7r+R/EsP3k7GLv8/GH9ivNPSiq7Gk7Kc8UV7lgnHxWEqhvW0wbB5FOpFWFlU4bJX34LaxeP370sXDjBRwxqQ82R/Po8yBCWxbVwKZoWyQrolMhve9Ual8/li0W/nUXbtmYwdCiY4+e63l5VJyf+vuiU670/VHeU0WLWKSBWgEgOpLDznJWqmWeLg+NlbtbihXkzzuV58JB0ZTpzyoysHMh2bujB2GkxQkkQkEYdNiWRnT/m0+mx2hZmjggVZ4CpRZWdt5Zxc2PDLhkGxesSUKae/abZnXsGW98idG91+VW0+mxAwAhL0qZnvEGZLoXssAEvucxFo4TcEcshwiyEqROcPHg865PgKwGLtJUYC7pYJyr+9LlSsW7hqrkLJhard2H5Q+WY1svQ9aUKUARbmrk63zk0LG1AGaq9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9TOh0z+ev9sG1U8Sitg0rzT/Y3BCYB5VYFXMxJ3A5PSuOv9rm4RMEH1cyPitRaXk0S0LMbjeXaxxg+TGQ2Ui7NhJyyx4nifYcIomWL7j9RqubJWVlqqKufnlu6zhuBjUULRfFxlKampyVM3rg9Ap/EnH5fhCIOgY4lTL7rKMdwzd5TOJ5IzGnlg34pnsxZAPMAMBTEQS4xvgTuW2I3yrKmKA/+PumVK9COehTaJRQRNo9xfBj+sL+lJdgORxLjBheuRlVZxqB7NDu74Q2dT25tVhDwQXzM+xwoFRV5p5k6hjphIBTJtEcZEEC0GtX4oP/Ta3LQLdT0+JicFGD1F9L2TXFMQ0+CwQ0I+Cvi6+GGp6uhDCqo0QP7vpWFTuGEJuHGBUaY5O+WG+V+9cDF4qwNaWJ7lgsyJnUZfduvP1pxNvyC/sFMBZP/yOkxN6m5x7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 07:54:01.9901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd839fd-6a5c-449a-7a22-08dec2d79bc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624
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

- Implement range_needs_migrate_to_vram() checking migrate_devmem
  capability and current backing location.
- Add amdgpu_svm_range_migrate_to_vram() wrapping
  drm_pagemap_populate_mm() for RAM-to-VRAM migration.
- Add amdgpu_pagemap_capable() to check device memory support.

Signed-off-by: Junhua Shen <Junhua.Shen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 115 ++++++++++++++++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  35 ++++++
 3 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 08207cad310d..d644079f3e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -328,14 +328,14 @@ amdgpu-$(CONFIG_HMM_MIRROR) += amdgpu_hmm.o
 
 # svm support
 amdgpu-$(CONFIG_DRM_AMDGPU_SVM) += amdgpu_svm.o amdgpu_svm_attr.o \
-	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_userptr.o amdgpu_migrate.o
+	amdgpu_svm_fault.o amdgpu_svm_range.o amdgpu_svm_range_migrate.o amdgpu_userptr.o amdgpu_migrate.o
 
 .PHONY: clean-svm
 clean-svm:
 	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fault.o $(obj)/amdgpu_svm_range.o \
-	      $(obj)/amdgpu_userptr.o $(obj)/amdgpu_migrate.o \
+	      $(obj)/amdgpu_svm_range_migrate.o $(obj)/amdgpu_userptr.o $(obj)/amdgpu_migrate.o \
 	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.amdgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd \
-	      $(obj)/.amdgpu_userptr.o.cmd $(obj)/.amdgpu_migrate.o.cmd
+	      $(obj)/.amdgpu_svm_range_migrate.o.cmd $(obj)/.amdgpu_userptr.o.cmd $(obj)/.amdgpu_migrate.o.cmd
 
 include $(FULL_AMD_PATH)/pm/Makefile
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
new file mode 100644
index 000000000000..e51657c2a65c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
@@ -0,0 +1,115 @@
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
+	int ret;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h
new file mode 100644
index 000000000000..6e4b6e45512e
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
2.34.1

