Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB12C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE31310EFA7;
	Thu, 23 Jul 2026 06:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZfKgEej2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7647610EFA6;
 Thu, 23 Jul 2026 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784788891; x=1816324891;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dndr+Q7ZbdWNVlT+QLoBDH1fcE11CMP/4FK8lYK2cI4=;
 b=ZfKgEej2DFRn2r2dxXEOoh/aKYM/LVtj2Tm5VEETbMw73sskRTGNXh87
 F/PQ6ctEJw8UWL2rifalf6nMOJQ13aktD87tfyBJEb9jXIrvjGN5U5q3Q
 0jzYhsMMmjnN/X9ELKHKlgBeGzw2uxoIdNg8cNnFLFtqM1twcIIyULpW1
 hcS7yHzuDKCoBvgv1t+RVVGsQonGa/3NwNzKoyocb43n3P9MfnMN0Kvwf
 h1HRb4wqODOOmRMMkpixohYHSUIn3uZZiSUwSqRunLcAKQsfEzzRMgUwS
 C58tJaIFuhw5aXDxhfihmQioCl6oO6lh0mKEZHusy/+OO5g3LFcH1E+9z Q==;
X-CSE-ConnectionGUID: fep24l8GRsqrnnWxEOlSMg==
X-CSE-MsgGUID: DLZcGkQ9TICOomd19ubEbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85555164"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="85555164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 23:41:30 -0700
X-CSE-ConnectionGUID: iyLNOZPCQN2e165/5ark1w==
X-CSE-MsgGUID: F6r60qe8TOiEeLgGB9fBrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="288321794"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 23:41:26 -0700
Date: Thu, 23 Jul 2026 08:41:23 +0200
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
Subject: Re: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectable
 error events to userspace
Message-ID: <amG3k8dNCJb_tHxT@black.igk.intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722094134.3036087-6-riana.tauro@intel.com>
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

On Wed, Jul 22, 2026 at 03:11:37PM +0530, Riana Tauro wrote:
> When an interrupt is received for correctable errors indicating that error
> counter has crossed its threshold, read the current counter value and
> deliver a drm-ras error-event to userspace for each affected component.
> 
> Also send drm-ras error-event to userspace for uncorrectable errors on
> receiving an AER.
> 
> To avoid sending duplicate events when the same component appears multiple
> times in the response, Send the error-event once per component.

...

> +/**
> + * xe_drm_ras_event() - Report drm-ras error event to userspace
> + * @xe: xe device structure
> + * @component: error component (see &enum drm_xe_ras_error_component)
> + * @severity: error severity (see &enum drm_xe_ras_error_severity)
> + * @value: value of error counter
> + *
> + * Report an error-event to userspace.
> + */
> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u32 value)

Forgot to add. Looking at the existing xe_drm_ras code, this should be

void xe_drm_ras_event(struct xe_device *xe, enum drm_xe_ras_error_severity severity,
		      u32 error_id, u32 val)

but can be done as follow up.

Raag
