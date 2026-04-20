Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5D9F36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7736D10E534;
	Mon, 20 Apr 2026 12:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B87Yt6Cx";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE8F10E534;
 Mon, 20 Apr 2026 12:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEXZBzjEUT0FVtvm15SVMOIl4xpOnDmX6NcpCqGS+RAK11IGj5WFDc57WbQ3AjSV+apCNBaHb2X1cDpLmp3+PCxUACeAg5PFyGjj+OK73DUzid4X/8ec4emyWtvR5N2pe7JC8iz7bHlEYATW4cmbwTanUIAsdtJNHDjXCBYMteUDcrtUniT2sHQ+igok1sElaQmWnODNOH9ofl3uq8c1IWvGuukaCKBqeueICsPhNYqwr86jFlS+9uajeVR6jmh5NXyNwKeVN17NWw3/koAJCA0Vkn40gJRhRJUPtK8b7c2Rzio+1UfSReXdaMFjfel3doIv+Y9gTXQwwFuycuMWaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjTtsfUKo8sZFXkY4gdU5G9HcsT5mUBfXSBitFR+DB4=;
 b=O79LNoygDrHCDqnbQs0aezVmrP6nNBbZtuQFjZHBzsnFtIgqKEk6vz8uZRgq9BCUuZsEYbYUyPFRA4q7k63+0hJQwFWedeHS4t0D9pUTyvEviZ1zOvGpKit+UxSlZX1ngrZCXRvUBetESf3YT0QpA0/lNLXL7KfYQaW6DEdaJefA8xMOm5A4J34pNs8SGldJaL9OemoAZwPdhHzHWACs/L/UVJmZIexvvTl+Wh+hJCE96eGNpS07JWKi2P2ansm0fnonmRdw6ydN34TD3hMdRdOzfc/HcV+fp/3ntKbqv8SyYQPT9pNvQ8ZL2F+RHjLCZTj2XYIOtghxEg8bKvu2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjTtsfUKo8sZFXkY4gdU5G9HcsT5mUBfXSBitFR+DB4=;
 b=B87Yt6CxgMWsPE/1GdhfxaPnW8dcjhPz3d4aaFX9neYrw1ubl45YNBj/8a55hXx1pzRu47snT1DY9T+mZZL5jyQZPWDZ/XkndKihgi/eQnuvgXwHQtC9tHUgeLObVI13daZr19jqYubZ2SzP1ozTvDsqb+NQ31m/4tHaMl+vzt0=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by DSWPR12MB999175.namprd12.prod.outlook.com (2603:10b6:8:36f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:08:22 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::1c) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:22 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:18 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 05/12] drm/amdgpu: implement SVM attribute set
