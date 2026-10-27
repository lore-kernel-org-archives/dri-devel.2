Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1049606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Zizy2pld
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D7C110E24A;
	Tue, 27 Oct 2026 09:31:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041F210F303;
 Tue, 27 Oct 2026 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793093484; x=1824629484;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=mENBM7L0NMnkFXUKkoj0KRaIna8saiPp1s2/O6X9Bsg=;
 b=Zizy2pldXJHltUklKCgdOwd1eJaxJrw+4Wt4kML58HY8SYIJjBB3vOZy
 arDp+Uvr7NRVaCL2S8+q/6QLVxkRVdVy3vj4VnL+Q4AknLOHVY6yE4dih
 eZsTFiWwkgjnOhqfYs+E77a+4ueMQNYpi53dd4/GSjPbNk7avR8jdchSb
 Z5/VpNfui2KHN95iBCA6a0ySykOiECJKJj7rNiyChTtEWsI5IkIR9EqlG
 Erh85XZSQds1i8CxHsrlmh0//dII+INlxj7jiGiejNJe+3d+UIFoib/JY
 mPLLkvDdrbI1Idtn+JkJn2++/ENbD9j2uYCBqL18ICAaqHn6Se5BweodW w==;
X-CSE-ConnectionGUID: zE2Es0ryQoGID3ZLThHFxA==
X-CSE-MsgGUID: TBKOOIFkS52qIFAnhMGLNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1796565"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1796565"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:31:23 -0700
X-CSE-ConnectionGUID: vjRQxLxUQmCYoJZVy2tglg==
X-CSE-MsgGUID: BF2qoHQ/QPC2cHnSOnwgXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4849329"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.247])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:31:20 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Aman Sharma <amansharma6122002@gmail.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Aman Sharma <amansharma6122002@gmail.com>
Subject: Re: [PATCH v3] drm/i915/hdmi: preserve cached EDID on DDC failure
 when connector is forced
In-Reply-To: <179284640822.1672477.8751430644960613659@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <179284356403.1659508.10439113185286055496@gmail.com>
 <179284522321.1666644.7085985666852699043@gmail.com>
 <179284640822.1672477.8751430644960613659@gmail.com>
Date: Tue, 27 Oct 2026 11:31:17 +0200
Message-ID: <c1c3c10002166161503e6b529726ae305d0b698c@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026, Aman Sharma <amansharma6122002@gmail.com> wrote:
> When an HDMI connector is forced enabled (e.g. via video=HDMI-A-1:e for
> laptop clamshell operation) and the external monitor enters DPMS standby,
> some monitors (such as the BenQ GW2790Q) power down their internal DDC/I2C
> controller, causing SCDC/EDID reads to fail with -ENXIO (-6).
>
> Currently, intel_hdmi_detect() and intel_hdmi_force() unconditionally call
> intel_hdmi_unset_edid() before calling intel_hdmi_set_edid(). When
> drm_edid_read_ddc() returns NULL during monitor standby, the connector's
> cached detect_edid is wiped out and
> drm_helper_probe_single_connector_modes() falls back to the 1024x768 VESA
> no-EDID mode. When the monitor wakes back up, because the connector status
> remained forced to connector_status_connected, no hotplug state transition
> occurs and the display remains stuck at 1024x768 until a manual mode probe
> (such as toggling the laptop lid) is triggered.
>
> Fix this by moving intel_hdmi_unset_edid() into intel_hdmi_set_edid() after
> checking whether a forced-on connector (DRM_FORCE_ON or
> DRM_FORCE_ON_DIGITAL) already has a valid cached EDID (detect_edid and
> edid_blob_ptr) when DDC fails, and preserving connector_status_connected
> on Gen11+ digital port disconnect when a forced-on connector has a cached
> EDID. When the monitor is awake or a different monitor is plugged in,
> drm_edid_read_ddc() succeeds, resets the previous EDID and dp_dual_mode
> state via intel_hdmi_unset_edid(), and updates the connector with the new
> EDID.

