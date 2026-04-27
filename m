Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD1CFF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D26910E683;
	Mon, 27 Apr 2026 10:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XXLGeZHh";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B4E10E683;
 Mon, 27 Apr 2026 10:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhXnuHD7Ysa2+px0vpdgbjeqc0+y5WHc4apjN7tlhxxhiPeGfa5eltTSv2T+S+FYSHIicwLsLFhdZenevHM6QKktmV9xLIwux9O6E0UpzEGxnPO3H8AUpTquooArWeCM1EXpGx2LkZSc4XkvUSyJG2wVeN94vbjjRPjn3x8b8LAT6h3Fd/Y4iKpubbcwwtK3WzAhDyslCuFXrJOJpIdaN3oiVIWUl92x+YwMAqs52qUQ8SGgp7Rm5rj6N0tEgm7E7He61YI0VXmyhQxhpsDzYLdm2KSXukaGFxPGIGSue6qgug7KHwKwzV/KX32urwGjTtOMs35jw4qDzRCPAPAyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/5rNWxgs3bM1roRQEfIrRVwNQfgp8rDDF0lw54xkqU=;
 b=I+d6RDD7FPS0uPdasOhWCr+OnJqkOOxC2z9oaOvD7aA2CxnVvFRWJS8Z3caP5QoKQGiAfhbNmbgr0aWagy83HpoR7niEVSW83N35+O9ayJHKzhO0uIb2e8QnMucsuOKFWaDzTpBR+uh6gzN9OUkfNKjsTcOWYakb3nzT9dYY3SEOJRNp4OtcWCYkktKqT25tg1jsBJ0tco/dJN2eJVBRrBh1mtW2LXDfz2YGm7iu/JPLkgNTn/Pge8vDkMv1/DtgnHSJOSdm5WF7IxsYSDUGryxW5PRaRaxs90OSP+DwC5xjTkkwliPDkA/Z8t+4/CEHJUBE3L8U7emKgjOnoPXCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/5rNWxgs3bM1roRQEfIrRVwNQfgp8rDDF0lw54xkqU=;
 b=XXLGeZHhQuIuEcPf0tt5HXIyy2FKEvZ2yrH3x0OTFk2N+7tCekBHyGE5Y4Kr4UAT/MhqJewapYWuoKTrqLv7R3GvBtSAO5RJ7IRJS0gkCgBPzr7V7vm1MG24gL1lfo+bLcDBVrQKiO9/kuz+fzSlY6HhOaiqP1NrCfc1BRnMe80=
