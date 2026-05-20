Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D67DCD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:14:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3802C10E21F;
	Wed, 20 May 2026 18:14:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEo+hAUe";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0143210E0E2;
 Wed, 20 May 2026 18:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvBcOEdOv65A/lYwZKvfHPmvRrqP7tNr9hXlk9V2OKlXWwy5B/GJWx7JAJbZE0kusagd/PhvYGZ/HkaQsLKs71+GS9AHTBTDD59cGYM5oypwI5J7qYdtNjdEZg0uKfehlzRFfN13GAd8c10aWDTutPJdX56qGuDTO28w+g1z+9rjlMGfHy1UZMLoi3I3q/i1Lt6+pZhKCZR6IqTfRPzYxW0tXjtB9bsl0OCubpzTNCAWQh9u3i4iKpkIML4L/Eg/6fdRRLXH4IVz0Zq2xnP2Nbh/SKzdgZn6Qcid06UMMDub4sWaqA03qe51RkaZCJPq8cuku/QQWsXreBVv28TSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJIOXBY+31PCI4TRvVqmFxxghKZY1oVg2Hw7U7zhI2Y=;
 b=E+meYfh4rO3b3VfHkMlXrZDLMkuMwPLaXO7VDMXmtDe/MvOGto3JGRxf9W81rOX6Q62JVOsCGKe5eUWAxDgZvKfKZjgkclDj/lWcZzIEnuLOcxcgL5r1/SlcrOdWMs69RWfN1BqRQYK96m9McgS6RsPC2ZTJPnQc2YsHVz5YjmZk3Sh/x1zm9NpYOavLbQS102O844oJgwA9g3RBPmtN8dQigf6KrRw+PCnuRpvCZw5k6i2IblxBNK+74P43eLdtKxI4ecd0ix4xb3qG0Jw2vRWqMW1GcFiwkoApixRPw5fUfqDy7+OnpowaT85EY/ZoAiIiPt9aR+GwwmW3hMzWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJIOXBY+31PCI4TRvVqmFxxghKZY1oVg2Hw7U7zhI2Y=;
 b=bEo+hAUeQAJrf/oHoQ6ni8NXxpxOdJnIyEZw7/9qj4Xv2o6B0fu3M6ClGvXR9j/R+nNy8e4wj5dCJrL2FzyrQB79eNY2w/0ZMPcZLHFgU0FIUbB1Elga4VjfL/S26ZRJqcz9bDTan718HlTQa1jF9Xk9aWG9EaIcDZImKEYAXzc=
