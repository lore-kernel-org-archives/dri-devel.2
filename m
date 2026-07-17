Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C0FC44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DAE10F611;
	Fri, 17 Jul 2026 21:50:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NrsU/bId";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93DB10E358;
 Fri, 17 Jul 2026 21:50:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oR1m2vob94A6WX4im28SEx36Ym3BTTvYtDzwGcEv/p5b6OPaWkTZTwxa9YWEhlnkubHo0VfS6nDcieS5krd0H+OoPobClDWtXU2YCAY/tMA+z7tQOM/t5wjGb5P8e11hX2gE6JfOh61ckSegY99V9CVagyY8ioLunUC5QNY6DG/GCiyK+XkJp2lF+SapC/qToIQ8f5Q2u0agykzjFo+3FKxv7gYb9ftsDLmD4vdhy+ApQGCpmbtIjQZ0Kn3I8bL4ALS9Rbw/uG5ZE0S/9fUQhzNV1rfMtky8tbEZ7gM3GN9RBIvvf9lW6uz0PGQAbDh6UQGiRfNsFpXTB6otLFtI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NROzCh/fW+ME8HLafElqPy0Gcm89Zr/3D4BVIs9Hx80=;
 b=ttG8q236yIJ0V0+tx/EYU2cag7LIQtLvxyS8x6YnqdN2m1FTNaaI58ND/usRAtJk2BrRnP41hSRe1+54J5qGGYEK7B4r5L3zyOnvg3qEMWnHQeuFqJ83nDL3bQLONckKHmMqaNQr3kdp6J91wBEu91RVKic9KVua4FToRX3yx3zezw9HP8pRCJCSX+ovS88ZaJf888AjzwVSVKmg0mZBFzaWmjQirSTEy1B5/SqLSRIhrRALAa7iwsp72Kk/JiRSlWldfVHnUBWGnXE9DS+nR/gHfmsHsRyc/A+9QiHM66Fgp/Jr7wVCiHVEUaj6Se7u9uoXPyPIctZQRtkzORpYfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NROzCh/fW+ME8HLafElqPy0Gcm89Zr/3D4BVIs9Hx80=;
 b=NrsU/bIdp3W1M7NCW8K+RMKddU7f6ADVuTuHaN1/iVaJMwdr5IvCI16+2u/7Q2pLRRiaRxB9L+uHTp3zYNSQDxOmYQQX8l2iihJ0k+lAx1wiheHJpPDo++Jfg23iEWsKS4J8Lp359gKba97lQxjgROhDu4+wKzooPiB0d4ySIOA=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 21:50:19 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::44) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 21:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 21:50:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 16:50:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 16:50:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 17 Jul 2026 16:50:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.2
