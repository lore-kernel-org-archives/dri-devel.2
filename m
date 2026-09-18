Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE3C982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86EF10F259;
	Fri, 18 Sep 2026 07:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ovqr1D7/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B49A10F253
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyVpcpaK7n1fayzIcjSBMYSe7ENxsA64PdeIo3RSJJv+pkmUwremAYfjS8o0yFDON/mJtbmKivprWpgRQFibNT1ts4Oehh6aeUNS27aFowbcIowEEonK1PbOlJjmZQ7ppYBZxE4XsBzpLdSqILHBdUcevwHLwpd49TcfdI3oGHfHoUc1m71Y+kXBrqLaAwf8R4IDIuyMbF7ZbVaqrCOY3TIwfX224aAfrAkcBBCmLfpsEtiPKyXbooOToNfwlyDLSeHRdcrDMUMeuRcMI7bu37WI5bu5CAQhWjp1jFhR9Jfh2I3Rz73pARNwz8F0rOo1hHwicjn5p7ClvRlxtwvK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEd3Ws1ZJrISbTEwZ1itvhZz4BbQlDtfOlJ4JlqZyxE=;
 b=qFEBKZB9hwEaghqYwyiuuWol7nOLkGfh9Qw2MgLWFRpmzd/7CDxv/LsbwM8ElAXKqG/IQtkZo8wXx3TmvsaaLMuKucGWr9g5b6ZJkAfzY/m9aV+NX9x3zE06zbu5RE6MYhWCmFvGQA0W0/lzzsug/kLHtiC91GVMbFUS23nx9rAC2MHCYXPdsuB3FuDxYHjUXtGZ+vxh0Uj1AOwxXlEygoXZG+718xBU0ZpZ89WoMKG5VSrwzZVwGfJUxPazomTaOPk2wr9Yy9ZXjzqT0+g7j12LIAo8eeFVHWYZCChKqvINQUKnTnUQe5VEF1t+Qf9BF/tI+mi3dJdWjs58Kv0JgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEd3Ws1ZJrISbTEwZ1itvhZz4BbQlDtfOlJ4JlqZyxE=;
 b=ovqr1D7/JsG/4V+kXms3RSm0C+mpu9tzUj1YVnAsMr1Ei6SEpuqXmZ7+xUnGXSGRGyDCxNAf1iFDHIg9C2gB9d0E37uM7ZHcR5HS/Ux0hDXgYIPbG6xI1W6YS+iVBJ9wmfdMjWZzZnns1TBtyqINyC6BD3TDD7K3A2hdr60E4RA=
