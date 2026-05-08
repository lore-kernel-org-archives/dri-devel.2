Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738D7CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA83610F3A0;
	Fri,  8 May 2026 07:52:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WXPDZ21u";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D459810F399;
 Fri,  8 May 2026 07:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDeHxsalhq8cnqppRwDYo4krTS/O5HmvaQLTqUnNIYzzMlFuCRX3AzFJ9LgZZXw8WFPbujhacs17tay5JdPmqPm71JHyfZt1gG0bRwvgW5ulBnGIFwBoyxJxAuoFsiOhyqwbnmX6WjG06tnxZAGks+FuCDmM2VT3QHh1m8kHJNJEVdlACPzgMAdSrMqeXdhvqS9pNM1xbB/jdQ5D0PrcivUoIv8MjNBSzYV9caKf74xu+T0exV6zgKpDNyUKd7OO96H45KvOVvY6e91vtNrop6rFCK+Jn8RA3VYRxTc1ro03SRTHT3WEzEVskD0Z+ns2NZYAOwu1NwAoRLxPlg5G4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fY1svWe52lwWeY8rVfVA37qy0b42M4LNY1wQ9VrTRo=;
 b=k235jK9V3l78ozXtoql8BwsezgPiJkG0fly0Fsy+ge2KNCpOeyNNMPY5IK7DLMYf72iC3n7WcXycV10mU8dttusX1PURmnsYAErHLwyfr0IoER/QuOqLcyJjvj53+W3iCwmjlZLCL1nrssIR5qvkcJ73PI+u71aOky7Z532RPkPYOafUD8JHWCLvEM+aiRufJdCf8tD/NQZH4dPw4de2O3urrgbqI7l/OsF1iGq+RGWb+r3AnzivWadbPBnDmzPhtM2jDrlFDf1jtygIYxQQZ1yzq+ZCU8FYlxzrlFU/OToujYJuWMoDDmoIZc8KO9iQwxXiyD5k4KRCX8DhLsd4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fY1svWe52lwWeY8rVfVA37qy0b42M4LNY1wQ9VrTRo=;
 b=WXPDZ21uktKoGK3S0mdAlSg7Is8IxBCdqORk4LeTChngpnewZX4P1ce8UEW1aDGo0BKUOkzPdYUgJcoYT7DYh4Vsa7SfzGGxMwIPmO5tRvZXtaOn/cULhULyL/8jdJySB8y2pmP4FluPizTx7chGBJEqq53DAqYRtgg5PLQvOEU=
Received: from MN0P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::16)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 07:52:02 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::8c) by MN0P222CA0010.outlook.office365.com
 (2603:10b6:208:531::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:02 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:51:56 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 03/12] drm/amdgpu: add SVM attribute subsystem types
Date: Fri, 8 May 2026 15:51:20 +0800
Message-ID: <20260508075129.1161157-4-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508075129.1161157-1-honglei1.huang@amd.com>
References: <20260508075129.1161157-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3724ca31-b96e-468c-bd6e-08deacd6b0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|921020|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: RWdgw2nfAnPM0RpkjvvcUTMv/MY9dBrqhvbpfx7Kd21myDyNrbLuFDfVfi1EslS7Mhj03/HS971SmmocXrq3pHlMvsNEyVzosxWQzrijPq12MVC34QgTlV2ntUnCxUX0Jroepr27VqV7KVr+J/zzgHAnsSlKO8Q+o0wcKwVEEc/yVlj8qKNEzhVVUflLmMPCcZcci8DICwC5n0NNR777HUuTznaucK4yKRL9oO35WI/qfL7KD0PnvYg6ADxf7RUghFP1ax3TuIfePacSnwCfSVJeza0HNlZ3NENKihzOoMBYV1Gei4PqtuiXfbMPH9GZVaNyhfcs9l4gMU/023jXAfl0da2TwhWhKjZ0+5eyQJPU5cB+/XAtKQrcq5NWmLFspqVeTbqEI+QDRsmIfMOgI4udB5SWfVyceaeeLFs5Q+tEZZCCCFHgnJ9JK6bwYuM1vrPAvMF7WgMmYZHAtKa/4QvBmNObUa5ulk9m3SxvFM48YrZ4c1Dbt5IUhkXh0X2cho9U3P7KDyiMsQdWYDG15MuUtitogITxvZzzJMyHULdw+WZJ+jYAsoICnWv1a95Rl03/sIxiKuvyB559E0VsLvr5YYomNAfLJbAhy1o0KKxuNZopp0pnJ/5hgliKPSF2nX420U3veCaZJ2tStXaauN1tO0NaUQx5x7KAMNbK+M3/iD/KhLf+zEwIBuhPFUWjzvRYMJIenGbcVUzZDdzsN99lHSv/M9IkGlqFsC+mwhvxXb4XsE76mV+W746lmjS7L9D6SiVqXq4F56VGJU7uZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(921020)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d13Eb+86glB6WxiiwzROHd4N2Ux6EuKI6HuwnT8+9usC3kNhA6tP4keVm6aWrLE+n+F6K4+SHuNpJbJrC32hRmjQ8FZyvihsia2+2z0g+R8rGqhjHNUHFVgCZs/rRjFwGZLZRYXZ4tvmkK6sm2P8BBEiMSmrbw2YgYcgxqFPt/pPG6cNPjbxd7jlB+aZtZWgeXJW8y4PaAHY31B2KIzthokf9+8t5gd/ozRbPOn+kAAQd//Anvq54/bUoh7no+PslwYsP9RL+yrNWMFU12DQMzFrflOH7isGROESvO5flM4uM5SHtusSBHnyRXn2iOYvbP2hti8evC6bAO8aYf7r1wd9KP6mS6/X6SnFDTC5j4ox0HhMnsDU5EThzf1aoGeT8u5Bm6t0odHTztBxBmdWIlItm4SqyGoHaPbBDkGEfyhtqwvEWRDmfTc7FN75YIFP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:02.5231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3724ca31-b96e-468c-bd6e-08deacd6b0fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

