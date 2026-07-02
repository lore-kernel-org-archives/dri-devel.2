Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8CAC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888F810E4D3;
	Thu,  2 Jul 2026 14:31:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HEo2Y1fd";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B29210E4D3;
 Thu,  2 Jul 2026 14:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6Pho/9w2FLhSHGbaiKLHw4D7yaCi6dAiAAsFhxKpkS2BSFHDrKrAR21dVmtHDxIC+lXdQseZ7rrl3s/An2HYlUr24E/MQHo5iQHxamXYsBGv5/Sy630vxpWZgyDAc80XdwkYN5sALh1bcgn2lXoaGIZqnFX+nowrr8X2sYGKc7o30N8XcchxNVZU3d+TNAyL3OUw+JT1kiftpIJ+BFUPe6TDhukAXQ3QiT3VfmpNQzVY614lbk5J/Hd+kN+l698yzpdklH4ZzQN4dfUy1Z5Pnn8feAfjVULOy2zTjPOtfSlpoEPvXmbYcsEPnBNFsfMDUuNPCn6mcABAo+H5YejwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbtHDqtOCQar3R/d0/6SJDOKpoCD3iTKb06PxSebdUg=;
 b=oZBUvNIgdtzJnX25TgQb41fx5EwagHOqr5J5uZLyges21p+dbsjWyL8ho/ECmdYS3gzOEwF2f2gYr0rWtwXXfbf75KwwrN6dwhAJ6+1t5Ks9lb63l5kg1caow2yqf1VkLFaqaPLQm+qKQfOwv7XOHlKAB08pKTo4gv0QCxug28MUjWT/1jGdHuaqH64trF8NK3ZrkEUJdTR+tJTVUDUGCvNxSbPlbsAVzJQFslxBbGh5fiZkzpZ2lJp0jkiNP4S6v40AxYKCV3Pi5B1XUIAoa6TzQbjNO9g2FaNu/yMS1iets/H9cDHZsxOIulj3Ufd2U1/jgjwOTmV47vRdydigEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbtHDqtOCQar3R/d0/6SJDOKpoCD3iTKb06PxSebdUg=;
 b=HEo2Y1fdHEtbZ5vNsQE29ru1bR+5q+I9aiuGbhK89CxQKzwwOotSM4wrFULLCF1kk07j3ZfiRv8ARy5btirxNUT8UJ9MQweKZeKi2+aFPYNkrf8TdEyO28N+GqcPMX1IAkX6VwOI/Ik9/sZZXfVw6UtsYvUw+/V19jCmZRZrhJQ=
