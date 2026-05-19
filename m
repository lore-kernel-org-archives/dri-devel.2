Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A62CCD5BA3
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F25110EBAB;
	Tue, 19 May 2026 09:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yc32S4E+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1028C10EBA5;
 Tue, 19 May 2026 09:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXJLBa/OhyatvGVOKWkA3wJ511+6/iATfyQbuF1VkCAqamHCVSCF+oTGws7MUzy6YHLjWHbPkaAcLDn5tyVxzNJN4B+z47EKPiISdwtgI5ip2bSDu91vyfHLv3ow0z3fJuRIaKNvidOPVtdMmFwuRZeUWoJS5xo6mgKzNW9EXfhMnVH0DeV3yWCIhflZBr/nTWo0Jggoai14lC9h2db+qxcOF1LqEHQ+vFOu2ghd5Gb9vz8UdNvG6+Bct7LE/YMqt0JgfxaZaF9pSbkvWBmxcS6olaQpIIFdZtpQZPbh24kAO1CYnBdVC+8Uvg4cxHuJuIp00XgvI0drQmuSY+qPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmwTEebhc8j+LDQjKlbHUvfhBbKldBAWL/m99oIUgwA=;
 b=AOItRp45WfTK565/icRn580iGWHD7r16Mn1L2k+6OOT2gZzj5kehLUQmKFnYszhOb6ovMuIbpNnJDEP5yZ0JB31lyunUDr9OLufROCbx8rD4TN1MzoEzsQreQ6BmwRnexujAUcqGbq+5q9mb9Nr3N3oHstQ21kNQtoydqtV8GzR73U6Naojfdll9ACBdc2OtlIGonpQBg3eWXa5zPZIFpsmqkebkhn29M0HBl0SRQx/htsaeLdwarBhv9wnWpu9ww37PEou6PosnBi0rHWJE1pAmUW/aqDV/gnHE0C4/jzsmcsinbjRPjfACYhBAmMqG2TY3rwtoekRgs+Tl5QkNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmwTEebhc8j+LDQjKlbHUvfhBbKldBAWL/m99oIUgwA=;
 b=yc32S4E+tMgLVGX6Vl4MDqTf6+/VROH2fV0ytEHNNAiDrpbe89eA7t2lkHv14Q4tZAo3UkSfnTrxG/ZvJPB2eUN2duOj7707gxCE0LefH64rnKGK9xTW1eM2E9vf4CZ2lEZrYCpyu8U2hWPbnKvVGTDldAV4NIclIzpn4zshKAI=
Received: from CH0PR03CA0327.namprd03.prod.outlook.com (2603:10b6:610:118::20)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 09:23:37 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::67) by CH0PR03CA0327.outlook.office365.com
 (2603:10b6:610:118::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 09:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 09:23:36 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 04:23:31 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC 1/8] drm/amdgpu: add xnack-off restore types header
Date: Tue, 19 May 2026 17:23:06 +0800
Message-ID: <20260519092313.3115848-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519092313.3115848-1-honglei1.huang@amd.com>
References: <20260519092313.3115848-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 84400231-490f-4a1f-03cc-08deb5884e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|3023799003|921020|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wpPG7T4HJC/ZBEIdUt6ZRNCKYqZ7it38IsuPXMtEO2A8FMefQrbVQXFYQEg9N9vkLA0mXMOCMZ5B8Zss/CBLhnNgrLMXBSgklVd4M6NUQXYCQ4W+kRLLG79fkb4x65ChkZBUAVnI7/3tXy58lFrsdROJG+rkysWO5rJhMd2JUdzXgT99kwpmHE/x/Ys5EKXjzm8ZQApzu3BdR9lyiQtME9t2oFCGOOoTuC5emxM7eQSZ85ZPFQyQwrUx+qMStWBtPzGY28leLd49EwJ10lVyonJS2bre8KC//B+LbTqagqUYB7roaShKgZ0koKV05ehY4VLRu7kJ4yhl/LmaWen/Z35doCyNJ0DuKEpeQs/ul/2LbYaNfhGkbSDw2IukT4/GmYfO0ehAJ/W/ghOIJ8PY+sU5ChOpB/k285YzHm0L7ZQdFXuIo+8rE/wsJePD6bsl0GKZivr7UuL3nUqX+Or3r+dI7fbANYa2Lj1H4gi7YQxkZY0agIIgCKD/M6nIrOmFYuLMaf4XVAoNv4OYUq/fwqxVs+Iq+hoB4x3LWlpSefhaJKriyGD1QbNqONyDT/A8NkJ+eyrmxXeNNq1qx2wqcNSdfA/XCXUt00EsUmZsa8Ra0evwSqhVazSjqn3hWkVz6mJbrORInOWF8z3xsyw6uM653cBjFjayke12DLbtBzf5oTCocJjfknGzhelIvGIjcwMptt/gfrABF2wrz9ZevcfJQveFnuxzInw4mghmSYj1XziQ9+9dspE41txf4QMUpscauz5WXHsqZT71Koj1pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(3023799003)(921020)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Er7NPEOye5A3eSTxafSByk5N70uh7Ef5S1lRBKnjmcUrdN7g70/6VhUQPyEAwIwKN+pEriuw8Rye8LSDfo0evJOSpnl6oZ+/HLNCHikTxEtJ2kxdXrcDtDZzprOpWkqJEHTMo/JJPrCJEkI7b5iVBpqhrOl12qBGZjfFZnjv4eukFEZiqr9IhamGHZQSDdfmFOg73iRMIJBIn/P0seJPe4R0ODpJZfeDaPdWw/eYfCFWm/9nSb1Ahg8wcw/nyMdZOk7U+uvoD8sEJMmsUEJX5w6v8I1XUhCBFLPLDQlTotxCBVleX7GcCDbkKJlPdwico38hQ2LXvfzhNaGcQaBTgyHQ+md51QgKcbrYUu7Tmn1Yo6uoD+/MkXFEuzg0JmP5Bxe/kybzeXdd6ODvsi1F8RGmObQxBZWW2kG0ZfhDZFAa0onwSbofLky6ZuqWQZ55
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 09:23:36.6371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84400231-490f-4a1f-03cc-08deb5884e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893
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

