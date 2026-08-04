Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28967C55172
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 09:43:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724FD10E95D;
	Tue,  4 Aug 2026 09:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+GB4Fio";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B82A10E952;
 Tue,  4 Aug 2026 09:43:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTZ0V1zCUwuepA4Z8B5gnXBUgdfl9Eul70uGEkEFcQoaS8ZfkAvVHobSKPJE4IgcLSNTI2hVoFPSdkCkhwizFAhlhwx4D6n667yWY6vGz+9Gun8bgiYBNqHB3z2y70wT+5bXgVPnK2P/Q7veeVPjiCxn4KgeEQB3ondK5dDxfKX+Ch80dUSs0b66NpUdUNt3fXzcKgv2X2xdEGOOMdWMd/nOcSwmUQT9SxP6y42EIW8Mzr58ZMNdRbJiZmOU5WpZpB06FnWXv/P5rgEfTk2EIrQv4nvX9XrZYK3zKyZwf1AyAsp9CmYaTpPG2l+SxkcUgM6+rw/RnYYkDMaDzF79PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XuF/BossCWvrCYnQVj14mryMgWzstQUI1z5YnQrq0c=;
 b=wXf2cU94Cdg2t6FWxunx+VNaxmD25JXYqoZAmIFVKaNDVBrOTHpP9lSweUMxM54B0B7BEGxK4TlfRUvGr3NMb4nMAy1oNpg0qZcPd5v6qFb8JnSiLtHhs2O/xrJpGAR80AEY1+R///fikSixYCd00uf37cGfe4YLQQqMcf07ZmMIBJSEBGcpGnVRDezczS/HHJ1Hdmp2Ie2+TyQzVECR6/6cXkCQD0H94iYMdBGdQQ6SMhcwefMFWtbdkbZHlQxnAf7ZOMVnct9bQIpC06IPpxaAv4r5n3hQ/xDrNmm2ZT+dIhlzmwFT26GLxE2WOQ54EtKTzPdHrb8TICMjWEnohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XuF/BossCWvrCYnQVj14mryMgWzstQUI1z5YnQrq0c=;
 b=d+GB4Fio/+OKp7Vm9Yuli/lACiE4Q6gc/OHJcMV2Wc51fOMPQWgJdlIZBhURlHU8rnnUXTOr4ElAk1Hvvu23MlFXpQ26IIFgzpntbmKtT5QYL17SF9giGv4NqrvhlMJI0XmNtt+EGbhIM399a4dswfw4o7QeYoxZS5itT8lW9t4=
Received: from PH8P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::35)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:43:18 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::25) by PH8P223CA0016.outlook.office365.com
 (2603:10b6:510:2db::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 09:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 09:43:17 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 04:43:12 -0500
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
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v9 03/18] drm/amdgpu: implement SVM attribute tree and helper
 functions
Date: Tue, 4 Aug 2026 17:42:29 +0800
Message-ID: <20260804094246.1719318-4-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804094246.1719318-1-ray.huang@amd.com>
References: <20260804094246.1719318-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 01689bd3-7169-4f4c-af06-08def20cd023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|3023799007|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: JCjy0Rduex96TolbsUC0Xnjh0mXw5Ov8o7QleTBYANONEHtmvxA4eK8oPi0biaKTEBotPz76lzV65ooG7rfhNpJfLwV1cEXeenZyaCR5Y3IhnGSZfgb5edUIIBh6fFJPAPcrMd6+hyTMGFTBxJzt0pNyQxy+JWla1sMTLTes+FR202uPK1pO1vnFGrHzAVqlW3tFa5X9UqG+GFSs+IalNFTcbrhm1At4pdZo9noWrXL9VWCOPZnYHic2fT1mOpVEQzSEzd2PL+Kj755bX4hIG/lJ04oROwBa5sD1SKBdLxq6YYuNNUzNcUXg6oAdERHnP3pjDUAFGS1dyVPiMXb7M8pX99J2yz0efmJExKeKnQxvklttkP/LtXIok3cOg+bno2/z8FXdvRKKVwgTeJSuzFraop34+SiRBk/11Zzd5mflyj1b0QLt+8JvQf5DZXn69R6JxaPWrK98fHs7K+3+QhvvV8oCFWYwz84rFaVZLj5EERaxFIy8zmfwM47t+6nIjkhy1/R59dMX4X0dF07smnm4b0MFA73ip/h4nLC67ZwfCTS8XBqRaoATQn96Byr8EJZe0hjM6xAcwTALQ6UwZLyXMA+VqwRUKLs8tBX9BrtkJGKq9VDMgZnwD5seSPNhUKc+YXqyOXToZFUqM0IHOsvQKjwC58bzzJJzEzgaud3a+DnF/kNamHLEXfzGhl1se2UaA+CPwZZfi+QNCmMNxRyrO3kT0g+adBr1hAiWDS0hCHGM2A8jLLhOQ4ut25lZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ytYFS2YogpxpW0pRUf4iKzDiLDzikjEKwjVFLyVUXenjox5Xv6AiKYT9iZjGlzn9ZK+Rg1PUW5HVDKwthAy+A8Jf+EOax6W6/KYp/OEzuYVelsGvi+j/amaX19M6RgDdQVP/lY2CI+J2soSOg2BN2F0dUtW3DM2CjlVqFqVskh31SQY5glzuKcWhhO12uXT8jSprdDlnlcDKarN2cj6jA1nXaQzIk9db5nse7WAD8ydrignOZUmuJLPeC92hkYMqGvtNpgpL1jFE6Y0uDULvH/LB5Hz94WjQ4JS8m/Gw32AawEXLtJm7tC8csP0d8jQOxL0xajJie2AG5fZcpPewPBtvgdLgfxB/LvIz3if2vUAfvCouiVSk2R6KleuhWozhx0IjA3v7P0O/bPv7mGB5d5+I+R476kZvYJTpLiA/gz+pa9LMwRauB5YIh2vVMWON
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:43:17.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01689bd3-7169-4f4c-af06-08def20cd023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

