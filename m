Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B494BCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 21:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33AA112550;
	Fri, 29 May 2026 21:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ubxVKhD";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660F711254F;
 Fri, 29 May 2026 21:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeLzx1uttS7yqAscHjBTh8u0uUoQwdvMC374jpVXJlZNPRO7DDpcS6eeZv/lz00MhjIYHyXugksG+judgyNbYu5gUz/j2spwmpbKMolVqmjgBhK+JuFlBEw6c/u3voZV8RfpxYrOhB1Jeirw0XM3eDnYfQgK0A3CbrqY7I1LisVGY1kxT2cjuCtjC2KJ4eNwKFnt+45xnRm9bIESjlGYrIqIp4QGLnvLSJbVGhgKwk+MkYSKVdB4QUryGQtIaWJrynstmZOFeUxsU1Qn/mqK5NWwy0EfoVz7gBLI4c8SZIc0gd86re0kaExU9bIUD8y6xPX0/kzGWjPy2fsXCeMklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyhDjEi91hCzhLxseBPDKsJVcPMybmVf1F3pf4K+g0M=;
 b=tuJXv4o0pIbB7KnuR/0J4W2FQWbMvFKLtQJ7A95DizQ6lIsYSJ9mi2q5RRHe+2EmYK4qiSM05oCWvWWyRgoxnor4XDroCkn3uku+p5g84KkFsK1ewHkMspQZr6E30aAt5ZI0LVJzwx7f5tR21hW0JwZu06otPWB8UJe2MZ92Qg0sxovncL5/+XElAjQgL6Ic/mB0qsrPkAob4TUCWJD81VCzhT6rKJXfxX116Zb07LW9yvMkBndCqqOJGlMNVv7ABpj9vtUfjf79UujsA2kGOfhcOQrHac7TEowfuk8es8VssaouwcYHB7fWJcl20s//PJ1DXXk790+vJBkGJKOJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyhDjEi91hCzhLxseBPDKsJVcPMybmVf1F3pf4K+g0M=;
 b=4ubxVKhDyZiaYbMsix/IGZLi4FwibqP9ra6supPUnI2wAfEGdPofGBFs9dzWTOROR9sSxVgf1/aVfqSrSOCs8bYg32YKQrd446G6z/xVmXdAJMWsvvHY2c1qzc4t6e4RYp9ikY88Q5SU/+Kepb05rREzCa62IeAuosU4cWomT/w=
