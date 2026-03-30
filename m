Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1935B1061B20
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7389010E69E;
	Mon, 30 Mar 2026 19:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ysrf6P/X";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9AAC10E64B;
 Mon, 30 Mar 2026 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774899633; x=1806435633;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OibO0t2JHGSlFvW/svLrXqyNgoskVagFwZ2l+ypwWtg=;
 b=Ysrf6P/Xy+qpMOXHj0M9SqEFJfCLf1LswjQH0c5Yvh1PrvQtc7HXN4B9
 Nlzkl27wD2dj/EH0SMRUAHKVlTTS+VsIoxb9V+sSdH3BSCOvM0EhnLmzs
 bCzt9rMaeaoJFSQGN6TbncF+3SziZePdhA9FkKNA9n/8i57DuvU0nkIes
 IrdN9ZrlJWVBi/Dwv56EWuEwKGVDzKNWA7T7xoQrO7jgzevGwwyxmxjpf
 SjvRj83OaehYTVuLun0B8M0+hDA2EgeodBcSYU5SH2mOl97XMUK5a+hkF
 p3R/SHYcKvaWFrY1P6Y2hHyxA3YhJorV84Rio9PVdtcN9LFTnyn/Gpd7B Q==;
X-CSE-ConnectionGUID: WbU1Kej4SiS7Zhi6k+FPUQ==
X-CSE-MsgGUID: Y8s7CrQZRK2WlsWYS9vxCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93485350"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="93485350"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 12:40:32 -0700
X-CSE-ConnectionGUID: wBzn6x4ATpmmKDP+faegRQ==
X-CSE-MsgGUID: EU/j9LwkRJ++L9pqobWBag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="221283018"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.155])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 12:40:30 -0700
Date: Mon, 30 Mar 2026 22:40:27 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jouni.hogander@intel.com,
 animesh.manna@intel.com
Subject: Re: [PATCH 08/19] drm/i915/dp: Add a helper to decide if AS SDP can
 be used
Message-ID: <acrRq22jrzvdnwBL@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
 <20260330040656.4116502-9-ankit.k.nautiyal@intel.com>
 <acq_Nix_LJQYmQHq@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acq_Nix_LJQYmQHq@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Mon, Mar 30, 2026 at 09:21:42PM +0300, Ville Syrjälä wrote:
> On Mon, Mar 30, 2026 at 09:36:45AM +0530, Ankit Nautiyal wrote:
> > Add a helper that determines whether AS SDP can be used for the
> > current DP configuration. For now this is true only when the sink
> > supports AS SDP and VRR is enabled, but more conditions may be added
> > later.
> > 
> > Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> > index 499850c2abcf..7ca3f9d583db 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> > @@ -3124,6 +3124,15 @@ static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state *crtc
> >  	vsc->content_type = DP_CONTENT_TYPE_NOT_DEFINED;
> >  }
> >  
> > +static bool intel_dp_can_use_as_sdp(struct intel_dp *intel_dp,
> > +				    struct intel_crtc_state *crtc_state)

Hmm. Maybe the name should be .._need_as_sdp() or something like that
instead. I can imagine many cases when we could use the AS SDP but don't
have to.

> > +{
> > +	if (!intel_dp->as_sdp_supported)
> > +		return false;
> > +
> 
> Could have a FIXME here about fastset being borked with this. Didn't
> read far enough in the series yet to see if you did anything about that.
> 
> Either way
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> > +	return crtc_state->vrr.enable;
> > +}
> > +
> >  static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
> >  				    struct intel_crtc_state *crtc_state)
> >  {
> > @@ -3131,7 +3140,7 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
> >  	const struct drm_display_mode *adjusted_mode =
> >  		&crtc_state->hw.adjusted_mode;
> >  
> > -	if (!crtc_state->vrr.enable || !intel_dp->as_sdp_supported)
> > +	if (!intel_dp_can_use_as_sdp(intel_dp, crtc_state))
> >  		return;
> >  
> >  	crtc_state->infoframes.enable |= intel_hdmi_infoframe_enable(DP_SDP_ADAPTIVE_SYNC);
> > -- 
> > 2.45.2
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Ville Syrjälä
Intel