Add amdgpu_svm_attr.h with attribute types and tree infrastructure:
- Internal flag bitmask definitions mapping from UAPI attr types
- PTE_FLAG_MASK and MAPPING_FLAG_MASK for change detection
- struct amdgpu_svm_attrs: per-range attribute bundle (preferred_loc,
  prefetch_loc, flags, granularity, access)
- struct amdgpu_svm_attr_range: interval tree node with attrs
- struct amdgpu_svm_attr_tree: mutex-protected RB tree container
- enum amdgpu_svm_attr_change_trigger: change classification flags
- Inline helpers for range start/end/access queries
- Full attribute API declarations

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 174 +++++++++++++++++++
 1 file changed, 174 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 000000000..97bf0032b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,174 @@
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
+#ifndef __AMDGPU_SVM_ATTR_H__
+#define __AMDGPU_SVM_ATTR_H__
+
+#include <drm/amdgpu_drm.h>
+#include <linux/interval_tree.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/rbtree.h>
+#include <linux/types.h>
+
+/* Internal SVM attribute bitmask flags mapped from UAPI ioctl definitions */
+#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS			(1u << 0)	/* AMDGPU_SVM_ATTR_HOST_ACCESS = 4 */
+#define AMDGPU_SVM_ATTR_BIT_COHERENT			(1u << 1)	/* AMDGPU_SVM_ATTR_COHERENT = 5 */
+#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT		(1u << 2)	/* AMDGPU_SVM_ATTR_EXT_COHERENT = 6 */
+#define AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL			(1u << 3)	/* AMDGPU_SVM_ATTR_HIVE_LOCAL = 7 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_RO				(1u << 4)	/* AMDGPU_SVM_ATTR_GPU_RO = 8 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC			(1u << 5)	/* AMDGPU_SVM_ATTR_GPU_EXEC = 9 */
+#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY		(1u << 6)	/* AMDGPU_SVM_ATTR_GPU_READ_MOSTLY = 10 */
+
+#define AMDGPU_SVM_PTE_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+
+#define AMDGPU_SVM_MAPPING_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
+
+struct amdgpu_svm_attrs {
+	/* keep preferred_loc to adapt to kfd API */
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	uint32_t flags;
+	uint32_t granularity;
+	enum amdgpu_ioctl_svm_access access;
+};
+
+struct amdgpu_svm_attr_range {
+	struct interval_tree_node it_node;
+	struct list_head list;
+	struct amdgpu_svm_attrs attrs;
+};
+
+static inline unsigned long
+amdgpu_svm_attr_start_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start;
+}
+
+static inline unsigned long
+amdgpu_svm_attr_last_page(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.last;
+}
+
+static inline unsigned long
+amdgpu_svm_attr_start(const struct amdgpu_svm_attr_range *range)
+{
+	return range->it_node.start << PAGE_SHIFT;
+}
+
+static inline unsigned long
+amdgpu_svm_attr_end(const struct amdgpu_svm_attr_range *range)
+{
+	return (range->it_node.last + 1) << PAGE_SHIFT;
+}
+
+struct amdgpu_svm;
+struct mm_struct;
+struct vm_area_struct;
+
+static inline bool
+amdgpu_svm_attr_has_access(enum amdgpu_ioctl_svm_access access)
+{
+	return access == AMDGPU_SVM_ACCESS_ALLOW_MIGRATE ||
+	       access == AMDGPU_SVM_ACCESS_IN_PLACE;
+}
+
+struct amdgpu_svm_attr_tree {
+	struct mutex lock;
+	struct rb_root_cached tree;
+	struct list_head range_list;
+	struct amdgpu_svm *svm;
+};
+
+enum amdgpu_svm_attr_change_trigger {
+	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = (1U << 0),
+	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = (1U << 1),
+	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = (1U << 2),
+	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = (1U << 3),
+	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = (1U << 4),
+	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 5),
+};
+
+#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE \
+	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
+
+struct amdgpu_svm_attr_tree *
+amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
+int amdgpu_svm_attr_cache_init(void);
+void amdgpu_svm_attr_cache_fini(void);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
+			   unsigned long page);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
+				  unsigned long page,
+				  unsigned long *start_page,
+				  unsigned long *last_page);
+void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
+				 struct amdgpu_svm_attrs *attrs);
+
+int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
+			   uint64_t start,
+			   uint64_t size,
+			   uint32_t nattr,
+			   const struct drm_amdgpu_svm_attribute *attrs);
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
+				       uint64_t start,
+				       uint64_t size,
+				       uint32_t nattr,
+				       struct drm_amdgpu_svm_attribute *attrs);
+int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page);
+int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page);
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page,
+			   unsigned long last_page,
+			   const struct amdgpu_svm_attrs *attrs);
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range);
+bool amdgpu_svm_attr_devmem_possible(struct amdgpu_svm *svm,
+				     const struct amdgpu_svm_attrs *attrs);
+bool amdgpu_svm_attr_prefer_vram(struct amdgpu_svm *svm,
+				 const struct amdgpu_svm_attrs *attrs);
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
+					unsigned long addr);
+int amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
+				unsigned long start_page,
+				unsigned long last_page,
+				unsigned long *bo_start,
+				unsigned long *bo_last);
+
+#endif /* __AMDGPU_SVM_ATTR_H__ */
-- 
2.34.1

