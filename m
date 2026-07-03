Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5513DC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6B110F721;
	Fri,  3 Jul 2026 09:44:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="NnP5Wc1l";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6649910E331;
 Fri,  3 Jul 2026 09:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783071848; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Hns0HDF+5DW4cD3Wyzj1ukJUOFrgFYrE5+YBpCvyWZs/W5i1XphlqM2jmQd74vHGAOf5SrrsSoJdGZwukc8jUGed2yCtRJcZfShg6cUS84axjtd7FzRPaqPfE0Q1OkT8gzP7DAzZsAvEB7aZB2YLsm6OumBXrkZZwzFm4ucmnZ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783071848;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iY6shyBIx6VYi3lt7Tn+pTfkrRSShmHcVAkPE+hZzh8=; 
 b=C/8bQVBcAGDodPlIA8FodQa4mScPk9wc11zuXiFwWjIMAcGgdbZ8GelwWDAU/fzy9r4KzcibrRhY1uS2qGCchCUMMJoyPWkYPYLid74pTVYSy8iOa3uSb+Icw9xw2lotFPP2BWb8te4GqArl2FCDzk6px7c5bpUL3pexk/0kKmw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783071848; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=iY6shyBIx6VYi3lt7Tn+pTfkrRSShmHcVAkPE+hZzh8=;
 b=NnP5Wc1lSYg5HsW1oqfJxCG0KgoZSdNoqu5SUZNoxVuRhV+ifrFEVRKQTd9tztjb
 qRGzXtyjBCo5u38d0XcbBVAR+dFcNQ8IN7Fk2m2SiiohhtD261qC8Fhax5zXFjqFoZU
 iOmlfluyM8gSFotaZbpG885ZkdGbQejCGQCU+H8c=
Received: by mx.zohomail.com with SMTPS id 178307184634623.534923268723333;
 Fri, 3 Jul 2026 02:44:06 -0700 (PDT)
Message-ID: <8035ec76-bc86-47a9-950a-674a39b6a2fe@collabora.com>
Date: Fri, 3 Jul 2026 11:44:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] YUV conversion colorop with amdgpu and VKMS
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260623164812.81110-1-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Harry,

I wrote a Weston draft implementation here: 
https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133

Weston had an existing test ("color-representation-drm") for the legacy 
properties, ensuring the VKMS output visually matches expectations for 
all six possible values. With the MR above, if VKMS is loaded with 
enable_plane_pipeline=1 the new colorop is used, confirming that the 
VKMS implementation works as expected and in general that the new 
colorop can be used as a drop-in replacement for the legacy properties. 
That means any driver/hardware/plane that currently supports 
COLOR_ENCODING and COLOR_RANGE could offer a pipeline with only the 
colorop added here and just map it to the existing underlying 
implementation.

The mentioned test runs on the CI and thus allow to easily check that 
things work as expected - quoting one example from KMS debug output in 
the the test log:

[atomic] applying output 0 (Virtual-1) state
     [CRTC:97] MODE_ID (24) -> 108 (0x6c)
     [CRTC:97] ACTIVE (23) -> 1 (0x1)
     [CRTC:97] GAMMA_LUT (29) -> 0 (0x0)
     [CRTC:97] VRR_ENABLED (25) -> 0 (0x0)
     [CRTC:97] BACKGROUND_COLOR (31) -> 18446462598732840960 
(0xffff000000000000)
     [CONN:105] CRTC_ID (21) -> 97 (0x61)
     [PLANE:35] FB_ID (18) -> 109 (0x6d)
     [PLANE:35] CRTC_ID (21) -> 97 (0x61)
     [PLANE:35] SRC_X (10) -> 0 (0x0)
     [PLANE:35] SRC_Y (11) -> 0 (0x0)
     [PLANE:35] SRC_W (12) -> 16777216 (0x1000000)
     [PLANE:35] SRC_H (13) -> 16777216 (0x1000000)
     [PLANE:35] CRTC_X (14) -> 384 (0x180)
     [PLANE:35] CRTC_Y (15) -> 256 (0x100)
     [PLANE:35] CRTC_W (16) -> 256 (0x100)
     [PLANE:35] CRTC_H (17) -> 256 (0x100)
     [COLOROP:40] BYPASS (42) -> 0 (0x0)
     [COLOROP:40] FIXED_MATRIX_TYPE (44) -> YCbCr 2020 NC Limited to RGB 
