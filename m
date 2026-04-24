Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B305FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D57410F6DD;
	Fri, 24 Apr 2026 22:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OP4tSzT0";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73E2210F6D0;
 Fri, 24 Apr 2026 22:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWoQMRCniApBpbezKXgxUMy07tO3yVB5oBj69zNyN6p4cUA/hmxWW4hD8YBXMMbYOkvwpaBajB0kY0dg53BodER80+EQ1G1JzP85NEGtpfAPVCYhlUqzYV1Ce/ebAA0ki9Tt0HLWdzj02LCDHsMNKziaEo0WgZf+M5pXO5TLd335/9iipbROIrNEYgA3tX8DiosXi0tdG/cr1FR5gUV4O0SLISnO1/Rr9am0q9cOitPAB0v/MDeMiyEI76tSDxPu5Q/OH+g1k/2gWhM+d27qlvoyseCEDSGUxpp14Zwx0EZM6IHIde//Io90KQuhk9Y257ESt6CXuCeGCQAAbYf3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI3sLFTR2O9PnDCU7fwH6ImeyeZTAXyrhrianinh8p0=;
 b=MMu98hRWRx6Fjs5eBtvHZh7tfJQMyC2xbdwCSuKyWC5Slv3TxuPs0IVsag4DP4aGFwK6F0ABvAqAjU9vzLQVo+6zCNHd2y2THa6rcst1TBCxcySetoXYpguP9EEDYJE4RTrzP6IAnJZMp+Xu/jbO20l4HtUy00a0ONUmyHwrs5FoTY6qgCPxeojrXW7ZSub3q8WiTPk3EaATxaYU8vmnUoL6235Gjba9wmdvJ9bku5+QG3qvnitjbB4cO0hYRtzzRohMMpbUSmrcdyT1UuJJEeMUPBebC9WVE19JyUNOW+qcNFUg2fHcDXIwpl8uxXZB8MIS+6QtLhjzJMOPlCz2+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI3sLFTR2O9PnDCU7fwH6ImeyeZTAXyrhrianinh8p0=;
 b=OP4tSzT0SLBoSmu/o+CxvMYG+UBtu/zwDYFHSIj1tA5cOflpzHfWhcaDN2v6h1hkfc5MaNubKar6rgHdfbHBU1a9Y41BImy3SltZGiw6i96Onn+A20JV6KKGM86CCitLrjHog1/pejqq67jKiQQBlMDrI8e/mB6piyfhuTg286o=
Received: from CH0PR03CA0077.namprd03.prod.outlook.com (2603:10b6:610:cc::22)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 22:10:11 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::2b) by CH0PR03CA0077.outlook.office365.com
 (2603:10b6:610:cc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:11 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:09 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 0/8] Add support for a DRM backlight capability
