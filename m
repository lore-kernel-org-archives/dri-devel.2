Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A55CF44841
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9716D10E93C;
	Fri, 10 Apr 2026 11:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oRuZQ/CL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0D810E93B;
 Fri, 10 Apr 2026 11:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvtKmoTNUBRK2hpEGyJ6PIgdWPG3yJNvhbiOfW8wkYAvgMd73mBgaDeyaWcLe2ZsUZktZ8OafHLpXyFFd6TXDd84IGbxnFJyb0+NHEamVF7Vju+vhHH27radbriMFXORVXabtjq+pJoiic+R5Dp1fBr+uOpE5v8JS9lGlTMG+P6MiJke2d43C7ZYumshs2c0lUwAKwQ6zT86y78ZnsZ6FYbtIVpIDnYdEhXxxsSOWximC0pMWeGQdEpbKXmcVvgHvPz0Yx9lk/eoJaxaUx7AU3D8GNqABUq2rDUsQNltQiFNJJQTZ0Rl9j02MtSQcM9UK7EbuQ9wefUYAXWBYJFinQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR8IGvyW/uerlWdF3Aa6wLFh43qDkI1NdYc02LACRas=;
 b=Hnt8/HlKijuCKWCHzHIgSGcGojYairA667nMFkliRavBGCgf5DhJHD3Lib4JhRj9HrUESmTO5MrJekEQ0aeg7qnmgfkjHyE5Uwovn3a308WRo/OUWtvNQ4awpVtYfhKmm/Jf3eAwmWzmtS2p50J5jxPnbmZ/X1eWGQ01n0cEmED8ak18MJRK9HJH1Ix/FhP+74dYYjTHM6KcfuJH1w84BOmzn3qXeFQUVRBnEk2l3kwA3Vw+2rIqTVC38y42NB9/8397P4kfNQdG9iRrMugQxV/RstMLVmYikKZWV1MbRX+FNS3b7qY58bzPc+aNUIgR+IYsDUUqE23/qvcV502lFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR8IGvyW/uerlWdF3Aa6wLFh43qDkI1NdYc02LACRas=;
 b=oRuZQ/CLhpQi6PBjibh6ELtFOBjLLeHz9uVlzZ+1gZ4Wf6hX0B4GCGlSp5w2111lnsZ/WPl1Q6mN9A6rNF/bwqJAkaHsIaaxBo64mYBv37H0OtzgMNcRIhsP6xuXzI9umUXCF4N3hCAaZKLNezxOfVVU47BxZD3DwbIkLb1yGZY=