Connector forcing and EDID reading/caching need to remain
orthogonal. The patch at hand makes a complex thing more complex.

Please file a bug as described at [1], reproducing the problem.

[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html

> v3:
> - Explicitly check for DRM_FORCE_ON / DRM_FORCE_ON_DIGITAL so DRM_FORCE_OFF
>   still clears the cached EDID as expected.
> - Report connector_status_connected on Gen11+ disconnect when a forced-on
>   connector retains its cached EDID, and jump to out in
>   intel_hdmi_set_edid() so CEC physical address remains valid and
>   drm_helper_probe_detect_ctx() does not increment epoch_counter on
>   standby HPD pulses.
>
> v2:
> - Move intel_hdmi_unset_edid() into intel_hdmi_set_edid() so hotplug
>   detection via intel_hdmi_detect() also preserves the cached EDID on
>   forced connectors and resets dp_dual_mode when updating EDID.
> - Clear detect_edid on Gen11+ disconnect when the connector is unforced,
>   and verify edid_blob_ptr is non-NULL before retaining detect_edid.
>
> Signed-off-by: Aman Sharma <amansharma6122002@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_hdmi.c | 31 ++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
> index b6fa1a1558b8..a14a857dfe94 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
> @@ -2570,6 +2570,21 @@ intel_hdmi_set_edid(struct drm_connector *_connector)
>  		intel_gmbus_force_bit(ddc, false);
>  	}
>  
> +	/*
> +	 * If the connector is forced on (e.g. video=HDMI-A-1:e) and the sink's
> +	 * DDC/I2C bus is powered down during DPMS standby, keep the previously
> +	 * cached EDID rather than wiping it and falling back to 1024x768.
> +	 */
> +	if (!drm_edid &&
> +	    (connector->base.force == DRM_FORCE_ON ||
> +	     connector->base.force == DRM_FORCE_ON_DIGITAL) &&
> +	    connector->detect_edid && connector->base.edid_blob_ptr) {

Drivers also have no business looking at edid_blob_ptr.

BR,
Jani.

> +		connected = true;
> +		goto out;
> +	}
> +
> +	intel_hdmi_unset_edid(&connector->base);
> +
>  	/* Below we depend on display info having been updated */
>  	drm_edid_connector_update(&connector->base, drm_edid);
>  
> @@ -2580,6 +2595,7 @@ intel_hdmi_set_edid(struct drm_connector *_connector)
>  		connected = true;
>  	}
>  
> +out:
>  	intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
>  
>  	cec_notifier_set_phys_addr(intel_hdmi->cec_notifier,
> @@ -2611,10 +2627,15 @@ intel_hdmi_detect(struct drm_connector *_connector, bool force)
>  	wakeref = intel_display_power_get(display, POWER_DOMAIN_GMBUS);
>  
>  	if (DISPLAY_VER(display) >= 11 &&
> -	    !intel_digital_port_connected(encoder))
> +	    !intel_digital_port_connected(encoder)) {
> +		if ((connector->base.force == DRM_FORCE_ON ||
> +		     connector->base.force == DRM_FORCE_ON_DIGITAL) &&
> +		    connector->detect_edid && connector->base.edid_blob_ptr)
> +			status = connector_status_connected;
> +		else
> +			intel_hdmi_unset_edid(&connector->base);
>  		goto out;
> -
> -	intel_hdmi_unset_edid(&connector->base);
> +	}
>  
>  	if (intel_hdmi_set_edid(&connector->base))
>  		status = connector_status_connected;
> @@ -2638,10 +2659,10 @@ intel_hdmi_force(struct drm_connector *_connector)
>  	if (!intel_display_driver_check_access(display))
>  		return;
>  
> -	intel_hdmi_unset_edid(&connector->base);
> -
> -	if (connector->base.status != connector_status_connected)
> +	if (connector->base.status != connector_status_connected) {
> +		intel_hdmi_unset_edid(&connector->base);
>  		return;
> +	}
>  
>  	intel_hdmi_set_edid(&connector->base);
>  }

-- 
Jani Nikula, Intel
