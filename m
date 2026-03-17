Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E0AFD8745
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EB010E619;
	Tue, 17 Mar 2026 11:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnqZJS//";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24A5810E60F;
 Tue, 17 Mar 2026 11:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgsjFCAE4KYshK2+5wDaaHiD9x3xoCtekJDvMA+ETab4MBlEqsBvybwr2Dsry5MQo7QZWfG/KHOHmwzb2VBVJUKFvozRxEU2eRHrW56H1veep0ahGoSXrMGE6cQ5IBZ38MMApF45jY06gjL36DOxJtbSNXdG+7KFBpcgeY7+NF2nH13Tm1IyZ0xJ6oTMLcqkQVOYb0577x4En93NOkWyLrntnbQVhZ0iY8uE1LczO4mOpBaddEFSvbxNHmXAhYGXF5P4G5Tm1y8uM48PDswFsKDMLfDyF3trtRftMAJPeTgQdvo/2WgmOF9A2c7nQRr4opB2/rxKZWHfuk1fuiQSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjTtsfUKo8sZFXkY4gdU5G9HcsT5mUBfXSBitFR+DB4=;
 b=ps/bw9/6Vhu+SsujTvIdoLBjwkkEb3xjhK+vYErTIWyv1vP5SFmDOX2GYOAc3boGrj+Ezp5iyWKagRrIPN56d7MxZSTqvUzmY1zygy0xCpdZlbY/EMHEukkpNLdQhWRbtW+dI4V5llfD1iAvK6SeS2j4FJWxTudGCMznSZmMT7sni6wqF2XsEE6iI0nOiq2WbL3KAYIItm7RbHQMy7tNvAqJlqB1FTBjKyYvMXGJ6tC7bqox/z7sczHevQpCxtvhuLiPj7+PbOFBdTAE7qgk9/Hm+Dm54sA1KUeZlSE3jtD+rukO1/DcGXzYcFYeR8W8oCLCC4c+wxFGzENPaqHmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjTtsfUKo8sZFXkY4gdU5G9HcsT5mUBfXSBitFR+DB4=;
 b=MnqZJS//sWFYD50HcNZ7RthvIJfQWEgrI+qo1md60/bXXVMkIKpTNKdWcA05pouK+yXz0ouy5mCtaKUj5gZIrz2aCYIMY3gA5f8N7/CjauT2/ayo9xD7/VpNS52FE+5srhGM7DVVaidOo6g31w2KjFKXJfQ2pL1MXncCHxQaGqc=
Received: from SJ0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:a03:39e::29)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 11:30:32 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::bc) by SJ0PR03CA0294.outlook.office365.com
 (2603:10b6:a03:39e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 11:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:31 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:27 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 05/12] drm/amdgpu: implement SVM attribute set
Date: Tue, 17 Mar 2026 19:29:51 +0800
Message-ID: <20260317112958.2925370-6-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317112958.2925370-1-honglei1.huang@amd.com>
References: <20260317112958.2925370-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfd94f5-67e7-49c6-2ab5-08de84189949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: anVawpt0tC1ieCyUHjBuwhgz+dnx3QU2rjDtAp24fi9dAarfhpSo527nQsuzrNOhH1I/8jBKG1d+inaDH9KsOqp5YCKFw3M/wKGgBp7eUnleFVoMzEdmFqRf6s1NzztduwXHn9mO7Pdf7UpzENpGQUxCgXEWgQ9X4Y/bRf2tAnzMFOwaxxdJth1fgj5TJZVqGuOt9G4va8uV4iOu8Ejc5lF3ZCHD9qVWMufJXN1poBr71Su48+cMcnTKZSGnAq/dbjSqnoCwbt1blErjuBl8af7J3UZEWwtfN5AGZSa0+6Lz+hKO4bUGl9NS3u/dDK9Fb3F9IEz8v5hWzlOHw0KHUre3OKh2h/cAIhPO1zUGjqE9gcouyH0fauKQriKts3PtMEsbs8E6t4A84im4ph+gCvscVdg5vADWbYfKIY4qnXaHSum6wSmI3DC7NVYX+BFxkX5mY94gCzsLs43cn5KiQh9/yti9PMktBJaP03EvmLC3g7mddnVk5ilmBPR/TcwqLCC9bo+6+7VTylSC84JyBkAies5TD5Bu5s+tXaLtw05A4soAKw8GokAGzML3iMqxVV4MUfOR6rQpDAgGdjuBN/cAxEQvPgYVaBsI6ohfeUKm2ptOSaHXTIdsHT4SH+9elanVkd04N8gMVqYHVSnwWUc2Wk01SQsTWN0EPCvZr1KvXRjeaDW0cc9oJ5hTK+T8tgKhuQqKe9uyHK8v/vs0iSqkCr3IhRP9XuP8YqTMhXLICPfjnvwUDqvr2ryZe1jelGm307qmeY3RauNM4K5otrS5+EOB39CnWiJFPR+KAUlU1DbEZMCVBFOiLwxtUoM/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hsukkmzFsZ0APQo7AQ/vbCWCbJ65jfxw9hzThT99bOxTu0KTzcYb1RmsJFGjXyUAH7TTZ5XyECJP345NKN2tRk89ioreb/7WPe6no8pLDO84tPbHeajoe8jrSy7Q8q3NDTnTCGqfbNXeeU0IxpWvaTNhIo+cEESOeQxaHLHXSjWB4/1KaMvpTTkQs6/excBz/Xjz4VmVJsfiCa0DnlZKtkjaFwMdhDZtWU7y8/2ZfGZtgD06wOUWvgky1vJ286SIdVRZldKs8DCcb+CLt4WLVNSwswYryssIHrZlGP6xRxqD5LxMDeGcATMnoGn54Lj1FfJIU5RzHmg1ymNo4FYDfdnQL7FiGxGYasEWR25yeNQYhcQ96a9i2X1W7QQmdDV80GjVujvkAPLhzklXXgLtjXgI2WobyNeN2uQeWSe7dHTrx7xDfhAjDudxppPLFN34
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:31.7570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfd94f5-67e7-49c6-2ab5-08de84189949
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
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

