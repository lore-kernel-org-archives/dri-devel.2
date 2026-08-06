Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E78C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6EE10F2DE;
	Thu,  6 Aug 2026 21:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3TXapf29";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF9F10F2DE;
 Thu,  6 Aug 2026 21:15:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnSF+vVzbtdCRmDB5Yretyn0xF+5r6X97CCBGJEO4z+uuiokHTH8gY5Xvv321QTsozpJErLvAXfZaTGPFb3ulw4qbgYO5zwfsvuda89Oe9z0ni2YZ9dhfGu+FrT2nTV04bQDagtDvRezcgv5W98OhV4PzhevM9c6XcP2Kxi5oJRBqtR19rJ6RKZLKQrq81skih1vJlJa1Q3vofdfiubeF6g1laVfOEMRhA+tpt2xn5T3XrVH9rebxrDKd2ZJEZwLbQFwL1jVTjCObRAapljXuoo4ZG8DbVmuaLa4PD7w+mEz5MzbyPZ+39WpEBS5ljrBaOwnF6svBVuwpzTv5MDgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDGwxgAvMxZs0HvEL/ItGcY3eK6lIYnh7F0drhgaOgU=;
 b=w9E9QipaWyx/KON7LAG8Fcep9bbS0QeARLoex2aPdRTGgR6rEWFXzQzcVSq9AvPTR29UPv9c2sDzzmUhDCdNXaiam8kiVWpJfdDccuodq+HQeh8GceawVqVWw7PhVUnql6dOH4iqWZu1/AQL2snrtH/L5gQvxXxJ9ohHx9KXQ0QmSYjelqPs+6zNo3q7XOJajG5pPrVdi1C4O1Fg27nwssJ2GtX101YNPtJttuW6SbFqhKq+qHNHOFeVPoS1gsEXW3mSlVQjAm3XMQ2iIGFVu40vnMetD3yhrw0x2KdMO2UDZcKTClC8ywWHGMURUt3fiWlHGgwkV8QuIoSDtIzvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDGwxgAvMxZs0HvEL/ItGcY3eK6lIYnh7F0drhgaOgU=;
 b=3TXapf29kJGvc+xfYa0j6LDPD1hPye/ujkmuvTHC0jdg0DFxjObrJ9Sm/XMQbzxABfFGzXWq2KWKicU90aCdovBqBJhZYQFsqnINDNvlfBWiqbhFZozbv2sgVGs0yhy736N4UjAI8QicgSQqYvmkB3e28RmUn7nWR2Ub75KFeQQ=
