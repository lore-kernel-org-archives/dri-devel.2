Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72BAFD8746
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED93A10E604;
	Tue, 17 Mar 2026 11:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zblg42wi";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFC810E604;
 Tue, 17 Mar 2026 11:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DREZijeTIZK4VGzrPBeAAKyippH482+PzqjGNP/7AdqZ/v12JmNiV88aXPSlKL8106+Bq548dhaKTf6iV1UdxvYi7SOI6JMm9nVdHiC7harb9gu+fngRDM/o6DYImkbmjlP6J+3abqMjqT4EDHeSAU82GFFLox2Pkwj7Uuesr4GYXLoQ2nd5yr7cUw6WWzkzqZAeZbFpL0uHiI7MRWBmFnnTstD+xn9f2cnYHdXp3xXjAeABA9l5AYYutRvKGuRwHsXz1DPkK+il092SaUsiN/p+fUp16OYQwIH64seed8bcWK+zyMvU/3VCM3R2Y+7U2xJXsgcunnAL6e4tNiG9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJXMHiZAby5/tBoJSEodEBfdBFeidyacDtA9+3Pm4ks=;
 b=HJZDNPkzBxwomA+1r+i8PnJg5R5gM6DsUhbNboENy+emMuPM+M2z4ecVAMxZYkfBk/oBU7zgDvfGw8XKa0br/OF/+d30jbRK5ErmXC9IrHVbhtZOCnKjvStGbHgAixXSm+PRqs/4xyJqr+Vnzs3d9TzQJl/2bOlVdLnovMmkEIoEFR9PO3d/FOvvHWdk46EpZuHTEHyrH9mg8Hx6ok68KRxgMLhhe0f4/Vql9qtcTvhBiikuPJl7NMZteW8icXGGd2v4jXkHC3TRSIYS/jMCpfgZ6KFvonKswxXxooc6+59ygr5nAF47rJsX32BhMZaae4XS7wPyfk3WOxiewjiFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJXMHiZAby5/tBoJSEodEBfdBFeidyacDtA9+3Pm4ks=;
 b=Zblg42wiYWZ7Lcni/x0wQcO31d0zJGlV08RLWIJYuxrW7a66IM3WkMkR4ufspgZe31AB2F1vCcvNcKx50+VyzD8eot1t+il0+kJUzK47fgIslH1qG6wHohIVjPH65QwQOSwCGHbjUWZ4c6R4eDA302U7ubDjHYnqgtCXd0rJsnE=
Received: from MW4PR04CA0214.namprd04.prod.outlook.com (2603:10b6:303:87::9)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 11:30:18 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::cf) by MW4PR04CA0214.outlook.office365.com
 (2603:10b6:303:87::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 11:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:30:17 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 06:30:14 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
Date: Tue, 17 Mar 2026 19:29:47 +0800
Message-ID: <20260317112958.2925370-2-honglei1.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: ccde9947-095f-40f3-8352-08de841890fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kjUG5K9+DuWqcXih2bezEt5RM4V+xPsvZczEp/vt6rMncHGOclZK6WyYGtTOB8FgRoVLNWuWaVfMi1C9u89J/LmZ/A6/DADMVmrnLxSbzjSXWhVZY7TrzF/BvVtF3oVw0BFwKbAoBphXJkDrHH5K5h/yxMF27upQ3n6Fmr2dsDIJ0sbtpKzl9yVeiq+Ci6C7VRLBJ8AVwINfUTUzCTB97n+C7zjINHEFLq357wIP8D4tTJzm1Bvhxr2639h0v0g5K+3+qT9m6NTrnoP6muRqcii4u2L0ozMQjD7U5V0Gy4PpI+vQWuWE8Rz3R9Oc6MnTAXeVH+koZwZNjlEQqIUVROUwSPKqHB3OKifd9YE+qj/utlAVPTspZR3Fa+vm8iGDHXJwHiwyTN/D65+3RPmt0MZQmCLVBeC5jn+i1/EDxZfhntTdPWJug8VPddHUxI7CssstpKRFHkZ3skhiMKqp3pA8P5w+f2qvyk5E/BpcyjjeNxSDbqWe2O9jteCR/BOaQ9LxcVi/Uf0ufNLxjjEjm3aq2s2H6K4kcmX8OWE3vBvTkvEvpffRl0pW5a+SamfVQle7kuLzkuB8oIf7nA9RJBEK9kV4gKW/7sKzxA7j4wXuqUwpfjYUiFgMIvsWCssxX4TO4vESmnEy5X1HahFjcXoZvFh87LW7iUNI8qG7fioejdHd/Fp+R6E2L6hY7CvzMKTyLyVXcOXyd877mfFdA44fKwu5S764rwVspGENW1WW/+2s57OJJ08iEfwRhrHJ1xzA8oAG0MxiSUAY+YFbd8kfqw2Jl9PadJb5bPRIRAQpkVSfgGzUZkxURMSqX6wF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /Cz+o5kJyFatRceilr4f02jxM8Q9sQZ2Kpca3FbtI9/siHaTX/DtQpCcq6GpK0Uf3H/ltnq4+NpHYB4QWMbUa84qYvYDswXPREIbtoqjBbOg0Mpo+3lLHQG1fVlJ4ZdoYBfV/iphrtU0k3T7ZrGTzOGvkx/G/6EtyFtmOCAmikeIEetGVayMjxR0xyiO2Poif0+A3gGlJbpWVUiJPd7bwMcfhISyfgbGYI+U6tzKkwQy23wXYl6o7MxMSR9wRtO4fJKBWHt+/AP3Jxcam60NLhirFYBU3XmPJcqwtrIR2/qiP2G4tKV/+Rr2usDZsUYTfDQarJqUmHqUqSWUPIJ7IA/0oUtD5rr/0z8a1We+ahqBLSca0wuZe+NxSfvD1k/hb/dWkf1mEclz/TZVN2Gcb4eC6SI4Zlqngd/JvRYcaPyZFqF7/Gpst68ZEkQj/T0J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:30:17.8278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccde9947-095f-40f3-8352-08de841890fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109
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

