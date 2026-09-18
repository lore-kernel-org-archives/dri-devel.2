Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB9C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC0710E821;
	Fri, 18 Sep 2026 06:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BAwOTABw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FC910E821
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vF9OydSnHl9uFwtvda7uZEnYq3gWGQAZKob8FlQA5RqKC/pmQDtTcJWe65dk7CiRwFNo3iUp1ElIQWSi2L7BBbMDqwFmtJKRususl2W488WXaQf+uvg4nTB2p1qVMHS05NQ+3Shm7s/yOgOwNKGqnhJ+b9QgInB0Su6FYgW9TMg/EoGTHpWbSSkwE7vpxnPT9P70YlHT1Vh889lo00zBCthDbWiuS4r1HiFEDJcu/pO3IISX7aBP5GZayoBV/rKbLv/caE47hE29GPqETQn12ff2WwVH19cN6FhYRgokPnS3IIUvnczvuI8ND9Ln0GFH3jFRWR3bYKZvERk4ncxPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0UtvNu0i/yixDuXK795+esTvfGBI68UI3c4EWL4lh8=;
 b=R2Gg867/Ex5nAFubjpKnKTKFcmur4taMJJvPxEJEtIYGXQnKboWUp3JD/naQ5UG2nvLcONgj70/Av02HG5l1u6UW/yVUS527sU6MqXXrNxpafvOeCjapmTmveBSb+LKLYBTIhwV2lTpzP0bKCf1aey3CSjtrDmXi7bdDJPq41CARAsVVDBy2480wufpnxiSMPKLB7Czzlyv4f+NGsLV1rszHmA4c540fw5KHgFGxoXwaCCM63zCNyP2wWOM3JOzECHFedr8TeJ3cF+eYEB5LrjQyroEsP4GzORk4NkKjwZ4kF+613WzPmu3rrDX/ZCmXMGGIb+lreyst+bM7JWejcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0UtvNu0i/yixDuXK795+esTvfGBI68UI3c4EWL4lh8=;
 b=BAwOTABwPlneP4am1j4KIv4w9G2M7nXnksSkrn2mIXvphQy//rPkUorcBaQQem05V9IuZa5+qEsjUcVkhEeAFd/PraIZEg/EslHRZZ+3G0g1fIxfmsZYmHqL5biIWFSeszllIsulpF7Op6i6Ww4/HWKe9E40UGJebKSW9jhqVmU=
Received: from PH0PR07CA0033.namprd07.prod.outlook.com (2603:10b6:510:e::8) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Fri, 18 Sep 2026 06:57:09 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::87) by PH0PR07CA0033.outlook.office365.com
 (2603:10b6:510:e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 06:57:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 06:57:09 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:57:06 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 2/4] drm/virtgpu api: add blob userptr resource
Date: Fri, 18 Sep 2026 14:56:51 +0800
Message-ID: <20260918065653.2170828-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918065653.2170828-1-honghuan@amd.com>
References: <20260918065653.2170828-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DM6PR12MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 9055ef80-fd00-4609-86f1-08df15520ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wFZPocuDSRDy5cEBnEInfBpxqB53r2Cmgdy8KyLp3d2DUPezV+NnfLBxVorrYa1WoyXFbiDgM9Kc9OgNQXlfPre35cuLclQfKo3Ou3W/UBGT6fpVoALdOXqyoLYmjtW6WU2tp1u+A5YsYcbbSug1GHCHYi34tivURcM15642Nc7F6/6DBeeJKdVnTOti8utysFTyq4+EyK1nFSzFDQsyJGg2AM++Z15ByWVPzb1E9G72PQmHsbRkX7GjAu7dtICegrat2bp6knt9Q0wqJytue5emmuhmpcsPnfnauYpf78iuHHum8y7SwyHTAnpqapsTeuw9ydaXPOD0JM4+n+IIduOIer894DF86JNYNfjj8j3zTgPre+yaFqZ1rfMCvZ2dpBvrvjJf3tRA/X977+whc0IEmtymAtnyc2fx9UYgybp1phjkmgz+CxUQCnlXA65knlwGoiEnXbd+S2mxPfT8Gi7V1knDLI3Hu2dnI2LkhgH9iAb8PAFnMXhGpKSMdIAXImV4SnGCvzqxmd4uDxvyIV3e8JVFeOch6x0N8Yi+MB7pPlhYxvMOkwGuQdLFj833aA+zLAQXPPVgRT/1VcQAFTubg0Vh/HQnCQ9ZjpU3HURAf2sJDmlNl7f6LNsJO2nyCN8DLAQAbrtYpgS2zsj/iUrALzXz5VrABdY1lKLhDuhv0NB69Wy08G7w0KRCQ3v8LFhnEZ1O6mHYDB1yD5i6gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: htZ/7OXZKOmJ31WWWOjOhepraBdlPuwMreXD7be8aK20FnDdmCeQqHPxg+RDsgBhwHO2xkjYlvNTyMN3Hjfj4bC3k/nlpe4x30/Vb5xhjKMMQoeRhav3sM/Nmpx3drB22Mqn2ixYsBMahk0sW6pqUjyyx448RFJ6nBl1iSPLmnTF7a36yM8IetXHy7D2zPqBtDrpMCPQi8kirWTyXsAWlbIFziBClmcHyWsOETzGNpM+F99mOTNWDGmrT9uz87xuWQMydBjlI0nNRM+pmipJpATTP/+fY1/C/cC0Bnky2vIe2V+eXDWNpjXsPcrGjGqUjhq//Awx+rA8N8eCg4DbwuJQvT+kbYR5sojKdHp2VuoEGqrxF9b02jpJN0QlpbXKcpVKPC8SilFtNbH43m3O7uHO5tg0ALz1XxlG5UxuhuTnVUcSlqZ51GQES0nKe8SD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:57:09.0020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9055ef80-fd00-4609-86f1-08df15520ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
resource, and the guest pins without FOLL_WRITE.

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/virtgpu_drm.h  | 10 ++++++++++
 include/uapi/linux/virtio_gpu.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 95587e12ae..5e2a7ac1aa 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -99,6 +99,7 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
 #define VIRTGPU_PARAM_EXPLICIT_DEBUG_NAME 8 /* Ability to set debug name from userspace */
 #define VIRTGPU_PARAM_BLOB_ALIGNMENT 9 /* Device alignment requirements for blobs */
+#define VIRTGPU_PARAM_USERPTR 10 /* CREATE_BLOB userptr field is supported */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
@@ -186,6 +187,8 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+/* Wire flag: device MUST NOT write. Guest pins without FOLL_WRITE. */
+#define VIRTGPU_BLOB_FLAG_USE_READONLY     0x0008
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
@@ -205,6 +208,13 @@ struct drm_virtgpu_resource_create_blob {
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
index 3d4dfadc9d..b765ff9aa9 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -415,6 +415,8 @@ struct virtio_gpu_resource_create_blob {
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

