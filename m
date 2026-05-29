Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887B2CD6E49
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A272F10F904;
	Fri, 29 May 2026 05:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k8bOwJL2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD4310F8FC;
 Fri, 29 May 2026 05:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wR0LAOf8LXOPPVMO6PWVBZ5kmjcczZ2FYnFl+5X6qR+D6XcbUeOew+/rNRdQch3jbl8KOli+uq2+ZXevcVGqA2q05rSMV1vXOBkTTa75maEHo98g5KdMAkIoqZVsGvXy45RhqQdUu9D8TtPyScrbLqKY67jaDh62w9xW6ZzGBHlGPGLHBSlNO0YgHIjzmXsB0hPJeTIDAxc9CPeaH3y3kP9B+yYh81RdliNBt1L2DpqtQtZhPxGOZjDQ5jwxQWvbd9AyoX0HfN9VV/FSyCcVjuOb2OLc9wkyYKIPTF3ko7+Uo5HO0Qzu2gvbcUB0TeYZJggeGsBKMGH0sh70bgU67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmwTEebhc8j+LDQjKlbHUvfhBbKldBAWL/m99oIUgwA=;
 b=uLoa7Jvel/G+5ZOyJTgp4kHvhmvQQa/tzmRIIJF+qS6/TYpQaamvFDpJBIZQt61fXmU9jNHjeLjyZ9Axmw+cNxrpESTpJar9sSLPaM4MNcq1brdCXWv3lUdPafa1KeZ+o/ojshrUuTQkc9C6M48HSSU92/VORU0Gu8Wii0aWiVTKEC01Zj9taRQbtuj84YikDTgcduVGQB+YERLzbErCdChyfzeRfLzpMVDUiKT++lVmkMeXp/kEX0beLjCPLGVsBxI9psMzk4AorM5McFElWBU6/lKiyIaZClQG4LiSAUfRItXz1GGyF4I1BW+yrG9mR9I96Nc0jDeO3SJESqXb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmwTEebhc8j+LDQjKlbHUvfhBbKldBAWL/m99oIUgwA=;
 b=k8bOwJL2FKxeBERIU1PMzjoqdACldkdik8su2TaaIBhBSXrVePiTrFujlUugCoO/qoZMjLy4z0L05u5wmi8GYKwAFko9vZbpxKlEsgGVG7yWcwmwW8ZFHfJQAeLmAtxOtqjCPZZ6XThiO+4SEm1LlTN1JLFi+bFmAUI+zBX1t5M=
