Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B74F588C4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C0A10E5DB;
	Mon, 20 Apr 2026 13:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NCcjUzuM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CBF110E5D4;
 Mon, 20 Apr 2026 13:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hybbBX6X9c9iCl9oSvJwG3ZkN6/qU8lG8UJB8m0PR619X/MKDNssp/g9pO3KAkbLWP3SDUoQWj3o/iEncK44lyxYML1PiFDkffzuoD9S79IybkMcMdof8aUg+s8sqezuud+z4wkM6jl7llcXTegeu6UsU6PcpADRjL5GmoBHU543dwrxlpMnjBFNKDOSucC+3iKFMtauffEgBzM4x3vvhnmITGCHAkhnH3C59B9eBfwnlcVv2AL951PArViTleaLO4elC7IDJ0MFNrDdfxwSlSFkYcLycKcu8bZ5n23mpX0Rs0kG73jSwzAbYaft0PA/1yA5fcIkZkxGcM3obPbwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CbGBdkFsAZZUlkCisc+OmJLungxMm3am5adTDt1XNw=;
 b=BCbfjd4uZhkx3QOH9Ga5E9nO9VQx0g2c4nKDbNKCYZnbb8lHHVOaxOGNPf3mDV0T35Qjrh3wviAyQLQ+0jq54jHWXXlwSpIo0RjHcCU+12SYM8rY84re0hGphnMnqZRs5eVzu8jxVyG9gPLKRfCCZDAS4n0hQMdHvo2Yk9mzx7QOlNCVm1C22fDcVRQo50A6eI+AX9dIC7Cw4ll7g2JZF2T2OBwcBjYRTYIeObR+gDmBH25mfccHal3ksXPloE6ss3x4fMg/aBG5E4AdiwT8XjUhQsurOadF9hgisv5Jo+qVD1Zd5K/+p5EbXiPwshFqfmHgFwrLiRskULq/zko6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CbGBdkFsAZZUlkCisc+OmJLungxMm3am5adTDt1XNw=;
 b=NCcjUzuMuYW0icrZfGvOeKovKaWJzGNtjkXdQWHISye5R4vsgLby/J5VoZlp8lxzCyCjDhC8nu99/93fpNyil5GhFimDy+ECkELpvuwJtoVViqCzHw8++kQxEA6T8ip8GR8n1xxzcjhVNrnsz0FkaoiTZcQb4fE9NNVRlG3bvwY=
