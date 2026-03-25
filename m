Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5B9109C033
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABA4210E7C5;
	Wed, 25 Mar 2026 15:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y1O8aYdv";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0EF10E7CB;
 Wed, 25 Mar 2026 15:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8e9K520JP7iMkYrmXTdghy9R/qmMHrUdjl0zQDeAb+PvxpCmxfDv527f8LNhKNIIQesZM74L/VxZqlca1MsUwKeg1SU5l3iIXvwPNVOsBSlHfBGhQVXD4A1x6KPzAJHU3zlDB+QKSRRNVV6jb4EAjqysdXa9Q444p11TQJMPuaGHrn0FkRGB90KxwFIFLBF0vGh4Ba403lEHg9K/WlNbERy0csL65AgxXAesKqE9g56KkvMmP6jVdEeE8wxbSRkG9IRDdu5vAJgSzJkITh94Z1tQ6y2wpGkU40//bel/PFDh/BqVYv5X3BgX3reATYRiStI2Q3Ya2kQNZegZfW7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OwnTFE3Xg2oELQFhvH+eyiDVxIcTomQ4a6NWIuhIh4=;
 b=OAbwRx3OeUARfcHQI+FCRL9Gbr+YAb8BKMdCSwlmVLoxU6IcnFfa+4xw3+K2/tCJmq2Mjy+L3RhWjUPtlMV+1VPGQiql02Ne7NPTRc3i0M5kPz4LPo/35xPB7CBL/AZCsnTzUpuKGqwl5oWit2mtvMyVfsHk+LxQj6ly6te3/t17kYngbXihgU1HD9Cdj4JemJcCpko0zgIG+8zYbP4DLvm6bj7JSM9dXFsk+MtpVd9jOvXUCSSjNtPiwsVQWbKFDHZsNpCItfE4QxufzeMfkcjTTmcVN8ZiEW2TIzC8dzoed4BoqnJEKDWdtqCyMYVT3gTHwKNAcTiydlFiVN8IAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OwnTFE3Xg2oELQFhvH+eyiDVxIcTomQ4a6NWIuhIh4=;
 b=Y1O8aYdvBQED73wxb/o6qy3U8sfQZn+sLZiR/tIHimZHMQ81SqtPHFGqxDy8aru/C8Kv3BNQn5TZSqNSBXpp4SSOv5b3bWTxJkZbeOC6eh6BWuYFGP1zQFP3GzXOsgJzZw1UFmc5LxSQGX0IQ/ehqoTCb76b7fxBNWpY62t6xKQ=
