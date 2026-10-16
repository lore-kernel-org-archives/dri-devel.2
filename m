Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC924CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150C810E1C0;
	Fri, 16 Oct 2026 11:54:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DB9010E1C0;
 Fri, 16 Oct 2026 11:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792151676; x=1823687676;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8s+27W1oOkXwILqN2uB0760lu1sodKRNQB/0lxQfADs=;
 b=kSBBSvY/r2KdqbNYO7rlEz2QnPicg3rNdRBASxjHMqT4FgOuv9/i/RN2
 tIRioym+sRq9ddY+lqfbRv+i1hEjcoHigIBK/UVAGNCaf2iit3wTbUxQv
 wYEbB/KVxScAznUdXrTZJ1Di4L8aZ92QdvY6NAXpEZ0kaxlehKBvPC2A0
 8bGlj0pBLKi7VLZw6Piy2GZKLxpCodJYNQBhZ7ANVhCSUxcAtk7sF1TGc
 w+8x2aN7O3fDEBifz8Nqi1BZnUdbRKsbp2AFYG5WwDVkU54qlb6mn9i8C
 9ZbtCM8wnljHI4ByIc/P8u+3QUme3F0AuSJH/Lg+210bc/xb9c3pyqVwR g==;
X-CSE-ConnectionGUID: 9m6O0R/fSoiVMMcBSYublg==
X-CSE-MsgGUID: vKZu/Uv8SPSIkXU9tqd0Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="937696"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="937696"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:54:36 -0700
X-CSE-ConnectionGUID: PV+MM3THTQOBptn1cMx+kw==
X-CSE-MsgGUID: uA9jmqNUQomWf8nwt62l0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2310171"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.56])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 04:52:57 -0700
Date: Fri, 16 Oct 2026 14:52:53 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hanson Wang <hanson.wang@ugreen.com>
Cc: intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 tursulin@ursulin.net, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH i915] drm/i915/bw: Ignore inactive CRTCs in bandwidth
 calculation
Message-ID: <atIQFRHdf3uofLHM@intel.com>
References: <20261016014704.3876294-1-hanson.wang@ugreen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016014704.3876294-1-hanson.wang@ugreen.com>
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

On Fri, Oct 16, 2026 at 09:47:04AM +0800, Hanson Wang wrote:
> The per-CRTC bandwidth helpers use cached active_planes and data_rate
> values without checking whether the CRTC is active. During hardware
> state readout an inactive CRTC may retain stale plane state, causing
> intel_bw_state to account phantom bandwidth.
> 
> This can leave bandwidth and an active plane accounted after an HDMI
> disconnect and make the QGV check reject otherwise valid atomic commits.

Shouldn't happen. If the CRTC gets disabled it no longer counts. Are you
leaving the CRTC logically enabled but inactive (enable==true &&
active==false)? That we still want to count because 
'enable==true && active==false -> enable==true && active==true'
transition should never fail.

> 
> Return zero from both helpers for inactive CRTCs so hardware readout
> and atomic checks cannot propagate stale bandwidth.
> 
> Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
> ---
>  drivers/gpu/drm/i915/display/intel_bw.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
> index ac6da20d9..62d9ae416 100644
> --- a/drivers/gpu/drm/i915/display/intel_bw.c
> +++ b/drivers/gpu/drm/i915/display/intel_bw.c
> @@ -838,6 +838,9 @@ void intel_bw_init_hw(struct intel_display *display)
>  
>  static unsigned int intel_bw_crtc_num_active_planes(const struct intel_crtc_state *crtc_state)
>  {
> +	if (!crtc_state->hw.active)
> +		return 0;
> +
>  	/*
>  	 * We assume cursors are small enough
>  	 * to not not cause bandwidth problems.
> @@ -852,6 +855,9 @@ static unsigned int intel_bw_crtc_data_rate(const struct intel_crtc_state *crtc_
>  	unsigned int data_rate = 0;
>  	enum plane_id plane_id;
>  
> +	if (!crtc_state->hw.active)
> +		return 0;
> +
>  	for_each_plane_id_on_crtc(crtc, plane_id) {
>  		/*
>  		 * We assume cursors are small enough
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel
