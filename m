Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE741061B0F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6509010E21E;
	Mon, 30 Mar 2026 15:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JcpfgSqh";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010053.outbound.protection.outlook.com [52.101.46.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 511FA10E21E;
 Mon, 30 Mar 2026 15:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVhOf79oHJdC1c5cQBNL3V6kQDYy9HM71HQh5WnMn8dpxmyBg3gWlS1Yxrf9xmMBLQLy7fuucNIe5OJaktc9w39c9Lsfm+nRsNciWBeo6rn0q0IhjxmTITwRhwNmwhdec9wZS27GJA/H6NZLnL/iOOz5oXpf7HrrdTVEE8muCMCTxFWOxPaloRR7I8hPw4tvuevihl2vjuWo+WT2NNK2v/BUPVmztdSNhVZONUwWd4PcSVacZSICMpQzBHYY19PfKGX09piRFfkdnjjWV+O0+RWyPY8M7CDd7jkGdSTYIhIeoNqCn+zL69aUokOEjOVtxaMA2CjYrP8m6qTVU4W2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZGzcnkgeqP2d/67VSSoQ1bKYmfUOtPMbdKZAlT5zH8=;
 b=lTUduFYXi7Ni0WZd9V4vEt1/X4W5lRXBl55fSI6rlc9k23tWgC2453AMZhJkzIJ5z9gz4H5TA4WIjqq+7vjHefGF0ukrRvPrFpfh+kSpID6rPYgt0p0l5+bwMXQrmCPakgGZbJZd2FuNtfmFZgZnGcNUnsfduqqKDGrJ6cTPrVoWSa7rp5G/U1Rbyw01h1DU0Y3H/izFXgsxW8iehvpnNHNSsQPbfSlegqlr44V/8tbxmV+Y6KK+pKK/5u/ylefihstjLH6FowCU42XS+QPqGwzaYSb4Q5MSS3oQehhcSOmg67So8cVeXB6OsitVbGC6NQ5kEsF6fra3tWSWLgGcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZGzcnkgeqP2d/67VSSoQ1bKYmfUOtPMbdKZAlT5zH8=;
 b=JcpfgSqhPzXqFYbcUbajOGTqT5fk3CmT8L+ktc0e3/9wrSgd/kQ4wAMkZ12QXZbTjbdVtwzA8Eo4l44ROCymmlNcwoaXO5Rwi5XCLz90iRaeM8/56jlKBx8gDfDLw98BAk41MRuD8D+SSJGliq/0ntmyeOh2xhCzg/fOP2QsvIM=
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 15:34:56 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::d2) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 15:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 15:34:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 10:34:55 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 30 Mar 2026 10:34:54 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Stone <daniels@collabora.com>, Chaitanya Kumar Borah
 <chaitanya.kumar.borah@intel.com>, Uma Shankar <uma.shankar@intel.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>, Simon Ser
 <contact@emersion.fr>