(0x5)
     [COLOROP:45] BYPASS (47) -> 1 (0x1)
     [COLOROP:50] BYPASS (52) -> 1 (0x1)
     [COLOROP:55] BYPASS (57) -> 1 (0x1)
     [COLOROP:60] BYPASS (62) -> 1 (0x1)
     [PLANE:35] COLOR_PIPELINE (65) -> 40 (0x28)
     [PLANE:35] FORMAT: NV12 MODIFIER: LINEAR (0x0)
     [PLANE:35] rotation (37) -> 1 (0x1)

I also tested the AMD implementation with the Weston MR and Gstreamer 
(>= 1.28) pipelines like this:

gst-launch-1.0 filesrc location=~/Alaska2160p30fps8bitAV1.webm ! 
parsebin ! vaav1dec ! waylandsink fullscreen=1

and confirmed that at least BT709-limited and BT2020-limited with NV12 
and P010 work as expected.

In these test cases all other colorops where set to bypass - however at 
the recent Display Next Hackfest we also tested more complex pipelines 
with a mostly identical patch-set.

Therefor the whole series is:

Tested-by: Robert Mader <robert.mader@collabora.com>

I'll now go over the individual commits to add additional R-Bs where I 
reasonably can.

Thanks and best regards!

Robert

On 23.06.26 18:48, Harry Wentland wrote:
> When we merged the drm_plane color pipeline API the major gap
> that existed was the lack of a YUV to RGB conversion colorop.
> We deprecated any legacy drm_plane color properties, which
> means that the COLOR_RANGE and COLOR_ENCODING properties can't
> be used with the COLOR_PIPELINE property on a drm_plane. In
> practice this means that we can't use a COLOR_PIPELINE on
> YCbCr encoded framebuffers.
>
> This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
> and adds limited range variants of the YCbCr to RGB conversions.
>
> His full patchset can be found at
> https://patchwork.freedesktop.org/patch/709860
>
> This code has been tested with IGT and an experimental KWin branch.
>
> IGT branch:
> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop
>
> KWin branch used for testing:
> https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop
>
> The kernel branch containing these changes, based on drm-misc-next
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop
>
> Further background on this work can be found at:
> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>
> v3:
> - base on Chaitanya's updated patch and rename code accordingly
>    to Fixed_Matrix instead of CSC Fixed-Function
>
> v2:
> - use Chaitanya's CSC_FF block for named matrices
>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Robert Mader <robert.mader@collabora.com>
>
> Chaitanya Kumar Borah (1):
>    drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
>
> Harry Wentland (10):
>    drm/colorop: Add limited-range YUV-to-RGB fixed matrix enum values
>    drm/vkms: Add fixed matrix colorop to color pipeline
>    drm/vkms: Add atomic check and matrix handling for fixed matrix
>      colorop
>    drm/amd/display: Add fixed matrix colorop to color pipeline
>    drm/amd/display: Implement fixed matrix colorop color space mapping
>    drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>    drm/amd/display: Check actual state during commit_tail
>    drm/amd/display: Set color_space to plane_infos
>    drm/amd/display: Set COLOR_SPACE_SRGB when fixed matrix colorop is
>      bypassed
>    drm/amd/display: Force GAMCOR for subsampled surfaces with
>      PQ/Gamma22/HLG
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  91 +++++++++++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 ++++-
>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>   .../amd/display/modules/color/color_gamma.c   |   3 +-
>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c             |   4 +
>   drivers/gpu/drm/drm_colorop.c                 | 109 +++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_colorop.c           |  66 +++++++---
>   drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>   drivers/gpu/drm/vkms/vkms_plane.c             |  68 ++++++++++-
>   include/drm/drm_colorop.h                     | 114 ++++++++++++++++++
>   include/uapi/drm/drm_mode.h                   |  12 ++
>   13 files changed, 487 insertions(+), 32 deletions(-)
>
> --
> 2.54.0
>
>
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <dri-devel-bounces@lists.freedesktop.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.lore.kernel.org (Postfix) with ESMTPS id B655BCDB479
> 	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:48:27 +0000 (UTC)
> Received: from gabe.freedesktop.org (localhost [127.0.0.1])
> 	by gabe.freedesktop.org (Postfix) with ESMTP id 0E9B310EC02;
> 	Tue, 23 Jun 2026 16:48:27 +0000 (UTC)
> Authentication-Results: gabe.freedesktop.org;
> 	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZX10j76";
> 	dkim-atps=neutral
> Received: from CO1PR03CU002.outbound.protection.outlook.com
>   (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
>   by gabe.freedesktop.org (Postfix) with ESMTPS id 5F51010EC02;
>   Tue, 23 Jun 2026 16:48:26 +0000 (UTC)
> ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
>   b=VA0YLyQcoF/NwrbXIx3+VQ3BEuv4aT+SYHQefo57EnVYiNpi7RTRdV8VfAs3YI1HaBIgdfe0AkgUp2sC8Azh2r/XMeGOAqDdtj7rRvOHuvgjadls3iVdy5T/OCqvN+DcP5e0Ydi2hlorPceYBV4ks7zRX19kZmUhJfvowzMu+XwXMzrBa9xNAjbM+WxzxrXmrQH5lmz3Zg5xwSSInH2RR9E/Tt4TP/XK+pIaCYlJJpAYXMrInwgmzvdFXJZxaMdQ9JKTbSm0SgpYPSQNPx97d2RgSobhpvcU8W+dKFZisu+NPHwJZmigWmqY5aK94xMrUhQlA+IxH7Lt3oENs+ALcA==
> ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
>   s=arcselector10001;
>   h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
>   bh=Va79LlpBVSYHVb5GCR4+MP8S3TZmpgDcdmsEEadaWcA=;
>   b=eoDmKJvvQs88tX+Vv3cmW09h27cbxGDBKt5MemE17ISSIfStPkjPR1Usp+BuJfNnGpTnlrmuYy0r6kE690Tnn9r9T1yFAYNZzZ6U8HOGw+zlTM8cXdLol+R37urgfqSWz21U08bYDNw7XnTf6wbE/g/x75DRwzWyrKN3z5Y6tWiX8+LK0yLYRmsjneexC8uAw5Z5kRaPPylBnJRY0Thse5NiffisMrri1OdAoOgEW9z1GL2Q7X8AInUvthDOGefsppr5QOZIr2Xr8zNqqKSpRCMyDIDOTUXlfO5SCdCaYc68yb7FOUWO+rbxqgWll7JcOmnMaZh4eJ1+eAgKTst9lA==
> ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
>   165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
>   dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
>   header.from=amd.com; dkim=none (message not signed); arc=none (0)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
>   h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
>   bh=Va79LlpBVSYHVb5GCR4+MP8S3TZmpgDcdmsEEadaWcA=;
>   b=qZX10j76DTVxZmEdcDnUG3FjzS8o4p/w092+ZzCoDTdUvqRhy8BseSn6wGPgeWFEbkyS35p0+8lPhM6kx0YCDqeAvP6ya7APbwQxyiMLnhDAMu7cZffNOZGNmVMrJd0zsMMZgN8X2aWlj0ckB5JENTDjCjjYyKZfVWwJHQO3Isc=
> Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
>   SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
>   Microsoft SMTP Server (version=TLS1_2,
>   cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
>   2026 16:48:19 +0000
> Received: from DS1PEPF00017099.namprd05.prod.outlook.com (2603:10b6:8:2f::4)
>   by DS7PR05CA0037.outlook.office365.com (2603:10b6:8:2f::24) with Microsoft
>   SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12
>   via Frontend Transport; Tue, 23 Jun 2026 16:48:18 +0000
> X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
>   smtp.mailfrom=amd.com; dkim=none (message not signed)
>   header.d=none;dmarc=pass action=none header.from=amd.com;
> Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
>   165.204.84.17 as permitted sender) receiver=protection.outlook.com;
>   client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
> Received: from satlexmb08.amd.com (165.204.84.17) by
>   DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
>   SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
>   15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:18 +0000
> Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
>   (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
>   cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
>   2026 11:48:18 -0500
> Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
>   (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
>   cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
>   2026 11:48:18 -0500
> Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
>   (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
>   Transport; Tue, 23 Jun 2026 11:48:17 -0500
> From: Harry Wentland <harry.wentland@amd.com>
> To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
> CC: Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
> Subject: [PATCH v3 03/11] drm/vkms: Add fixed matrix colorop to color pipeline
> Date: Tue, 23 Jun 2026 12:48:04 -0400
> Message-ID: <20260623164812.81110-4-harry.wentland@amd.com>
> X-Mailer: git-send-email 2.54.0
> In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
> References: <20260623164812.81110-1-harry.wentland@amd.com>
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> Content-Type: text/plain
> X-EOPAttributedMessage: 0
> X-MS-PublicTrafficType: Email
> X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA3PR12MB9199:EE_
> X-MS-Office365-Filtering-Correlation-Id: b8d5e9e1-ef4b-45b3-3dd2-08ded1473a84
> X-MS-Exchange-SenderADCheck: 1
> X-MS-Exchange-AntiSpam-Relay: 0
> X-Microsoft-Antispam: BCL:0;
>   ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003;
> X-Microsoft-Antispam-Message-Info: HWkLA1p9dJhZyeyQ+wRPa13E7c3B1nHhhTTqJAch6jyxhBqK2bXCX4wi71GuXwKamvb0dDZO5W0bt+VmstYYLg/ai2JdaH9Ky5UZrjhvd6xZP0WpXuMaYcmPe3sy6CNsQ45zbDJH6G+w3ycZWBm9yXMQg3/U8q75th+zL2NV1PrP9CZ+xuTpWLmITvsb8s7QN75yKpxosdZ1hQheQ6SiWpe3JbfBU80b5FE03xBEQAjlO5Zr8ALlTgfDNNzSfbDmzK24bLPUxeE9gHq6uJTKbcv7mYXJsFdpDetHWjEN4gAaqXAUlyP62FksIJOdNSl1ZU4GPi9UEzqpiW/MJp2KH7p8LIVvyeN1TRtv0n8gch2slamirYUj3XZd5GGusjidQKjon7MMq1HVjkAne6f44NC1+E4WRBCWr9l3ij5HFz9+OfO6yGchONfrY/HzYApeFN8ylIghw5ZhL3FdtDmC4Ya0nC9e4zoWdcfSRa013xQC4W2ZR02YxAuoirWh9JgCbYPwcIe59geKASyGabDlJrwhmci/aFeaMzw8/cw+UvRGqnVS4dfjhyvYKKw8IDnZtHL775UavtadnBKftKlz3Punx/lsLNlEPgEInts1YSsrWWcSDwZjf9i3d+srM2YMEMtoaRjWP/ghtKFYio84JfqBTGz2zb1MductyyjOnbU/6fatAM4cf+PqmdSqyLZ9KL+xrK8hcaFxT4awOqeqvg==
> X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
>   IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
>   SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003);
>   DIR:OUT; SFP:1101;
> X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
> X-MS-Exchange-AntiSpam-MessageData-0: y1eQ/S3waZfjEZXFahjKn+8wWNk7thWlCT5NINZNyFhy6gsLTrvn2uHkXQjwTIZHM0dKCFbNTMTl/+rtqNe7HsAuG7uDsfbZBlLQQE4BY4QDUYh4W8IvQa+vMgtH/lDUe8dUAeXDCDm6JXk6hkomFO8h3vM8ey/NZYyctZZlxUKS/ocYoL4t24N28DABkUVt+82m7QrOo6BUWwftaj2rATOo3F/wdisUHeLnUyucdGsOWYxnlD1G2Z/ZpbNChk8m5EnAMkti2xmQgHLAIroV9KC+bHBURnmn5BoK0Bub2tXFMqdFnE7SIrD4BE5GeGCWjs3icEwQgr8B1/dqwIMr1Pccuk1QebbrFUiqZEfj9rzwNcF/cYq6gqvCsM30BhcObGAob2T4aGbJam2qmxG0q53+aVy00VxSqQvLGYLDkr8VaGsbt6MOEEZ5oyYrwxTd
> X-OriginatorOrg: amd.com
> X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:18.7091 (UTC)
> X-MS-Exchange-CrossTenant-Network-Message-Id: b8d5e9e1-ef4b-45b3-3dd2-08ded1473a84
> X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
> X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
>   Helo=[satlexmb08.amd.com]
> X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
> X-MS-Exchange-CrossTenant-AuthAs: Anonymous
> X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
> X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
> X-BeenThere: dri-devel@lists.freedesktop.org
> X-Mailman-Version: 2.1.29
> Precedence: list
> List-Id: Direct Rendering Infrastructure - Development
>   <dri-devel.lists.freedesktop.org>
> List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
>   <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
> List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
> List-Post: <mailto:dri-devel@lists.freedesktop.org>
> List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
> List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
>   <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
> Errors-To: dri-devel-bounces@lists.freedesktop.org
> Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
>
> Insert a fixed matrix colorop as the first operation in the
> VKMS color pipeline, before the existing 1D curve. This allows
> userspace to select YUV-to-RGB conversion via the color pipeline
> for YCbCr framebuffers.
>
> The CSC Fixed Matrix colorop advertises support for all six
> YUV-to-RGB conversion presets:
>    - YUV601/709/2020 full-range to RGB
>    - YUV601/709/2020 limited-range to RGB
>
> Bump MAX_COLOR_PIPELINE_OPS from 4 to 5 to accommodate the new op.
>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/vkms/vkms_colorop.c | 66 ++++++++++++++++++++---------
>   1 file changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
> index 071f3a8d2e7c..9424b1994239 100644
> --- a/drivers/gpu/drm/vkms/vkms_colorop.c
> +++ b/drivers/gpu/drm/vkms/vkms_colorop.c
> @@ -12,11 +12,19 @@ static const u64 supported_tfs =
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>   	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF);
>   
> +static const u64 supported_fm =
> +	BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
> +	BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
> +
>   static const struct drm_colorop_funcs vkms_colorop_funcs = {
>   	.destroy = drm_colorop_destroy,
>   };
>   
> -#define MAX_COLOR_PIPELINE_OPS 4
> +#define MAX_COLOR_PIPELINE_OPS 5
>   
>   static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_prop_enum_list *list)
>   {
> @@ -27,7 +35,25 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	memset(ops, 0, sizeof(ops));
>   
> -	/* 1st op: 1d curve */
> +	/* 1st op: Fixed Matrix (YUV to RGB) */
> +	ops[i] = kzalloc_obj(*ops[i]);
> +	if (!ops[i]) {
> +		drm_err(dev, "KMS: Failed to allocate colorop\n");
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &vkms_colorop_funcs,
> +						  supported_fm,
> +						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type = ops[i]->base.id;
> +
> +	i++;
> +
> +	/* 2nd op: 1d curve */
>   	ops[i] = kzalloc_obj(*ops[i]);
>   	if (!ops[i]) {
>   		drm_err(dev, "KMS: Failed to allocate colorop\n");
> @@ -41,23 +67,6 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   	if (ret)
>   		goto cleanup;
>   
> -	list->type = ops[i]->base.id;
> -
> -	i++;
> -
> -	/* 2nd op: 3x4 matrix */
> -	ops[i] = kzalloc_obj(*ops[i]);
> -	if (!ops[i]) {
> -		drm_err(dev, "KMS: Failed to allocate colorop\n");
> -		ret = -ENOMEM;
> -		goto cleanup;
> -	}
> -
> -	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
> -					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> -	if (ret)
> -		goto cleanup;
> -
>   	drm_colorop_set_next_property(ops[i - 1], ops[i]);
>   
>   	i++;
> @@ -79,7 +88,24 @@ static int vkms_initialize_color_pipeline(struct drm_plane *plane, struct drm_pr
>   
>   	i++;
>   
> -	/* 4th op: 1d curve */
> +	/* 4th op: 3x4 matrix */
> +	ops[i] = kzalloc_obj(*ops[i]);
> +	if (!ops[i]) {
> +		drm_err(dev, "KMS: Failed to allocate colorop\n");
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_plane_colorop_ctm_3x4_init(dev, ops[i], plane, &vkms_colorop_funcs,
> +					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +
> +	i++;
> +
> +	/* 5th op: 1d curve */
>   	ops[i] = kzalloc_obj(*ops[i]);
>   	if (!ops[i]) {
>   		drm_err(dev, "KMS: Failed to allocate colorop\n");

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