Received: from CH2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:610:60::17)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 13:13:57 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::b) by CH2PR14CA0007.outlook.office365.com
 (2603:10b6:610:60::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 13:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 13:13:57 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 08:13:53 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>, Honghuan He <honghuan.he@amd.com>
Subject: [RFC V3 05/12] drm/amdgpu: implement SVM attribute set, get, and clear
Date: Mon, 20 Apr 2026 21:13:00 +0800
Message-ID: <20260420131307.1816671-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420131307.1816671-1-honglei1.huang@amd.com>
References: <20260420131307.1816671-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 4466ceba-75b0-4d6b-b967-08de9edeae5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|921020|56012099003;
X-Microsoft-Antispam-Message-Info: /2+6ISlXmwjeR62FlTaw12MRdhAce3SrakvCiMRMbOp2aKPE4Fv9bqqH7CFJExtdX9Jxj+UfT2nV1PxVhunjfsoeeGO82aV2+xflWQBPj3ha4P6uDzNP0rEpFHq3pzi5AlwidRVzeohr0I8CS613hNq1zVRhxM/TjQg15ySYaTvhIITSI6TzQ1VgsEwnWFr4P0cNIB7Z+MzYf3WkLXmMKljXE96LK/ijf4sVh7Bizo3sz9PKmuu/pTZKXS1+7McgxSzMmzH7SLyIHE4diWni6ivLMjACg5xlXs4FL/UPZzkXEPujyjApixJ+43gl9m+ojRhqNcRyBrSNkeB6+YUZg4XYHbBULKHlMyIDAtMd0+5TqZXC7p1K9v4gQotAXgQvpf9P6NrhePNYch48F6ABy5tONNwlqwJ9zgFs24vbaoOmXVdRv+v9xE8zGWVVQImeMtOAkfQiulLkPuroJrPbRMp4saHcZRI2hDfGtd/XHRuSIerqc79P7ZdbDi/hwWVaZslchVU+HCLDG7JlgO5a5+9g7fWVGA6JfkTaM2YY/1JaPotquvQcgBrKOwIAVZxjwlnXqzIXFDNhdJKqBtcb0+6NtsWuPPoOOmN2ryAd7tGfDZ8Vf9WbvxmSR/H5SZ1mOXwhQ0EvN0NpdDzU+6Db73fCq6CVLAUWJexOwBQ2FO46inyXgeQaFuvOkUcIZtCmqCZpWboPoyIUcneYYZ1RyGt0I3BgKXEkuCkgz3DwQy3IqPuHqRqRpu4AzY1xQtA/l71EAX22LpFNHUqYSLo9AMr5rmFeCImb+A/Raf0Yz8vbedDLzgxVMvNXITveJEsP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(921020)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3OQB7+56CvUE3zU320aeOvp5FVGlzeYE7WTKSC+e6QH/z9ZPuSW4e/BJpWeywyJMqwjSkZAPP4YaZ0MbBmn0ev5RwXLbLgpHxEhwEAVF6AJwJuAX4dldBGl7OFR3EJdLWCDO5f6HSWKfz535nJdpzCh/v7XEt55tY+YwWS41b0AwyjXuLSvkiMYYk0tfYFoU2z2swgXhGgvARnBwVUISUn0B/wDOUnAAgSRDxgB14jK4c0Nl7hHsx64Z9ksDocLsSVXscM7Kwxr/Kb0YNSv2FBH6dROzyL2PpZGKr6P05oFV9R6XUnjLpm0uWqJn2eWWFFB3RH0/uJO7TQwnN0KHEJ8qKkwPJjXEiDa94kPQEwjsyPHepoTRTeJol8yqhEcJqTWEn7qBMbsx4ujIGgZVuSj4kyDp6PtdgfCCQYxp65dnEHvEc9h3ccxb9kHdtiJy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:13:57.7652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4466ceba-75b0-4d6b-b967-08de9edeae5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
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

Complete the attribute subsystem with tree modification and query
operations for setting, getting, and clearing per-range attributes.

Change propagation:
- amdgpu_svm_attr_change_ctx_set(): store change context
- amdgpu_svm_attr_apply_change(): dispatch range-level updates
  when attributes change (PTE remap, prefetch, rebuild)

Validation:
- attr_check_preferred_loc/prefetch_loc/access/flags/granularity():
  per-attribute value validation
- amdgpu_svm_attr_set_validate(): validate a UAPI attribute array
- amdgpu_svm_attr_validate_range_vma(): ensure VMAs cover the
  entire target address range

Attribute application:
- amdgpu_svm_attr_apply(): apply one UAPI attribute to an attrs
  struct, accumulating set/clear flag operations
- attr_same_attrs(): fast check if existing range already matches

Tree modification:
- amdgpu_svm_attr_set_hole(): create a new attr range in a gap
- amdgpu_svm_attr_set_existing(): modify or split an existing
  range when attributes partially overlap
- amdgpu_svm_attr_set_range(): walk the tree applying attributes
  to a page interval, handling gaps and overlaps

Lifecycle:
- amdgpu_svm_attr_tree_create(): allocate and initialize tree
- amdgpu_svm_attr_tree_destroy(): drain and free all ranges

Public API:
- amdgpu_svm_attr_set(): validate, lock, walk tree, trigger
  downstream attribute changes
- amdgpu_svm_attr_clear_pages(): remove ranges for a page interval
- amdgpu_svm_attr_get(): query attributes for an address range,
  intersecting results via attr_get_ctx_add/attr_get_ctx_to_result

Signed-off-by: Honghuan He <honghuan.he@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 651 +++++++++++++++++++
 1 file changed, 651 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 03ea2f005..ed4d89ecf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -299,3 +299,654 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
 		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
 }
 
