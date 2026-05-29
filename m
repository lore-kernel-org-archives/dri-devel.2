Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5883CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 05:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DE910F8EF;
	Fri, 29 May 2026 05:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RYaTLRZZ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C33B10F8EA;
 Fri, 29 May 2026 05:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ymvdu8xGp1vjdxN6CF4jWB9xJlY+D+z8TJmSfjLTDioow/iDsZqHjJLzDeGN1+KcVJV/qRQJGSQ/2jQTK8wurzgeSp91H06sJ7shEoFRQWZml0ACY8CMnUg0LOQDd9lh8Ba/TeVROvxbH0BrYo6qr4lT+P6Gua4wjrB/+SETaPbtO89wskalRfkx0wzx0NBxewRB1SKDtuvRwrMSp+Vb1OKim9gWK9RDgjXjuCb6jH0931NOrLjxcq20cufrv6nSVQOWOVUeoCDj9+sQOmtdqdVuki+0DPTuMhKsd38gkMm9e0iDnR7jFN+VZ2p7n4gQkQmjaNw8Gq1lkvtV+F+ZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX1bzBGoZUvBPp0ZcMWAwrtHQoweNels7PnZdEW1q/c=;
 b=eff7pn+DXoUlRiEfOVJkYaXFTBeRCv1GGf1hKKd6yGZ08Slh2bkWqvhQP9UlBCgUrxeuZ4aV0k5cL+iTCzqMACHxr77SPrHjWowDFvAQICPdsDJLYO8qtSrp+WhUfKZN6vFI4alXO8jfHMd9mxNeo2nwr2lF/I/c/rD6WZ1aiQXzJDhPJD4fd8DSr4gSDQn2Otlt/deBXtMcnCTRpqRwsIOrBdBAveGDvkhp/j7p/UwNZXqPzQCWZh7qRp+/d4sd+K1P/40U1LDLkfBz08mDtwcQMDTuJ4UQ4TSBtWy+qEuutsDASpB8hj2PEHRkwFPZ5kFRUXjQhmTORgkGY3C59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX1bzBGoZUvBPp0ZcMWAwrtHQoweNels7PnZdEW1q/c=;
 b=RYaTLRZZX8xHXyhfAW7WvxUvOBtxmPjg8RWjvK57b7t26fpoGuhTn/MzRjIUpnsphim1krPg0hm/LXkcVlvKTgxYxP7dQQQSELapI3ANAmt1Aqp4/raGLjxMHlMgmgIzWcIsxUNRTtLxGdkIjnW2Rxkpctk6TqdrmDdDy0CPsCk=
Received: from CH5P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::27)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Fri, 29 May
 2026 05:48:46 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::8e) by CH5P223CA0001.outlook.office365.com
 (2603:10b6:610:1f3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.14 via Frontend Transport; Fri, 29
 May 2026 05:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 05:48:45 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 00:48:40 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V7 05/12] drm/amdgpu: implement SVM attribute set/get/clear
 operations
