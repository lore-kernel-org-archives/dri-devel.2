Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D766CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 15:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5C2310EE03;
	Wed,  6 May 2026 15:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gMgd2baJ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CDE10EE03;
 Wed,  6 May 2026 15:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsea9TsDmTUKk3vDiSrNpucqFvSQENvExOxRkEKz1/7GlOt7B8OwsssCbtP20ofb/mNLYF8b8Hz9EEqiJFYRZECXL0fcMWG6pbROwVdETa5ntUsKbPSwhSK5UkjY9Q/Sb6D67ZMSRr8M0hFJQQEiYL3BkArqEY9XTH9BtF2878+68Mj8OVb+lw9oGE85wZHHAv9YQ3+jT8LcGDiRbKfggtIi5F4DdeICrBp7vi8at4gQnCzvHxALl5o1pXHF4l1Nq2pNzK5qFMbrxWLoG8oovkz3qy+qw6YoXTfkB+MTKl4vL3LYD3HHhxH/odoy6YJA7QypupjxC/TOjbb5xFEQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u57BuU3HDq97m/+Cgb50VL4h9MGwu9o98wm6HEhkg6I=;
 b=uf6fUhKM9Svn0A5irZzMBCwGT1qgijBif9e2jMzuz7P9+VAmrIfjW/+Tz+nvztBblmGaskETAGS/d9zor9Cq963pyA0zj0FqeEu6RxVpkcxdjKOWZXrBoXzhWr5Ja5Ao9n52I0DD6hKFQxVp0zD8pNYRwrTdoskzkdtjkmvweuCdsjC2oNp+CI0TQzMIHvMFNoMp8GpKGhmCVRMElfCgZbAcBdQtS/LLWsv8Nbd3aB4hmURtt0y1UmUD2hO6Eij/bmlyJjqVo2qicxf5o2v7M2B9y+u2T9yL4JEqBP0Pjh8aXNpBYWxM2DzF60jLYgKYFYNRDQYy0XKnU7GpgfQ0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u57BuU3HDq97m/+Cgb50VL4h9MGwu9o98wm6HEhkg6I=;
 b=gMgd2baJyOYgsOcVv4IcgHwz8WZk7aCabdwp5So6Lme29WrRS9z+bOfZNmkQz+WcKLDCO521CqMiGO5cOQdY/VO7+vS2ajJJjRuYXKv6heMmQX7iUT6NTdZSzBix/kkh3wbJgB5uLKVnrO85E3O6w3GZ0hPqPQ6zE5ornm2GIBg=
Received: from BN9PR03CA0306.namprd03.prod.outlook.com (2603:10b6:408:112::11)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 15:46:49 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::ce) by BN9PR03CA0306.outlook.office365.com
 (2603:10b6:408:112::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 15:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 15:46:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 6 May
 2026 10:46:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 May
 2026 10:46:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 10:46:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-fixes-7.1
Date: Wed, 6 May 2026 11:46:31 -0400
Message-ID: <20260506154631.1733034-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b140fe2-aa08-4c83-43fe-08deab86af80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info: kujxcPAUtAhC25J23bhUy43+ceXS2UL/rlWsQPcL+ujnea0izZ4rrRpeNAZg82skJpzwesASEZbq+RWoePe9L9lKclU3DwbA9UsgIkhLuSYYqILnXMN6sSFyTci5KhSPIOhccpNkYp2yOYth9IWY64sYCK//pEXLr4LBhALJutQ+l7uVHKEMikSGV/UGuSO44HSYcpjRsmyXKO3ymcM1x6jdViqD+M++QN9LljTfOQ5lnf0wAtOl5AvAi+RC4wwH6Lm3S+YMun45MnSmUisQgrfiQJv/7yS0RfoNNJn3IrMcgo+13fELPDRSRHI1ntFJACWfpyyKEKd6bNOfyDq/BgkoX2eflEFmIOx/immw4Qawdj32sQuHnckg/I7tmAmBvUn9YDohR9N9E7TOPLW3uRg8LdH1tmo0s47KsC+/iXE0cMMcwHGJFVrwOUMsW63jKvBJWrBOby+Xpv59wFvH1vP383QgdLkt/spt2sb9l573s2W33vU/tfQhHPfK3M0+0mloKKq8viFiD8yPc71ZYkQ9OL/GoRYZj/uxp1s4MDdNlDxyDrS4WGhykucm4WrVWt/pJIO/TxostJ4C0cygx7nCE530y1lY8KJIxyluNTNrh2w0iNSsz4e6zH7/nzrZwnt6q2E5Tq+msCfu5xMWkkZP5MHCrFkpuRKCzxpjXtAzM+IzYgEOLr0ZgdDDNvVQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G5tVMqYxvyrwr00Xt8Tgpqoctj/J8k4ki4EuWLONdrFt/uVsMx3HdKfKyWMGxV+PU0Rbn++az/axiHU1if7chcfuYrMknCwxLzaBPckZdJ0aDAes8t+5l2RshOfBMhWrhC8S7yaJm1uqeJOzCn42AROL+3oOon37KsqOHiq9A5jJaKRjhdEAzJhRupr47ZA2EIj1FP7Brnwzo7uM+bRfgkyjYWkfDYUZh8/triFHhQrLWjqLvY5Jalc69ervYEdWhluG9cT5J4kVbHrsaB1cIpobBN8pGUT2uMw6PaGkVVwiPj0BJsLF+oCBq6YjZKlHb/SMLMxrzobN+zZydgyZrK/5vUrA2sAykD6lr6Yl5O/HSgWuHbeTKivEhTwOIazENz/HTLIxlZUMausTz+s00qV2y0NJw0qeqkldwwYmw8/oxLExppY/H0agvR3r0JbG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 15:46:49.1140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b140fe2-aa08-4c83-43fe-08deab86af80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450
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

The following changes since commit f0997a06e3e32898bcae667d6807fc46ebfd0eec:

  Merge tag 'drm-xe-fixes-2026-04-30' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-fixes (2026-05-01 12:49:29 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.1-2026-05-06

for you to fetch changes up to 4e02e0afa95f691dc7cc17538cdd648089a843f0:

  drm/amdgpu: nuke amdgpu_userq_fence_slab v2 (2026-05-05 10:23:06 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.1-2026-05-06:

amdgpu:
- GFX9 fixes
- Hawaii SMU fixes
- SDMA4 fix
- GART fix
- Userq fixes

amdkfd:
- GPUVM TLB flush fix
- Hotplug fix

radeon:
- Hawaii SMU fixes

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/pm: add missing revision check for CI
      drm/amdgpu/pm: align Hawaii mclk workaround with radeon
      drm/radeon: add missing revision check for CI

Christian König (1):
      drm/amdgpu: nuke amdgpu_userq_fence_slab v2

Felix Kuehling (1):
      drm/amdkfd: Make all TLB-flushes heavy-weight

John B. Moore (2):
      drm/amdgpu/gfx9: drop unnecessary 64-bit fence flag check in KIQ
      drm/amdgpu/sdma4: replace BUG_ON with WARN_ON in fence emission

Philip Yang (1):
      drm/amdgpu: zero-initialize GART table on allocation

Sunil Khatri (1):
      drm/amdgpu/userq: fix access to stale wptr mapping

Xiaogang Chen (1):
      drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 13 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           | 13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 28 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h    |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  3 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         | 95 +++++++++-------------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 33 +-------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  4 +-
 .../gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c    | 13 +--
 drivers/gpu/drm/radeon/ci_dpm.c                    |  9 +-
 14 files changed, 80 insertions(+), 154 deletions(-)
