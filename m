Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C270DC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7336B10E196;
	Wed, 19 Aug 2026 18:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eFHRC1cF";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C04C10E18E;
 Wed, 19 Aug 2026 18:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4mqIxOEO1bm2Y7qddkqe3ZNziny/6khnyWJ0gU6PlJeo/pflHl68MK1glSWqoAUzkyVjUobTQOdWZ4pMrZ8XxanV2AKkuEifWNXpXPOrYT5tJOdKaFInxHDzXloeJLyT2nYovH6LV+sbqZaGNdp5yqqW2Rly4GrgapSSJBzib0I7G3BkR0RXmdNjt0Lq6SaUaQoTsVjs4EOXCS8lc8LJh9STiZAja3sk6Jv0sJQ2KFKOhBDDbRxvIZr+rnKH98XPpPaBlIcKN4aqrYVRc5rMtoaD3aq0aMytfXX73egSTe2N1KhhW1M+wA0im8AaH7b7c6kCCweogNGR9dWp3qJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzIaRBGwxDA7DxG6mE1JmTWij6m7tfJntb3nDGLrvlU=;
 b=OGKZsZIlXRPZF1hiRrfkFKBJLDYPT4yQHX7xcIWiXUPefcQw0IHnl8yO/VX65E0mPN6FNdi8qwZp3DBhvKSrJzhkOvLYrGP1getPnUunlWMARdSQ3PMREWIy+mOVlU5s/Cdt12MRSJEf8gkJB1uu6p4ak7pUiffCXrwG6thrk4sLS2zKpJrAJyONMiboGvDhedo5zfxW/w11LcexDhxRnQyBJVBCMhZ/pbZ3F6ZygY0M1bufCY15D8StbzW+7Ffp1zlOIMFgPlKvuwFtfAEADpeECyYg/EQyIDBRc9ML4enLHa5EdkSS2X3DzMhp5RFE4lpbDDArNXT1RbHYrhu5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzIaRBGwxDA7DxG6mE1JmTWij6m7tfJntb3nDGLrvlU=;
 b=eFHRC1cFEmqS1EUY5lIAroRsW/IkBmm5UIpj6SotTJOVnDl/zRnfoRlp/u+PpBrotzzfTz9ydXaL4zX4CISoYDGq02xokbCsVnvR35+DJoVH4vRQCOrGUw92jtHUHOA4xWQPmbnozm5zvkhQ4NW3wPZf65rglifJEpxCq4sLaLA=