Received: from CH0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:33::23)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Thu, 2 Jul
 2026 14:31:47 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::1e) by CH0PR08CA0018.outlook.office365.com
 (2603:10b6:610:33::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 14:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 14:31:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 09:31:46 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 09:31:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 2 Jul 2026 09:31:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.2
Date: Thu, 2 Jul 2026 10:31:36 -0400
Message-ID: <20260702143138.68463-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c0792a-b384-4948-25e6-08ded846a537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|6133799003|11063799006|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 8Dm6QaLebHL2phd9QTm42bJwUE4UQsqlNYI83OB/+up717E/uBuGCHDolRLxLnEpdMk8Ssgw1593INC+Ns0EKsTGJijPLscn1w9knEBX8ELoiAqLcjHGYj3NiIg8DT9NdafiG2C4XzyfUf8gaejgAINawpiTHZTIyiPFv4ezrs7ftyGfQeAp9bvXSKME2AsWHXNrhQRQYcwlObbeq9YhBzBcbBgldTNtdabQP2cM/SBAm3AZLUvDc4defn2hPd7B+Kdl4goizoJbwpI+pbMNb3lGQFBRhKQ29TTvAt0bwgtHwR3vBZX5P9tBcXGsof9Q6IQRHfNQYVEFe0fTa/F2QW2FN2rCLOWW2u6UO/uaUuOZ51VTKs87BFI4f+QWf59k6khWbDSUdwtefOHm9lOWnPbFzL4QMcUOrNdNTyyF1tlNK6LOZ8HPgRjxdp5IQWeU0BUo2qceVoubEuw76Dygtt6A8MVjaBa12fHionlVOYJNc7pGS4YAXTa9uASyNZj0i2dFq7kYGKZawoZ3lq+Gum3kZSajvccE1uZCH+0NtuQ/7gBNLjVbKL7aWRZvZ1O0l54DsJLVGg+Gj+QnAY0d+NE/ztu8G2iTYCyFtf7EsWNOb+ELnjBHn0gupD9RPC75VaYwKpjp9iUkFgD/ICLSqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(6133799003)(11063799006)(5023799004)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m2FWjqDrctqShCKvIiOJxZ9g53isJ/Qxx/oGg8JjLTDCgm/wy4xvILLoAxmfg9YciQJuOtOj58mblVlg37216XpGhhtaR1q40HLxbFjS3OnLUtwzvv9VetdaN/9xcUbmpj/F4ItZYPhiACe4tCQW3LHeYk8QrMdCC2jd9S3YDygmeCiJ7gtkrzl3O639xMoHZx8IutIfjy1jFt0xfac/65GwPPINX+HRYUAyt3o9WE1uXdASAf52YCNTGE5X13RwANAEdcaYG7FMrBelOEAxTHG6DXcJIpqh961IzszmUWBkuQw9Rz/264jgCI79SMROuf36P98rLif7Aju/grFdVtG2iEgxK2j2FwpxVzvTUFx5nbJ5yfw8K4tpF3ITonpIoIrYbgAqvrNqLlX48JvwM9hoduF2wkO3z66wQy2GY2JFgLuq2CS0LR5U4htsrnP4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:31:46.4060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c0792a-b384-4948-25e6-08ded846a537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
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

Hi Dave, Simona,

Fixes for 7.2.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-07-02

for you to fetch changes up to c44af3810fc8b3adf6910a332038aa566560c8fa:

  drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection (2026-07-01 13:02:53 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-07-02:

amdgpu:
- Soc24 aborted suspend fix
- Drop unecessary BUG() and BUG_ON() from error paths
- SCPM fix
- Power reporting fix
- DCE HDR fix
- UVD boundary checks
- VCN boundary checks
- VCE boundary checks
- DCN 4.2 fixes
- Large stack allocation fixes
- Fix aperture mapping leak
- UserQ fixes
- Ignore_damage_clips fix
- ACP fixes
- DC boundary checks
- GPUVM fixes
- JPEG idle check fixes
- Userptr fix
- GC 11.7 updates
- Non-4K page fix
- SMU 13 fixes
- DP alt mode fix

amdkfd:
- Boundary checks
- CRIU fixes

----------------------------------------------------------------
Alex Deucher (13):
      drm/amdgpu/gfx8: drop unecessary BUG_ON()
      drm/amdgpu/gfx9: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx9.4.3: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx10: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx11: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12: replace BUG_ON() with WARN_ON()
      drm/amdgpu/gfx12.1: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma4.4.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma5.2: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma6.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.0: replace BUG_ON() with WARN_ON()
      drm/amdgpu/sdma7.1: replace BUG_ON() with WARN_ON()

Arnd Bergmann (1):
      drm/amd/display: avoid large stack allocation in commit_planes_do_stream_update_sequence

Asad Kamal (1):
      drm/amdgpu: fix aperture mapping leak

Boyuan Zhang (5):
      drm/amdgpu: fix division by zero with invalid uvd dimensions
      drm/amdgpu/vcn4: avoid rereading IB param length
      drm/amdgpu/vce: fix integer overflow in image size
      drm/amdgpu/jpeg: fix jpeg_v5_0_1_is_idle detection
      drm/amdgpu/jpeg: fix jpeg_v4_0_3_is_idle detection

Ce Sun (2):
      drm/amdgpu: fix resource leak on ACP reset timeout
      drm/amdgpu: invoke pm_genpd_remove() before freeing genpd

Christian König (1):
      drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx

David Francis (1):
      drm/amdkfd: Use kvcalloc to allocate arrays

Donet Tom (1):
      drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K systems

Granthali Vinodkumar Dhandar (2):
      drm/amdgpu: add support for GC IP version 11.7.0
      drm/amdgpu: add support for GC IP version 11.7.1

Harish Kasiviswanathan (1):
      drm/amdgpu: Fix kernel panic during driver load failure

Harry Wentland (1):
      drm/amd/display: guard against overflow in HDCP message dump

Honglei Huang (1):
      drm/amd/display: use kvzalloc to allocate struct dc

Jakob Linke (1):
      drm/amdgpu/soc24: reset dGPU if suspend got aborted

Jesse Zhang (2):
      drm/amdgpu/gfx11: fix EOP interrupt routing for KQ and userq
      drm/amdgpu/gfx12: fix EOP interrupt routing for KQ and userq

Leorize (1):
      drm/amd/display: set MSA MISC1 bit 6 when using VSC SDP for DCE 11.x

Matthew Stewart (2):
      drm/amd/display: Fix DCN42 null registers & register masks
      drm/amd/display: Remove DCCG registers not needed in DCN42

Natalie Vock (2):
      drm/amdgpu: Only set bo->moved when the BO was actually moved
      drm/amdgpu: Rename moved state to needs_update

Perry Yuan (1):
      drm/amdgpu: flush pending RCU callbacks on module unload

Prike Liang (3):
      drm/amdgpu/mes11: set doorbell offset for suspending userq
      drm/amdgpu/mes12: set doorbell offset for suspending userq
      drm/amdgpu: add the doorbell index input for suspending userq

Thomas Zimmermann (1):
      drm/amd/display: Handle struct drm_plane_state.ignore_damage_clips

WenTao Liang (1):
      drm/amd/display: detect_link_and_local_sink: DP alt mode timeout path leaks prev_sink reference

Xiaogang Chen (1):
      drm/amdkfd: Guard m->cp_hqd_eop_control setting by q->eop_ring_buffer_size

Yang Wang (3):
      drm/amd/pm: make pp_features read-only when scpm is enabled
      drm/amd/pm: fix amdgpu_pm_info power display units
      drm/amd/pm: fix smu13 power limit range calculation

Yongqiang Sun (1):
      drm/amdkfd: clamp v9 CRIU control stack checkpoint copy to BO size

Zhu Lingshan (1):
      drm/amdgpu: reject mapping a reserved doorbell to a new queue

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            | 13 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 12 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 46 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            | 17 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 58 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  9 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 13 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             | 78 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             | 69 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             | 24 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 10 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            | 11 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |  4 ++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  6 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 | 56 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc24.c                 | 28 ++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              | 15 +++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           | 12 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 10 +++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 25 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 10 +--
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 16 ++---
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h | 62 +++++++++--------
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    | 15 ++++-
 .../drm/amd/display/dc/dce/dce_stream_encoder.h    |  3 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.c    | 30 +++++----
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |  2 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 | 26 +++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 11 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 15 +++--
 62 files changed, 541 insertions(+), 268 deletions(-)