Date: Mon, 20 Apr 2026 20:07:32 +0800
Message-ID: <20260420120739.1811731-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420120739.1811731-1-honglei1.huang@amd.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|DSWPR12MB999175:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c205e78-9332-4b7b-b79f-08de9ed584a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: asZygQPS3TtYf60xSkXj6sTZM1ljaQYAnDa7ga4Zf4liBxX3t+kPdGNdSok1nxAweF45xgkO5M+gddAnaoS1QzWWGOhOjFJ/CImo4/pe/vAY2ormizGwt8G6kE+IXbNsQkvoBWl7pQmOIcRvzHpBZWfGGsHjFyxO2rOR9EQdB8obrYgllLnYbOh5+J5I24i6rP4D1GDphD4RxpNOlRSZvzWWX1GGAIk5A3cC13YoSY+RzCQHEp46IwjlEATZA+1i/AHYPf69hOtlU8hRDAk2VTEDpWhhq9pdcI2SYT2jUMIv8+E2F9GlEmzkV0xiEgZSI9Hj3ckpyWolMKIylYF4rkp26q0aCc/8OMqvcEYCYZYODGKMDPMC/QLOkltZvY5NS/sO6e7j+FkbHcqNy9BMeqmSM/5k10M4EzHtFvJsuzlKnbhI2dki4Gj+oNRweQ4z+TCwOBiDIWhLGmKwk08mbobj+yzVE2RamJwYgnk7yxJo4C6WtETgvWq5yFn2/UEP8ioGh3UPxAkKcdt4yYmaYBvK0EqhVrdL3oE/h7NFan2rAlN9tDq6r8mSowDomWI2GWfDNs7rYTThxI0Tsqmgs+1gUB8RdJe2lwdrF7PT4wUT+SN7jZplLRmvaA3z2KQDb0MXSbpDCaub5hU1shM9xBz11Qb6aehkFxy7PUPEU1NYujKRe8c4wOoh1VKRKrbmGCRh2m7zOGkdoL9jYM1mY0P+dhDywrIBXPCzoa94B4Vq+Yo5bmciURtfGkyYw8cjmK3XUjyINdUDgDLkB/q0KzV/e7k6+i2hKxIvKIZPztNK/q5N88en+wWpItBOvqTf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zr1TTqZhEJ4+Itclw5skNJyBqyTuaXro1cLK48uBJIxK+cRq0ZvAZN3qX8tdKwXjEhw+bJgXeAtlbL+AiVyirRqJFqvn+qc/pjhDJKJPMGgpLHeFLKZswbhzmMjspZanCYPbSdJe6I1qiqxLChs20zwpMjU6jRrxat0ZrZDZQQaPJfX9B7YWh7Mf0m7aic1soUBe+MbizgO3lxu78P7+beDY0CvPKGsF6/zW2fssoks0J+42YlhPdhDMMHdKgTPdoNwtjqUN+75qS4115rofVdX0Xc+DOnE7C/Ss/vymqMdmX6pBV9aFkkNBPMMMWlS5yS2zK5Ycxt0bkbgsJvE14PrD1ypo5oahyHem3vCZLgX0I1Ix+G2VtxMNTqcJIKQE8Z+T4+HrEHI4lR3rj9F/f7f1HL60H9aOm5sEp50s8A3zRnCFAoF70lzLHmjJ6l4u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:22.3129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c205e78-9332-4b7b-b79f-08de9ed584a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999175
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

Implement the attribute set path

- Attribute application: apply UAPI attributes to internal attrs
- Attribute tree set split remove.
- amdgpu_svm_attr_set with retry on -EAGAIN
- amdgpu_svm_attr_clear_pages: remove attribute ranges for unmapped
  operations.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 548 +++++++++++++++++++
 1 file changed, 548 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 137dfcb58..cd972026f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -33,8 +33,23 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 
+#define AMDGPU_SVM_VALID_FLAG_MASK \
+	(AMDGPU_SVM_FLAG_HOST_ACCESS | AMDGPU_SVM_FLAG_COHERENT | \
+	 AMDGPU_SVM_FLAG_HIVE_LOCAL | AMDGPU_SVM_FLAG_GPU_RO | \
+	 AMDGPU_SVM_FLAG_GPU_EXEC | AMDGPU_SVM_FLAG_GPU_READ_MOSTLY | \
+	 AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED | AMDGPU_SVM_FLAG_EXT_COHERENT)
+
+
 static struct kmem_cache *amdgpu_svm_attr_range_cache;
 
