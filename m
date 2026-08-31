Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904F9C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBB9010E2A1;
	Mon, 31 Aug 2026 13:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="a5mefDxP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40B810E2A1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788182005; x=1819718005;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=gGkEA30qAcCS836tsqMXLUUo1XiCVXjdP7PDl+1MtCU=;
 b=a5mefDxP3mN5oOJFjrdDTxMkUchR67URR5Eidk6Ewk0e8bJJkOewz/UL
 VFAbPKVe72uzqJEDaKJASx1DJVtmvvRs3k6QRxJF10WurOLOpOhYJ59Gi
 Enff18zpZjyfrzy2AqxY0W0xZlkxwx/8s2RKJkdkoK/a8RGaOo+gdERqV
 tp8veTn8pF6AI2I4vLQuRyCKvRubW3ZOFvJ8rpVyK2fgs08qTrdcPHMHQ
 k8qyhiZGmFwlQobota7If+PbArbCU6CeuL96eYGNBaYwdzAvhXS6QjjfC
 8NuLQ7/oJ0zLxZUNDH4Gpz5ube8ahuBB7StQw1coAM2hO9pVg+vSydAon Q==;
X-CSE-ConnectionGUID: ea87Ode3S+emsT5zo7/Trg==
X-CSE-MsgGUID: AiPrGp5lR/WszutkRKkZIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="92398762"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="92398762"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:13:25 -0700
X-CSE-ConnectionGUID: gVgP45ggTjaAvHNEXWl+jA==
X-CSE-MsgGUID: 8orwyznRR8+/stM/ePNwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="293624396"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 06:13:21 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 ardb@kernel.org, ilias.apalodimas@linaro.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 2/3] drm/edid: Add drm_edid_get_preferred_size()
In-Reply-To: <20260831093020.494701-3-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260831093020.494701-1-tzimmermann@suse.de>
 <20260831093020.494701-3-tzimmermann@suse.de>
Date: Mon, 31 Aug 2026 16:13:19 +0300
Message-ID: <f5f1ab9e6fab9499e49f116369858ee4da626025@intel.com>
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

On Mon, 31 Aug 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Add drm_edid_get_preferred_size() to extract the panel's preferred
> display resolution from a given EDID. Required for DRM's panel
> orientation quirks.
>
> v2:
> - handle EDID without pixel timing descriptor (Sashiko)
> - fix checks for width and height pointers
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/gpu/drm/drm_edid.c | 46 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_edid.h     |  2 ++
>  2 files changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 9990a836d0b6..53c7eed7a73e 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2872,6 +2872,52 @@ u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
>  }
>  EXPORT_SYMBOL(drm_edid_get_panel_id);
>  
> +/**
> + * drm_edid_get_preferred_size - Get a panel's preferred size from EDID
> + * @drm_edid: EDID that contains panel ID.
> + * @width: Returns the panel's width in pixels per scanline, if given
> + * @height: Returns the panel's height in scanlines, if given
> + *
> + * This function detects the preferred size of a panel from the given
> + * EDID. There is no such information stored in the EDID block directly,
> + * but the preferred mode often corresponds to the panel's native geometry.

I think the special use case for this function should be mentioned. In
the regular EDID parsing case, the connector will include the modes, one
of them will be preferred, and that should be, uh, preferred.

I dislike adding multiple functions for parsing the same thing, but
looks like it can't be helped here. Let's at least avoid adding users
for this in the paths that can use the normal stuff?

> + *
> + * Return: Zero on success, or a negative errno code otherwise.
> + */
> +int drm_edid_get_preferred_size(const struct drm_edid *drm_edid,
> +				unsigned int *width, unsigned int *height)
> +{
> +	const struct edid *edid = drm_edid->edid;
> +	const struct detailed_timing *dt;
> +	const struct detailed_pixel_timing *pt;
> +
> +	if (drm_edid->size < EDID_LENGTH)
> +		return -EINVAL;

This is guaranteed. drm_edid_alloc() intentionally won't hand you out a
struct drm_edid with size smaller than EDID_LENGTH. Maybe check for
!drm_edid instead.

> +
> +	/*
> +	 * Use display mode from the Preferred Timing Descriptor. For old
> +	 * and obscure displays, we might need better heuristics.
> +	 */
> +
> +	if (edid->revision < 4 && !(edid->features & DRM_EDID_FEATURE_PREFERRED_TIMING))

The preferred timing mode should always be there starting from EDID
1.3. The bit doesn't indicate whether it's there or not. It should be
always set for EDID 1.3, and for EDID 1.4 it indicates whether the
preferred timing includes the native pixel format and the preferred
refresh rate.

I think just if (edid->revision < 3) should be enough.

> +		return -EINVAL; /* no Preferred Timing Descriptor */
> +
> +	dt = &edid->detailed_timings[0];
> +
> +	if (!le16_to_cpu(dt->pixel_clock))

There's is_detailed_timing_descriptor() for this.

> +		return -EINVAL;
> +
> +	pt = &dt->data.pixel_data;
> +
> +	if (width)
> +		*width = (pt->hactive_hblank_hi & 0xf0) << 4 | pt->hactive_lo;
> +	if (height)
> +		*height = (pt->vactive_vblank_hi & 0xf0) << 4 | pt->vactive_lo;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_edid_get_preferred_size);
> +
>  /**
>   * drm_edid_read_base_block - Get a panel's EDID base block
>   * @adapter: I2C adapter to use for DDC
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 04f7a7f1f108..981aeeb6ddf9 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -487,6 +487,8 @@ void drm_edid_get_product_id(const struct drm_edid *drm_edid,
>  void drm_edid_print_product_id(struct drm_printer *p,
>  			       const struct drm_edid_product_id *id, bool raw);
>  u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
> +int drm_edid_get_preferred_size(const struct drm_edid *drm_edid,
> +				unsigned int *width, unsigned int *height);
>  bool drm_edid_match(const struct drm_edid *drm_edid,
>  		    const struct drm_edid_ident *ident);
>  bool drm_edid_has_quirk(struct drm_connector *connector, enum drm_edid_quirk quirk);

-- 
Jani Nikula, Intel
