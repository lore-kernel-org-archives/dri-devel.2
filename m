Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C36C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42AB10F479;
	Fri, 21 Aug 2026 19:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W1tOqpf1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31D4E10F479;
 Fri, 21 Aug 2026 19:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrq4d5K7Huxcvnf9grASLYNNCZ1V50I27iAHUq2ae1fM7t3p5yfk2u7se2eSSVjNeuYprTCImjRJ2+UNlBxelW9w6MbXhN5H9lzxBVeLnBH6LEGjrCPCsivGzVSTuA5SPwG/n59daK1iIhrEfdAiGFQkONPp8IiuTl2SmGUYI6h5rL791jCDBVB/DMBpe1WMcmtc5a1wMRjyDxXJLtnZfjUGS7ngqGnA5xpt6GaE58J5CxoGbSn5FkRybrz56jIvww+phf7PeJwXKFYKmQFJgGOI6L4uLIGeD7z4qkh3Cg+GJ4Z9XEmsk6hUXJpfyDMo9ni1P/T2FW+VWZrXU+CWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPHL4FLMtyw1R0AgizUpq/ikj+Nak9DgTRjUf4JnP64=;
 b=t/deCbhxLw8hrmCVhX34OScSw9il1W3sqZN1yLLhb5hYPcb3lbn/mugKUFqVXCWPCTpyKC7i2e+I+7GtroE5V9sMHqN2IUffWmiP7GfSL17TwsfMHCe3ZYV116I0NtXc3x6YjfZjQ+sSSFUQ4jK8Zl0PuewAp4G4CuzmrpKR9daA343SP43NH7oWOIz3mhP9IMZIEaNV29Znv90jhnlZho9XX3Ttllx5rcej7JO29rEoZgr1V+GmFFT7+/VtpAy5XMGxinNNqrMkhmNMV0ORzCYgYcTBCrxlEyLsocpmalByuYQ8NWKeJ1OzpXh2ui/orei8LB085Q/OoZyDTK4gIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPHL4FLMtyw1R0AgizUpq/ikj+Nak9DgTRjUf4JnP64=;
 b=W1tOqpf1k28VG2J98LMfCm5FRuCV5IP1p1eO6TjLBw5TrKFJ51JcDkw9pbc1ZzGpFcuVBb0KzVtlhVINgP4D1re/UZaZ/NzgWZayIjMBLjW/2Jm+NgqqMtr+6wxWqxok2r79RMLKokNfOnIH4T2Kam+JFcI6bErXswVzbMQbLkg=
Received: from CYXP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::7) by
 PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.11; Fri, 21 Aug 2026 19:52:41 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:ee:cafe::48) by CYXP220CA0007.outlook.office365.com
 (2603:10b6:930:ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:52:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:52:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:52:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <Felix.Kuehling@amd.com>
CC: Mukul Joshi <mukul.joshi@amd.com>, Horatio Zhang <hongkun.zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ioctl infra for exporting/importing
 UALink handles
Date: Fri, 21 Aug 2026 15:52:23 -0400
Message-ID: <20260821195224.809173-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821195224.809173-1-alexander.deucher@amd.com>
References: <20260821195224.809173-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: eea260bd-5527-4aef-ae50-08deffbdc25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|11063799006|3023799007|56012099006|18002099003|10067099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: q09M/PS02qT3r5UB/9fQeRIbVYaEqt/iyF+PVHGtmn/J/VFWYYL8MeXbQNZOQb2IbWQWMWpvwJ5WQpT4XM26eaOsMV+PNO1biEL03PlFfCtjRUs5t0NK6H7lxuyketCwf1XOC8hq1Z30j/wfBPIWSZpDaiC5UrCV2EARhMuBkbrnXgiWMuJ77IIIO8mZHCMMwwT0lQ+U0uMrDP1wFQ6cMcFxLGcoPNkkf+QF0LgmVHXw/j4ROOoR8e+B29nD0vevH0SrIMXO4w4BeCMdxay6XOAFAqJoEaDhlUR0AsH276CXAw8OLazqMSckhtpga1KlUfCmSXu7jCzdMtQyI6xsI6r8KS52RDA/eXPlHMXfNIptTzLlMZHSvGG9cjcPB4y/uGL3c51yeF0JCHi3ELMEIUmkABNUtCuvzW7i0eoZs7+pbhl19hBXdNQfDDhOU2U/7BaRVAsUBaQYzR1kzOrVMiSe4hxHtsP4xWco501R4zG8E4mGB6Ige9JzkiDqLgurk6cyAoz+pQscIIry4eTZfK3B4Qe05zeuy+5tAJqTvxMNDZuYFVBC2KuXDp2BaQRDDntjGOsx3Tqz50VFD9AjPmrTGjGt1Ts4tF50+8n8bPoW5LTFeK/TFBjZhvurcy4ecyuJmkySxhtToQx/hdfWL+kjsedRXFXoNqx4Ll/RNf4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(11063799006)(3023799007)(56012099006)(18002099003)(10067099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ktxM3A4rI5NPBxyKke/ZNgNVPLmRJ2u8+VpaEU7bcHDa2xq0HIyrSUKt5hpGS8D7ij7w+9lZA7sDzp4XbbuzqskCoMKPPZU9Dso+DQpB32VgObVw7b6gQ4s6E/MKE3VuxBFvol5Uu1BGlAMXfwm1N5A3LXxF7vj4tO/wTkgkMlGrphgKkV6iDhaRui+bVVFNaMEjTJp2FKJviDpLAYfzAgzE4cUbD0GLVXw/pfzdDTrp1TBcTwBjdK4OhPVexUU+6ilF9fJDx2uLj6Qg2Vmuw612I8GVDcnadEsqt+UVJR/iALYGCGH+srs1TWjFhBMH4vOcaiRmKG+4M8fk+csMUxnEE2GHe6F9CV4awD44j0SpOjH2nwxcnkwMUXDVKoaiSMXtgTUXQNq5Ats++BnDdq4tutZKE9CfhadhewN8xmxw5WjSXoBRs00UFrDe342c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:52:40.7067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea260bd-5527-4aef-ae50-08deffbdc25c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982
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