+struct attr_set_ctx {
+	unsigned long start;
+	unsigned long last;
+	uint32_t trigger;
+	struct amdgpu_svm_attrs prev_attrs;
+	struct amdgpu_svm_attrs new_attrs;
+};
+
 struct attr_get_ctx {
 	int32_t preferred_loc;
 	int32_t prefetch_loc;
@@ -130,6 +145,48 @@ static bool amdgpu_svm_attr_equal(const struct amdgpu_svm_attrs *a,
 		       a->access == b->access;
 }
 
+static uint32_t
+attr_change_ctx_trigger(const struct amdgpu_svm_attrs *prev_attrs,
+		      const struct amdgpu_svm_attrs *new_attrs)
+{
+	uint32_t trigger = 0;
+	uint32_t changed_flags = prev_attrs->flags ^ new_attrs->flags;
+
+	if (prev_attrs->access != new_attrs->access)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE;
+
+	if (changed_flags & AMDGPU_SVM_PTE_FLAG_MASK)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE;
+	if (changed_flags & AMDGPU_SVM_MAPPING_FLAG_MASK)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE;
+	if (prev_attrs->preferred_loc != new_attrs->preferred_loc ||
+	    prev_attrs->prefetch_loc != new_attrs->prefetch_loc)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE;
+	if (prev_attrs->granularity != new_attrs->granularity)
+		trigger |= AMDGPU_SVM_ATTR_TRIGGER_GRANULARITY_CHANGE;
+
+	if (!trigger)
+		trigger = AMDGPU_SVM_ATTR_TRIGGER_ATTR_ONLY;
+
+	return trigger;
+}
+
+static bool attr_has_access(uint32_t nattr,
+					  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	uint32_t i;
+
+	for (i = 0; i < nattr; i++) {
+		switch (attrs[i].type) {
+		case AMDGPU_SVM_ATTR_ACCESS:
+		case AMDGPU_SVM_ATTR_ACCESS_IN_PLACE:
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static struct amdgpu_svm_attr_range *
 attr_alloc_range(unsigned long start,
 			   unsigned long last,
@@ -179,6 +236,388 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
 		kmem_cache_free(amdgpu_svm_attr_range_cache, range);
 }
 
+static void amdgpu_svm_attr_change_ctx_set(
+		struct attr_set_ctx *change,
+		unsigned long start,
+		unsigned long last,
+		uint32_t trigger,
+		const struct amdgpu_svm_attrs *prev_attrs,
+		const struct amdgpu_svm_attrs *new_attrs)
+{
+	change->start = start;
+	change->last = last;
+	change->trigger = trigger;
+	change->prev_attrs = *prev_attrs;
+	change->new_attrs = *new_attrs;
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
+	ret = amdgpu_svm_range_apply_attr_change(svm, change->start, change->last,
+						 change->trigger, &change->prev_attrs,
+						 &change->new_attrs);
+	if (ret)
+		AMDGPU_SVM_TRACE("mapping apply failed ret=%d [0x%lx-0x%lx]-0x%lx trigger=0x%x\n",
+				 ret, change->start, change->last,
+				 change->last - change->start + 1,
+				 change->trigger);
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
+	const unsigned long device_vma = VM_IO | VM_PFNMAP | VM_MIXEDMAP;
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
+		struct vm_area_struct *vma = vma_lookup(mm, start);
+
+		if (!vma || (vma->vm_flags & device_vma)) {
+			ret = -EFAULT;
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
+	return amdgpu_svm_attr_equal(&range->attrs, &target);
+}
+
+static int
+amdgpu_svm_attr_set_hole(struct amdgpu_svm_attr_tree *attr_tree,
+			  const struct amdgpu_svm_attrs *default_attrs,
+			  unsigned long start, unsigned long last,
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
+	if (start > last)
+		return 0;
+
+	/* no action if default attr */
+	new_attrs = *default_attrs;
+	amdgpu_svm_attr_apply(&new_attrs, nattr, attrs);
+	if (amdgpu_svm_attr_equal(default_attrs, &new_attrs))
+		return 0;
+
+	range = attr_alloc_range(start, last, &new_attrs);
+	if (!range)
+		return -ENOMEM;
+
+	attr_insert_range_locked(attr_tree, range);
+
+	trigger = attr_change_ctx_trigger(default_attrs, &new_attrs);
+	amdgpu_svm_attr_change_ctx_set(change, start, last, trigger,
+					   default_attrs, &new_attrs);
+	return 0;
+}
+
+static int
+amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
+			     struct amdgpu_svm_attr_range *range,
+			     unsigned long start, unsigned long last,
+			     uint32_t nattr,
+			     const struct drm_amdgpu_svm_attribute *attrs,
+			     struct attr_set_ctx *change)
+{
+	unsigned long range_start = attr_start_page(range);
+	unsigned long range_last = attr_last_page(range);
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
+	/* The attr layer doesn't store the gpu mapped state, and for align with KFD,
+	 * need force trigger range layer to check if gpu mapped.
+	 */
+	force_trigger = !attr_tree->svm->xnack_enabled && attr_has_access(nattr, attrs);
+
+	if (attr_same_attrs(range, nattr, attrs)) {
+		if (!force_trigger)
+			return 0;
+
+		amdgpu_svm_attr_change_ctx_set(change, start, last,
+						   AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE,
+						   &old_attrs, &old_attrs);
+		return 0;
+	}
+
+	new_attrs = old_attrs;
+	amdgpu_svm_attr_apply(&new_attrs, nattr, attrs);
+	trigger = attr_change_ctx_trigger(&old_attrs, &new_attrs);
+
+	/* only need to update attr */
+	if (start == range_start && last == range_last) {
+		range->attrs = new_attrs;
+		amdgpu_svm_attr_change_ctx_set(change, start, last,
+						   trigger, &old_attrs, &new_attrs);
+		return 0;
+	}
+
+	/* split head */
+	if (start > range_start) {
+		left = attr_alloc_range(range_start, start - 1, &old_attrs);
+		if (!left)
+			return -ENOMEM;
+	}
+
+	/* split tail */
+	if (last < range_last) {
+		right = attr_alloc_range(last + 1, range_last, &old_attrs);
+		if (!right) {
+			if (left)
+				kmem_cache_free(amdgpu_svm_attr_range_cache, left);
+			return -ENOMEM;
+		}
+	}
+
+	attr_remove_range_locked(attr_tree, range, false);
+	if (left)
+		attr_insert_range_locked(attr_tree, left);
+	attr_set_interval(range, start, last);
+	range->attrs = new_attrs;
+	attr_insert_range_locked(attr_tree, range);
+	if (right)
+		attr_insert_range_locked(attr_tree, right);
+
+	amdgpu_svm_attr_change_ctx_set(change, start, last, trigger,
+					   &old_attrs, &new_attrs);
+	return 0;
+}
+
+static int
+amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
+			  const struct amdgpu_svm_attrs *default_attrs,
+			  unsigned long start, unsigned long last,
+			  uint32_t nattr,
+			  const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = attr_tree->svm;
+	unsigned long cursor = start;
+	bool need_retry = false;
+
+	while (cursor <= last) {
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
+			seg_last = min(last, attr_last_page(range));
+			ret = amdgpu_svm_attr_set_existing(attr_tree, range,
+								   cursor, seg_last,
+								   nattr, attrs, &change);
+		} else {
+			struct interval_tree_node *next;
+
+			seg_last = last;
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
+					seg_last = min(last,
+						       attr_start_page(next_range) - 1);
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
+		if (seg_last == ULONG_MAX || seg_last == last)
+			break;
+
+		cursor = seg_last + 1;
+	}
+
+	return need_retry ? -EAGAIN : 0;
+}
+
 struct amdgpu_svm_attr_tree *
 amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
 {
@@ -214,6 +653,115 @@ void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree)
 	kfree(attr_tree);
 }
 
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
+	attr_set_default(attr_tree->svm, &default_attrs);
+
+	/*
+	 * POC/WA:
+	 * can not acquire the mmap lock because of drm gpu svm frame work design (drm_gpusvm_range_find_or_insert)
+	 * the hmm operations and GPU mapping possiable to fail so add retry mechanism
+	 * 
+	 * TODO: add mmap locked flag in drm_gpusvm_ctx to acquire mmap lock in entire ioctl period
+	 */
+retry:
+	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs,
+					       start_page, last_page,
+					       nattr, attrs);
+	if (r == -EAGAIN) {
+		AMDGPU_SVM_TRACE("attr_set retry [0x%lx-0x%lx]\n",
+				 start_page, last_page);
+		amdgpu_svm_range_flush(svm);
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
+		range_start = attr_start_page(range);
+		range_last = attr_last_page(range);
+
+		if (range_start < start_page && range_last > last_page) {
+			struct amdgpu_svm_attr_range *tail;
+
+			tail = attr_alloc_range(last_page + 1, range_last, &range->attrs);
+			if (!tail) {
+				r = -ENOMEM;
+				break;
+			}
+
+			attr_remove_range_locked(attr_tree, range, false);
+			attr_set_interval(range, range_start, start_page - 1);
+			attr_insert_range_locked(attr_tree, range);
+			attr_insert_range_locked(attr_tree, tail);
+		} else if (range_start < start_page) {
+			attr_remove_range_locked(attr_tree, range, false);
+			attr_set_interval(range, range_start, start_page - 1);
+			attr_insert_range_locked(attr_tree, range);
+		} else if (range_last > last_page) {
+			attr_remove_range_locked(attr_tree, range, false);
+			attr_set_interval(range, last_page + 1, range_last);
+			attr_insert_range_locked(attr_tree, range);
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
 static void attr_get_ctx_add(struct attr_get_ctx *ctx,
 			       const struct amdgpu_svm_attrs *attrs)
 {
-- 
2.34.1

