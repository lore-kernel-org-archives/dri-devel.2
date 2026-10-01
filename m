Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E340CA5FD9
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A694A10E126;
	Thu,  1 Oct 2026 23:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ffO+mgX1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013051.outbound.protection.outlook.com
 [40.93.196.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A2710E126;
 Thu,  1 Oct 2026 23:01:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfFzaummc0a6YgrAn1SAbArpAmufMx49AwdQjBv52k0JftlYQ4dw5/KYIlpoBfc3GZEmPtnNdeYt/E+4mWxHCyw5auWlZbTKc5tOpRTHUq9BT5SPfnEBmvBo826ioExWSiJcUOj6W7D627BuJKTUiXZSXkstFrwuJXkpffkJ4jqvHYBcSMfMbCccNaw7AfWCT7Mkn9ke74kXgWsjhixaKFjg2KRtTSi7EAPowjOSL0DW8Ssm56PcnGSL3fIQfNTQ7w0lyo+hNvsVL18oUZl0nhCtqK9/Q4dUdyvnoCuPrVd4Vr36wnfPfsMVT2K8bBdLZq7cHCHr659/KI3Uz6qjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khxJgNAW+Bo2UfkZfLciczviS5YeTZiUHE0KAKgkxfU=;
 b=wtNbMY5N8Ry0/4JynlgjQ0IiH73r1iF6Y5O44A9IuKYi7g0GtaB17JHqeqUshl3c4MpDggN3aOpBjpX4csiQh2a1zF86m3dclba1wd3ReMYViKX9/iogDe6sBpwJl1ogWmINBN/pC0d/PjCztJMm95BBQYC6ECthzPG6zlQzSdJnlwjI5BXhw3ejJj0xAxG2lylAGpmtmcRaK7w+n4kk8uHK4Rq4cWiOamjuOeIcObbao6R7bZhpfB1rB2GB75rwc0oaPg8MZm6oYrgg63zlGu1CJ+a0vizuiZ45xjM7LHTT20B2Teqm/p5BrZt6o3mQIDk4xaGQWyM40dn9PRc2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khxJgNAW+Bo2UfkZfLciczviS5YeTZiUHE0KAKgkxfU=;
 b=ffO+mgX1PDA5rnclQLijBTW6KLsdJQYKoxxzO3+8vXmTFMJZ5TfUJ+XsxNwddY0SaKFagnsZ5r0E6xapOriSlRLEMBqZb/VFRpOhWF89TunB5sjEaEy3WzzaE2JFnEldNdndWlQoleHMY4XdZSokiqLpn73803fZsAilxXP5hv4=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 23:01:27 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::56) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 23:01:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 23:01:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 18:01:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 1 Oct 2026 18:01:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-fixes-7.3
Date: Thu, 1 Oct 2026 19:01:15 -0400
Message-ID: <20261001230115.1319089-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc51793-6aa2-4d80-f36d-08df200febb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: xq9amEB00O2+9D8b14e3CMascYqZSojewGn0121IU16BYAE+/YOOacaVvCT6wLPGHT8crHVsqWmx4WAUNZ82cIVXP44GtdtvwxE1LOuqwsdkIZ3quunKHdpBqfvUPlHpcdaZ3CFYqRJt271MaTCRb/kuGL2V2ieyETWTPRtazykOwch2YbTAflUZKf61/7TKBPAy1tzg9Yoho8ayw9zxZqA+FdZAuGnqXc0WZEw0YK55Mv5CLRaHd8m/Rrq1mJ3QT/xfYKk2RG/1XqwMPgw8e7xjJl11vaItzAPC9v3zTXgvhqSHjkpfmizDEgonepEaTa6NS222bLUAFDzUD1sSLDRHnqHH6BwwJVdcnXbdlzDq5IZee9/0bIkecKe/PSNbp1DijMayOSwOroiVoK+E8N4fG2XDqd8BX/rGdTJ6b3Gsau4TboZ+uW2/YyihQAUgZZ8VhYdTbeEPQDocdZs8+Klqp2Sl2FXJy6cC4v9GXGuwaPgVFgSzAQ51KDM/SD+FHe7BJajqwGMlWanaXTl9EWr/2+WnhbDxavMAjwmK2hEW5EhHNM8ywqtfK/RiFrmw5fbBESu3UxMeNYo8RbS0aW8TNLxmu9yMzVUQn0mfEe9FBox9zQ31EMZSIQ6FVDe5BJ8YKtNgq55GeCvjMbcRQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wi9rv7I1k6I6r8dc7aWwEoISTY2SZm6OpDDETNN1foMKA7i6B38yvFMsdx3h1+kIRUrvBQPZQgq4+wLEwx/ioDNk8Fbftml9JxHioyOYM0UudmS2hsRUzyFHoy6T3ReNJz22dGvjYX88qBerkZG1Xb5IAXvmAfXq100F990u3u6g5z5dRjpUaOKnGzPp37GpS9b/HChmxDIbeHQLsBCSgiYYx2Zc4tASWbgU6GvmSGiBrPXyqED/lNAXlBXCXQ2a8WqsIs3EA3z9rAzf9E/VD/2EwwM/ICsxSI5wk+jFiC9d3p9Nfb9Bg0uFXVZKR+SeQVlFWj0omUpaj1nLx7a3IHSNFUcBZhRq0xRgawwa0ZPTI+jf4xHIJfl/m5z4xvMrLgXZaCUhU2SYou3hf6cc69EatXqk6S2VQbIBcVlwq+QEl9Lco6IBKId5zYbmlisD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:01:26.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc51793-6aa2-4d80-f36d-08df200febb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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

