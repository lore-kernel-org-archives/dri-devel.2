Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DFC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E907710E47B;
	Wed, 22 Jul 2026 15:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Mq5B1xJ8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680E110E2BA;
 Wed, 22 Jul 2026 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784733852; x=1816269852;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yNp5vfbNrcw9crZa4ho/0WR69M1J0VF4JvsRHE3RGcU=;
 b=Mq5B1xJ8baEIdtJcySnyCvAcd2laHJiH3Ubm3lCCZTL/mWQrx6wxDSbD
 lpezQHAyd7jTLtpFIRnKjrFnsaUpIiSUaZoq/w2zkhbK6brjVf7iwt6E3
 fyXWx4KwjsVrG5uQDEfCbkiELyyyJRFkxC+I4FPTclzB4IK+90WUFMDta
 sUe6Km2u3404kH0Y+yxKbhl40jyp6xLfYaW+TKUpNHnQlePEHKo3Kj6+n
 OpBbEYUJ+/YmZMcGd8hUjOYf6gtghdgGlifIY6cKsJC3MwKopeeofqUZL
 5Wco8sQAv6dlJ0txfz7zVQqcN6WGKtNdTUOY1zsd6LUEPWMDgwLTeBflM A==;
X-CSE-ConnectionGUID: 2RhOn3pySwSW+3/ZfeuJRA==
X-CSE-MsgGUID: Ks0Wf7Q5Q/qqF75ZKLOwsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85318087"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="85318087"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 08:24:12 -0700
X-CSE-ConnectionGUID: 6UUqaySHRriAFSZgN/h1kQ==
X-CSE-MsgGUID: AKAZSnbeQquZ5UOnakilBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="263068633"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 08:24:07 -0700
Date: Wed, 22 Jul 2026 17:24:04 +0200
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
Message-ID: <amDglMC44EIWChvp@black.igk.intel.com>
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

> @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>  			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
>  				sev_to_str(severity));

Similar to threshold crossed case, we should probably have a BUILD_BUG_ON()
against XE_RAS_NUM_ERROR_ARR.

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

> +			/* Send event once per component */
> +			if (!(sent & BIT(component))) {
> +				sent |= BIT(component);
> +				ras_send_error_event(xe, severity, component);
> +			}
> +
>  			switch (component) {
>  			case XE_RAS_COMP_CORE_COMPUTE:
>  				action = handle_core_compute_errors(arr);
> -- 
> 2.47.1
> 