Subject: [RFC PATCH v2 0/9] YUV conversion colorop with amdgpu and VKMS
Date: Mon, 30 Mar 2026 11:34:42 -0400
Message-ID: <20260330153451.99472-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e1c3a5-0eed-4fdb-a513-08de8e71e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: DQC4/6yE/wy1jY2kURCr/uExEjFi7UrQkTkRZx5N3mHCen48+5zvhKLxUhZA5ToX6gzPplpPdGyIe0NYss4eukSQxIOUdLHxBBDIWWr5WITfKugyCSWcc7qE9Pkz79XrlC0S6itKJuT1R9lUyhhwO6q34Qn35EzErZe83YtVhWdYfVmr1Sf4BWZgOtzbeMvOPRVtQ678ZIFcbFLR+aG+aTmjy3r4oA9QYmxy/z8YVo8nc4/syAlS50FAtAcAwYI/UJWgr7tQDVOxrgRe4esstplyZaujpetXeI18LDmY61WnqfqCM9VVVfQSYxwVoHadDLNpSXyCBkRMfUVNay3vMCmga0jX32WH14UaSCKdjOOaZsqYzh6pILkw2f8+NYKaS0nTQYfgmRCJ//hhB+/oCI6EovVcNxR+zVvSghOL9hs4OFrLemKJVXwkjpDblpfmV3S02/aNo0HKb7NbNETGQR/lme3LUPjiN5viCANf9Hs4lrM4AKIHyWt/j5FifHqexIbj75CMxfwRNRKV2a1KUbl1b3cWV7RAvcQT7tPASWsT/cNZj2qNvvtFEbiYnCkzCWnYYI6cegt1X15bYhxSzejoqpA8YGRHoy8bL1CDl2ijFOGuz3FCmpjGF01tobIlu6SwuuGpJTsRJTr2SsOcWZP47ovZCYFc3R0B97i1i18YnA0PDVRTS7ieD/LJUaLgjGezgwY7T48RTWyNYODA/TwzxE+aYIjGZhiO7W5us5M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6aEGDO50/oCvxbhDBjHHktZFERj9vKzmfbX+xcx3z8/zgdhOkpl9nQo5eDq++Iw8SSc6EzpHSYZv4MpgSjCPZjWQRW2JqP0obUqisLnaacwvgycpGETPq/YnElqUUrGWvUkDJXot0S9Xagxb65aXX4TTsNsHX8wVY0GiA69MdI8l3L58+EhoLUYMKYVNbT5vTTD1aCC+83qYzISOG0fees06UjyxXfTSITzsOfA6TcpnrahoUdONm8/U+IXreyX5YtbN+D0yxG0VkvUSgqwagIkqdchh9f+xmVecqteYPrA+a3S4DjPR1SciNiftO+3r5QYIj5Zs67VeGDxRHrAREFxptPmLw3MMqtnmXUmbSHJb0Q92nWCZCDChujJJ9jw1DRPZb1s9gWz2wTVoqJUVd+IrUWhtSEP6geWbx1s+hvSUDldSuxMgE4GxSaynOZ/4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 15:34:56.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e1c3a5-0eed-4fdb-a513-08de8e71e548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

This patchset expands on the CSC_FF colorop proposed by Chaitanya
and adds limited range variants of the YCbCr to RGB conversions.

His full patchset can be found at
https://patchwork.freedesktop.org/patch/709860

This code has been tested with IGT and an experimental KWin branch.

IGT branch:
https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-ff-colorop

KWin branch:
https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut

The kernel branch containing these changes, based on drm-misc-next
can be found at:
https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-ff-colorop

In order to successfully use this branch you might need a few
bugfixes. The kernel tree containing those fixes plus these patches
can be found at:
https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-ff-colorop-all

Further background on this work can be found at:
https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html

v2:
- use Chaitanya's CSC_FF block for named matrices

Cc: Alex Hung <alex.hung@amd.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Simon Ser <contact@emersion.fr>

Chaitanya Kumar Borah (1):
  drm/colorop: Add DRM_COLOROP_CSC_FF

Harry Wentland (8):
  drm/colorop: Add limited-range YUV-to-RGB CSC FF enum values
  drm/vkms: Add CSC FF colorop to color pipeline
  drm/vkms: Add atomic check and matrix handling for CSC FF colorop
  drm/amd/display: Add CSC FF colorop to color pipeline
  drm/amd/display: Implement CSC FF colorop color space mapping
  drm/amd/display: Use GAMCOR for first TF if CSC is used
  drm/amd/display: Check actual state during commit_tail
  drm/amd/display: Set color_space to plane_infos

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 102 ++++++++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
 drivers/gpu/drm/drm_atomic.c                  |   4 +
 drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
 drivers/gpu/drm/drm_colorop.c                 | 108 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++++----
 drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
 drivers/gpu/drm/vkms/vkms_plane.c             |  70 +++++++++++-
 include/drm/drm_colorop.h                     | 102 +++++++++++++++++
 include/uapi/drm/drm_mode.h                   |  13 +++
 12 files changed, 487 insertions(+), 30 deletions(-)

--
2.53.0