Received: from DM6PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:100::41)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 15:56:09 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:100:cafe::1c) by DM6PR03CA0064.outlook.office365.com
 (2603:10b6:5:100::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 15:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 15:56:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 25 Mar
 2026 10:56:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Mar
 2026 10:56:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 25 Mar 2026 10:56:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd drm-fixes-7.0
Date: Wed, 25 Mar 2026 11:56:00 -0400
Message-ID: <20260325155600.4184877-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 25cb88e6-51ad-4854-bda9-08de8a8707a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: w5GdjPCkYSD0jLUJ+jSKrU7V/OKuTTAaGSpmS8phCVobDWEWZIetWE970qY5s95kwnODbPXl1x6MIqkS4p8+LtRl5hHO78Tt9TdsAnUruG60xAi2AT0mXgwxkUGLn9eZnEwUDS1kWCu3ObZoD/XdX3+7W+gQ/qUpspmTeyIFVZODJLK005/2Vh4TcFdglN8JAoG0raLB/DLhOfnWnmCnH0U8YGcq48qYltmedof9PkT6m8YdY9kU3RRDMX0qLCVaL0FNBgNeLQ83LiU1cRW+lHKDbZV04lTILovZRCXSKqyKjce4FyJKG8QMcBD/mOMuf1eLNeb5ZOqCI4R5DSKcQUZBOHhpf/b2Z57yMBdU1uice2IydVcUjSirx95TXyC7pidf2bLkCFC2ExLfJoBuyA+l9rgLt071SSnSy7ahDDpTWZ7XWtCHdg0QWhyK5YEH/rZbA28+nFG2+Y5qXRBcQMPteOxi0WGrypqhsh608h1asqmS0zL/0tsdTzfVCllhLzoFyTF3nblckjkCrkDaaO++34yHtByobmeWKyNBX64rGoxFrdwwDnT2w4WZDIdMYZbKeFD6nmcqN+7HRfycW5z4qgWOuoXdQA2t7E1/oD0O6akcifiweFvZGBKvxR05YouRhQMfxopnxoIgbmlGNxlmC92Puf7ZwTLz3u/qPN2mYULFQ1Cw27TKmGDSGPfBkRFkIWeTRSFHtLoVXO1qchye4HQq4KQKaI1xSYu4vlI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dM9udEKGkrXVI+7vHOwa9VLqxEjNDyqbJoJjne99JveFbsVAu1BM7fce0G7vxezoyPoUPSXTHmTwO6DH0cM7kwnzx1dzNh7thNREp/YoQL89XPtWL75ZZPO/RjDf2GK/fMSSoRFYqNE0nXSwYt9XK1EviQFen9NycyA/jZO1ZoQsrr/woxEUnfkUzlhSZWEm4Jvo14HMVhCfUPq9/Om+B1WVkio+TytP/T36ffN2fSaBnksm1rVyevSF4tLddVdOPJkrGkoeo8DBVgVbd2YxK08/AY+wVS9okbjVQ4I8fGFrbOMWRnA1dprYoNB+yWx/gTPJ1QVMP6JyI8vUa7NRURUnhxYQP8PYStWXOOVGZVxFVq6nDvzSo5X4vd8+j7chbwtj68RUuTOj6grfJLhB8WJQem466c/3Rhlw1KFhslPOGviCZtx2zfyaH619F8lt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 15:56:08.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cb88e6-51ad-4854-bda9-08de8a8707a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.0-2026-03-25

for you to fetch changes up to 90d239cc53723c1a3f89ce08eac17bf3a9e9f2d4:

  drm/amd/display: Fix DCE LVDS handling (2026-03-24 13:55:47 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.0-2026-03-25:

amdgpu:
- DSC fix
- Module parameter parsing fix
- PASID reuse fix
- drm_edid leak fix
- SMU 13.x fixes
- SMU 14.x fix
- Fence fix in amdgpu_amdkfd_submit_ib()
- LVDS fixes
- GPU page fault fix for non-4K pages

amdkfd:
- Ordering fix in kfd_ioctl_create_process()

----------------------------------------------------------------
Alex Deucher (2):
      drm/amd/display: check if ext_caps is valid in BL setup
      drm/amd/display: Fix DCE LVDS handling

Alex Hung (1):
      drm/amd/display: Fix drm_edid leak in amdgpu_dm

Asad Kamal (2):
      drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6
      drm/amd/pm: Return -EOPNOTSUPP for unsupported OD_MCLK on smu_v13_0_6

Donet Tom (1):
      drm/amdgpu: Handle GPU page faults correctly on non-4K page systems

Eric Huang (1):
      drm/amdgpu: prevent immediate PASID reuse case

Ruijing Dong (1):
      drm/amdgpu: fix strsep() corrupting lockup_timeout on multi-GPU (v3)

Srinivasan Shanmugam (2):
      drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib
      drm/amdkfd: Fix NULL pointer check order in kfd_ioctl_create_process

Yang Wang (2):
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu v13
      drm/amd/pm: disable OD_FAN_CURVE if temp or pwm range invalid for smu v14

Yussuf Khalil (1):
      drm/amd/display: Do not skip unrelated mode changes in DSC validation

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 13 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c            | 45 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  7 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  6 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 10 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  4 +-
 .../display/dc/resource/dce100/dce100_resource.c   |  6 +--
 .../display/dc/resource/dce110/dce110_resource.c   |  5 ++-
 .../display/dc/resource/dce112/dce112_resource.c   |  5 ++-
 .../display/dc/resource/dce120/dce120_resource.c   |  5 ++-
 .../amd/display/dc/resource/dce60/dce60_resource.c | 14 +++----
 .../amd/display/dc/resource/dce80/dce80_resource.c |  6 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 33 +++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 21 +++++-----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 33 +++++++++++++++-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 33 +++++++++++++++-
 19 files changed, 192 insertions(+), 60 deletions(-)
