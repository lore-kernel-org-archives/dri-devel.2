Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3F7C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93DCF10EDEC;
	Wed, 22 Jul 2026 13:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H2GUyikg";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A045A10EDE5;
 Wed, 22 Jul 2026 13:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J94pJLmfaSNf9CSr91/6vyHHyGLkuaJiuyWxViGvqjsdWXxUepkqGTS457ccZvETtRQsu6hK2PoNFPkK5Oiqsw0qwIdrsreeI5go8sul6ji/bT79jIHCI6AsMAH7HbS/cV2W2HcmPPNiPEJbm1vfEAJ2EkdUySNSBxGqHbTPBOorerJSfmFlRYhNL6Beg5dleYfvlQXuAYd2jmVV5Gib5xgA2pJzpM4Zo7m8nheu8IwlaOSvcvNidE8W20RDuL28HbMwzYBzYI7DQTmxxzHl+vnhdB2MKYB7lrCfwrk3aDCACAxmnOZkVrc1g5/24G3YZgKbXC1UIHSWPnJG0fvcLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VE/8jp+02pa0lGdxoUHPUe5LbKA4HEIwumgTmLftnoo=;
 b=QPIcDCOl2drrd6/HWI4/OkPUZFkjSmY9eW43KR9flCazRq0YxsKEWi2CWoOgSwomDQo6MMCJ0RjWlfDBJLXs+5WucLxbkPwzxRoOPowX/P57Fk/9n9VponzdHmO/Mzncbu8Cjw5ndjTS956VKb9Tr74o6B5WNoH6QJrKSyiWODDwrWJh6c0U2xs9mMG0awJdIUy+2xkE2nfxUFSyusHRLJ/+iAqSrY8aEXhP6M8R1AjnkEKxg+tTT2FyjncS4FpRRnCf2vBLDtqUFYu7jmmAmU95/BgkmQwMwkyII2p9GpUa6+UD+a5zPAt60KHLeH6hCdUxfnPyg08udVW2MDgc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VE/8jp+02pa0lGdxoUHPUe5LbKA4HEIwumgTmLftnoo=;
 b=H2GUyikglYI09NCzUhGeDJLBIt5smf3b4WHqKMyl+QYnhlG+wiNzv7WZ6kmIQGwzQ9h8UyWwmgYVIB1WF+9LrerS8kfxEZ7VY7wQrKlBBg2NzRNZKh31Vn9mMkYB+bMEUwXy04A+0xNdUWt+yLOT5TOc3DsI6+h8H1LbyQDbJro=
Received: from SJ0PR05CA0180.namprd05.prod.outlook.com (2603:10b6:a03:339::35)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 13:46:17 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::4f) by SJ0PR05CA0180.outlook.office365.com
 (2603:10b6:a03:339::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5 via Frontend Transport; Wed, 22
 Jul 2026 13:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 13:46:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 22 Jul
 2026 08:46:15 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 22 Jul 2026 08:46:14 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>, Simon Ser
 <contact@emersion.fr>, Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v4 00/11] YUV conversion colorop with amdgpu and VKMS
Date: Wed, 22 Jul 2026 09:45:56 -0400
Message-ID: <20260722134607.136293-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 564cfc63-1fa5-49df-a6d6-08dee7f79aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|13003099007|3023799007|11063799006|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: BG2F6PkT0IHuLctbP6vOaevT2wJq6A2aJQOzDYWFsLQPwZ3X9AQtx+sBpylicMBkfcepxSHj+v9eGVPxu/vr7HZAl93SamrYz8nGNG877AWTMXmo1juvMojVGGIS1vNFpWZmXI80OKnN/IVmk6qmq/iMh59Eq3L7ZZ+Uip1xevvSpXSelJb/QbTIiGPLQZsEBBW2m0ZqjAQzIjFwGe5xCuKSHoAuGlNsUeCDxC0qdmTZXrds24yly9vVPsPiZhlqvnzBecqSSKMGYTiwoeVbme2Jof1MRoTV4JXHR2Y/r7FUyoqqAhOpalsa2Z8uXGSE0qk3ic4gvi86jad3qUUCoe3/pQLJf/kzfviyh+BP4hG6CxapCZbPguwPQae++t2xKuqws16rwtlDukw9k9wpoAc3OpfSaodKZJocrhImOv0MVztLEUC3/mLuYVXeuYZ8K5tTX9K2esGo90Id1Opqzvj3mTTIXk4hGawqOcddw/vxLK5BmFYmHXxEGnwmdqY6fI7gfREJGTtNttbwsmHymkzjevX5g7wEq3eKo4ZKroe+ZdMnItzVTTGv1RuWds6lMyBCNh88yqgxzVNNa+/aGXM4DZireYzJaKpkDkZ8D5W6TSXr377lv8qRzvRKSs+3FFcYf5GamiMgJT3BB5trPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(3023799007)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YQBZf04fqVX3DMeQYVnNdQpOYgeYnI7SG4fwJaabOyNaDHz7du9+7uJIABOAPVyAUto9KNFQvEbUvx69bRC0w4ovmAj0vktla70j/GnKiXTKAKd5sBCe0CL+yK2zDbBn/rQSQXC3W4zP56rdmWQcmwmBnG8TpO2dy1mkzD/JyEy1DkyVVrqoNbTJyrkKQhu0cvPuqHg+8EPnd+m7INB0BLyPIEvkQ/xr45LxbruuYyQXhRjBP22W3CvqWFqhdrWx3w4fIrFaL8+QSaBAUMqI0u9FObzwRF5qyuidwhLTH5lpaANrSZNqnKjPxSqr6conTFtp9VDt+YpGttAVAvBc+K7WHMKftR9nC1vC/qB5NwDub4NMk9bs6hyzXPhZPfHjPIgRpEfOISgxVYMzEcl++74z0bWtasJu9Qq3nw+zBeEycf2/DsvOSLp8TgJ9x9Ng
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 13:46:16.9346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 564cfc63-1fa5-49df-a6d6-08dee7f79aa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

Harry Wentland (10):
  drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
  drm/vkms: Add KUnit test for YCbCr to RGB conversion matrices
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
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
 .../amd/display/modules/color/color_gamma.c   |   3 +-
 drivers/gpu/drm/drm_atomic.c                  |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
 drivers/gpu/drm/drm_colorop.c                 | 109 ++++++++++++
 drivers/gpu/drm/vkms/tests/vkms_format_test.c | 160 +++++++++++++++---
 drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++---
 drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
 drivers/gpu/drm/vkms/vkms_formats.c           |  64 +++++--
 drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
 drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++-
 include/drm/drm_colorop.h                     | 159 +++++++++++++++++
 include/uapi/drm/drm_mode.h                   |  12 ++
 16 files changed, 706 insertions(+), 68 deletions(-)

--
2.55.0