Received: from PH7P220CA0094.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::30)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Mon, 27 Apr
 2026 10:05:32 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::58) by PH7P220CA0094.outlook.office365.com
 (2603:10b6:510:32d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 10:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 10:05:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 05:05:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 05:05:30 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Apr 2026 05:05:28 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, Junhua
 Shen <Junhua.Shen@amd.com>
Subject: [PATCH v3 0/5] drm/amdgpu: SVM VRAM migration via drm_pagemap
Date: Mon, 27 Apr 2026 18:05:17 +0800
Message-ID: <20260427100522.7014-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 6978fdde-bd59-40b6-b1d2-08dea444843e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BbVztE5mtOd1a0HWlHbL6FPscaHs1bTkB9St/IH2fRs3Z00LZ+KW0epj3WumM/UA0mS9K8a4L40TSsQUMQA5hEwfL7P0w+SSHideFRyRVHzLXNBHbZCOhPgMGudN5TsKVAo+rrDlMghecteS03kd5u+BjLnuZohsxBO1/xGBbZ1AMlVr0ZomGbvAPO4qkya0SA/sNx95tFMhK4sn8Qj84RTnOwYw4hR/iVeLO4X1O4C2FygoxPqQn/aPqZMZAZw7OyUH2SMeeESES80uL3n2gG3nsTdqltuZFoSFZEhaW2M52l3EkZsrwQ2s46fnr7YLUL1/i+Nf0rTVGfjiIIYmA1vf2z7GvduEnGnFe1JYMKmm8stXZtWyyqE23dwTLEhS5ZFUnx/+e8Yv7nyCaQNF1RXY8705LJ2S2O1cXzR1p+0Y7KRl3cmqqFBLLSyI1PI2cUQFGKdGNZ9/fEvpJ2ihXg2pPOfZ2xVnWtxKX99ClvlJFm5OjF7iiVBqeUksSRbFJt/a31SGAJXXV+BzfoojZGlCITwpKUcMkKPB9PzXbExSE/5VuAbvjbtL1KEBNxmAEkNtyK1UjjjGkW1FGZ35zOvzM6S91xTks9FXOYCnDCmLrgfY5pYUSIMRcmsd5WwzurjlqyY2rAJiH/3TXB97H273XuyqtibtOpg5PYPBmPdMWVoExnmrJx9fNpOSZbLfmDnOE4Oqj9wNTozuAQCYtOCBc3wxYKt2zMLYxPfXyF2Yq4e24L7u2FSVD79uW+3dFZPQ0XH7Dp+w/LY/CqrnhJwTdTC1/PjuPJv/eZHD1HM2nLmNH0DisjvPTpnvVz5ZMVq1PCIs27mft/egD17abw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(921020)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PoiCv60fdvySigvh4HJHLIYLc9fhHYyY2AcbCNCn5Hl+vL+wVisBMFqte186HUuELPbJyZC3sz3udsDppvPPDoA5aNrtSuqB1ukVfLGptTO1w9EM73TCxJUdOuoeIZ3uBtJrO6orApEqA6j+ogwFkosQK1OR5pGIDJ0338hu5H9y1lTPXkzKKKcdrKeRT5NxoaP3nHu/n/EEF5Cxqw09Xpm3MvPWf7YfL8Zl3m56zbp2sT5PxiTn76I+XCdUcZ9HNl4HrBtN0/VrOx7QwqepwPYL7UokVeKqhOGDh1XmO8M7YR/zToasxPdo6uO8T5ITcLTnxbFufGOR7klZGCE+cD1/ViLjzyGD12h7JrRJwJxvD6qQTkBNCeZPeaL6IX+FsVXhd2yKvSJ9TpP2pohxzVWdW5Gw/4GgHzAf7qB5VU3JHU4v4GMupV+7FUazRJoU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 10:05:31.5813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6978fdde-bd59-40b6-b1d2-08dea444843e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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

This series adds VRAM migration support to the amdgpu SVM (Shared
Virtual Memory) subsystem, built on top of the drm_pagemap
infrastructure [1].

It enables transparent page migration between system RAM and device
VRAM using SDMA, driven by userspace SVM attribute hints (prefetch
location, access attributes) through the existing AMDGPU SVM ioctl
interface.

Limitations:

  - Single GPU only; multi-GPU migration is not addressed
  - No XNACK-on GPU fault-driven migration (XNACK-off ioctl
    path only)
  - No VRAM-to-VRAM (peer GPU) migration
  - No eviction fence / VRAM overcommit handling yet

Design highlights:
  - ZONE_DEVICE pages managed via devm_memremap_pages / drm_pagemap
  - SDMA-based migration with proper DMA fence synchronization
  - Migration decision layer that evaluates SVM attributes to
    determine when and where to migrate
  - Zero modifications to the KFD subsystem

Patch breakdown:
  1. Core VRAM migration infrastructure (ZONE_DEVICE, drm_pagemap_ops)
  2. SDMA migration callbacks (copy_to_ram / copy_to_dev)
  3. Migration decision layer (policy evaluation)
  4. SVM attribute extensions (prefetch force-trigger)
  5. Integration into SVM range map path + ZONE_DEVICE registration

Built on top of the drm_pagemap SVM series [1].

Changes since v2:
  - Moved amdgpu_pagemap entirely to amdgpu side, eliminating all KFD
    modifications
  - Split commits for better reviewability: separated infrastructure
    from SDMA callbacks, decision layer from integration
  - Merged ZONE_DEVICE registration hook into the integration patch

Changes since v1:
  - Dropped the eviction fence patch per Christian König's review
    (violates dma_fence contract)

[1] https://lore.kernel.org/all/20260317-drm-svm-v2-0-4bceef04e41e@amd.com/
v1: https://lore.kernel.org/all/20260410113146.146212-1-Junhua.Shen@amd.com/
v2: https://lore.kernel.org/all/20260413103031.181953-1-Junhua.Shen@amd.com/

Junhua Shen (5):
  drm/amdgpu: add VRAM migration infrastructure for drm_pagemap
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: introduce SVM range migration decision layer
  drm/amdgpu: add SVM attr prefetch/force-trigger functionality
  drm/amdgpu: integrate VRAM migration into SVM range map path

 drivers/gpu/drm/amd/amdgpu/Makefile           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 789 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   |  98 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |  34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c | 136 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.h |   5 +-
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.c | 140 ++++
 .../drm/amd/amdgpu/amdgpu_svm_range_migrate.h |  60 ++
 12 files changed, 1212 insertions(+), 76 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range_migrate.h

-- 
2.34.1

