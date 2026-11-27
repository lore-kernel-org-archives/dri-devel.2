Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7F606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KYhhBhIn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47212112C3F;
	Fri, 27 Nov 2026 16:56:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 785DE112C25;
 Fri, 27 Nov 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795798556; x=1827334556;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HxP47Q/4l18MLX+FXiUnCCUy1o0eCQlI9UohTEgEELo=;
 b=KYhhBhInFyqO2HAk8lLrWONMLvhEhVGPkX7gsH+uKf2aQnqx661Rvi0L
 YqiWrpPbRgXTrheBqOpqUSADFOjkXsBvFEliJwISjE3Nii8vLu3cpXT3d
 P0GnxbwasQc0mrwYUAZtIppBbybNWLPNkx2dq5gnRfZmn6xLtwBtFFPf1
 BqrerH16U5S8jFTu4Jc6kgdKWFd+7sXpmgfZxUBIkrLeDl+bybQCU8Q84
 JFPUYUkUjKsF5QillYrN31RsrUhvmHJy3q7uUJ+hd/tgZp5x/tirHwKCe
 ZXfKY9QWaGGNFQTfbmhA3T/OWQrgi6BU9HGAwjv3amePQnKjC69LdVNnn w==;
X-CSE-ConnectionGUID: hHv5oGcaQrOiljYGQLaqpg==
X-CSE-MsgGUID: MJIk2LinRXak7P9dNqQeXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4732737"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4732737"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:55:55 -0800
X-CSE-ConnectionGUID: KNe7pR8HRnqqguo/ebnlRA==
X-CSE-MsgGUID: pSTJtUyVQTST6UVOqxGlhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12669283"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.172])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 08:55:54 -0800
Date: Fri, 27 Nov 2026 18:55:50 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/i915/bios: Attempt to match the VBT PnP ID
 against DisplayID first
Message-ID: <awm2FlsQeZpjZNBU@intel.com>
References: <20261124224621.6506-1-ville.syrjala@linux.intel.com>
 <20261124224621.6506-3-ville.syrjala@linux.intel.com>
 <76c590b4a6156485f96ba751b2683851871842be@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c590b4a6156485f96ba751b2683851871842be@intel.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 06:29:00PM +0200, Jani Nikula wrote:
