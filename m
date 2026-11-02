Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37B606A338
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FyYwYRJj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60BC210ED85;
	Mon,  2 Nov 2026 12:06:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A651410ED68;
 Mon,  2 Nov 2026 12:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793621163; x=1825157163;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ncuBlp/vjWSskm6RKhx8Q7dAMfd8B7ZAd2luPtRcmgk=;
 b=FyYwYRJjgoS22DqmWwCcg42j8EosMTzUSjvlNYyLqr1FfAD0Lnrtsfm8
 Hkxl6qziz8QqEtBSSSQtyLocakY4BWG7pB7v3DTZB6Nuuj0/f3V0my8yC
 HVm0GjdrPBNeRb5CpxrS4ZGm/lyQEJ9HxSpRt7n6Pxn6uMjcdEbNiBMUq
 QOXnk388qoARw+dWYyaE+jNm2VEKHiLyTI6crNUC5+MvIk/vVzYN5p+qq
 TrngFdnC4+9pEwZKBzyBvYvM8ppbM1yyvrNR+hlqJJJj/zIbbxi8kUa3C
 GvdqulayfFe9NIqk9x+XfupQupYp279Ky9aY2RGpIl8pHJ7jTmTSMOFf7 w==;
X-CSE-ConnectionGUID: tbDt44kqSqmp+EhjQ5ZErw==
X-CSE-MsgGUID: Ak5fMV19RZK9ueZBOD/u1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2203700"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2203700"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 04:06:03 -0800
X-CSE-ConnectionGUID: 9ZWO4pEeTcmgI6T3jsBCsA==
X-CSE-MsgGUID: 2DVx2ONiT/2bWxje6/1zYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6275782"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.10])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 04:05:59 -0800
Date: Mon, 2 Nov 2026 14:05:57 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hugo Sales <hugo@hsal.es>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/probe-helper: Sort and set crtcinfo before dropping
 the modeset locks
Message-ID: <auh8pUx_kXUYSdZ8@intel.com>
References: <20261031161952.660049-1-hugo@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261031161952.660049-1-hugo@hsal.es>
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

On Sat, Oct 31, 2026 at 04:19:52PM +0000, Hugo Sales wrote:
> Currently, drm_helper_probe_single_connector_modes() holds
> connection_mutex while it probes and prunes connector->modes, then drops
> it before sorting the list and filling in the crtc_* fields of each
> mode. The caller still holds mode_config.mutex at that point, but
> drm_atomic_check_only() never takes it. The only lock it holds on the
> connector is connection_mutex, which drm_atomic_get_connector_state()
> takes for it
> 
> amdgpu walks connector->modes from its atomic_check, in

That is just wrong. connector->modes is protected by mode_config.mutex

The fact that amdgpu apparently uses scaling for external 
displays is a very odd as well. No other driver does that for
external displays. That said, I've thought about adding that for
i915/xe, but I think it should be done via some uapi so that
userspace retains control over the actual display timings.
I'd really prefer to do it that way for laptop panels as well,
but the old uapi is already carved in stone there so can't
change it :(

> create_stream_for_sink() and amdgpu_dm_get_highest_refresh_rate_mode(),
> holding only the locks of the atomic acquire context. list_sort()
> NULL-terminates the list while it runs, so that walk can follow a NULL
> next pointer or read a mode whose crtc_* fields are being rewritten
> 
> Sort the list and set crtcinfo before dropping the locks, as the
> function already does when it probes and prunes the modes. As far as I
> can tell, the unlock ended up in front of the sort when
> commit 6c5ed5ae353c ("drm/atomic: Acquire connection_mutex lock in drm_helper_probe_single_connector_modes, v4.")
> first took connection_mutex here, and that commit gives no reason for
> the order
> 
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 856b40fdaac4a..2085d93651b21 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -703,11 +703,10 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>  	}
>  
>  exit:
> -	drm_modeset_drop_locks(&ctx);
> -	drm_modeset_acquire_fini(&ctx);
> -
> -	if (list_empty(&connector->modes))
> -		return 0;
> +	if (list_empty(&connector->modes)) {
> +		count = 0;
> +		goto unlock;
> +	}
>  
>  	drm_mode_sort(&connector->modes);
>  
> @@ -720,6 +719,10 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>  			    DRM_MODE_ARG(mode));
>  	}
>  
> +unlock:
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);

I suppose we aren't moving all that much work under the lock
here, so maybe fine. Though I kinda hate that we even have
to hold the lock across the mode validation. But as long as
we're looking at the connector state in connector.mode_valid()
I suppose there is no choice :/

Any new locking rules would need to be properly documented.

And regardless of changing the locking rules or not, someone
should probably sprinkle lockdep asserts to bunch of places
where connector->modes is consulted. Perhaps even introduce
custom list iterator macros that include the assert...

> +
>  	return count;
>  }
>  EXPORT_SYMBOL(drm_helper_probe_single_connector_modes);
> -- 
> 2.56.0

-- 
Ville Syrjälä
Intel
