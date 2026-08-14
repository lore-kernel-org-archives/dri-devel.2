Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F195C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 21:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CB410E034;
	Fri, 14 Aug 2026 21:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iX/jZoQ9";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013033.outbound.protection.outlook.com
 [40.93.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0297C10E034;
 Fri, 14 Aug 2026 21:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHqXUo9z33t0+pCq+ncp7UMy7euROwuMgScMdTC5B51q71XvTjFoYOhgOkUznCk4CshGE9+rbU/aI2yF16ELyAeiAu+YE8pfOoljG/bttn8WJ2AXII/APg2bFm5jUog5cyJBZVinYOAi3i5GwWkIqjHWU+YI/RvOBL5ZlcSrO4kNpltWPEZzzQtoGbB6pxqioZCuJoL7+MlNRjNy0fm4ilAmdZi65KW1hzA46dOJ+X9WFE9C3qSaBAr0pNJHz6XnwedEaUlCFX8vRdJdc7W0StVr6r49E/dD3BHZMzjfl/BWZ49HFmRjjZ4BxftI4Nb+wRUIxsrIQFUxmm6jB9tNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmafTIQbHGwHDU+H22kr0j74lSBtUWGB9QFRCYjZYHU=;
 b=rKe76tlYS/r0u2+1c9W+jz9/LtaBEUD1UFELJ+c1756ZLL5Y6nKDCid6rtFVNP+jxo/to4z2jZRBi12s0OdRjtJ6+FHfGUrgtr46nBXe6/iCDNjntb9v+tSdcB2FfvbGzYlXPt4bR17MRu39sp5FEyayA/Vj7516P8HtVq8cd3xVznS0TEzWmmAW+/umCAT3BETGbdCVlUZJCYUlCfpG26yXCsmVwP5uXO9G7NfssRB7INPC7+1ofX5IReLmal/vpUl2wrFLLitJEP7supaE0DiWTfyQmeWLkezmD+SYhbjZ+GdNh8OpgHjTtAAJFZhpfARBdzWz4VMxjLea/0VVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmafTIQbHGwHDU+H22kr0j74lSBtUWGB9QFRCYjZYHU=;
 b=iX/jZoQ9JTZ6nZGjFFY3gFbI4E6NsC8pwEQaGFSiI5XqY/LqtWoU6RhCtPGwLsKAJrbSgIKZc82UABBKha64Lvt5nbLsBzTeKHUqiPU5TnH71s6AFHW53+k5fDcJh8zRQfhAq+7k630iYOHKKJrBaoibTAE/7xKHR/PCErlUKHg=
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 21:18:19 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::4c) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:18:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:18:18 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:18:17 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>, Simon Ser
 <contact@emersion.fr>, Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v6 00/10] YUV conversion colorop with amdgpu and VKMS
Date: Fri, 14 Aug 2026 17:18:06 -0400
Message-ID: <20260814211816.1219597-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7843cfc5-11d4-4e97-9bcd-08defa499029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|13003099007|10067099003|18002099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: MDiKRjbxsX83ETgKGsJa7bRwwtZNRYvyyqhw4m4cm3ZgT1tHY7/d09y9uwNBQ1hqh41tlPE00R+IXvkjre5az0ro2RUxZUCYqsH4cjJbMr5gRxjgUlO9zHxu9pgiG2ZS1Jz61WNULwyTEvL+VAXZvy9yzse6qb9jGoZY+gTHo3pXRXiVdRTom6XKlsJb48pmbpa2vH4KnMiOJeU8voXGjlHiBjc4UXjyowSQizKLkO1xA9VShRfIH/tW496HBAcQsb1or374WZimQj5Tr5fAKKVWSrfMmHG1LsP/IG8jIbZyb2VbzCge3IfyzW0/br40Mk5T0a11zP0ubDu8WGq3d7jOkxrtqO4KRmGn9OJvKfD0TjLlflNsk5CGRVYk+qtmzZhFuODBN8dk+Ocre/F7b/gjkSm1ONb7pKB70IiuideXY35Cs9ud+Fsnddb1DKJEdtaZrIUkJhL5+FOm0rPxo8uXnRvejllhmFtTk7LAuEWYMjneeYx+M2M1M+zYbtIerDor0lM3Bs2XiajlTaXgzSIaP1W2QJ7VdEUROBNZ6HcGpYAgh5dK9tEgRvactI6iBwjZWrFUDVMQ2QzGh+3WlxJ5+6w21Ct++BJaHdufXzKvXJw13XSOlChEjnEz5Pq1ZAYNcFeB4kA/3yxaIzy/ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(10067099003)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MO+BB7q+sYENbF6ZFhDj2p4s3GfewicwcyOwj3EUYUeM/bDMh9v5CixtmA7+4ISkQ/b0BIp5Wk/6aBGukMXSmt+TvWFQ1ZO97ZhTUp+Skk5nWZlBOCogMdr8lItEt/6USpVG8J/k2PqKZzBNNkGLHrPWiaSkreEvwrtWWd+hLmDnTU0jgxN4aEAIe+W9rcFuKUYczWMoJvZSRfFSgd293TtafWxniGAvof1tC/+O7tsp2r+tKIR6exUgDUkH6go5b5TG1esxyEKgkQqq9LtijF04HLhNcelERS3G2vdK0lJur0YVLaBQa4c/A7aMrsY4grbWTuX7or+TXDlU6tWX1u+yIVzz4J6B4ucwTlBcd/2qXbBZ3gaoEV4nFGcmw7vCFMRTcVA/F3R6sQdL/KDDYTa1cvsflEyPStVdJm8Gu9moT7+YRafgW8gtiZhf2gOd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:18:19.0826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7843cfc5-11d4-4e97-9bcd-08defa499029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756
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
that existed was the lack of a YUV to RGB conversion colorop.
We deprecated any legacy drm_plane color properties, which
means that the COLOR_RANGE and COLOR_ENCODING properties can't
be used with the COLOR_PIPELINE property on a drm_plane. In
practice this means that we can't use a COLOR_PIPELINE on
YCbCr encoded framebuffers.

