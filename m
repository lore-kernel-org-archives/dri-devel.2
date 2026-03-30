Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460FCFF494F
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:35:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9318E10E429;
	Mon, 30 Mar 2026 12:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Cbt3+pDk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80C710E351;
 Mon, 30 Mar 2026 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774874127; x=1806410127;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=f3gehPB0baWMsE94qq83+j/x1pGTFfqcJ8zA6oiLevA=;
 b=Cbt3+pDkR9bY6aLOO7JTaqWkqzt8156xh3MnAGJRKUhdrci9EnJNrqJ8
 LRP9u76HeNR7C1MO4BEbIkrshI7f65AYaKrYBPd2YYbO1nRe3kpCPkaek
 Z4BfDHgt10yb4H4AcfE+Su0ap9CI+fDvzJcZI3rcCA193i9MhkgEUDDq7
 o5pCptDb7BczFRBO9VOkHh8ocNw7AXqFW+akrTzLLctzrBhkFdR/VhxTS
 IuSKUamNyFUohVFfabPiCFWeNl2cap3uEdIZF35D07jzCBRy/J6N7dIkN
 DGnLuI+c+Quq5ykkbDZFJ5ghbhLFuSNFhn+3j9yrylvNwVEA9O9yOcl4X Q==;
X-CSE-ConnectionGUID: SbtNN5R3StKx/asaBVHoSw==
X-CSE-MsgGUID: M+1q85frRNWM7VZu+LDzmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76056419"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="76056419"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 05:35:26 -0700
X-CSE-ConnectionGUID: PAPG+5foRL2l1ELzp5SDvA==
X-CSE-MsgGUID: 4suED2TzROioJd8hEvSNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="227661086"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.246.17])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 05:35:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Adriano Vero <litaliano00.contact@gmail.com>,
 dri-devel@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, Adriano Vero
 <litaliano00.contact@gmail.com>
Subject: Re: [PATCH 1/2] drm/edid: populate monitor_range from DisplayID
 Dynamic Video Timing block
In-Reply-To: <20260328132027.22383-1-litaliano00.contact@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260328132027.22383-1-litaliano00.contact@gmail.com>
Date: Mon, 30 Mar 2026 15:35:20 +0300
Message-ID: <c207468b57c7c1367169e796d50626fc8f07dbd7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, 28 Mar 2026, Adriano Vero <litaliano00.contact@gmail.com> wrote:
> Some eDP panels report their VRR limits only via a DisplayID v1r2
> Dynamic Video Timing Range Limits block (tag 0x25), without setting

That's a contradiction right there. DisplayID v1r2 does not have tag
0x25. DisplayID v2r0 does. All the DATA_BLOCK_2_* are only defined for
v2r0.

