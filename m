Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A7AC5DF80
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB0A10EA70;
	Tue, 18 Aug 2026 08:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HJ49Mt2H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC8BB10EA70
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787043317; x=1818579317;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Tn7jI98e+vGuQ3H7rNVXuXEnFAs5nvRGa4IW2cG8LI4=;
 b=HJ49Mt2Hoq4jRicmzn/7woj/Ouf0EAxYGDVITaVmsOf/gX8Hp2wa45I1
 qEBGNG3ujG0K+yF7s4h3xlavAb9fZMgsHyQ/Yv3xQZBWRD0TogK76NPJA
 ifoh6P5XENvy/kyXOYM3IF+KCOsZ51QcfAellNAIkF0YhZdSPKKBlsjdC
 xMuW4J2sgYBx1VfSXK8/UdonLmd67LD8K2QF4duTKqhQ3BwZS56n6bMxo
 k8akmPG6IfJ2zU9O+sKspC/CV2ScaVchEnH+awXHoi+ASrxLiOw3BtSc3
 3D1M6ubdz8N1rR/md2VTQYwH1WokM2tPBYWpDgg7wY9v2NZZisgUNKf35 w==;
X-CSE-ConnectionGUID: TBsJpzL0S62FGgtBXP34mA==
X-CSE-MsgGUID: Um+zplmmQvuJv7ey6vQfiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="90042228"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="90042228"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:55:16 -0700
X-CSE-ConnectionGUID: aYEWlZpCQ2KCh+LXcGBG8A==
X-CSE-MsgGUID: dOHrbJSpRMCirl6PWQMqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="269010338"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.209])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 01:55:12 -0700
Date: Tue, 18 Aug 2026 11:55:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Piparo <holofermes@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
Message-ID: <aoQd7qsojnphARpH@ashevche-desk.local>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
 <20260818080626.30430-7-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818080626.30430-7-amit.barzilai22@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Tue, Aug 18, 2026 at 11:06:26AM +0300, Amit Barzilai wrote:
> The Solomon SSD1351 is a 128x128 RGB color OLED controller. It shares the
> SSD133X pixel layout: one 65k color (RGB565) pixel per Segment, written as
> a bulk transfer once a column/row addressing window has been programmed.
> Add it as a new SSD135X_FAMILY rather than as a separate driver, so that
> the ssd130x plane, CRTC and encoder infrastructure is reused.
> 
> Give the family its own primary plane update and disable, encoder enable
> and backlight callbacks instead of teaching the ssd133x ones about a second
> family. Only the callbacks that carry no family specific logic are reused
> as is: ssd133x_primary_plane_atomic_check(), ssd133x_crtc_atomic_check()
> and ssd130x_encoder_atomic_disable().
> 
> The data path differs from the ssd133x family in one respect. The SSD1351
> only starts accepting pixel data after an explicit Write RAM command
> (0x5c), while the SSD133X enters data mode as soon as the address window
> has been programmed. Emit it from ssd135x_update_rect(), which both the
> damage update and the clear screen paths go through.
> 
> SSD1351 differs from previous controllers in the command protocol. While
> the opcode is still sent on the command path, the parameters are sent on
> the data path. Introduce the cmd_params_are_data flag to struct
> ssd130x_deviceinfo and let ssd130x_write_cmds() split the buffer in
> accordance to the device specifications.
> 
> The SSD1351 also needs its own init sequence (ssd135x_init). The remap
> byte is fixed at horizontal address increment, COM split, reversed COM
> scan direction, BGR sub-pixel order and 65k color depth; rotation is not
> supported.
> 
> Contrast is calibrated per color channel as for the ssd133x family, but
> the three channels are parameters of a single command (0xc1) instead of
> one command per channel. Add ssd135x_set_contrast() for that and use it
> from both the init and the backlight update paths.
> 
> The SSD1351 is SPI-only, so only the SPI transport match tables gain an
> entry; no new config symbol is needed.

...

>  static int ssd130x_write_cmds(struct ssd130x_device *ssd130x, const u8 *cmd,
>  			      size_t len)

>  	unsigned int i;
>  	int ret;
>  
> +	if (ssd130x->device_info->cmd_params_are_data) {
> +		if (!len)
> +			return 0;
> +
> +		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[0]);
> +		if (ret || len == 1)
> +			return ret;
> +
> +		return ssd130x_write_data(ssd130x, cmd + 1, len - 1);
> +	}
> +
>  	for (i = 0; i < len; i++) {
>  		ret = regmap_write(ssd130x->regmap, SSD13XX_COMMAND, cmd[i]);
>  		if (ret)

>  	return ssd130x_run_cmd_seq(ssd130x, cmds);
>  }

