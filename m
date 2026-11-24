Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CE606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jGa4hhVB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023C410ED03;
	Tue, 24 Nov 2026 23:06:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FBB10E182;
 Tue, 24 Nov 2026 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795561611; x=1827097611;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=joly/PEpSexe3n7x+ZVnxoWAU4gCOVp+X6ms+eCoo6s=;
 b=jGa4hhVBVVzbm/tTptKuyzU+1NBufQst2ZlpZT8wyZMYJSDnOxSZ9q8Y
 9RwcMDKiM1xq21gxN+1f7jxOGmTA6R6yJbvIhM5AgDOdXEeTTbA6c4yVf
 mOWuo9TJyezJ24ixDL80BdP1NVB7jr5HlK0WlzhO1o4/AZe43mC+xflHN
 cz/yi21N/Czd86JrmumcjNBSW66AOSbAJQEjaSn5dJkyf8Pl1dYoQ3tdD
 I4vydyfIhc+1zqIQt2vfMg1RTKEJwdF53TTBxbSd7BZd/TsjewWPQ4gT1
 IL0voPkh1aV1I7M0unx3KdpwQvXYuwVe5XEk3W9ihN3Y28g/FpulxG7Ad g==;
X-CSE-ConnectionGUID: VxQdlXKRTH6iKQWs1i1szA==
X-CSE-MsgGUID: ZZkUju87QSO7GUBqDeBjUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4300169"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4300169"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 15:06:42 -0800
X-CSE-ConnectionGUID: TaZWj348RgKc86l050bjMQ==
X-CSE-MsgGUID: te1MJFr0TbGUuANaGKnzQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11988602"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.204])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 15:06:40 -0800
Date: Wed, 25 Nov 2026 01:06:36 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/i915/bios: Attempt to match the VBT PnP ID
 against DisplayID first
Message-ID: <awYYfMeH42kZGZh-@intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
 <20261124224621.6506-3-ville.syrjala@linux.intel.com>
 <sashiko-outbox-232179@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-232179@kernel.org>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 10:56:48PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/i915/bios: false VBT match in
>   pnpid_displayid_get_panel_type()
> --
> 
> commit b621730b3ac12390341a723bfb91f30971b56f98
> Author: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> drm/i915/bios: Attempt to match the VBT PnP ID against DisplayID first
> 
> This commit attempts to match the VBT PnP ID against the DisplayID product ID
> block before falling back to the base EDID vendor/product ID.
> 
> > diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> > index 7b6a6f8c3cf19..8fbabf2e8b6f8 100644
> > --- a/drivers/gpu/drm/i915/display/intel_bios.c
> > +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> [ ... ]
> > @@ -732,6 +727,48 @@ static int pnpid_get_panel_type(struct intel_display *display,
> >  	return best;
> >  }
> >  
> > +static int pnpid_edid_get_panel_type(struct intel_display *display,
> > +				     const struct intel_bios_encoder_data *devdata,
> > +				     const struct drm_edid *drm_edid, bool use_fallback)
> > +{
> > +	struct drm_edid_product_id product_id;
> > +
> > +	if (!drm_edid)
> > +		return -1;
> > +
> > +	drm_edid_get_product_id(drm_edid, &product_id);
> > +
> > +	return pnpid_get_panel_type(display, &product_id, "EDID");
> > +}
> > +
> > +static int pnpid_displayid_get_panel_type(struct intel_display *display,
> > +					  const struct intel_bios_encoder_data *devdata,
> > +					  const struct drm_edid *drm_edid, bool use_fallback)
> > +{
> > +	struct drm_displayid_product_id displayid_id;
> > +	struct drm_edid_product_id product_id;
> > +
> > +	if (!drm_edid)
> > +		return -1;
> > +
> > +	drm_displayid_get_product_id(drm_edid, &displayid_id);
> > +
> > +	/*
> > +	 * Only the first two bytes of the OUI get
> > +	 * smashed into the old EISA/PNPID field, and
> > +	 * that gets matched against what's in the VBT.
> > +	 */
> > +	product_id.manufacturer_name =
> > +		cpu_to_be16((displayid_id.vendor_id[0] << 8) |
> > +			    displayid_id.vendor_id[1]);
> > +	product_id.product_code = displayid_id.product_code;
> > +	product_id.serial_number = displayid_id.serial_number;
> > +	product_id.week_of_manufacture = displayid_id.week_of_manufacture;
> > +	product_id.year_of_manufacture = displayid_id.year_of_manufacture;
> > +
> > +	return pnpid_get_panel_type(display, &product_id, "DisplayID");
> > +}
> 
> [Severity: High]
> Can pnpid_displayid_get_panel_type() falsely match an unpopulated VBT PnP ID
> entry when the EDID has no DisplayID Product ID block?

I don't think we've ever seen an all zeroes pnpid in the VBT. But I
suppose I should have drm_displayid_get_product_id() return whether
it found something. It would at least prevent pnpid_get_panel_type()
from printing the all zeroes product ID into the log.

> 
> drm_displayid_get_product_id() zeroes displayid_id up front and leaves it
> zero-filled if no DisplayID Product ID block is present. Passing the resulting
> all-zero product_id into pnpid_get_panel_type() will match the first unused
> (all-zero) slot among the 16 entries in BDB_LFP_DATA, causing get_panel_type()
> to select that unpopulated VBT panel index via PANEL_TYPE_PNPID_DISPLAYID
> instead of falling back to PANEL_TYPE_PNPID_EDID.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261124224621.6506-2-ville.syrjala@linux.intel.com?part=2

-- 
Ville Syrjälä
Intel
