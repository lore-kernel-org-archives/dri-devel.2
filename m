Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00D606A31B
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=2+G2EVyA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36B310F834;
	Wed, 21 Oct 2026 03:00:00 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB21710F834;
 Wed, 21 Oct 2026 02:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5JIRNRPbTUHLFcYRnNnwFHMyof79XK97VlxYWlmgoNfUjgb65enbUduBzaYL/HXQVH94dm97szUdecXjnTYg3akGPdivCg4ag+2glEIN9cMfuMI+ll5qemaoXIWGAgoq8rjN2WmOcjtKXwKLa9Kc2cLtH6Oz6077RlwJb8oob/4TQah5ugs7B0vXz2OOPoZpVNLEaEeWxKj2wVANn1T+ksiucCsaZckwBbE/YF0tW5SfZ3vBXArNV0uncGyw7AlkLoDCf6tjy0Hc8Gi9FUToB/Ld3yWkg7NkA7y1FQWg+r3FosVDWaWAPoZQhSqVmNQr3WaAhR812MIWs+VJc/wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKgZ3bP+EY/N4i56flGw2z1EaaxBlxvlN6rhgHFsLss=;
 b=XFfuxs4ZDYdCSQV9WfSJUoeTq6feDbsH6TyGmb0vFPLO/N8bdnGqERkGA6M/IxWBGtOW/FNrSpQl2vXX88xSeBoFfzXmtFzY+lloGTLX9hA2Jn/J4KbymczshslkY8PCMB+uDsm1EmcLe4Mj3wV+q/c4GIBJE2VLeEIWz2JSEeaa+t9UuI7B05zhRf+mTev/5fMDYUpNvWdbpyFBhQIfHQjWsUthScL08pEbe6C3VwbUkxFHhDoVaj0JgYC4S0h7zOHBahOsWCExa/Uc+ZDFy8idBhsJXZFs7FAol6RgZCs5wMd+oWeIS1qbfrQ6KyaWOSdI7mRdIgMwr7dUFcK5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKgZ3bP+EY/N4i56flGw2z1EaaxBlxvlN6rhgHFsLss=;
 b=2+G2EVyAcIqSYin1lilE5i1DUzCqq19cz+fpB3A1WPGAXRrtfqRVNT1jHWuv27Phwf59FJ0BxDK18dXW1qQiG0KY/bCL5VU2OA5eh048azfm/ceBjDj+imq07GOmJ1qGNiMt+kgSB1v+G1MqWx9CJ2Iuf/h5z6NmqnI/1mEDooY=
