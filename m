Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B253EC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 05:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DF310E168;
	Tue, 30 Jun 2026 05:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="isEtJ/Sx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09B8010E13A;
 Tue, 30 Jun 2026 05:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782796821; x=1814332821;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Kr/YG75jknEBGygfbdZbiLsmWOHsghWO/YAbsUOCBnA=;
 b=isEtJ/SxG2viFRDptx17SepD3Rb2J9PvUbI+lBZi10lVAaV1pv2JKiet
 tdTBp6eUVZ+RQWe/XPBV7qXechVbTZyD3/lq9b1lBfZkPhVV42RXKl00h
 CF6QEYA1E3YSNH7d/XUYNI/tNGXU0Qqc0V9uGA7bWZwXagb8TQlR5VtRx
 tFRSf/Wvhfl+OA7831WVjlB+qtn/s/933N4XHmjS1x4s3ejcYm4HUGpyI
 tf0vi83KMi1vpikHlK8tfs6lkRj8ibnrUgmAirqoVgKYQ4NsnrJLB91hi
 WyHydtrrEZiLR8J2oh/bYAPixbbpDWpZP2if2UI6V7nC3W0w6n+UjQgZI w==;
X-CSE-ConnectionGUID: HC3XzVZdRee+VniCNG+rCg==
X-CSE-MsgGUID: w2KQX7ETQ+yPkFxewxqwTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94883791"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="94883791"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 22:20:20 -0700
X-CSE-ConnectionGUID: t9Hv/DrSRa6tVdNCttLtrQ==
X-CSE-MsgGUID: UHByy7OvTc6B1DVHvZlakg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; d="scan'208";a="252305245"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 22:20:16 -0700
Date: Tue, 30 Jun 2026 07:20:13 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Riana Tauro <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, aravind.iddamsetty@linux.intel.com,
 anshuman.gupta@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 maarten.lankhorst@linux.intel.com, mallesh.koujalagi@intel.com,
 soham.purkait@intel.com
Subject: Re: [PATCH v3 3/3] drm/xe/xe_ras: Add error-event support for CRI
Message-ID: <akNSDXcXa0mtwR5r@black.igk.intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
 <20260622101716.3313496-8-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622101716.3313496-8-riana.tauro@intel.com>
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

On Mon, Jun 22, 2026 at 03:47:20PM +0530, Riana Tauro wrote:
> Add error-event support for Correctable errors in CRI.
> error-event is reported to  userspace for all errors that crossed
> threshold on receiving an interrupt for correctable errors.

...

> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> +{
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	drm_severity = xe_to_drm_ras_severity(severity);
> +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX)
> +		return;
> +
> +	drm_component = xe_to_drm_ras_component(component);
> +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX)
> +		return;
> +
> +	ret = xe_ras_get_counter(xe, severity, component, &value);
> +	if (ret)
> +		return;
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
> +}
> +
>  void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  				      struct xe_sysctrl_event_response *response)
>  {
> @@ -152,6 +203,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  		severity = errors[id].common.severity;
>  		component = errors[id].common.component;
>  
> +		ras_send_error_event(xe, severity, component);

We already have error-value as part of the event, so this looks like
a lot of redundant duplicate events if threshold is set high enough.
I'm wondering if we use a local variable as a bitmap for components
(which we set here) and only send event for_each_set_bit() after the
loop?

Raag

>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
>  	}
> -- 
> 2.47.1
> 
