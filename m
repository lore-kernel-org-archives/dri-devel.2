Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FDAC44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5013D10E03E;
	Thu,  9 Jul 2026 21:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BrB6JypK";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2421F10E03E;
 Thu,  9 Jul 2026 21:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+4IoMXvhctbYeFz+FEwCuaquii3UHaBkCCLUYv6ZN0+8t0Xq194wU1o/EC8dCQBFmVvKssKeiXY8QRcssjm4LTk440mJ6oPilZBrx3iVGsn5c1XuajUj5GICD/+1CElONNlTkNLWnoQRx68yfFpI2QgDVCUGq3sQHfAmNfjVDSbIV6HNJzeLiVawZAKm59sGl9e7Ei1cFWGTBXIusJDvteKiZcA/jUo9dkFUQEggBR6D+jlnBxU9lCoJtbT+PS7ec9ks1UXARK8vp8Lm0bA9+G6VQYg+J+HorLyp6i1v8eVLX4O/SCtJ50KTzW7rJgppYAko8o8W1pckP9dAOn+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA0wIC/dYbWb7fRKgHvUwwo55VJa9xUTF+3R/OlciHQ=;
 b=vj/ZUp3SSj4wlFQwaS30NaM0tpsilETEd0E0oHLKfXC28+j9Jky91+HY4IJsUSItL9CPhEQdtbh/GfpzGrW1sf5d4uav8upoISh+KATre3SNh5JKFyL0HOCJ1gI+eY6LKMIoRaGw8d6UZvrnb5y+ZtI1SuzumQVtXNwniwp2Z3ID3g/MR2IJMTbm54i6PIi+HmSXZIk7uY70rC0P/8S9PGd9apkUD+Syy6qcqXBBd9b656JbeNyOm/q7knjAHfEi0mfCriTtdZUiMKT/lGSSrxg7SSdIU01b7ZQvuEY1sh4E4+ddTuJGhFVB5q2l8mP+KguJaida0qI3YnYvw3ASKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA0wIC/dYbWb7fRKgHvUwwo55VJa9xUTF+3R/OlciHQ=;
 b=BrB6JypK0psCQk7ljKivvutKxkIfuBhI3VRRujgRSgtvD0QJrSTKJI34nRhzMZ0yANFxjyw2Xv/dokjNinSLuRgpl4R52Sn+XhWYt6LbQjR1o2B+O9dmXxRW7+4kUHNM1eoSsUHKqM/b24R4NBY26RBpYZGvqtppPAxNzQ9xoSM=