Received: from CY8PR12CA0008.namprd12.prod.outlook.com (2603:10b6:930:4e::12)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Fri, 29 May 2026 21:43:53 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:4e:cafe::8d) by CY8PR12CA0008.outlook.office365.com
 (2603:10b6:930:4e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 21:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 21:43:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 16:43:52 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 14:43:52 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 29 May 2026 16:43:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.2
Date: Fri, 29 May 2026 17:43:45 -0400
Message-ID: <20260529214346.2328355-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DS7PR12MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a30add-bb2c-4f4e-30bc-08debdcb60d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|3023799007|56012099006|6133799003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: bohPeCy/E3l+5/v3AnZKqU8MFH+7+jRICw/W1sDZzvNX7AgezE7rSOnr7NdyMXhtfL5RSQZWWsp8GR6adsftLNJqQ/DfJkK9I5QemDZ0N7l9M7TreNMqEm9klrnxNbfBhOfimTCRJ+F8uD5gN2wsUBDxmKOsVIepticxpf9OcaxYBsVQNzskSiFRfyVJJlbKmCFWzw488EazOwQnSfevlWEsNpTi4R6tPBdFafAozg2EksmQwzkzAVR3mSo33rOAyhfGt9UYtAiAVXl3a+YJQCA7fXwplNI+1mDFile2YT3VAUt6HQwOIwv5sVDdBazn6/oKcY37c+TuH8E5yaFdo1ez+PPAq5QMBl6c/R0Kw8dvcvUZfqPFynS23zv1lgGy4zGHBjZUx2FUDgBg0LFZJ14ocz4QnR3Z2ikE0u6TbvG+OIg1b8Y/mBQlJQAkFcP0ezV7VIPQlb+sk9Rohab9/kIzB9pp4i0xnRQlrxUhP1gL+8M82xEU3bqD5tzczoHd3/gwwG7i7LIqW1li71SyP9+d2RcpIAM3yNiyxndX1L1yo3+kGaTBv9sVzfwOU0yIA86kifq9XhZ/9Bg+XNM1qg54RvXWYTxk47fQAHLKY7um9uYHS8rk4Dzj052S8Na41kp/g0XSVvrYjOqwmNu4IZsfuFrq4mmoQrm7BPS00Z+0hK191ot+orCWRbk7oL3p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(56012099006)(6133799003)(11063799006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oCraLmdxsLHxSAA0yYqAvLpkyyW1M1or3hfouTA7j+kH6x3l+uzw+dnLVzIrVjudfCskjXerRBpjeEnNeNSnKXgNVZvv4+iko05arHLwb8fTSHxE5krAh1G87An2dz4E7izJsUMwM1CwIuVBd/SkpzgolcycC3FpeC4WI9athOeod23YFk+c+wbWcHGzutFhZkWN9bvcOYNDm2y594YdK+dRo20LUeNoCyQr+sZnbDxljvV+hnuEC/t/aQHKSpjBjht+27oiF59adaJeDnhZByHTJdoDcRex5OBDQ42ujV6mXOmqDGoE08mvFDIe/2VuhV/DwaSsCjJfYmeEq0WSChwe4FSEDYv9qlxGrJ2R0TlDfZVfPebinn2MsqhWdWlYV8wYNcQLAuDje2PYlBE5DSiqnx2YFoStrRn92L9InT9g5RCWuY4ZeJ+Gim1gz4ro
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 21:43:53.3110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a30add-bb2c-4f4e-30bc-08debdcb60d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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

More stuff for 7.2.

The following changes since commit 4cdbba5a16aaf16513b69cc332b1d6f971a44b52:

  drm/amdgpu: restructure VM state machine v4 (2026-05-19 11:54:32 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.2-2026-05-29

for you to fetch changes up to 470d1ae31d29f90b8998c5c08ee0b267a05fe378:

  drm/amd/display: Add a default case for dc_status_to_str (2026-05-28 16:21:42 -0400)

----------------------------------------------------------------
amd-drm-next-7.2-2026-05-29:

amdgpu:
- GEM_OP warning fix
- GEM_OP locking fix
- Userq fixes
- DCN 2.1 refclk fix
- SI fixes
- HMM fixes
- Add DC KUNIT tests
- UML fixes
- Switch to system_dfl_wq
- Old DC power state cleanup
- RAS fixes

amdkfd:
- svm_range_set_attr locking fix
- CRIU restore fix
- KFD debugger fix

radeon:
- Use struct drm_edid instead of struct edid

----------------------------------------------------------------
Alex Hung (7):
      drm/amd/display: Add KUnit test for HDCP process_output
      drm/amd/display: Add KUnit test for colorop TF bitmasks
      drm/amd/display: Add KUnit test for color helpers
      drm/amd/display: Add KUnit test for PSR function
      drm/amd/display: Add KUnit test for replay
      drm/amd/display: Add KUnit test for ISM functions
      drm/amdkfd: Fix UML build guards for x86_64-only code

Aurabindo Pillai (1):
      drm/amd/display: Add KUnit test for CRC function

Chenglei Xie (2):
      drm/amdgpu: bound SR-IOV RAS CPER dump parsing against used_size
      drm/amdgpu: Fix TOCTOU on UniRAS  command response size

Christian König (3):
      drm/amdgpu: fix amdgpu_hmm_range_get_pages
      drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx
      drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine

David Francis (1):
      drm/amdkfd: Check for pdd drm file first in CRIU restore path

Eric Huang (2):
      drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
      drm/amdkfd: fix a vulnerability of integer overflow in kfd debugger

Ivan Lipski (3):
      drm/amd/display: Write REFCLK to 48MHz on DCN21
      drm/amd/display: Initialize dsc_caps to 0
      drm/amd/display: Add a default case for dc_status_to_str

Jeremy Klarenbeek (2):
      drm/amd/pm/si: Fix updating clock limits from power states
      drm/amd/pm/si: Notify the SMC when switching to AC

Joshua Peisach (2):
      drm/radeon/radeon_connectors: use struct drm_edid instead of struct edid
      drm/radeon/radeon_connectors: remove radeon_connector_free_edid

Marco Crivellari (2):
      drm/amd/display: Replace use of system_unbound_wq with system_dfl_wq
      drm/amdgpu: Replace use of system_unbound_wq with system_dfl_wq

Mario Limonciello (1):
      drm/amd: Add dedicated helper for amdgpu_device_find_parent()

Michael Bommarito (1):
      drm/amdgpu: fix lock leak on ENOMEM in AMDGPU_GEM_OP_GET_MAPPING_INFO

Ray Wu (1):
      drm/amd/display: Fix amdgpu_dm KUnit allmodconfig build

Stanley.Yang (3):
      drm/amdgpu: fix potential overflow in fs_info.debugfs_name
      drm/amdgpu: init locals in umc_v12_0_convert_error_address
      drm/amd/ras: cap pending_ecc_list size

Sunil Khatri (9):
      drm/amdgpu/userq: Fix doorbell object cleanup of queue
      drm/amdgpu/userq: Fix the mutex_init cleanup for fence_drv_lock
      drm/amdgpu: simplify return value in amdgpu_userq_get_doorbell_index
      drm/amdgpu/userq: add amdgpu_bo_unpin when amdgpu_ttm_alloc_gart fails
      drm/amdgpu/userq: reserve root bo without interruption
      drm/amdgpu/userq: make sure queue is valid in the hang_detect_work
      drm/amdgpu/userq: remove amdgpu_userq_create/destroy_object wrapper
      drm/amdgpu/userq: move mqd_destroy to later stage to keep core obj valid
      drm/amdgpu/userq: use array instead of list for userq_vas

Timur Kristóf (17):
      drm/amd/display: Delete unimplemented dm_pp_apply_power_level_change_request() (v2)
      drm/amd/display: Delete dce_get_required_clocks_state()
      drm/amd/display: Remove min/max clock levels from clk_mgr (v2)
      drm/amd/display: Delete max_clocks_state
      drm/amd/display: Set max supported display clock without max_clks_by_state (v2)
      drm/amd/display: Delete max_clks_by_state from DCE clock manager (v2)
      drm/amd/display: Delete disp_clk_voltage from integrated info (v2)
      drm/amd/display: Delete dm_pp_clocks_state
      drm/amd/pm: Delete unused get_display_power_level() function
      drm/amd/pm: Delete dummy get_dal_power_level implementations
      drm/amd/pm: Delete non-functional SMU8 get_dal_power_level implementation
      drm/amd/pm: Delete vddc_dep_on_dal_pwrl
      drm/amd/pm: Delete get_dal_power_level
      drm/amd/pm: Delete PP_DAL_POWERLEVEL
      drm/amd/pm/si: Disregard vblank time when no displays are connected
      drm/amd/pm: Rename enable_bapm() to notify_ac_dc()
      drm/amd/pm/smu7: Notify SMU7 of DC->AC switch

Ziyi Guo (1):
      drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO

 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |   11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c            |   17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  207 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |   31 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   24 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |   47 +-
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c             |    3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    6 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    3 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |    2 +-
 drivers/gpu/drm/amd/display/Kconfig                |   12 +
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile     |    5 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    2 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    |   65 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.h    |   89 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c  |    4 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   17 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |   10 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |    5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |   13 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c  |   26 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h  |   10 +
 .../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h    |   19 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   55 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c  |    6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h  |    5 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c   |    3 +
 .../drm/amd/display/amdgpu_dm/tests/.kunitconfig   |   14 +
 .../gpu/drm/amd/display/amdgpu_dm/tests/Makefile   |   18 +
 .../display/amdgpu_dm/tests/amdgpu_dm_color_test.c | 1071 ++++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c       |  161 +++
 .../display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   |  121 +++
 .../display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c  |  175 ++++
 .../display/amdgpu_dm/tests/amdgpu_dm_ism_test.c   |  636 ++++++++++++
 .../display/amdgpu_dm/tests/amdgpu_dm_psr_test.c   |  255 +++++
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c        |  206 ++++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |   36 -
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   18 -
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  144 +--
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h    |    3 -
 .../amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c |   25 -
 .../amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c |   41 -
 .../amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c |   16 -
 drivers/gpu/drm/amd/display/dc/core/dc_debug.c     |    4 +-
 .../gpu/drm/amd/display/dc/dccg/dcn21/dcn21_dccg.c |   15 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h       |    8 -
 drivers/gpu/drm/amd/display/dc/dm_services_types.h |   30 -
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |   10 -
 .../amd/display/include/grph_object_ctrl_defs.h    |    9 -
 drivers/gpu/drm/amd/include/dm_pp_interface.h      |   19 -
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |    4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |    8 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |    6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |   50 +-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |   34 +-
 .../drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   |   10 -
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   |    1 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |   47 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   15 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |   63 --
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |   18 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |   16 -
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |   17 -
 .../gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |    3 -
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h       |    5 +-
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c  |   16 +-
 drivers/gpu/drm/amd/ras/ras_mgr/ras_sys.h          |    9 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c          |   35 +
 drivers/gpu/drm/amd/ras/rascore/ras_umc.h          |   12 +
 drivers/gpu/drm/radeon/radeon_audio.c              |    4 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |    4 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |   60 +-
 drivers/gpu/drm/radeon/radeon_mode.h               |    4 +-
 80 files changed, 3307 insertions(+), 955 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_replay_test.c
