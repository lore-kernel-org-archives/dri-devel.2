Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50828C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EC710F035;
	Wed,  2 Sep 2026 07:21:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PuXjr7/Y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C58610EFFC;
 Wed,  2 Sep 2026 07:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788333662; x=1819869662;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=QZzdXAcAcv+mKzUV0NnviJmj89qKZNp+wA8NIWKm+dU=;
 b=PuXjr7/YEYi9jWzzxfRKylaUkI+Bz7haattdys8r2aajCRKWxoOwuB5a
 fo6eE1Yf6KI45rgp1EUMyDlo2PPxrcpkDgL9rcdI4FyWtEKzM000IZ1rf
 rM3kcfR46uvBvloGmA5GHdcWLzQPW68qHgt6eVrca8SEGrLuQCLtCk+en
 biX1qJINd1VZyEdm2jTfgHq1GOh9h9Jzm1UjNHBWzWOdZrMaiDfhUidxk
 BqY+F/CTqIbdBj98EIqu/p1JfX7URG02AH7e/Zi0P3Rpj3tY5JUTMc6lx
 55yj5Thr0uSxJsMmKvpAwjB7iHRSeCqzhxvZjP/AnDnWQx8vabIFMjlo7 Q==;
X-CSE-ConnectionGUID: 54Os7LPJSH+SkVssJNmaWw==
X-CSE-MsgGUID: Hx/q1c+mSdWP7SZXF/4E5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87919846"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="87919846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 00:21:02 -0700
X-CSE-ConnectionGUID: HDgy3qFKRLm0BVtRjJGcNg==
X-CSE-MsgGUID: q8e/TXTdS0a9wXvfIr1jGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="294166448"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.84])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 00:21:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, uma.shankar@intel.com,
 ville.syrjala@linux.intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH 01/44] drm/i915/hdmi: Parse frl max link rate from vbt
In-Reply-To: <20260807041430.229038-2-ankit.k.nautiyal@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
 <20260807041430.229038-2-ankit.k.nautiyal@intel.com>
