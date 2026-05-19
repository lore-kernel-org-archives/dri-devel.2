Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24350CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8892D10EB4F;
	Tue, 19 May 2026 08:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urWJGXkR";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71DDE10EB4F;
 Tue, 19 May 2026 08:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFElKQVEM9QmncQvTQvc6hI+hdx7hNc8WWbEjaCK0ZDqrj/cQaV515Yz9aIoGmrzcmyftH8UxFHYZK7NA0bSZjuLJ/hPrr56oxiaCW8Hbm9/Y/Ivd2RtfIILqtJrcByOJqpv4OqCLcb4TegaLQBr9Q023ezL9nEfsf5dW9MwwekR0uvevdXBqE8V/4hbIAaBM5gexYF44OIKE5sb/H7PirtDi+8D1hr3HmlIY2MTvnvMleJrop7aeg84Fire9MxObNQpGdKt7fp3Tq601Ru4nZui0bkrLpKP83dhUO/52bj/gNw7N7GjcVpa4tmqr/eThzYqpKXwPgaNpY9WP3MGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHdNkCIXFLs4JXDWpfmpm+U457bFkCniZz6mVuEJB7s=;
 b=XyImlgvgChP+08IWvPwR0tw5b/pSqJAN3D79vkealBbzWJbalFC/3RbD52aizphDitG+6gxG4PxS61ey+w5XoTwxfaXy81u+gtQ8G2ru0jJiAEhZUpnnJ5qtOH52LZsUH3viRKP37CoGBMcrIC5JeVPpmxAQjFT8sUl83fQC+rIg1PKBUlro2u8wII0e8or8v0AQq8ZGuMo/jaIU6tzHhIQ3FT9ffv6u9blbUdJqSbSH22XWi7YPdOKBq5MoVdL4SjEZtN/1zDHKEI4Wo33QO95HsTrs0Zb+aWpil0B6gyEEddjDI3sK7QddzNJKO4uGQfL45dMtImUS0nzy4CeadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHdNkCIXFLs4JXDWpfmpm+U457bFkCniZz6mVuEJB7s=;
 b=urWJGXkRdThFTeiWjmQn41c27Onze1RGxZfZavArCj4Gcy6dHDOUSkvaUpy/DTIpbTQn++wK3e/NvDE+8cVMGpWgDu5EfEVXPpdYq648YG1832K73AilGLtmNnLaEZc5DDIBEv8D+jD/JhNszq7lOq4g5sExvtMhAo2mbM/7kAc=
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 08:32:07 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::95) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 08:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:32:07 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:32:02 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 05/12] drm/amdgpu: implement SVM attribute set/get/clear
 operations
Date: Tue, 19 May 2026 16:30:50 +0800
Message-ID: <20260519083057.3108087-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519083057.3108087-1-honglei1.huang@amd.com>
References: <20260519083057.3108087-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d7779e-8ffb-4cca-abbb-08deb5811ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|22082099003|18002099003|11063799005|921020;
X-Microsoft-Antispam-Message-Info: rcaJaTsUkACjsGfC+PFvJyb9VjUKI4Vgjas4O43K/Xlue7ZFijRo8BpYU2A0i7iZHXK9WndZd6LxEdINqmE2c4AEyRF0m+O2TaUVV2kwolRLjnZPAXLEPPc0MPYzVoKm0xXfqzUSFcqfoqFOcdvHaA04oEM3jlPM807+QNz3iiXWaeFqbQkEiHUzooZN5CoPBr8s1rIamGQi17TROjwbq/B4jQqbtSps344hS/0qk3/VLHQBze0Opf0zfwSOBhfCN5ej+FXSvtkTrkhR16JBjCope2VSILDibTFXC8gZgI2+J+bKmrPfM0sC3Ok9RJ4YotNHy5+oqBZKSagozsmj/3hp3Ku0rymj3di2xjIfConl6gq9ratF6oaM7EbJ04ewifKhak69LE+H3dqrQv3eVBqVB9DV7SxxwE4Gbk9GifcJ+kL/PA1yzAS/8jZjExYkPBxnHijGf4njRytqgP8XP4eRFSWsGmBZwEIlNZlxINqchp5oGKFW2Xt+SsqY+gEm6vMwsNF+yJCbTZ7blicb3xil91Uy9ZZS2EvnR76IFidRqSWvngkhZh3q4xSr+A7YA/S/r6iEcazNi8uAkSiEj1v1MPLH9AW+P+loqJFYfd8zMvVFP3gyYrg0o7tip+HA055FMyzghNNbYeoIm3DinXOO1SmYLSvcmrd9G2xTjJVizBt8tL/vCvFrAaA7xP6u8rUOlBQP5QCl1TsV+P0zddZWi3rALQD56ah7wp8I9dVribuhpKmUtDSWsW91mJuEHA8euTfGZruRaZoqeMI0hQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(11063799005)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JDel5xtQjWroknrLA3i98ql7kTNOetMXtNeS4iueUs3ppYwPgxJYq2ICk2wW5erCG6M6UIIeC28Ic5FPY483waAudZAriyKxvhSO01bqbkcmW/J9ylSU9QnKsjeQiE8+WHwlafAFjGYRxVeiJvUzQtxevA1nEGEw30Zn74TPNVBDpWH4UlTboBiUqwsgKXEM6JzmBsJwq/xTYujmNZwssjWhDUVbjLau66itSXeikvSSgdFQka9c5WI9RfhzEE4gNVBYJSp8LX3oOh339nIkarZHIXd3yy36Q+C7l/TzOLtW7OiuMQAdMr7ofXhrWjJtyQAUDNzGPBZmkhsXyjmM35IiN2o0BGGCmpW1nVJEFCM1Hv7gjgRVeIiQtRQMSXBgXHnno7VTXxcbyWRY6jwF+BBNa4cWbhL+rM2NkVAHDX9/huQ0U2nBCvAeS3fPDdkG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:32:07.1244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d7779e-8ffb-4cca-abbb-08deb5811ccc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 736 +++++++++++++++++++
 1 file changed, 736 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 10e4de4dc..5f0425d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -248,3 +248,739 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
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
+		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x for page range [0x%lx-0x%lx] xnack:%d",
+			 attrs[i].type, attrs[i].value, start_page, last_page,
+			 svm->xnack_enabled ? 1 : 0);
+		r = attr_set_validate(&attrs[i]);
+		if (r) {
+			AMDGPU_SVM_TRACE("invalid attribute %u value 0x%08x", attrs[i].type, attrs[i].value);
+			return r;
+		}
+	}
+
+	r = amdgpu_svm_attr_validate_range_vma(attr_tree, start_page, last_page);
+	if (r)
+		return r;
+
+	r = amdgpu_svm_attr_check_vm_bo(attr_tree, start_page, last_page,
+				        NULL, NULL);
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
+			tail = amdgpu_svm_attr_range_alloc(last_page + 1, range_last, &range->attrs);
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

