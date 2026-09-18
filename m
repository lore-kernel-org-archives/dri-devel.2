Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722B7C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69A7610E643;
	Fri, 18 Sep 2026 08:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ri6663KP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C0010E643
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 08:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbgp0nZlM+LlHJhxglZ9ceSTCMw8D8wB9jwmvDADnslUTTqL6457wBEtR3lrg0sysOTNMe1w0F9jn9Wh5ikMMp7jHIbJQbwr52kd6flzFUrQ+mwcTXJojIoG/Vlm4cwofc5OwKgZDdfD3dIu2cG5r3cX8RR/vnKjERXCPPJVHgSVSHGz+KIw7V49B926dJiKpAgcRfgFPjraNXel7Crq7qbnPMYo0mzsDi+2B2jzpRya7ew0S3rCHf/4h9RvN37iQg+d8UpiS024Rw/1UJ4U0c6vTCVsWdDKnyvN6qBUO+kCiVvVS+C4nK6nw8wE6B027Kh9GlUstLOAgRzEl95h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x41LyXrH4JYVgFWP+2IYuK3KFfLdptTo58+8pef3ieE=;
 b=cvwSh94VhnScy0hYWKXhcCYMv5gKgrwOECHeL/C/KWXnbvqt2hpwoxdHBOMJpRtwoh74JXOJOW1VCZf6IQQslup88JBSjBIwFyjEWBFESxCTT3L4UGzjB0fT0orj6kcgTzcigIeID96SxH3cFom4ZSEqFUFcop3fBKg0EJMbydp5iirbw5OAIC4jKI7I84HpB3oWZqoyOJO1BnmD0DjKmGgRDfbCfCPLp4mkQ+qrm6fUb6DQiLcGCLnra4lx4gKvLBbK8xoGPLpdj7dP32J647eXTelTlP2l0+qwSyfeFmNFvVp1nME4bcqZu2MOs+suZS5o6rtm9b/XmZOkH3gVfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x41LyXrH4JYVgFWP+2IYuK3KFfLdptTo58+8pef3ieE=;
 b=Ri6663KPGwRIiXQQcU0V3eGQaw94ihVw/NsDNtlEHTYfR++SF3cRqkSi7qvU6g3Jz/f8e9P45x97MxACKkORSKjY0afVcnEK/dGnh2PfboTR/s2oAk6ghoObynxScLBlKyWFKfXUkuiO7poGHa4q4oebuQmc//rO5flLAZ1i3Ds=