Received: from SA0PR11CA0019.namprd11.prod.outlook.com (2603:10b6:806:d3::24)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 07:56:16 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::82) by SA0PR11CA0019.outlook.office365.com
 (2603:10b6:806:d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 07:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 07:56:16 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 02:56:13 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
Date: Fri, 18 Sep 2026 15:55:58 +0800
Message-ID: <20260918075600.2197253-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918075600.2197253-1-honghuan@amd.com>
References: <20260918075600.2197253-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: b96b902c-7d9a-4ba3-76b4-08df155a5114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: xjWxbyz0dtGwrgw/1qd3Gz2Kmd2AtNrQVoQEwBrdBIh8ScM5j8h6FEWZncecjeTBWgPuAKa2IG/lLw6Ij5WDiV9L75wh10iq0bf4HtpVJmp2Lwjy5IXNjQ6CaR6sADJvOPCPF/+kjoZWUPfn+B311PsQhtCiebzK873cBw/IXbBIm+WfiKHaz7oKOGYicvAHVkRzNU867pP2CbGqRHcMBDjHsX2Ouq0A722QI7IJwF/ho2Xcoh/yvPPpXFAfMhHTfE6yfpx3aIvG/G0OtdaNPq4Z5WbEuYvs9p15LjyNidjnLUK/8rdLetTdRibH202TDFREp5MhOLL/oRDFqYvvBHQY4C4KF1LPPXqsOCeDH37CGUyCW7TL58U1ty/mh95DaLr7il3pqJRUXbMh+vU1+A1F3/fUD50fHsrjXsdEacx5ncV4B4dRljVknOWviwpcEljwkur4dPg72CHOIIav2iemvJRQoGXvg+Bc6bPNNQ+Qa/ylzpaD/eP8Hh7IsdZrnFreWHJmJYu3KG7UnL3Px6wCCtKRLHaR4agH2K0kgp7LltVwTl/YVu9c3Teur0Ig90m93xpBrw9RMSjFRRlQ/wI4a8sLI+GqE+gBGSoW0FvpjGV08skqTsflPbPO0C5o9gzPnNiCtAvWfAQ0iB41KDhinzqZNen1r6UkfkYdaWSyViVq2hAW1UgH5dN60klQ4XtVqVjS7CqsoqcnvxUnbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7YDKE8LMEtF5cKY6hmLwWF/zQ8iV63RVMPdSf/hi48qg+A6pjJ5YXkPIyZ7AGsFkHJYqvwVPvAHZZmmsEtfHQKk+QX5RfjkHtmohPvKdKmDUanGyXnLR3VjLuGhpMykxRSv89T8Pk8GIxKbgOuFOOc44Sqvv/IPxGVqtMZ6BVXOSTGelUCBj2XCP+rwIzK4QtRDlN22ou/9yBNP+hdySFEzHPVoNzpC+PjXXnHLRHChaoL/kcBGUKvFk51RGJLurVbGin0cVjd/hAjEP2ACF8IBtP3gh25ecJ3OMWKignctjr1zYbYNewx9t7YgD4ZgacUDFrqLvfJFt+ZZljJOKwt1a4AKmg4F8gENtIC1XE1D4n1JarWW13kBX2hCw+6Y1cxrioKegI8hlqNn68TEz507MidqFwi+7iE5+pMESfgTG3Lyvjn2zZk/O9jM5fzrO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:56:16.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96b902c-7d9a-4ba3-76b4-08df155a5114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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

Add a userptr address field so userspace can request a blob backed
by an existing process mapping. A non-zero userptr selects that
path; probe VIRTGPU_PARAM_USERPTR before using the field.

GPU-readonly backing is requested with the virtio CREATE_BLOB wire
flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
resource. The guest pins without FOLL_WRITE only when the device
advertised VIRTIO_GPU_F_BLOB_READONLY (VIRTGPU_PARAM_BLOB_READONLY).

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/virtgpu_drm.h  | 13 +++++++++++++
 include/uapi/linux/virtio_gpu.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..80f73b3276 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -99,6 +99,8 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
 #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
 #define VIRTGPU_PARAM_BLOB_ALIGNMENT 9 /* Device alignment requirements for blobs */
+#define VIRTGPU_PARAM_USERPTR 10 /* CREATE_BLOB userptr field is supported */
+#define VIRTGPU_PARAM_BLOB_READONLY 11 /* VIRTGPU_BLOB_FLAG_USE_READONLY is honored */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
@@ -186,6 +188,10 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+/* Wire flag: device MUST NOT write. Guest pins without FOLL_WRITE.
+ * Rejected unless VIRTGPU_PARAM_BLOB_READONLY is 1.
+ */
+#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
@@ -205,6 +211,13 @@ struct drm_virtgpu_resource_create_blob {
 #define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
 	__u32 blob_hints;
 	__u32 pad2;
+
+	/*
+	 * Guest VA to pin as blob backing. Non-zero selects the userptr
+	 * path and is valid only with VIRTGPU_BLOB_MEM_GUEST. Must be 0
+	 * otherwise. Probe VIRTGPU_PARAM_USERPTR before using this field.
+	 */
+	__u64 userptr;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 3d4dfadc9d..33f5332e59 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -72,6 +72,10 @@
  * must be aligned to that value.
  */
 #define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
+/*
+ * VIRTIO_GPU_BLOB_FLAG_USE_READONLY
+ */
+#define VIRTIO_GPU_F_BLOB_READONLY       6
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -415,6 +419,8 @@ struct virtio_gpu_resource_create_blob {
 #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+/* Device MUST NOT write. Driver may pin read-only guest pages. */
+#define VIRTIO_GPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob mem */
 	__le32 blob_mem;
 	__le32 blob_flags;
-- 
2.34.1

