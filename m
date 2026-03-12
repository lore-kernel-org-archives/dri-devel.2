Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EFD106ACD6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 18:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B69310EA85;
	Thu, 12 Mar 2026 18:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IZRj02rV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011041.outbound.protection.outlook.com
 [40.93.194.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13DCB10EA85;
 Thu, 12 Mar 2026 18:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCyjpnYz/NouCxIc1efWbal0ZOvpK3dl9/8AAFda2nWpYTpc1f9TQMTzfBDSYjAAKSPt7DtXHYu/2oj+eXkKcsfm6M50HNPyCwFNKXn+oNZORyE5PIBbdBSvoGoO8d2+1Y0YR/TLy4bwJCdwPtUrWFkIjyFsORcN9H0W9V9eufl6oXojNt2r7C3vyFTeZ/uL3vGTfXbgPssXf/JFSQWBCmZqQKIOyLhJ9MPT1TLdrN9kDffoP9N2FDMe7+nhKgY5YDP5jYeF8ZYz6/l+czMYMl/cNHSlO1EOMO3IOgC0rG8bwgvhXYQSl5Ux7pcNHmOSDmqFo6MlX0PTUbdzphiYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXEBIZw3Fe222CbQoxDODj7bkGn0sO2sy7w+U2osykY=;
 b=LPcgCsd4k0a5axW+GeE+cpmLl0agftX+kCPe9BX/uKKZ28IVGOn9bjlaDl/zBKRtqL3QrEGAFSeGmMtRXtJLcxe2Pzquj60cqwFZ5YwPDVeYTebEx3UrcvuvwRtuNN0C2LHXIYyEgjkcNVYsR5K2FE2LeH93b9WbUy6rNiJJJHLeQDDFsGoehFaC7Vg4RvdzvgWpQ/pO8iBz+5mfoitIDArLCkhlpYrglEnmiXryLiVPVYBkpPJKp7WMjblWgiO3z4vl3rm9hQScaX+vW3B01iahjmX4x5HQ3AUHBLsvrfnHYOcr2G60q9EXYZ7ytHhlhSGbbrGrJh8cPpWuhZHevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXEBIZw3Fe222CbQoxDODj7bkGn0sO2sy7w+U2osykY=;
 b=IZRj02rV9JyF6IRpOpksJlnv6eIhNMJ4hGXip2IyObN5z0pmAYBo+zo12xfhBi4VrR7kSpNZOtKkjp+95uWBjHZ55C5yQ+ieYNxBksmtIeTfj1mpS/bpdFNFSSzOs2Re89/WPSURrJYYLdM+tVWEshWURLPeOpEvmCtdiZ4mwvw=
Received: from BN0PR04CA0084.namprd04.prod.outlook.com (2603:10b6:408:ea::29)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 18:44:38 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::9f) by BN0PR04CA0084.outlook.office365.com
 (2603:10b6:408:ea::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Thu,
 12 Mar 2026 18:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 18:44:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 13:44:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 12 Mar
 2026 13:44:37 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 12 Mar 2026 13:44:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.1
Date: Thu, 12 Mar 2026 14:44:25 -0400
Message-ID: <20260312184425.3875669-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 90da67fe-10f6-4aa7-276b-08de806769b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: E2IEKrOwc9ulKJejMQFUkb+Ev7ml10CSAJJ4541BniWhaBRCovd6q9m+2gJskISivd1OJxxEkNat6WvzMr82U14qSWmTzPptT9RUEqk+tTCvZinHGPgI4CDifYPYCQxRC+/hpl7dC7csZq0qrXyaE9HJxBk6EybxavcYEX7ktoBX4TTWCbeOuQDNtyJZ2qm8UG71WK01QTrW0zMHgNkoYRRflw5m9FBcG1w8aVQA29JAc2b45g8fs2rOQlE4VlbRs2pDlk5K+pXz+R3iII42hX2E4iSntdB2us5jKg3lz5YN0jk19mnKzBADCLDbiixsicNfICx6E62uLtc9yqjZxYmdXMS+YImuC59koIFjt13QvJ0cQFyPs5JjrhXg88WKRNoQF1zPA61dQZN8zg4EN8OHMhW3eaZ2nbfpOi5zOuwN0CeRgJJ6+h5vlyvo1no7kqGFwNMWYaEixh9dn7TUJC7TGTFQ6V/wu78va5jpfd4XTFGxkhgqVJVy6DG88H0/01nTfPaCI1wN8QCrpGggq3soyIMZdFhBhlhVMeXyQKIHNL0+HYv7o0+0sa3VtxbAjV7ulfMtZWqq8SvKy0GjPfp0jigF5mv6OtvalQS46j7WmR4ua9mkz0R4VwRj+YI1QHzbR1FTdgWwwqqSrArKCp7d8V52N3/Ly90TgFVGaRwruibbGggmlk9vxDSkhUDFdwzECL1a5nfv88Ze21F7lacoqVHQCK6+3c4abUdrxbI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pdaMECOXbO9A6TWj/pu3h7IovjXQRRMBlAZV2UaGFZFMDy+/0t4B7VS72cHBzNQM5+A0SnEX7fd9itNCKls/PZy+h02TK2LN1p3+w8pDJI/ztwfs/8Apn/kJfx9lEAY3U0GaGoX2agUsvZ7CPJyJnAYJ81UEKAY1ak7KXDaQY66IpgN7jqqLCHdDSyoXh5i+6FYyaXAEnX6p7Clc628WPpUaH34NfT5UqPkciL5tIKE6cLAnJEuswtUycG/j83D4VIVHvgQaJHwAMjlOm/7Tb/whnXY/V1YncZ8TYEvOSNMI3ndhkXX3ZuJP8qB63f7cu+NIQ4z0A1wiJyWAbquso9D9Veo2ypZEZ/QUfx5AxnqoaDUi6m8uNG3ZK9Mv1QVtpfTQ7VHHogruioRPnxu3CUzBxnqhokta4qe9GOIh2tbXD7robJaMR4VmbskZTg1S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 18:44:37.6282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90da67fe-10f6-4aa7-276b-08de806769b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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

New stuff for 7.1.

The following changes since commit c5d8df53b620eb094855a2bd88be89c4bdf7a031:

  drm/amdgpu: Fix mutex handling in amdgpu_benchmark_do_move() v3 (2026-03-04 11:50:56 -0500)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-03-12

for you to fetch changes up to 7a9419ab42699fd3d4c857ef81ae097d8d8d5899:

  drm/amdgpu: revert to old status lock handling v4 (2026-03-11 13:58:08 -0400)

----------------------------------------------------------------
amd-drm-next-7.1-2026-03-12:

amdgpu:
- SMU13 fix
- SMU14 fix
- Fixes for bring up hw testing
- Kerneldoc fix
- GC12 idle power fix for compute workloads
- DCCG fixes
- UserQ fixes
- Move test for fbdev object to a generic helper
- GC 12.1 updates
- Use struct drm_edid in non-DC code
- Include IP discovery data in devcoredump
- SMU 13.x updates
- Misc cleanups
- DML 2.1 fixes
- Enable NV12/P010 support on primary planes
- Enable color encoding and color range on overlay planes
- DC underflow fixes
- HWSS fast path fixes
- Replay fixes
- DCN 4.2 updates
- Support newer IP discovery tables
- LSDMA 7.1 support
- IH 7.1 fixes
- SoC v1 updates
- GC12.1 updates
- PSP 15 updates
- XGMI fixes
- GPUVM locking fix

amdkfd:
- Fix missing BO unreserve in an error path

radeon:
- Move test for fbdev object to a generic helper

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: gfx 12.1 cleanups
      drm/amdgpu/gfx12.1: add support for disable_kq
      drm/amdgpu: use common defines for GMC 12.1 HUB faults

Asad Kamal (4):
      drm/amd/pm: Add aid/xcd/hbm temperatures
      drm/amd/pm: Enable aid/xcd/hbm temperature reporting
      drm/amdgpu: Add default reset method for soc_v1_0
      drm/amd/amdgpu: Disable reset on init for soc_v1_0

Charlene Liu (1):
      drm/amd/display: Update underflow detection

Christian König (1):
      drm/amdgpu: revert to old status lock handling v4

ChunTao Tso (1):
      drm/amd/display: Add new types to replay config

Clay King (1):
      drm/amd/display: Clean up unused code

Cristian Ciocaltea (1):
      drm/amdgpu: Fix kernel-doc comments for some LUT properties

David Francis (1):
      drm/amdgpu: Check for multiplication overflow in checkpoint stack size

Gaghik Khachatrian (2):
      drm/amd/display: Clean up NULL pointer warnings in dml2
      drm/amd/display: Fix compile warnings in dml2_0

Harry Wentland (3):
      drm/amd/display: Set chroma taps to 1 if luma taps are 1
      drm/amd/display: Add NV12/P010 formats to primary plane
      drm/amd/display: Add COLOR_ENCODING/COLOR_RANGE to overlay planes

Hawking Zhang (4):
      drm/amdgpu: New interface to get IP discovery binary v3
      drm/amdgpu: Use memcpy to update IPD table for sriov guest
      drm/amdgpu: Handle IH v7_1 reg offset differences
      drm/amdgpu: fix shift-out-of-bounds when updating umc active mask

Ivan Lipski (2):
      drm/amd/display: Add missing DCCG register entries for DCN20-DCN316
      drm/amd/display: Check for S0i3 to be done before DCCG init on DCN21

Joshua Peisach (2):
      drm/amdgpu/amdgpu_connectors: use struct drm_edid instead of struct edid
      drm/amdgpu/amdgpu_connectors: remove amdgpu_connector_free_edid

Le Ma (3):
      drm/amdgpu: update GFX CGCG/LS flags for gfx 12.1
      drm/amdgpu: bypass IMU ucode loading for MP0 15.0.8
      drm/amdgpu: fix array out of bounds accesses for mes sw_fini

Lijo Lazar (1):
      drm/amd/pm: Fix xgmi max speed reporting

Likun Gao (9):
      drm/amdgpu/discovery: support new discovery binary header
      drm/amdgpu/discovery: use common function to check discovery table
      drm/amdgpu: Add lsdma v7_1_0 ip headers
      drm/amdgpu: add support for lsdma v7_1
      drm/amdgpu: fix DF NULL pointer issue for soc24
      drm/amdgpu: correct SDMA instance number for soc v1_0
      drm/amdgpu: change sdma doorbell size for soc v1
      drm/amdgpu: disable rlc fw info print
      drm/amdgpu: fix sysfs ip base addr with 64bit

Mario Limonciello (3):
      drm/amd: Fix NULL pointer dereference in device cleanup
      drm/amd: Fix a few more NULL pointer dereference in device cleanup
      drm/amd: Set num IP blocks to 0 if discovery fails

Nicholas Kazlauskas (2):
      drm/amd/display: Fix HWSS v3 fast path determination
      drm/amd/display: Add documentation and cleanup DMUB HW lock manager

Ovidiu Bunea (1):
      drm/amd/display: Add min clock init for DML21 mode programming

Peichen Huang (1):
      drm/amd/display: Return early from vesa replay enable function

Philip Yang (1):
      drm/amdkfd: Unreserve bo if queue update failed

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: include ip discovery data in devcoredump

Roman Li (3):
      drm/amd/display: Enable dcn42 DC clk_mgr
      drm/amd/display: Add DML support for dcn42
      drm/amd/display: Sync dcn42 with DC 3.2.373

Sunil Khatri (7):
      drm/amdgpu/userq: remove queue from doorbell xarray
      drm/amdgpu/userq: remove queue from doorbell xa during clean up
      drm/amdgpu: fix warning for potentially insecure string
      drm/amdkfd: fix the warning for potential insecure string
      drm/amdgpu/userq: defer queue publication until create completes
      drm/amdgpu/userq: declutter the code with goto
      drm/amdgpu: push userq debugfs function in amdgpu_debugfs files

Taimur Hassan (2):
      drm/amd/display: [FW Promotion] Release 0.1.50.0
      drm/amd/display: Promote DC to 3.2.373

Thomas Zimmermann (2):
      drm/amdgpu: Move test for fbdev GEM object into generic helper
      drm/radeon: Test for fbdev GEM object with generic helper

Tom Chung (1):
      drm/amd/display: Add back missing memory type in array

Weiguang Li (1):
      drm/amd/display: Add ESD detection for replay recovery

Yang Wang (3):
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v13
      drm/amd/pm: add missing od setting PP_OD_FEATURE_ZERO_FAN_BIT for smu v14
      drm/amdgpu: fix gpu idle power consumption issue for gfx v12

 drivers/gpu/drm/amd/amdgpu/Makefile                |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  53 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 529 +++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h      |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 135 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 146 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c          |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c             | 107 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c               |  36 +-
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c            |  99 ++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h            |  31 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c             |   5 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c                 |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c              |  50 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   7 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |  16 +
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |   1 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   | 301 +++++------
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 134 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   1 -
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |  41 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |   9 +
 drivers/gpu/drm/amd/display/dc/dc.h                |  61 ++-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h          |   1 +
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_trace.h          |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |  26 +
 .../gpu/drm/amd/display/dc/dccg/dcn20/dcn20_dccg.h |   9 +-
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |  21 +-
 .../drm/amd/display/dc/dccg/dcn301/dcn301_dccg.h   |   8 +-
 .../gpu/drm/amd/display/dc/dccg/dcn31/dcn31_dccg.h |   5 +-
 .../drm/amd/display/dc/dccg/dcn314/dcn314_dccg.h   |   5 +-
 .../drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c   |  20 +
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.c |  59 ++-
 .../gpu/drm/amd/display/dc/dccg/dcn42/dcn42_dccg.h |  11 +-
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |  16 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.h  |  31 ++
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |   3 +
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |   4 +-
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |  56 ++-
 .../dc/dml2_0/dml21/dml21_translation_helper.h     |   1 +
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   1 +
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.c    |  15 +-
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h | 263 ++++++++++
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |  13 +
 .../display/dc/dml2_0/dml21/inc/dml_top_types.h    |   3 +
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c | 111 +++++
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.h |   1 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_factory.c |   9 +
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.c   |  63 ++-
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.h   |   2 +
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  33 ++
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h |   1 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |   6 +
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn4.h   |   2 +-
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c  |  76 +++
 .../dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h  |  12 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |   6 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |   6 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |   4 +-
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.h   |   2 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c       |   2 +
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_legacy.c |   1 -
 .../dml21/src/inc/dml2_internal_shared_types.h     |   3 +
 .../drm/amd/display/dc/dml2_0/dml2_mall_phantom.c  |  41 +-
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c   |   3 +-
 .../gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |   8 +-
 .../gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c   |   8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c    |   2 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c    |  23 +-
 .../dc/hpo/dcn31/dcn31_hpo_dp_stream_encoder.c     |   5 +
 .../amd/display/dc/hubbub/dcn401/dcn401_hubbub.c   |   4 -
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 201 +++++---
 .../drm/amd/display/dc/hubp/dcn401/dcn401_hubp.h   |  23 +-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c |  85 +++-
 .../gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h |  16 +-
 .../drm/amd/display/dc/hwss/dce110/dce110_hwseq.c  | 158 +++---
 .../drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  32 +-
 .../drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c    |   1 -
 .../drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c    |  12 +-
 .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  | 421 ++++++----------
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.c    | 553 ++++-----------------
 .../drm/amd/display/dc/hwss/dcn42/dcn42_hwseq.h    |  10 +-
 .../gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c |   8 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |   2 +-
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |  73 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |  36 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |  18 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        | 112 +++--
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |   1 +
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  12 +-
 .../dc/link/protocols/link_dp_irq_handler.c        |  36 +-
 .../dc/link/protocols/link_dp_panel_replay.c       |  23 +-
 .../dc/link/protocols/link_edp_panel_control.c     |   3 +-
 .../gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c   |   4 +-
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c | 177 ++++---
 .../gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |  25 +-
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   | 390 ++-------------
 .../gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h   |  50 +-
 .../gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h |   8 +-
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.c | 105 +++-
 .../gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h |  13 +-
 .../amd/display/dc/resource/dcn20/dcn20_resource.c |   2 -
 .../amd/display/dc/resource/dcn42/dcn42_resource.c |  10 +-
 .../amd/display/dc/soc_and_ip_translator/Makefile  |   3 +
 .../dcn401/dcn401_soc_and_ip_translator.c          |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c            | 163 +++++-
 .../dcn42/dcn42_soc_and_ip_translator.h            |   1 +
 .../soc_and_ip_translator/soc_and_ip_translator.c  |   4 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  71 ++-
 drivers/gpu/drm/amd/display/include/dpcd_defs.h    |   3 +
 .../amd/include/asic_reg/clk/clk_15_0_0_offset.h   |  44 ++
 .../amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h  |  52 ++
 .../amd/include/asic_reg/dcn/dcn_4_2_0_offset.h    |   2 +
 .../amd/include/asic_reg/dcn/dcn_4_2_0_sh_mask.h   |   9 +
 .../include/asic_reg/lsdma/lsdma_7_1_0_offset.h    |  44 ++
 .../include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h   | 105 ++++
 drivers/gpu/drm/amd/include/discovery.h            |  13 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   3 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c  |  42 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   3 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h   |  13 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |   3 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  30 ++
 drivers/gpu/drm/radeon/radeon_device.c             |   7 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c              |  17 -
 drivers/gpu/drm/radeon/radeon_mode.h               |   5 -
 include/drm/drm_fb_helper.h                        |   8 +
 163 files changed, 3803 insertions(+), 2501 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_mcg/dml2_mcg_dcn42.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/lsdma/lsdma_7_1_0_sh_mask.h
