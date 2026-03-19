Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ED71090223
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAE8510EA0C;
	Thu, 19 Mar 2026 13:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a3WfOdrI";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010030.outbound.protection.outlook.com
 [52.101.193.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A00710EA0C;
 Thu, 19 Mar 2026 13:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCqcWh9wzXnhb8r1OZZTAdOrih54EITieC/OWQ3KjjPBFj/MB3GViNnLwDjDKjMp/hPlELNB2IaO/Unk13MFU0LcPEvPpW6MfIzKLY/7oK8zjNGvy8OcFXnqczEA14A7X6J1gI+fW3v3bXimx4MRp3Hh+070JgTPoY9oNmRnG0Bw+VeUhdZ1QXCNmWHOoWf/KqQsQlcrhnn/IqKnTRNAxQoTw2nKR+nMgIyGIOK4ZjPOujORfWssafhCn4YnjzqBGqZsnQjJoymV/qxKGmP4DcxQdkFCiVrM+ubpghicxw5gZA345PjEglBQ9wbeYlFnd7VBC167ICyy3mzdKfAL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ6ppPHPugdi0+lW+EI6Tv9vJfzvKZwUWxsfand5PhI=;
 b=GJsqu43Z+T507NJoSVlQd99z0avYDfBzS6OTa5X5JhIeHhbdY9+LRxlQbSsFDqx7j7+m3y8cva8Q6UwJB+knzhb9cRqjxrtDJv2CSO+kkVsXbuDKO3gwsvpT0GcgkrTjuTejUmqMP/G2FuZKrmbXMnj5+zlxCwttfOFbAqK8RdgXQZdmIiVwNwR5lTcnc0ahHe86aokrrYA2DAQxzJMDf2srxSEe0GkKzdN5N2kGMS8bu6cJ4/cwdtts/4nQHyOJ0X/b4aDneX48M5s4ziRz1Tk1yo7fEYpcYSGn1wG/GsXoeTHE1IlUJ4CVIKKW//Ce8Z4onjRW/Ee821Rd+AEyQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ6ppPHPugdi0+lW+EI6Tv9vJfzvKZwUWxsfand5PhI=;
 b=a3WfOdrIw2fw3CZr1ihw12HyZA5o7UUEKgrAZ59NKbET6KfUss5kPC0EfSplmWyDs07070ZSSP5sZ8PJiGqAI7RfPwMM9Yt9ONjdxE5kMDsevJUyfVqfTzCMw6S24GopwBP2EfmIc5wd5wNhAH1U3ywqBIIn2zGM5E11bFDXL2U=
Received: from BLAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:36e::7)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 13:10:22 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::6b) by BLAPR05CA0007.outlook.office365.com
 (2603:10b6:208:36e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Thu,
 19 Mar 2026 13:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 13:10:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 08:10:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 06:10:21 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Mar 2026 08:10:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu, radeon drm-fixes-7.0
Date: Thu, 19 Mar 2026 09:10:13 -0400
Message-ID: <20260319131013.36639-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: e5131814-c349-475e-ea65-08de85b8e036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: toxwROvnryzCPZB74oFPSdKdnh003bvicEm9dEO5SU6txCodQE8NgnGHAsZXJJfgZ8Y0hlradg5dia5tfEWUP10wk1WRl2YjeDynIaEsuzLwaJLKkBTuGcjj8JLQr0KvsJFOIFPyqlK72bMMDsOOBHQq2lIXy/HxMW6mpfhA53jgZTTjtTAlWnDDOah725VmUqe7FXjwHXmRXY0013/Xy/C0Msh8Imzc/27e4MDfFvk8/GhTB0HTBGFrKGKQTvnB/2HptRm8tQ69LwBNCremTa5TCMi5G0s5SI5eVYz6s6FNBAUnXQDIhUM9Mf3rMWPkn2zxYZPsDIndT+n+sK89zGwMucJ58RQUCGecnX/CtDyNg4a+Re7p7FWaVw2/aY2ZJZCsDyQKGxhiYBhVDymathkc2Gyl5HyegCv8HDlMuJZIZ7HZOnPTB3+opdF1x3qiUMTtxiPSnRyqHQdDKfP+j6/4RjmiBJ5bKtv7ED40VEDJAVTA8TVKYcLtn/oFhaSpNyhoHPw5crWwe/cAffM8KKDQ6l2OQI6fy4WoNLPiZRX8rv7fQjX1doadIwk0CqYylvpYkt/nzFmHSKeoUD80+IUVbkJZoQ8/usiTACIdouYXkCqkAAVZdXmppGpmMQeIpaUdblCtAITDrIa3/+/a7ff/jUB7/dNNNsqL+0SRmebExeEkR4ruYMNJJr1yqv+7mHIOHDKmDN+sxLpiQZUaPAXbfoRtuyhGeJQdW4ryLTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wbf4VPrgUXRzbxfZdFkNXpDTZWMrb9kUrZ8H3wlkud0Lr7fcskgnFmHJJC2bQu14CsSA8kNCoQI+97y/mVCcSgNRjr0a+AahnI9iUqvsaVCcnyio4oenwQy+TtvAVDK8SLXl5JSPq0sYhAUiqhkQAD2tEr8yBlhSmphcgfwElHoe0JZ2yeiMNVkmX8xMrBIYTOURKc32xR/dr07qRbgcHLs20erYA8Tf8bdVVXNqvhhvkIu7ExrrCT1/j3gX/6iIPsoGCceWk/zWo8sNtNQUhRutKU+9/ih0IOkrBKt4emQwinlDHNFwxsuFvC/aYVStyLVdtAxKaq7J7tZ6IeR+/hkriAax+U0B7a5HJWxxTtkSIMXZ2NXJkpRwW4V6lro66/JKHX5chpl0L/vg2yAp+qCBhZKGHZ6wdWow3QJcZ/4Yf1qaeKXE5zwPyCGQX/OA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:10:21.4909 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5131814-c349-475e-ea65-08de85b8e036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.0-2026-03-19

for you to fetch changes up to 86650ee2241ff84207eaa298ab318533f3c21a38:

  drm/radeon: apply state adjust rules to some additional HAINAN vairants (2026-03-17 18:04:15 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.0-2026-03-19:

amdgpu:
- Fix gamma 2.2 colorop TFs
- BO list fix
- LTO fix
- DC FP fix
- DisplayID handling fix
- DCN 2.01 fix
- MMHUB boundary fixes
- ISP fix
- TLB fence fix
- Hainan pm fix

radeon:
- Hainan pm fix

----------------------------------------------------------------
Alex Deucher (11):
      drm/amdgpu/mmhub2.0: add bounds checking for cid
      drm/amdgpu/mmhub2.3: add bounds checking for cid
      drm/amdgpu/mmhub3.0.1: add bounds checking for cid
      drm/amdgpu/mmhub3.0.2: add bounds checking for cid
      drm/amdgpu/mmhub3.0: add bounds checking for cid
      drm/amdgpu/mmhub4.1.0: add bounds checking for cid
      drm/amdgpu/mmhub4.2.0: add bounds checking for cid
      drm/amdgpu/gmc9.0: add bounds checking for cid
      drm/amdgpu: rework how we handle TLB fences
      drm/amdgpu: apply state adjust rules to some additional HAINAN vairants
      drm/radeon: apply state adjust rules to some additional HAINAN vairants

Alex Hung (1):
      drm/amd/display: Fix gamma 2.2 colorop TFs

Andy Nguyen (1):
      drm/amd: fix dcn 2.01 check

Calvin Owens (1):
      drm/amd/display: Fix uninitialized variable use which breaks full LTO

Jesse.Zhang (1):
      drm/amdgpu: Limit BO list entry count to prevent resource exhaustion

Pratap Nirujogi (1):
      drm/amdgpu: Fix ISP segfault issue in kernel v7.0

Srinivasan Shanmugam (1):
      drm/amd/display: Fix DisplayID not-found handling in parse_edid_displayid_vrr()

Xi Ruoyao (1):
      drm/amd/display: Wrap dcn32_override_min_req_memclk() in DC_FP_{START, END}

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c         |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c              |  7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h              |  2 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c               | 21 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c             |  9 ++++++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c             |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c             |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c           |  3 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  6 +++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c   |  6 +++---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c    |  8 ++++----
 .../amd/display/dc/resource/dcn32/dcn32_resource.c  |  3 +++
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c          |  4 +++-
 drivers/gpu/drm/radeon/si_dpm.c                     |  4 +++-
 18 files changed, 65 insertions(+), 31 deletions(-)
