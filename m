Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17C7CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5639710F362;
	Fri, 12 Jun 2026 09:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VIUsytP7";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012034.outbound.protection.outlook.com
 [40.107.200.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7106E10E9B9;
 Fri, 12 Jun 2026 09:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRt7Lwxppr9t55I0ykbtMT8/OBKnACa9bAqmnI9cafZgoVqg6fTTsD+VPiol74NcOH7JqkZRBhnngi4TdBWppQF5sXCk6/8dA53+mHxrEEMfxqlowT1zkC20iyhIcGrPs5h/4LKcemBgsea2FzHWt7DLak4jjG/167NXb5rGoFduUvQMI//gUwpVInP1bdlFhDP4VSytm0TdBTXkI9f0gofkf2hdQk8TpvDKyvs5wz+4hd8Ki/OJpHQAP2yS7xBMfbDOM4Xb866eTgtVvjC/+2Hpi9HChmv1dI3NBmB1UZiUS+Ohq5OOkbxVts5eMHFFGx3VLA5Fa48H+Xc81sy6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/z7ULuKxayFtWEYtWZezeneyLB6FulwZRF3o1JQeIA=;
 b=fU1TPAVONUQNe+ay1mSNREZOJXCHyr0jPX5+GX6Vf5KjE5SfoJPjSnz/tis5bptTAZywUW8BHbYrCLPRr03wO9ZlerWlOeAZlRRB9ckp3G2sEe0s197ENCcG6ouVyOIm3yRzz6ZZw+0kjMlq2C8YWP7Fk1U9sYDsv9kCjMMS8Mz9Th2SETfMw03sz2u3uuzaVoLvhg3SSa5QE+/XxpdgxJuU3av82VoITSyspWE222O/BOHUM8INrHRjZ67lQ4xNmLHrJrfnYUhn4zd5y8piQNXMD1knuk+F9PzQqu97RCjzU79OJclOAF7u5Mu71VZomirNxbwoaxJfSyzLbwiTyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/z7ULuKxayFtWEYtWZezeneyLB6FulwZRF3o1JQeIA=;
 b=VIUsytP7ITm9n+VyfeHcm+N8QRBeEQjrW512pRNT+3DY9OFhouxW/tIpJydCcP1/UDiGu7RbDZojJeY3sJ5OEiRfxI4f+2ZTMmjtkorlquP5rhIxFNx9e4pxBzqEE5xcCUnz1e1pVrEI/ix8tRhSO5qG1pNQ4Qnz/5ukirRx09A=
Received: from CH2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:52::20)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:10:08 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::3b) by CH2PR04CA0010.outlook.office365.com
 (2603:10b6:610:52::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 09:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 09:10:08 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 04:10:02 -0500
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
 <yiru.ma@amd.com>, Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 01/18] drm/amdgpu: add SVM ioctl UAPI definitions
Date: Fri, 12 Jun 2026 17:09:03 +0800
Message-ID: <20260612090928.29682-2-ray.huang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612090928.29682-1-ray.huang@amd.com>
References: <20260612090928.29682-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 407035c7-1ae5-4aba-68ac-08dec862665d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|921020|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5T4wBi4NUmnI0I+tPeXntgiT2xQanh/jM5YUqRtmhYvNGc/XzJkq72BOGHtX/Nwem1LR0RDm/6UnBYfQ1ICTY53E9UnACFBYy+koDCvPCt1Fijo+2fRpCyySRoVY9lQhBhzZeHEoymqIHuUJAFJXChORxwFRDG2xL0PJJmCdnNIYdlnE3LSt3/0ArcQaAX6dXVjZn5xDnmomV+sIkLZWnM4888iELobRUHZwW8qSNxiIqSlA1E33FQyJEQUAG+zyok+GDRBk3qZd7qEYDw//V0pWvap9VCc0FokFGOzkyJglgwjb1JJ9o7rPR/E/2Q64uFycnx02Yv7XhhkriySf/Dviyzg1+mtGyKpQAczLXBhT2inYmscmBQl7EBvfq/gyeEZSCKfbMd2U78LjI5m0wxBP2RO/MYCv50N1Lxo1lt9z/HArsjaKMpGr0lPJqUGAOEY77o6wvACLAypb8dC9yyz6+pCA/CMPCU0STVceN+x+atY0I6iH65Qq5AGo5QHvuUVc3/ad9c7q4KRt4XOK1UuRn2qfsEYW9lzGwmEfYFGKp8Tx+1R+3EikFQugVaree8qgyYWJGWVxf9ISdpHe7aH0WMpIw1t9BdrSkc2TtqiHqHuHaflkSdWHN7aaJyFNd76Y7J2wa1gNUwsLI9xCPnZWKJ76nTRdt8bpFmIJsvZ2tM6XOYmLUpZnvFKhSw/6xQvYPFMmzkwIaKupGWrPE7N5maGj9Kd3KZILqIIObZQEId3G39oeRAXiJo4zQetzexnmdwZhbUx6o7f1I1rv3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(921020)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ksGgfQi2cW/qWD2nVkofw4dyr+smuLnoWmcNHKBm4zrnoIuQ1v4njlzRuMVBA2anRJfeM3V0Yr3QuQ95inF19PdeisWzkjYBIiLpTBGGLkBx4rdoS2ssyaxXZq2ZjSEkRpu+pZgW/qjhc2QEihKrwwK40Xkg1eIt1pXP2IL94m0V3Oxww+DsO1XYKKcnBAl/5crdb0DzzXrH+3QDea+tZFTpJwLXnFXqaimXrs5a2/8gwUoeQO6pi0nb2C3zXxWvE1FUKX8BNXkT5idEzqy3sd7NMvkW3tRFwgYvFazWCRTM/Mo0mbAP2bdZ0bsPEEFY/L3tXHd9EtHhpU8ohPFjocXWZjrqf1U+SR+iMMuKjPdpaCERFMc+BGtut7Ukf8qRdzJeh58wEg3SSBEbVSfH9SzDtrF2CxS5WS2T8B/mf0+97U6xDBndRiUCgXXO4cVu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:08.2606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407035c7-1ae5-4aba-68ac-08dec862665d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470
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

