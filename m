Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE830C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD28210F4BB;
	Thu,  9 Jul 2026 10:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CzVKGG4H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 078DA10F462;
 Thu,  9 Jul 2026 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783591450; x=1815127450;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ifXbCxYpUjHu59OiIIZZCt4wGRbPAoNS773qHevYFm0=;
 b=CzVKGG4HaUJso/XWxJc4OEmm8hH8elWq+H5lBeQxa2wxPXgrdRhEjC8u
 9rE3ohXFJGk3eNO2J3iFU93gNc736pbRq2v4ULZzPSlklqRAUGlGrJq+o
 ILoKSD6oP1j3vtUse/5f82cAKFeXQzv82oXzJsxkp0GhF2VNZAF5IJ7du
 Ws2lRnxbpbR5cbiLldKXs0hiY1W8kHsdSZPbBppJeem+/Osh/wUlF9+ye
 LsUPcRW6yeCsriHyXHM/iifLYLkLoD+uIfy8s73kk3+wSA0kjaZBJWvDD
 QgTOowRaP1kELXoL/ilRMMpAdAvB250euXZyurmNonr5D0JaMnMy692+d A==;
X-CSE-ConnectionGUID: ouxggHshSXKHWS7MzBGwlA==
X-CSE-MsgGUID: Ug4osmDpQEmBxQfTZadJGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101815711"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101815711"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:04:09 -0700
X-CSE-ConnectionGUID: 8qbiF+8CQ5+VdNnlVzpgpA==
X-CSE-MsgGUID: 9cJlt2YKT8eEZeCyv8fSqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="250137721"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 03:04:06 -0700
Date: Thu, 9 Jul 2026 12:04:03 +0200
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
 soham.purkait@intel.com, Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v4 3/3] drm/xe/xe_ras: Add error-event support for CRI
Message-ID: <ak9yEyDF_tlJe-Rx@black.igk.intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-8-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701094409.129131-8-riana.tauro@intel.com>
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

On Wed, Jul 01, 2026 at 03:14:13PM +0530, Riana Tauro wrote:
> Add error-event support for Correctable errors in CRI. Report an error
> event to userspace for every component that has crossed the threshold on
> receiving an interrupt.

...

> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> +{
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	drm_severity = xe_to_drm_ras_severity(severity);
> +	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX) {
> +		xe_warn(xe, "sysctrl: unexpected severity %u\n", severity);

This is uapi and not coming from sysctrl, so the message is a bit
misleading. But if at all it needs validation, it should be done in
drm_ras layer.

> +		return;
> +	}
> +
> +	drm_component = xe_to_drm_ras_component(component);
> +	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX) {
> +		xe_warn(xe, "sysctrl: unexpected component %u\n", component);

Ditto.

> +		return;
> +	}
> +
> +	ret = xe_ras_get_counter(xe, drm_severity, drm_component, &value);

No, instead of converting back and forth just do get_counter() using
sysctrl values and send_event() afterwards.

> +	if (ret)
> +		return;
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
> +}
> +
>  void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  				      struct xe_sysctrl_event_response *response)
>  {
>  	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
>  	struct xe_ras_error_class *errors = pending->counters;
>  	u32 id, ncounters = pending->ncounters;
> +	u8 sent = 0;
>  
>  	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
> +	BUILD_BUG_ON(XE_RAS_COMP_MAX > (BITS_PER_BYTE * sizeof(sent)));

I prefer it the other way around. Also, have you tried using BITS_PER_TYPE()?

	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX));

>  	xe_device_assert_mem_access(xe);
>  
>  	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
> @@ -154,6 +211,24 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  
>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
> +
> +		if (severity != XE_RAS_SEV_CORRECTABLE) {
> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
> +				severity);

This should be before "detected" log above.

> +			continue;
> +		}
> +
> +		if (component >= XE_RAS_COMP_MAX) {
> +			xe_warn(xe, "sysctrl: unexpected component %u\n", component);

Ditto. Also, use xx_to_str() in both cases or don't but be consistent.

Raag

> +			continue;
> +		}
> +
> +		/* Send event once per component */
> +		if (sent & BIT(component))
> +			continue;
> +		sent |= BIT(component);
> +
> +		ras_send_error_event(xe, severity, component);
>  	}
>  }
>  
> -- 
> 2.47.1
> 
