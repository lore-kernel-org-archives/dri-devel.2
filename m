Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D7C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D613A10E84F;
	Mon, 31 Aug 2026 18:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QWCGMSKh";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A90D10E4EB;
 Mon, 31 Aug 2026 18:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVzdcq1Gp1pk+Cj2LGy4VeV3hNRBCWhpCYgK3vUocr71e1uYeJfQBZ7+kzlvm/CCFPakrozBiAim5eiOO7ohzR2eYWrNzOgOw8fRQdGIrFoLjY3yEw7AWKFzKVTJzcEvSPlGo/3Huwl9ToTWJzO1+28ui0yEbVHA+juh46t7FS1M+JRUoqQEZk0mYmAfBDFmeae0wIMRMh7ucfpNAMWPC7/Qzc12nk9uoqHKBGHNI6FnRUhTJEJPdeg79JmUzirPFIZGD+jxpY2qkkBiNJwppARQfCC+syV4EEp7qrI9qYCOVrn40Anv0rPQ+NlBj/GA8ZhqFjaRJa96QdUR3ljt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kyZTyppgCkPXWNxElQyALkKO7gAvpQ2od2qik/Sy8k=;
 b=bMrVK/QcK+6T/S7gXgm/gn1IbS+5dGymZknDu5sfRwqcaiq7tmgC53UHS4PuIdYN9alWKbvEAM9AiQKKdahbKkMRI5EZ/iiZp5S+9xxlotozhWw/nuTXVxWVi7tFkntBtXWC+lUh6+J1zP5XjjDWCkco2sTft7RCnJhsEpQ4832Ui9s9+lc9G6MuuiyUWZogdKaePxWl0WFEIIH/jQi5bzPAHwEkuORMc5vGSpPwAEIjGX5kXApAs8SBjIMtfLeh3tX0baoteGAyUcQwEIuPMDF1/+yZ5tQZPoXVnGAOruqUbXos5SAO7bQq7Bv3+FuQnruvpkH4zFLFoxvEk+7+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kyZTyppgCkPXWNxElQyALkKO7gAvpQ2od2qik/Sy8k=;
 b=QWCGMSKh+/1XrdDW6bzXXByzOgAa3b5WNexhIK2nsGn7pbZpeyuNlYPKs1UwcFD1IfebQu+bSQtrWU8KbpShedy9zqEb/eo16pSeYLksNRtlcfdVjC4OucB9ZA3JRrS8fmRneK+oBwxGVyy5rgVEyVYXc48J3yjBu3BtyRrn/1c=