Received: from SA9PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:6e::21)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 21:15:52 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::4a) by SA9PR11CA0016.outlook.office365.com
 (2603:10b6:806:6e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 21:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 21:15:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 16:15:51 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 6 Aug 2026 16:15:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, radeon drm-fixes-7.2
Date: Thu, 6 Aug 2026 17:15:38 -0400
Message-ID: <20260806211538.994087-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c24ab64-31ff-4029-9bd6-08def3ffe4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|10067099003|6133799003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 6FAWLRpctzEJFEcX0a2DYFRHTDV0n6yMgpIZOOZSv0hnwMst7fMDoQewn0cpBa2EWsrm7A24Px8hcQfpPLEPc3fwfonqoNYSks5uvMAHlQs9C6hb3ajKu3ww3RwmSEBzEi8oKI6h08cLOTDm7xYxSDUlh1x1U8kb+7cZzVbIAOZ7eoqHuKgYaDPtzF/w/qn8AwDygRCY9dBJLKsZRKhmoc5BadB65rcu4DCa/qeqH8fF/QbdauTYB6ZGu7ZIVuqY8hv8DAP7vhxzBTJB30XzAH/hOFtANw9GMdrJyRf/sa3zPODbAUnkb+c+FUz0fb28m9z7h6EdxsZjrTsjFCDg3jryV4TzxlUajazZrrBWmYlxOh7XjnjMBiBQRhoi19fvTNLrYjtGmNiooCGScR01LFAw4/YyZjrR3sTCrbKZv/XKxVQSFQOkuafdEDjfrbXlZ6GVVAfoE8erBcZZ1nV9Z64HxPJKTistHFPDFQNwLUcjMnZ7SU9LPVzIDIEsQfg6Faxf6KuN0uWKuhCggrf/d6TelB4ICzh7TILJBWAIWLLqx1GR42lB/ZDgBmScgJDlEMUTUETET6D6g38zD+ViHsfsQfeKA8BGG4dqYen/85XIsW/5aOJJMCQuA3bh6FvHAxXJ7NrDOYaEhgBxFrkVqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j8hp29nZaNBlSWpxvNtY+0haD3aO2kNX0/aKfYv2ufokxQt5VvISOs+d75LxlC3eyVVEK3+vPr2XokmLo3dUXX0fDqwc0O4/+7c0SeI8h8jXJ6kJ48wb5soh3MuJ7RaM8Xr8JFTdLKGd5Gk1HqmS8A7Ard7CR55DUcuu/oDRcROth18uIgZk3UdLx9igBZjBdEB5F9ZBijrdbuKtAiAk0t6bUQB6AUeMcMumrC3ZEteX+OK2CrVL1eCGs3BUnLVjV4V1Cw5NX08ZYXif8NXPxepIETsYeSmL9hxmH9W/YqQpjO08WSAkaWM2Kgkqicv4ewmrjemKKJ0iosXWs0jgCZJJT1KZZNB0+oy5lwXcqRGqBaqbqeawQfQeqzHwEAcrwa+AMLA/ED06mHDPwn204qrAZ+ZMOTaoVtNsWv7uR6cLMbvjteF5HksOLwOq9Jk0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 21:15:51.3112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c24ab64-31ff-4029-9bd6-08def3ffe4c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
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

The following changes since commit 075b74841bd0065a3bda3440873c747938e69b68:

  Linux 7.2-rc6 (2026-08-02 16:24:24 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-08-06

for you to fetch changes up to 8099bd08646544730ba8c9fc7c0ebf6773206e19:

  drm/amd/display: allow self-refresh exit while entry is blocked (2026-08-06 14:34:44 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-08-06:

amdgpu:
- JPEG queue reset fixes
- GC 12 fix
- GMC 12.1 fixes
- Lockdep false positive fix
- Userq fix
- Bounds checking fixes
- Devcoredump fixes
- DCN 2.0.1 fix
- Aperture mapping fix
- DC avmute fix
- DC self refresh fix

radeon:
- Performance regression fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amdgpu/gmc12.1: implement tlb inv semaphore
      drm/amdgpu/gmc12.1: fix MMHUB0 check in pasid tlb flush

Asad Kamal (2):
      Revert "drm/amdgpu: fix aperture mapping leak"
      drm/amdgpu: fix aperture iounmap skipped on device removal

Candice Li (1):
      drm/amdgpu: reject oversized IBs with per-ring packet limits

David Weber (1):
      drm/amd/display: allow self-refresh exit while entry is blocked

Jesse Zhang (4):
      drm/amdgpu: fix JPEG v5.0.0 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v4.0.5 queue reset failure in DPG mode
      drm/amdgpu: fix JPEG v5.3.0 queue reset failure in DPG mode
      drm/amdgpu/userq: serialize queue map against GPU reset

Lijo Lazar (2):
      drm/amdgpu: Use virtual alloc during coredump
      drm/amdgpu: Allocate coredump ring buffers per ring

Qiang Yu (1):
      drm/amdgpu: read TRUNCATE_COORD_MODE on gfx12

Ray Wu (1):
      drm/amd/display: Check for tg ops in dce110_set_avmute

Travis K. Bangs (1):
      drm/amd: Disable DP audio spread spectrum for Cyan Skillfish

Vitaly Prosyak (1):
      drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init

Wang Jiang (1):
      drm/radeon: restore hardware polling in fence_is_signaled to fix performance regression

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 27 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   | 54 ++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c        | 21 ++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 29 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  5 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  5 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             | 48 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c           | 21 +++++++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c           | 21 +++++++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c           | 21 +++++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  5 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  6 ++-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  |  5 +-
 drivers/gpu/drm/radeon/radeon_fence.c              |  7 +++
 16 files changed, 216 insertions(+), 64 deletions(-)
