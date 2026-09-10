Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F455C79FBB
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B3510E319;
	Thu, 10 Sep 2026 20:25:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M1ntmPRd";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A870510E314;
 Thu, 10 Sep 2026 20:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7otJ4xOOpIghxp+9/wamxWvPnlKPjIC9PzF4I1aEaPH3MnwYi9RmLY7bFEAX8UgbdNsM+q0r0+1AC/8SDq9iHxLTckWWzIU3oGQSeODd50O8IM8kMsbG7pDBJlt3vgztbFITHd/24sqJoNrm/1ic4zPVEnwEPaNiRf1Pwb8lk/BqswjMjOQ59UtpD4/yeJT4/BDXkGElS4NE8eCTVkDNudEcpH1KVW9YcwEXP+iKOJ8NVi2Ald1i8/Xt4HowNR5nX+AhdU1962jUzjcnSZzM0TGO/Z9rTb8+/965rjG4Ra1tl5ygQ832qIUwk079Pfa2cVhvnsfs4KER1VwlD9M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRs53k8jl5ehDAEfuIN0PT3LOYFHLE6erfX6krUgrxA=;
 b=w+sqiApewiwDyeG+9ICeF6xEJ7oszpu8gyE3NH2J3eJ7sGDw3OFOTQZKCt0HMK0Z6JaCYyADZeDARgll1wB+1Q3jH1Z887kuaiLdJ9pr/3BpzeSBvtA/cXsKfFgjjI1OhmjaMBjb72Q8W9IoaAwS4HrWbwBMxYdJ3RXFPfjpArXqS40xI8uene2bswVihxG/R1xwQFXhDxgus0LF3sRCnLMhRpsnoYMhka1dQnHZ8N15VPjEvKS1uO+rMqC8JCOk1wsBPdrnPo+wKmFdC/Fs3wB0rlC14vqE87ldkz5oGBYamW7Txe3dYPhgGnzIrFG8jh93zhuABJRMzq33GoqoWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRs53k8jl5ehDAEfuIN0PT3LOYFHLE6erfX6krUgrxA=;
 b=M1ntmPRdO7mOuh+8kG49C/M9N0lzqUP6LQod3acHOiLW1dEX5NP7Jx/5u331qi4/lYb1qoMtmzK5SJvkrQ7tqC5UHUH0aZmzvweu2h3sxDVR5lCQioQGGIqPzaYrPaYTe3Mt/pg3m4jynuZiX3Nhp1UnbYzY7rkY2aDeKtwf1fk=
