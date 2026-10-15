Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46DDCCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 22:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050291124F0;
	Thu, 15 Oct 2026 22:10:22 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2FA1124EE;
 Thu, 15 Oct 2026 22:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uK+uSpT6EQFvDWZPk/aMlzgcc1xYd8ErNUNB1X3yJujA11JTiAlxDQsWhzawNoh2wm374/riZuODnrBTFOZlDGhdvAkEx/A5+XZ8G9vFVBmnayy6fD8slVpmJ6w9ZYJGT1G5Qg8KWDpe0wKeEUgpDmn+Dy4ebru2NzSB3m1xaFtGzHkIrf/Y+gYnZrj27ZZ64GuaJ6abLmP7e4+YM86i/Fq/J5je3FKbby7P1Y/UpUto+ZudxEEJ+gIicPs2sT76QDvTKSg2KHKjlZ+ULaJYCiirILpO4zOAnjL2TxpqCpqtYd6BzArQ5rNT0GD4Eg7TBsOkmu2wLazBcHpAU91Ahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8u1VZapl7r/4GmwPCC2lGfbxWFO2JhwHlVfuViJaQY=;
 b=iZL3f2ZCLorrP5XoJ8yR/NP7jC1vJ18Atzj3XJcywDxE87x2wp/0QKBh217rLdCQP/llr2dSDdHy1XCLABM5J/eMoLYTht/RJ+I538LbInZ4xYCbQqzQV1gyLOffL7U75yimw+CRm/aASJzzGvCW3Bbm4IrIA+DmljTfOfBX91XLuIn8RDfjGvzNVf+mJgbs9aWUqD00ux38T2XP/2ZnI8qgQ/OkdfCpntqhRfyB41a1X++VxV5d10Xo7R2P8EIYibVNZd0Woxf72p5zsmz0Y8OPXNgDnQuTr7TWA8Mmr9lw+EEw6g3VPg7L/bZASgqcUwwSTlIYVWnSnfL7YzuAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8u1VZapl7r/4GmwPCC2lGfbxWFO2JhwHlVfuViJaQY=;
 b=j7Q72mUABt3eVq1KAK0ioy8roHTy5tOGWs5rmXJNw3aiwA/RWR0RzVDtTUjuK2u6RsceV5tAgR/wapNEQfqwIybGBXWMl/qoaTTK8GgWZNT4s4wr6PQvx7xr7QdQwWsAUhzqDVMm8ZOzVKa+VUrEp9J9Pii4qxGrMF0P2qT0wl4=