Date: Fri, 29 May 2026 13:47:57 +0800
Message-ID: <20260529054804.596214-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529054804.596214-1-honglei1.huang@amd.com>
References: <20260529054804.596214-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fef347-f719-46ba-5494-08debd45f2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|921020|6133799003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: ZjyCr2tMVUkehBhjO9QvNc9VZWrDF8Ni5/cHTkm/0G4/ZXQaE1qmfgxICIhyJ57OOW3TrLqyWUi0Fw628UmtGJAc/DovHpitKBNiOHG8ZbiczzAxBm66WCa6Nv0iL0MDIiLasZMM+oHhXxOzn5qGE70mhviQUKlJKB9BqxHB2106fxq+TjvB9srlyqLj9CA+Tx4oURHPML7P9az8447nbBC593zksxl0ndM66Q5Vu5Gt6IGvxsdGqg80JaZyeHTp/OYkAD2hzfQjTy/zL2XvFXscLK+tdlE3mgYz9Bdm+ODz6Tt90u2vbKYp+a5/D5mvZxOsPrnKuXb4ob4+hBEv2dGsFDmKtQVGRxJLtRfHgrVIdo97ubu/ewjCNdT6YyUvGOhuoADKkZkd9l+j56uJkzJNURN8og0Klx9SqQR2k4RPFFhqBoBmutFAd3i332y+dwfsioEyLBrI9xDkrYarUNrJUxifgPMQ0z19pGxqtX4W2sjjBVnwqJ2eUZIFjPGR92StrpvhpppfnzjIs/P0MdcfipecGVP7V8Lq5b40RZJYPB+CHl7b6/P1OVKUlDLbH86/iG39ciAzffkz4vbbO23FZh84Va2vNeXVD3047gktWo9k/NYop+YR6NVWmxhjRuRI0xpHxsA30P5pdlWHk9O6HeGA91cR7q8Cx07qIgOxNHiyMIh0l/bSD/0bsFEdhB3vyyGMQzqueTy8g3MrLL96WnGz5c8CaMUEUvBWGj89u1BIUgb8vqKdGlP8O31N8UnapOHsI88ObgkDjTGqrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(921020)(6133799003)(11063799006)(22082099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ma7JAFCFRxWBJWoAN99DjKr0+cehZEUu63jFINGXdf/yLUYh7bSas0eHZ0cbmu/D3FxSWE3ffrqZcK6C3ZruRvB6r9FHYAQoketKzskCLveOeQu8AXeLKtH/lHXECvohFJf1pfpoDN0ec6KTzSkD3j7SqAe+/srX8HoEx2EgzoeFvWjERwifornsS2JQIUGYQezAD58N19eCabYPnxN3fM1h7kc4c6AICgOvGYzmAGgoe8Ssk1nU3VFAzBE8X+aWdSSE1p6Dfwl5cVevXhjohhOY7TS5mufP8t3gwy0siZStilPerMHBuGUC7n7vt4ws38dK0gV/engC5L/Yprj00hxWZkMnubNaRQ2fn4hyNIawRxFbH+4Sgm0194iYF9r0f5fUN+IxfudmdvuAYPSLsZr9IV+M+hRhgvJYNEzkK51gtP3iAaIhTJoTf640L2l3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:48:45.8979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fef347-f719-46ba-5494-08debd45f2ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

Complete attribute subsystem with validation, tree modification, and
public API:
- Attribute validation: per-type checks for preferred_loc, prefetch_loc,
  access, flags, granularity
- Flag application: attr_apply_flag, amdgpu_svm_attr_apply
- VMA range validation (amdgpu_svm_attr_validate_range_vma)
- VM BO overlap detection (amdgpu_svm_attr_check_vm_bo)
- Tree modification with gap/overlap handling:
  amdgpu_svm_attr_set_hole (new range in gap),
  amdgpu_svm_attr_set_existing (split/update existing range)
- amdgpu_svm_attr_set_range: cursor-based iteration with per-segment
  lock acquisition and change propagation
- Lifecycle: amdgpu_svm_attr_tree_create/destroy
- Public API: amdgpu_svm_attr_set (validate + set_range with retry),
  amdgpu_svm_attr_get (aggregate attrs across interval),
  amdgpu_svm_attr_clear (interval removal with split),
  amdgpu_svm_attr_reset (clear wrapper for RESET_ATTR op)

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 738 +++++++++++++++++++
 1 file changed, 738 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 10e4de4dc..177eb3cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -248,3 +248,741 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
 	if (free_range)
 		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
 }