Received: from DS1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:8:44f::8) by
 SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Thu, 9 Jul 2026 21:40:09 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:8:44f:cafe::5d) by DS1PR04CA0001.outlook.office365.com
 (2603:10b6:8:44f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:40:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:40:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 16:39:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.3
Date: Thu, 9 Jul 2026 17:39:53 -0400
Message-ID: <20260709213953.16494-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: a278acf6-aa2e-48eb-cb79-08dede02a5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|11063799006|6133799003|18002099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 52L0fFzFHchcdZr2EIQ69LQCbTwbijXhrCq8e03UMGyWWXdq2WazpHlZylkX6xq9z7vsJZsW4yH9oGAUaF5742nlvUefUbj0ax1IVLSxGLTHJfkOlK3SBrFl2YxRM6nkLGhbO6jxdo1LgIs5+mr+P+KwZtdjAtqSpiGb7QeFffRSiGs2xd8KxlEgMNrwWYhdlQNjIPOvKA4Puu8fEA4T4k0NFlGCdrCi9zvgMN2x97HzPV7+eBbysfApku9kXt9aFE3bWKnOMIZreP9W4HlMzo1LPCsrnX8NOMUgjKXcbIA/r49GlcSfE98BBQTzRyI3Ofst+YBDFrDUgE9JIq3s2p+8AZqsXLapULEBBBtuGRFP2/u2OLgkYzFHPGUtSJ3ZeXSwVjGdQm1ogN0VFZO/+iluFrY4/aL/BOHKTyVdas1QGt18TpYQDLp/5dZ90nnDJaIlHdsXaJB4i/4unvE6aaLQzC69AGEYxAsJudJskJU7pTin/CDLsqKxqNNHKkNch48nSnkW4l4lpLBY3h2/1aBbp4H9uDOkYB60Eh1mZnlnJCaj87BrNhi52kINEpjcV1/pOYnGOexg0y6XEj0ZwGjxTqubOGNfnw9IjLfYhw60xdIqlPe2dqSheMCVxTD1vJN72mTJ1lEUH8/TfFRV4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(11063799006)(6133799003)(18002099003)(56012099006)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h/aFP30O/EBoih1shaJK9sEFkMbjWjSOJ2CElvtYh11XxLw6xlBjcHDo3vuPfRnC/63UNuhCDsV/Z09mFPFG6HN6E8rIen6ttxYqdiHWD9jR/Eh46wZb6vuhz0jAAVxqmzGB+7I6e4dmNnG6SsirLsXl5sXkI+iXKQrA7kXTePS5SOSoYucGyDMFmfDII6UroLz2/PaoXiCACwfVgw+lL95ABxOZo5A6gG4M902KeHJfRwfGlfd9bpY4ERvZ/NGRoCmnr2EgYxW/UqHCszQaXw0fzjWXfVxU96ocAsaQSgLtNID02Bm/tnQ192nX+oxQl9vrtDpzi9C8G9cSjutdczvfvPLRJGJyQLc07sMfYpYzy1jEBAB2uZn0KG+u2I0kLiW+Zv/r8YlH8MX0zDmdHkHEqnjC4ZWA6ki9zlCRtLCxcprZXmISFy+hb+4yENwQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:40:08.5542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a278acf6-aa2e-48eb-cb79-08dede02a5c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
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

New stuff for 7.3.

The following changes since commit 0461ba9a7994a9bfa2ceefe730e2c87759edc267:

  Merge tag 'amd-drm-next-7.3-2026-07-02' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2026-07-07 16:48:23 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-07-09

for you to fetch changes up to 5c6c247992d4d9200e073b83f4ec6c703c096845:

  drm/amdkfd: Check bounds on CRIU restore event id (2026-07-08 14:27:26 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-07-09:

amdgpu:
- RAS updates
- PSP 15.0.9 update
- SMU 15.0.9 update
- VCN 5.3 fix
- VI ASPM fix
- Userq fix
- lifetime fix for amdgpu_vm_get_task_info_pasid()
- Gfx10 fix
- SMU 14 fix
- JPEG cleanups
- MES fixes and cleanups
- Header cleanups
- Misc gfx fixes
- Gfx pipe1 support on gfx11 APUs
- BUG() and BUG_ON() removals

amdkfd:
- Merge fix
- CRIU bounds checking fixes
- secondary context id fix
- Event bounds checking fix
- Fix CWSR buffer mapping when in VRAM
- Secondary context fixes

----------------------------------------------------------------
Alex Deucher (17):
      drm/amdkfd: drop duplicate kfd_queue_acquire_buffers()
      drm/gfx10: Program DB_RING_CONTROL
      drm/gfx11: Program DB_RING_CONTROL
      drm/gfx12: Program DB_RING_CONTROL
      drm/amdgpu/gfx11: enable gfx pipe1 hardware support
      drm/amdgpu: return an error instead of BUG() for CSA bo_va
      drm/amdgpu/gfx11: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/gfx12: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/gfx12.1: WARN() rather than BUG() for invalid SDMA engine
      drm/amdgpu/atomfirmware: WARN() rather than BUG()
      drm/amdgpu/cgs: WARN() rather than BUG()
      drm/amdgpu/ucode: WARN() rather than BUG()
      drm/amdgpu/cik_sdma: replace BUG() with an error
      drm/amdgpu/sdma2.4: replace BUG() with an error
      drm/amdgpu/sdma3.0: replace BUG() with an error
      drm/amdgpu/si: drop BUG()s
      drm/amdgpu/gmc6: replace BUG() with an error

Ce Sun (8):
      drm/amdgpu: retire legacy pmfw eeprom interface wrapper
      drm/amdgpu: retire legacy pmfw eeprom support check
      drm/amd/pm: retire legacy smu ras driver framework
      drm/amd/pm: retire legacy ras_smu_drv interface for smu v13.0.12
      drm/amdgpu: retire legacy mca umc status check interface
      drm/amdgpu: retire legacy get_retire_flip_bits for UMC
      drm/amdgpu: retire legacy get_retire_flip_bits interface for UMC
      drm/amdgpu: retire legacy deferred error separate logging

David Francis (4):
      drm/amdkfd: Check bounds on CRIU restore queue type and mqd size
      drm/amdkfd: Don't acquire buffers during CRIU queue restore.
      drm/amdkfd: Check bounds in allocate_event_notification_slot
      drm/amdkfd: Check bounds on CRIU restore event id

Geoffrey McRae (2):
      drm/amdgpu/mes: Add NULL check for mes_hung_db_array allocation
      drm/amdgpu/mes: Fix hung_queue_db_array loop limit for multi-XCC

George Zhang (1):
      drm/amd/display: Fix sign mismatch warning

James Zhu (1):
      drm/amdkfd: use iosys_map for CWSR buffer access

Jesse Zhang (1):
      drm/amdgpu: trigger GPU recovery when userq destroy fails to unmap a hung queue

Kanala Ramalingeswara Reddy (2):
      drm/amdgpu: add support for PSP version 15.0.9
      drm/amdgpu: add support for SMU version 15.0.9

Kenneth Feng (1):
      drm/amd/amdgpu: disable ASPM on VI if pcie dpm is disabled

Shahyan Soltani (7):
      drm/amdgpu: move struct amdgpu_wb and helpers into separate files
      drm/amdgpu: move struct amdgpu_video_codecs and helpers into header file
      drm/amdgpu: move struct amdgpu_mqd and helpers into header file
      drm/amdgpu: move amdgpu_acpi helpers into new header
      drm/amdgpu: move amdgpu_allowed_register_entry into amdgpu_reg_access.h
      drm/amdgpu: include amdgpu_video_codecs.h only where needed
      drm/amdgpu: fix lifetime issue of amdgpu_vm_get_task_info_pasid()

Srinivasan Shanmugam (1):
      drm/amdgpu/mes12: Remove MES self test

Suresh Guttula (1):
      drm/amdgpu: Disable JDPG on VCN5_3

Tiago Dourado (2):
      drm/amdgpu/jpeg: deduplicate jpeg_v3_0 process_interrupt
      drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0 process_interrupt

Yang Wang (1):
      drm/amd/pm: fix smu14 power limit range calculation

Zhu Lingshan (2):
      amdkfd: properly free secondary context id
      drm/amdkfd: expose pasid of secondary contexts by debugfs

 drivers/gpu/drm/amd/amdgpu/Makefile                |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                | 267 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h           | 151 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c   |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 113 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h            |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  46 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            | 127 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |  30 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     | 146 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |  23 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_reg_access.h     |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |  18 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h   |  47 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c             | 129 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h             | 102 +++++++
 drivers/gpu/drm/amd/amdgpu/cik.c                   |   1 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |  11 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  35 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h             |   4 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |  21 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           |   2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           |  22 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   6 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             | 340 +--------------------
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |  10 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   5 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |   1 +
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |   1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             | 151 ---------
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h             |   3 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   5 +
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           | 113 +++++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   6 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  73 +++--
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  43 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c |   6 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   7 -
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  12 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   8 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  | 130 --------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  21 --
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |   1 -
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  28 +-
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c     |   1 +
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c   |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h        |   1 -
 94 files changed, 969 insertions(+), 1643 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_video_codecs.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_wb.h