This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
and adds limited range variants of the YCbCr to RGB conversions.

His full patchset can be found at
https://patchwork.freedesktop.org/patch/709860

This code has been tested with IGT and an experimental KWin branch.

All patches are now reviewed and tested. We have a Weston and
KWin implementation. IGT patches are missing one review. I
deem these patches ready to merge once the last IGT patch review
comes in.

IGT branch:
https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop

KWin branch used for testing:
https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop

The kernel branch containing these changes, based on drm-misc-next
can be found at:
https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop

Further background on this work can be found at:
https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html

v6:
 - Fix fill_plane_color_attributes build failure in Patch 8 when
   building with KUNIT (Robert)

v5:
 - Drop new VKMS kunit tests for conversion matrices
 - Added script to show how VKMS kunit test values are computed (Pekka)
 - Removed fixed-matrix enums for "YCbCr limtied to full" and
   "RGB709 to RGB2020" as they're currently unused by userspace (Robert)

v4:
 - Specify matrix entries in docs (Pekka)
 - Squash limited-range enums into "Add FM" patch (Robert)
 - Don't reject RGB planes with fixed matrix in VKMS as
   we don't want or need to make a colorop dependent on
   the framebuffer's pixel format. (Robert)
 - Fix conversion matrices in VKMS and implement kunit
   tests (discovered while documenting the matrices)

v3:
- base on Chaitanya's updated patch and rename code accordingly
  to Fixed_Matrix instead of CSC Fixed-Function

v2:
- use Chaitanya's CSC_FF block for named matrices

Cc: Alex Hung <alex.hung@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>
Cc: Robert Mader <robert.mader@collabora.com>

Chaitanya Kumar Borah (1):
  drm/colorop: Add DRM_COLOROP_FIXED_MATRIX

Harry Wentland (9):
  drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
  drm/vkms: Add fixed matrix colorop to color pipeline
  drm/vkms: Add atomic check and matrix handling for fixed matrix
    colorop
  drm/amd/display: Add fixed matrix colorop to color pipeline
  drm/amd/display: Implement fixed matrix colorop color space mapping
  drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
  drm/amd/display: Check actual state during commit_tail
  drm/amd/display: Set color_space to plane_infos
  drm/amd/display: Force GAMCOR for subsampled surfaces with
    PQ/Gamma22/HLG

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  16 +--
 .../amd/display/modules/color/color_gamma.c   |   3 +-
 drivers/gpu/drm/drm_atomic.c                  |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
 drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
 .../gpu/drm/vkms/tests/gen_yuv_conversion.py  |  87 ++++++++++++
 drivers/gpu/drm/vkms/tests/vkms_format_test.c |  40 +++---
 drivers/gpu/drm/vkms/vkms_colorop.c           |  66 ++++++---
 drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
 drivers/gpu/drm/vkms/vkms_formats.c           |  64 ++++++---
 drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
 drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++++-
 include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
 include/uapi/drm/drm_mode.h                   |  12 ++
 19 files changed, 651 insertions(+), 79 deletions(-)
 create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py

--
2.55.0