Date: Wed, 02 Sep 2026 10:20:57 +0300
Message-ID: <36d16c8b33bc5e46df384e4b402d97fca0d93d5a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 07 Aug 2026, Ankit Nautiyal <ankit.k.nautiyal@intel.com> wrote:
> From: Vandita Kulkarni <vandita.kulkarni@intel.com>
>
> Parse the maximum FRL link rate from VBT and store it for use
> during FRL mode selection and link training.
>
> Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_bios.c     | 53 +++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_bios.h     |  1 +
>  drivers/gpu/drm/i915/display/intel_vbt_defs.h |  7 +++
>  3 files changed, 61 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/drm/i915/display/intel_bios.c
> index 97cbae2e547e..6354fa4041dc 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -2734,6 +2734,43 @@ static bool is_port_valid(struct intel_display *display, enum port port)
>  	return true;
>  }
>  
> +static int _intel_bios_hdmi_max_frl_rate(const struct intel_bios_encoder_data *devdata)
> +{
> +	struct intel_display *display = devdata->display;
> +
> +	if (display->vbt.version >= 237 &&
> +	    devdata->child.hdmi_max_frl_rate_valid) {
> +		switch (devdata->child.hdmi_max_frl_rate) {
> +		default:
> +		case HDMI_MAX_FRL_RATE_PLATFORM:

That's 0, and we already checked that in the if.

> +			drm_dbg_kms(display->drm,
> +				    "HDMI limited to support only TMDS modes\n");
> +			return 0;
> +		case HDMI_MAX_FRL_RATE_3G:
> +			return 3000000;
> +		case HDMI_MAX_FRL_RATE_6G:
> +			return 6000000;
> +		case HDMI_MAX_FRL_RATE_8G:
> +			return 8000000;
> +		case HDMI_MAX_FRL_RATE_10G:
> +			return 10000000;
> +		case HDMI_MAX_FRL_RATE_12G:
> +			return 12000000;
> +		}
> +	}
> +
> +	/*
> +	 * When hdmi_max_frl_rate_valid is 0
> +	 * Don't consider the hdmi_max_frl_rate for
> +	 * limiting the FRL Rates on FRL-capable displays
> +	 */
> +	if (display->vbt.version >= 237 &&
> +	    display->platform.meteorlake)
> +		return 12000000;

Both the if branches have version >= 237, so you could just have if
version < 237 at the top and return early.

And what's the point of having if
(devdata->child.hdmi_max_frl_rate_valid) and switch
(devdata->child.hdmi_max_frl_rate_valid) back to back? Just handle
everything in the switch case?

> +
> +	return 0;
> +}
> +
>  static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
>  {
>  	struct intel_display *display = devdata->display;
> @@ -2741,6 +2778,7 @@ static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
>  	bool is_dvi, is_hdmi, is_dp, is_edp, is_dsi, is_crt, supports_typec_usb, supports_tbt;
>  	int dp_boost_level, dp_max_link_rate, hdmi_boost_level, hdmi_level_shift, max_tmds_clock;
>  	enum port port;
> +	int hdmi_max_frl_rate;
>  
>  	port = intel_bios_encoder_port(devdata);
>  	if (port == PORT_NONE)
> @@ -2806,6 +2844,12 @@ static void print_ddi_port(const struct intel_bios_encoder_data *devdata)
>  			    "Port %c VBT DP max link rate: %d\n",
>  			    port_name(port), dp_max_link_rate);
>  
> +	hdmi_max_frl_rate = _intel_bios_hdmi_max_frl_rate(devdata);
> +	if (hdmi_max_frl_rate)
> +		drm_dbg_kms(display->drm,
> +			    "VBT HDMI max frl rate for port %c: %d\n",

Please stick to the same format as the other debug messages. They'll be
easier to read in the dmesg. frl -> FRL too.

> +			    port_name(port), hdmi_max_frl_rate);
> +
>  	/*
>  	 * FIXME need to implement support for VBT
>  	 * vswing/preemph tables should this ever trigger.
> @@ -3879,3 +3923,12 @@ void intel_bios_debugfs_register(struct intel_display *display)
>  	debugfs_create_file("i915_vbt", 0444, display->drm->debugfs_root,
>  			    display, &intel_bios_vbt_fops);
>  }
> +
> +int intel_bios_hdmi_max_frl_rate(struct intel_encoder *encoder)
> +{
> +	struct intel_display *display = to_intel_display(encoder);
> +	const struct intel_bios_encoder_data *devdata;
> +
> +	devdata = intel_bios_encoder_data_lookup(display, encoder->port);
> +	return _intel_bios_hdmi_max_frl_rate(devdata);
> +}

I don't think we want this wrapper at all. The caller can pass
encoder->devdata.

> diff --git a/drivers/gpu/drm/i915/display/intel_bios.h b/drivers/gpu/drm/i915/display/intel_bios.h
> index 75dff27b4228..53d46c9fa6e1 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.h
> +++ b/drivers/gpu/drm/i915/display/intel_bios.h
> @@ -102,6 +102,7 @@ int intel_bios_hdmi_max_tmds_clock(const struct intel_bios_encoder_data *devdata
>  void intel_bios_for_each_encoder(struct intel_display *display,
>  				 void (*func)(struct intel_display *display,
>  					      const struct intel_bios_encoder_data *devdata));
> +int intel_bios_hdmi_max_frl_rate(struct intel_encoder *encoder);
>  
>  void intel_bios_debugfs_register(struct intel_display *display);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_vbt_defs.h b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> index 0dc13d080e8a..db7484542dc0 100644
> --- a/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> +++ b/drivers/gpu/drm/i915/display/intel_vbt_defs.h
> @@ -381,6 +381,13 @@ struct bdb_general_features {
>  #define HDMI_MAX_DATA_RATE_340		4			/* 249+ */
>  #define HDMI_MAX_DATA_RATE_300		5			/* 249+ */
>  
> +#define HDMI_MAX_FRL_RATE_PLATFORM	0			/* 237 */
> +#define HDMI_MAX_FRL_RATE_3G		1			/* 237 */
> +#define HDMI_MAX_FRL_RATE_6G		2			/* 237 */
> +#define HDMI_MAX_FRL_RATE_8G		3			/* 237 */
> +#define HDMI_MAX_FRL_RATE_10G		4			/* 237 */
> +#define HDMI_MAX_FRL_RATE_12G		5			/* 237 */
> +
>  #define LEGACY_CHILD_DEVICE_CONFIG_SIZE		33
>  
>  /* DDC Bus DDI Type 155+ */

-- 
Jani Nikula, Intel