Received: from PH0PR07CA0028.namprd07.prod.outlook.com (2603:10b6:510:5::33)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:59:48 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::80) by PH0PR07CA0028.outlook.office365.com
 (2603:10b6:510:5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 02:59:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:59:47 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:42 -0500
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
Subject: [PATCH v10 04/22] drm/amdgpu: implement SVM attribute set/get/clear
 operations
Date: Wed, 21 Oct 2026 10:58:43 +0800
Message-ID: <20261021025915.2433837-5-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021025915.2433837-1-ray.huang@amd.com>
References: <20261021025915.2433837-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 452eb47c-7f36-467f-2693-08df2f1f5e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|921020|56012099006|11063799006|261009223327099003|261009221227099003|261009220027099003|261009223027099003|261009221727099003|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7Q3cyHxXwt9jJN6bncvHyLSp07yJdu8xDDIKffQYCbQjbKwGTjd+VK5zrMfBWn5U8hRr2g/heGU09R7r40isyoWrZR6MuAtoO2efLUMbVbtqSFi5JXedOO4gCyMrX5nD0VbLQM0+cu+iUJ1nFYg7zv4dm8hZEPck3ZCQAIMtjEyXb220LQDRfMBCiUPaC/4ZouSt432uMHL9mA8+g0NMQ2HeRoNkO+NizdUcL3Bsc5YynyIm+p6JGT1GfXjFf2xk4ge/s2qjoE/ql5LsHuSw+vxHw156Nx70qfNwDzaiocf26OSGMScBXAgXJkQ188Qj7NC2trEinzqh4BRJcQN0dyG/XndVDafnjPy/rxHWNdabi2zSPaxJK5e7TkhB3mQzvzI+gVROd+Ob0eaJTfO/f9pJspaaEnV0/vlMZ+ERzqeMAUktEayDH5BA/sYHaikJzrqdaGKcn/6077RGGtuhHaG+WGtG5UXimAEU43aL4uEdCQpvjQm6DTt74QJXEwWM3M02/hrCj7ZNbykeboa1eT9qE8goIRWUROjrqaE41SdEUA4sxM3ZKoAfJjU3/UpJr1Sv1VVbqrZy81JNTPgq6nTbxBELDZNUWayVCz/9Wo+YgezU8kz38pi65XPkwtqmYYbaDW7RwSfX+gKsoRXIKyvUzFjBT3jA9lzur+ixfQWS+LEd5ROzuHodCQmab/eyywy9mix83shLkC0cNQ649NfO4V9Sg4pDkG9DWsCQOlUzkfjq9NZ7nOqXhiK4KHN0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223327099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0d8n47x02doBRFnm9v9jncd4IjP2Io00O6EBlsqpo+1haUF6ZHTEPjKOWBTMeqBz6Priv7WHMvocJV0rLtEevvNDJjmHnrY8BnvGbDvvojqmykDmLh0zUykU6XGZxG03aicE9hyxQ+r/Iezh3f/BRZNiIVSZ3g8FLWdWaDgB1xwcA5XixHS8ppkfRNxdffoa8IKZxf44HlkFvhnSB7rhX8t8fmWoIV18ZjOTmrhU+BOo5YaFJM3E5CZMqpe5Ju6mq43NxfBFLpFoAz9+heP9sDKc3c+vmUUUa9ZWLL0JM7XNiDpCViqow7lbhJyrHUa5NoJTJLlU90iIZoCYOmEn05IDIUc/+Myhq2They8mMfGhvlZKt0IxkYHP7zm2eE94sf8IkdwXxBNad2dLs1KgsUWPPvXx4NJUpNG8tEZT+vxr3uMYMfFRNatLnCVhVArs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:59:47.9293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452eb47c-7f36-467f-2693-08df2f1f5e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Complete attribute subsystem with validation, tree modification, and
public API:
- Attribute validation: per-type checks for preferred_loc, prefetch_loc,
  access, flags, granularity
- Flag application: attr_apply_flag, amdgpu_svm_attr_apply
- VMA range validation: amdgpu_svm_attr_validate_range_vma
- VM BO overlap detection: amdgpu_svm_attr_check_vm_bo
- Tree modification with gap/overlap handling:
  amdgpu_svm_attr_set_hole (new range in gap),
  amdgpu_svm_attr_set_existing (split/update existing range)
- amdgpu_svm_attr_set_range: cursor based iteration with per segment
- Lifecycle: amdgpu_svm_attr_tree_create/destroy
- Public API: amdgpu_svm_attr_set (validate, set_range with retry),
  amdgpu_svm_attr_get (aggregate attrs across interval),
  amdgpu_svm_attr_clear (interval removal with split),
  amdgpu_svm_attr_reset

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 736 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h |  20 +
 2 files changed, 756 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index a5afa75421fbd..c76e10473968e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -78,6 +78,43 @@ struct vm_area_struct *amdgpu_svm_check_vma(struct mm_struct *mm,
 	return vma;
 }
 
+/*
+ * amdgpu_svm_attr_range_is_valid - validate an attr ioctl address range
+ *
+ * Synchronous input validation for the SVM set/get-attr ioctls: walk the
+ * CPU VMAs covering [start_page, last_page] and reject the request if any
+ * part is unmapped or backed by an unsupported VMA (-EOPNOTSUPP).
+ *
+ */
+static int amdgpu_svm_attr_range_is_valid(struct amdgpu_svm *svm,
+					  unsigned long start_page,
+					  unsigned long last_page)
+{
+	struct mm_struct *mm = svm->gpusvm.mm;
+	struct vm_area_struct *vma;
+	unsigned long start, end;
+	int r = 0;
+
+	if (!mm)
+		return -EFAULT;
+
+	start = start_page << PAGE_SHIFT;
+	end = (last_page + 1) << PAGE_SHIFT;
+
+	mmap_read_lock(mm);
+	do {
+		vma = amdgpu_svm_check_vma(mm, start);
+		if (IS_ERR(vma)) {
+			r = PTR_ERR(vma);
+			break;
+		}
+		start = min(end, vma->vm_end);
+	} while (start < end);
+	mmap_read_unlock(mm);
+
+	return r;
+}
+
 static void attr_set_interval(struct amdgpu_svm_attr_range *range,
 				unsigned long start_page,
 				unsigned long last_page)
@@ -233,3 +270,702 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
 	if (free_range)
 		kfree(range);
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
+	/*
+	 * SYSMEM and UNDEFINED are always valid; LOCAL/HIVE select device
+	 * VRAM (see enum amdgpu_ioctl_svm_location).
+	 */
+	switch (value) {
+	case AMDGPU_SVM_LOCATION_SYSMEM:
+	case AMDGPU_SVM_LOCATION_UNDEFINED:
+	case AMDGPU_SVM_LOCATION_LOCAL:
+	case AMDGPU_SVM_LOCATION_HIVE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static inline int attr_check_prefetch_loc(uint32_t value)
+{
+	/*
+	 * Prefetch accepts the same values as the preferred location (see
+	 * enum amdgpu_ioctl_svm_location); UNDEFINED means no prefetch and is
+	 * what GET_ATTR reports for default or mixed ranges, so it must round
+	 * trip through SET for CRIU restore.
+	 */
+	switch (value) {
+	case AMDGPU_SVM_LOCATION_SYSMEM:
+	case AMDGPU_SVM_LOCATION_UNDEFINED:
+	case AMDGPU_SVM_LOCATION_LOCAL:
+	case AMDGPU_SVM_LOCATION_HIVE:
+		return 0;
+	default:
+		return -EINVAL;
+	}
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
+/*
+ * amdgpu_svm_attr_set_existing() - Apply attrs to part of an existing range
+ *
+ * Update @range over [@start_page, @last_page]. If the request fully covers
+ * @range the attrs are updated in place, otherwise the range is split into the
+ * head/tail, carrying the old attrs, and the covered middle, carrying
+ * the new attrs. The resulting change is reported by @change.
+ */
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
+			kfree(left);
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
+/*
+ * amdgpu_svm_attr_set_range() - Apply attr changes across [@start_page, @last_page]
+ *
+ * Walk the interval in segments, each segment being either an existing range
+ * or a hole.
+ */
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
+	attr_tree = kzalloc_obj(*attr_tree, GFP_KERNEL);
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
+		kfree(range);
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
+		pr_debug("set attr type %u value 0x%08x range [0x%lx-0x%lx] xnack:%d",
+			 attrs[i].type, attrs[i].value, start_page, last_page,
+			 svm->xnack_enabled ? 1 : 0);
+		r = attr_set_validate(&attrs[i]);
+		if (r) {
+			pr_debug("invalid attribute %u value 0x%08x",
+					 attrs[i].type, attrs[i].value);
+			return r;
+		}
+	}
+
+	r = amdgpu_svm_attr_range_is_valid(svm, start_page, last_page);
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
+		pr_debug("attr_set retry [0x%lx-0x%lx]\n",
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
+/*
+ * On return @out_size is shrunk to the length of the contiguous range starting
+ * at @start over which all attributes are identical, so user space (e.g. CRIU)
+ * can walk the address space one uniform range at a time.
+ */
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
+			uint64_t start, uint64_t size,
+			uint32_t nattr,
+			struct drm_amdgpu_svm_attribute *attrs,
+			uint64_t *out_size)
+{
+	struct amdgpu_svm_attrs default_attrs;
+	struct amdgpu_svm_attrs ref_attrs;
+	struct attr_get_ctx ctx = { 0 };
+	struct interval_tree_node *node;
+	unsigned long start_page, last_page, cursor, homog_last;
+	bool have_ref = false;
+	int r;
+
+	start_page = start >> PAGE_SHIFT;
+	last_page = (start + size - 1) >> PAGE_SHIFT;
+
+	r = amdgpu_svm_attr_range_is_valid(attr_tree->svm, start_page, last_page);
+	if (r)
+		return r;
+
+	mutex_lock(&attr_tree->lock);
+	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
+
+	homog_last = start_page;
+	cursor = start_page;
+	node = interval_tree_iter_first(&attr_tree->tree, start_page, last_page);
+
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
+							       last_page);
+				continue;
+			}
+
+			if (amdgpu_svm_attr_start_page(range) <= cursor) {
+				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
+				node = interval_tree_iter_next(node, start_page,
+							       last_page);
+			} else {
+				range_last = min(last_page,
+						 amdgpu_svm_attr_start_page(range) - 1);
+				range = NULL;
+			}
+		}
+
+		range_attrs = range ? &range->attrs : &default_attrs;
+
+		if (!have_ref) {
+			ref_attrs = *range_attrs;
+			have_ref = true;
+		} else if (!attr_equal(range_attrs, &ref_attrs)) {
+			break;
+		}
+
+		homog_last = range_last;
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
+	if (!have_ref)
+		ref_attrs = default_attrs;
+
+	attr_get_ctx_add(&ctx, &ref_attrs);
+	r = attr_get_ctx_to_result(&ctx, nattr, attrs);
+	mutex_unlock(&attr_tree->lock);
+
+	if (!r && out_size)
+		*out_size = ((uint64_t)(homog_last - start_page) + 1) << PAGE_SHIFT;
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
index 36fee11aa9ea0..56bcd81c608cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -158,6 +158,9 @@ enum amdgpu_svm_attr_change_trigger {
 	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | \
 	 AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
 
+struct amdgpu_svm_attr_tree *
+amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
 struct amdgpu_svm_attr_range *
 amdgpu_svm_attr_find_locked(struct amdgpu_svm_attr_tree *attr_tree,
 			   unsigned long page);
@@ -169,6 +172,23 @@ amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree,
 void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm,
 				 struct amdgpu_svm_attrs *attrs);
 
+int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree,
+			   uint64_t start,
+			   uint64_t size,
+			   uint32_t nattr,
+			   const struct drm_amdgpu_svm_attribute *attrs);
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree,
+				       uint64_t start,
+				       uint64_t size,
+				       uint32_t nattr,
+				       struct drm_amdgpu_svm_attribute *attrs,
+				       uint64_t *out_size);
+int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page);
+int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree,
+			  unsigned long start_page,
+			  unsigned long last_page);
 struct amdgpu_svm_attr_range *
 amdgpu_svm_attr_range_alloc(unsigned long start_page,
 			   unsigned long last_page,
-- 
2.53.0

