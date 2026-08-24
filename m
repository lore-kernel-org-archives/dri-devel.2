Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C42FC61CE3
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26D210E7FE;
	Mon, 24 Aug 2026 17:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r05u2F8T";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DB310E800;
 Mon, 24 Aug 2026 17:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEdy5NJtfMiz0pCf3vpAvmRqH07VM9e3n18LtVDnfNiEuBgvYweaVc7jT4hr5xX92EajLscYoBz20EMSMre5YQTrZZGwTVVf5QfSQ0iiRy4/ILSIcfnlqEwanwGrD+C6erEVyo9bp/vZBZKdlAup3XlnxfMBopahhItMd5prVrXr16VgqRt0qK+mUrfaySiY8rfmR1WAH9lgrK5svwJ624rC4WynV54I+/bAXpYv4cHtzo1jbsNi/6agcrZ4h7hoOS4u/V0pNWF6VLxtK1oh31Wi9aK56PfXrrTmWvvPJ1dl8p3EnD/k1xuOTpavYqG67wqDdDvKcLT4VZAvouiSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPHL4FLMtyw1R0AgizUpq/ikj+Nak9DgTRjUf4JnP64=;
 b=I/yYUjVNAujXi2wsMU7HvhJYnpKgXnEMoJsLvlfivIFrU6/jIXu2kEU0HCmWuYRZ1tvlfop8U8dwj2rRGGH+IzA9V3Ik9sNJHsTyWkdI1YkQIVZQO+wVgkq6ALnDMxC4WxYN4VuGxU+jwYLRfluLHg9uUDx+H1oO4jEbdAe63VPPApM3ZFMNNsmc54OEb7R5S9BP7jXWSA+loQ+ZbYMacoM1Ae0P8rWCT/udof6DXCTNRN5/44QjcAHvv2rFHf1T8H75uZOkoDGw3l/Dz8mVTza1W3ShLIeIP0kCNLjctm18qmwbGvGXL7A4Qz/Hngb/p0p16qzLhAldHMYewucoMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPHL4FLMtyw1R0AgizUpq/ikj+Nak9DgTRjUf4JnP64=;
 b=r05u2F8TweWfRCgXMbXZzDfrAd3/wyJiSvxkxpKFnrKKyP7zamtJp8TcCCd9GUcu4Qs2b58djgH6m1ZRn/aog8EwrywFPDnAH4dRfqY7TOnaYm9A+qHMhKRRu6vd8W0a8qY0wyfPYv+9Gmg9gBoKlcmBIHqdYW8QKltItSiiM+k=
Received: from SJ0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:a03:3a1::8)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:02:28 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::12) by SJ0PR03CA0363.outlook.office365.com
 (2603:10b6:a03:3a1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 17:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 17:02:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 12:02:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 12:02:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Mukul Joshi <mukul.joshi@amd.com>, Horatio Zhang <hongkun.zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ioctl infra for exporting/importing
 UALink handles
Date: Mon, 24 Aug 2026 13:02:01 -0400
Message-ID: <20260824170202.1764463-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824170202.1764463-1-alexander.deucher@amd.com>
References: <20260824170202.1764463-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: afa86155-f5c6-4826-da85-08df02017980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: LyhYbueqqQIvjd9AC2D1F+UzfTO1kx9OdBxY/fH8+tNJgtPcazrUAJYmcqJfcmZir3iUaX9wG7ir5r3y9wVPBbiP1OyW6Z9vt704fPeEQih/ZE3DSeRXaVXfsoWN3ct0pBuaa38sxEvw0TzIupKUnZxEACtIfKC/Ao3mkEc/7mqLS3fXnSRc0CnuG+CagwRiDHL52l3pJEnS4ks6/03WIP/pup0P5G61FGNiO2f5tu126fZPNlSFGuw6CLnrZ12iQh/L+9hgsRyKAsijGg59kZXzoSXa0H3AHlhwTXZyEA3odoszxDcw7H3CBWuoFN5t0gRMMzyq8PNl69X9MMVrLQPHdH6LsJ6Ky3HfPPji3yO70ekFi4GusUDHkvI+Fz9hIV/ufjdPu4LrOgTThjpg+Mi/RxyD5g0JlguSrN7YEmPe9oA8y7mIgFI8dQ0GAnXWkfrR8xfpno8x3+j0BX472F1Q4OzxR1rM3tRZbzxbjpdAD3RoKVRwu0m+EBLAYY7RGrxiFios6IYLZPz1GJhUt4ZWNkFheZbsO4PYQ5lG34hMHfwjeIIhrCZQ+u5XYoVGNfi7sLUmo5SEsXtZ9R8jdY6RLFrTZxz2dNaoWTUIgknYRPdAbrpKSh9mhMWvp69VwFO9by2w9frzlIi9Zl59OoO5tZb1kugnhOqlCCkXfcQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hTJhhf/vzeUIK+sH1bMFXVE1iuk23p84u3+9A/LVDZDv0KgKPWZtIocYi9VBpq6t7gcbHOyA/FsX3ug0uFQ0cq4gKt31o2JV3k8dgvq0XuYY97BjFWG7zLx9yobURo6Y8O02QmONoIacFD80HL3SxkQgOMcQOLxxx6r8EhmjvZwkK5rBrZ+qYhZJBogrnIqLFqdcMbyfLnyeV0aFAmfHdnkwHAUForyL98WKnIAOgGasWTIkm6n/uTi13LpDcVuC+JEV6PsJ6V8bVqimAxHK6abwQ1ypAAQUT1/NqSQt4Pr9IxFfuTMhFi4gLQQ2iN2jwnnZ23YqBdDh10bBhnl57mrT4WMpiQtUWe77ws0MsD78aCPMNzA7YPPz2vR31VdENo/3imSzq/55EgW8kso2PPILmQajzZGguzewKxUWEMNrLQCNEPTaMe3b5x6HPosO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:02:26.5353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afa86155-f5c6-4826-da85-08df02017980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361
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
index 04b21e456fbc0..25430ff39a6c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -54,6 +54,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
 #include "../amdxcp/amdgpu_xcp_drv.h"
+#include "amdgpu_ualink.h"
 
 /*
  * KMS wrapper.
@@ -3119,6 +3120,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_UALINK_HANDLE, amdgpu_gem_ualink_handle_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 402d8941fb045..63374c6b9ebd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3963,6 +3963,50 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
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
index 63710b484c6a5..9908d3a277172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -409,6 +409,8 @@ int amdgpu_ualink_export_handle(struct drm_device *dev, struct drm_file *filp,
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

