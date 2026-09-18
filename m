Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF82C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C124810E819;
	Fri, 18 Sep 2026 06:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YmJMRW0L";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DA210E819
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 06:57:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2xyNR+zZn3e+L33elbf/h9dhor9+iWGNosh2MIZ2B/6fNkK59Mcwf6kK/ixCA2X2hyxld7yTUKuWsnwvHw1YW1YJ801k4FA9I3Ae3Yz6HTuo24U1v/AgL+B5VyUM9AvH+KnBTI5JBSrW9T7eTD8h29RfSFDbhmGslMlGvOl3Y7r1YR9rFqt4Aym3wTKE1CXBV4ST7ZznvT+7FMbnR1hi88B3EQvqOAazay3JgS3LKU7zd9H3yAZRh44P8r5t7LfZVauWbsbQLumubzz3B9oNAoVVdKMp5kQjpRvKHLXpBFeZ/rsWxUNOePRQn7t28y4WGw3wcmcgIcpqAIIHf0RFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/R4AYxoli6kpEPXHckjWDjhH7vpfpbVEjV/RjOwIm4=;
 b=cMiobkVkCNQk5vgzYJKCpdaO5h2waqdqJ2leyzj6cHCz2ca1ZkQIJcPDbpq/cob8e6QbthzLPX4NTB/nnvleO4pM57ZZfR6T2S68jA7aKBN0gCxu6lqfGczoxpRnI54x23NhwqcyyHJkqYqLXpfVnrCBqkbIMdfth6+A2fZrRCb95xHjbKOAxkxDz7UIJxpTzoRaBYMnuZsW2U/IEKKlYsSBcDezaGoIJuHgdDs43lballQG0XYBO29Q8IAbP4CRopgi7zoX4J7KWFdGBmtO0NGLroBt5xhP3xWUbRvO5oJVvREvzYaEeOIL3Hfq17yUbuBwz5Y4E1JTc0JR3SZa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/R4AYxoli6kpEPXHckjWDjhH7vpfpbVEjV/RjOwIm4=;
 b=YmJMRW0L1OO5e93jry0k9piXVmSOdr80XLjwScFWS1Y/+xxpl+dWcEkZuLuDHqMWiPx4vefKMFviB0IqEjQf1/avAzBLgCnvPr4C48RlH1ew+P3y+MhmYJyQ1n2wZfG8N8rHhm1HQVHeVnq252tKrUu3996OUDIHIthhm6q8F08=
Received: from PH0PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:e::6) by
 SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Fri, 18 Sep 2026 06:57:07 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::5d) by PH0PR07CA0031.outlook.office365.com
 (2603:10b6:510:e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 06:57:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Fri, 18 Sep 2026 06:57:06 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 18 Sep
 2026 01:57:04 -0500
From: Honglei Huang <honghuan@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: Honglei Huang <honghuan@amd.com>
Subject: [PATCH v8 0/4] virtio-gpu: Add userptr support for compute workloads
Date: Fri, 18 Sep 2026 14:56:49 +0800
Message-ID: <20260918065653.2170828-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|SJ1PR12MB6121:EE_
X-MS-Office365-Filtering-Correlation-Id: 39871ff1-f796-4253-8ae2-08df15520d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|13003099007|10067099003|56012099006|6133799003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: G93nwTj47On352lT5n028YJ3f/idAdSoZUeeUq4nPFarjXEbnDOAdz4ofky19Wm1mDiVZGKFK1Uut3uMRw9veQhMkjSpOiQtKnXwyNWbOTKx54CBuSao7LP+iHWpCZkPEugp2ZeHA6Hx2ajXfFzODKchWUHJlwzPiPnBqlNOsFcj10GO1m8Ot+NLEwAlSZiHGprI7o57fErCLPL9PVMkDG3sZRSmYOZ+QU3pZvkPL7RCACoZTXx4OUyD6m1PcqWmIDZHS/T533+YXaZSjju83QwT+FmIa28CnPPhvsMCWEQ1vzkyB47w1BD+tK0t4k2DUFB7bJEkx/VuB0RGPiH0lcgUNuXrFqy+pXgN2JAUS4D4XAVCZ09STSbmet9SmwUu+J+WqZNSfb28nrNLldHTD1lEjJ4Y+/+dVGqMSQNuge2I5Vi74hUZl4K0sUo5ZgHng6QvkyoAYPJ1B3UgRQ9syDW8BTkLQ/8n196Lt7ZbcNfnQbL699Wz6XBCThSDA5KBUORmUtWn1ViLFoHerzZyNiCG+ywurlo6pPVcssKpZ69pWlg5MSKMoA57QtdvRXyldvL73zlmulScZP1/4gTVMH+xQb5WntClaCwqKIg6ykvD+C9aVU5NMD0rClWHcVERVVjBN2JF0OYKw+yNz5CvNJb3gSLTQswTHv7L2G0c/SSmkje4E/jY94wsI5Fz28/TserQ/8nemdkHXZA95m+qzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(13003099007)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qVKVHLhC7QIUYeCcQ9mF2VaZUNGoceWVWFyWh4/UD3chKN2q/KAZWDeUqZWGijnor93VByzF0jhzVHHzapVem2TfbUSOoydLC+tjsWaGBJh0pDxmp/lm1/DjEtTe7NqdQ0bLkNFzCF2mC6hD0//Jfu6TlYGuiqxklhcgyqUInR+JZmSJM1nIWpAzM5ODc71gXmHAN/Jc9IpMjXoDTSQ9xeO3kgj4o1MiXgbGAk3NZV8hY4j0D/tQoudTeGkMejuA16hSySSsK2TCVcc3WDjslCOBvty5GZmkvPxOZhz46EzOj+MoWpQ43Re143hgtIVYWyz1cOrj1QkAqP2xzDFHiOWpaNYFrsG7DBRPKkTFN+SV0HGALh7J4UvpTu+EY4/1ZPRGWXL4LjVboWGWLoTUAQeAsmvhpkTaJrEJ9WVdxXNDxl35XfMtf7swptNnkbS6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 06:57:06.1405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39871ff1-f796-4253-8ae2-08df15520d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6121
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
resource. The guest pins those pages without FOLL_WRITE.

Patches overview:
1. Add VIRTIO_GPU_CAPSET_ROCM capability for compute workloads
2. Extend DRM/virtio UAPI with userptr, PARAM_USERPTR, and
   USE_READONLY
3. Implement core userptr functionality with page management
4. Wire blob ioctl creation to userptr objects

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
- Request GPU-readonly backing with virtio wire flag USE_READONLY;
  guest pins without FOLL_WRITE
- Drop the CREATE_BLOB blob_flags mask of retired guest-only bits

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
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  38 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |  27 +-
 drivers/gpu/drm/virtio/virtgpu_object.c  |  10 +
 drivers/gpu/drm/virtio/virtgpu_userptr.c | 330 +++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  33 ++-
 include/uapi/drm/virtgpu_drm.h           |  10 +
 include/uapi/linux/virtio_gpu.h          |   3 +
 8 files changed, 439 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_userptr.c


base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
-- 
2.34.1