> On Wed, 25 Nov 2026, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > The Windows driver policy appears to be now to first match the
> > VBT PnP ID against the DisplayID product ID block, and only if
> > there is no match (not even a partial one) then attempt to
> > match the against the EDID base block vendor/product ID.
> > Implement the same policy.
> >
> > We also need to implement the same weird scheme of just smashing
> > the first two bytes of the DisplayID three byte OUI into the
> > old EISA/PNPID field of the EDID defined structure. That is
> > then matched against the similar old EDID style structures in
> > the VBT.
> >
> > Smoke tested with a firmware override of EDID and VBT:
> >  [drm:get_panel_type [xe]] Panel type (VBT): 255
> >  [drm:pnpid_get_panel_type [xe]] DisplayID manufacturer name: NRA, product code: 16826, serial number: 0, year of manufacture: 2014
> >  [drm:pnpid_get_panel_type [xe]] DisplayID raw product id: ba 41 ba 41 00 00 00 00 00 18
> >  [drm:get_panel_type [xe]] Panel type (PNPID DisplayID): 3
> >  [drm:pnpid_get_panel_type [xe]] EDID manufacturer name: SDC, product code: 16826, serial number: 65441, year of manufacture: 2024
> >  [drm:pnpid_get_panel_type [xe]] EDID raw product id: 4c 83 ba 41 a1 ff 00 00 00 22
> >  [drm:get_panel_type [xe]] Panel type (fallback): 0
> >  [drm:get_panel_type [xe]] Selected panel type (PNPID DisplayID): 3
> >
> > Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8969
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_bios.c | 81 ++++++++++++++++++-----
> >  1 file changed, 63 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> > index b77d1599482a..5b0fc87e7673 100644
> > --- a/drivers/gpu/drm/i915/display/intel_bios.c
> > +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> > @@ -684,27 +684,22 @@ static int vbt_get_panel_type(struct intel_display *display,
> >  }
> >  
> >  static int pnpid_get_panel_type(struct intel_display *display,
> > -				const struct intel_bios_encoder_data *devdata,
> > -				const struct drm_edid *drm_edid, bool use_fallback)
> > +				const struct drm_edid_product_id *product_id,
> > +				const char *source)
> >  {
> >  	const struct bdb_lfp_data *data;
> >  	const struct bdb_lfp_data_ptrs *ptrs;
> > -	struct drm_edid_product_id product_id, product_id_nodate;
> > +	struct drm_edid_product_id product_id_nodate;
> >  	struct drm_printer p;
> >  	int i, best = -1;
> >  
> > -	if (!drm_edid)
> > -		return -1;
> > +	p = drm_dbg_printer(display->drm, DRM_UT_KMS, source);
> > +	drm_edid_print_product_id(&p, product_id, true);
> 
> This will now print the wrong year for DisplayID, off by 10 years.

I think in this case we actually want to print the bogus year
as is because that's also what's in the VBT. All we care about
is whether this matches something in the VBT, not whether it's
in any way correct data otherwise. The mangled OUI is also
complete nonsense outside of the VBT context.

> 
> [Unprintable words about not learning anything from Y2K.]
> 
> I'm beginning to think we should have a separate struct that's not
> __packed or serialized, which can be initialized from either EDID or
> DisplayID. And have drm_edid_print_product_id() operate on that. But
> maybe it's a bit too much for this now.
> 
> The EDID spec says the year is mandatory. The DisplayID spec says 0x00
> is a reserved value, but also contradicts itself by saying, "If the Year
> of Manufacture/Model Year field is not used, the byte would be cleared
> to all 0s."
> 
> One approach is to make drm_edid_print_product_id() treat zero week and
> year as "not specified", basically incorrectly reporting displays
> manufactured in the year 1990. And then printing product_id_nodate
> here. Possibly an acceptable compromise?
> 
> I don't know. It's a mess.
> 
> >  
> > -	drm_edid_get_product_id(drm_edid, &product_id);
> > -
> > -	product_id_nodate = product_id;
> > +	product_id_nodate = *product_id;
> >  	product_id_nodate.week_of_manufacture = 0;
> >  	product_id_nodate.year_of_manufacture = 0;
> >  
> > -	p = drm_dbg_printer(display->drm, DRM_UT_KMS, "EDID");
> > -	drm_edid_print_product_id(&p, &product_id, true);
> > -
> >  	ptrs = bdb_find_section(display, BDB_LFP_DATA_PTRS);
> >  	if (!ptrs)
> >  		return -1;
> > @@ -718,7 +713,7 @@ static int pnpid_get_panel_type(struct intel_display *display,
> >  			get_lfp_pnp_id(data, ptrs, i);
> >  
> >  		/* full match? */
> > -		if (!memcmp(vbt_id, &product_id, sizeof(*vbt_id)))
> > +		if (!memcmp(vbt_id, product_id, sizeof(*vbt_id)))
> >  			return i;
> >  
> >  		/*
> > @@ -733,6 +728,48 @@ static int pnpid_get_panel_type(struct intel_display *display,
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
> 
> Having this return a value based on whether the product id was found or
> not would indeed be useful.
> 
> > +
> > +	/*
> > +	 * Only the first two bytes of the OUI get
> > +	 * smashed into the old EISA/PNPID field, and
> > +	 * that gets matched against what's in the VBT.
> > +	 */
> > +	product_id.manufacturer_name =
> > +		cpu_to_be16((displayid_id.vendor_id[0] << 8) |
> > +			    displayid_id.vendor_id[1]);
> 
> I'll take your word for this.
> 
> Apart from the comments, everything else looks good,
> 
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> 
> > +	product_id.product_code = displayid_id.product_code;
> > +	product_id.serial_number = displayid_id.serial_number;
> > +	product_id.week_of_manufacture = displayid_id.week_of_manufacture;
> > +	product_id.year_of_manufacture = displayid_id.year_of_manufacture;
> > +
> > +	return pnpid_get_panel_type(display, &product_id, "DisplayID");
> > +}
> > +
> >  static int fallback_get_panel_type(struct intel_display *display,
> >  				   const struct intel_bios_encoder_data *devdata,
> >  				   const struct drm_edid *drm_edid, bool use_fallback)
> > @@ -743,7 +780,8 @@ static int fallback_get_panel_type(struct intel_display *display,
> >  enum panel_type {
> >  	PANEL_TYPE_OPREGION,
> >  	PANEL_TYPE_VBT,
> > -	PANEL_TYPE_PNPID,
> > +	PANEL_TYPE_PNPID_DISPLAYID,
> > +	PANEL_TYPE_PNPID_EDID,
> >  	PANEL_TYPE_FALLBACK,
> >  };
> >  
> > @@ -766,9 +804,13 @@ static int get_panel_type(struct intel_display *display,
> >  			.name = "VBT",
> >  			.get_panel_type = vbt_get_panel_type,
> >  		},
> > -		[PANEL_TYPE_PNPID] = {
> > -			.name = "PNPID",
> > -			.get_panel_type = pnpid_get_panel_type,
> > +		[PANEL_TYPE_PNPID_DISPLAYID] = {
> > +			.name = "PNPID DisplayID",
> > +			.get_panel_type = pnpid_displayid_get_panel_type,
> > +		},
> > +		[PANEL_TYPE_PNPID_EDID] = {
> > +			.name = "PNPID EDID",
> > +			.get_panel_type = pnpid_edid_get_panel_type,
> >  		},
> >  		[PANEL_TYPE_FALLBACK] = {
> >  			.name = "fallback",
> > @@ -792,8 +834,11 @@ static int get_panel_type(struct intel_display *display,
> >  	if (is_panel_type_valid(panel_types[PANEL_TYPE_OPREGION].panel_type))
> >  		i = PANEL_TYPE_OPREGION;
> >  	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
> > -		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID].panel_type))
> > -		i = PANEL_TYPE_PNPID;
> > +		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID_DISPLAYID].panel_type))
> > +		i = PANEL_TYPE_PNPID_DISPLAYID;
> > +	else if (is_panel_type_pnp(panel_types[PANEL_TYPE_VBT].panel_type) &&
> > +		 is_panel_type_valid(panel_types[PANEL_TYPE_PNPID_EDID].panel_type))
> > +		i = PANEL_TYPE_PNPID_EDID;
> >  	else if (is_panel_type_valid(panel_types[PANEL_TYPE_VBT].panel_type))
> >  		i = PANEL_TYPE_VBT;
> >  	else
> 
> -- 
> Jani Nikula, Intel

-- 
Ville Syrjälä
Intel
