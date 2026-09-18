Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F15C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6CE10F251;
	Fri, 18 Sep 2026 07:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0G7v7e9x";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B6BA10F251
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjUBaWzCGl3DZF8/gZks0qZMzfA7En1bwB3pm3+th4aPFnmSyIdLtFF2uS7HARdIk/N4tlP580D8RvVa/sGEtuHJJ2CmwRbtvizp8uj1PwL2ZMVE5bd5xGj9FqmbMWSYE1mXWZbXBcUUDFivUgmxcvm4sQsiV2sM15BoUb5p/0jHE57Rv9v5HXJGgmtcOxrUKBoYWI/nVLefQUf7PFIZ+30OCtiRHQmS17mTDtgipv20xj4QWC9l5e94AUOLUH/1n9pkEod2PD6rzMlXaVVXZGOyvQDCsTuO9EBnWHlwSZKy/AjXVUekcKz6bp1YlK1+K9HrhN+cPld75qUExKPOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPRkNnGi77oWVxx9H8m0ac0P+wRjKbiTgvjDS5b2WdM=;
 b=Jp1zthJHy/aSMVoxcAR/kpNUBq1JRnH/feBUFlF0653xi9YVAHSOjBfz7ZDn0FBaagF/5Ov8NxqOZ263aLZay88Iys+ATMqk2Fz/tY8fteLzBvR+a8/ADEmfBhP2SAjJ8KvF/jPa8Gh8hJ+swQN6M/PGggVx+Psr/C87CFzAmVIOuQfhv4eQoZMBQgFndCR+2w7LMv76b48foqI0JFXSncyaG0j3vGfKHadvxPZGd8KVT6I4D55RvFViD71iVvC6QVnYFgATvIu0qFZ4DPQAC9sJfannhaSOk9QtFimSHVQpnb1WtgJYD8mKIu3/49uXCNJ8BEf5IVccHQ0pWzcarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPRkNnGi77oWVxx9H8m0ac0P+wRjKbiTgvjDS5b2WdM=;
 b=0G7v7e9xhHwh55wDDFNnE8hQge4ZdpCKdkqnnt/8srNvPxC8pGqJ3lI4DnpycXNH/3YZz2Cg6O9nhIyxYp9i5CHMn5cx6nt35Fbf+y9V12LNJSgPVhWnqCDBcZlGTnxhmsUTn/9f5rxWD/9DBpsd2CprdyzPTNEMjobHphrjDII=
Received: from SN7PR04CA0028.namprd04.prod.outlook.com (2603:10b6:806:f2::33)
 by LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 07:56:12 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::a1) by SN7PR04CA0028.outlook.office365.com
 (2603:10b6:806:f2::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 07:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 07:56:12 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 02:56:11 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Fri, 18 Sep 2026 15:55:56 +0800
Message-ID: <20260918075600.2197253-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV2PR12MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9357a5-4465-46a3-ed17-08df155a4f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xlxOcF/ymOje6Z4plkFs88o9hG9XZJfO+BALMgJ4SF5vkL+JxxVCxncYd/0n9oYbp+IKmpP3A9NhFIKiNui7V9LqeKjN7gtnSd6dMX8es/3oVtUk60EShB1iUITMANRoZZOUa8MMx+4XCLQttiov4M/dKmh25a5ApkWUWUbDY1Ccq403zl6wVHOHQfMGc1FKaNG8jw2rYBvaFxY9zXgk+FKMyXCl0+g4wWSJTpGJ/F1ERIpcjGlbLwrBrH09KqoCRnACblUAs+nnMcL6g7xKAjY5OHpII5wAE2AmR3U0Ne8sd0AhjhRyh8bwnQ6e1xHBBI+q+zk6W4P2Budcd4YNJg39jdLM1S2IclLiC3mUp19JM8/+e9joiddJZp4Bf8yX1Hs0fO1Uko8smxdJJOfNRvjlvNOfvBa7rKCrHaxcOqp095hn/tITPyE2CV/kW6HYMhrWKJAoJmFZpoVb/VGXQ560GEDpatKQ+b0HiSXPqkAlnTwysLC5+buiXGRQpRnin2NrDhTFbzzHd3tAorxvbUiUPkGygErcgxLBy8iE23Krl1zCccGXO59GdJZTpp8HcxnZqciLu/kkIKgRTXdKYE1VBRrvJTdM/27Ll3LuKakteWL+ACHygLh8kyPSJCbLAr3eo1lLMbagb7v7JPkrk0t3EMUGox+QIR2V7Kg9/ttu32WqiWjVAULKgVB/qqwarrnPf3cwi51YhjJObtYVPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cJpMkGhMPssnhixoPCboT66tQr/yhIG2PE01HfxLJdbKII1BVFg1KCML1EpXveZk3K1pQ+7G9CbtnGNBW7c9b6Pixy5dOT1lEIOTN/V21AljXwSgTN2vdSxB5POdXrwD0Hoz5t01knuEDCMVhkcBx5g0oRNSLc3OMU9Cgqvvra3plFSXhhMakLy/Br5w3EICruWoE49AhaMeF4tg6NKhyCKH18YKM3ZZTIOV5TU16cAdmmYRUaBBSFJTKjTU3NNsm3nMGAF45Ouoe3BdYUnmz5PtJ4y5P40dYF5lM0yujdslau9ZTBd7z5KGzqg6EZ+jsSqDba/SdtZHtqskhG7ZrIfTAk/5Ykd0JO6alcIPBOQ8KF9Ussc9gqEtc0A9aiTAghfShBe9PRIW9TiehMLqzodTycIy6zqDwzVgvIBa4+mLB9838TDGzZCrAJN59pRg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 07:56:12.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9357a5-4465-46a3-ed17-08df155a4f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  39 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  35 ++-
 drivers/gpu/drm/virtio/virtgpu_kms.c     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 330 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 ++-
 include/uapi/drm/virtgpu_drm.h           |  13 +
 include/uapi/linux/virtio_gpu.h          |   7 +
 10 files changed, 462 insertions(+), 17 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