Received: from BL1P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::7)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 20:25:26 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::3a) by BL1P221CA0042.outlook.office365.com
 (2603:10b6:208:5b5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 20:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 20:25:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 15:25:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 15:25:24 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 15:25:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu drm-fixes-7.3
Date: Thu, 10 Sep 2026 16:25:15 -0400
Message-ID: <20260910202516.825788-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 95545c4c-35ce-41c9-d7c9-08df0f79a5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|30052699003|13003099007|3023799007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: qwyexR8B49aefpMOKtKzp/u7KXkE0iP1PRDTXimYzm6y1yNFH6FcKD1ZYfAuiTmumqqsHW0c7S9bikqKFd1s2y0j23d8I/tOF+cFMfLQ2dCpPX++VSdgwMymydxvXYQCtfAEuAFYPCBZtjDEzZ96Yhena8M1VGg+gBqa55EBFnFV4DIIKYPHbH6s6I32FVtCz+cLePiFhyHoKCKooZ/QizK6kpucevJ1/qpY02Snd8jGX6bxotaVm6+cCIk6y7149qayYzP8zwwPADDl5f83J27jd8ZJ1pIcm/0FAPrCxMWrQnfRltHWl2M0PG1inzPY/RhrRYhZdw6iA1qA02nAFHnPl0Wf8sQqcY02mrILgYd2Q0inE/XO/tw0JXm4qtDvdOfdQF4EEy7ujMv1uWGXGAY2zeh52xLdmj5KJCLg4z+5TG4WHZQ6oMf+hkgIp6Afb2AT9J+bKbOxwV5RuZJRr2EWJ0OoJ0z99MUf81JOM5G/eCXfCa0hCZDz9Ogu+2N3tjOxvouDBbdUVTff+8ayQkqM4riKcSzFsNO2YEhP1E0M0xZkL8U/Ou/XgGNOPf9djU4CRI48swWnQrVeraUzm1GEisXrC9D3GE7Zz4xqOndYdHC0hAJG/yYuqhlNLjXaDDkcner8k70KjSyayQ0Lbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(30052699003)(13003099007)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KGSPA5SMbFbjaABr5CsFhbFL2S7LDrKbZLv68tbGWaQ/f9yHNjzGjDmd+QcUBGKwryCYWhLUiC3wZUxFkV8oN8vukROicZBHJMugKngYoJ+Y4Er1evI7OaNFKfwZ3eEmXcnB0RUDqpkAwUVMaHaT515J2Wb02FLsnUr64qhWxTEihQHbzDa53/ZUMzlrH0x4J5AX2jSmCYVe5pSqp05u/5Y/SjP520rPDoAmNbbzlJwXJxCp7UNA6huk97ITFN3Nyg97DLr3d1Jmb5bzIfjOfoNV1jnwqJB44I4x5EjHLmKNrFWLaCttlF5ypXEStjik00g557MlYlPLMqGTsp5dByoIvSKnyrsffg/FglyJ1UNzIpp+w8kP9DVTujilvsAWdTwPr6OfKDGyVDW8HH8rjH6ffECCWdCPxs/oTrpLz6BxPCh5hw8ltJYEpQwC4Ysw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 20:25:25.5073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95545c4c-35ce-41c9-d7c9-08df0f79a5b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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

The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-09-10

for you to fetch changes up to f3c6a8ae601abf2d8476d3f899283cc9a1001f7d:

  drm/amd/pm: report energy accumulator for smu 13.0.0 (2026-09-10 12:56:11 -0400)

----------------------------------------------------------------
amdgpu:
- Freesync fix
- GPUVM fix
- Debugfs fixes
- HDMI fixes
- IPS fix
- GPU reset fix
- RGB quantization fixes
- SMU 13.0.x fixes

----------------------------------------------------------------
Arunpravin Paneer Selvam (1):
      drm/amdgpu: skip the VMID 0 flush for VRAM

Fangzhi Zuo (2):
      drm/amd/display: Exit IPS before connector detection on resume
      drm/amd/display: Fix HF-VSDB DSC bpc detection to be cumulative

Harry Wentland (1):
      dm/amdgpu: fix malformed link_settings debugfs output

Kevin Wang (2):
      drm/amd/pm: fix gpu metrics energy accumulator for smu 13.0.0/13.0.7
      drm/amd/pm: report energy accumulator for smu 13.0.0

Michel Dänzer (1):
      drm/amd/display: Consult MCCS FreeSync cap only if requested & supported

Nathan Chancellor (1):
      drm/amd/display: Shorten hdmi_frl_status_polling_workqueue

Prike Liang (1):
      drm/amdgpu: skip gfx switch_power_profile during GPU reset

Satyajit Roy (3):
      drm/amd/display: Propagate HDMI RGB quantization selectability
      drm/amd/display: Honor Broadcast RGB for BT.2020 RGB output
      drm/amd/display: Rebuild InfoFrames on output color space changes

Thadeu Lima de Souza Cascardo (1):
      Revert "drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info"

 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            | 20 ++++++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  8 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 24 +++++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 20 +++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  6 ++--
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 37 ++++++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c       |  4 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  3 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  6 ++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  8 ++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  4 +--
 12 files changed, 99 insertions(+), 44 deletions(-)
