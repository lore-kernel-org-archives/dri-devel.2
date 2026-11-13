Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC9606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I0IWwZmm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ACF7112644;
	Fri, 13 Nov 2026 15:15:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B7C0112640;
 Fri, 13 Nov 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794582894; x=1826118894;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=9n1I6MgYVaSPGAh07V1x0mIv4hUKhoAau8I38dMqmDA=;
 b=I0IWwZmmUBki3nXxBhM9Yg9DTL3KI236QffjeAlH5nmdMMNW+DvDAdTh
 ENv0ho246ATQLfj2TCTMwFGucn78MMS2vNkt9fJ2k9TZ51qY0wN/YC51Y
 3IL47SfVhahudPv3pxUe9lpMYjGJV7+rBClINHpskM+12Zg2cqwD0l13e
 ONgKmcRDVMr7IFxQJ0u0bypGzTcnhcURyFaDRxb7cAYyPUp8rxC4IGqFZ
 jh7XuvHnFZb4f0gUI2Clu6zWtnU8JqComzUD5r+r4iT6u1nR0Ah7YgUxE
 27ngmppGsyD1rILjQk0whutJm+PNHXPbbPmhWUrH8SvLkq5EqvK9fkuxI A==;
X-CSE-ConnectionGUID: dZTf4vGJSbeWc1equ6Q6Uw==
X-CSE-MsgGUID: qucCpwjKQu6VxhMnnac3Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3265171"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3265171"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:14:54 -0800
X-CSE-ConnectionGUID: B3hhH7pMR926idme/iuElQ==
X-CSE-MsgGUID: nOFZsQLrRY+7o7boJzQFXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9265609"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 07:14:50 -0800
Date: Fri, 13 Nov 2026 17:14:46 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Aditya Garg <aditya.garg@linux.dev>
Cc: Lukas Wunner <lukas@wunner.de>, Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Andre Eikmeyer <dev@deq.rocks>, Yossef Osman <yossef.osman@proton.me>,
 Alexander Fischer <alexander.fischer@kait2en.org>
Subject: Re: [PATCH RESEND] drm/i915/psr: enable PSR on Apple T2 eDP panels
Message-ID: <avcpZt3CkBJvz49o@intel.com>
References: <20261112165956.61633-1-aditya.garg@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112165956.61633-1-aditya.garg@linux.dev>
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

On Thu, Nov 12, 2026 at 10:29:56PM +0530, Aditya Garg wrote:
> From: Alexander Fischer <alexander.fischer@kait2en.org>
> 
> Commit 1035f4a65f58 ("drm/i915: Disable PSR in Apple panels")
> disabled PSR on all Apple sinks until i915 gained the required panel
> handling.
> 
> An AUX trace on a MacBookPro16,2 running macOS 15.7.7 shows the
> following writes when the panel is powered on:
> 
>   DPCD 0x321 = 0x3c

That's in the source device specific range. I think technically
the registers there can only be considered valid after writing
the appropriate source OUI to 0x300-0x302. Which source OUI
does the Apple driver write there?