Received: from SJ0PR13CA0133.namprd13.prod.outlook.com (2603:10b6:a03:2c6::18)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 18:14:08 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::34) by SJ0PR13CA0133.outlook.office365.com
 (2603:10b6:a03:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 18:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 18:14:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 13:14:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 13:14:06 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 13:14:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-fixes-7.1
Date: Wed, 20 May 2026 14:13:59 -0400
Message-ID: <20260520181359.28421-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: d9dcca98-869d-4221-2cd0-08deb69b955c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|13003099007|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: TcZOdqCM9DoVRR14zkMff3Mo/V31mNnEfTIMr1qxLpLNTvtxI23lZVJbMohSHIcWzAwsWJ4eawL5/gYlHDsDyfDsC3xQFcHlYwPuYt37aV6AsRjqOMvJ2eIBTaAQQGr89LMsd+T7UtDieiKRh9sDlYTgeZNBj0GDe6AVd3Hrx6XF317sxgDWDUtdoS42ywUPem4JBovVH7ARI9v11QR3UCqpQe7vg3cxc33kNQjIAZxyWz2LsyCza1n5hMJ1QFbSNcKfsJ3lYuaugYLj2fl1oZcMB6lUsAZjKMzF1c/uLL7RGODLMNRG/deLywLsZNL+2SsjHZBpROBXyhb9HeyNrhW/8kqK+Bh10aW4krzMNfrB659AyWjGBDVAl0k7hpSvUFACmRzfgVKNflS8/SPX2bAFeTNiyMbaseGGOfJskx1jQ7ksooqPaWIhZ8m/BUiIK73OhWdP1uD4TFt3MtaGJxbkFu2SAbuUWxHlBlG+qxaO8oqdIY43FFqTdMyYz1CW/7XHqKWgN79xWbLCgrjFafSt5LQtQIV7NqwuTq+dxRa6RNqZo2pT8xYCzuFK57SIEfj47tkxllNLSiEHkja2pm9UN8gDJksiL7NbakDeKmGKq2U0URCO3pcfK6U1uYPd8FoGJ2gcbfADyvcIMZCEl4LNKO/KtTr2LuTvz1St+SBFd8V8WbjpNmFJ6/w08qvN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LdcC9xNBfDCsa1NSKVGIzQ1wljeSr4fPeG8EZAUxv+u9JlapsizSpoVOZh0X6BJOPTFp7ZSmPLC9ENlEw4Iod3OrYc66Ce8+ZbgEqE18WkimzktfsFvjHAOjisLFKnZCSWGGgKPHPzvUU58AXGwJcyzxTbP+Wg58AcM0cFFuifTwLqxliFvrQM9uTLgmHz3IvM217h62yV+j0a+O96n5l5zQyF0AwxX9K9MdhnLTui7YsSJr3Tei3Y/yX5AKfouGRyt7LTABm0H5Q1AFrYdLjQXUE6aofUc3buMMlhp6oiy8XMZIiKkzHntuOORbwS7L1Ms/YYiG3/JD8GlSgccLL5M1qOehrkqoJ3730Vyu7v4iuK6PuErmlUub8dv7CoHCVB8BGXqS3BX3o4d1OhO9X5Mlr2xI/Gqgozu3ozKR7I5BUZHBq3KEx6hMiS5P60RT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 18:14:07.4419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9dcca98-869d-4221-2cd0-08deb69b955c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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

Fixes for 7.1.

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-05-20

for you to fetch changes up to b6fe4ff340560ecf39e10733366f85832550699a:

  drm/amdgpu: fix handling in amdgpu_userq_create (2026-05-19 12:25:32 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-05-20:

amdgpu:
- Userq fixes
- VPE fix
- SMU 15 fix
- Misc fixes
- VCE fixes
- DC bios parsing fixes
- DC aux fix
- Mode1 reset fix
- RAS fixes

amdkfd:
- Misc fixes

radeon:
- CS parser fix

----------------------------------------------------------------
Alan Liu (1):
      drm/amdgpu/vpe: Force collaborate sync after TRAP

Amir Shetaia (1):
      drm/amdgpu: reject non-user addresses early in GEM_USERPTR ioctl

Ce Sun (1):
      drm/amdgpu: avoid integer overflow in VA range check

Christian König (2):
      drm/amdgpu: rework userq reset work handling
      drm/amdgpu: fix handling in amdgpu_userq_create

David Francis (2):
      drm/amdkfd: Check bounds on allocate_doorbell
      drm/amdkfd: Check bounds for allocate_sdma_queue restore_sdma_id

Harry Wentland (3):
      drm/amd/display: Fix integer overflow in bios_get_image()
      drm/amd/display: Validate GPIO pin LUT table size before iterating
      drm/amd/display: Validate payload length and link_index in dc_process_dmub_aux_transfer_async

Lijo Lazar (1):
      drm/amdgpu: Fix discovery offset check under VF

Sunday Clement (1):
      drm/amdkfd: Fix OOB memory exposure in get_wave_state()

Sunil Khatri (7):
      drm/amdgpu/userq: use drm_exec in amdgpu_userq_fence_read_wptr
      drm/amdgpu/userq: pin mqd and fw object bo to avoid eviction
      drm/amdgpu/userq: cancel reset work while tear down in progress
      drm/amdgpu/userq: update the vm task info during signal ioctl
      drm/amdgpu: remove va cursors for all mappings
      drm/amdgpu: use atomic operation to achieve lockless serialization
      drm/amdgpu: userq_va_mapped should remain true once done

Timur Kristóf (9):
      drm/amdgpu: Align amdgpu_gtt_mgr entries to TLB size on Tahiti (v2)
      drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
      drm/amdgpu/vce1: Remove superfluous address check
      drm/amdgpu/vce1: Check if VRAM address is lower than GART.
      drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
      drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
      drm/amdgpu/vce1: Stop using amdgpu_vce_resume
      drm/amdgpu/vce2: Fix VCE 2 firmware size and offsets
      drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets

Vitaliy Triang3l Kuzmin (1):
      drm/radeon/evergreen_cs: Add missing NULL prefix check in surface check

Xiang Liu (1):
      drm/amd/ras: Fix UMC error address allocation leak

Yang Wang (1):
      drm/amd/pm: fix memleak of dpm_policies on smu v15

Yifan Zhang (1):
      drm/amdgpu: unmap all user mappings of framebuffer and doorbell before mode1 reset

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  25 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c          |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 255 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  55 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c              |  64 ++++--
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |   9 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  22 ++
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   9 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   1 +
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   9 +
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   2 +
 drivers/gpu/drm/radeon/evergreen_cs.c              |   6 +-
 27 files changed, 347 insertions(+), 211 deletions(-)
