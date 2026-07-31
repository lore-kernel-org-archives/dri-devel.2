Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BA7C55175
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52DC810F38C;
	Fri, 31 Jul 2026 18:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s4x2BDks";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B8510F36A;
 Fri, 31 Jul 2026 18:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah30fQ+ZD19fzRJA41u5goDycreWcsv7EvehvxaD6hmaQs2U2KfoyUyVaibfGt9AsU2uhyjFAA0L++HxFBtxd6KcRTdok/JE5jmlkmCbTM5uJ0UcLmMqgqbtJeKKRYvCk2PDbgmAydT28PXPRIOyyqTqWpK/VQYB/G8ek1CYJX/tlrgiEFIyKxSSkQZPqwhMpIR5ooLu7fat3CYI8q4HE5pEU4zksGE/3cO7bJMdoj21wj0oqiYc/MaFsB/F1hgv3BC546tHcUOkdzLfYhHA8ObfkEDZhDIVCwZGvM6j47+7TBae78ruJY3Yfuy5Ado8Qz4quUsHhT//o6VVIr6bjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST89sTCcEX4Wo+hRSxnQs7YGiiN3cYbf+MVWGvpsQxQ=;
 b=BVg3wnhETyPyZJXqU8Nf0ZJ6F2kVXTbqbDX8H//zYHDVt4NQFnX7hwc5cecUEChl5/GQDyz8DZs74f0F15mj+q1CHu1C1n61G/GfCgHISlP1ZHV5Sl928zA5gNYjy2MoEYbby1kPgQnNwaP5Zfi2GHdZAz6FVJXGa5HBg54PMDsDD/EgOFLhuGl5n/U0K8I3YkX1YQOtUhrwwd7AppxyM1iR3+nZG87Ipq9xAPxqpaNpFe6iLAoCotVhS/nLsCK0yCRkTVfr8vs2QLQTrW/CVGM8lRMug0jdkU3oMKklQTgwXHalBDRnc2XFxWLOlcQqZdqVPLEYIe9dN1IE9rSKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST89sTCcEX4Wo+hRSxnQs7YGiiN3cYbf+MVWGvpsQxQ=;
 b=s4x2BDkso2U6Bl9TnSTosPcfXubxnU2lbUd2aORwORq0Bp/wk2OdpKy/ZYm7t+sAuNqlp8oMXB/2RWjwBurBw2r7s3lnVreiZ9DelBbqVHoTcAle9+PCn9zos2QkKTG5JoppaY2su7PJkIYQ56QMlvKiuZUHdHxrHPE+8iSf/hU=
Received: from BLAPR03CA0057.namprd03.prod.outlook.com (2603:10b6:208:32d::32)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:15:25 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::79) by BLAPR03CA0057.outlook.office365.com
 (2603:10b6:208:32d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 18:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 18:15:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 13:15:24 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 13:15:23 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>,
 "Louis Chauvet" <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>, Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v5 00/10] YUV conversion colorop with amdgpu and VKMS
Date: Fri, 31 Jul 2026 14:15:11 -0400
Message-ID: <20260731181521.681990-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 433f72ce-62f1-420e-950d-08deef2fb18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|13003099007|3023799007|11063799006|6133799003|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5R/X2QDioAYKtW5nYqoBL/0x8tYXcucuA3HBxVGaXCaCvmJWgrI7zGIZ7S5IvI3eSTyOt12iM5Zwrk8GX2Q0xxVCwTYldY0yQUIbrJojDPlCnlIPmzqPX59QG46sXgCNo9ER8abi6f8mzryYyX2xYRqmtM/fq1pDLVTsWtiUdQ9xsflkCBUKwgp/Jjc/zHoqz+zQxqKt8tcFN6ej8/vKPtNWk3t2dtoo6+IrYc8xcwryxJ4edtQRNaK799sOZorjDyzqB083dWQE6ie2gdx/qw5eai9kAvWNxInH5uffovlZ1HJytPJU1upm7uPHfHNWxXHtYaXyVttGJXtvl8hPO3nfmQwRX3/3H/OUJ8vOE+0VtkxMdwkAh4OCC5l/4JpZuHcrxHCHqqXBDMh4JO3BgXZsZ2wBtzQUKDZ10B1X3AJsXZJ2s/cRH8a5U+7F+CGFxajjCy/CVkFDwEKmBjn9bMHPDSS11MuJWvgNWBLnV3eNECc+Z9FaNkiRyflB7VAhPRvVYhJlOmbd2Rh56bYES2RgmpdqdKnsPq++1O8/5sMuhhMJsvlS8F2JpiO+balPOWxNEi9Rj8LaTJgxJ8J0PeEuTT8hMyqV/XPGm8zOR85TRqU51P3wQA69Qo1g5ZXhnMlA4jchatdyhGgJQUHgfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(13003099007)(3023799007)(11063799006)(6133799003)(10067099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G6webRhrJy3UqlO+FEBfWzaJxjXFUUlTP19C3xUgkuf2f0Fu8nGezd0LcYMnpgrhhLIKGoXxx3Bd6xsW61Ii3LOv+HYttd0azLMTHE1saWsufUcTRi80VgPii1pU5vOiJWoFn+6fvWar1PbE9DJw7mWL9fiJZr5rhJsgae+Z2pNpkDM3T2JZomoeRWof9I1lDRtKNkfdC1DpsQPD2JfF9/NyOaKaYXp3diQ3W++IZJy5LMelGlweEPNOciyJ+eANy1ZWatw6Rqh307l7z2f882ra6zl5392+RA0n8VFPJWlUV31s6VitX3UIZrhUmBReKjtC+3Z3xwSD2S8+9tglIBoN/a3DQwo35zmaNBIOjt+DtpVp/moG7C5sHtbizjo68f6oKn1qUKP0K28bQSkLYJs1SMk15/O7mRoXARLugEqeJpXSsveCFIl4eTqL+dx0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:15:25.3965 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433f72ce-62f1-420e-950d-08deef2fb18b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
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
 17 files changed, 639 insertions(+), 68 deletions(-)
 create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py

--
2.55.0

