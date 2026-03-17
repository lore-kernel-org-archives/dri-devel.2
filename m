Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E56FED9E7
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:04:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6CF610E6E0;
	Tue, 17 Mar 2026 16:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wdwDFRfc";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E690D10E5A4;
 Tue, 17 Mar 2026 16:04:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X80R2E3Z1gUEvO6q6bwx6K2zHpYwbXi8s4szknoWsUAIyl2rzOlYheOL6V1Yc9FrDxSRHm2D4SRtmykAeRo+vJSmnLQYxovDJ2WXxokrVmqOHe/DWEep2BpNB+tBhdJ4PT4zv9K5qD1zwyhXhGFN8cIT8sArfr+IMwCJOE7xXXpy8U8UHdXljL1UaZ5wMYrET6P1/UTL7MZ3EITg8NdwHCZtRRPSK0iKO9Ua/uOXmn7qJ3ViqXinditmZmjn8MocGeVBepGRlXwMJQbr8iWiao9qdLrhVb3xY6YP9JDOSv7mBls6hdPohhdLG2EOUEbMpeRxh8VmEHKYqjNobjrAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMECym3gGAkXJ+1FIgfoO5F9vELn2NnWeD8GEPccxkg=;
 b=WQdmdud2JyuZoYcSyEYsYcJ8UxoCV3oQsFa/OWmwOZliXdwHzPTQHrDh+MMNZEBdaEGoAA2y7J4EM0CdCCT+B2DK4/0IPPDbrj/Q926i1uZCWoyi31A6UODQBeaehNcYHLsRcsjm1D1WW5zB1DQnpYLCFW32Gs14TREPEoQqK0a05lPdB/9N953N30OWqXkTjVBKVHB+fCM0MdUG/yLGkvih339BBxmOPjg/avqnw5wR1/SkfatApC8zDa5J1nnuOZCKPAXTCfLD/TBg/i6jSb9GmzgoFIVn6KQvtUEijEl4NYirkRRkngPXympT1jCHErbXIKbmcYJFiorPN41/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMECym3gGAkXJ+1FIgfoO5F9vELn2NnWeD8GEPccxkg=;
 b=wdwDFRfcwJ01tln8h8bPV8X6r1vYs6dCA1gbc4CrDpxV9sbtvNwn21GNDGavy1IhIb+WhtnGVMdo+DPGbPBEcH4N7wLFMXS+qt9G97MRY9oaAkI4n0fByS4ZyJQM/8Bp9X3Wcae7pc91fqi/bXowAzjVwVJqkTZs/qYGUBtyEt0=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:04:03 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::1) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.21 via Frontend Transport; Tue,
 17 Mar 2026 16:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 16:04:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 17 Mar
 2026 11:04:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Mar
 2026 11:04:00 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 11:03:59 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>, Simon Ser
 <contact@emersion.fr>
