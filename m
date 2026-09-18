Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D6CC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D82010E878;
	Fri, 18 Sep 2026 08:23:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T9C+5u4F";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A15F610E861
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NxQ/zIKNwUsZx1Rz7OOFshERCaSAlM6dSMEb2JSK/D+u3U/6T7N8AtpCIQZnnKquGt/+EgP8azXxVCERr2GCIg4WXftJF5IpjpX3x09Y7crORLZCsgBUCopI7DPw7O9Z7c5jA3HJlziCOBVjf6h5Yy5KaBJOOvwhXNK/R8nRR/TjJQVEZXKjf55l/pPzIjq/MQTFBQszbWfCvkj2vCVZAx2uqAq3NuCToOMaILgK8bGguGmVqXCLZcx9rS7gn6jvxYGaAOQrdGMFUA9t1nqERE+8oOFAzUrUBN5ypNGdxPjo+KqJEKXWfNuJbNhaTLD88a3TUvyOD2pIy6hmrFB9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEd3Ws1ZJrISbTEwZ1itvhZz4BbQlDtfOlJ4JlqZyxE=;
 b=F3LljaQLwGswT7fGtiCpKBwSGitDfx0VVxQBrJodIqXVXkYV6ivZAavL5VhaS8s2oOqcNvUyZnIaL3bJ2Mlt+luVM417UHfTbQzMRdDAErZmhBToSMoIZbe+QusS1SBh0cZ+TkOS9S0JC+uEX781QlgxVDfTQOEAmXlzNV99qgCNcE08DV5UT3I43aTmsXPreV3GWSy9pUE9Sf/iTYalsgOs6kXC3PbNFq5wXujCds89QbiM8d+PeC7vB8IkJ1yEovwk2ZgCo9urSrpPDghfVTknfRPonrWrPTYdgvZuwVzvOrd1gaOiGtET5GBiL0koYvohqbfcRO4PrUF/N4n+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEd3Ws1ZJrISbTEwZ1itvhZz4BbQlDtfOlJ4JlqZyxE=;
 b=T9C+5u4FU/F3TK+x3oVNcowXADSkoVG2a6XD80Dct9ecN7c4eIjVzFh1S5MCPaF/WuJ3i29gz8nr1+Ke/OsKMbtQoj8Ack0XS32XiETXt/WYNZmiUR60Gj2afngVVNU6Qm/JiwSpYOS1cUEGwEgiBedbUJCKiGGGt+4Ntvu8bQg=
Received: from BN1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:408:e2::30)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 08:23:27 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::4d) by BN1PR13CA0025.outlook.office365.com
 (2603:10b6:408:e2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.9 via Frontend Transport; Fri, 18
 Sep 2026 08:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 08:23:25 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 03:23:23 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
Date: Fri, 18 Sep 2026 16:23:09 +0800
Message-ID: <20260918082311.2213619-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918082311.2213619-1-honghuan@amd.com>
References: <20260918082311.2213619-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 2519afdc-a485-49be-ec8b-08df155e1c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|11063799006|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: upujH0mJh+1s+ijyqXoRILBjp7FIA8AvE8MrPnphFmkn3x9bKOpKLK5T0VATOPDsJfWHQ/0gCv3cO1dcU91yGdJ7bSWqalR4dloFhgSX6aFTP+RzS06SElqNHOVJh83y7hHqX/LbhDSwTq2X3eoefrYtRMzNQXNCZGjeUZmYUnMzzDH2K9LTEJyzhO+sa7PMkwdulvDZCWMFznlqDHgWrG/nFF+mIyW2uh3aWFd4lv4ld3wYkP1HskwBpkDO/ZpCStFFnfdPWNkQx92IdDQkLC0Cwiy8MbwYWQgP6yCBMniK6wodhK+0fxS/wBUI5tTQWVJbCfwdk+QSZrUqPlPfQG8p2Zor0HdABqcxRAPf+Zx+IPuo16xATQx+Oh/m4s0hs7NUNQQxX6TyCMDOitWrzJWrgjVfi5eq36BDmjGGGX3t58wX9a0nl1JV/lLHFnVDmpgTZ8KSsf/UpCe8RxgYiTEw7yD6N+BwsXoofR3WK0YtJ7+bipsz21rKcytL+VtqRhnVDE1ONS7/p4RMuPBNfKhkHqq445c+Em+GR7xWNV19Qhvn3BMrK+88F3y/KoC96BgmccVwI61O0wEyy819bR14H/pOnIG0AHzvzpv5l6fWXmxlaFkh4UCV6yNgVafaLluMspd+iDAq1XnNWzI8UASW+tFPCCdUt+53kjCrMzKu0yiHsD8PTpJ/fLq18cEZ4YYUA/9+NOWixkmyQe9jCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(11063799006)(10067099003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tvHr+s8ZGCGSxbePWyP2TSarVBSrbyW4j0TgJIMQnqZ4O++eFv037spgI5Y5/rqi08SAmwXgG4W5C5OHlm1qkV08vxiUELTg2gRjG48YxTj+BVd0uhoTP9SwbQPxsUX4EbCVrIfhttV2KfA5h5OsrHUIPfec3W2I354zzoEgYEaUn1uGl6QDNOkgTkXWDsQXv3edsK6xMZCFAJs1j1e/SBuqmQP+CtcsCjachGkoGp/+qZb2R/n9gWckzkKRhoxyYYrzrdXCDKnsNGoWjF0eQ7d92pRQpFyzLmlF9GgNhGIr+Pag6xknlsui8y9iz+3Mpyx2k2xBvT17tBq8k4XYu4DDBNRSLgDt8z51M6uX4soYLGreY3PmMrXChkKOpOg7ZfphKFJGm9v0ZmOWuTDYw0kTWv+xABRVL3NfRtTZB5BJkPIDNgLUm6rp1nnPexDm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:23:25.8402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2519afdc-a485-49be-ec8b-08df155e1c7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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

