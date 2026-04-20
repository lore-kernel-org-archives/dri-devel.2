Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5781F3ED74
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38CF210E52C;
	Mon, 20 Apr 2026 12:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EK4ll2CK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 454B610E52A;
 Mon, 20 Apr 2026 12:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdQE7iWRBnoadTkH06J5ESJEGuQijkA7PwJAFIu1eBCXTUYX5PzwR1NOftIfyMtpbpz3lSQcXfbffXDXFdhFVgcSBwZYhrsFS3gkl+JA0XMofV5zSJ/5IBo+bCtO0lNRxU56M0yNZnZax8vFUcLepQxRXOXzvaIWAgkJUOmDLKlpM1XF5ALN4hpBGclRUw1yDPGcp/w5Q8pW4lL8icAUDNhqlj5+OpEAeSpCSK2tvBnvTwl7gZeWTX9h4jTlXWgjON9X2afJ1kXjpGRHU8AkvRWv7n3SDjOoXJLMHxADhPTXyGu0I9onP9VYvqZWDL7foHUzlS5C3P6SuEjtasWrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJXMHiZAby5/tBoJSEodEBfdBFeidyacDtA9+3Pm4ks=;
 b=xTVV0SBa638L8d45z7B1laJA3MkC5scCWHsg5p6f2ihJ0bl50Mn7m3FdqIloayuxA/i1QiIEanCJlSDjaDFzu/J1VxBXyJkvujVs6+fHkNS+cMnbvmCNJwbKit5axn06zWYhsoYcofzZBfLqbvop6SFhxnM6o4WIWrm52nAxYdGg5SEjnOzEtLI4wtVM6/CwNMIXAqOmlaHaWCphwheqYkq7mLsbJ+LJ+U5kBBw/+MMhzfPer5KtV+OFEb/Kog2gU0LWDTrTTncVXrRM6LTYSZNYSVBV8v7cih6X6qUAPJ8YdbSrWxXSD/mebdWXONbR5sdn9L0u+ElrvA0yA31RAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJXMHiZAby5/tBoJSEodEBfdBFeidyacDtA9+3Pm4ks=;
 b=EK4ll2CKv6P8+dqEk3Hri3PsNfpzyrXZN2tsQVq8Enih8G3+0RQyxPAYcseViPaBr4VTvnVUe05ldfVdk8ZW93qI398bpIrjNkMEjKJhISTLUOU/568dY98rlwrPGOLwbIdhozeernVX8pV27d28s0MVicTbCpGKSl+OjBksmN8=
