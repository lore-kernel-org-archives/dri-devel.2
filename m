Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D99C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06C0910F41F;
	Fri, 24 Jul 2026 16:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VcrNofLz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602ED10F41F;
 Fri, 24 Jul 2026 16:31:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9B68600AD;
 Fri, 24 Jul 2026 16:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB681F000E9;
 Fri, 24 Jul 2026 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784910673;
 bh=iyJ8tkxt3n1CtByixTV93nC7Ad6kAUHNqgFi6ed8GAE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VcrNofLz4ndkJQcLHH4OHbh7X7jnjgpWFN8+bRrDeY66TddBug7TU4onYqHHszyHg
 Cl08sxC7B89sgdVrvnpoUg+9bgsM0i0jlboWdnOj6kmwBZLusHI1Uy1fpxYDSMbSiT
 L8OY7IvvxtF9QFW0O8UBS0JLyyzBaqdYe84L/1GFqcbsE70EiAAiS6PMJfC/F9XYQR
 bJkMf7l2I4Mw4Znj9PVi540ReK9l+RXpCkoAaq51B1sLikXEeOy9qTdWuGNdlbpyZn
 G4a8fd6mm00LzmfEXMDFIJmt6j/EuTf/JLXBafMgyV6kLdwGw+mhJIJEjlQu/LFJR0
 XN0vfl6mRJ2lA==
Message-ID: <a9d8e66f-bf4b-4299-9b2e-cdbbcac22b09@kernel.org>
Date: Fri, 24 Jul 2026 11:31:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] drm/edid: Parse AMD VSDB FreeSync range in common
 code
Content-Language: en-US
To: Alex Huang <Alex.Huang2@amd.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, alex.hung@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260724161713.119382-1-Alex.Huang2@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260724161713.119382-1-Alex.Huang2@amd.com>
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

On 7/24/26 11:17, Alex Huang wrote:
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
>   drivers/gpu/drm/drm_edid.c                    | 141 ++++++++--
>   include/drm/drm_connector.h                   |  22 +-
>   9 files changed, 175 insertions(+), 567 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
> 
> --
> 2.34.1
> 
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