...

> +static int ssd135x_init(struct ssd130x_device *ssd130x)
> +{
> +	/*
> +	 * Horizontal address increment, COM split, reversed COM scan direction,
> +	 * BGR sub-pixel order and 65k (RGB565) color depth. Rotation is not
> +	 * supported, so the remap byte is fixed.
> +	 */
> +	u8 remap = SSD135X_SET_REMAP_65K | SSD135X_SET_REMAP_COM_SPLIT |
> +		   SSD135X_SET_REMAP_COLOR_BGR | SSD135X_SET_REMAP_COM_SCAN;

Same comment about const.

> +	int ret;

Why not placing it after cmds?

> +	const u8 cmds[] = {
> +		/* Unlock the controller, then the extended command set */
> +		2, SSD135X_SET_COMMAND_LOCK, 0x12,
> +		2, SSD135X_SET_COMMAND_LOCK, 0xb1,
> +		1, SSD13XX_DISPLAY_OFF,
> +		2, SSD135X_SET_CLOCK_FREQ, 0xf1,
> +		2, SSD135X_SET_MUX_RATIO, ssd130x->height - 1,
> +		3, SSD135X_SET_COL_RANGE, 0x00, ssd130x->width - 1,
> +		3, SSD135X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
> +		2, SSD135X_SET_DISPLAY_START, 0x00,
> +		2, SSD135X_SET_DISPLAY_OFFSET, 0x00,
> +		2, SSD135X_SET_GPIO, 0x00,
> +		2, SSD135X_SET_FUNCTION, 0x01,
> +		2, SSD135X_SET_PHASE_LENGTH, 0x32,
> +		4, SSD135X_SET_VSL, 0xa0, 0xb5, 0x55,
> +		2, SSD135X_SET_PRECHARGE_VOLTAGE, 0x17,
> +		2, SSD135X_SET_VCOMH_VOLTAGE, 0x05,
> +		2, SSD135X_SET_CONTRAST_MASTER, 0x0f,
> +		2, SSD135X_SET_PRECHARGE2, 0x01,
> +		1, SSD135X_SET_DISPLAY_NORMAL,
> +		2, SSD13XX_SET_SEG_REMAP, remap,
> +		0,
> +	};
> +
> +	ret = ssd130x_run_cmd_seq(ssd130x, cmds);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
> +}

...

> +static void ssd135x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
> +{
> +	struct drm_rect screen = DRM_RECT_INIT(0, 0, ssd130x->width, ssd130x->height);
> +	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
> +	unsigned int pitch;

> +	if (!fi)
> +		return;

It's less maintainable than

	const struct drm_format_info *fi;
	unsigned int pitch;

	fi = drm_format_info(DRM_FORMAT_RGB565);
	if (!fi)
		return;


> +	pitch = drm_format_info_min_pitch(fi, 0, ssd130x->width);
> +
> +	memset(data_array, 0, pitch * ssd130x->height);
> +
> +	ssd135x_update_rect(ssd130x, &screen, data_array, pitch);
> +}

...

> +static int ssd135x_fb_blit_rect(struct drm_framebuffer *fb,
> +				const struct iosys_map *vmap,
> +				struct drm_rect *rect, u8 *data_array,
> +				struct drm_format_conv_state *fmtcnv_state)
> +{
> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
> +	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
> +	unsigned int dst_pitch;
> +	struct iosys_map dst;
> +
> +	if (!fi)
> +		return -EINVAL;

Ditto. The problem is that the current style is tempting for subtle mistakes
such as defining more variables that may use fi in between.

> +	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
> +
> +	iosys_map_set_vaddr(&dst, data_array);
> +	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
> +
> +	ssd135x_update_rect(ssd130x, rect, data_array, dst_pitch);
> +
> +	return 0;
> +}

...

> +static void ssd135x_primary_plane_atomic_disable(struct drm_plane *plane,
> +						 struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm = plane->dev;
> +	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_crtc_state *crtc_state;
> +	struct ssd130x_crtc_state *ssd130x_crtc_state;
> +	int idx;
> +
> +	if (!plane_state->crtc)
> +		return;

In the similar way here.

> +	crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
> +	ssd130x_crtc_state = to_ssd130x_crtc_state(crtc_state);
> +
> +	if (!drm_dev_enter(drm, &idx))
> +		return;
> +
> +	ssd135x_clear_screen(ssd130x, ssd130x_crtc_state->data_array);
> +
> +	drm_dev_exit(idx);
> +}

-- 
With Best Regards,
Andy Shevchenko


