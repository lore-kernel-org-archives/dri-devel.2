Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43078C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E1610E735;
	Tue, 21 Jul 2026 08:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h4Oq48A9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A90610E718;
 Tue, 21 Jul 2026 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784623073; x=1816159073;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tuO2+/LIjsEx+XFyN+fZk2W+ZU5M/HIoZSIlXVgHCSU=;
 b=h4Oq48A9J0c86k+5Lw4POrFnAX+HINHm26G3EVwMSZOOpCB4yfu6YnJN
 QRGIfxPanlAFGOSBsGcK+qhh6xa5rfFQyKu/+66FPgIesTun7QUzW/rBw
 A/h1ZTKiyX+UrVbUWXurOogos0MXErcBEPS/o2pP7ucIYQBmPDUeg1d+e
 fzycPpll0ulWLAxhmPs84Ox3eniwKLzHO/npbTs55Qw0OPUhSAb5KL2JK
 cYy8BIgCaUXKa/ickYYxSQGFOFwLPtIwk36MQb9geBXtm8GPem+65tZvv
 H7mH9Gw6oMY1gDMF0b1veu67h6cdsWxOhDhaiYdo48wsxNBP6E/MmEqv3 Q==;
X-CSE-ConnectionGUID: 0IHwepb8QO+8A1A20+AIwQ==
X-CSE-MsgGUID: 4GZ5AO3wTwKCqzpTymzThg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="89037216"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="89037216"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 01:37:52 -0700
X-CSE-ConnectionGUID: 8eSonQXHRFGdoJ/7ZakRGA==
X-CSE-MsgGUID: L9tLW/9ERsmf9CBmhnPKGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="280968466"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 01:37:48 -0700
Date: Tue, 21 Jul 2026 10:37:45 +0200
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
Subject: Re: [PATCH v5 2/3] drm/xe/xe_ras: Report correctable error events to
 userspace
Message-ID: <al8v2STXTiMhp5C5@black.igk.intel.com>
References: <20260720082208.2648279-5-riana.tauro@intel.com>
 <20260720082208.2648279-7-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720082208.2648279-7-riana.tauro@intel.com>
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

On Mon, Jul 20, 2026 at 01:52:11PM +0530, Riana Tauro wrote:
> When an interrupt is received indicating that error counter has crossed
> its threshold, read the current counter value and deliver a drm_ras error
> event to userspace for each affected component.
> 
> To avoid sending duplicate events when the same component appears multiple
> times in the response. Send the error-event once per component.

...

> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)
> +{
> +	struct xe_drm_ras *ras = &xe->ras;
> +	struct xe_drm_ras_counter *info;
> +	struct drm_ras_node *node;
> +	int ret;
> +
> +	/* Event is supported only if drm_ras is enabled */
> +	if (!xe->info.has_drm_ras)
> +		return;
> +
> +	if (component >= DRM_XE_RAS_ERR_COMP_MAX) {

IIUC this is error_id and should be validated against first/last counter
range in drm_ras layer (similar to registration code).

> +		drm_warn(&xe->drm, "unsupported component %u\n", component);
> +		return;
> +	}
> +
> +	if (severity >= DRM_XE_RAS_ERR_SEV_MAX) {
> +		drm_warn(&xe->drm, "unsupported severity %u\n", severity);
> +		return;
> +	}
> +
> +	node = &ras->node[severity];
> +	info = ras->info[severity];
> +
> +	if (!info || !info[component].name)
> +		return;
> +
> +	ret = drm_ras_nl_error_event(node, component, info[component].name, value);
> +	if (ret)
> +		drm_err_ratelimited(&xe->drm, "drm_ras error-event failed: %d for %s %s\n", ret,
> +				    info[component].name, error_severity[severity]);
> +}

...

> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
> +{
> +	struct xe_ras_error_class counter = {0};
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	counter.common.severity = severity;
> +	counter.common.component = component;
> +
> +	ret = get_counter(xe, &counter, &value);
> +	if (ret)
> +		return;
> +
> +	drm_severity = xe_to_drm_ras_severity(severity);
> +	drm_component = xe_to_drm_ras_component(component);
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value);
> +}

This entire function can be dropped. See below.

>  static u8 handle_core_compute_errors(struct xe_ras_error_array *arr)
>  {
>  	struct xe_ras_compute_error *error_info = (void *)arr->details;
> @@ -312,8 +364,10 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  	struct xe_ras_threshold_crossed *pending = (void *)&response->data;
>  	struct xe_ras_error_class *errors = pending->counters;
>  	u32 id, ncounters = pending->ncounters;
> +	u8 sent = 0;
>  
>  	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
> +	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
>  	xe_device_assert_mem_access(xe);
>  
>  	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
> @@ -327,8 +381,21 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
>  		severity = errors[id].common.severity;
>  		component = errors[id].common.component;
>  
> +		if (severity != XE_RAS_SEV_CORRECTABLE) {
> +			xe_warn(xe, "sysctrl: unexpected severity %s (%u)\n", sev_to_str(severity),
> +				severity);

Sanity checks are good, but I think this needs to be extended a bit.
I have something[1] more robust, feel free to reuse.

[1] https://lore.kernel.org/intel-xe/20260721082953.640497-1-raag.jadav@intel.com

> +			continue;
> +		}
> +
>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
> +
> +		/* Send event once per component */
> +		if (sent & BIT(component))
> +			continue;
> +		sent |= BIT(component);

With [1] in place you can just get_counter(&counter) and drm_ras_event()
directly.

Raag

> +		ras_send_error_event(xe, severity, component);
>  	}
>  }
>  
> -- 
> 2.47.1
> 