Received: from MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19)
 by IA4PR12MB749807.namprd12.prod.outlook.com (2603:10b6:207:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 22:10:12 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:8b:cafe::2d) by MW4P221CA0014.outlook.office365.com
 (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 22:10:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 22:10:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 17:10:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 15 Oct 2026 17:10:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu drm-fixes-7.3
Date: Thu, 15 Oct 2026 18:10:02 -0400
Message-ID: <20261015221002.1728931-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|IA4PR12MB749807:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbee141-a1d6-4c97-61db-08df2b09152f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: /gv3UW4MR/+K4pSFHlqQ5QYqb2SHr9KKkb3CvfsZkNxhsVoQdXXzKMWHcS54Bxw+4Tq/ySGl2gUcPf3hPlHOIbiqjaTUXPIs+UlybC8iNugU0Bsrc0jVyy85MgRj5l8Hrl0KNyIBpcH8CVjNXgwaurMMIwa5IkPT1KgcMUHGWzWXh/ukL2L7eMD+5OHG993V8JgrawE1Hqek15+kryUOrf350U21PER+/7evZcmvLPnAWBNHK4R5GnqJL3tqjxBuQoaH/jR/ZT6dYTPm+TRR+ciBiCYVjGuS0+JBEMxQ/GHUE/hdzchD9ybmfES+om5i9K+4UzMU5s2m0644fmJzb6ZP8ukINffmeqgpe96n/I30vfvEk7IKGz+HUKbcqJxszIJiHy6JHjLhdLmvk3CIt/p5fdFEsDRm3vhwtJ7CSG9UAaU3lxjtv+iC/x3eCxm15UgFhWIX+itGBJuAd3PO9a3802MRdkbHyYi8lrEiqIEDrPrk1FkhvW548ceR7DEDfCdxc6Don1zm8y69aBc2qQF5fVGjFcV34C0o/CSr4IFqAQHJyGuXvmwNu+zOnPuAT2a45zPqRS8MMTC91mPTy3MUGlCX6ztBJABIop3eKv0FsSgupHEa7A306ZgjdyEj27xhmo9HNQ+ygyo0wO+I2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +XxvxhcY6xwa/kfLueVfXrZfrrW9+jMBgxmMaKEbWdWsD1Rn/BuUmKrWBVdkW7l67QiTS8n1DOu7jUQTaa9Hj87G/bPH48gGOCQNtEFJM+dNZpWHZD4PmjTbehP8JOeCsIjHf2gUpzSkptw8XVJtVhoFShLMqdd9+rDWkLT7Os3aYq4CKQPyMS7Fu+rPGOxv/jbKfj9huN9rHPkIHd+3IzyNG/ASsVjl04KLydodo3NeQKQR+vPSnpGre/LK8KYmeBdgaMAcb5yGk71V0B7c6WEwpnkJQ0NljKuFSwVTfV7awfblT4AeY47VBw2IvLnZzUYY7gWCiaShxPeczlHK8jjYtM7rvZSaRKUX3L/DfmNZH1B7F/rvHbjM5bwR7HkzULZTInnYNC+TZmUYCEhKAz/kNZlvmWr7S9Eu5ynPvjXIDzj2p91mgdmW8SZ7iM7f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 22:10:11.8674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbee141-a1d6-4c97-61db-08df2b09152f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB749807
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

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/amdgpu/kernel.git tags/amd-drm-fixes-7.3-2026-10-15

for you to fetch changes up to 752480ad62964edf0254e151110d3e53a7cb37de:

  drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang (2026-10-15 12:46:58 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.3-2026-10-15:

amdgpu:
- UVD fix
- TTM sched entity fixes
- SMU 14 fix
- Userptr leak fixes
- Runpm ref count fix
- CRIU fix
- UserQ fixes
- USB4 fix
- SDMA 3 fix

----------------------------------------------------------------
Benjamin Cheng (1):
      drm/amdgpu/userq: actually validate userq BOs

Jesse Zhang (4):
      drm/amdgpu: don't drop the runtime PM reference twice in amdgpu_gpr
      drm/amdgpu: free the userptr ranges when a CS fails after parser_bos
      drm/amdgpu: report the BO alignment in bytes in GEM_LIST_HANDLES
      drm/amdgpu: keep the eviction fence until the last handle is closed

Kenneth Feng (1):
      drm/amd/pm: add zero fan stop temperature support on smu 14.0.2

Perry Yuan (3):
      drm/amdgpu: fix sched entity leak in ttm buffer entity init
      drm/amdgpu: destroy mutex when tearing down ttm buffer entity
      drm/amdgpu: fix GEM object leak on ENOMEM in userptr ioctl

Srinivasan Shanmugam (1):
      drm/amd/display: Fix NULL sink dereference in USB4 bandwidth functions

Timur Kristóf (2):
      drm/amdgpu/uvd3.1: Fix checking whether UVD firmware keyselect was already set
      drm/amdgpu/sdma3: Work around POLL_REGMEM / FENCE hang

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 15 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        | 21 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 17 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  7 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 10 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             | 25 ++++++++--
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |  2 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    | 18 +++++--
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   | 55 +++++++++++++++++++++-
 9 files changed, 126 insertions(+), 44 deletions(-)