Subject: [RFC PATCH 00/10] CSC Colorop with COLOR_RANGE and COLOR_ENCODING
Date: Tue, 17 Mar 2026 12:03:40 -0400
Message-ID: <20260317160350.229028-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fdebebd-34f5-46be-c560-08de843ece47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: T6S1O6dy5yKfBFL0T5y0MHsrhFcvEaSDlLCh86yRVqGLXt3ZnUjZdkNg6pJXtHnVNtvYvHWp7U0AROOGTkjfMM1Ih8J8rTI5gvhckXQogqD4KMijEo7d/nZ8zpkcwOPiBuHXzkkd6T3jKP9tAUnahsPnslHvZEjpGraj779cfd5jnIRuRolaV/rLWwTe/CrHL/isvL2TvU3eBX/IIDkR+w48MgArwBiNodebmmLHg+zsopQI66UBLDjgR5cRM5qEYMwVlicRLFX8tBP6WxUZo8JM5GRnfslfPomc4Z5beLPlzAo4M8zrKUL9S4SWUA/S6T7DdX53qOrscPfbGGCj+IJHjiRm+cJDkAzrIvuoAH2prkLkuebzjtBuKgv+WrpiE2QOtnE9U7mDuRXFfHqQqbjttucBY52vAfeK7rLImaeUhePCSdUoSs2HFgSY/xX+Ej2cr0jZko+udygKx6Tde4XorfPILYHbQ3+OVAleRQl7rPomGd4CmK2JsSuUjRrOnDxB6PaRDOPi0LLcR4in3KA23Vq0Ef35V08ysUcOAdY0JR0TBY0wIWL5wrwHATqHTWwB1eEBhXYztXgoEcmsQ+u3bbXacWpZvi2MhHeu6QIrM5VF/qHi9w2kHosB3yTvE4q963iyAMu9EVzoVzErMN5vTG506oq35tqHWXwrgM0pgTEzJ18PPyXhJ4vCV4+2eNBri9pHaAdqXPQGHQRc7HqTri/soImW4OOO+uXbJA8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MWUGjDhN1jcZbnvC18vlO0artuJgEfDwDnc1j4CLX3uZhgR3vk0DqkmM5G8foyL2OCj/3p6hadAOTBu8DTQrxFHZ94C/1bBV+DNJICGJ0uHf64PKH6UWHKv9M1ysPgoV3hgK5uoSFt2TNcM8fgqeGXaUnwixudEGSmyLsZesQzLOlVo0o7udDPY7RvORiyy5jlUgufhuItqRGBRNTJAkKhfmpZifs/3fv0LCSa7q63qKwU9ru0IXwSaZwKGYtLAJDM/5dUfYMKlu6xkC7qkjN43ydbZn2TuxNivs5ZJeS4yYOnrYILJF+85Kgqy9E9ALU/qlJIOAu5w030/MdVVXPDvTRQ0PlGuYBPHI0kBsjBCl1ea7BMNZnxMGs+IGmwdGwIoACj2c5dhB6RdX7VGSeTeR4qDeGsR2qr2+1SB+8Cd7SbUy+Lmn/s7kLv1yv5sG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:04:01.5496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdebebd-34f5-46be-c560-08de843ece47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757
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

When we merged the drm_plane color pipeline API the major gap
that existed was the lack of a color-space conversion colorop.
We deprecated any legacy drm_plane color properties, which
means that the COLOR_RANGE and COLOR_ENCODING properties can't
be used with the COLOR_PIPELINE property on a drm_plane. In
practice this means that we can't use a COLOR_PIPELINE on
YCbCr encoded framebuffers.

This patchset adds a CSC colorop with the COLOR_RANGE and
COLOR_ENCODING properties and implements support in VKMS and
amdgpu.

An alternate way of possibly representing this has been proposed
here:
https://patchwork.freedesktop.org/patch/709860

This code has been tested with IGT and an experimental KWin branch.

IGT branch:
https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-colorop

KWin branch:
https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut

The kernel branch containing these changes, based on drm-misc-next
can be found at:
https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop

In order to successfully use this branch you might need a few
bugfixes. The kernel tree containing those fixes plus these patches
can be found at:
https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop-all

Further background on this work can be found at:
https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html

Cc: Alex Hung <alex.hung@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>

Harry Wentland (10):
  drm/colorop: Add CSC colorop type
  drm/colorop: Add CSC colorop initialization helper
  drm/atomic: Add CSC colorop state handling
  drm/vkms: Add CSC colorop support
  drm/vkms: Add atomic check and matrix handling for CSC colorop
  drm/amd/display: Implement CSC colorop support
  drm/amd/display: Use GAMCOR for first TF if CSC is used
  drm/amd/display: Check CSC colorop bypass before programming
  drm/amd/display: Check actual state during commit_tail
  drm/amd/display: Set color_space to plane_infos

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 115 +++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  25 +++-
 drivers/gpu/drm/drm_atomic.c                  |   6 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   8 ++
 drivers/gpu/drm/drm_colorop.c                 |  91 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_colorop.c           |  64 +++++++---
 drivers/gpu/drm/vkms/vkms_composer.c          |   5 +
 drivers/gpu/drm/vkms/vkms_plane.c             |  50 +++++++-
 include/drm/drm_colorop.h                     |  39 ++++++
 include/uapi/drm/drm_mode.h                   |   1 +
 11 files changed, 388 insertions(+), 30 deletions(-)

--
2.53.0

