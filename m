Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB28C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:07:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1B410F116;
	Wed, 12 Aug 2026 20:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zrfZhaSF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BD8E10F0F5;
 Wed, 12 Aug 2026 20:07:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVkWRzufNeDovwpCWCrCaCfmsXdfB1D+ngg27K1l62BZodhQUE7uaYLP5irBZJE6YWxHNZKgP8ls3ZJopMeHd12OvNbt2XPjZzN1lAhMOC8JMY8fY4tUJ0nx9q0ONJGGJePts5uVJli/Sqm9R758xdaCAa/Fn1sjWSrbBkGptSRt7Xk7uSGhBZwjcERNWLt5uNWjJm7vZdkUP7DlLUhkBoWiprF/r8z9pnhQeT9YcMLcO+uFt3E58av5fXqADUgqTWypGLxIRCUSowVPOsA4u2Pe0jtkrjHYjVjla2BqGZsqQJRTRSC4AYyG3N5O/415eyvfCWr5X4zC4PZ08C7cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giid6V5V/3CjSWG2N7pn7BxznPA7c0EGReYqfYtyLGU=;
 b=UAdCRUBjKyKNIVNmuRenMSXCW9M9pI5eJtJVO2DFkXNL+Xq+8Q44X/lYlyd5ZgY0tZD0x2YrMdWBXmr9mGncsKqd4n/F8n2NvaEBgRNMY/qefLgcUhvrUFAtFm6jkFPEbxxbSWuFibu0FK9p07pdXwXffAA0MJqfiqbJOrMmRQTYkrL62f6TS4aDtHXLBpPoxraUoqkSjCU5vEdq8iWFm3+Wrr/SyiZV565Dg70SRW/sWTE/sbMOfYH6AP4yuJqdwCQKt0s+pZhViAV8Hf8G3c/D4YnEJty/sBywvshFcHQFHcQb+sVRjkwOLfj5LP/YKq9g9RHaQYK3fJ8xrcqbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giid6V5V/3CjSWG2N7pn7BxznPA7c0EGReYqfYtyLGU=;
 b=zrfZhaSFma/knfsFjzbtNiUsYyurI4yTZRkOS4YR4wSgL1hSIkAfcOVFW6xEEt2Yfbd6jzreNc1EMjkA244Cx3UaHkZqgSQc2E5bnJGAUavGDXFq+oLaiqFacTmW8wMPV19l4FcFUebVitY5ndyokf7V2P1Ezj69J4kO+lmWcoE=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by MW9PR12MB999209.namprd12.prod.outlook.com (2603:10b6:303:301::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Wed, 12 Aug
 2026 20:07:37 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::59) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:07:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Wed, 12 Aug 2026 20:07:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:07:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 15:07:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, radeon drm-fixes-7.2
