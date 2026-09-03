Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D2EC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7218610E150;
	Thu,  3 Sep 2026 17:47:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fuMeQhKd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9D110E150;
 Thu,  3 Sep 2026 17:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhtv93BfD1XHST3uLOQVD0dsKbsisCIz+Phn72YpBbVD/XmZLIy5vsTdQpNyZG+c/66L7ifqLgmCjYBIuiisjX5FxZaUn+SYJquCrBHdF0HL0vUbmSAj5pWsSYNRQTJtoMV5TnvzWhnqOK1D/F0FNmtcCWAB6IwTXJ5bc2RWOhE0m4KZJPnZvTHQzgcIIg3e0XzkODeSS1CVy4SRAVcO8IqC9/7JLIhE6zPRdHGafwGx1VOX4gK6bSm/dKCqFAH5eX7gu+opq/fhajXYQtuiP3P4/oTQ2jot9woUl8QcRRds2Q2WGgM0vRBdyHXYJ4dmhtvOIXp4K54xl2zHJ8DodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4aKMGf00JO7s2htTSbIzDUsqw1cxGjeXy2zNFoR8M8=;
 b=DijkVGMvAPABNrmNR45kPzo058QOctge3XrVEZrnbJXdED8RAxHKp+JeiwQ4ITI1uoDhLT/dkAANXPqfuTBefICn/ZXbtY6btGdW1ef3zqATnbgC/wy51a/TlM+V0jY60OhYXb+5GWPyY1SyzgXqKrd1touN6YonqeowCNr4IBSlWzE4s90zqHTUDPsPvRwH5zW55vsk6qNfDQwVZvfPmPB52EiVjLtKrlYLXYiFCg2xriF4fSo46MyBe1BFwqydGB6IBccij4Tu3b6mOzVLLt5yw/0N/EuIF3Mts5uxAQnLdyfc1K4TU5Os/6VOmhoGlnSp/77f0hyjY4KIye3pgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4aKMGf00JO7s2htTSbIzDUsqw1cxGjeXy2zNFoR8M8=;
 b=fuMeQhKdO85yKIX78T8TzjoBLrv4hHwFi1/KO4/sBTc1XssgX5VxObuPPvuyjckv3++lhBhtGLh4nofHiFhcrtTp2CSQL4OKReJjDtwWXzWkhoqTRKt5dg45jzaIBu8/FF4F6DaJ8GdQDphfrcZ2A3WrYUV8zF39yjEgoA8/ntU=
