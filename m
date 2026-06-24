Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9AECDB470
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300C710E04F;
	Wed, 24 Jun 2026 08:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VKx7MHsL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0728D10E04F
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782288363; x=1813824363;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version; bh=STIShcwIg7UvH80ThNShJdyT5uz0v79UPIWeULPku1E=;
 b=VKx7MHsLK7e/21/R0aEs0qyCbd7MbQOAPhxFD8a5qrn79Qj3rrH2ynvi
 /XBNMhHVLR0ZbblgKZGPCNxm2d1E6XAvtuDY+wgj+sEp0jthviasIndp+
 3CavZwXZGKfN2KfxgfQCEqynBTpBYFdoHcZ6GUbwHpx+mCErmomLiQvY7
 cmkEyD3NPhk2LRiQ83IXwrmx6YxjSPEXwAVQK+diCF2ycuNcX7LCD4PRf
 g+bgvSErDA3XZsI3B4OeP88H2gDjtaqx4ArCC1DPbuwfrLq+fB+O137u0
 Q/U4d5ojapkZeb+PbnDdu7KUo3c2xUbV49k7dndwZpBRn2uhh3i+mKM+l w==;
X-CSE-ConnectionGUID: 5MGjB6XYTrKH9bE5bHGfpQ==
X-CSE-MsgGUID: 7JOe5wUOSJqsVsI3t+QvtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83093249"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="83093249"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 01:06:03 -0700
X-CSE-ConnectionGUID: pLKmkdFFTMilPWjvuf/MsA==
X-CSE-MsgGUID: pzDM3EXdSp2Bo5xZERJobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="245631290"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.187])
 by fmviesa010-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 01:06:01 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Naveed Khan <naveed@digiscrypt.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/edid: check DisplayID tiled block length before
 parsing
In-Reply-To: <178223524141.58041.12138826976759023373@digiscrypt.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <178223524141.58041.12138826976759023373@digiscrypt.com>
Date: Wed, 24 Jun 2026 11:05:59 +0300
Message-ID: <3bf6abb4dfd22771b3774f22a4be9b7f647668fe@intel.com>
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

On Tue, 23 Jun 2026, Naveed Khan <naveed@digiscrypt.com> wrote:
> drm_parse_tiled_block() casts the generic DisplayID data block to
> struct displayid_tiled_block and unconditionally reads the whole
> fixed-size structure (tile_cap, topo[3], tile_size[4],
> tile_pixel_bezel[5] and the 8-byte topology_id), but it never looks at
> block->num_bytes.
>
> The DisplayID iterator in displayid_iter_block() only guarantees that the
> block's *declared* length, sizeof(struct displayid_block) + num_bytes,
> fits inside the section. A DisplayID extension that declares a tiled
> display block (tag DATA_BLOCK_TILED_DISPLAY) with a num_bytes smaller than
> the structure payload is therefore happily handed to the parser, which
> then reads past the declared block. When such a block is placed near the
> end of the last DisplayID EDID extension, the over-read runs past the end
> of the EDID allocation - an out-of-bounds read controlled entirely by the
> contents of the EDID.
>
> Reject tiled blocks that are too short to hold the structure, mirroring
> the size check already done for the VESA vendor block in
> drm_parse_vesa_mso_data().

Already fixed by commit faaa1e115583 ("drm/edid: fix OOB read in
drm_parse_tiled_block()").

BR,
Jani.

>
> Signed-off-by: Naveed Khan <naveed@digiscrypt.com>
> ---
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 404208bf23..b4298012eb 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_connector *connector,
>  	u8 num_v_tile, num_h_tile;
>  	struct drm_tile_group *tg;
>  
> +	if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] Invalid tiled display block size %u\n",
> +			    connector->base.id, connector->name, block->num_bytes);
> +		return;
> +	}
> +
>  	w = tile->tile_size[0] | tile->tile_size[1] << 8;
>  	h = tile->tile_size[2] | tile->tile_size[3] << 8;

-- 
Jani Nikula, Intel
