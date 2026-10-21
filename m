Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E493606A323
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UxNY+gII
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6301D10F880;
	Wed, 21 Oct 2026 02:59:48 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B6B510E5E1;
 Wed, 21 Oct 2026 02:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPv4oj3W6QqLZ0iqXaF8s8gRb7B+WmnQxFYWmSi6u6ZTBonoVN28OkNc7OKidVE+rYUuFp9AvBIGrZdJNYvWWB/CZEKg/n2knOETZILebVKNCLjqsry2oHpb2sBn+/rFkXVRlMQGNmRn30djHVu9bC+n6W+gUjNmelpS0PE6q4bedTyEj44pe24HwbABH1u0AIpnugJyKylf/M8Z9j/mEHNXCqpdKGlxJGOmuWR5uuFZYVJEwEnBbTB0CiEReUJG3WUkDRQ9/V/h4ih2vXTsOYVBV6lwtUjlVIU9AjWbRL2GiIcgQ7XrAgVewQjm/uZaiRMg4t9aX4p1u22fA558Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imYtSMNPObDkQUdCOCgpGSvFwonnWlETmGlJhd8JyUY=;
 b=vWG9czok5o6B75uVndoQa03LBzQmUeF8Vw9wmiz7bcc9EyIrFZFKXbkqb8nXyR7cvww7ikoNCHZ3hKRiapxebQiJwxNGL5ettPLJZzGKKEZm5AmFQ2SYB97F16pVGZpWL888aig9fVo4zZeqgfsO2kwBWIyrf205mcdT23bXwBwJni+v2+K9bff8y1nTlU/+FfMyeobC/ysJcVAsvRmYC0QeNBbDrjxXu7vTNWFoSN4DsA2A1chfeX4cges/RUNlB156Zpy0I0zEkJiTGAjJaz3YuC26Z0gttI20NGd46aP5mgjto6rpIePKwszrUJRk1PM+Q0S1Rm01xuh0x8G2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imYtSMNPObDkQUdCOCgpGSvFwonnWlETmGlJhd8JyUY=;
 b=UxNY+gIIaBc7ME9vy5gX9LjZBjbOYMYV+23uBM86o7IbzSb0KTsMPphIph84os2Y3Y9mdDFlYFuEtkznqo8dyUiJ4rBLT1A33aHzbO7lpY65thPBlhn9/6NTpoLbN0dqzhs3q4PXWsSy8wpHWu+HVs0ieMOwqsU5AgSt7/4PpDI=