Date: Fri, 24 Apr 2026 17:09:45 -0500
Message-ID: <20260424220953.167058-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 2113a07c-a5d9-4d24-d961-08dea24e40de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Mp5qsEHbt2r/i7kGOWTy9ez0MDVhEutCDK67fsm0COabmgQP3un8l4Q0gsynkQFmRpGnZYbjwb82T65wfRFhPnJ1k/Om1a87VPJ3euBO39MuwOEnAr0HoSv6Ma2rjCIKgDeAGh5r+dSVSWbqdc/0AWpuz8msDGIa/A6HuTCjzJi4PBEKXco0JlaKdbV19chAHKc7LF/+ptJkcTjwtbj3qHnMFVTHP5Mkcpaa08xXBSoUUFy7iJ2CZc5cUGKIcufGv8ghuLLuHjpFtmVOB6S+O7F7WvtX1qsCPuGDKVeMFgVObzpMsKd68eFWEVRVE2buE0TcbfmITxlXVtRW+ZTp/18+fGxVBZF3rBy6iEyoc2wM7lJIUVmcOddWZhHnN+NXUiL02CAO1r/RRvvpERzlPnM/i5XziRXiFCTOyBSQ2PtB7ipwc/L6y/RVRYIeXyE2Bnw4D6pHgPjPJ7wDnPF8BleRSLOejU8RqyoGxGmyQVScjNJgDqVZbmZ3WeJgVpTZZxe0O39y8JgU1TOqLsRloGk2q3cpREHU6/b3zw3F2l35S3ep8NAzVoWamRzCBtxfRZcHBasmnoqQ05yckP7VNKyCEUEPANY5FpS87Wa8X3KoX7+0/2AW0baV87fkDb67AWEXXkKvyN1pfxUYJUxBlOrEM39T0m0g1YFY1+WNTq2Muzs9+0I/c8Yg2derZXu2DjppLKUhCfQ5Hi10U2C8NdZUvpqzB1bT9JLkbk0awEToGopq3xEvoURCE5y6nw7XPfR6Wyj1HFzBrz+RyKf8dsasIDbwA/ET7hm1AYRTxcc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ho2gkoPVyAV0YFEcXbl/3F2tESqhrv/FrlA3XW9xrfxv6pXMqUL3rKmcMsd1z8bTUYzQGO3bTT8oSa/65kf4vzJ6fC2A6sQMMttnjhTYlkB3YTJeA4VoBws+ZGzF9B5RInhpnWLCy6ekaIjcfkQJLRN28atFbbEqF0H0jsVMrzwliE80Xs00U8FJqH+9up9o6nySGIlDGEdE94jpexjkGhrOL5+rMipEp3wdMw6UZUqrjj3k5xtUYa9Zp3y6ukvHayAACBna8mXSTbG8UDiZ8hbLot39j8bm002bRlJ2KvNRKzR6dd8F6JeFNY7tVGYr+7y0GVsCgfFWcEssd61BoXsSP40GAIIbZID80qejQm0jjZWHZzkTuMfmAeOvZ8AKRqjG7Q0A0QzOY+835gp9g9MfuhrWvIYLPSnDHNeRMNLOpToMaVj/9ScqSmEG5yIt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:11.2363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2113a07c-a5d9-4d24-d961-08dea24e40de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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

From: Mario Limonciello (AMD) <superm1@kernel.org>

At Display Next Hackfest 2025 we discussed the renewed need for moving
brightness control into the DRM connector properties.  I've taken the
previous efforts from David and Marta, rebased and adjusted for the
current kernel.

The legacy sysfs interface is synchronized with the DRM connector (although
the scale may be different as DRM connector property is u16).

Later after this has been adopted by enough userspace, it may make sense to
configure the legacy sysfs interface to be configurable so that only
DRM master controls backlight.

I've done a first implementation with amdgpu with eDP connectors; but
conceivably this can be extended to other connectors like DP for displays
that can be controlled via DDC as well later.

I have also used DRM review prompts to review this series and fix some bugs
which were caught with two different Claude models.  The fixes are squashed
into the patches.

Assisted-by: Claude Opus
Assisted-by: Claude Sonnet

For ease of testing; this series is also available on this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v3

David Rheinsberg (1):
  backlight: add kernel-internal backlight API

Mario Limonciello (6):
  drm: link connectors to backlight devices
  DRM: Add support for client and driver indicating support for
    luminance
  drm/amd/display: Pass up errors reading actual brightness
  drm/amd: Indicate driver supports luminance
  drm/amd/display: Allow backlight registration to fail
  drm/amd/display: use drm backlight

Marta Lofstedt (1):
  backlight: expose the current brightness in the new kernel API

 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  88 +++-
 drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
 drivers/gpu/drm/drm_backlight.c               | 406 ++++++++++++++++++
 drivers/gpu/drm/drm_connector.c               |  12 +
 drivers/gpu/drm/drm_drv.c                     |   8 +
 drivers/gpu/drm/drm_ioctl.c                   |  10 +
 drivers/gpu/drm/drm_mode_config.c             |   7 +
 drivers/gpu/drm/drm_mode_object.c             |  66 ++-
 drivers/gpu/drm/drm_sysfs.c                   |  54 +++
 drivers/video/backlight/backlight.c           |  83 ++++
 include/drm/drm_backlight.h                   |  45 ++
 include/drm/drm_connector.h                   |   8 +
 include/drm/drm_drv.h                         |   7 +
 include/drm/drm_file.h                        |   8 +
 include/drm/drm_mode_config.h                 |   5 +
 include/linux/backlight.h                     |  30 ++
 include/uapi/drm/drm.h                        |  10 +
 20 files changed, 852 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

-- 
2.53.0