Received: from BYAPR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:40::27)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.8; Mon, 20 Apr 2026 12:08:05 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::5e) by BYAPR04CA0014.outlook.office365.com
 (2603:10b6:a03:40::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 12:08:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 12:08:05 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Apr
 2026 07:08:01 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <matthew.brost@intel.com>,
 <rodrigo.vivi@intel.com>, <thomas.hellstrom@linux.intel.com>,
 <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
Date: Mon, 20 Apr 2026 20:07:28 +0800
Message-ID: <20260420120739.1811731-2-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e6f357-1dc9-49ce-7bf2-08de9ed57a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BrCWaq4Rk5jtWjt7CDmBhXLiFwn48HlJMfnKq8FJot6AdalVgsUT8fKFKLlEhJDj1B+pSWQdRA8E9FPrFoGrTLXCArEJlLMKcLu2Qg2DgkUsb/k9zFZlT+9R6JRptPKSRDOpi6Y9/qpqBytUlvp8g43aQuRmmc4ZBatz5GufBiKbXFMPs3gK+0yrqEQ3R5hK42mgfKjbTVu+rNcygCKs+1oSD6MsAIaKL9MCo5WPPUrbQ7So+Ols9r+95yBnomYAeTNs6mYXYZ3lhy4oSAcUso03nul1MohTI2UGSvzXO2YMMJTfCxQ8DpYSV/39bEgWOr8VVVwLLKu1d126e7FAo3YomyNfO2jDCgsGBXJ9z2fK8TQOXi+7yNO8PztVJYhUfBDqQqBktA2KME+SalyHHGEklo2oKkGC9KNN7bWFGuz5OUad1MawbSsKAOLnGzrFhOYhepRQbJN4Ue6BiXs325MHGUIN2U+0UH0YozLDp9N0h4rLBIt/qdKOy92vIzJLCK9P6NTkoOskPMxcEDoz7Yk3Ta8opPIWNK45YVfJnnTOYcpcehw6OZDhBif/fyk9t8FnJg5b8yxa1GKsaU2ESoya3Xd+5QvyeL0XiV38+yS/0DvaychM8XJQ1Fn5X9irD0tETc3wh7Q3kQ8WulBGi6SIodVFqtvOdG0Jz5qApDZzDbXS5TH2DKyjy52eWKCKQiJtH2scBVntAJbCT7+Xc3S8cFHqcPZEqhKatEKPlPSXo6ju8jWVzKRsX5+xPdUwGqMEzn7a50+iXvt+UjndgcIyj8FTguNvqo+ziVimjV4mVlXzSMsx+lAyYcB3I2vn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wVgoPA9hJECB0JCQXQ3dqIydej7Ya0llDJ+XncIEYfVokW5V8Fb7NQ/aIHoN7ysjHxRP/c3+rmcBykmmk7fIfSadF4jBjEIeTg6qjMf1nDzxvJt4EhsVW4nwRqWH8C/2uY7Va5ONDc6Kyu2iAIEPKgxIig8tBaX52jp9pDaQ0WoicVw2teiqsxfgkoZhKBGVGjIfNd5/dDcXrf/NTEwbum5/7rqvwh1WONDLqDOG5O6ksCdanU2Sp4C4FVqcYwUVBGRTo95GpfMcQ6lu37Er2yiDOTlXwzM/dcPYZp2++4MA2BvQF1LC+JxUu8Ma3vlmc7jBomOmHLvGQqdcwu8dfOpbYStKCiQXjcRcYYlT9POeR8mNE9xa61y0rNItdPlmsZqzCXEFMvrg0Pr79g1H2f0UumUcU0mm/qxjNNrqGhIAWqSAkOYL4BpK22N80t6U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:08:05.4149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e6f357-1dc9-49ce-7bf2-08de9ed57a94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

Add amdgpu drm SVM API definitions built on the
DRM GPUSVM framework.

This includes:
- DRM_AMDGPU_GEM_SVM ioctl
- AMDGPU_SVM_FLAG_* flags
- AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
- AMDGPU_SVM_ATTR_* attribute types
- AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
- struct drm_amdgpu_svm_attribute and struct drm_amdgpu_gem_svm

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 406a42be4..bed71ed9b 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -58,6 +58,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_SIGNAL		0x17
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
+#define DRM_AMDGPU_GEM_SVM		0x1a
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -79,6 +80,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
+#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
 
 /**
  * DOC: memory domains
@@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
 	__u64 matrix[12];
 };
 
+#define AMDGPU_SVM_FLAG_HOST_ACCESS		0x00000001
+#define AMDGPU_SVM_FLAG_COHERENT		0x00000002
+#define AMDGPU_SVM_FLAG_HIVE_LOCAL		0x00000004
+#define AMDGPU_SVM_FLAG_GPU_RO			0x00000008
+#define AMDGPU_SVM_FLAG_GPU_EXEC		0x00000010
+#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY		0x00000020
+#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED	0x00000040
+#define AMDGPU_SVM_FLAG_EXT_COHERENT		0x00000080
+
+#define AMDGPU_SVM_OP_SET_ATTR		0
+#define AMDGPU_SVM_OP_GET_ATTR		1
+
+#define AMDGPU_SVM_ATTR_PREFERRED_LOC		0
+#define AMDGPU_SVM_ATTR_PREFETCH_LOC		1
+#define AMDGPU_SVM_ATTR_ACCESS			2
+#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE		3
+#define AMDGPU_SVM_ATTR_NO_ACCESS		4
+#define AMDGPU_SVM_ATTR_SET_FLAGS		5
+#define AMDGPU_SVM_ATTR_CLR_FLAGS		6
+#define AMDGPU_SVM_ATTR_GRANULARITY		7
+
+#define AMDGPU_SVM_LOCATION_SYSMEM		0
+#define AMDGPU_SVM_LOCATION_UNDEFINED		0xffffffff
+
+struct drm_amdgpu_svm_attribute {
+	__u32 type;
+	__u32 value;
+};
+
+struct drm_amdgpu_gem_svm {
+	__u64 start_addr;
+	__u64 size;
+	__u32 operation;
+	__u32 nattr;
+	__u64 attrs_ptr;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.34.1