> DRM_EDID_FEATURE_CONTINUOUS_FREQ. drm_get_monitor_range() returns
> early for such panels, leaving monitor_range zeroed.
>
> Add drm_get_monitor_range_displayid() and call it from
> update_display_info() immediately after drm_get_monitor_range(). It
> uses displayid_iter_edid_begin() to locate Dynamic Video Timing blocks
> and extracts min/max refresh rates, including the 10-bit max_vfreq
> encoding signalled by block->rev bits [2:0]. It is a no-op when
> monitor_range is already populated by the classic EDID path.
>
> All drivers reading display_info.monitor_range now receive correct VRR
> limits from DisplayID-only panels without any raw EDID access.
>
> Byte offsets verified against parse_edid_displayid_vrr() in amdgpu_dm.c.
>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 68 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ff432ac6b..d2c360178 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6504,6 +6504,71 @@ void get_monitor_range(const struct detailed_timing *timing, void *c)
>  	}
>  }
>  
> +/**
> + * drm_get_monitor_range_displayid - populate monitor_range from a

Please no kernel-doc for static functions here.

> + * DisplayID v1r2 Dynamic Video Timing Range Limits block (tag 0x25).
> + *
> + * Some eDP panels report their VRR limits only in a DisplayID block,
> + * without setting DRM_EDID_FEATURE_CONTINUOUS_FREQ. drm_get_monitor_range()
> + * returns early for such panels, leaving monitor_range zeroed. This
> + * function is called separately from update_display_info() as a fallback.

Useless info. Please don't repeat what's obvious from the code.

> + *
> + * Block payload layout (block->num_bytes == 9):
> + *   data[6]       min_vfreq in Hz
> + *   data[7]       max_vfreq low 8 bits
> + *   data[8][1:0]  max_vfreq high bits (when block->rev & 7 is nonzero)
> + *
> + * Byte offsets verified against parse_edid_displayid_vrr() in amdgpu_dm.c.

Useless info.

> + */
> +static void
> +drm_get_monitor_range_displayid(struct drm_connector *connector,
> +				const struct drm_edid *drm_edid)
> +{
> +	struct drm_display_info *info = &connector->display_info;
> +	const struct displayid_block *block;
> +	struct displayid_iter iter;
> +
> +	/* Only run when the classic EDID path left these zeroed */
> +	if (info->monitor_range.min_vfreq && info->monitor_range.max_vfreq)
> +		return;
> +
> +	displayid_iter_edid_begin(drm_edid, &iter);
> +	displayid_iter_for_each(block, &iter) {
> +		const u8 *data;
> +		u16 min_vfreq, max_vfreq;
> +
> +		if (block->tag != DATA_BLOCK_2_DYNAMIC_VIDEO_TIMING)
> +			continue;

It would be pedantically correct to also check the
displayid_version(). See displayid_is_tiled_block() for an example.

> +
> +		/* rev bits [7:1] must be zero; payload must be exactly 9 bytes */

I can see all of that from the code. The comment doesn't add anything
helpful. If it explained why, it would go a long way.

> +		if ((block->rev & 0xFE) != 0 || block->num_bytes != 9)
> +			continue;
> +
> +		data = (const u8 *)(block + 1);
> +
> +		min_vfreq = data[6];
> +
> +		/* rev bits [2:0] nonzero: max_vfreq is 10-bit */
> +		if (block->rev & 7)
> +			max_vfreq = data[7] | ((u16)(data[8] & 3) << 8);
> +		else
> +			max_vfreq = data[7];

You might as well add a __packed struct for the data, similar to struct
displayid_tiled_block, to help parsing.

> +
> +		if (!min_vfreq || !max_vfreq)
> +			continue;
> +
> +		info->monitor_range.min_vfreq = min_vfreq;
> +		info->monitor_range.max_vfreq = max_vfreq;
> +
> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] DisplayID dynamic video timing range: %u-%u Hz\n",
> +			    connector->base.id, connector->name,
> +			    min_vfreq, max_vfreq);

So I'd like all of the above to be in the form:

		if (displayid_is_dynamic_video_timing_block(...))
			displayid_parse_dynamic_video_timing_block(...);

Or something similar. Again, see displayid_is_tiled_block() and its use.

The main point is that I think we should group these displayid_iter*
blocks together more, iterating fewer times and handling all blocks at
once. Note that I'm *not* asking you to do that here, but separating the
parsing from the looping goes a long way in doing that in the future.

BR,
Jani.

> +		break;
> +	}
> +	displayid_iter_end(&iter);
> +}
> +
>  static void drm_get_monitor_range(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> @@ -6691,10 +6756,9 @@ static void update_display_info(struct drm_connector *connector,
>  	info->height_mm = edid->height_cm * 10;
>  
>  	drm_get_monitor_range(connector, drm_edid);
> -
> +	drm_get_monitor_range_displayid(connector, drm_edid);

This is way too early. Somewhere near drm_update_mso() call is much
better.

>  	if (edid->revision < 3)
>  		goto out;
> -
>  	if (!drm_edid_is_digital(drm_edid))
>  		goto out;

-- 
Jani Nikula, Intel
