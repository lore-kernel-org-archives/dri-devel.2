Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBA7CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 17:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDAB910E33A;
	Fri,  8 May 2026 17:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="S9bLNOBj";
	dkim-atps=neutral
X-Greylist: delayed 320 seconds by postgrey-1.36 at gabe;
 Fri, 08 May 2026 17:50:50 UTC
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com
 [95.215.58.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BB710E33A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 17:50:50 +0000 (UTC)
Message-ID: <0aa24b65-bf32-4955-95ff-e83b5cf4a95e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778262318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYSZnDmTsuozUYUmJINbc98ChIljg9omdqVjq5iRYaw=;
 b=S9bLNOBjMg09zTj2wf5tnT6yK4ofbB5j3KPH8NKiOuSpxgLgJai6TmNQHjw9pkrJmJHMw5
 0Pk7O188L/xNfASlN2d9JlTGQ7kNpzkJv4RTpdMoW0C2sr705NnRoBgdFVRrIdESgQlbqq
 qoh/Xo3sPJIFy91HStTEBYgjg7oJ//4=
Date: Fri, 8 May 2026 10:45:10 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] better LUT segmentation for EOTFs
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 pekka.paalanen@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260506191606.15022-1-mwen@igalia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20260506191606.15022-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

On 5/6/26 12:11 PM, Melissa Wen wrote:
> Hi,
> 
> With an external HDR monitor, we can see gradient banding around the sun
> in the intro of Ori and the Will of the Wisps game on steamOS/Gamescope.
> Gamescope uses AMD predefined transfer functions for degamma,
> shaper/pre-3D-LUT and blend/post-3D-LUT plus CRTC regamma, however, only
> degamma block has hardware curves. Shaper, blend, regamma predefined TFs
> are software-computed by AMD color module into PWL LUTs. In addition, we
> cannot use hardware curves on PRE_DEGAM with subsampled format, so that,
> predefined TFs are also translated to LUTs in this situation, using
> GAMCOR block instead. For this translation, the driver originally used
> the same helper for EOTFs and inverse EOTFs, even though they differ in
> input domain, number of regions and number of TF points per region.
> 
> Baring this in mind, patch 1 maps degamma predefined curves as LUT using
> GAMCOR block for AMD driver-specific property that are still in use by
> current gamescope. This was inspired by a similar patch from Harry for
> colorop [1]. Patch 2 reverts commit 8b89acc0b2ba ("drm/amd/display:
> Remove unused cm3_helper_translate_curve_to_degamma_hw_format") to
> reintroduce cm3_helper_translate_curve_to_degamma_hw_format() and patch
> 3 wire it up for encoded -> linear-light LUTs (degamma/blend). With 16
> samples per region across 12 regions for blend LUT (where hardware
> fixed-function curves are not available and predefined TFs are
> software-computed into LUTs), banding becomes almost imperceptible.
> 
> Patch 4 and 5 increase precision in the brightest half, where PQ/SRGB
> EOTFs are steeper, by enabling up to 256 samples per region and halving
> the per-region point count across 9 regions (128 in [0.5, 1], 64 in
> [0.25, 0.5], …). This better matches the shape of PQ/SRGB EOTFs.
> Although patches 4 and 5 seem conceptually correct to me, I couldn't see
> clear improvement in the bright end with or without them.
> 
> This series targets DCN3+ hw families. With this series:
> - degamma and blend LUTs use
>   cm3_helper_translate_curve_to_degamma_hw_format(): encoded input,
>   non-zero end slope, up to 256 points linearly interpolated between
>   adjacent TF pts, fitting [0,1] encoded input range.
> - shaper and regamma LUTs continue using
>   cm3_helper_translate_curve_to_hw_format(): linear-light input, zero
>   end slope, 16 points per region across 32 regions.
> 
> [1] https://lore.kernel.org/dri-devel/20260330153451.99472-8-harry.wentland@amd.com/
> 
> [v1] https://lore.kernel.org/dri-devel/20260414220237.184289-1-mwen@igalia.com/
> Changes:
> - new patch for GAMCOR usage in case of degamma predefined TF with subsampled formats
> - fix misleading information regarding degamma hw curves (Kruno)
> - clarify LUT segmentation choice using 8-bit sRGB as a reference (Kruno)
> 
> Best Regards,
> 
> Melissa

I tested this on a DCN35 device with an internal HDR panel that was affected by the gradient issue. I cannot see any banding present with this series applied on top of amd-staging-drm-next with AMD private color properties enabled.

Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
for the series.

Thanks,
Matt

> 
> Melissa Wen (5):
>   drm/amd/display: use GAMCOR for degamma private props in subsampled
>     format
>   Revert "drm/amd/display: Remove unused
>     cm3_helper_translate_curve_to_degamma_hw_format"
>   drm/amd/display: use a separate helper to translate degamma curves
>   drm/amd/display: support up to 256 samples per region in degamma/blend
>     LUT
>   drm/amd/display: use halving distribution for PQ/sRGB linearizing LUT
> 
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  16 +-
>  .../amd/display/dc/dcn30/dcn30_cm_common.c    | 184 ++++++++++++++++++
>  .../display/dc/dwb/dcn30/dcn30_cm_common.h    |   4 +
>  .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  10 +-
>  4 files changed, 204 insertions(+), 10 deletions(-)
> 