Fixes for 7.3.

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-10-01

for you to fetch changes up to a22e5e4f2ebbdbb962cc3233094d189c4dfaa051:

  drm/amdgpu: reset VI ASIC on MacBookPro14,3 (2026-10-01 17:18:34 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.3-2026-10-01:

amdgpu:
- dc_state_create_copy() fix
- HDMI RGB limited range fix
- eDP ASSR fix
- DCE 6 fixes
- DCE 8.1 fix
- SI DPM fixes
- Reset fixes
- Workaround for multiple SDMA entities with DCC
- PWM backlight fix
- GPUVM fixes
- Switcheroo fix
- Error handling leak fixes
- GC 6 unload FW leak fix
- SDMA 7.1 fix
- DML frame size limit fix
- RGB vs YCbCr 4:4:4 fix
- DP MST fix
- DC Power module fixes
- MacBookPro14,3 fix

amdkfd:
- SVM fix

radeon:
- Sparc64 fix

----------------------------------------------------------------
Adrian Betschart (2):
      drm/amd/display: Default HDMI RGB output to limited range on CTA modes
      drm/amd/display: Try RGB before YCbCr 4:4:4 in stream validation

Alex Deucher (3):
      drm/amdgpu/gmc12: properly pass flush_type to gmc_v12_0_flush_vm_hub()
      drm/amdgpu: drop userq callback assignment for sdma 7.1
      drm/amdgpu/gmc12.1: properly pass flush_type to gmc_v12_1_flush_vm_hub()

Andrew Martin (1):
      drm/amdkfd: Fix always mapped range mapping to all ACCESS GPUs

Arthur Heymans (1):
      drm/amd/display: Preserve eDP mode on initial ASSR failure

Francisco Beltrán Millalén (1):
      drm/amdgpu: reset VI ASIC on MacBookPro14,3

Guangshuo Li (2):
      drm/amdgpu: fix IP instance memory leak on kobject add failure
      drm/amdgpu: fix ACP MFD device leak on init failure

Hari Mishal (1):
      drm/amd/display: guard dc_sink dereferences in MST mode validation

Imre Kaloz (1):
      drm/radeon: Read the VRAM VBIOS signature with readb()

Jesse Zhang (4):
      drm/amdgpu: support non-guilty job save on ring backup
      drm/amdgpu: fix empty fence backup and replay intervals
      drm/amdgpu/gfx12: set KMD_QUEUE for kernel gfx queues
      drm/amdgpu/gfx11: set KMD_QUEUE for kernel gfx queues

Jiangshan Yi (1):
      drm/amd/display: check dc_state_create_copy() for NULL in dm_suspend

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: implement workaround for sdma dcc corruption

Ray Wu (1):
      drm/amd/display: map PWM brightness through custom backlight curve

Sasha Levin (1):
      drm/amd/display: Fix sanitizer check for the DML frame size limit

Simon Polack (1):
      drm/amd/display: Fix stale replay_events after mod_power stream removal

Theo Andersen Carton (1):
      drm/amdgpu: skip the noirq suspend reset for a switcheroo-parked GPU

Timur Kristóf (5):
      drm/amd/display: Fix fast updates on DCE 6.x
      drm/amd/display: Fix fast updates on DCE 8.1
      drm/amd/display: Mark DCE 6.4 as not APU
      drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
      drm/amd/pm/si: Fix updating clock limits on AC/DC

Willian Oliveira (1):
      drm/amdgpu/gfx6: fix firmware leak on teardown

 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |  37 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   9 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |   4 -
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  13 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  11 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  90 +++++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  24 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   6 +-
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 117 +++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   2 +-
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |   2 +-
 .../dc/link/protocols/link_edp_panel_control.c     |   4 +-
 .../amd/display/dc/resource/dce60/dce60_resource.c |  13 ++-
 .../amd/display/dc/resource/dce80/dce80_resource.c |   2 +
 drivers/gpu/drm/amd/display/modules/power/power.c  |   2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  39 +++----
 drivers/gpu/drm/radeon/radeon_bios.c               |   6 +-
 27 files changed, 348 insertions(+), 74 deletions(-)
