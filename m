Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F101CCF2E4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F209F10ECB0;
	Mon, 19 Oct 2026 12:40:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B8910ECAC;
 Mon, 19 Oct 2026 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792413596; x=1823949596;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Baku2ykks/DkyY3R0JkdEZovC1b1uK96RPEwP2b5q2M=;
 b=Ud3VfttMeYQjtSAHuRG4hEk+koJLpfspnbw9alrHiq5cVlg0xQPeZU52
 20NT1ZtJL9uBIMIiEJjzHNxrBQJa+7XQpTDYbPFBBJalKvUnXYS7+Bsei
 G+7jWpVcsdQoyAOiVckBNufqmK7RvgcS4lp6dPaNyrEOG15zPaaiWYiz9
 vT4tWsuIol1ABm7HsL9SYdZOS/fQ+sQkCyWZCXRHUrL9Kui9GD8Cjdj/l
 4ii3ZrzTozFoAe5u74roMEEDRS6390ucHfokpAmF/nVm0e68eaioxCRHP
 iaJNiLtcXSuubswTVR6VXMR86inDhiPLymqaIETE9TR/9OF38wZPWUEMa A==;
X-CSE-ConnectionGUID: tPLwf6HzSdyuE9rwSSK58A==
X-CSE-MsgGUID: vTK11/0oRsG2uhLQMuxoIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="975998"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="975998"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:39:55 -0700
X-CSE-ConnectionGUID: 5D0UVaIWQO6StvIbHfaUEA==
X-CSE-MsgGUID: iqL1HPHvRWaxAR2HpNOkvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2909728"
Received: from alekseim-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.34])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:39:52 -0700
Date: Mon, 19 Oct 2026 15:39:48 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: mwwa919@gmail.com
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/dsi: Use owned panel/backlight GPIOs in VLV
 MIPI sequences
Message-ID: <atYPlC-f2AQEjYWS@intel.com>
References: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018-vlv-dsi-owned-gpios-v1-1-3ca18bcda670@gmail.com>
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