Received: from BN9PR03CA0459.namprd03.prod.outlook.com (2603:10b6:408:139::14)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:33:27 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::54) by BN9PR03CA0459.outlook.office365.com
 (2603:10b6:408:139::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:33:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:33:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:33:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Mukul Joshi <mukul.joshi@amd.com>, Horatio Zhang <hongkun.zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ioctl infra for exporting/importing
 UALink handles
Date: Mon, 31 Aug 2026 14:33:10 -0400
Message-ID: <20260831183311.1090131-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831183311.1090131-1-alexander.deucher@amd.com>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 452b2a5b-b496-46af-1c86-08df078e594f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|10067099003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3xuVQ2BAQmFL+RqRrtkSQ20/EQaWnvMMjD7KLMVXoo0WqVRn0fXGiJ0jFKgUElJqh84gTsoFaAQpX5xxZn0dhz1sQjw3JUv7hFist9RdDscE6rz+gB74uQMrZxM4NVJHnDYOUGzYofrJUe9PM31csPbJjPtB4dcoUmpqCXVEfXoS2/bAhdProOQt/PfPN9r09SKSkI8336ppB6sCwkvWzk+5s7DpUyfGFpLtSU4GBHahvK/bZ367uY71S+d37FQyFnw8U8duxwnYtv2AZJvYmzfeGzSVOkHCQvvbnGrf4r1dGjTE9lYgk+t5yGszAZneZWGfaBcaZqRVcEVDw/BnpHG/NZ8CpYnZLVmh0a92q3Bpn5QvHo2awUc2KKbX0cgh8suM0MzComDmMfv5XoN41PuEZ5oFezfHWDIDmfS8X0SW3/zlrHM5VYwb4RNnlezhnOraSDcsnNv0kCT2vls4tY03EkUdwkL0l/2qDAnbPbO8IHKeOeWXAeO37VjwEOyRcCPNZM7sYT2ZxU3It1F0PlYm6ggT/mU0r9FaeopQN1E18RPCX8XptzruFZJqF9M9rmPE+MwHJq1SoLmeImiIkPpb3Yo88KVvR4Cz6V5ATg81XGH68+PuweXPpSW2VcEVyiIOwRd0RKsYlndNt63+NUZ07d1YU6odrAEgVwtROnA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TjYZo7VtVeuTkKIsmLxH/ybehXePgZN6StlcdEC4IVcsL9B3NRWY6JJjfwkeQhuksb/HMM9j/NBfkKJ+NAV1rK+RDLqtzdzihd3rpsF5UMfxNPnw33fTKkRbjceZS1egLn3N7hxeW+LDzG6LCWT5y+5dRxe0AH6Pa6e9Fe31//e/RPyJcjyJ5T5P/Jr/kLaLHEBIXCAGBDFWTsxGZjaG4Y5v26vFaFJvD1kNhGkNIcjiHFmKSMxnfMYOpleRR38v33gMjwqbfaySgbbNfVGORTKW9lZl2PRrhX6Y/oORM0ghp0BrgxoEoS7iqc6g5frHXnPF4/spiIX+uFih5zW3VdrOQHtwkAke9iY9y3r0O1ZETRpzqyGaNcDmK1uge9xsSSp6hFbeZVbQoatJjWRVrHe1AmfPNonc4IBJVZOMEv5EsAZV7Fm6j6w4dITKF73r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:33:27.4579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452b2a5b-b496-46af-1c86-08df078e594f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add the ioctl infrastructure to support exporting and importing BOs
to facilitate NPA based memory sharing across GPUs in a rack scale
setup.

Proposed userspace:
https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L971
https://github.com/ROCm/rocm-systems/blob/35959f8e1260c7cee3e51a740e320be3856ee4ff/projects/rocr-runtime/libhsakmt/src/memory.c#L1036

v2: Move the ioctl wire-up to the end of the series.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Horatio Zhang <hongkun.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 44 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  2 +
 include/uapi/drm/amdgpu_drm.h              | 30 +++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 287c9455969b2..9c5e93cd3ee64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -54,6 +54,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
+#include "amdgpu_ualink.h"
 
 /*
  * KMS wrapper.
@@ -3120,6 +3121,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 3f96044a3d54f..f82bc9a9d0837 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4008,6 +4008,50 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 	return r;
 }
 
+int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *filp)
+{
+	union drm_amdgpu_ualink_handle *args = data;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_ualink_handle handle = {};
+	u32 gem_handle;
+	int r, fd = -1;
+
+	if (adev->ualink.info->accel_state !=
+	    AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
+		dev_err(adev->dev,
+			"ualink device is not in active state in vpod\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* The input and output members of the ioctl argument alias each other.
+	 * Latch every input field before invoking the handlers, and only write
+	 * the output fields afterwards.
+	 */
+	switch (args->in.op) {
+	case DRM_AMDGPU_UALINK_HANDLE_OP_EXPORT:
+		gem_handle = args->in.gem_handle;
+		r = amdgpu_ualink_export_handle(dev, filp, gem_handle, &handle);
+		if (!r) {
+			args->out.export_ualink_handle[0] = handle.handle_lo;
+			args->out.export_ualink_handle[1] = handle.handle_hi;
+		}
+		break;
+	case DRM_AMDGPU_UALINK_HANDLE_OP_IMPORT:
+		handle.handle_lo = args->in.import_ualink_handle[0];
+		handle.handle_hi = args->in.import_ualink_handle[1];
+		r = amdgpu_ualink_import_handle(dev, &handle, &fd);
+		if (!r)
+			args->out.import_dmabuf_handle = fd;
+		break;
+	default:
+		r = -EINVAL;
+		break;
+	}
+
+	return r;
+}
+
 int amdgpu_ualink_manager_start(struct amdgpu_device *adev)
 {
 	int i, r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 1bd7181147dd4..85c9a9634a4b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -413,6 +413,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
 int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out);
+int amdgpu_gem_ualink_handle_ioctl(struct drm_device *dev, void *data,
+				   struct drm_file *filp);
 void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
 
 int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d6d5402a1e789..0e8115673d8d2 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
+#define DRM_AMDGPU_UALINK_HANDLE	0x1B
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -81,6 +82,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
+#define DRM_IOCTL_AMDGPU_UALINK_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_UALINK_HANDLE, union drm_amdgpu_ualink_handle)
 
 /**
  * DOC: memory domains
@@ -1705,6 +1707,34 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };
 
+#define DRM_AMDGPU_UALINK_HANDLE_OP_EXPORT		0
+#define DRM_AMDGPU_UALINK_HANDLE_OP_IMPORT		1
+
+struct drm_amdgpu_ualink_handle_in {
+	/* Export or import */
+	__u32 op;
+	/* For future use, no flags defined so far */
+	__u32 flags;
+	union {
+		/* GEM handle of the BO to export */
+		__u32 gem_handle;
+		/* UALink handle to import */
+		__u64 import_ualink_handle[2];
+	};
+};
+
+union drm_amdgpu_ualink_handle_out {
+	/* Exported UALink handle */
+	__u64 export_ualink_handle[2];
+	/** DMABuf representing the imported UALink handle */
+	__u32 import_dmabuf_handle;
+};
+
+union drm_amdgpu_ualink_handle {
+	struct drm_amdgpu_ualink_handle_in in;
+	union drm_amdgpu_ualink_handle_out out;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.55.0

