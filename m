Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416BBC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF4510F122;
	Wed, 12 Aug 2026 20:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f52dC+Af";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B65410F122;
 Wed, 12 Aug 2026 20:17:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A2F7600AF;
 Wed, 12 Aug 2026 20:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98B51F000E9;
 Wed, 12 Aug 2026 20:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786565831;
 bh=tD1TM/YZpUNPB462lbqZ7Y70M2F6tCpRYvMEMBniZHY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=f52dC+Afs4RjVmYnlFccxQpHOjaNMF2hCI7f9QdwICJoODGNoewpdFT/fg0ZO8yDm
 D3pBxJfDjLvN6zz8oI7+LaEnbpbWzdlmpGU8UWQoEeDyPutmlX0l49QmpakiEQwLZ3
 45uULFdFjJJ5V4lGla8isAzEncUQo94PmGufvO5z0s6e2h/kZYtVaainEJWwJZV73f
 pNggZ+PTx6+oDYF+rz1EbiShFquq8dv2ZEGZoZ05YLZ8PB+ClShTlh4C1iHXnp2QMx
 49sTLB+rOY9H+XgDRVmzt2k/mEXygiQC6Fl7DXgfohPS2mRnWI8udqcPlWBGXP6lvL
 MBzXnuJ5+o2mA==
Message-ID: <51132f10-3775-4296-827a-0d3d0d1855e8@kernel.org>
Date: Wed, 12 Aug 2026 15:17:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] drm/edid: Parse AMD VSDB FreeSync range in common
 code
Content-Language: en-US
To: Alex Huang <Alex.Huang2@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, alex.hung@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260804143339.714548-1-Alex.Huang2@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260804143339.714548-1-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/4/26 09:33, Alex Huang wrote:
> This patch series implements parsing for AMD VSDB block's FreeSync
> related data directly in the EDID common parser.
> 
> Some monitor manufacturers advertise their VRR capability exclusively
> using the AMD VSDB block's FreeSync data fields, many other
> manufacturers (notably pre EDID 1.4 monitors and some post 1.4 monitors)
> also do not include the relevant continuous frequency feature flag in
> the EDID. This makes it difficult to differentiate true VRR capability
> from supporting a few refresh rates between the range specified in EDID
> refresh rate range field in a spec compliant manner.
> 
> Incidentally also resolves a recent regression where amdgpu failed to
> detect some DP monitors as VRR capable after EDID parser was moved to
> DRM common.
> 
> v2:
> - Use a ladder style parser as suggested by Mario.
> - Validate payload lengths before parsing.
> - Removed an extra amd_vsdb_version reassignment.
> 
> v3:
> - Parse future versions as v3 block as suggested by Mario.
> 
> Alex Huang (4):
>    drm/edid: Parse AMD VSDB for FreeSync refresh range
>    drm/amd/display: Use HDMI FreeSync range from common EDID parser
>    drm/amd/display: Clean up FreeSync capability detection
>    drm/amd/display: Remove unused DMCU/DMUB EDID CEA parser
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 252 +++---------------
>   drivers/gpu/drm/amd/display/dc/Makefile       |   1 -
>   .../gpu/drm/amd/display/dc/dc_edid_parser.c   |  80 ------
>   .../gpu/drm/amd/display/dc/dc_edid_parser.h   |  44 ---
>   drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c | 121 ---------
>   drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  10 -
>   .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  71 -----
>   drivers/gpu/drm/drm_edid.c                    | 147 ++++++++--
>   include/drm/drm_connector.h                   |  22 +-
>   9 files changed, 181 insertions(+), 567 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
> 

Hi Alex,

As I've reviewed this and there is no other feedback the past week I've 
added it to drm-misc-next.  There were some minor changes from movement 
in amdgpu_dm.c to amdgpu_dm_connectors.c that I adjusted your patches 
for when committing (another commit moved it).

Thanks!
