Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EAA606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KHp8K4EM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1486111281D;
	Fri, 27 Nov 2026 08:42:15 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E40710E4D9;
 Fri, 27 Nov 2026 08:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpzDJ9wcyBJColAmbz2sRgMTfLg+VLE0a1DjOkq92GGW/usC1ggQ1EUEkCicypBx+OnoCCq/yi9Z2EhkWT2D2r/AoW3MUlORaMeda9BI/eJFSxQ7oiLLayPBavGxqBa1VgZJ0sSyFci9K20EX8J37e3Fmtn6Mqu1FKbICIPJPVcT7vAKDh2ipfi+GKoyvqmU6JSKGQnCAImDwKftXJ9NzoNVQqfLrIRN9f/8S2STbkQJUiwApzhXi08/4TduBvhM6kHNyCyILZ7GRKarYEYU7D3/GmgYaowPvQm/WGSpF4LknQ63fKmJ0OF2s/lv4YX+tmAUgd0tZ4ilf7ItgGhaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NlUc3yfRxTM6nfZTI/VnXL9NndCmAMSp1fNwhGwcsQ=;
 b=Jinh34GP+VPHS8PJlKoWBfoMfTN3bV02vV+3G3c1DePBPJHPmj6DoH+YOrhRK8VITvaz5odfX2r60Z03YSWv1ncs0DUkI5/OeR4bUyq407VKCmEfU3gxe9M7x9oe6vtSZ5ejCiqm39cKJzGTMgCnohatpdWAjppdRrlO54F3bN3/tL528AG6dtuW/HoGZdgEAfN5SxTM09CyXNzcDggMHt6WfWl23ahf6yW1xeNYptT+Smg8NwJyCJX/x0tO6cL+TDDJuDMlYO0eX4AdG7vP9911640PSy4byvYIGNhfA4CV/IZV2mJczLn13lRFkTEqf1UBl/pipxiXL1bReaN9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NlUc3yfRxTM6nfZTI/VnXL9NndCmAMSp1fNwhGwcsQ=;
 b=KHp8K4EMzFG2UB8llBunRylyhsXirIAdIlOWvvJJfDaxOXd6iVAfZbhiM7kAmBEVfDur4/BguJSoAKUicLrOpyONuICckkGZEVH6cwx4kEG7ZN0kw23hSM5jonlfHYGs5TsB90tkQRbrUrL+u7uOTiqfG4PCuqGNQsp/Plc0rfg=
Received: from CH2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:610:58::18)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 08:42:01 +0000
Received: from CH2PEPF000166BD.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::58) by CH2PR20CA0008.outlook.office365.com
 (2603:10b6:610:58::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 08:42:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BD.mail.protection.outlook.com (10.167.252.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 08:42:00 +0000
Received: from hr-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 02:41:55 -0600
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
Subject: [PATCH v11 02/22] drm/amdgpu: add SVM ioctl UAPI definitions
Date: Fri, 27 Nov 2026 16:41:25 +0800
Message-ID: <20261127084149.925625-3-ray.huang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BD:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b983bdd-732d-4c0a-5f01-08df4c624de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|6133799003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|261009223327099003|18002099003|22082099003|921020|10067099003|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: xCnFa53ncoifAykmyxMm7a+hrdp5KbhTfqw1RzNvn0GcrRoJut3eWwHVTOhfwzd4kgova1wqeDzWXPgzxpnGMJwR8vfaS6L8ACQQbQsaJIYhdjMwf9ksJxbk2WF9oR5L4BSlur+6rONzFwcp2dlZ8DvKLNv7mlpxKef/rgJU6g2QglgtDek9IU1IvSK7A5C01pURzafoM0L9ckwLoVFrNbn3RnnX5BNNMN2cUYsQ183LUf286Te5fCzTrGE8vX2l6qTNlO2iD5nNCiLIcly5kPPpgbCxfjZsqMME12ucVlWoLoNN+6fKRjaohpmXhHl4O8l3ZgEmVe2RdkXZO4V4oktiZf6GOm0XiCbbFAG1EHkwQtaaEs5rJ/CkJzJspBMSfuDZJp6Vh8uc5XU9P+tkuHYGOqM2hbwGZiEFZJHv+db4xTpF5r2DYeaVhqxfx6FXCi70cbC1EOoCOLl/vjl/4A30HcTT87pVCS1qjtTypMaa6vbD80GWcu49Qqni8LgrnbPZYHqJJ2WxFuYjuOS3ynCfDkVRTHMPs9MYIdI9/xFdlCodDcsSkyfTjp9yyrt7C14GZWsedcjf06V0PD4fNQF846IWF1oJFILqZzSGSljCmdPkFJ5OUfEkqBdoi+AM8lwHpHOz4hrZHeb3whKKe4XXsE7dPCXBgOVS5meFknBUVLxEf5vw5SxeQJJbQrnBOHmmOcfdkH+DLQDCUvcM1w7rld5hGzfFT5NM8hlR1gpd8t9O/hM84RxTOv5JynXq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(6133799003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223327099003)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rQQK6Dmz/vxvDqZ4xi3hSA6NAajE20N+8njqvqelEdgExyUa+KGk/0tDiMSBWHXMjBfpiRv452TwGXvTtA+LaWtogtG8B0jepXrtFgTAx1sFexK0W9dWNeNmYM+gCp5fRDifB6bZvXlfhJQgXLX91XQ42HIcDBJBwAOolMRRt40EyylmUcVOIdKRq/lZfIX2/gYY1zYODN7uPGlWA7AWPYD6Wkzfw/l2MjRzJTphMpl3gTKQYD/eKeRhxZ/T1cswhaRVWHlEemjwKrCY+6AJDXS25q8OJFDJ0F3yqPGCA3ix+sprsTrmkwNkF29aa4oW4zhAO2brx9WpQiUSDjUgwIVd9Q1PY2U4QKxIHye09aLbs0Ycrt7Zey5/bpfLWRMnv+pNZAMvfIJzICmXu6ey3zfsSM9/hhKMVRQjZBpdCmWnjqpVhy0O5ERSelGfiDYl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 08:42:00.6662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b983bdd-732d-4c0a-5f01-08df4c624de4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 127 ++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde9..a3adcb49469b6 100644
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
@@ -1737,6 +1741,129 @@ union drm_amdgpu_ualink_handle {
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

