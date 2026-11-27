Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3141606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=42HiyU3X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BC6112869;
	Fri, 27 Nov 2026 08:42:46 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013012.outbound.protection.outlook.com
 [40.107.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFAD11285A;
 Fri, 27 Nov 2026 08:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVhjJVtB/j5HMc2a8ckX6r6eW33GvV/msEgSS+cwMHIIPh2YVfetfaPWnGdw76I5qNF29Lk2dK0GvuX1HKZhY+4NjGXqFaETj6tsVpijOApVklYIlVj8ObDbiuJCCsr5LPO3Zp6puuBOCkCUPIw9Im4kUWzHzKBA2iGTHHggwW9u84G+3WsTM4VyxIuICX7MUOpw48eW1SFrL8hOIgaJnw1BmC53kdheFgOB7ZKW3cWyyhUh/v4OV8QL9X0LdserhgKN3Ao7kL6bIXSpL2TZsB9Qogmog2FaLZt0ZRY+QboQFGy2ZcEUjZnpztMWLkt29y07DJPdL9PtZl4gZgKI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1l8qReDrsRfBSesHrYR5A0VvMydYexOymag5a5ZCPg=;
 b=l5VFXJHxt+KmoN/Cri5ghVs4CDZkl3t6Id4Y76pG6uiY0xFFlz1V15Bsxydh88D5x3SDngKG/p8NJx/jNs1dUh0poVlob2kuVsroc9kHf0qI6IGXKSo5ZaYyy67ERpxbH33sTD/r7SVUQtPkamJjEztFNJ8aZwS200XhM7JlE6z8gei5/0L+EVcTPY8un/KTWS4fF0StazI4UnstyZDi6CtpkTz99iKE+GaM9Ao5TRXLn+mKBu3Hstz2b/xkXn9cE2PEfHMcafB4jdAZz1x66EEyBUGkQSU6vmkWYkH5VQBF0f7KBX1hfkLAKI9PBdfmVuv7J1oytxH/u0i2bydSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1l8qReDrsRfBSesHrYR5A0VvMydYexOymag5a5ZCPg=;
 b=42HiyU3XayQJY6Ff6vTEUr9j55qIgCdn9wYvM1XTFgC8TK20itFa6+JDHNQoaj1XTHv8dmz9niREJg1ydpueIDQJEc0bnN90rb+xArnKaGnwjlVa012IlZ9yCa7viQASmg9uBw57F7OsMBQarWK3bljk1DRDHW5z0vVvN4qyxns=
Received: from CH0PR03CA0432.namprd03.prod.outlook.com (2603:10b6:610:10e::20)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 08:42:17 +0000
Received: from CH2PEPF000166BA.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::2d) by CH0PR03CA0432.outlook.office365.com
 (2603:10b6:610:10e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 08:42:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BA.mail.protection.outlook.com (10.167.252.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:17 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:42:10 -0600
From: Huang Rui <ray.huang@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>, Simona Vetter <simona@ffwll.ch>, "Matthew
 Brost" <matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Aveline Noir <jm5905938@gmail.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>, "Jenny
 Liu" <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 "Honglei
 Huang" <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>, Yiru Ma
 <yiru.ma@amd.com>, Huang Rui <ray.huang@amd.com>, Honglei Huang
 <honghuan@amd.com>
Subject: [PATCH v11 05/22] drm/amdgpu: implement SVM attribute set/get/clear
 operations
Date: Fri, 27 Nov 2026 16:41:28 +0800
Message-ID: <20261127084149.925625-6-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127084149.925625-1-ray.huang@amd.com>
References: <20261127084149.925625-1-ray.huang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BA:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f61f9e8-4a4e-4e37-19f7-08df4c6257d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|921020|261022105027099003|10067099003|11063799006|56012099006|261026121527099003|261021123027099003|261028144727099003|261022075727099003|261021121427099003|261026140227099003|261102123227099003|261009221727099003|261009223027099003|261009220027099003|261009223327099003|261009221227099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: wlFUhzWgvQrjR+0Mpuv+2HdSM7uc+ercclE4Q/Xr3rzoKZbEEispZvRnfzcRuv95GljGFn7OzJxLTx+xi707Tb2k8WnLV1jUt0+mNzG2zUfVUHwZO72uigqLclG9fM9c9vbgO6Z85Lw+hLscKjkOGrBQwpASdP7V5M902FPtNd+FNiT+6nazKFjQXesun0zzMWLowgoo3j0jkUwEXxruRyk6muMkT5XG5N4Zavy6pm0GbAt1ysXW3okBlNjUVOjaIwaybxnBuu9iETuCetr322K2PvTtAWTTgZecGcXd8rEoHgPbTGIbvTW56wCVN8P2szR4gfDX0n/3w0pNBbxm55y1vleQdV4GfXKg6SgV3GeCXDa1D29zRvT1Vs9caM34ZLTBYrvRE9PeW4Yewkz0RfTuInRdqthdoXwqKZphtlpaIBXJ8l25rS7Tba1iBy+vLaSyzKp1IFCcc9qx8aV0ctzvKdld5X9ECT88/zlN6dYa0+wtfki+BRBxDC4k5EFsbj2crYdHqtRIr/1rmCFErI8fjMzbj16p1ZvVgz7UvkjD7BaZUUTSOSCI0wl2BlYvPekOtp69xSA20aIuLZOTBqd2l6sBlJxxbbd9CvEIBIwPi4yYI5r83zphZNnjZexRvfvLmcah9jKldvErH78EC2qiyKSdmmvAdmVi+H6VN9mAtBMQtUlTf1QoY7SrXhRVYoz0qroIkrSnsgwv4+kcVd+/nIQij1uIRTErXLAp0OXoU/QweiGUuWZP434RW8jS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(921020)(261022105027099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026140227099003)(261102123227099003)(261009221727099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221227099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dn0VAI6HtR/RVeCsMKav/DP/PBFkF92mqcUe4ZshVjWRF8S9gJwNM7gHK9W3pgAOgBv2whnUqDALqO1HZVGEZrbStvppkxVQY5b0MaD5UBzNFRK2Ak6UoexW0EOp/DoaBSaJh34NhCco1zUmODNZdqxA+vY7POPRg+0ptgkNWW9uyfNBo0pOlUw0xxzwRFA0cg3fE6HYDqDeIG4PKWTM9Ols3vjyv6X2zmSUINBz9+S/vPwB5YWQ6LzFQFt6XPKUc/DuCCLNFXq1vlK+G6Y9Vwj7qCw4QfFLpAHTKkMvhzmbunyi32FsJHXW6eFYhCl1pCZI9QRMOUvJACZl0Ko4ikPIVQUMZ+f1Z9ffsAMKPAzwbkInV1+ydPW9HlZf4xxAZwvOLDSvwF7rETJFRVgyrnEbicLB01rHa9s2+8S1c8Spdoi/iyGKREJolRkQwgJV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:17.3091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f61f9e8-4a4e-4e37-19f7-08df4c6257d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Complete the attribute subsystem with per-type validation, interval
updates, default attributes and public SET, GET and RESET operations.

Split attribute ranges as needed when applying updates. GET
reports the uniform prefix of the requested interval and its length.
Keep interval removal private to the RESET implementation. Document
the public helpers' arguments, locking requirements and return values.

Do not preflight attribute ioctls against transient CPU VMAs.
Fault and mapping paths validate current backing pages, while the
ioctl entry validates numeric address-space bounds.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c | 690 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h |   8 +
 2 files changed, 698 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
index 5b083aad24c01..0db96a4700666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c
@@ -260,3 +260,693 @@ static void attr_remove_range_locked(struct amdgpu_svm_attr_tree *attr_tree,
 	if (free_range)
 		kfree(range);
 }
+
+static void
+attr_change_ctx_set(struct attr_set_ctx *change, const struct amdgpu_svm_attrs *old_attrs,
+		    const struct amdgpu_svm_attrs *new_attrs, unsigned long start_page,
+		    unsigned long last_page)
+{
+	change->old_attrs = *old_attrs;
+	change->new_attrs = *new_attrs;
+	change->start_page = start_page;
+	change->last_page = last_page;
+}
+
+static inline int attr_check_preferred_loc(u32 value)
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
+static inline int attr_check_prefetch_loc(u32 value)
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
+static inline int attr_check_access(u32 value)
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
+static bool attr_flag_type_to_bit(u32 type, u32 *flag_bit)
+{
+	if (type < AMDGPU_SVM_ATTR_HOST_ACCESS || type > AMDGPU_SVM_ATTR_GPU_READ_MOSTLY)
+		return false;
+
+	*flag_bit = 1u << (type - AMDGPU_SVM_ATTR_HOST_ACCESS);
+	return true;
+}
+
+static inline int attr_check_flag_value(u32 value)
+{
+	if (value > 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int attr_check_flag_attr(u32 type, u32 value)
+{
+	u32 flag_bit;
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
+static inline int attr_check_granularity(u32 value)
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
+static void attr_apply_flag(struct amdgpu_svm_attrs *attrs, u32 type, u32 value)
+{
+	u32 flag_bit;
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
+static void
+attr_apply(struct amdgpu_svm_attrs *attrs, u32 nattr, const struct drm_amdgpu_svm_attribute *pattrs)
+{
+	const struct drm_amdgpu_svm_attribute *attr;
+
+	for (attr = pattrs; nattr--; attr++) {
+		switch (attr->type) {
+		case AMDGPU_SVM_ATTR_PREFERRED_LOC:
+			attrs->preferred_loc = (s32)attr->value;
+			break;
+		case AMDGPU_SVM_ATTR_PREFETCH_LOC:
+			attrs->prefetch_loc = (s32)attr->value;
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
+			attrs->granularity = min_t(u32, attr->value, 0x3f);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static bool attr_same_attrs(const struct amdgpu_svm_attr_range *range, u32 nattr,
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
+			 const struct amdgpu_svm_attrs *default_attrs, unsigned long start_page,
+			 unsigned long last_page, u32 nattr,
+			 const struct drm_amdgpu_svm_attribute *attrs, struct attr_set_ctx *change)
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
+	attr_change_ctx_set(change, default_attrs, &new_attrs, start_page, last_page);
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
+static int amdgpu_svm_attr_set_existing(struct amdgpu_svm_attr_tree *attr_tree,
+					struct amdgpu_svm_attr_range *range,
+					unsigned long start_page, unsigned long last_page,
+					u32 nattr, const struct drm_amdgpu_svm_attribute *attrs,
+					struct attr_set_ctx *change)
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
+		attr_change_ctx_set(change, &old_attrs, &old_attrs, start_page, last_page);
+		return 0;
+	}
+
+	new_attrs = old_attrs;
+	attr_apply(&new_attrs, nattr, attrs);
+
+	/* only need to update attr */
+	if (start_page == range_start && last_page == range_last) {
+		range->attrs = new_attrs;
+		attr_change_ctx_set(change, &old_attrs, &new_attrs, start_page, last_page);
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
+	attr_change_ctx_set(change, &old_attrs, &new_attrs, start_page, last_page);
+	return 0;
+}
+
+/*
+ * amdgpu_svm_attr_set_range() - Apply attr changes across [@start_page, @last_page]
+ *
+ * Walk the interval in segments, each segment being either an existing range
+ * or a hole.
+ */
+static int amdgpu_svm_attr_set_range(struct amdgpu_svm_attr_tree *attr_tree,
+				     const struct amdgpu_svm_attrs *default_attrs,
+				     unsigned long start_page, unsigned long last_page, u32 nattr,
+				     const struct drm_amdgpu_svm_attribute *attrs)
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
+			ret = amdgpu_svm_attr_set_existing(attr_tree, range, cursor, seg_last,
+							   nattr, attrs, &change);
+		} else {
+			struct interval_tree_node *next;
+
+			seg_last = last_page;
+			if (cursor != ULONG_MAX) {
+				next = interval_tree_iter_first(&attr_tree->tree, cursor + 1,
+								ULONG_MAX);
+				if (next) {
+					struct amdgpu_svm_attr_range *next_range;
+
+					next_range = container_of(next,
+								  struct amdgpu_svm_attr_range,
+								  it_node);
+					seg_last = min(last_page,
+						       amdgpu_svm_attr_start_page(next_range) - 1);
+				}
+			}
+			ret = amdgpu_svm_attr_set_hole(attr_tree, default_attrs, cursor, seg_last,
+						       nattr, attrs, &change);
+		}
+		mutex_unlock(&attr_tree->lock);
+
+		if (ret) {
+			amdgpu_svm_unlock(svm);
+			return ret;
+		}
+
+		ret = amdgpu_svm_apply_attr_change(svm, &change.old_attrs, &change.new_attrs,
+						   change.start_page, change.last_page);
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
+/**
+ * amdgpu_svm_attr_tree_create() - Allocate an empty attribute tree
+ * @svm: Owning SVM context.
+ *
+ * Call before publishing the SVM context.
+ *
+ * Return: The tree, or NULL on allocation failure.
+ */
+struct amdgpu_svm_attr_tree *amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm)
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
+/**
+ * amdgpu_svm_attr_tree_destroy() - Free the attribute tree and its ranges
+ * @attr_tree: Tree to destroy, or NULL.
+ *
+ * All external users must have been quiesced before calling this.
+ */
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
+/**
+ * amdgpu_svm_attr_set() - Apply SET_ATTR attributes to a VA interval
+ * @attr_tree: Attribute tree of the SVM context.
+ * @start: Page aligned start address.
+ * @size: Page aligned interval size.
+ * @nattr: Number of entries in @attrs.
+ * @attrs: UAPI attributes to apply.
+ *
+ * Context: Takes the SVM lock and @attr_tree->lock; caller must hold neither.
+ * Return: 0 on success or a negative error code.
+ */
+int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree, u64 start, u64 size, u32 nattr,
+			const struct drm_amdgpu_svm_attribute *attrs)
+{
+	struct amdgpu_svm *svm = attr_tree->svm;
+	struct amdgpu_svm_attrs default_attrs;
+	unsigned long start_page, last_page;
+	u32 i;
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
+			pr_debug("invalid attribute %u value 0x%08x", attrs[i].type,
+				 attrs[i].value);
+			return r;
+		}
+	}
+
+	amdgpu_svm_attr_set_default(attr_tree->svm, &default_attrs);
+
+retry:
+	r = amdgpu_svm_attr_set_range(attr_tree, &default_attrs, start_page, last_page, nattr,
+				      attrs);
+	if (r == -EAGAIN) {
+		pr_debug("attr_set retry [0x%lx-0x%lx]\n", start_page, last_page);
+		amdgpu_svm_sync_work(svm);
+		cond_resched();
+		goto retry;
+	}
+
+	return r;
+}
+
+static int amdgpu_svm_attr_clear(struct amdgpu_svm_attr_tree *attr_tree, unsigned long start_page,
+				 unsigned long last_page)
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
+/**
+ * amdgpu_svm_attr_reset() - Return a page interval to default attributes
+ * @attr_tree: Attribute tree of the SVM context.
+ * @start_page: First page of the interval.
+ * @last_page: Last page of the interval.
+ *
+ * Context: Takes @attr_tree->lock.
+ * Return: 0 on success, -EINVAL for an empty interval or -ENOMEM.
+ */
+int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree, unsigned long start_page,
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
+static void attr_get_ctx_add(struct attr_get_ctx *ctx, const struct amdgpu_svm_attrs *attrs)
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
+static int attr_get_ctx_to_result(const struct attr_get_ctx *ctx, u32 nattr,
+				  struct drm_amdgpu_svm_attribute *attrs)
+{
+	u32 i;
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
+			attrs[i].value = (u32)ctx->access;
+			break;
+		case AMDGPU_SVM_ATTR_HOST_ACCESS:
+		case AMDGPU_SVM_ATTR_COHERENT:
+		case AMDGPU_SVM_ATTR_GPU_RO:
+		case AMDGPU_SVM_ATTR_GPU_EXEC:
+		case AMDGPU_SVM_ATTR_GPU_READ_MOSTLY:
+		case AMDGPU_SVM_ATTR_EXT_COHERENT: {
+			u32 flag_bit;
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
+/**
+ * amdgpu_svm_attr_get() - Get attributes for the uniform prefix of an interval
+ * @attr_tree: Attribute tree of the SVM context.
+ * @start: Page aligned start address.
+ * @size: Page aligned interval size.
+ * @nattr: Number of entries in @attrs.
+ * @attrs: UAPI attributes, filled in on return.
+ * @out_size: Optional output length of the uniform prefix, in bytes.
+ *
+ * Context: Takes @attr_tree->lock.
+ * Return: 0 on success or -EINVAL for an unknown attribute type.
+ */
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree, u64 start, u64 size, u32 nattr,
+			struct drm_amdgpu_svm_attribute *attrs, u64 *out_size)
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
+			range = container_of(node, struct amdgpu_svm_attr_range, it_node);
+
+			if (amdgpu_svm_attr_last_page(range) < cursor) {
+				node = interval_tree_iter_next(node, start_page, last_page);
+				continue;
+			}
+
+			if (amdgpu_svm_attr_start_page(range) <= cursor) {
+				range_last = min(last_page, amdgpu_svm_attr_last_page(range));
+				node = interval_tree_iter_next(node, start_page, last_page);
+			} else {
+				range_last = min(last_page, amdgpu_svm_attr_start_page(range) - 1);
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
+		*out_size = ((u64)(homog_last - start_page) + 1) << PAGE_SHIFT;
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
index 3880ffaf46ffb..94371118cbdc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.h
@@ -156,11 +156,19 @@ enum amdgpu_svm_attr_change_trigger {
 	(AMDGPU_SVM_ATTR_TRIGGER_ACCESS_CHANGE | AMDGPU_SVM_ATTR_TRIGGER_PTE_FLAG_CHANGE | \
 	 AMDGPU_SVM_ATTR_TRIGGER_MAPPING_FLAG_CHANGE | AMDGPU_SVM_ATTR_TRIGGER_LOCATION_CHANGE)
 
+struct amdgpu_svm_attr_tree *amdgpu_svm_attr_tree_create(struct amdgpu_svm *svm);
+void amdgpu_svm_attr_tree_destroy(struct amdgpu_svm_attr_tree *attr_tree);
 struct amdgpu_svm_attr_range *
 amdgpu_svm_attr_get_bounds_locked(struct amdgpu_svm_attr_tree *attr_tree, unsigned long page,
 				  unsigned long *start_page, unsigned long *last_page);
 void amdgpu_svm_attr_set_default(struct amdgpu_svm *svm, struct amdgpu_svm_attrs *attrs);
 
+int amdgpu_svm_attr_set(struct amdgpu_svm_attr_tree *attr_tree, u64 start, u64 size, u32 nattr,
+			const struct drm_amdgpu_svm_attribute *attrs);
+int amdgpu_svm_attr_get(struct amdgpu_svm_attr_tree *attr_tree, u64 start, u64 size, u32 nattr,
+			struct drm_amdgpu_svm_attribute *attrs, u64 *out_size);
+int amdgpu_svm_attr_reset(struct amdgpu_svm_attr_tree *attr_tree, unsigned long start_page,
+			  unsigned long last_page);
 struct amdgpu_svm_attr_range *
 amdgpu_svm_attr_range_alloc(unsigned long start_page, unsigned long last_page,
 			    const struct amdgpu_svm_attrs *attrs);
-- 
2.53.0

