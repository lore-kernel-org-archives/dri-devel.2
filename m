Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00326F99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 22:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E969310EAD0;
	Fri, 17 Apr 2026 22:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RHqFyfPJ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A5110EAC6;
 Fri, 17 Apr 2026 22:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVCzIhjIVITlOh7mi5pDPkpXNNXb0U9kZqEb1q1cvghvqT4p84QYP9lQWK4AqH6uNLGX2c436RjfRjoce/1H7LJFqVXCqO73d3IkI6vHDSOcmX2QmPowsqBN+Ody9ZhOsq3Xy9vJUlwY654L8ozJrsT2BlTToMny2lW6TEBAyndEGrJC4HESn1h3HrI4UqM4WyJ5QO34ZW7sFoYwU7BgY76OPuk/Ben1g/patjo5dtoS4YEwCZPJPHBzwdA/j4d5jBG2H0q6fv2oUxRJ4Xs0pTlV8vjXgmSMpRmUHar+7GFjBq3m/h6MgCdkAMr1QWvUwR/9OZxWQ31OuZS42nvS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k5hZ8SIyFu51dOsPdNGwzukqsbfFGPZO4lLnR1JSts=;
 b=WwMNEIUfH+s0PWAgQqxykKq2VmRaPcR7vDOqryUWozWzvPzEbGd1NYgStGL1as79ahc0OkWg1IeksXif3mHS6VpLlZlE3CP7vMEBYo8OfwAEzgk9Na8trdpOzvbyNz/di0DcqjJYuY9Dg6lo/EJh8MpYzVB3H4wDEGDdrXY5juSgd7L5WxQOKPAfw7FcnbavtTmvNSDbRnmLmvYMBwfMTtPFhB2Yk/mI2mOvZQFTNXU+YmXJlVrkt+xgKZDDjEvIDJFxE0oYQlwKIGdgtmhFr3n2z/w/5AqwTTO9X/ZBpB0lTYgezPm0QAI1E6CCPbeRyooSYw9Mo0EQX0qYdfCqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k5hZ8SIyFu51dOsPdNGwzukqsbfFGPZO4lLnR1JSts=;
 b=RHqFyfPJL8CRJ/WrQlxnaFIB2FYf0XHvktLD4P4SVd3XsVSLCASHXLBIrJ1Da0ZAyLEBPNhhwmC1XWlRbmXRlkKACxeRSDgUczf1pDcuA68FfGYop+yQg0+Gi228yOaKAcklJXwRHaEItoGsotYhX4SLkYhYPCSrs9Qb0ti9p8k=