Date: Wed, 12 Aug 2026 16:07:20 -0400
Message-ID: <20260812200720.2155401-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MW9PR12MB999209:EE_
X-MS-Office365-Filtering-Correlation-Id: af416c2d-e8a2-4a63-aed8-08def8ad5a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|13003099007|10067099003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: ni/YUtrdzZNKi9oXmkwZeJNRaZqmv6C/LMYh9VsYGH+y0oY43mHidkOEBOvqsio86KFz77leWEcQOABN0FJI3VT0M4IRjMn9phOtRbcs5Ic340bgNvecS3+Gxf2C05v9MFf0G1jU3fqapPDXyxq76tyckEBej/UL/wc1EK6fXa93q5GSkXXD/Iap2ZbBLVeB6A/wfZH1ufJR/mW6jU6Mngij1ngUdjA5K7x79aEfnQmVnQdHMIeZgJpTlF6QE+6NK1iVGxCkCS0L7sU1qfZXoPpyYdOmMNkO0i8PpdiGwEP4uyWkU6DP+hcRxj7p7O6JfkDgiyPU6nANBa3tQz9KLvB75IWNcp+ojCb9kel0Z23DIPLIc4X/23fq+bPm0sgxh88FkpmheqblqYBvavqQ9taQCUS0ePDaEMrgzysr4c9/XFu7IrKRXgvzmt64GmpqtfwjhZZOp1Bfe7myCXCGgc7ybkf4qO5pb0vBns7g3+ah2+Lq8oDq8T4/9kSSIwe5gqg+T7AT0FZ3OsRmbeCUMmnmYY0kzqvHDkqEIcbcZE2rOjMEK3WLn7dXVBRugV73r6E989llh0HHWyH3n86bNzg5lJbPwUtpm3IRMf8EDE5vJjGjNX3T934JCY2yHJbaA8SoFj+o7+X0iXanUupVYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bL7240Az4FYgR8mZy5AWrVvoyjBfMuYuU+PKhtpM48031B8jTofnlksDw+PoF14xnfizIu8l4TDnHE00KcSXNWX5SNhAn+cw+oUgWAXe33bNsIK6isCUf4XXnbVxhlZyiYZOBcRiJ424a2fSihSJOEw5/aGG3TL1oeDI45LGoon4zIIeROBRRo922Ye535+aiCgKqYyGos91Tu8e/S1rIEyLJb9pOf2U8RLc3BKxHjzPJ4+BYzU3d6osomujZyoeWjke1jpuAgzAOS1+lVPMHrBBWmHf7ZuF/2QHD4l0kZ5Wd4k8A18CVG5q97WOtAnQQ/bSAySMUzW20qqwMuFAOD/gRq7hQ3MbRDElJM6m9jKWN/mSGp7B5wKrpEAPRnkV4tJySSS2cZM1pGk9CQUDagRxYIcMrN/O3+tGOrVzQsdEi8vJKtr3kqJViws0RYYw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:07:36.3488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af416c2d-e8a2-4a63-aed8-08def8ad5a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999209
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

The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.2-2026-08-12

for you to fetch changes up to ac828b94e027d29af82325fcc55556dc8173fd85:

  drm/amdgpu: Prefer default discovery offset (2026-08-12 10:23:07 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.2-2026-08-12:

amdgpu:
- Bounds checking fix in CS IOCTL
- Bounds checking fix in GEM IOCTL
- Display fixes
- GPUVM fix
- ASPM fix
- UVD bounds checking fixes
- VCE 3 fix
- BT.2020 fixes
- NBIF 6.3.1 fix
- IP discovery fix

radeon:
- Runtime pm fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: fix missing check in vm_flush()

Candice Li (1):
      drm/amdgpu: validate GEM_CREATE domain combinations

David Rosca (6):
      drm/amdgpu: Reject UVD message with dimensions above 4096
      drm/amdgpu: Fix UVD dpb min size calculation for H264
      drm/amdgpu: Fix UVD decode image min size calculation
      drm/amdgpu: Fix UVD min buffer sizes
      drm/amdgpu: Implement insert_end for VCE 3
      drm/amdgpu: Reject UVD message with invalid number of h265 refs

Guangshuo Li (1):
      drm/radeon: fix autosuspend cleanup during teardown

Junrui Luo (1):
      drm/amdgpu: disallow multiple FENCE chunks in one submit

Lijo Lazar (1):
      drm/amdgpu: Prefer default discovery offset

Nathan Lucas (2):
      drm/amd/display: fix BT.2020 YCbCr limited output CSC matrix
      drm/amd/display: fix BT.2020 YCbCr output CSC matrices for DCE

Samuel Pitoiset (1):
      drm/amd/display: Fix NULL pointer dereference in amdgpu_dm_crtc_set_vblank()

Yang Wang (2):
      drm/amdgpu: check ASPM on the dGPU host link
      drm/amdgpu: fix nbif 6.3.1 l1 low power not functional

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 50 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 13 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 21 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            | 85 +++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  3 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c           | 42 +++++------
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              | 26 ++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_hw_sequencer.c  | 31 +++++---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |  7 +-
 .../drm/amd/display/dc/dce110/dce110_opp_csc_v.c   |  7 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |  1 +
 13 files changed, 176 insertions(+), 116 deletions(-)
