Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41083CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B8F10EC01;
	Tue, 23 Jun 2026 16:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n1i9c4YJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07B3310EBFF;
 Tue, 23 Jun 2026 16:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNq/TG82pNnlz0c2LXO9QR+6B5K8tVUZAyIJh/i86M2zEFDjYnhN6QhiRZeVb5YuC8QnelUH6htXeJbfKC1pjSeNXNgDMPKjFxcYknGHAzGKev6wTw3uAoH1UbdEDRYtavRNTHBOTvAqe3ckcSVlNQXajtmjmBf0Lw64qv9boIIWtpbzJd4EDqH0lJVULJA6LXH/ucovomr/mZPDQEoF0i3pfrbskdio5nfOXmpkLK2uevnhGkHwncBj7tHMtf9zE/KEM3nh/iDeNOPWAUiMDrH9U6e9HydbAe/o4ICROyp8Twbh0YOi8ekjr6Z14MhCVYkOMDlq/XXB1nFt08tN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/YJYBusxbXAUYTPfEXJNGdB8uzTHWIgCDYkAIMr8Nc=;
 b=vFNRLGJm/8Lpbj6mjYCPgVQ9BTC0ecZq1Pg2QQBA+tf2f5R/upsXs4KucYRi4XJpt45vtvoAtamfwxFi1vZY1YMk4El+w9Wsmv0BRbbBDk3Ho1M/0dD59VqFaMfyf/E8rSGeve1TUY9DkIXxxZ/apEhBKRXy/uvFFD0U/TOxob8OGflwk3OxZiTY2r95CBP8+Asl2YFTsS3XCDK98vxOGHk9llvH7k/LjHf2rLFL8NijoXWf9DxgRbkIx1+AAPOH8wxCgLgCfdn1mMC6kcVRi5s2+PTXtgv/LIuKXhaEKo2z8Jx4KL1TwyHTnKxZpenn8+RqshORHa3i9k0sxwY9HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/YJYBusxbXAUYTPfEXJNGdB8uzTHWIgCDYkAIMr8Nc=;
 b=n1i9c4YJJSUdovcF57Qfi4y6b1tDtH03gwEmbz2V3J5Wi9NKShMvHoT9Z3rbW6Fa4e7Xnxoi65G085aC8QBdBc6dxZ7cGOgoe4R/dKrfQUbk4mxKKdwL00wDJQpcP4V9xXdm+SecOizaQ/0OARgslgiS6NQktc3Pe1lXclTWq9M=
Received: from DS7PR05CA0032.namprd05.prod.outlook.com (2603:10b6:8:2f::31) by
 SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 16:48:18 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:2f:cafe::8f) by DS7PR05CA0032.outlook.office365.com
 (2603:10b6:8:2f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 16:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:16 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:15 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>, Simon Ser
 <contact@emersion.fr>, Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v3 00/11] YUV conversion colorop with amdgpu and VKMS
Date: Tue, 23 Jun 2026 12:48:01 -0400
Message-ID: <20260623164812.81110-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f42dadb-cd02-4edd-2580-08ded14739a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|18002099003|6133799003|13003099007|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 49LDKgiC1Go5q4UmYs92bRWK/JT3G6BrKz22ln35H+XymVbhzmZXrQK0DINOlrHkCJPV+8+ExrNGvm0zHPmtrIu71Spdft94jps+Mq6NYWFKKe5TEMS/sFQzPtKEjl/pyPZ2ooVneNLxctaQvyuyeGff1X7P+EZ5cbOtWu07igugZAPuVCaYaywTQ7V0BGmoQzqnOmgj2WDeSgOM6zL1+1DcCMGoEeC68BgUw0STxvcezyhi/EhjISffWWl8MgiwQB9C+m+OeZAD9RBZpw/pa2cyWHnZsRwyPyX8z8Ex53yB0bxQzmf/jNoV6g4AM4Ljhu/b1Z2jxVNfeirWw23tpchB0acfQhTn5lvJ8EMSG46ESnjFy+GpNmRxmC1kk7w+ONGmnB4FHUtQYCA1d5ZRL5vPRhHDPICzVVDl4zB/Gg0Fv9jo6D33jla5irBQ4Ig/EulCrY9P+djW8D2gsLKrAGxMAPTLEt9CxPoCBEVSeLFIDMKYuIdfF1eXOMT+qwZzd/Pku3uJWWPkpslGfl4a4yydp1cSsnjwxFiXJkpdPdOQJGz3dhCqkCpmHduXR06bGUaoDrDBBUUd366KspIOJOLIYl0fIeI7qPF34Q6Qrl/V02mAMdD5y8+eAXr+b/xF2CGDgu2UGqaZQAJ40dSlKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(18002099003)(6133799003)(13003099007)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cDItw8PMGKbPcz9bWpFNXnW3UaBf5ft7yDLlLSlJYbd1F8uAenXMUx+87SZM4MxsldkxJU+L0lBONBHcWqdVqKzcJiaGXUxBuehxlZfgLsDfggtrZVeLU8Rg/GA80kUh5URyvzKYJDitk1s6KhQDItYho68OvVfwh81p6sbxK2S2wIPBbucas3uhQeoj+ZScTbPymLLeM3N9DZfnnvhOI32/cXuyua3i571rFW9bJjNjC6r5t9u2npdOX6MR2PdQrP5PJSDf4UrPVfZhqmNaAQpvN6LCQSyB2JDHBN0UAmO2VXLCiarwdH8rY9djVC8oHMKqH4U9Ki9kXlEYKIJwKCekvzQirH+L3I/xwA3P9EkVcHXJZCu1FV4DQ6qkC3i+g32tf/Hy5SgEGP6s9gSeJ/BJqOiBEt0GIZVOhMqjmF3d6M5W3lgdqNNb9weeySOg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:17.2529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f42dadb-cd02-4edd-2580-08ded14739a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253
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

IGT branch:
https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop

KWin branch used for testing:
https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop

The kernel branch containing these changes, based on drm-misc-next
can be found at:
https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop

Further background on this work can be found at:
https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html

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

Harry Wentland (10):
  drm/colorop: Add limited-range YUV-to-RGB fixed matrix enum values
  drm/vkms: Add fixed matrix colorop to color pipeline
  drm/vkms: Add atomic check and matrix handling for fixed matrix
    colorop
  drm/amd/display: Add fixed matrix colorop to color pipeline
  drm/amd/display: Implement fixed matrix colorop color space mapping
  drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
  drm/amd/display: Check actual state during commit_tail
  drm/amd/display: Set color_space to plane_infos
  drm/amd/display: Set COLOR_SPACE_SRGB when fixed matrix colorop is
    bypassed
  drm/amd/display: Force GAMCOR for subsampled surfaces with
    PQ/Gamma22/HLG

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  91 +++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
 .../amd/display/modules/color/color_gamma.c   |   3 +-
 drivers/gpu/drm/drm_atomic.c                  |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
 drivers/gpu/drm/drm_colorop.c                 | 109 +++++++++++++++++
 drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++++---
 drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
 drivers/gpu/drm/vkms/vkms_plane.c             |  68 ++++++++++-
 include/drm/drm_colorop.h                     | 114 ++++++++++++++++++
 include/uapi/drm/drm_mode.h                   |  12 ++
 13 files changed, 487 insertions(+), 32 deletions(-)

--
2.54.0

