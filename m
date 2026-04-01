Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CC5107638D
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCAEF10EDA0;
	Wed,  1 Apr 2026 17:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hVvk6adK";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E5E10E355;
 Wed,  1 Apr 2026 17:47:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHx1Iidsk9ScRiqSqMNMIeSMZmptkZi/5Ay9WDOb8WbpHAqqURNWjSAK1wv1YdO58pHa6osbPJeK1WTnINJukJy6K7yb4xgkhaXt240VEQo83AJU1FnyqZAbdPM04jl5Gwsj4WkdCUFemBO0GwT16zzYPyRmEE7R9/wafVpZpiga2mD3u2u0LaxoFSjuBZiZLVMqjxnVDum7j8qN79PzZZSy4TlaNvLSbfBsOeRyWUTy1OUb6esxp+K9a07jpoclp3LQy4aErPDCgJbdp67mQ1UPvGjwzMXiGb2AWu27Ny1A0ydCOUTEwBqxfhD+e+9CO9TanUfi/rwTg6ZaLwbong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqEepFIHhIFFnHk7ivnDPYSOHT/0yzuzBHv+S/KsR/8=;
 b=FH72Tg+Oih9Z8Y7h6+XarJOm3KtuhtD3bRvgLB5bA1J4KTiEkxuSQqPGkWRnLYLz9259jgBtbIjJZpsksd9svioqmVknPrTeEkKL7ZjD4++yyctDePfvPsJK5kPtvPZ0yP7v8zSbOFzQNuz0Dqm3weGf/pKX4vz5LolGYIayI4zIIkC7LYmpjxEC4Ozg0isuZWIkeELgNwkkvD7qIpfuUQ554NlaQGBDYyzWkKrt96i9K0xNcZ7F2QP6JXYB96mEJA1Yj6x3ybBDRaADasz8QI+jzO8X3ogKWS1RHW3QFzDmtrZ0yScB5B9uWrFKaKfpOBOSVH55RhhxxVxTMIZQwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqEepFIHhIFFnHk7ivnDPYSOHT/0yzuzBHv+S/KsR/8=;
 b=hVvk6adKLXmJHGKGByKgn9Q6I8T7tR7LeS8OieiQTkuYQmW1SVPKscq4N4pYF9LJIyXFqTtqkxyHAstFCPhpYQYs3TqZ7IMpnDLUc+aATxwn3Mpg1n5IIu5vk8LFhqHyqfq2Ms0qQHKKwei71PB3YhJCkJ6oyZt6ZxGv2vNgMB8=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 17:47:45 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::99) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 17:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 17:47:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 12:47:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 1 Apr 2026 12:47:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.0
Date: Wed, 1 Apr 2026 13:47:31 -0400
Message-ID: <20260401174731.3576021-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: f5df1562-a9d5-4dbe-4018-08de9016c802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: PtB+feVPf0Ji0jy9Cs5wxwSWLMXHYQBQHCuOArl/xkk0KWN61sEZv0BaQjRBK6pWAuHF0Mdm2jZw/LL5fMWEyy/Ilj+qRuYg+Sow9ROLfn8S4guTwCjX1UTNPYXL1hwIpO08Jex7tc1hLqyLVcJTD/rl4FXZg8iroqVCWJx7UfBzgBfrFkvy6OoRfYhyeZNdwYNBaZjytm30lAV2BvT3W1a2HyiM0A6qNvVVn7ivA00g2X7UUgDfELTtJQdcKcEfh1GmM9kY8agxRxvrO9GPGqAKZUMve9yiw5YorE8SwZAsD2DR3DMaSjal+aOMnLHPomCBkHrpeLZrLAax9iaqSof5gRPl2DuSKKPgfZk+1/hXnpUyDLrYaIhp0XDzJuA5HqYb3kAT/NZsbbznL8+OX5yoWovz3hIWYdM3O+Dh0WgtZikJLIvCz2bcRuzrbWYwabWC6pZvba9CLcAqp67LHCM+Gc9NIoHtIO0yjmOP/JgynFamN3ySHHlainEF7Xtq8Kl3OrI6G+AgbLi9+rQrN5oSBoIPQe1om5N4OfLWJ/lSC/15FE3zUlIh1n900R/VBTPpbSCf/ZZcRaJe4nxmUxQXSqkvhcrGqk7I4xCAMCjhASn9Bxi0yOOAlj5YOFcYVeGNFLLp737AyREkGdu8azolykfxxZ2arFfBX6rJdwrrsH19WT1cGBXz1X2OEPb/5J/GAYO5XTJQa90Nz+/VNqnVrBcFdU0mY755SBj5kN4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QZ9pQcWTD8IBEowl1DabVe99FjyPBK/vmeLKkqtZy4ofxXNMxOZvbW8a+zGbGfPAdn0+4XbGu3d6c1GnBkR0NUHc1gXpteWZ7nB1W85PE/aZw7+lD5+QLxcDILJOyItF48iUAToEfu+95XY9x9fl/w5sZvB1Xvh3iDzttk/1zTUu0rleh3CkEDWfLacHFXEVOPpf5oPNTT/zocdyb/e88OnvTR1jdYCzm8KxXP9JgdPYMpV9WrawWE7emddwFiqGSsQgfpvR8IzCZnHrVTU2W91/ScHCK6RBukgzw/13UagfKRmmQZTQCb8VX1QE1kd0Kwck5XTI+yk0OyXrxrxhpAuaQEjMvPI3Twwtz7j1i0tJAmzwVe2ZAxaUN4uy9z45Q6t1Ow47HClAMOfOjs+DoFoqFI2YZi+fRNMK40oFxKfI905SfSKdGg/wr46trGLH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 17:47:45.2032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5df1562-a9d5-4dbe-4018-08de9016c802
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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

Fixes for 7.0.

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.0-2026-04-01

for you to fetch changes up to 78746a474e92fc7aaed12219bec7c78ae1bd6156:

  drm/amdkfd: Fix queue preemption/eviction failures by aligning control stack size to GPU page size (2026-03-30 16:22:44 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.0-2026-04-01:

amdgpu:
- UserQ fixes
- PASID handling fix
- S4 fix for smu11 chips
- Misc small fixes

amdkfd:
- Non-4K page fixes

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/pm: drop SMU driver if version not matched messages

Donet Tom (4):
      drm/amdkfd: Align expected_queue_size to PAGE_SIZE
      drm/amd: Fix MQD and control stack alignment for non-4K
      drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
      drm/amdkfd: Fix queue preemption/eviction failures by aligning control stack size to GPU page size

Junrui Luo (2):
      drm/amdgpu: validate doorbell_offset in user queue creation
      drm/amdgpu/userq: fix memory leak in MQD creation error paths

Lijo Lazar (1):
      drm/amdgpu: Fix wait after reset sequence in S4

Prike Liang (1):
      drm/amdgpu: fix the idr allocation flags

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL pointer dereference in dcn401_init_hw()

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  8 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           | 44 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 16 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  7 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         | 16 ++++++--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    | 23 +++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             | 11 +++---
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 17 ++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  1 -
 16 files changed, 115 insertions(+), 46 deletions(-)
