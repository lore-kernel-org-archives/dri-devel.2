Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A5CCD37AC
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6766C10F3A9;
	Fri,  8 May 2026 07:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ePt5YFkp";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F03810F3A4;
 Fri,  8 May 2026 07:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpRofib2y2ulco5E491+0tdfYjCKKW33ABSbBNbOgaHiTtw9id38IESVPy8oKsjI8SWR0CknPUgqnvV1Y8v/cXliF1zKxOhCGZ+6+JNYJNdchePEmlZHMZHGiq504lDPiIROV1udcaJnHOgHjt/CvT6koYumjcVOX9C5XCqR4mSIXCqAI1qMl0xu4trGZzOO1AsIeKqRv0SGMRyFZFe64jeDmxk/fOJvEtaQy/bN56q2wRc4Fwl4wgDnZ3MVDVdEzkmyzgQE90Nbm1hMYgjUUe1C11oMXIiTDhZAo6RlDmgAW/VeZRqzCqLAqgXKr9jqqBfuvs45zqaYKFoIdLPtiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUer9K11eJtwaZd/aJokXtorizw6nVvLEPpzKD0dJYo=;
 b=jXm/dunwW6HVdpaUgkxY1UXZqwfzSstD9q+7hZaITRbNc4H+obO6RymUc28dmoug140eBl3RhX9qkqi1mAjF/3H006eMyQWHvBTtwweXM4WcypwkaaSMZ/NgWuUNeaSyxcg9ZVF/6f5ctu1wTG82/peJZdmsAy5zJ8yxPXZS9kHEuCS5CfY6mI1OfIqZ6eDZzOvqIZsG5HIPfCtd1e8aJTGXfK3Jbjn188BedK79UcUOgZerCHMZ4RyamytxnUisBTwcEEVUrqjcWaynzBtnlgk3pO6wsx9xSs3YlMcmALYzHBtIE6R9pyXEa/pCs8p6Lqt9EtQO+0kxnb8KP+q4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUer9K11eJtwaZd/aJokXtorizw6nVvLEPpzKD0dJYo=;
 b=ePt5YFkp/cqTWZuoP7dRoZPTeJEqqs2AyiNJCSxtyUybLY98xk/vlSRJTCM8bEsxZg9IHXHars4o+fkApMcfdnD7+qHz9xf7oX7S9GoBJAp4xCtZluI2GQttN8XUk4WyQQC6+jlDxbjjEU2YVcf3qA8k4cxjG05C+9JJ0OdB1aY=
Received: from MN0P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::28)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 07:52:14 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::48) by MN0P222CA0021.outlook.office365.com
 (2603:10b6:208:531::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.19 via Frontend Transport; Fri,
 8 May 2026 07:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 07:52:14 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 02:52:05 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V5 05/12] drm/amdgpu: implement SVM attribute set/get/clear
 operations