Received: from PH7P220CA0068.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::24)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Fri, 10 Apr
 2026 11:31:51 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::1d) by PH7P220CA0068.outlook.office365.com
 (2603:10b6:510:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 11:31:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 11:31:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 06:31:50 -0500
Received: from junhua-PC.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 10 Apr 2026 06:31:47 -0500
From: Junhua Shen <Junhua.Shen@amd.com>
To: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>, <Jenny-Jing.Liu@amd.com>,
 <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>, <Ray.Huang@amd.com>,
 <honglei1.huang@amd.com>, <Lingshan.Zhu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <junhshen@amd.com>, Junhua Shen <Junhua.Shen@amd.com>
Subject: [PATCH RFC 0/6] drm/amdgpu: SVM VRAM migration via drm_pagemap
Date: Fri, 10 Apr 2026 19:31:40 +0800
Message-ID: <20260410113146.146212-1-Junhua.Shen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 42246c5d-4ba5-4289-1769-08de96f4c233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: hw4AsyZFDhZfW4XPeZjVJ/cMbWYvL70NYoEesiwCxf+3owwKSlXPdKbV/Yce3X4BtkjUU93GZydHIRt+r/gtotYxxJ5ux5jgYs9Um7dS1b2FLf6SRJYsq4WV6by+gYaBR8V4RxZ1y6WZTlwC4YR5+nlw3ODcJfw2JWA4JF+PQxelPWuCYnzzp8P7rW3YyMcYLApnHuPpfkR69dlNJ7f6fq5GaWr+vHmfCfm0l4vVQziqH05OC2f0SZUwRu2KnuIJih86eyMCbPOjPfa6Atzl/qpThUIH0+yt+8Pe81vtlzRphlC8fCd8V6S49HmgFcwGZwjwZr43tqYmZbOdZ55GAg/ApzQvYsVJoOOtDW1deb62Op5X98mqDjob11Pzbww5weC2xpTXj5IjMAxWs8w8ao1Vp+YaIfxmGZ7UAY/IXKYYK33Olt4xSFlyb25SjWeyXl8d4/kD9Fvf8w8yozn3GMLvuTFuAepklZ5sIQtv3cpNC9M/2TD109NjYORvUy5Q4Hn1lQaT5JV1+NNPg/JER1fjzE0Z+aOPibfoG0/iBTnTLI7hPJpfnF/tMmeTDd28QI8jM+e5U3iZeBvC++7BMvZtFwLRBDN7k+io2cQwT50c/2oAkmTlHHewEPQK4hsPjAfI20Iznxmxk3yiCtKLEhwTTCjxYjfTRizWh+9pw4gxn9LYbEi/W0Zt3cRdovE7/0pfflzue530Ww0FulPuhJ+YXzpbER+DLfxy1KyRoKc9QjxZgXO8WQIwDcqiC5DLFkkIgwaVPACt8wjrLzXZXugIbH1IuGZW86Myxa71F3nZFAe4Zrb1Gk9y+aZFZcPR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(921020)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m4vmrINsjPl9XwbY/ordFyWpneE64Nit5CiUzk4QEOqPjD7tHzgAl9H0hnl/KU3wI+PJGN6vvIRPqt2e6e7+N8/sr7v3QmMECcD2IimtwuwYicMkiTeGeH3yvEwjn8TrcrnV/xyOwy1ZQluW3hfa/roZDUnTvQZsCyvhar1YKK95JtEFp/a6dD911qXWrWgL4TFvhDB1wOk9P/ldKXqk1uIeYncoNjU15iQd/IOPSYivmj8V8zBN7sknEPxdXDH7prNyDcNcgMKPedglw97nnm4bfR/buJvMdtbMKMBfHvzr9h3/mQGDGrQYV8rjnHWhFPPiygmZQanHpyLPQiIAvUdvjJTm/F0o6LLuGif8oZ2YosqF27OlGocalkGOp2taloKMmQDED0uGm9G7w9YTRyPlptrlektUaIkocApkwCpmqc8vNR6oswSNzWZOaTtL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 11:31:50.6576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42246c5d-4ba5-4289-1769-08de96f4c233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308
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

This series adds VRAM migration support to the amdgpu DRM SVM
subsystem, building on top of the POC SVM core series [1]. It uses
the drm_pagemap infrastructure for ZONE_DEVICE based page migration
between system RAM and GPU VRAM.

This is NOT a production-ready submission — it is a POC/RFC to
validate the drm_pagemap migration path and start discussion on
the design.

Limitations:

  - Single GPU only; multi-GPU migration is not addressed
  - No XNACK-on GPU fault-driven migration (XNACK-off ioctl
    path only)
  - No VRAM-to-VRAM (peer GPU) migration
  - Eviction fence path is functional but not stress-tested
    under heavy memory pressure

Design:

GPU VRAM is registered as a ZONE_DEVICE region via
devm_memremap_pages(). A new struct amdgpu_pagemap wraps
dev_pagemap with drm_pagemap state. The drm_pagemap_ops and
drm_pagemap_devmem_ops callbacks implement SDMA-based data transfer
through a GART aperture window.

VRAM overcommit is handled via eviction fences: when TTM needs to
reclaim VRAM, the fence's enable_signaling callback schedules a
work item that triggers migrate_to_ram for all device-private pages,
copying data back to system RAM via SDMA before signaling the fence.

Migration policy is driven by SVM range attributes (preferred
location, prefetch hints) and integrated into the existing SVM
range map path.

Patch overview:

  1/6  Introduce amdgpu_pagemap wrapper and KFD pgmap accessor
  2/6  Register ZONE_DEVICE for VRAM and init drm_pagemap
  3/6  Implement drm_pagemap SDMA migration callbacks
       (copy_to_devmem, copy_to_ram, populate_devmem_pfn, etc.)
  4/6  Add eviction fences for VRAM overcommit handling
  5/6  Add SVM attribute extensions for prefetch and migration triggers
  6/6  Wire up VRAM migration into the SVM range map path

Testing:
  - Hardware: gfx1100 (W7900) and gfx943 (MI300X)
  - KFD test: 95%+ passed, same failures as official release
  - ROCR test: all passed

Dependencies:

This series applies on top of the amdgpu DRM SVM core series [1]
which provides range management, GPU mapping, and attribute
infrastructure.

[1] https://lore.kernel.org/amd-gfx/20260317112958.2925370-1-honglei1.huang@amd.com/

Junhua Shen (6):
  drm/amdgpu: introduce amdgpu_pagemap and kfd pgmap accessor
  drm/amdgpu: register ZONE_DEVICE for drm_pagemap SVM migration
  drm/amdgpu: implement drm_pagemap SDMA migration callbacks
  drm/amdgpu: add SVM eviction fences for VRAM overcommit
  drm/amdgpu: add SVM attr prefetch/force-trigger and in_populate tracking
  drm/amdgpu: integrate VRAM migration into SVM range map path

 drivers/gpu/drm/amd/amdgpu/Makefile           |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   52 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |    9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c   | 1063 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h   |   67 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_attr.c  |   46 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_svm_range.c |  486 +++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |    6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |    2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |    2 +-
 13 files changed, 1694 insertions(+), 51 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_migrate.h

-- 
2.34.1