Define the following ioctl structures and enums:
- DRM_AMDGPU_GEM_SVM ioctl command and DRM_IOCTL_AMDGPU_GEM_SVM macro
- enum amdgpu_ioctl_svm_op: SET_ATTR, GET_ATTR, RESET_ATTR operations
- enum amdgpu_ioctl_svm_access: INACCESSIBLE, IN_PLACE, ALLOW_MIGRATE
- enum amdgpu_ioctl_svm_location: SYSMEM, UNDEFINED
- enum amdgpu_ioctl_svm_attr_type: PREFERRED_LOC, PREFETCH_LOC, ACCESS,
  GRANULARITY, HOST_ACCESS, COHERENT, EXT_COHERENT, HIVE_LOCAL, GPU_RO,
  GPU_EXEC, GPU_READ_MOSTLY
- struct drm_amdgpu_svm_attribute: type and value pair
- struct drm_amdgpu_gem_svm: ioctl payload with start_addr, size,
  operation, nattr, and attrs_ptr

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 106 ++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b32c72a662b61..4c49cd36f0e77 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
+#define DRM_AMDGPU_GEM_SVM		0x1B
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -81,6 +82,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
+#define DRM_IOCTL_AMDGPU_GEM_SVM	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct drm_amdgpu_gem_svm)
 
 /**
  * DOC: memory domains
@@ -1694,6 +1696,110 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };
 
+/**
+ * enum amdgpu_ioctl_svm_op - operation selector for DRM_IOCTL_AMDGPU_GEM_SVM.
+ * @AMDGPU_SVM_OP_SET_ATTR: apply the attributes in @attrs_ptr to the VA range.
+ * @AMDGPU_SVM_OP_GET_ATTR: read back the current value of each attribute
+ *                          listed in @attrs_ptr for the given VA range.
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
+ * enum amdgpu_svm_location - values for AMDGPU_SVM_ATTR_PREFERRED_LOC /
+ *                            AMDGPU_SVM_ATTR_PREFETCH_LOC.
+ * @AMDGPU_SVM_LOCATION_SYSMEM:    back the range with system memory.
+ * @AMDGPU_SVM_LOCATION_UNDEFINED: no preference; the driver chooses.
+ */
+enum amdgpu_ioctl_svm_location {
+	AMDGPU_SVM_LOCATION_SYSMEM	= 0,
+	AMDGPU_SVM_LOCATION_UNDEFINED	= 0xffffffffU,
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
+ * @AMDGPU_SVM_ATTR_HIVE_LOCAL: Use any GPU in the same XGMI hive as the
+ *	preferred device.
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
+	AMDGPU_SVM_ATTR_HIVE_LOCAL			= 7,
+	AMDGPU_SVM_ATTR_GPU_RO				= 8,
+	AMDGPU_SVM_ATTR_GPU_EXEC			= 9,
+	AMDGPU_SVM_ATTR_GPU_READ_MOSTLY		= 10,
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
+	/** Size of the range in bytes */
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