+
+static void attr_change_ctx_set(
+		struct attr_set_ctx *change,
+		const struct amdgpu_svm_attrs *old_attrs,
+		const struct amdgpu_svm_attrs *new_attrs,
+		unsigned long start_page,
+		unsigned long last_page)
+{
+	change->old_attrs = *old_attrs;
+	change->new_attrs = *new_attrs;
+	change->start_page = start_page;
+	change->last_page = last_page;
+}
+
+static inline int attr_check_preferred_loc(uint32_t value)
+{
+	/* cause one svm one gpu so value > 0 then means preferred loc is this GPU */
+	if (value == AMDGPU_SVM_LOCATION_SYSMEM || value == AMDGPU_SVM_LOCATION_UNDEFINED)
+		return 0;
+
+	return 0;
+}
+
+static inline int attr_check_prefetch_loc(uint32_t value)
+{
+	/* cause one svm one gpu so value > 0 then means prefetch loc is this GPU
+	 * keep prefetch loc to adapt to KFD API
+	 */
+	if (value == AMDGPU_SVM_LOCATION_SYSMEM)
+		return 0;
+
+	if (value == AMDGPU_SVM_LOCATION_UNDEFINED)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int attr_check_access(uint32_t value)
+{
+	switch (value) {
+	case AMDGPU_SVM_ACCESS_INACCESSIBLE:
+	case AMDGPU_SVM_ACCESS_IN_PLACE:
+	case AMDGPU_SVM_ACCESS_ALLOW_MIGRATE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static bool attr_flag_type_to_bit(uint32_t type, uint32_t *flag_bit)
+{
+	if (type < AMDGPU_SVM_ATTR_HOST_ACCESS ||
+	    type > AMDGPU_SVM_ATTR_GPU_READ_MOSTLY)
+		return false;
+
+	*flag_bit = 1u << (type - AMDGPU_SVM_ATTR_HOST_ACCESS);
+	return true;
+}
+
+static inline int attr_check_flag_value(uint32_t value)
+{
+	if (value > 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int attr_check_flag_attr(uint32_t type, uint32_t value)
+{
+	uint32_t flag_bit;
+	int ret;
+
+	if (!attr_flag_type_to_bit(type, &flag_bit))
+		return -EINVAL;
+
+	ret = attr_check_flag_value(value);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static inline int attr_check_granularity(uint32_t value)
+{
+	return 0;
+}
+
+int
+amdgpu_svm_attr_check_vm_bo(struct amdgpu_svm_attr_tree *attr_tree,
+			    unsigned long start_page,
+			    unsigned long last_page,
+			    unsigned long *bo_start, unsigned long *bo_last)
+{
+	struct amdgpu_svm *svm = attr_tree->svm;
+	struct amdgpu_vm *vm = svm->vm;
+	struct interval_tree_node *node;
+	int r;
+
+	r = amdgpu_bo_reserve(vm->root.bo, false);
+	if (r)
+		return r;
+
+	node = interval_tree_iter_first(&vm->va, start_page, last_page);
+	if (node) {
+		AMDGPU_SVM_ERR("SVM range [0x%lx 0x%lx] overlaps with BO mapping [0x%lx 0x%lx]\n",
+			       start_page, last_page, node->start, node->last);
+		if (bo_start)
+			*bo_start = node->start;
+		if (bo_last)
+			*bo_last = node->last;
+		amdgpu_bo_unreserve(vm->root.bo);
+		return -EADDRINUSE;
+	}
+
+	amdgpu_bo_unreserve(vm->root.bo);
+	return 0;
+}
+
+static int
+amdgpu_svm_attr_validate_range_vma(struct amdgpu_svm_attr_tree *attr_tree,
+				   unsigned long start_page,
+				   unsigned long last_page)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm;
+	unsigned long start, end;
+	int ret = 0;
+
+	if (start_page > last_page)
+		return -EINVAL;
+
+	if (last_page == ULONG_MAX)
+		return -EINVAL;
+
+	start = start_page << PAGE_SHIFT;
+	end = (last_page + 1) << PAGE_SHIFT;
+	mm = attr_tree->svm->gpusvm.mm;
+	if (!mm)
+		return -EFAULT;
+
+	mmap_read_lock(mm);
+	while (start < end) {
+		vma = amdgpu_svm_check_vma(mm, start);
+		if (IS_ERR(vma)) {
+			ret = PTR_ERR(vma);
+			break;
+		}
+
+		start = min(end, vma->vm_end);
+	}
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
+static int attr_set_validate(const struct drm_amdgpu_svm_attribute *attr)
+{
+	switch (attr->type) {
+	case AMDGPU_SVM_ATTR_PREFERRED_LOC:
+		return attr_check_preferred_loc(attr->value);
+	case AMDGPU_SVM_ATTR_PREFETCH_LOC:
+		return attr_check_prefetch_loc(attr->value);
+	case AMDGPU_SVM_ATTR_ACCESS:
+		return attr_check_access(attr->value);
+	case AMDGPU_SVM_ATTR_GRANULARITY:
+		return attr_check_granularity(attr->value);
+	case AMDGPU_SVM_ATTR_HOST_ACCESS:
+	case AMDGPU_SVM_ATTR_COHERENT:
+	case AMDGPU_SVM_ATTR_HIVE_LOCAL:
+	case AMDGPU_SVM_ATTR_GPU_RO:
+	case AMDGPU_SVM_ATTR_GPU_EXEC:
+	case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
+	case AMDGPU_SVM_ATTR_EXT_COHERENT:
+		return attr_check_flag_attr(attr->type, attr->value);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void attr_apply_flag(struct amdgpu_svm_attrs *attrs,
+			    uint32_t type, uint32_t value)
+{
+	uint32_t flag_bit;
+
+	if (!attr_flag_type_to_bit(type, &flag_bit))
+		return;
+
+	if (value)
+		attrs->flags |= flag_bit;
+	else
+		attrs->flags &= ~flag_bit;
+}
+
+static void attr_apply(struct amdgpu_svm_attrs *attrs,
+					uint32_t nattr,
+					const struct drm_amdgpu_svm_attribute *pattrs)
+{
+	const struct drm_amdgpu_svm_attribute *attr;
+
+	for (attr = pattrs; nattr--; attr++) {
+		switch (attr->type) {
+		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
+			attrs->preferred_loc = (int32_t)attr->value;
+			break;
+		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
+			attrs->prefetch_loc = (int32_t)attr->value;
+			break;
+		case AMDGPU_SVM_ATTR_ACCESS:
+			attrs->access = (enum amdgpu_ioctl_svm_access)attr->value;
+			break;
+		case AMDGPU_SVM_ATTR_HOST_ACCESS:
+		case AMDGPU_SVM_ATTR_COHERENT:
+		case AMDGPU_SVM_ATTR_HIVE_LOCAL:
+		case AMDGPU_SVM_ATTR_GPU_RO:
+		case AMDGPU_SVM_ATTR_GPU_EXEC:
+		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
+		case AMDGPU_SVM_ATTR_EXT_COHERENT:
+			attr_apply_flag(attrs, attr->type, attr->value);
+			break;
+		case AMDGPU_SVM_ATTR_GRANULARITY:
+			attrs->granularity = min_t(uint32_t, attr->value, 0x3f);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static bool attr_same_attrs(const struct amdgpu_svm_attr_range *range,
+			    uint32_t nattr,
+			    const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm_attrs target;
+
+	target = range->attrs;
+	attr_apply(&target, nattr, attrs);
+	return attr_equal(&range->attrs, &target);
+}
+
+static int
+amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
+			  const struct amdgpu_svm_attrs *default_attrs,
+			  unsigned long start_page, unsigned long last_page,
+			  uint32_t nattr,
+			  const struct drm_amdgpu_svm_attribute *attrs,
+			  struct attr_set_ctx *change)
+{
+	struct amdgpu_svm_attrs new_attrs;
+	struct amdgpu_svm_attr_range *range;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	if (start_page > last_page)
+		return 0;
+
+	new_attrs = *default_attrs;
+	attr_apply(&new_attrs, nattr, attrs);
+
+	/* Always create a range entry even when attrs equal defaults */
+	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs);
+	if (!range)
+		return -ENOMEM;
+
+	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+
+	attr_change_ctx_set(change, default_attrs,
+				       &new_attrs, start_page, last_page);
+	return 0;
+}
+
+static int
+amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
+			     struct amdgpu_svm_attr_range *range,
+			     unsigned long start_page, unsigned long last_page,
+			     uint32_t nattr,
+			     const struct drm_amdgpu_svm_attribute *attrs,
+			     struct attr_set_ctx *change)
+{
+	unsigned long range_start = amdgpu_svm_attr_start_page(range);
+	unsigned long range_last = amdgpu_svm_attr_last_page(range);
+	struct amdgpu_svm_attr_range *left = NULL;
+	struct amdgpu_svm_attr_range *right = NULL;
+	struct amdgpu_svm_attrs old_attrs;
+	struct amdgpu_svm_attrs new_attrs;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	old_attrs = range->attrs;
+
+	if (attr_same_attrs(range, nattr, attrs)) {
+		/* Report old==new so apply_attr_change can decide */
+		attr_change_ctx_set(change, &old_attrs,
+					       &old_attrs,
+					       start_page, last_page);
+		return 0;
+	}
+
+	new_attrs = old_attrs;
+	attr_apply(&new_attrs, nattr, attrs);
+
+	/* only need to update attr */
+	if (start_page == range_start && last_page == range_last) {
+		range->attrs = new_attrs;
+		attr_change_ctx_set(change, &old_attrs,
+					       &new_attrs, start_page, last_page);
+		return 0;
+	}
+
+	/* split head */
+	if (start_page > range_start) {
+		left = amdgpu_svm_attr_range_alloc(range_start, start_page - 1, &old_attrs);
+		if (!left)
+			return -ENOMEM;
+	}
+
+	/* split tail */
+	if (last_page < range_last) {
+		right = amdgpu_svm_attr_range_alloc(last_page + 1, range_last, &old_attrs);
+		if (!right) {
+			if (left)
+				kmem_cache_free(amdgpu_svm_attr_range_cache, left);
+			return -ENOMEM;
+		}
+	}
+
+	attr_remove_range_locked(attr_tree, range, false);
+	if (left)
+		amdgpu_svm_attr_range_insert_locked(attr_tree, left);
+	attr_set_interval(range, start_page, last_page);
+	range->attrs = new_attrs;
+	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+	if (right)
+		amdgpu_svm_attr_range_insert_locked(attr_tree, right);
+
+	attr_change_ctx_set(change, &old_attrs,
+				       &new_attrs, start_page, last_page);
+	return 0;
+}
+
+static int
+amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
+			  const struct amdgpu_svm_attrs *default_attrs,
+			  unsigned long start_page, unsigned long last_page,
+			  uint32_t nattr,
+			  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = attr_tree->svm;
+	unsigned long cursor = start_page;
+	bool need_retry = false;
+
+	while (cursor <= last_page) {
+		struct interval_tree_node *node;
+		unsigned long seg_last;
+		struct attr_set_ctx change = { 0 };
+		int ret;
+
+		amdgpu_svm_lock(svm);
+		mutex_lock(&attr_tree->lock);
+		node = interval_tree_iter_first(&attr_tree->tree, cursor, cursor);
+		if (node) {
+			struct amdgpu_svm_attr_range *range;
+
+			range = container_of(node, struct amdgpu_svm_attr_range, it_node);
+			seg_last = min(last_page, amdgpu_svm_attr_last_page(range));
+			ret = amdgpu_svm_attr_set_existing(attr_tree, range,
+								   cursor, seg_last,
+								   nattr, attrs, &change);
+		} else {
+			struct interval_tree_node *next;
+
+			seg_last = last_page;
+			if (cursor != ULONG_MAX) {
+				next = interval_tree_iter_first(&attr_tree->tree,
+								cursor + 1,
+								ULONG_MAX);
+				if (next) {
+					struct amdgpu_svm_attr_range *next_range;
+
+					next_range = container_of(next,
+						struct amdgpu_svm_attr_range,
+						it_node);
+					seg_last = min(last_page,
+						       amdgpu_svm_attr_start_page(next_range) - 1);
+				}
+			}
+			ret = amdgpu_svm_attr_set_hole(attr_tree,
+							       default_attrs,
+							       cursor, seg_last,
+							       nattr, attrs,
+							       &change);
+		}
+		mutex_unlock(&attr_tree->lock);
+
+		if (ret) {
+			amdgpu_svm_unlock(svm);
+			return ret;
+		}
+
+		ret = amdgpu_svm_apply_attr_change(svm,
+						   &change.old_attrs,
+						   &change.new_attrs,
+						   change.start_page,
+						   change.last_page);
+		amdgpu_svm_unlock(svm);
+
+		if (ret == -EAGAIN) {
+			need_retry = true;
+			ret = 0;
+		}
+
+		if (ret)
+			return ret;
+
+		if (seg_last == ULONG_MAX || seg_last == last_page)
+			break;
+
+		cursor = seg_last + 1;
+	}
+
+	return need_retry ? -EAGAIN : 0;
+}
+
+struct amdgpu_svm_attr_tree *
+amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
+{
+	struct amdgpu_svm_attr_tree *attr_tree;
+
+	attr_tree = kzalloc(sizeof(*attr_tree), GFP_KERNEL);
+	if (!attr_tree)
+		return NULL;
+
+	mutex_init(&attr_tree->lock);
+	attr_tree->tree = RB_ROOT_CACHED;
+	INIT_LIST_HEAD(&attr_tree->range_list);
+	attr_tree->svm = svm;
+	return attr_tree;
+}
+
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
+{
+	struct amdgpu_svm_attr_range *range, *tmp;
+
+	if (!attr_tree)
+		return;
+
+	mutex_lock(&attr_tree->lock);
+	list_for_each_entry_safe(range, tmp, &attr_tree->range_list, list) {
+		interval_tree_remove(&range->it_node, &attr_tree->tree);
+		list_del_init(&range->list);
+		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
+	}
+	mutex_unlock(&attr_tree->lock);
+
+	mutex_destroy(&attr_tree->lock);
+	kfree(attr_tree);
+}
+
+int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
+			uint64_t start,
+			uint64_t size,
+			uint32_t nattr,
+			const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = attr_tree->svm;
+	struct amdgpu_svm_attrs default_attrs;
+	unsigned long start_page, last_page;
+	uint32_t i;
+	int r;
+
+	start_page = start >> PAGE_SHIFT;
+	last_page = (start + size - 1) >> PAGE_SHIFT;
+
+	for (i = 0; i < nattr; i++) {
+		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x range [0x%lx-0x%lx] xnack:%d",
+			 attrs[i].type, attrs[i].value, start_page, last_page,
+			 svm->xnack_enabled ? 1 : 0);
+		r = attr_set_validate(&attrs[i]);
+		if (r) {
+			AMDGPU_SVM_TRACE("invalid attribute %u value 0x%08x",
+					 attrs[i].type, attrs[i].value);
+			return r;
+		}
+	}
+
+	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
+	if (r)
+		return r;
+
+	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
+					NULL, NULL);
+	if (r)
+		return r;
+
+	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
+
+retry:
+	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs,
+					       start_page, last_page,
+					       nattr, attrs);
+	if (r == -EAGAIN) {
+		AMDGPU_SVM_TRACE("attr_set retry [0x%lx-0x%lx]\n",
+				 start_page, last_page);
+		amdgpu_svm_sync_work(svm);
+		cond_resched();
+		goto retry;
+	}
+
+	return r;
+}
+
+int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page)
+{
+	struct interval_tree_node *node;
+	int r = 0;
+
+	if (start_page > last_page)
+		return -EINVAL;
+
+	mutex_lock(&attr_tree->lock);
+
+	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
+	while (node) {
+		struct interval_tree_node *next;
+		struct amdgpu_svm_attr_range *range;
+		unsigned long range_start;
+		unsigned long range_last;
+
+		range = container_of(node, struct amdgpu_svm_attr_range, it_node);
+		next = interval_tree_iter_next(node, start_page, last_page);
+		range_start = amdgpu_svm_attr_start_page(range);
+		range_last = amdgpu_svm_attr_last_page(range);
+
+		if (range_start < start_page && range_last > last_page) {
+			struct amdgpu_svm_attr_range *tail;
+
+			tail = amdgpu_svm_attr_range_alloc(last_page + 1, range_last,
+							   &range->attrs);
+			if (!tail) {
+				r = -ENOMEM;
+				break;
+			}
+
+			attr_remove_range_locked(attr_tree, range, false);
+			attr_set_interval(range, range_start, start_page - 1);
+			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+			amdgpu_svm_attr_range_insert_locked(attr_tree, tail);
+		} else if (range_start < start_page) {
+			attr_remove_range_locked(attr_tree, range, false);
+			attr_set_interval(range, range_start, start_page - 1);
+			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+		} else if (range_last > last_page) {
+			attr_remove_range_locked(attr_tree, range, false);
+			attr_set_interval(range, last_page + 1, range_last);
+			amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+		} else {
+			attr_remove_range_locked(attr_tree, range, true);
+		}
+
+		node = next;
+	}
+
+	mutex_unlock(&attr_tree->lock);
+	return r;
+}
+
+int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page)
+{
+	/*
+	 * Range with no attr node in this implementation is treated the
+	 * same as one that explicitly stores default attrs. So clear
+	 * the attribute ranges when user wants to reset the attrs.
+	 *
+	 * - GET_ATTR: return default_attrs to userspace when there is no attr
+	 *   range.
+	 * - SET_ATTR: holes are treated as having default_attrs when
+	 *   computing the change trigger.
+	 * - Fault: attr lookup falls back to defaults when no attr range exists,
+	 *   so migration and PTE flag decisions are unchanged.
+	 *
+	 * This approach simplifies the implementation and avoids redundant
+	 * attribute maintenance. This ioctl operation is for attribute only,
+	 * so do not invalidate the GPU mapping here.
+	 */
+	return amdgpu_svm_attr_clear(attr_tree, start_page, last_page);
+}
+
+static void attr_get_ctx_add(struct attr_get_ctx *ctx,
+			       const struct amdgpu_svm_attrs *attrs)
+{
+	if (!ctx->has_range) {
+		ctx->preferred_loc = attrs->preferred_loc;
+		ctx->prefetch_loc = attrs->prefetch_loc;
+		ctx->granularity = attrs->granularity;
+		ctx->access = attrs->access;
+		ctx->flags_and = attrs->flags;
+		ctx->has_range = true;
+		return;
+	}
+
+	if (ctx->preferred_loc != attrs->preferred_loc)
+		ctx->preferred_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	if (ctx->prefetch_loc != attrs->prefetch_loc)
+		ctx->prefetch_loc = AMDGPU_SVM_LOCATION_UNDEFINED;
+	if (attrs->granularity < ctx->granularity)
+		ctx->granularity = attrs->granularity;
+	if (ctx->access != attrs->access)
+		ctx->access = AMDGPU_SVM_ACCESS_INACCESSIBLE;
+	ctx->flags_and &= attrs->flags;
+}
+
+static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx,
+				uint32_t nattr,
+				struct drm_amdgpu_svm_attribute *attrs)
+{
+	uint32_t i;
+
+	for (i = 0; i < nattr; i++) {
+		switch (attrs[i].type) {
+		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
+			attrs[i].value = ctx->preferred_loc;
+			break;
+		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
+			attrs[i].value = ctx->prefetch_loc;
+			break;
+		case AMDGPU_SVM_ATTR_ACCESS:
+			attrs[i].value = (uint32_t)ctx->access;
+			break;
+		case AMDGPU_SVM_ATTR_HOST_ACCESS:
+		case AMDGPU_SVM_ATTR_COHERENT:
+		case AMDGPU_SVM_ATTR_HIVE_LOCAL:
+		case AMDGPU_SVM_ATTR_GPU_RO:
+		case AMDGPU_SVM_ATTR_GPU_EXEC:
+		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
+		case AMDGPU_SVM_ATTR_EXT_COHERENT: {
+			uint32_t flag_bit;
+
+			if (!attr_flag_type_to_bit(attrs[i].type, &flag_bit))
+				return -EINVAL;
+
+			attrs[i].value = (ctx->flags_and & flag_bit) ? 1 : 0;
+			break;
+		}
+		case AMDGPU_SVM_ATTR_GRANULARITY:
+			attrs[i].value = ctx->granularity;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
+			uint64_t start, uint64_t size,
+			uint32_t nattr,
+			struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm_attrs default_attrs;
+	struct attr_get_ctx ctx = { 0 };
+	struct interval_tree_node *node;
+	unsigned long start_page, last_page, cursor;
+	int r;
+
+	start_page = start >> PAGE_SHIFT;
+	last_page = (start + size - 1) >> PAGE_SHIFT;
+
+	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
+	if (r)
+		return r;
+
+	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
+					NULL, NULL);
+	if (r)
+		return r;
+
+	mutex_lock(&attr_tree->lock);
+	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
+	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
+
+	if (!node) {
+		attr_get_ctx_add(&ctx, &default_attrs);
+		r = attr_get_ctx_to_result(&ctx, nattr, attrs);
+		mutex_unlock(&attr_tree->lock);
+		return r;
+	}
+
+	cursor = start_page;
+	while (cursor <= last_page) {
+		const struct amdgpu_svm_attrs *range_attrs;
+		unsigned long range_last = last_page;
+		struct amdgpu_svm_attr_range *range = NULL;
+		unsigned long next;
+
+		if (node) {
+			range = container_of(node, struct amdgpu_svm_attr_range,
+					     it_node);
+
+			if (amdgpu_svm_attr_last_page(range) < cursor) {
+				node = interval_tree_iter_next(node, start_page,
+							      last_page);
+				continue;
+			}
+
+			if (amdgpu_svm_attr_start_page(range) <= cursor) {
+				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
+				node = interval_tree_iter_next(node, start_page,
+							      last_page);
+			} else {
+				range_last = min(last_page,
+						 amdgpu_svm_attr_start_page(range) - 1);
+				range = NULL;
+			}
+		}
+
+		range_attrs = range ? &range->attrs : &default_attrs;
+		attr_get_ctx_add(&ctx, range_attrs);
+
+		if (range_last == ULONG_MAX)
+			break;
+
+		next = range_last + 1;
+		if (next <= cursor)
+			break;
+		cursor = next;
+	}
+
+	if (!ctx.has_range)
+		attr_get_ctx_add(&ctx, &default_attrs);
+
+	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
+	mutex_unlock(&attr_tree->lock);
+	return r;
+}
-- 
2.34.1