Received: from BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::28)
 by IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:36:29 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::7b) by BL1P221CA0008.outlook.office365.com
 (2603:10b6:208:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 18:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 18:36:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 13:36:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 13:36:29 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 19 Aug 2026 13:36:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, amdkfd, radeon drm-next-7.3
Date: Wed, 19 Aug 2026 14:36:22 -0400
Message-ID: <20260819183622.2406038-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: c1834dda-611e-4393-a21a-08defe20c8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: iEEHwOmKnWk4eG7xf/E5sUTYYoNH0HINxYbFv27roQpEcmVx9/5pmxuDnhb80z/PHglcpsWwSEVtuybJzLSwg9gM2LQ/XQhpfs1lmSktSBak23irSd9SLdJkB5xoHXvOmIxYIMLDVkAPRDQZauxFHLh+NsFcJQOJmWyo67otuQoZ39VHeNQTDoIlIriphXdBADngVMkoNntS4SQ9N3eotI5Uhg29llEff3DiakJmV51UlLmhApp1sg7v6JWdlbrtRnCwpPrPwsI6KUr7DubT8/OyUeKiZYBTUKxET9nYF8gQytssAbsy4Nam3q3HcdQEZHe3X04gzIBcp41PbHRccvd+HrpovT4DoGktpHhn9I7LpjPTiU4xgCQquB3lV7zv2da7TlNeZj65Aepin40drKD7n8TaaLwfpsCQRFs2Ijecyic3kuqsgjTC3fG/KfYFDLJxYNyuItJ2c74pqUh0oYolL/tDOT/ibhGuwq+jkq5YwxVwmDTO0uvFIi8RVIApKxdSFPtOgr/GM3S0ZTR7J22FJMBA3p/RTFwJCQqAMolKaAATVDCcUEq/c0MGF6Eukn6YoCPMNqggTO46n78x89AhkzCWrQlsUTzuSBY3dBUbIc3wdUr1CGbrhy+dJdQJNGQ3W1U/NDFmHb9wz8yasA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /XlWvcdqJjDpBNMSBSv5k/ZFf6TtdAK7WhEUDnq/KhK3ptJ945h0WgDhAE6ndOwQcfrmF/iquVzK0ob33OVhPXMuolz0KL9rjRayhn8ZR8lDAtzXNRAP9Aa7zZVfxsfaGBb/ffQ5vx7NYoj1mbRrgcTswKLB0hflrhDYQLrKvtQLTbGaZC5OoS1GrtU8UMFHT4LL/4HjBc+dXQsoIu1fW0rWC0WMqCw3J4E3yYVc8sBYLnF7PhFPusuMZUkzJ8vvWDHBrVLiutT5NIfpshwBECFEE6Kx/QEidYakmoluICg5OqndiSktEtMbKczoG4ROlOg2cBafazKMNiawlMXx0mIvFVc4qGeo/GMQ6YIpr+gSclRXDHUUzYSx7GHftcTRcCKHGI7cpbRhoCLolD85gdzaJQzUwN1vHh7aM57zwcLJqreahqtJSBNKX8dqJEyF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:36:29.5705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1834dda-611e-4393-a21a-08defe20c8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
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

The following changes since commit 65b92bc671db7c222f8de1146c88e40fe8764d95:

  Merge tag 'drm-xe-next-fixes-2026-08-13' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-08-14 18:30:33 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-next-7.3-2026-08-19

for you to fetch changes up to e4c3ab59021e7c146a84b6671f0d530972bd58b4:

  drm/amd/display: validate plane degamma LUT size for private color prop (2026-08-19 10:14:55 -0400)

----------------------------------------------------------------
amd-drm-next-7.3-2026-08-19:

amdgpu:
- eGPU fixes
- Runtime PM fix
- UserQ fixes
- Backlight fix
- Discovery sysfs fix
- Reset handling fixes
- Buffer func handling fix for xgmi
- VCN boundary check fix
- DC lut handling fixes

amdkfd:
- Fix return value

radeon:
- iMac display fix

----------------------------------------------------------------
Akhmed Zhitaev (1):
      drm/amd/display: Scale custom brightness curve from full range

Alex Deucher (1):
      drm/amdgpu: handle pipeline sync without a VM fence

David (Ming Qiang) Wu (1):
      drm/amdgpu/vcn: fix integer overflow in dec_msg buffer count check

Gilles Risch (1):
      drm/radeon: fix internal display on iMac11, 1 (RV770/DCE3.1)

Guangshuo Li (1):
      drm/amdgpu: fix autosuspend cleanup during removal

Harry Wentland (2):
      drm/amd/display: avoid divide-by-zero in __is_lut_linear()
      drm/amd/display: validate plane degamma LUT size for private color prop

Jesse Zhang (2):
      drm/amdgpu: force complete the MES ring fences on reset
      drm/amdgpu: force complete the KIQ ring fences on reset

Mukul Joshi (1):
      drm/amdgpu: fix sysfs ip base addr for 64bit in standalone mode

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: delay ttm buffer func enablement on xgmi

Sunil Khatri (3):
      drm/amdgpu/userq: ignore duplicate BO locks in userq signal ioctl
      drm/amdgpu/userq: ignore duplicate BO locks when counting wait fences
      drm/amdgpu/userq: ignore duplicate BO locks when returning wait fence info

Yang Wang (2):
      drm/amdgpu: Disable runtime PM for externally attached dGPUs
      drm/amdgpu: check thunderbolt before switcheroo registration

Zhu Lingshan (4):
      drm/amdgpu: ensure all userq VAs mapped before restore
      drm/amdgpu: validate rptr and wptr of a userq
      amdkfd: let profile_lock_device return an int other than uint32
      drm/amdgpu: fix hang and race in userq destroy

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 54 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 15 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 49 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             | 27 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  3 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              | 10 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              | 10 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  8 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c    | 13 ++++++
 drivers/gpu/drm/radeon/atombios_crtc.c             |  5 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         | 23 +++++----
 16 files changed, 160 insertions(+), 74 deletions(-)