Received: from CH2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:610:51::35)
 by LV8PR12MB9336.namprd12.prod.outlook.com (2603:10b6:408:208::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 05:49:50 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::35) by CH2PR15CA0025.outlook.office365.com
 (2603:10b6:610:51::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 05:49:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:49:49 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:49:45 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [V2 RFC 1/8] drm/amdgpu: add xnack-off restore types header
Date: Fri, 29 May 2026 13:49:21 +0800
Message-ID: <20260529054928.596825-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054928.596825-1-honglei1.huang@amd.com>
References: <20260529054928.596825-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|LV8PR12MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 036405cc-ce7b-4216-2339-08debd461912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|921020|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: XoLo3HMM3B3Yx8IzuePJG12cS4PBd2OTuRxBXs46xLEuYtPCUWhk9hrnUQh+GDbfR/LXE+qgBbq4aMWovevSrcNjodDOR/OJxctW//7S4fLsccj8RPXMAkc39pLBhAtKNVEKZxBBqFC+S/i6cycIs1vnlA2QQbJxix8hWivgEzwz40VuNsj8vTXrP90bJngija6JYJhiEFmvaibhZ64+WQyDi/SUb1RIYDOPi5Br54y92QKIOzi+9eTGlsNQqW1mCLdlfKCwklxIF8c7Z+wb8prGgz6e0s6ACMFlKkPN4cGl0p3b4TKwSZcfbE9lsiZSXWsUkIMxw3VvMh4uEjzriXZY9P9GRG6SbaNAuiVu7pCjvYzlp/FwNcSodhuYSPFVYCIvoSG5GOhASKI37XN2EI5dMUQnrmH5W2niojxb5xQ7fJ4t0B+5zymbKyQr4We/uNpEIQ3p9HrZjbsNQkVYvB45uJNFnGUBKn2JAffqKvLFbyypQ4jg7YKaDCuqfZ6mSAX6BiJQOsVfV82u8N2jHtcU/fdIQI5N03raiqvgrnGUmuc4XwafbmaYeLlCo6qozPoEJ96PuI0j9dOjWqZ018To//ynwylAIRVTq8ifzk2LDjOWQiPfApMuGxbkSJtHfz9RWhJgi7SgziU7DSFvDKpIu3FtB+ip0V8XoiomQp23FKMD88cgfql+d5VX5XChQO7OOl26Czv5T+/2H29sD3WQFO/6aphA9BmiHypVE8aZHuItzD0dz0wH19sUijJD/5Q5ZvNLNlykGVLVGrihAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(921020)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qTwVyP1aU7uv8LFlPhgoH1cdsyTnLj/2MTXylyR3g2/Gklfdp9TH8oSfGyLAjMZphRe1u4EtPlIm52euAKe3bDof0Qq7BlUndolmGScCPZuWj/hvwrZRY14awFkkwhANNO0T3w1wXuvOS7kobr1CD4P4m6kd3Y0rjWMRUroa70Qx51jBxcuDEj6SV/OKiNSfIl17giPV+UaN/MV8mvGCE75lh/REDjvdMsVezCtstZez2MuZBpEE2H2cbnoeJjhSyWyWC1u0O2OcK9yhBfzpJFIWxEWYSLRDmw4H973sHfPSROoTRhUQK6+bxatSm5gRHnU+a/xNZQJyRclzRFy+s1wYREFhK7C9LN5Cx35BZ2gDtSXkXBr5kvo8NLPgph2LbE7G1nvSFzYc+BcrPPKMYKcyV44DHNqyXpnnhQaxeDuDXZYyDqKbX/d0BexAN40g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:49:49.8832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 036405cc-ce7b-4216-2339-08debd461912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9336
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

Add amdgpu_userptr.h with types and declarations for xnack-off
(noretry) restore infrastructure:
- AMDGPU_SVM_RANGE_RESTORE_DELAY_MS: 1ms default restore delay
- struct amdgpu_svm_restore: restore workqueue context with delayed_work,
  evicted_ranges atomic counter, quiesced state, begin/end callbacks
- Function declarations for restore_init/fini/flush, invalidate,
  gc_work_func, quiesce/resume_compute

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h | 63 +++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h
new file mode 100644
index 000000000..a8f76f785
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userptr.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __AMDGPU_USERPTR_H__
+#define __AMDGPU_USERPTR_H__
+
+#include <linux/atomic.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+
+struct amdgpu_svm;
+struct drm_gpusvm_notifier;
+struct drm_gpusvm_range;
+struct mmu_notifier_range;
+
+#define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS	1
+
+struct amdgpu_svm_restore {
+	struct workqueue_struct *wq;
+	struct list_head list;
+	struct delayed_work work;
+	atomic_t quiesced;
+	atomic_t evicted_ranges;
+	void (*begin)(struct amdgpu_svm *svm);
+	void (*end)(struct amdgpu_svm *svm);
+};
+
+int amdgpu_svm_restore_init(struct amdgpu_svm *svm,
+			    void (*begin)(struct amdgpu_svm *),
+			    void (*end)(struct amdgpu_svm *));
+void amdgpu_svm_restore_fini(struct amdgpu_svm *svm);
+void amdgpu_svm_restore_flush(struct amdgpu_svm *svm);
+void amdgpu_svm_restore_gc_work_func(struct work_struct *w);
+void amdgpu_svm_restore_invalidate(struct amdgpu_svm *svm,
+				   struct drm_gpusvm_notifier *notifier,
+				   const struct mmu_notifier_range *mmu_range,
+				   struct drm_gpusvm_range *first,
+				   uint64_t adj_start, uint64_t adj_end);
+void amdgpu_svm_quiesce_compute(struct amdgpu_svm *svm);
+void amdgpu_svm_resume_compute(struct amdgpu_svm *svm);
+
+#endif /* __AMDGPU_USERPTR_H__ */
-- 
2.34.1

