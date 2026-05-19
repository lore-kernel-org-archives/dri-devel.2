Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C94CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE5010EB38;
	Tue, 19 May 2026 08:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QF3CW2GV";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013069.outbound.protection.outlook.com
 [40.93.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC63910EB3A;
 Tue, 19 May 2026 08:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm1/TIRiGrDymyX7wpr67AgYVpkR2Mh4Svl689uqU/ehtf4km56tnCfGzOEQ7TEdF2ozcrAPHI/i81eetqKRzrp3Mzy6EyJVtX4lPdCgvHvedTcuo6LZ/Mh0VcawX7WmlyC29FUVHZSvcPeHtlaWsXgNW+SHoYLfaVGC0hAK/7O4QzR2POczqV2LBIHZmd8gYiV59XOJzJMxP5s7QjDZKokmh9Zecw61coZjO2c/cPJl5QTvcm1HatmcU/HHZ/o4eiwGgcTLz61XvXshONowo+8TiqFtJCTy93R60WJ27IJ7sAOc+ZwBikNfiJERbGNrem0VIHo3TjzIMADyBxGaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyll83XzOLfjSJILlz+MBS1eoXrtZKznP7Bxx54KtQI=;
 b=KrAhFFcR3lI8AEUhvUDmC8cvtGsPDAADRwNwmOC88LQi5Mgld99PCm8JIaewVoTJ6OWA8WvAWzZemtnpxyuSD4WupqDzyAgDR/LWfrspkKD6M/TlXNlx09fby7MkZFLxxiTfyctZw6NgntAfSS9M8G97HbliLt6PP2VbPU5G/eIQ7Qxhx8tg1OFM9xQasGmdfQaiOcEXAwNeGuLks+4n3YgEDlAHnQBQ+oxZnL9VR0tvQnAChTBdbJ+ZuRHtliPVedznLtDH/ww1Uz/2tXwtUI/p/fj5LLnzkLe+5Rvi/uwmltSizva9m476rCeHyUlvw28kK03ePwOhPU5Oe0zHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyll83XzOLfjSJILlz+MBS1eoXrtZKznP7Bxx54KtQI=;
 b=QF3CW2GV6+W8HQga/3lfzl2N5nyjyV3YoB6EOQpCCDK9z6y7b59DWNkt9K7j56Q554i1lvIVdNkLEmWpiqkE2ksX2dBswEQo+vtnM6azH3tRTKV+qMq2mdE9XOyP7sjDG4kFIUynzFH5lc9XjnROmJjEXsliawV+Lxn97ZCVEWY=
Received: from MW4PR04CA0371.namprd04.prod.outlook.com (2603:10b6:303:81::16)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 08:31:49 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::14) by MW4PR04CA0371.outlook.office365.com
 (2603:10b6:303:81::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 08:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 08:31:48 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 03:31:43 -0500
From: Honglei Huang <honglei1.huang@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>,
 <sima@ffwll.ch>, <matthew.brost@intel.com>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>, <aliceryhl@google.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <honghuan@amd.com>
Subject: [RFC V6 01/12] drm/amdgpu: add SVM ioctl UAPI definitions
Date: Tue, 19 May 2026 16:30:46 +0800
Message-ID: <20260519083057.3108087-2-honglei1.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519083057.3108087-1-honglei1.huang@amd.com>
References: <20260519083057.3108087-1-honglei1.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cded20-9c8c-4754-dc1c-08deb58111da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003|11063799005|921020;
X-Microsoft-Antispam-Message-Info: 7NhK0F2GyIXEjDupKaM8VbEk6fjNFsk4keD0dIMl9/4zQAPhNBkgU0a/ujjJsmnUzEqXOkqmHlX24DB5f2/tjXxKmuRWllJFpKHn6PJA4FJNrnGHMLobPdDI6EaQNsMWRv/PrcB/3rUFdWzJslwPwRG5wMQ6Ugs6N1bsx6yy+aoI+dX305GKCYHETJoZQT5weO+1FF/bv0lh1hVf3l467RTqUlUtQi/ehxIigA5OE83Sf09N0qppnRTP4jOy7TZyG2ik5SNl6ltmjIHIF/C7wFnmi1DRc9htjyaPYR9K0mM3HgKo5XK8YmDdjbU3F3XN1zsBgSxq30lbnTuaEulgkmFT0gvivDVplW6dk0G/lj+9NaOTxme0EtTLaQH8izoOP3nPMEblduCX9wMZdsmmP1D4bqU6iBeMZ4Ls4VeS+Cu4uGRHZliMrgTajXBWnghBankj4jmUpB/slsUlAvYdG44J4Mb7coUZuZYf4pYbYWGvi189fxNwW5SB1ANCF5YWZyaUtxiV3V7qQr37eqW2AmLo6kgKMPTTvU9DFPwKY1D/2pOdTznsjdcU7AiBRhLNVEmH6eNJLBlP4J8dE2H/Yd0bkQ8S0Xy40p1wyk3ATYx4P/wnFG+RiMZhHmAQMDP1liHG5CVGd4mGMxQWLwYvGrnHQpoxKyNYM1ipShVvTnWuUQZ0Gk/0C5DmuO8ObBivvU78UbDS+5wCOgj+OI5s8TJ3wP6Ze5KbiOostbBkVlQVqqMH8ti8mfjCetIKloS+yegkeeKilTuxFhldD6J4xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(11063799005)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q3wD6QUpFUxf5Hajg4cqnme68kHcevg4FX7Va5/T8d0HePIuyM7H7VCHD2C8VUNzJoP8k46WMu6ntLNCZVxqb4o0Q6k+TbtWU8ppgr1OKmDbkngr+NkfATDNuYqWS1auQt7IZ74686sgZRrMpKN98Z/Rjj38YQM5dZ/MUTmq0ILzI2ZziTQEijrX1cAV8NHIpEQ1m2yAbLsCixS0TIwh76cZCL3XIyy4oXKUV4dbOPwuPmctAhKWMMEYVjWS7sG+0FqpyBazRlffwTOip+eUlX1AR/UbocCASMAWiAwcO3zg7KcMotqeaLyNgNfbI7GkCGU/JGSBQxUYQEI++nWGAfB9gl2aMgLBQY2Y+D/1d0/2/EiIb2dLDUajoeIyr0WNX1kiIE2mmIhaFn/JDB/uyqPG5JNXxIhAug7MWKU+TFkF3I1hTb3VradQ9rhyrtrR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 08:31:48.7041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cded20-9c8c-4754-dc1c-08deb58111da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
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
- struct drm_amdgpu_svm_attribute: (type, value) pair
- struct drm_amdgpu_gem_svm: ioctl payload with start_addr, size,
  operation, nattr, and attrs_ptr

Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 106 ++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9f3090db2..5d35eda88 100644
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
@@ -1673,6 +1675,110 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
 
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
2.34.1