Received: from SA0PR11CA0121.namprd11.prod.outlook.com (2603:10b6:806:131::6)
 by LV2PR12MB999097.namprd12.prod.outlook.com (2603:10b6:408:353::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Fri, 17 Apr
 2026 22:54:03 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::de) by SA0PR11CA0121.outlook.office365.com
 (2603:10b6:806:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Fri,
 17 Apr 2026 22:54:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 17 Apr 2026 22:54:02 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 17:54:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 17:54:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 17:54:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-next-7.1
Date: Fri, 17 Apr 2026 18:53:51 -0400
Message-ID: <20260417225351.8714-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV2PR12MB999097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d317a0d-2708-406c-1702-08de9cd43891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 1rFhSnvqay28RFf2XklpSaI7/i/rv5Hl/6lacI7Xx7wb4RA/n9SHBPK3DhsI6X+IMjOJl49PyovjDutO/4Wk66rchoxkHZxkyjEp7zM8FfcxEfs8HFi5vqVbcB4mleLAwHNUvtnwx6mpKjM2maPXgdmEVmn+LXGd/QF3EjGi3YKUlYCNGqOJcgNATtFUjIi6tCZVSkjbfvyvD/g8faC92DuQfmGW7TYsRxved80vT6SQRvvvmE8Uwwmv4RuYULXzYvdlYKpcQ+zljuut4Sv5OImFjLdvBM0ehsqOD50B8EnyVB7bTZ2JpiXirvfu0b51Mbz1RSXDIHTgI23ZpVrrhpjSBBWrX5Yx7Ok3wOPTtqj2uBUrW5zkqNvZaFeNzhK/rAjg23Cq4zVN02wgp7TLGbG+Ym4tQVbzMOK4sOKaLdrB7xHta4BZkGZj3jqtCTg6b8kxSWPdkmAGr03V4E/ezdZBRAY3CZoSe+1yHUBlaknp5n3S0E8ey9gIyLaWxpHoWZTps9GC49O6FFqRPIsmmvTYQAyxjEYY0SJnjFRG+7uhjXMcU8eOBuwKZaiMR6cNo2BxkhszzaFLtr5pHM7R5onqEpCXwC0LrMRl4Qk0E9N90QC/2PLp7tWSEHuXjZiJXXSDfe7COOEI9z5adaAmh0hejMKcPpMp9rJRbff3dEpbK3Cnvm4yvvvwrvlae0GF0OxOqqnUNCY90Bxbha3MTyns3vR6HxvXf94VblCcQlY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RNeB9HCDM3UmhAtWymhrHSQUcYrxsfVzAVLENmg43NwEurfa0BgN4tDxJ1G4lZs7Ly/rvvBSPa/GD9JcnO4AvhzOO/0a6pqwa56DG7G5CSoSvjVWhtJbDAAHYDOzbuISTesAFJelo85SLNROOBB8ceBinfuNhkES/5syxwrV7+1SQogcmJ269NLx96FvvlYLCJzrx/WNY1PhrqGoOj8jBpUaNSbKJVXBPWlzYUmd6+Yk4oY8+pMBqDm+UlpwIzkSblOer3F4s3WirkPteeT0unci9KURu5DettWUkU4aeFgEwr6BSf5keqnaH+1Ky+q6srCU0M27Cz8a8K73CaqKiNAGfJVeewR/B1AiO1TrMGE4siEGUu/QZHpYDpijkkkKBi9hDycKWYgD5tC89qzMJr4XmpSNqED0gZBCgHdil2yo44RCDpTAza7qwth3lkRz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 22:54:02.8575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d317a0d-2708-406c-1702-08de9cd43891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999097
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

Fixes for 7.1. A bit bigger than normal as this tied up some fallout
with the merge window, includes two weeks worth of fixes, and has
some fixes for a new IP that was added in 7.1 (DCN 4.2).

The following changes since commit a7756371e57f69a137f295a418fb56f15ff2c10f:

  Merge tag 'drm-misc-next-fixes-2026-04-17' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-04-17 16:29:24 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.1-2026-04-17

for you to fetch changes up to dd88d42d9ca0dd7a4ed327dd33f6ead76cedf726:

  drm/amdgpu: drop userq fence driver refs out of fence process() (2026-04-17 15:41:12 -0400)

----------------------------------------------------------------
amd-drm-next-7.1-2026-04-17:

amdgpu:
- SMU 14 fixes
- Partition fixes
- SMUIO 15.x fix
- SR-IOV fixes
- JPEG fix
- PSP 15.x fix
- NBIF fix
- Devcoredump fixes
- DPC fix
- RAS fixes
- Aldebaran smu fix
- IP discovery fix
- SDMA 7.1 fix
- Runtime pm fix
- MES 12.1 fix
- DML2 fixes
- DCN 4.2 fixes
- YCbCr fixes
- Freesync fixes
- ISM fixes
- Overlay cursor fix
- DC FP fixes
- UserQ locking fixes

amdkfd:
- Fix memory clear handling

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/sdma7.1: add support for disable_kq

Alex Hung (1):
      drm/amd/display: Use overlay cursor when color pipeline is active

Amir Shetaia (1):
      drm/amdkfd: Clear VRAM on allocation to prevent stale data exposure

Ce Sun (2):
      drm/amdgpu: correct single device PCIe reset flow for DPC
      drm/amd/ras: Avoid ECC status update in hw_fini for VF unload

Charlene Liu (1):
      drm/amd/display: update dcn42 bounding box

Chenglei Xie (1):
      drm/amdgpu: gate VM CPU HDP flush on reset lock

Chuanyu Tseng (1):
      drm/amd/display: Fix coding style issue

David (Ming Qiang) Wu (1):
      amdgpu/jpeg: fix deepsleep register for jpeg 5_0_0 and 5_0_2

Dmytro Laktyushkin (2):
      drm/amd/display: update dcn42 memory latencies
      drm/amd/display: move memory latency update to dml for dcn42

Gaghik Khachatrian (3):
      drm/amd/display: Fix unused parameters warnings in dml2_0
      drm/amd/display: Fix implicit narrowing conversions in modules
      drm/amd/display: Fix compiler warnings

George Shen (1):
      drm/amd/display: Remove unnecessary Freesync w/a from DCN32

Mario Limonciello (1):
      drm/amd: Add missing firmware declaration for PSP v15.0.0

Nicholas Kazlauskas (5):
      drm/amd/display: Fix HostVMMinPageSize unit mismatch in DML2.1
      drm/amd/display: Correct MALL parameters for DCN42 soc bb
      drm/amd/display: Pass min page size from SOC BB to dml2_1 plane config
      drm/amd/display: Fix DCN42 gpuvm_min_page_size_kbytes in SOC BB
      drm/amd/display: Add DCN42 PMO policy for DML2.1

Prike Liang (1):
      drm/amdgpu: drop userq fence driver refs out of fence process()

Rafal Ostrowski (1):
      drm/amd/display: Move dml2_destroy to non-FPU compilation unit

Ramalingeswara Reddy, Kanala (2):
      drm/amdgpu: Use SMUIO 15.0.0 offsets for TSC upper and lower count.
      drm/amdgpu: Use NBIF offset for register RCC_STRAP0_RCC_DEV0_EPF0_STRAP0 .

Ray Wu (1):
      drm/amd/display: fix NULL ptr deref in ISM delayed work

Relja Vojvodic (1):
      drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (2):
      drm/amd/display: Drop unused tiling formats from dml2
      drm/amd/display: Remove redundant includes from DC

Srinivasan Shanmugam (6):
      drm/amd/pm: smu7: Remove stale error check in smu7_hwmgr_backend_init
      drm/amd/pm: Fix mode2 reset ACK handling on aldebaran v2
      drm/amdgpu/mes_v12_1: Fix iterator reuse in mes_v12_1_test_ring()
      drm/amd/display: Add missing do_mccs parameter description
      drm/amdgpu: Clear cached EDID pointer after drm_edid_free()
      drm/amd/display: Fix ISM teardown crash from NULL dc dereference

Sunil Khatri (12):
      drm/amdgpu: add job->pasid in check as amdgpu_job could be NULL
      drm/amdgpu/userq: avoid uneccessary locking in amdgpu_userq_create
      drm/amdgpu/userq: clean the VA mapping list for failed queue creation
      drm/amdgpu/userq: fix kerneldoc for amdgpu_userq_ensure_ev_fence
      drm/amdgpu/userq: dont lock root bo with userq_mutex held
      drm/amdgpu/userq: create_mqd does not need userq_mutex
      drm/amdgpu/userq: caller to take reserv lock for vas_list_cleanup
      drm/amdgpu/userq: hold root bo lock in caller of input_va_validate
      drm/amdgpu/userq: unmap is to be called before freeing doorbell/wptr bo
      drm/amdgpu/userq: unmap_helper dont return the queue state
      drm/amdgpu/userq: use pm_runtime_resume_and_get and fix err handling
      drm/amdgpu/userq: unpin and unref doorbell and wptr outside mutex

Taimur Hassan (2):
      drm/amd/display: Promote DC to 3.2.377
      drm/amd/display: Promote DC to 3.2.378

Vitaly Prosyak (2):
      drm/amdgpu: fix NULL pointer dereference in amdgpu_devcoredump_format
      drm/amdgpu: fix heap buffer overflow in amdgpu_coredump ring dump

Wayne Lin (6):
      drm/amd/display: Adjust freesync pcon whitelist
      drm/amd/display: Parse freesync mccs vcp code
      drm/amd/display: Read sink freesync support via mccs
      drm/amd/display: Enable sink freesync via MCCS
      drm/amd/display: Avoid to do MCCS transaction if unnecessary
      drm/amd/display: Fix fpu guard warning

Wenjing Liu (3):
      drm/amd/display: fix math_mod() using arg1 instead of arg2
      drm/amd/display: add const qualifiers to watermark params struct
      drm/amd/display: add pstate schedule admissibility flags and frame-time utility

Xiang Liu (1):
      drm/amdgpu: fix CPER ring header parsing

Xiaogang Chen (1):
      drm/amdgpu: Remove sys file compute_partition_mem_alloc_mode at module unload

Yang Wang (4):
      drm/amd/pm: fix incorrect FeatureCtrlMask setting on smu v14.0.x
      drm/amd/pm: fix runtime PM imbalance issue in amdgpu_pm.c
      drm/amd/pm: add read arg support to smu_cmn_update_table
      drm/amd/pm: add od table upload error message parsing for smu v14.0.x

Zheng, Austin (1):
      drm/amd/display: Remove Duplicate Prefetch Parameter

filippor (1):
      drm/amdgpu: fix IP discovery v0 handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c           |  36 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 140 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  47 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c         |  12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  31 ++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c           |  52 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  21 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           |   9 +-
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c             |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c             |  12 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 135 +++++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 241 +++++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c   |  78 -------
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  |   2 -
 drivers/gpu/drm/amd/display/dc/dc.h                |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h          |   6 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   2 -
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |  10 +
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h   |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |   6 +-
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h   |   6 +-
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  37 ----
 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile     |   1 +
 .../drm/amd/display/dc/dml2_0/display_mode_core.c  |  17 ++
 .../drm/amd/display/dc/dml2_0/display_mode_util.c  |  14 ++
 .../dc/dml2_0/dml21/dml21_translation_helper.c     |  24 +-
 .../drm/amd/display/dc/dml2_0/dml21/dml21_utils.c  |   2 +
 .../amd/display/dc/dml2_0/dml21/dml21_wrapper.c    |   4 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper_fpu.c    |   2 +
 .../dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h |  25 ++-
 .../dml2_0/dml21/inc/dml_top_display_cfg_types.h   |  14 --
 .../dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c |   5 +-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c     |  37 +++-
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |  40 ++--
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.c   |  73 +------
 .../dml2_0/dml21/src/dml2_core/dml2_core_utils.h   |   3 +-
 .../dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   1 +
 .../dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_factory.c |   2 +
 .../dml2_0/dml21/src/dml2_mcg/dml2_mcg_factory.c   |   1 +
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c  | 192 ++++++++++++++++
 .../dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h  |  17 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c       |  21 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h       |  10 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_factory.c   |   3 +
 .../src/dml2_standalone_libraries/lib_float_math.c |   2 +-
 .../dc/dml2_0/dml21/src/dml2_top/dml2_top_soc15.c  |   2 +
 .../amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c  |   9 +
 .../display/dc/dml2_0/dml2_translation_helper.c    |   6 +
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_utils.c |   1 +
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c   |  11 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c   |  10 -
 .../display/dc/dml2_0/dml_display_rq_dlg_calc.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |  13 +-
 .../gpu/drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c   |   2 +-
 .../gpu/drm/amd/display/dc/dsc/dcn401/dcn401_dsc.c |   2 +-
 .../gpu/drm/amd/display/dc/link/link_detection.c   |  25 ++-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   3 +-
 .../display/dc/link/protocols/link_dp_capability.c |   5 +-
 .../amd/display/dc/resource/dcn21/dcn21_resource.c |   7 +
 .../amd/display/dc/resource/dcn31/dcn31_resource.c |   9 +
 .../display/dc/resource/dcn315/dcn315_resource.c   |   9 +
 .../display/dc/resource/dcn316/dcn316_resource.c   |   7 +
 .../dcn42/dcn42_soc_and_ip_translator.c            |   4 +
 .../drm/amd/display/include/ddc_service_types.h    |   1 +
 .../drm/amd/display/modules/freesync/freesync.c    |  32 ++-
 .../drm/amd/display/modules/power/power_helpers.c  |  49 +++--
 drivers/gpu/drm/amd/display/modules/vmid/vmid.c    |   8 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  14 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   3 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h      |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  70 +++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  37 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |  14 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |   9 +-
 91 files changed, 1344 insertions(+), 510 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h