+static void amdgpu_svm_attr_change_ctx_set(
+		struct attr_set_ctx *change,
+		uint32_t trigger,
+		const struct amdgpu_svm_attrs *prev_attrs)
+{
+	change->trigger = trigger;
+	change->prev_attrs = *prev_attrs;
+}
+
+static int amdgpu_svm_attr_apply_change(
+				struct amdgpu_svm *svm,
+				const struct attr_set_ctx *change)
+{
+	int ret;
+
+	lockdep_assert_held_write(&svm->svm_lock);
+
+	if (!change->trigger ||
+	    change->trigger == AMDGPU_SVM_ATTR_TRIGGER_ATTR_ONLY)
+		return 0;
+
+	ret = amdgpu_svm_range_apply_attr_change(svm, change->trigger,
+						 &change->prev_attrs,
+						 change->attr_range);
+	if (ret)
+		AMDGPU_SVM_TRACE("mapping apply failed ret=%d trigger=0x%x\n",
+				 ret, change->trigger);
+
+	return ret;
+}
+
+static inline int attr_check_preferred_loc(uint32_t value)
+{
+	/* casue one svm one gpu so value > 0 then means prefered loc is this GPU */
+	if (value == AMDGPU_SVM_LOCATION_SYSMEM || value == AMDGPU_SVM_LOCATION_UNDEFINED)
+		return 0;
+
+	return 0;
+}
+
+static inline int attr_check_prefetch_loc(uint32_t value)
+{
+	/* casue one svm one gpu so value > 0 then means prefetch loc is this GPU 
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
+	if (!value || value == AMDGPU_SVM_LOCATION_UNDEFINED)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int attr_check_flags(uint32_t value)
+{
+	if (value & ~AMDGPU_SVM_VALID_FLAG_MASK)
+		return -EINVAL;
+
+	if (value & AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED) {
+		AMDGPU_SVM_TRACE("AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED is not supported yet\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline int attr_check_granularity(uint32_t value)
+{
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
+	case AMDGPU_SVM_ATTR_ACCESS_IN_PLACE:
+	case AMDGPU_SVM_ATTR_NO_ACCESS:
+		return attr_check_access(attr->value);
+	case AMDGPU_SVM_ATTR_SET_FLAGS:
+	case AMDGPU_SVM_ATTR_CLR_FLAGS:
+		return attr_check_flags(attr->value);
+	case AMDGPU_SVM_ATTR_GRANULARITY:
+		return attr_check_granularity(attr->value);
+	default:
+		return -EINVAL;
+	}
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
+			attrs->access = AMDGPU_SVM_ACCESS_ENABLE;
+			break;
+		case AMDGPU_SVM_ATTR_ACCESS_IN_PLACE:
+			attrs->access = AMDGPU_SVM_ACCESS_IN_PLACE;
+			break;
+		case AMDGPU_SVM_ATTR_NO_ACCESS:
+			attrs->access = AMDGPU_SVM_ACCESS_NONE;
+			break;
+		case AMDGPU_SVM_ATTR_SET_FLAGS:
+			attrs->flags |= attr->value;
+			break;
+		case AMDGPU_SVM_ATTR_CLR_FLAGS:
+			attrs->flags &= ~attr->value;
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
+	uint32_t trigger;
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
+	trigger = attr_change_ctx_trigger(default_attrs, &new_attrs);
+	amdgpu_svm_attr_change_ctx_set(change, trigger, default_attrs);
+	change->attr_range = range;
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
+	uint32_t trigger;
+	bool force_trigger;
+
+	lockdep_assert_held(&attr_tree->lock);
+
+	old_attrs = range->attrs;
+
+	force_trigger = !attr_tree->svm->xnack_enabled && attr_has_access(nattr, attrs);
+
+	if (attr_same_attrs(range, nattr, attrs)) {
+		if (!force_trigger)
+			return 0;
+
+		amdgpu_svm_attr_change_ctx_set(change,
+						   AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE,
+						   &old_attrs);
+		change->attr_range = range;
+		return 0;
+	}
+
+	new_attrs = old_attrs;
+	amdgpu_svm_attr_apply(&new_attrs, nattr, attrs);
+	trigger = attr_change_ctx_trigger(&old_attrs, &new_attrs);
+
+	/* only need to update attr */
+	if (start_page == range_start && last_page == range_last) {
+		range->attrs = new_attrs;
+		amdgpu_svm_attr_change_ctx_set(change, trigger, &old_attrs);
+		change->attr_range = range;
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
+	/* trigger if new attrs is set in sub old attrs range.
+	 */
+	if (left || right)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_RANGE_SPLIT;
+
+	amdgpu_svm_attr_change_ctx_set(change, trigger, &old_attrs);
+	change->attr_range = range;
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
+		if (ret)
+			return ret;
+
+		down_write(&svm->svm_lock);
+		ret = amdgpu_svm_attr_apply_change(svm, &change);
+		up_write(&svm->svm_lock);
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
+		AMDGPU_SVM_TRACE("set attr type %u value 0x%08x for page range [%lx, %lx] xnack:%d", 
+			attrs[i].type, attrs[i].value, start_page, last_page, svm->xnack_enabled ? 1 : 0);
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
+int amdgpu_svm_attr_clear_pages(struct amdgpu_svm_attr_tree *attr_tree,
+				unsigned long start_page,
+				unsigned long last_page)
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
+static void attr_get_ctx_add(struct attr_get_ctx *ctx,
+			       const struct amdgpu_svm_attrs *attrs)
+{
+	if (!ctx->has_range) {
+		ctx->preferred_loc = attrs->preferred_loc;
+		ctx->prefetch_loc = attrs->prefetch_loc;
+		ctx->granularity = attrs->granularity;
+		ctx->access = attrs->access;
+		ctx->flags_and = attrs->flags;
+		ctx->flags_or = attrs->flags;
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
+		ctx->access = AMDGPU_SVM_ACCESS_NONE;
+	ctx->flags_and &= attrs->flags;
+	ctx->flags_or |= attrs->flags;
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
+			if (ctx->access == AMDGPU_SVM_ACCESS_ENABLE)
+				attrs[i].type = AMDGPU_SVM_ATTR_ACCESS;
+			else if (ctx->access == AMDGPU_SVM_ACCESS_IN_PLACE)
+				attrs[i].type = AMDGPU_SVM_ATTR_ACCESS_IN_PLACE;
+			else
+				attrs[i].type = AMDGPU_SVM_ATTR_NO_ACCESS;
+			break;
+		case AMDGPU_SVM_ATTR_SET_FLAGS:
+			attrs[i].value = ctx->flags_and;
+			break;
+		case AMDGPU_SVM_ATTR_CLR_FLAGS:
+			attrs[i].value = ~ctx->flags_or;
+			break;
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
+	mutex_lock(&attr_tree->lock);
+	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
+	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
+
+	if (!node) {
+		mutex_unlock(&attr_tree->lock);
+		return -EINVAL;
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