Add amdgpu_svm_attr.h with the SVM attribute types and tree
infrastructure together with the helper implementation in
amdgpu_svm_attr.c that uses them. The header is squashed into the
implementation patch so it does not stand alone as declarations
without an implementation.

amdgpu_svm_attr.h:
- Internal flag bitmask definitions mapped from UAPI attr types
- PTE_FLAG_MASK and MAPPING_FLAG_MASK for change detection
- struct amdgpu_svm_attrs: user set attribute range
- struct amdgpu_svm_attr_range: interval tree node with attrs
- struct amdgpu_svm_attr_tree: mutex protected RB tree for store and
  search
- enum amdgpu_svm_attr_change_trigger: change flags of user attribute
  changes

amdgpu_svm_attr.c:
- Default attribute initialization: amdgpu_svm_attr_set_default
- Device memory and VRAM preference helpers
- VMA validity checker: amdgpu_svm_check_vma
- Attribute equality comparison: attr_equal
- Interval tree CRUD operations: find, get_bounds,
  alloc, insert, and remove
- attr_set_interval helper for range boundary updates

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 235 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h | 183 +++++++++++++++
 2 files changed, 418 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
new file mode 100644
index 0000000000000..9d3519776c9c8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -0,0 +1,235 @@
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
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/lockdep.h>
+#include <linux/minmax.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+struct attr_set_ctx {
+	struct amdgpu_svm_attrs old_attrs;
+	struct amdgpu_svm_attrs new_attrs;
+	unsigned long start_page;
+	unsigned long last_page;
+};
+
+struct attr_get_ctx {
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	enum amdgpu_ioctl_svm_access access;
+	uint32_t granularity;
+	uint32_t flags_and;
+	bool has_range;
+};
+
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs)
+{
+	if (attrs->preferred_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
+	    attrs->preferred_loc != AMDGPU_SVM_LOCATION_SYSMEM)
+		return true;
+
+	if (attrs->prefetch_loc != AMDGPU_SVM_LOCATION_UNDEFINED &&
+	    attrs->prefetch_loc != AMDGPU_SVM_LOCATION_SYSMEM)
+		return true;
+
+	return false;
+}
+
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
+					unsigned long addr)
+{
+	const unsigned long unsupported_vm_flags = VM_IO | VM_PFNMAP |
+						   VM_MIXEDMAP;
+	struct vm_area_struct *vma = vma_lookup(mm, addr);
+
+	if (!vma)
+		return ERR_PTR(-EFAULT);
+
+	if (vma->vm_flags & unsupported_vm_flags)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return vma;
+}
+
+static void attr_set_interval(struct amdgpu_svm_attr_range *range,
+				unsigned long start_page,
+				unsigned long last_page)
+{
+	range->it_node.start = start_page;
+	range->it_node.last = last_page;
+}
+
+void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
+				 struct amdgpu_svm_attrs *attrs)
+{
+	attrs->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	attrs->granularity = svm->default_granularity;
+	attrs->flags = AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_COHERENT;
+	attrs->access = svm->xnack_enabled ?
+		AMDGPU_SVM_ACCESS_ALLOW_MIGRATE : AMDGPU_SVM_ACCESS_INACCESSIBLE;
+}
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
+			   unsigned long page)
+{
+	struct interval_tree_node *node;
+
+	node = interval_tree_iter_first(&attr_tree->tree, page, page);
+	if (node)
+		return container_of(node, struct amdgpu_svm_attr_range, it_node);
+
+	return NULL;
+}
+
+/**
+ * amdgpu_svm_attr_get_bounds_locked() - Find attributes  or surrounding bounds
+ * @attr_tree: attribute tree to search.
+ * @page: page index to look up.
+ * @start_page: out, first page of the returned range or gap.
+ * @last_page: out, last page of the returned range or gap.
+ *
+ * If @page is covered by an attribute range, return that range and report its
+ * bounds. Otherwise return NULL and fill @start_page/@last_page with the bounds
+ * of the default attribute gap around @page, clamped by neighboring explicit
+ * ranges or [0, ULONG_MAX] when none.
+ *
+ * Return: the covering range, or NULL if @page falls in a gap.
+ */
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
+				  unsigned long page,
+				  unsigned long *start_page,
+				  unsigned long *last_page)
+{
+	struct amdgpu_svm_attr_range *attr_range;
+	struct interval_tree_node *node;
+	struct rb_node *rb;
+
+	attr_range = amdgpu_svm_attr_find_locked(attr_tree, page);
+	if (attr_range) {
+		*start_page = amdgpu_svm_attr_start_page(attr_range);
+		*last_page = amdgpu_svm_attr_last_page(attr_range);
+		return attr_range;
+	}
+
+	*start_page = 0;
+	*last_page = ULONG_MAX;
+
+	if (page == ULONG_MAX)
+		return NULL;
+
+	node = interval_tree_iter_first(&attr_tree->tree, page + 1, ULONG_MAX);
+	if (node) {
+		if (node->start > page)
+			*last_page = node->start - 1;
+
+		rb = rb_prev(&node->rb);
+		if (rb) {
+			node = container_of(rb, struct interval_tree_node, rb);
+			if (node->last < page)
+				*start_page = node->last + 1;
+		}
+	} else {
+		rb = rb_last(&attr_tree->tree.rb_root);
+
+		if (rb) {
+			node = container_of(rb, struct interval_tree_node, rb);
+			if (node->last < page)
+				*start_page = node->last + 1;
+		}
+	}
+
+	return NULL;
+}
+
+static bool attr_equal(const struct amdgpu_svm_attrs *a,
+				 const struct amdgpu_svm_attrs *b)
+{
+	return a->flags == b->flags &&
+	       a->preferred_loc == b->preferred_loc &&
+	       a->prefetch_loc == b->prefetch_loc &&
+		       a->granularity == b->granularity &&
+		       a->access == b->access;
+}
+
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page,
+			   unsigned long last_page,
+			   const struct amdgpu_svm_attrs *attrs)
+{
+	struct amdgpu_svm_attr_range *range;
+
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (!range)
+		return NULL;
+
+	INIT_LIST_HEAD(&range->list);
+	attr_set_interval(range, start_page, last_page);
+	range->attrs = *attrs;
+	return range;
+}
+
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range)
+{
+	struct interval_tree_node *node;
+	struct amdgpu_svm_attr_range *next;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	/*
+	 * Keep @range_list ordered by start page: insert before the first range
+	 * starting at or after @range, then add to the interval tree.
+	 */
+	node = interval_tree_iter_first(&attr_tree->tree, amdgpu_svm_attr_start_page(range),
+					ULONG_MAX);
+	if (node) {
+		next = container_of(node, struct amdgpu_svm_attr_range, it_node);
+		list_add_tail(&range->list, &next->list);
+	} else {
+		list_add_tail(&range->list, &attr_tree->range_list);
+	}
+
+	interval_tree_insert(&range->it_node, &attr_tree->tree);
+}
+
+static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					  struct amdgpu_svm_attr_range *range,
+					  bool free_range)
+{
+	lockdep_assert_held(&attr_tree->lock);
+
+	interval_tree_remove(&range->it_node, &attr_tree->tree);
+	list_del_init(&range->list);
+	if (free_range)
+		kfree(range);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
new file mode 100644
index 0000000000000..0f712536a5dc1
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -0,0 +1,183 @@
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
+#define AMDGPU_SVM_ATTR_BIT_HOST_ACCESS		(1u << 0)
+#define AMDGPU_SVM_ATTR_BIT_COHERENT		(1u << 1)
+#define AMDGPU_SVM_ATTR_BIT_EXT_COHERENT	(1u << 2)
+#define AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL		(1u << 3)
+#define AMDGPU_SVM_ATTR_BIT_GPU_RO		(1u << 4)
+#define AMDGPU_SVM_ATTR_BIT_GPU_EXEC		(1u << 5)
+#define AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY	(1u << 6)
+
+#define AMDGPU_SVM_PTE_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_COHERENT | AMDGPU_SVM_ATTR_BIT_EXT_COHERENT | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_RO | AMDGPU_SVM_ATTR_BIT_GPU_EXEC)
+
+#define AMDGPU_SVM_MAPPING_FLAG_MASK \
+	(AMDGPU_SVM_ATTR_BIT_HOST_ACCESS | AMDGPU_SVM_ATTR_BIT_HIVE_LOCAL | \
+	 AMDGPU_SVM_ATTR_BIT_GPU_READ_MOSTLY)
+
+/**
+ * struct amdgpu_svm_attrs - SVM attributes for an address range
+ * @preferred_loc: Preferred backing location, using AMDGPU_SVM_LOCATION_*.
+ * @prefetch_loc: Target location for prefetch requests, using
+ *                AMDGPU_SVM_LOCATION_*.
+ * @flags: Internal AMDGPU_SVM_ATTR_BIT_* flags mapped from the UAPI.
+ * @granularity: Mapping granularity encoded as a page order.
+ * @access: CPU/GPU access policy from the SVM UAPI.
+ */
+struct amdgpu_svm_attrs {
+	int32_t preferred_loc;
+	int32_t prefetch_loc;
+	uint32_t flags;
+	uint32_t granularity;
+	enum amdgpu_ioctl_svm_access access;
+};
+
+/**
+ * struct amdgpu_svm_attr_range - a range of user attributes
+ * @it_node: interval tree node keyed by [start, last] page index.
+ * @list: links the range into amdgpu_svm_attr_tree.range_list in address order.
+ * @attrs: the attributes applied to this range.
+ */
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
+/**
+ * struct amdgpu_svm_attr_tree - per-SVM store of user attribute ranges
+ * @lock: protects @tree and @range_list.
+ * @tree: interval tree of struct amdgpu_svm_attr_range for fast lookup.
+ * @range_list: address-ordered list of the same ranges, kept in sync with
+ *              @tree to allow ordered traversal during modification.
+ * @svm: back pointer to the owning SVM instance.
+ */
+struct amdgpu_svm_attr_tree {
+	struct mutex lock;
+	struct rb_root_cached tree;
+	struct list_head range_list;
+	struct amdgpu_svm *svm;
+};
+
+/**
+ * enum amdgpu_svm_attr_change_trigger - effects caused by an attribute change
+ * @AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE: Access policy changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE: GPU PTE permission/cache bits changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE: Mapping policy bits changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE: Preferred or prefetch location changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE: Range granularity changed.
+ * @AMDGPU_SVM_ATTR_TRIGGER_PREFETCH: New attributes request a VRAM prefetch.
+ *
+ * Bitmask describing what an attribute update touched. It drives whether the
+ * existing GPU mappings must be invalidated and/or remapped.
+ */
+enum amdgpu_svm_attr_change_trigger {
+	AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE = (1U << 0),
+	AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE = (1U << 1),
+	AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE = (1U << 2),
+	AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE = (1U << 3),
+	AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE = (1U << 4),
+	AMDGPU_SVM_ATTR_TRIGGER_PREFETCH = (1U << 5),
+};
+
+/*
+ * Attribute changes that require invalidating existing GPU mappings.
+ * A granularity-only change does not, so it is intentionally excluded.
+ */
+#define AMDGPU_SVM_ATTR_TRIGGER_NEED_INVALIDATE \
+	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
+	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
+
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
+struct amdgpu_svm_attr_range *
+amdgpu_svm_attr_range_alloc(unsigned long start_page,
+			   unsigned long last_page,
+			   const struct amdgpu_svm_attrs *attrs);
+void amdgpu_svm_attr_range_insert_locked(struct amdgpu_svm_attr_tree *attr_tree,
+					 struct amdgpu_svm_attr_range *range);
+bool amdgpu_svm_attr_prefer_vram(const struct amdgpu_svm_attrs *attrs);
+struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
+					unsigned long addr);
+
+#endif /* __AMDGPU_SVM_ATTR_H__ */
-- 
2.53.0