Received: from CYXPR03CA0091.namprd03.prod.outlook.com (2603:10b6:930:d3::14)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 17:47:36 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::2c) by CYXPR03CA0091.outlook.office365.com
 (2603:10b6:930:d3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 17:47:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 17:47:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:47:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 12:47:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 12:47:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.3
Date: Thu, 3 Sep 2026 13:47:12 -0400
Message-ID: <20260903174712.584320-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: e1cb5320-0dc9-439f-e5c3-08df09e3705f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: ceEUy6NSXG8b7lvoOXaoGEBwnfVMVvDDq0NMar5TEPcYEf6qPmlZeUhROw6Hp+1CwjZR7MOLZDEaF7SfDxsv7s47XJBBBhed5ab+GG8ePfS26rYliGWHwZDlqTzNc+d3DKTVYAb10YIReXQYMDX7LyBijRLAFG5T98MhdZ5LNceZw0cfnHIlhOUrxd4a6iubwHW7f3nx2Dt3Js5BsfO2V8CkLvaqcsQxdzUEZ8wz4hGdxAirl/pxyAFiHSv3cemL2iTD1zzAPqRmMcFHii3jIonXR0VCDF4EBJvBckqH5pVohWbRoolKcBqXcRm1sohg+sJwAM2WIDZj1YNO5W2Bh9r6fCbb6Q/JPwmj3HTkVeVSZwklj0OollhHstr7Ah0XW7pV/HgHbW00qDgOy2ABAcWU+JqixnOehumHptbURFsl9TUQ1XVaapv6Fx7YzM6lA6ma/7Ev4MxIv6VSa63taWaciWbrSH0pK3yFLuchCCUlbSCyqHW4YbcLcHa/yF30rklGnmpSA+Wqzi73Chm9pYlU2KjdbCGg93mpzqajTCa+hy5HciyCH4xB8drNYyvUYdJq6rsSOsUsVWPzo/Re3IewBQAoQ3jbUhTN2o8CGKJIorwXI8EOzc0/sP8xTP4UQoIcU3Gz9Sup7anpz4gg3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T9OLgUVR2M1kmfQfQKyPsfdewrl/6wTBafKCyZQ5Ld2SfCgX9loOCZ6ct/zgZ6lBXyZasVIBsl5TFcg3X1txmuHnAmGeOVgUvD23EaAvAT4SjI1s4pm/Lih3jizv7lK7f9qzmWCdEcMH42gg9rv7H7f7ySn1pdseppw+Il6UNZOIO0Jnjk8rnd262PAD1vJuS0m9AAw+bks27Udl7rUO+Za236la1zpqzqNP5E0Zdp21uPi2aRwx7IFsLuiZucFTZ8BLBH8DxFOh5zOhKtdJkGt5d+dMzopJ13h5hOOmD4G341NIvpXehWgSvNDnLFLNZr0bwIJVrCl4nCCgmTiWgW1WCyhLgECHFaEx4Y9qgzche0Ha2mUepEGS70ERQ1QPskm4/lqP6UoSxKdwCPPKrgkFs7Qu70NlaS83paAf9KekrjapMVsPeyIYMUBNja7Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:47:35.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cb5320-0dc9-439f-e5c3-08df09e3705f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-09-03

for you to fetch changes up to 13af55f71399f5e562f6cb59ad413476e513c4d4:

  drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding for 32bit compile (2026-09-02 17:02:23 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.3-2026-09-03:

amdgpu:
- SR-IOV fix
- GFX8 fix
- MES queue reset fix
- GPUVM fixes
- DCN 6 warning fix
- DCN 3.5/3.6 fix
- DML fix
- Backlight fix
- Colorop fix
- DC get_estimated_bw() fix
- devcoredump fix
- Userq fixes
- APU PSP fix
- Cursor fix

amdkfd:
- MES queue eviction fix
- MQD debugfs fix

UAPI:
- Fix for drm_amdgpu_info_device with mixed 64 bit kernel and 32 bit userspace

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/gfx8: only apply compute quantums to KCQs

Amber Lin (1):
      drm/amdgpu: Update queue reset support version

Austin Zheng (1):
      drm/amd/display: Remove const Qualifier From Non-Pointer Fields

Hari Mishal (1):
      drm/amd/display: fix division by zero in get_estimated_bw()

Ivan Lipski (1):
      drm/amd/display: Fix DCN5/6 DML2 compilation warnings

Kanala Ramalingeswara Reddy (1):
      drm/amdgpu: Skip accessing psp rum time db for APUs

Mario Limonciello (2):
      drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
      drm/amdkfd: fix scope of mqd_mgr dereference in pqm_debugfs_mqds

Melissa Wen (1):
      drm/amd/display: use halving distribution for all encode-to-linear curves

Priya Hosur (1):
      drm/amdkfd: Add TLB flush after MES queue eviction/suspension

Roman Li (2):
      drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
      drm/amd/display: Fix backlight control for luminance-capable OLED

Sunil Khatri (6):
      drm/amdgpu: use AMDGPU_GPU_PAGE_SHIFT instead of PAGE_SHIFT
      drm/amdgpu: fix Idle BOs list in VM debugfs status info
      drm/amdgpu: fix byte/dword unit mismatch in coredump IB dump
      drm/amdgpu: update the fw version for gfx11 userqueues
      drm/amdgpu: update the fw version for gfx12 userqueues
      drm/amdgpu/userq: dont overwrite the error of subsequent map call

Yogesh Mohan Marimuthu (1):
      drm/amdgpu/userq: fix struct drm_amdgpu_info_device padding for 32bit compile

Yuling Li (1):
      drm/amd/display: Fix cursor disable with horizontally split planes

 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  6 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c             |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |  8 +++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 13 ++++++++-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 12 ++++----
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  8 +++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  7 ++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 34 +++++++---------------
 .../dml2_core_dcn5_funcs_mode_programming.c        |  4 +--
 .../dml21/src/dml2_core/dml2_core_shared_types.h   |  4 +--
 .../src/dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c  |  2 +-
 .../display/dc/dml2_0/dml2_translation_helper.c    |  1 +
 .../display/dc/link/protocols/link_dp_dpia_bw.c    |  5 ++++
 include/uapi/drm/amdgpu_drm.h                      |  2 +-
 20 files changed, 83 insertions(+), 59 deletions(-)