Date: Fri, 17 Jul 2026 17:50:05 -0400
Message-ID: <20260717215008.998399-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cefb4f-f9b9-4750-aad2-08dee44d64e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|13003099007|3023799007|11063799006|10067099003|56012099006|6133799003|18092099006|18002099003;
X-Microsoft-Antispam-Message-Info: nK+Ovrfz3v/OrtIbLxjlvGNbEG9GO1tnWrazcopxlLJwcFvEcBatYmlZx361N2RupnUSg+tzkNuQ1qz3webh1whjfIYAmKDYQ2jiONW6aPBXoVQCjK9YFIiz9rwhca0aLPx/Ocfv/N8i9BOLbkd6sxOOsc3MCyY2CmuxthvB3FsbSo9PhlR+oFZ7BKjYRK/zZfE/1zFmN3BAKxT7Yc6/C6y0CIRNbDhfB7Rzaa8LgSS7kvNeNoc1yiD361zbvGG/a6IB7sHIYjcbj+Q9ptzyYSg4AtWPpey3ebfh8f3+Almfgyto23NrQrJkyqubB5e7DEsuCRy711csCe3CF4LZs94y+p92UEKW+Dxd1Yz6nQzSWS4XwpI0FRYlUG8dBiM9FxjBVe221jRZsOIjSbJ7lBvCZL+uMqff2tlhfOWFLc+VmHh8H7oIyIZrP/LVmHWJNpG2sRCVlWdc2ciq11DgCxVY0e/Yoyp1G/pQaB0pW4upQ0yO0unHfZk6F/Bf7xo415b6lRKqw4wt1R/u9gvDz3P/rln/eoYNRKtO6Nj6kIToTuDArrFRBOtBlB/RYUju9jyCxNkRZQ5cyNJQDNpb/H2tBarcDiAbgwaT0iWQDLZmFwsJcacghDnUf6ogNBmslTxGjcg96byb9s8JByBm3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(13003099007)(3023799007)(11063799006)(10067099003)(56012099006)(6133799003)(18092099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w6oohhmNNtIB6+7cCqR8zb/03w+/YS4Bah0rIzOlljwP7zLvtKhRYdcvwmzQsJRJigE+5EQqi4YUNvWlhJKu+DB/DMdMqWE03XP0UMiAsWo44YdCWbQJKw9DwAp/Bq9IWe25l8tlSzowM2MHx9Y5wh1pDDkjDK0CqBAVRLu57CtkXRlQqjlcgrzjh4PN28J22+rViiYfnxZNRnUwfKiMHiy1JAWEKIPF7SGCA60fq21vZaKci0bhak1Y5zSnCKWBS6aM62WBfA8JkiZ9oF9d906atOQZbh4+FcNLY4Xy4k/g/CptByRowIRjUu+hZhlBIChn3d8lyFCnYkIgL6czk9CVGH2AeXVB/sFYycuFfOTb8UmfadE+0V+fDRw4L1esEGNEWoHhP2YHc326AdxANGRIXJQ8JtQRVLOd3NB+ArVB5vgu6HJYTnIScTzpg5fA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:50:18.8450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cefb4f-f9b9-4750-aad2-08dee44d64e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
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

Fixes for 7.2.  Fixed missing s-o-b.

The following changes since commit a13c140cc289c0b7b3770bce5b3ad42ab35074aa:

  Linux 7.2-rc3 (2026-07-12 14:16:39 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-07-17

for you to fetch changes up to f39283eab44fb7e304677b2aa1d8c38f151b6566:

  Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs" (2026-07-17 17:43:13 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-07-17:

amdgpu:
- DCN 4.2 fixes
- NUTMEG fixes
- 8K panel fix
- Backlight fixes
- UserQ fix
- Fix bo->pin leaking in amdgpu_bo_create_reserved()
- VFCT fixes
- devcoredump fixes
- Display fixes
- SMU7 DPM fix
- AC/DC fixes for SMU7 and SI
- Queue reset fix
- PCIe DPM fix
- XHCI/GPU resume ordering fix
- Pageflip timeout fix

amdkfd:
- Fix potential overflow in CWSR size calculation
- DQM error clean up fixes

----------------------------------------------------------------
Alessandro Rinaldi (1):
      drm/amd/display: Force PWM backlight on Lenovo Legion 5 15ARH05

Alex Deucher (1):
      drm/amdgpu: always emit the job vm fence

Andriy Korud (1):
      drm/amd/display: dce100: skip non-DP stream encoders for DP MST

Dmytro Laktyushkin (2):
      drm/amd/display: fix dcn42 det allocation order
      drm/amd/display: fix dcn42b det allocation order

Fangzhi Zuo (1):
      drm/amd/display: Fix 8K Mode Not Parsed by EDID

Guangshuo Li (1):
      drm/amdkfd: free MQD managers on DQM init failures

Jesse Zhang (1):
      drm/amdgpu/userq: fix indefinite fence wait during GPU reset

Leo Li (3):
      drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock
      drm/amd/display: check GRPH_FLIP status before sending event
      Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

Mario Limonciello (5):
      drm/amd/display: Fix backlight max_brightness to match exported range
      drm/amdgpu: Fix VFCT bus number matching with soft filter
      drm/amdgpu: Release VFCT ACPI table reference
      drm/amdgpu: Disable PCIe dynamic speed switching on Ryzen Pinnacle Ridge
      drm/amd: Create a device link between APU display and XHCI devices

Matthew Stewart (1):
      drm/amd/display: Fix DCN42B null registers & register masks

Pengpeng Hou (1):
      drm/amd/display: wire DCN42B mcache programming callback

Roman Li (1):
      drm/amdgpu/discovery: Fix device family for DCN42

Timur Kristóf (10):
      drm/amd/display: Fix preferred link rate for NUTMEG
      drm/amd/display: Add dp_skip_rbr flag for NUTMEG
      drm/amdgpu: Print vmid, pasid and more task info in devcoredump
      drm/amdgpu: Reserve space for IB contents in devcoredumps
      drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658 (R7 260X)
      drm/amd/display: Set native cursor mode for disabled CRTCs
      drm/amd/pm/si: Don't schedule thermal work when queue isn't initialized
      drm/amd/pm/si: Fix AC/DC switch notification
      drm/amd/pm/smu7: Fix AC/DC switch notification
      drm/amdgpu/ttm: Consider concurrent VM flushes for buffer entities

WenTao Liang (1):
      drm/amd/display: set new_stream to NULL after release

Yongqiang Sun (1):
      drm/amdkfd: fix 32-bit overflow in CWSR total size calculation

Zhu Lingshan (1):
      drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved

yanglinlin (1):
      drm/amd/display: fix __udivdi3 link error

 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |  62 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  10 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             |  23 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 551 +++++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  70 +--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  45 ++
 drivers/gpu/drm/amd/display/dc/dc.h                |   3 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |  11 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |   2 +-
 .../display/dc/link/protocols/link_dp_capability.c |   6 +-
 .../display/dc/resource/dce100/dce100_resource.c   |   7 +-
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |   1 +
 .../display/dc/resource/dcn42b/dcn42b_resource.c   |  23 +-
 .../display/dc/resource/dcn42b/dcn42b_resource.h   | 116 +----
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |  17 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |   7 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  16 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  12 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |  12 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   |  45 ++
 drivers/gpu/drm/drm_panel_backlight_quirks.c       |   9 +
 include/drm/drm_utils.h                            |   1 +
 31 files changed, 720 insertions(+), 431 deletions(-)