>   DPCD 0x4d2 = 0x01
>   DPCD 0x4d1 = 0x03
>   DPCD 0x170 = 0x01 (DP_PSR_ENABLE without CRC verification)
> 
> Five seconds later, a write of 0x01 to DPCD 0x4d4 occurs between the
> BanksiaTcon FIFOEnter() and SRDEnter() events. This register is the
> vendor trigger for entering self refresh.
> 
> With the three setup writes, CRC verification disabled, and the 0x4d4
> trigger added to i915's existing PSR enable sequence, the tested panels
> enter PSR1.
> 
> Implement this handling as an i915 DPCD quirk. Match the Apple PCI
> subsystem vendor in the quirk table, and limit the quirk to Apple-OUI
> eDP sinks on systems containing an Apple T2. All other Apple sinks
> retain the existing NO_PSR quirk. Override the VBT PSR flag for
> matching panels because Apple leaves it clear.
> 
> The same sink-side protocol may also be present on T1 and Apple silicon
> systems, but leave those systems unchanged until it has been tested
> with their display drivers.
> 
> Tested on MacBookPro15,1, MacBookPro15,2, MacBookPro16,1,
> MacBookPro16,2 and MacBookAir9,1, covering four panel device IDs. All
> five enter PSR1 after boot and across suspend/resume, report
> DP_PSR_SINK_ACTIVE_SINK_SYNCED, and show no sink errors.
> 
> Tested-by: Andre Eikmeyer <dev@deq.rocks>
> Tested-by: Yossef Osman <yossef.osman@proton.me>
> Signed-off-by: Alexander Fischer <alexander.fischer@kait2en.org>
> Signed-off-by: Aditya Garg <aditya.garg@linux.dev>
> ---
> Changes in v4:
> - Rebase onto drm-tip; use drm_dp_dpcd_write_byte() for the new
>   writes to match the conversion of intel_psr.c
> 
> Changes in v3:
> - Match the Apple PCI subsystem vendor in the DPCD quirk table
>   (Lukas Wunner)
> 
> Changes in v2:
> - Use pci_dev_present() instead of pci_get_device()/pci_dev_put(),
>   which also drops the local PCI_DEVICE_ID define (Lukas Wunner)
> ---
>  drivers/gpu/drm/i915/display/intel_psr.c    | 28 +++++++++++++++++++--
>  drivers/gpu/drm/i915/display/intel_quirks.c | 28 +++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  3 files changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
> index 00d0146b2..c3bde5b64 100644
> --- a/drivers/gpu/drm/i915/display/intel_psr.c
> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> @@ -228,6 +228,9 @@ static bool psr_global_enabled(struct intel_dp *intel_dp)
>  
>  	switch (intel_dp->psr.debug & I915_PSR_DEBUG_MODE_MASK) {
>  	case I915_PSR_DEBUG_DEFAULT:
> +		if (intel_has_dpcd_quirk(intel_dp, QUIRK_APPLE_PSR_HANDSHAKE))
> +			return true;
> +
>  		return intel_dp_is_edp(intel_dp) ?
>  			connector->panel.vbt.psr.enable : true;
>  	case I915_PSR_DEBUG_DISABLE:
> @@ -667,7 +670,8 @@ static void _psr_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *co
>  	drm_dbg_kms(display->drm, "eDP panel supports PSR version %x\n",
>  		    connector->dp.psr_caps.dpcd[0]);
>  
> -	if (drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_NO_PSR)) {
> +	if (drm_dp_has_quirk(&intel_dp->desc, DP_DPCD_QUIRK_NO_PSR) &&
> +	    !intel_has_dpcd_quirk(intel_dp, QUIRK_APPLE_PSR_HANDSHAKE)) {
>  		drm_dbg_kms(display->drm,
>  			    "PSR support not currently available for this panel\n");
>  		return;
> @@ -807,19 +811,36 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
>  	drm_dp_dpcd_write_byte(&intel_dp->aux, PANEL_REPLAY_CONFIG3, panel_replay_config_3);
>  }
>  
> +/* Undocumented Apple eDP sink registers */
> +#define APPLE_PSR_SETUP_1	0x321
> +#define APPLE_PSR_SETUP_2	0x4d2
> +#define APPLE_PSR_SETUP_3	0x4d1
> +#define APPLE_PSR_TRIGGER	0x4d4

Maybe these should include "SOURCE" vs. "SINK" in the
name as well.

> +
> +static void psr_apple_prepare_sink(struct intel_dp *intel_dp)
> +{
> +	drm_dp_dpcd_write_byte(&intel_dp->aux, APPLE_PSR_SETUP_1, 0x3c);
> +	drm_dp_dpcd_write_byte(&intel_dp->aux, APPLE_PSR_SETUP_2, 0x01);
> +	drm_dp_dpcd_write_byte(&intel_dp->aux, APPLE_PSR_SETUP_3, 0x03);
> +}
> +
>  static void _psr_enable_sink(struct intel_dp *intel_dp,
>  			     const struct intel_crtc_state *crtc_state)
>  {
>  	struct intel_display *display = to_intel_display(intel_dp);
> +	bool apple_psr = intel_has_dpcd_quirk(intel_dp, QUIRK_APPLE_PSR_HANDSHAKE);
>  	u8 val = 0;
>  
> +	if (apple_psr)
> +		psr_apple_prepare_sink(intel_dp);
> +
>  	if (crtc_state->has_sel_update) {
>  		val |= DP_PSR_ENABLE_PSR2 | DP_PSR_IRQ_HPD_WITH_CRC_ERRORS;
>  	} else {
>  		if (intel_dp->psr.link_standby)
>  			val |= DP_PSR_MAIN_LINK_ACTIVE;
>  
> -		if (DISPLAY_VER(display) >= 8)
> +		if (DISPLAY_VER(display) >= 8 && !apple_psr)
>  			val |= DP_PSR_CRC_VERIFICATION;
>  	}
>  
> @@ -835,6 +856,9 @@ static void _psr_enable_sink(struct intel_dp *intel_dp,
>  
>  	val |= DP_PSR_ENABLE;
>  	drm_dp_dpcd_write_byte(&intel_dp->aux, DP_PSR_EN_CFG, val);
> +
> +	if (apple_psr)
> +		drm_dp_dpcd_write_byte(&intel_dp->aux, APPLE_PSR_TRIGGER, 0x01);
>  }
>  
>  static void intel_psr_enable_sink(struct intel_dp *intel_dp,
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 7d7db774d..8e9c851c2 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -9,6 +9,7 @@
>  
>  #include "intel_display_core.h"
>  #include "intel_display_types.h"
> +#include "intel_dp.h"
>  #include "intel_quirks.h"
>  
>  static void intel_set_quirk(struct intel_display *display, enum intel_quirk_id quirk)
> @@ -100,6 +101,25 @@ static void quirk_disable_psr2(struct intel_display *display)
>  	drm_info(display->drm, "PSR2 support not currently available for this setup, applying disable PSR2 quirk\n");
>  }
>  
> +static void quirk_apple_psr_handshake(struct intel_dp *intel_dp)
> +{
> +	static const struct pci_device_id t2_ids[] = {
> +		/* Apple T2 */
> +		{PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x1801)},

This is some other device on these systems? Can't just
match on the GPU subsys vendor/device + sink OUI alone?

> +		{}
> +	};
> +	struct intel_display *display = to_intel_display(intel_dp);
> +
> +	if (!intel_dp_is_edp(intel_dp))
> +		return;
> +
> +	if (!pci_dev_present(t2_ids))
> +		return;
> +
> +	intel_set_dpcd_quirk(intel_dp, QUIRK_APPLE_PSR_HANDSHAKE);
> +	drm_info(display->drm, "Applying Apple PSR handshake quirk\n");
> +}
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -289,6 +309,14 @@ static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
>  		.sink_oui = SINK_OUI(0x00, 0x22, 0xb9),
>  		.hook = quirk_disable_edp_panel_replay,
>  	},
> +	/* Apple T2 eDP panels */
> +	{
> +		.device = DEVICE_ID_ANY,
> +		.subsystem_vendor = PCI_VENDOR_ID_APPLE,
> +		.subsystem_device = PCI_ANY_ID,
> +		.sink_oui = SINK_OUI(0x00, 0x10, 0xfa),
> +		.hook = quirk_apple_psr_handshake,
> +	},
>  };
>  
>  void intel_init_quirks(struct intel_display *display)
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.h b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 970a4fe52..7b863d408 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -23,6 +23,7 @@ enum intel_quirk_id {
>  	QUIRK_EDP_LIMIT_RATE_HBR2,
>  	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>  	QUIRK_DISABLE_PSR2,
> +	QUIRK_APPLE_PSR_HANDSHAKE,
>  };
>  
>  void intel_init_quirks(struct intel_display *display);
> -- 
> 2.56.0

-- 
Ville Syrjälä
Intel