On Sun, Oct 18, 2026 at 04:12:40PM -0400, Mike Anderson via B4 Relay wrote:
> From: Mike Anderson <mwwa919@gmail.com>
> 
> On VLV with PPS_BLC_SOC, intel_dsi_vbt_gpio_init() requests the
> backlight and panel enable GPIOs (INT33FC:01 pins 10 and 11) for i915
> itself. Since commit 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV
> GPIOs behind the driver's back") the GPIO elements of the VBT MIPI
> sequences also request their pin through gpiolib, so when a sequence
> toggles one of these two pins the request fails and the toggle is
> dropped:
> 
>   i915 0000:00:02.0: [drm] *ERROR* GPIO index 10 request failed (-EBUSY)
> 
> Before that commit the pad registers were written directly, so the
> sequences could still drive the pins i915 owned.
> 
> The Toshiba Encore 2 WT8-B (Bay Trail, DSI panel) uses pin 10 as the
> panel reset line: MIPI_SEQ_ASSERT_RESET drives it low and
> MIPI_SEQ_DEASSERT_RESET pulses it high-low-high. With every toggle
> failing, the panel is never reset after i915 sends MIPI_SEQ_DISPLAY_OFF
> during takeover and stays black, even though the backlight PWM and both
> enable GPIOs read back as on. The tablet only has a usable display
> with nomodeset.
> 
> When a VLV MIPI sequence targets pin 10 or 11 and i915 holds the
> corresponding descriptor, set it through that descriptor instead of
> requesting the pin a second time.
> 
> Fixes: 8241b55f1ded ("drm/i915/dsi: Replace poking of VLV GPIOs behind the driver's back")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM sparse
> Signed-off-by: Mike Anderson <mwwa919@gmail.com>
> ---
> This patch was developed with an AI coding assistant (Claude Code,
> Claude Opus 5.5): it ran the debugging session on the tablet (drm.debug
> log, gpio/pwm debugfs), traced the -EBUSY to 8241b55f1ded, and wrote the
> change and the changelog; I reviewed it and tested it on the hardware.
> 
> Testing, Toshiba Encore 2 WT8-B (Atom Z3735F, BIOS 2.10, VBT MIPI
> sequence block v2, PPS_BLC_SOC):
> - Arch Linux v7.2.11-arch1 with this patch backported (applies as is):
>   the panel lights up at i915 takeover and the Xorg login screen shows;
>   no "GPIO index ... request failed" errors; gpio-10/11 stay owned as
>   "backlight"/"panel". Unpatched v7.2.11 and v6.18.57 give a black
>   panel with five -EBUSY errors during boot.
> - drm-intel-next: built intel_dsi_vbt.o for i915 (=m and =y) and for
>   xe (=m) with W=1 and sparse (C=2, sparse v0.6.5-rc1): no new
>   warnings.
> 
> Not tested: other VLV machines with PPS_BLC_SOC. Their behaviour only
> changes when their VBT sequences touch pin 10 or 11, which currently
> fails with -EBUSY anyway.
> ---
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 32 +++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> index fe12041e9..85d1cdc6e 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -54,6 +54,10 @@
>  #define MIPI_VIRTUAL_CHANNEL_SHIFT	1
>  #define MIPI_PORT_SHIFT			3
>  
> +/* VLV NC pins of the backlight and panel enable GPIOs, see soc_panel_gpio_table */
> +#define VLV_GPIO_NC_BACKLIGHT		10
> +#define VLV_GPIO_NC_PANEL		11
> +
>  struct i2c_adapter_lookup {
>  	u16 target_addr;
>  	struct intel_dsi *intel_dsi;
> @@ -247,10 +251,12 @@ static void soc_opaque_gpio_set_value(struct intel_connector *connector,
>  	kfree(lookup);
>  }
>  
> -static void vlv_gpio_set_value(struct intel_connector *connector,
> +static void vlv_gpio_set_value(struct intel_dsi *intel_dsi,
>  			       u8 gpio_source, u8 gpio_index, bool value)
>  {
> -	struct intel_display *display = to_intel_display(connector);
> +	struct intel_display *display = to_intel_display(&intel_dsi->base);
> +	struct intel_connector *connector = intel_dsi->attached_connector;
> +	struct gpio_desc *gpio_desc = NULL;
>  
>  	/* XXX: this assumes vlv_gpio_table only has NC GPIOs. */
>  	if (connector->panel.vbt.dsi.seq_version < 3) {
> @@ -265,6 +271,22 @@ static void vlv_gpio_set_value(struct intel_connector *connector,
>  		}
>  	}
>  
> +	/*
> +	 * With PPS_BLC_SOC, intel_dsi_vbt_gpio_init() already owns these pins,
> +	 * so requesting them again fails with -EBUSY. Some VBTs still toggle
> +	 * them in their MIPI sequences, e.g. as the panel reset line, so drive
> +	 * them through the descriptors we hold.
> +	 */
> +	if (gpio_index == VLV_GPIO_NC_BACKLIGHT)
> +		gpio_desc = intel_dsi->gpio_backlight;
> +	else if (gpio_index == VLV_GPIO_NC_PANEL)
> +		gpio_desc = intel_dsi->gpio_panel;

Please file a bug
https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items and
attach a copy of /sys/kernel/debug/dri/0/i915_vbt there so that 
we can all see what it looks like.

I think what we should do is stop using .gpio_panel and/or
.gpio_backlight when the VBT expects to control them via the
sequences.

The big question here is whether we need to keep some kind of
hybrid approach where one pin is controlled by the sequence and
the other explicitly by the driver.

For example https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/14605
has a VBT where the reset pin is controlled by the VBT but there is no
backlight stuff whatsoever in there. Well, unless some of those DCS
commands has something to do with the backlight, but IIRC DCS has no
standard stuff for backlight so it would all be panel specific. So
it's not clear if a backlight GPIO pin is needed at all there, of if
the DCS and/or the PWM alone is sufficient.

Hans, do you still have these funky VLV DSI machines around, and if so
can you check whether they would need this kind of hybrid approach?
Sadly all I have is old stuff that doesn't use the VBT sequences at
all.

If we do need the hybrid approach then it could perhaps look something like this:
--- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
+++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
@@ -917,8 +917,14 @@ void intel_dsi_vbt_gpio_init(struct intel_dsi *intel_dsi, bool panel_is_on)
 
 	if (display->platform.valleyview && mipi_config->pwm_blc == PPS_BLC_SOC) {
 		gpiod_lookup_table = &soc_panel_gpio_table;
-		want_panel_gpio = true;
-		want_backlight_gpio = true;
+
+		if (!connector->panel.vbt.dsi.sequence[MIPI_SEQ_ASSERT_RESET] &&
+		    !connector->panel.vbt.dsi.sequence[MIPI_SEQ_DEASSERT_RESET])
+			want_panel_gpio = true;
+
+		if (!connector->panel.vbt.dsi.sequence[MIPI_SEQ_BACKLIGHT_OFF] &&
+		    !connector->panel.vbt.dsi.sequence[MIPI_SEQ_BACKLIGHT_ON])
+			want_backlight_gpio = true;
 
 		/* Ensure PWM0 pin is muxed as PWM instead of GPIO */
 		ret = pinctrl_register_mappings(soc_pwm_pinctrl_map,

> +
> +	if (gpio_desc && connector->panel.vbt.dsi.config->pwm_blc == PPS_BLC_SOC) {
> +		gpiod_set_value_cansleep(gpio_desc, value);
> +		return;
> +	}
> +
>  	soc_opaque_gpio_set_value(connector, gpio_index,
>  				  "INT33FC:01", "Panel N", gpio_index, value);
>  }
> @@ -430,7 +452,7 @@ static const u8 *mipi_exec_gpio(struct intel_dsi *intel_dsi, const u8 *data)
>  	else if (DISPLAY_VER(display) >= 9)
>  		bxt_gpio_set_value(connector, gpio_index, value);
>  	else if (display->platform.valleyview)
> -		vlv_gpio_set_value(connector, gpio_source, gpio_number, value);
> +		vlv_gpio_set_value(intel_dsi, gpio_source, gpio_number, value);
>  	else if (display->platform.cherryview)
>  		chv_gpio_set_value(connector, gpio_source, gpio_number, value);
>  
> @@ -886,8 +908,8 @@ static struct gpiod_lookup_table pmic_panel_gpio_table = {
>  static struct gpiod_lookup_table soc_panel_gpio_table = {
>  	.dev_id = "0000:00:02.0",
>  	.table = {
> -		GPIO_LOOKUP("INT33FC:01", 10, "backlight", GPIO_ACTIVE_HIGH),
> -		GPIO_LOOKUP("INT33FC:01", 11, "panel", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("INT33FC:01", VLV_GPIO_NC_BACKLIGHT, "backlight", GPIO_ACTIVE_HIGH),
> +		GPIO_LOOKUP("INT33FC:01", VLV_GPIO_NC_PANEL, "panel", GPIO_ACTIVE_HIGH),
>  		{ }
>  	},
>  };
> 
> ---
> base-commit: 0507cc5a476af0b6d037b19248bdd20dbe27487d
> change-id: 20261018-vlv-dsi-owned-gpios-cd127ba137e7
> 
> Best regards,
> --  
> Mike Anderson <mwwa919@gmail.com>
> 

-- 
Ville Syrjälä
Intel