Received: from BN1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:408:e2::30)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 08:23:24 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::4d) by BN1PR13CA0025.outlook.office365.com
 (2603:10b6:408:e2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.9 via Frontend Transport; Fri, 18
 Sep 2026 08:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 08:23:24 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 03:23:21 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Fri, 18 Sep 2026 16:23:07 +0800
Message-ID: <20260918082311.2213619-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a154823-d5b4-4534-8ef0-08df155e1b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|13003099007|11063799006|10067099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: jdkRpN2t8PF8Hh4ueF3eyaBJ5Z72Y5QbeMH/yXtS5SYoTBXScnjo94ce3Zs3dunPh/CgnXPYn/gPTvzkpWF/oadgzdjCO+g1MOVny2oFJNRf/ML6TBfLzm4kCcThUU/3srx5MXIP+5WyduRtgwUigh1itHjjkZ5+ZqRSyEnj2O7n+A+mmWwimq+u3jYGiwXdkDx1yPFxoMPfmb0YPFm3hBAzpAlaAMWirB5hULA563h9i6/0rcd1N7VGVcYwZkQucGt6rDp6k8wI6HfjdguPw1p/tmoDXUuezfLZaAAUYPD7HnhPFWJiUHZWIm1en/m4ZpPUGyzs65kyfx9U2SqHH0mqC914kaaRlHHwU47Dm0GSA9KNRuLpKG8/lSZfpGUcNydYuRqQsJ1ewDT9IfV5GZZIHeXCBO4/nl6/NeJhqND23bizpbsxGjnhONWBEzuaE5k9ulzFC1YL8Y+7MiU2o3NUPJFXARiNF72x7frc10G0EazD0MB6NYP1H9baGahqM3BuirlZGZlFk7GACvdMsC69WriR5Lg58HTENhH9qWwm/U+irRweuF0j7P1iL8c7G7Vl02BXGqaaRmgcdRKoc+Hs0YlxEgI8Yy4MebFl8PRvJK5rbA8VbtvEc6F63JmCfGBPG7lzghnsqGEcBQN1CMxnb4VmBqj2ChpFtDT28JpuFXCj0zlfpPiRif2Ok8XNprCeFm0hJQotp8vnBNb2iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(13003099007)(11063799006)(10067099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vadFRDtJNr2Y8smJLrYHrOGInDUJQeDATga1LYBL6y+LKMKg76ITEn/NdR7vTVl/AUmRCcb4La5Os0D0+Emk2uLPCD7OvKhi1z92I9gDfP6Zp/XJQrZPIVeiVG8wDvOkGGQA6ME8kxQ38jb6e4EzEeLde7CoxyGNGpv8OKqapMUbA/WY3lMqC+iU8Qm9K12tYz4WdEYNIO+lgIeCagaGvZ/JdHcnk64uVom20oBDLrdgi6i3pUFty54ICAELOPPOMXhWvFFbwSOsjATOzm10A7wQNEJ1LydH/fKOfdzupCAa7oVvwsEJSpOCf7RKIbpGJdTxnJdioX9lH9aGuxxBDWPcJKq6xXRmA0Tc4Mj3BLK8M11APkZ0rNnIsQUj7C0T4ZVd09M/SL++c0MoyjqInq/t/y4GeH6Dm0IaBHCyAZ+DkE6diyMIogmDBgbgaaM+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 08:23:24.3822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a154823-d5b4-4534-8ef0-08df155e1b9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
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

Hello,

This series adds virtio-gpu userptr support for ROCm native compute
contexts. The guest kernel pins an existing userspace mapping with
FOLL_LONGTERM and exposes it to the host as ordinary CREATE_BLOB
backing entries, avoiding a second shmem allocation and memcpy.

A non-zero userptr field selects that path. Probe
VIRTGPU_PARAM_USERPTR before using the field so an older guest kernel
rejects the request instead of silently creating a shmem blob.

GPU-readonly backing is requested with the virtio CREATE_BLOB wire
flag VIRTIO_GPU_BLOB_FLAG_USE_READONLY (also
VIRTGPU_BLOB_FLAG_USE_READONLY). The device MUST NOT write such a
resource. The guest accepts that flag and pins without FOLL_WRITE
only when the device advertised VIRTIO_GPU_F_BLOB_READONLY
(VIRTGPU_PARAM_BLOB_READONLY). Otherwise CREATE_BLOB fails, matching
the CROSS_DEVICE host-capability check.

Patches overview:
1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
2. Extend DRM/virtio UAPI with userptr, PARAM_USERPTR,
   USE_READONLY, and F_BLOB_READONLY
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects and probe the
   readonly feature

Tests:
- Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
- Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
- most HIP catch tests passed on ROCm 7.0 W7900 platform.
- Some AI applications enabled on ROCm 7.0 W7900 platform.
- latest ROCm 7.14 and ROCm 10 testing is ongoing.

V8 changes:
- Drop guest-only USERPTR ioctl flags; a non-zero userptr field
  selects the path
- Add VIRTGPU_PARAM_USERPTR so older kernels do not silently
  ignore the new field
- Request GPU-readonly backing with virtio wire flag USE_READONLY
- Accept USE_READONLY and omit FOLL_WRITE only if the host
  advertised VIRTIO_GPU_F_BLOB_READONLY
- Restore userptr blobs after hibernation without the shmem path

V7 changes:
- Mask guest-only DRM flags out of CREATE_BLOB wire blob_flags
- Clear userptr->pages after pin failure to avoid double-free
- DMA-map userptr SG only when virtio_gpu_use_dma_api() is required
- Use DMA_TO_DEVICE for readonly blobs
- Sync userptr SG for the device on TRANSFER_TO_HOST
- Mark writable pages dirty when unpinning
- Reject USERPTR unless blob_mem is VIRTGPU_BLOB_MEM_GUEST
- Disallow PRIME export of userptr objects
- Note that CAPSET_ROCM uses ID 8 because ID 7 is taken by VIRCL

V6 changes:
- Rebase onto drm-misc-next
- Keep USE_USERPTR / USERPTR_RDONLY as guest-only DRM flags; drop the
  virtio wire-header patch (5 patches down to 4)
- Fix userptr lifetime, DMA mapping, memlock accounting, alignment
  checks, and PRIME SG export
- Updated corresponding cover letter and commit messages

V5 changes:
    - Add VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY definition to patch 2
    - Dropped unused VIRTIO_GPU_F_RESOURCE_USERPTR feature bit in patch 2
    - Included VIRTIO_GPU_BLOB_FLAG_USERPTR_RDONLY in VIRTGPU_BLOB_FLAG_USE_MASK in patch 5
    - Add check for userptr feature in patch 5 before creating userptr blob resource
    - Updated corresponding cover letter and commit messages

V4 changes:
    - Renamed VIRTIO_GPU_CAPSET_HSAKMT to VIRTIO_GPU_CAPSET_ROCM
    - Remove userptr feature probing cause it can reuse the guest
      blob resource code path, reduce patch count from 6 to 5
    - Updated corresponding commit messages
    - Consolidated userptr feature detection in final patch
    - Update corresponding cover letter content

V3 changes:
    - Split into focused patches for easier review
    - Removed complex interval tree userptr management
    - Simplified resource creation without deduplication
    - Added VIRTGPU_PARAM_RESOURCE_USERPTR for feature detection
    - Improved UAPI documentation and error handling
    - Enhanced code quality with proper cleanup paths
    - Removed MMU notifier dependencies for simplicity
    - Fixed resource lifecycle management issues

V2: - Split add HSAKMT context and blob userptr resource to two patches.
    - Remove MMU notifier related patches, cause use not moveable user space
      memory with MMU notifier is not a good idea.
    - Remove HSAKMT context check when create context, let all the context
      support the userptr feature.
    - Remove MMU notifier related content in cover letter.
    - Add more comments  for patch 6 in cover letter.

Previous version:
https://lore.kernel.org/dri-devel/20260917102540.1312102-1-honghuan@amd.com/

Honglei Huang (4):
  drm/virtio-gpu: Add VIRTIO_GPU_CAPSET_ROCM capability
  drm/virtgpu api: add blob userptr resource
  drm/virtio: implement userptr support for zero-copy memory access
  drm/virtio: wire blob ioctl creation to userptr objects

 drivers/gpu/drm/virtio/Makefile          |   3 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |   1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  43 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  35 ++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  22 ++
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 365 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 +-
 include/uapi/drm/virtgpu_drm.h           |  13 +
 include/uapi/linux/virtio_gpu.h          |   7 +
 10 files changed, 513 insertions(+), 17 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