Received: from SJ0PR03CA0159.namprd03.prod.outlook.com (2603:10b6:a03:338::14)
 by SN7PR12MB6840.namprd12.prod.outlook.com (2603:10b6:806:264::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 02:59:33 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::27) by SJ0PR03CA0159.outlook.office365.com
 (2603:10b6:a03:338::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 21
 Oct 2026 02:59:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 02:59:33 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 21:59:28 -0500
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
Subject: [PATCH v10 01/22] drm/amdgpu: add SVM ioctl UAPI definitions
Date: Wed, 21 Oct 2026 10:58:40 +0800
Message-ID: <20261021025915.2433837-2-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SN7PR12MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a2ae4a-a49f-4ffb-952c-08df2f1f556c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|56012099006|921020|11063799006|261009221227099003|10067099003|261009220027099003|261009223327099003|261009223027099003|261009221727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4ogc9irtFrtq3Z4BvSMJw3hIwDHTA1/ev0w9IeHwo5jWdpKQCcCj6J0pOTOByJ8ZogQGv7gp5FYIfhlczxhQvhGoBgf6fWP90nrVI/jTuEoVacwDnkhEChXB02xBCM7P0yu0SQYII6ZYc6juJLXZjabg2dUbECM5ISxHuPqy1Kf3w3W8/X9VViWURr4mGRo535WEB3F2zDTiz6P/eSzAOEBxVvrDdMr62Ktaj79bOkfibUFr58RUpiEr/MhXW/or4Eru75vhTUePUEJqKvfIEz8eNR7yRBzDoOJMjwwX0f05dNRpEcVchio3qTUoSnfcHXFiwZJALes8YQmtmutfjc40PE6TpgWH4H4qH3zYHxrGP9V2xyuRZ1HDn4wdA+E36ljxZM8oGM2fbfL2slzk2EEngw+iLwPaAW5kAuuaip8SkBkJGGrTKOrfcH4QjKFAA3MXJmwQXyDc3GYV4eiL7CopvxvoXANzAKMAP6mUg3AH1s1RjpI7JY0/gMOsHU44Gi/hKWOLOXHF4RUH7merPvt2+sa4s+Rb1Tmz+5f7YMqs422O5mz04EslNIT1OuU/h8cPzWaX222+zY/a4Y1ssOYd6j1IKvxPfVuV1ifCASEfEA6Kn9/XbCIzJmoHi2+WDD1Xtcbk2F9lbBGWkQ7priwvvZBIU1wV51xl2+j0YLmwynWeTQF7nmoYPKq8r88GPWCJMI704mUOcrmobN294qfatWKi0fvWy9OqdDgWgxL0yaiEgia0iuLGHf28g/SZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(56012099006)(921020)(11063799006)(261009221227099003)(10067099003)(261009220027099003)(261009223327099003)(261009223027099003)(261009221727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bF5jBYCrz/I8f34FZcSOK2oaRmKSed1UBCbPfXvPFSCudWMyRhFjndyOfVAzITXXZv/FUm5KlDfOD3ejSO993FrHfbuclktAdMHNe+P/4msA8zY6Io4IPLQJnewXNi7Lib2xbkAQTuz1ojw6Uq2us2SApGEoBDtL3KRENkS9RYaGL0939A39ToOj+L7p3ARugdsKKrEdiJWdi7ebRIbcFKLwu/wKWeCHiQjIQrIgYMI2Ur5Mo8gKkkEgGx82Dp+d0nyP4djWs9ClvD/BR8n9hmkJg3ZxaBDKpZBtR9Aze7ibM0DO8LJgWiYMqBhUS8r19AGQ3CauTPcmIjDr6qTPm7ggI50jQLM8d8JATIjlslgREv7gQK8vhwt2gbfOD3s3V/0ezWvjaqxFx+31sp0PaDvSyc0jbgZUWVZWb6tdamuNofP68+jGetcsbB2PoBxn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:59:33.2314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a2ae4a-a49f-4ffb-952c-08df2f1f556c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6840
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Honglei Huang <honghuan@amd.com>

Define the following ioctl structures and enums:
- DRM_AMDGPU_GEM_SVM ioctl command and DRM_IOCTL_AMDGPU_GEM_SVM macro
- enum amdgpu_ioctl_svm_op: SET_ATTR, GET_ATTR, RESET_ATTR operations
- enum amdgpu_ioctl_svm_access: INACCESSIBLE, IN_PLACE, ALLOW_MIGRATE
- enum amdgpu_ioctl_svm_location: SYSMEM, UNDEFINED, LOCAL, HIVE
- enum amdgpu_ioctl_svm_attr_type: PREFERRED_LOC, PREFETCH_LOC, ACCESS,
  GRANULARITY, HOST_ACCESS, COHERENT, EXT_COHERENT, GPU_RO,
  GPU_EXEC, GPU_READ_MOSTLY
- struct drm_amdgpu_svm_attribute: type and value pair
- struct drm_amdgpu_gem_svm: ioctl payload with start_addr, size,
  operation, nattr, and attrs_ptr

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 127 ++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index cd1b8034a2fb4..cfe463f2114a1 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern "C" {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_UALINK_HANDLE	0x1B
+#define DRM_AMDGPU_GEM_SVM		0x1C
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -83,6 +84,9 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
 #define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
+#define DRM_IOCTL_AMDGPU_GEM_SVM	\
+	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, \
+		  struct drm_amdgpu_gem_svm)
 
 /**
  * DOC: memory domains
@@ -1735,6 +1739,129 @@ union drm_amdgpu_ualink_handle {
 	union drm_amdgpu_ualink_handle_out out;
 };
 
+/**
+ * enum amdgpu_ioctl_svm_op - operation selector for DRM_IOCTL_AMDGPU_GEM_SVM.
+ * @AMDGPU_SVM_OP_SET_ATTR: apply the attributes in @attrs_ptr to the VA range
+ *                          [@start_addr, @start_addr + @size).
+ * @AMDGPU_SVM_OP_GET_ATTR: query the attributes at @start_addr. The caller
+ *                          lists the attribute types it is interested in via
+ *                          @attrs_ptr; the kernel fills in their current
+ *                          values and updates @size to the length of the
+ *                          contiguous range starting at @start_addr over
+ *                          which those values are constant. Input @size is an
+ *                          upper bound. This lets user space (e.g. CRIU) walk
+ *                          the address space and read back all attributes
+ *                          without knowing the range boundaries in advance.
+ * @AMDGPU_SVM_OP_RESET_ATTR: reset all attributes for the VA range to their
+ *                            default values. @attrs_ptr and @nattr are ignored.
+ */
+enum amdgpu_ioctl_svm_op {
+	AMDGPU_SVM_OP_SET_ATTR = 0,
+	AMDGPU_SVM_OP_GET_ATTR = 1,
+	AMDGPU_SVM_OP_RESET_ATTR = 2,
+};
+
+/**
+ * enum amdgpu_ioctl_svm_access - values for AMDGPU_SVM_ATTR_ACCESS.
+ * @AMDGPU_SVM_ACCESS_INACCESSIBLE: GPU must not access the range; any access
+ *                                  is a fault.
+ * @AMDGPU_SVM_ACCESS_IN_PLACE:     GPU may access the range only at its
+ *                                  current backing store; the driver will
+ *                                  never migrate pages to local VRAM.
+ * @AMDGPU_SVM_ACCESS_ALLOW_MIGRATE: GPU may access the range and the driver
+ *                                  is allowed (but not required) to migrate
+ *                                  pages between system memory and local
+ *                                  VRAM to satisfy the preferred/prefetch
+ *                                  location.
+ */
+enum amdgpu_ioctl_svm_access {
+	AMDGPU_SVM_ACCESS_INACCESSIBLE		= 0,
+	AMDGPU_SVM_ACCESS_IN_PLACE			= 1,
+	AMDGPU_SVM_ACCESS_ALLOW_MIGRATE		= 2,
+};
+
+/**
+ * enum amdgpu_ioctl_svm_location - values for AMDGPU_SVM_ATTR_PREFERRED_LOC /
+ *                            AMDGPU_SVM_ATTR_PREFETCH_LOC.
+ * @AMDGPU_SVM_LOCATION_SYSMEM:    back the range with system memory.
+ * @AMDGPU_SVM_LOCATION_UNDEFINED: no preference; the driver chooses.
+ * @AMDGPU_SVM_LOCATION_LOCAL:     back the range with the local VRAM of the
+ *                                 device the SVM context belongs to.
+ * @AMDGPU_SVM_LOCATION_HIVE:      back the range with the VRAM of any device
+ *                                 in the same XGMI hive as the local device.
+ *
+ * The location is expressed as a fixed enum rather than a device file
+ * descriptor on purpose: a descriptor has no stable meaning across a
+ * checkpoint/restore (CRIU) cycle.
+ */
+enum amdgpu_ioctl_svm_location {
+	AMDGPU_SVM_LOCATION_SYSMEM	= 0,
+	AMDGPU_SVM_LOCATION_UNDEFINED	= 1,
+	AMDGPU_SVM_LOCATION_LOCAL	= 2,
+	AMDGPU_SVM_LOCATION_HIVE	= 3,
+};
+
+/**
+ * enum amdgpu_ioctl_svm_attr_type - attribute selector for
+ *                                   &drm_amdgpu_svm_attribute.type.
+ *
+ * @AMDGPU_SVM_ATTR_PREFERRED_LOC: Preferred backing location for the range.
+ *	Value is one of &enum amdgpu_ioctl_svm_location.
+ * @AMDGPU_SVM_ATTR_PREFETCH_LOC: Prefetch target for the range. Value is
+ *	one of &enum amdgpu_ioctl_svm_location.
+ * @AMDGPU_SVM_ATTR_ACCESS: GPU access policy for the range. Value is one
+ *	of &enum amdgpu_ioctl_svm_access.
+ * @AMDGPU_SVM_ATTR_GRANULARITY: log2 of the migration granularity in pages.
+ * @AMDGPU_SVM_ATTR_HOST_ACCESS: Guarantee host access to memory.
+ * @AMDGPU_SVM_ATTR_COHERENT: Fine-grained coherency between all devices
+ *	with access.
+ * @AMDGPU_SVM_ATTR_EXT_COHERENT: Fine-grained coherency between all devices
+ *	using device-scope atomics.
+ * @AMDGPU_SVM_ATTR_GPU_RO: GPUs only read the range, allowing replication.
+ * @AMDGPU_SVM_ATTR_GPU_EXEC: Allow execution on GPU.
+ * @AMDGPU_SVM_ATTR_GPU_READ_MOSTLY: GPUs mostly read the range; may allow
+ *	optimizations similar to GPU_RO, but writes still fault.
+ */
+enum amdgpu_ioctl_svm_attr_type {
+	AMDGPU_SVM_ATTR_PREFERRED_LOC		= 0,
+	AMDGPU_SVM_ATTR_PREFETCH_LOC		= 1,
+	AMDGPU_SVM_ATTR_ACCESS				= 2,
+	AMDGPU_SVM_ATTR_GRANULARITY			= 3,
+	/* Boolean attributes below: value must be 0 or 1. */
+	AMDGPU_SVM_ATTR_HOST_ACCESS			= 4,
+	AMDGPU_SVM_ATTR_COHERENT			= 5,
+	AMDGPU_SVM_ATTR_EXT_COHERENT		= 6,
+	AMDGPU_SVM_ATTR_GPU_RO				= 7,
+	AMDGPU_SVM_ATTR_GPU_EXEC			= 8,
+	AMDGPU_SVM_ATTR_GPU_READ_MOSTLY		= 9,
+};
+
+/* One (type, value) pair carried by DRM_IOCTL_AMDGPU_GEM_SVM. */
+struct drm_amdgpu_svm_attribute {
+	/** AMDGPU_SVM_ATTR_* */
+	__u32 type;
+	/** Attribute value; interpretation depends on @type */
+	__u32 value;
+};
+
+/* Argument for DRM_IOCTL_AMDGPU_GEM_SVM. */
+struct drm_amdgpu_gem_svm {
+	/** Start of the virtual address range */
+	__u64 start_addr;
+	/**
+	 * Size of the range in bytes. For AMDGPU_SVM_OP_GET_ATTR this is an
+	 * input upper bound and is updated on return to the length of the
+	 * contiguous range starting at @start_addr with constant attributes.
+	 */
+	__u64 size;
+	/** AMDGPU_SVM_OP_* */
+	__u32 operation;
+	/** Number of struct drm_amdgpu_svm_attribute entries in @attrs_ptr */
+	__u32 nattr;
+	/** User pointer to an array of @nattr struct drm_amdgpu_svm_attribute */
+	__u64 attrs_ptr;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.53.0