Date: Fri, 8 May 2026 15:51:22 +0800
Message-ID: <20260508075129.1161157-6-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|BL1PR12MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 50bce8c1-af9a-43c7-bdf8-08deacd6b800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qMB5mKcvpx0/s39VH2reIWKG6xYXis335I/Da3c9YyngD1BKKb14SAFw5K1XjYozMiG5GTpOb2d22rL8ueGs2GEKAd33F46EMD3p/X/yVweEmKSL2tmKaGMcTHJbXQk4lLbrMFjwLu3pGNFxWEPfSa8Z6Vuv+vtqqKQbG3DYbyZR6LoqOQ6BxOPueZ+wzsVzYnDlL3Y/grEbznPCqSyHbQmEZ2RTSlEbDGqmC1BCCQ8wtvcSbgOQFu01Jg6f1L9mH2aUAdmbayoj8DwG6WL0ALTUM1XDa5SxSxoKgf7T4/U1AELZrYhjtA8mnAZsmbA0UINfPXveZZuFgGWgX8ZYcoaJWvqY/e79Ft+wfbqymWZieu2Jq3qyIg9s3qzwMiWQrmiEmBxdLd4HwuYCKaPqXrZ1u0hv1qcIRQF16zavnh9tx/EP1+nq4Bm2tqwnBNMsklZJ+Aqf0I0YsGyf20Td6DKczBElSt7USc79S6uUdrGANwQn5CTyexKY2XmKs4nbuTmyYCpFlVWnu5Vb1bnTbYv16UxI/QW3erMkOwMtsCd7JeLBbhukO0BVhkU4UPZ2gq63PR766bY6Lc/LL+tcMy5k+I2uhmKZ4kIug27g8jkiv5oB2iAjA27BhBsqL7Qa0Qep9SfiJsNOwDC+os3dM4g0Tr0USEpIEwbjM/J4krBzSxe/0NnwHFvuHDQc3d+qMMRMZdy/QuTWe14GuM8+nvHOJ8QNBQF2k+yNKMg5euRbDLwzpIQnxzghqqXtKBOR8aNtZ9JBy/o8dBtd4Tz9fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(921020)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kvL0wug53MZDHIfkuKkxeAceXgPQdsMewKQmnfxwWC4L6Ieqv2y66fJrrKtuNuYCNNvyD6Sf+am75ZIsC46DA+bSu7H9AUSJremYqZoz/FAoCT9EgHZoUgjVrk325UvK3jcgb9lqPIrJoOEqGQMXL/wWSBoBF2TGsLQiQuUC6DILME7TPskNg1XUFp6aSNodeuuJQgh9oFdwbiyVnYnQo1Crqowgda56A4u4YIouok8p2Nhy7+A3rcrTLawDj6qY40wvlFczEfSi2WSO7QmGZL+TShRPP6hHpMocfGUASg2COIATx0QA1xZhPtp+PC6hnVZqykLkcYLakIQsOhg+lweHBn3uY4SSrardwhIzqpGZqozfNUFRay58Fxm3xiRP2dWs1DGJ/4/6IFeYHpI65u5nhIFPpfJ3vGyIJA+mFjPHmyMw9THUfqvTE8aHqLxk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:14.2808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bce8c1-af9a-43c7-bdf8-08deacd6b800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
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
index 10e4de4dc..e50b67540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -248,3 +248,739 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
 	if (free_range)
 		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
 }
+
+static void amdgpu_svm_attr_change_ctx_set(
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
+static int amdgpu_svm_attr_set_validate(const struct drm_amdgpu_svm_attribute *attr)
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
+static void amdgpu_svm_attr_apply(struct amdgpu_svm_attrs *attrs,
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
+	amdgpu_svm_attr_apply(&target, nattr, attrs);
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
+	amdgpu_svm_attr_apply(&new_attrs, nattr, attrs);
+
+	/* Always create a range entry even when attrs equal defaults */
+	range = amdgpu_svm_attr_range_alloc(start_page, last_page, &new_attrs);
+	if (!range)
+		return -ENOMEM;
+
+	amdgpu_svm_attr_range_insert_locked(attr_tree, range);
+
+	amdgpu_svm_attr_change_ctx_set(change, default_attrs,
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
+		amdgpu_svm_attr_change_ctx_set(change, &old_attrs,
+					       &old_attrs,
+					       start_page, last_page);
+		return 0;
+	}
+
+	new_attrs = old_attrs;
+	amdgpu_svm_attr_apply(&new_attrs, nattr, attrs);
+
+	/* only need to update attr */
+	if (start_page == range_start && last_page == range_last) {
+		range->attrs = new_attrs;
+		amdgpu_svm_attr_change_ctx_set(change, &old_attrs,
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
+	amdgpu_svm_attr_change_ctx_set(change, &old_attrs,
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
+		r = amdgpu_svm_attr_set_validate(&attrs[i]);
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
+		amdgpu_svm_gc_flush(svm);
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
+	 * Range with no attr node in this implemetation is treated the
+	 * same as one that explicitly stores default attrs. So
+	 * resetting a range to defaults when user wants to reset the attrs.
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

