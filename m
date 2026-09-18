Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DFAC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFE710E808;
	Fri, 18 Sep 2026 05:59:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yG6sFsEk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012025.outbound.protection.outlook.com
 [40.107.200.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CBF10E808
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 05:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uu/DDfb6vqXzGfj8ggLGebBW4y/j//XQvkb/oWdwmFmd9x3IJ2aPkF59C6z1oCXsupLScxK9ZiphuZ76I9FuAxj0WlyptVfBFxbFWPixfwDkp8aBdzpZqUy2gpHGUyZdp/ELxE2Q6lEzKe1HtQQ96kXIWQbmACtz2wtdbODDCZFuVHz8MjKGYBZlXK5aUbwLjA05Ueq1w3JBWaA+u8alKInx/8D/GcO5PhiL+fgW7U/oEJyHuktl+CK4MLXZhpMEcj4PfpixOFDjTNEOvyteKybi7NakQz/NTXPsc91e812qPu7E36StdIiIe5+al3RZQfV4G8mEGK3VGve7FvcOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWdutmH3Eppi7JuO/T9+pybjNTaTpqbp/dXdKOngG0U=;
 b=l8BXrxkQ++TksncYzR1W0cDGVe/el7d2MZg1uA+F/dPG09xAWtnKJHBwxPcy8EVhAS+7tq85PebZCrK4SXy16FOySHyJFSsDv5lx6PRGSonjsF104XtsNJv8zQ5NAeppERtwQKlZn5omA7MhsNRQnsLXYrB2bO8ZQq/8gscI6p2pNmniAm4BO+mWXNB28dK2GrAGJ8wCpkmAWXLOc8VXPw1h5gt/8PCmz/Owlxzpyv3ro41Uc+Qb9/iaR7QQ3ssHF/LhPP6BMIU3oJaAP0eCCZEJWFPlsVRE7T411cXKFE4VMlvoPZZSLsU6y+lWSogx1QDgDDAUAllXIIHQBL6aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWdutmH3Eppi7JuO/T9+pybjNTaTpqbp/dXdKOngG0U=;
 b=yG6sFsEkkNc8CvSVqIjdxsNFMzJlRYvJkwVc2/tMENJBdzzJXEBzsnS2zSYHJAPn+cA3xRlslzRXE4h2WcF55Z5XeiOV3O9ufAGwj5aP9T3gJQEZXYnOeqBxeYPql2z+enN1j8NnoKNKy6kn2Xf6nttXIr9Nb8gleX6vPc7cG7g=
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 05:59:30 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::77) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Fri,
 18 Sep 2026 05:59:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 05:59:29 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 00:59:28 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Fri, 18 Sep 2026 13:59:13 +0800
Message-ID: <20260918055917.2133574-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: c0852ca4-b325-4490-39a6-08df154a00db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: uccu+hSql8Hx+pXtrMfl5kZ115xBKGdaCZtHDblB/dPvgLIzhe3MpmQIM8J+eqCjlVGdtTH+JFlmSgqIjwyf7u2Fj7yeKEvFcQS0npE92fQ8BJU+PmuxxJ+jQwuE41K8pyGFzQSJdCOQm8B5xnKzB7iGx11zI3feMowjFxcU18Dr53pZunOur50tHmIdXkVX9J45/t1Qw0iV5q2fcZp88vWWH+jSkV/ruB+QXZOGQNNA+UkIwvv6GIKBGWh2rWGaCtjCKoyz+3g+y/vfozTl921r1BM+2mQdQGaxEXQ7xhh4Aa57SG0s8TqrWv8yqLIoX3yDXDEDnuKLe07nTg8dIfzt8KpdTv78KIwK22yF2meVjrmAljnd5r89tEQtoZ9PU5lF5f0ZKI12xYMv/daHRFYrxwhcm5QVsFfjO+EKHfx6xe8Yq8lEcYA5FVjeIKCDNuvrz65G4/aukpP7JsKXVQ6psyCCgGNTsB2NMi9jKb4TESbQjAeOvdk4WV1tojRvxitMIGJeqLN+jR1a2m5Wxlj1CACcRGsZ3m7w9yq3EdKritLVRimVruep9BmEdlVQUIlRB/roT1h4CuK4ZsDS8g8vvj6rXkF+j1MGrk+oGqrfUkLq/FrJbl71yOpYfVsJ7qVf8PiETmV6ce5UmgJ0icmVWVfsGbxqNLCFPymq2wbpod1l4Gx5nXqSYRg+rIJ/8eqRFTUC9CjHWx4UKqQ2bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YBZacslZF4LPOuxmemvOmDshkkCEMxiDYLGijt7PlyUNjnBhezYR4g5AP0l0vkblLtXV1HkpcnNqhqQ7KE8skqJd05DXrerhV5FIk8CBJHFRv0RA8SaBrdDwagcYTT1MgcPonlEh7D00A6NorgI2Tv+vEDhcycKdRDFgQtIArdigw4bE5j0xPKn1Up8ogMjsg0cYI0FRbKwQlsUC9RwRbDxm3iD5Yd39BrSlM2zEkl1Zkr1Y4zIUG4h/fPE61OLy9PyWAWU/vcE/8ka3E/hz4Lf6R+cehEmk3H6oiwu2vlElAud/MNLcMlyI7Z1UF/TxXbb384rIcw4BIURNxup8JhrKvppHKVhPVRGJvtH+8nJQtTT3cmCFLk2CCZlnYyutaUuSgBdcuBeE3GjCcN9vBhj3q+QIvOSW73tFsd0ExnD4v6z4Wg0z3ntT3gqnoxrx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 05:59:29.5605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0852ca4-b325-4490-39a6-08df154a00db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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

HINT_USERPTR and HINT_USERPTR_RDONLY live in blob_hints. They are
guest-only DRM ioctl selectors, not virtio CREATE_BLOB wire flags.
The device does not need a new wire flag. CREATE_BLOB only carries
the documented wire blob_flags (MAPPABLE / SHAREABLE / CROSS_DEVICE).

Patches overview:
1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
2. Extend DRM UAPI with guest-only userptr hints and a userptr
   address field
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects

Tests:
- Full OPENCL CTS tests passed on ROCm 5.7.0 in V2000 platform.
- Near 70% percentage of OPENCL CTS tests passed on ROCm 7.0 W7900 platform.
- most HIP catch tests passed on ROCm 7.0 W7900 platform.
- Some AI applications enabled on ROCm 7.0 W7900 platform.
- latest ROCm 7.14 and ROCm 10 testing is ongoing.

V8 changes:
- Move USE_USERPTR / USERPTR_RDONLY from blob_flags into blob_hints
  (HINT_USERPTR / HINT_USERPTR_RDONLY) so they do not occupy virtio
  wire bits
- Drop the CREATE_BLOB blob_flags mask; hints never go on the wire

V7 changes:
- Mask guest-only DRM flags out of CREATE_BLOB wire blob_flags
- Clear userptr->pages after pin failure to avoid double-free
- DMA-map userptr SG only when virtio_gpu_use_dma_api() is required
- Use DMA_TO_DEVICE for USERPTR_RDONLY
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
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  38 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  29 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 330 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 ++-
 include/uapi/drm/virtgpu_drm.h           |   9 +
 include/uapi/linux/virtio_gpu.h          |   1 +
 8 files changed, 442 insertions(+), 11 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
