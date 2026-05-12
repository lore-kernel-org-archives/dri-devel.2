Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CA9CD4855
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BBE10E9A6;
	Tue, 12 May 2026 08:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CSRZZqjN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hFUYmwyG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CSRZZqjN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hFUYmwyG";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F105E10E689
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:24:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7E1675BE4;
 Tue, 12 May 2026 08:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778574270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4iBq1/ABJqkll5FE9u9WRAC0iYpsY0AQY5N1i1CvLw4=;
 b=CSRZZqjNq7wh6aFVc9MYF5apKg4+yHmbAs9+C3W7v+8voL4BsFwBHwGokjc+JUlfLUgPUl
 +ErCalxFbGBubiHfH6amkLqL7MfhgpoK3qR8N1OPKy2cccCcQAv19kQUTh0wvgvUglxA7P
 pNDDXbARH0zGjqESJ7mnRh3H2KG8Dnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778574270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4iBq1/ABJqkll5FE9u9WRAC0iYpsY0AQY5N1i1CvLw4=;
 b=hFUYmwyGsWR7OeUX868+rn9YOHtF59p/a65GotIAhtVcMInDeCdZk41NQ36AcWkIdsZKbB
 9e/xsVF+1lmKCVAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778574270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4iBq1/ABJqkll5FE9u9WRAC0iYpsY0AQY5N1i1CvLw4=;
 b=CSRZZqjNq7wh6aFVc9MYF5apKg4+yHmbAs9+C3W7v+8voL4BsFwBHwGokjc+JUlfLUgPUl
 +ErCalxFbGBubiHfH6amkLqL7MfhgpoK3qR8N1OPKy2cccCcQAv19kQUTh0wvgvUglxA7P
 pNDDXbARH0zGjqESJ7mnRh3H2KG8Dnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778574270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4iBq1/ABJqkll5FE9u9WRAC0iYpsY0AQY5N1i1CvLw4=;
 b=hFUYmwyGsWR7OeUX868+rn9YOHtF59p/a65GotIAhtVcMInDeCdZk41NQ36AcWkIdsZKbB
 9e/xsVF+1lmKCVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46DBD593A9;
 Tue, 12 May 2026 08:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJT4D77jAmqadgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 12 May 2026 08:24:30 +0000
Message-ID: <5157ab4d-3195-49f3-a3e9-aef6d58e869e@suse.de>
Date: Tue, 12 May 2026 10:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/verisilicon: add support for Nuvoton MA35D1
 DCUltra Lite display controller
To: Joey Lu <a0987203069@gmail.com>, zhengxingda@iscas.ac.cn,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260511075142.54752-3-a0987203069@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[dt]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[16];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,iscas.ac.cn,linux.intel.com,kernel.org,ffwll.ch]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.com:url,
 imap1.dmz-prg2.suse.org:helo]
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

Hi,

instead of this if-else branchery, I strongly recommend to add a new 
file with a new mode-setting pipeline for the new chipset.  You can 
share existing helpers where possible, and implement variants where 
chips differ.  It's a bit more code, but will be a lot easier to 
maintain in the future.

See ast and mgag200 for example. Both drivers support various revisions 
of their chipset, where each rev has its oddities.

Best regards
Thomas

Am 11.05.26 um 09:51 schrieb Joey Lu:
> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltra Lite display
> controller, which is a previous generation of the DC8000 series. While
> the general register layout is similar to the DC8000, there are several
> key differences that require per-variant handling in the driver.
>
> Add a vs_dc_info platform data structure (in vs_hwdb.h) to describe
> per-IP-variant capabilities, and use it throughout the driver to select
> the correct code paths at runtime.
>
> Key differences between DC8000 and DCUltra Lite handled:
>
> 1. No chip identity registers (0x0020-0x0030): DCUltra Lite uses static
>     platform data instead of reading model/revision/customer_id from HW.
>
> 2. No CONFIG_EX commit mechanism: DC8000 uses registers at 0x1CC0
>     (FB_CONFIG_EX), 0x24D8 (FB_TOP_LEFT), 0x24E0 (FB_BOTTOM_RIGHT),
>     0x2510 (FB_BLEND_CONFIG), 0x2518 (PANEL_CONFIG_EX). DCUltra Lite
>     omits all of these and instead uses enable/reset bits in FB_CONFIG
>     (bit 0 = enable, bit 4 = reset) for direct framebuffer updates.
>
> 3. No PANEL_START register (0x1CCC): DCUltra Lite panel output starts
>     when PANEL_CONFIG.RUNNING is set; no separate multi-display sync
>     start register is needed.
>
> 4. Different IRQ registers: DCUltra Lite uses 0x147C (IRQ_STA) /
>     0x1480 (IRQ_EN); DC8000 uses 0x0010 (IRQ_ACK) / 0x0014 (IRQ_EN).
>
> 5. Different clock/reset topology: DCUltra Lite requires only "core"
>     (bus gate) and "pix0" (pixel divider) clocks with no reset lines
>     managed by the driver. DC8000 needs core/axi/ahb clocks and three
>     resets.
>
> 6. Single output only: DCUltra Lite has one display output; per-output
>     index logic is still in place but display_count is fixed at 1.
>
> 7. Reduced register space: max_register is 0x2000 vs DC8000's 0x2544.
>
> Add the "nuvoton,ma35d1-dcu" compatible string to the OF match table,
> extend Kconfig to allow building on ARCH_MA35 platforms, and expose
> vs_formats_no_yuv444 as the default format table for DCUltra Lite
> (YUV444 blending is a DC8000-only feature).
>
> All changes have been tested on Nuvoton MA35D1 hardware and are
> functioning correctly.
>
> Signed-off-by: Joey Lu <a0987203069@gmail.com>
> ---
>   drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
>   drivers/gpu/drm/verisilicon/vs_bridge.c       |  28 ++--
>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  13 +-
>   drivers/gpu/drm/verisilicon/vs_dc.c           | 129 ++++++++++++------
>   drivers/gpu/drm/verisilicon/vs_dc.h           |   1 +
>   drivers/gpu/drm/verisilicon/vs_drm.c          |  16 ++-
>   drivers/gpu/drm/verisilicon/vs_hwdb.c         |   2 +-
>   drivers/gpu/drm/verisilicon/vs_hwdb.h         |  25 ++++
>   .../gpu/drm/verisilicon/vs_primary_plane.c    |  43 +++---
>   .../drm/verisilicon/vs_primary_plane_regs.h   |   2 +
>   10 files changed, 187 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
> index 7cce86ec8603..295d246eb4b4 100644
> --- a/drivers/gpu/drm/verisilicon/Kconfig
> +++ b/drivers/gpu/drm/verisilicon/Kconfig
> @@ -2,7 +2,7 @@
>   config DRM_VERISILICON_DC
>   	tristate "DRM Support for Verisilicon DC-series display controllers"
>   	depends on DRM && COMMON_CLK
> -	depends on RISCV || COMPILE_TEST
> +	depends on RISCV || ARCH_MA35 || COMPILE_TEST
>   	select DRM_BRIDGE_CONNECTOR
>   	select DRM_CLIENT_SELECTION
>   	select DRM_DISPLAY_HELPER
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index 7a93049368db..225af322de32 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -164,13 +164,16 @@ static void vs_bridge_enable_common(struct vs_crtc *crtc,
>   			VSDC_DISP_PANEL_CONFIG_CLK_EN);
>   	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
>   			VSDC_DISP_PANEL_CONFIG_RUNNING);
> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			VSDC_DISP_PANEL_START_RUNNING(output));
>   
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	if (dc->info->has_config_ex) {
> +		regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +				  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
> +				VSDC_DISP_PANEL_START_RUNNING(output));
> +
> +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	}
>   }
>   
>   static void vs_bridge_atomic_enable_dpi(struct drm_bridge *bridge,
> @@ -228,14 +231,17 @@ static void vs_bridge_atomic_disable(struct drm_bridge *bridge,
>   	struct vs_dc *dc = crtc->dc;
>   	unsigned int output = crtc->id;
>   
> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> -			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> -			  VSDC_DISP_PANEL_START_RUNNING(output));
>   	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
>   			  VSDC_DISP_PANEL_CONFIG_RUNNING);
>   
> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	if (dc->info->has_config_ex) {
> +		regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
> +				  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC |
> +				  VSDC_DISP_PANEL_START_RUNNING(output));
> +
> +		regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> +				VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
> +	}
>   }
>   
>   static const struct drm_bridge_funcs vs_dpi_bridge_funcs = {
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
> index 9080344398ca..2f3e6d41c657 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -18,6 +18,7 @@
>   #include "vs_dc.h"
>   #include "vs_dc_top_regs.h"
>   #include "vs_drm.h"
> +#include "vs_hwdb.h"
>   #include "vs_plane.h"
>   
>   static void vs_crtc_atomic_disable(struct drm_crtc *crtc,
> @@ -132,7 +133,11 @@ static int vs_crtc_enable_vblank(struct drm_crtc *crtc)
>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>   	struct vs_dc *dc = vcrtc->dc;
>   
> -	regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN, VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE)
> +		regmap_write(dc->regs, VSDC_DISP_IRQ_EN, BIT(0));
> +	else
> +		regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
> +				VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>   
>   	return 0;
>   }
> @@ -142,7 +147,11 @@ static void vs_crtc_disable_vblank(struct drm_crtc *crtc)
>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>   	struct vs_dc *dc = vcrtc->dc;
>   
> -	regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN, VSDC_TOP_IRQ_VSYNC(vcrtc->id));
> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE)
> +		regmap_write(dc->regs, VSDC_DISP_IRQ_EN, 0);
> +	else
> +		regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
> +				  VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>   }
>   
>   static const struct drm_crtc_funcs vs_crtc_funcs = {
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
> index dad9967bc10b..82a6a26f6d81 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
> @@ -9,21 +9,45 @@
>   #include <linux/of_graph.h>
>   
>   #include "vs_crtc.h"
> +#include "vs_crtc_regs.h"
>   #include "vs_dc.h"
>   #include "vs_dc_top_regs.h"
>   #include "vs_drm.h"
>   #include "vs_hwdb.h"
>   
> -static const struct regmap_config vs_dc_regmap_cfg = {
> +static const struct regmap_config vs_dc8000_regmap_cfg = {
>   	.reg_bits = 32,
>   	.val_bits = 32,
>   	.reg_stride = sizeof(u32),
> -	/* VSDC_OVL_CONFIG_EX(1) */
>   	.max_register = 0x2544,
>   };
>   
> +static const struct regmap_config vs_dcultra_lite_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = sizeof(u32),
> +	.max_register = 0x2000,
> +};
> +
> +static const struct vs_dc_info vs_dc8000_info = {
> +	.family = VS_DC_FAMILY_DC8000,
> +	.has_chip_id = true,
> +	.has_config_ex = true,
> +	.regmap_cfg = &vs_dc8000_regmap_cfg,
> +};
> +
> +static const struct vs_dc_info vs_dcultra_lite_info = {
> +	.family = VS_DC_FAMILY_DCULTRA_LITE,
> +	.display_count = 1,
> +	.has_chip_id = false,
> +	.has_config_ex = false,
> +	.regmap_cfg = &vs_dcultra_lite_regmap_cfg,
> +	.formats = &vs_formats_no_yuv444,
> +};
> +
>   static const struct of_device_id vs_dc_driver_dt_match[] = {
> -	{ .compatible = "verisilicon,dc" },
> +	{ .compatible = "verisilicon,dc", .data = &vs_dc8000_info },
> +	{ .compatible = "nuvoton,ma35d1-dcu", .data = &vs_dcultra_lite_info },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, vs_dc_driver_dt_match);
> @@ -33,6 +57,13 @@ static irqreturn_t vs_dc_irq_handler(int irq, void *private)
>   	struct vs_dc *dc = private;
>   	u32 irqs;
>   
> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE) {
> +		regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
> +		if (irqs & BIT(0))
> +			vs_drm_handle_irq(dc, VSDC_TOP_IRQ_VSYNC(0));
> +		return IRQ_HANDLED;
> +	}
> +
>   	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
>   
>   	vs_drm_handle_irq(dc, irqs);
> @@ -43,6 +74,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void *private)
>   static int vs_dc_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> +	const struct vs_dc_info *info;
>   	struct vs_dc *dc;
>   	void __iomem *regs;
>   	unsigned int port_count, i;
> @@ -55,6 +87,10 @@ static int vs_dc_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +	info = of_device_get_match_data(dev);
> +	if (!info)
> +		return -ENODEV;
> +
>   	port_count = of_graph_get_port_count(dev->of_node);
>   	if (!port_count) {
>   		dev_err(dev, "can't find DC downstream ports\n");
> @@ -75,15 +111,31 @@ static int vs_dc_probe(struct platform_device *pdev)
>   	if (!dc)
>   		return -ENOMEM;
>   
> -	dc->rsts[0].id = "core";
> -	dc->rsts[1].id = "axi";
> -	dc->rsts[2].id = "ahb";
> +	dc->info = info;
>   
> -	ret = devm_reset_control_bulk_get_optional_shared(dev, VSDC_RESET_COUNT,
> -							  dc->rsts);
> -	if (ret) {
> -		dev_err(dev, "can't get reset lines\n");
> -		return ret;
> +	if (info->family == VS_DC_FAMILY_DC8000) {
> +		dc->rsts[0].id = "core";
> +		dc->rsts[1].id = "axi";
> +		dc->rsts[2].id = "ahb";
> +
> +		ret = devm_reset_control_bulk_get_optional_shared(dev,
> +				VSDC_RESET_COUNT, dc->rsts);
> +		if (ret) {
> +			dev_err(dev, "can't get reset lines\n");
> +			return ret;
> +		}
> +
> +		dc->axi_clk = devm_clk_get_enabled(dev, "axi");
> +		if (IS_ERR(dc->axi_clk)) {
> +			dev_err(dev, "can't get axi clock\n");
> +			return PTR_ERR(dc->axi_clk);
> +		}
> +
> +		dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
> +		if (IS_ERR(dc->ahb_clk)) {
> +			dev_err(dev, "can't get ahb clock\n");
> +			return PTR_ERR(dc->ahb_clk);
> +		}
>   	}
>   
>   	dc->core_clk = devm_clk_get_enabled(dev, "core");
> @@ -92,28 +144,18 @@ static int vs_dc_probe(struct platform_device *pdev)
>   		return PTR_ERR(dc->core_clk);
>   	}
>   
> -	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
> -	if (IS_ERR(dc->axi_clk)) {
> -		dev_err(dev, "can't get axi clock\n");
> -		return PTR_ERR(dc->axi_clk);
> -	}
> -
> -	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
> -	if (IS_ERR(dc->ahb_clk)) {
> -		dev_err(dev, "can't get ahb clock\n");
> -		return PTR_ERR(dc->ahb_clk);
> -	}
> -
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
>   		dev_err(dev, "can't get irq\n");
>   		return irq;
>   	}
>   
> -	ret = reset_control_bulk_deassert(VSDC_RESET_COUNT, dc->rsts);
> -	if (ret) {
> -		dev_err(dev, "can't deassert reset lines\n");
> -		return ret;
> +	if (info->family == VS_DC_FAMILY_DC8000) {
> +		ret = reset_control_bulk_deassert(VSDC_RESET_COUNT, dc->rsts);
> +		if (ret) {
> +			dev_err(dev, "can't deassert reset lines\n");
> +			return ret;
> +		}
>   	}
>   
>   	regs = devm_platform_ioremap_resource(pdev, 0);
> @@ -123,23 +165,30 @@ static int vs_dc_probe(struct platform_device *pdev)
>   		goto err_rst_assert;
>   	}
>   
> -	dc->regs = devm_regmap_init_mmio(dev, regs, &vs_dc_regmap_cfg);
> +	dc->regs = devm_regmap_init_mmio(dev, regs, info->regmap_cfg);
>   	if (IS_ERR(dc->regs)) {
>   		ret = PTR_ERR(dc->regs);
>   		goto err_rst_assert;
>   	}
>   
> -	ret = vs_fill_chip_identity(dc->regs, &dc->identity);
> -	if (ret)
> -		goto err_rst_assert;
> +	if (info->has_chip_id) {
> +		ret = vs_fill_chip_identity(dc->regs, &dc->identity);
> +		if (ret)
> +			goto err_rst_assert;
>   
> -	dev_info(dev, "Found DC%x rev %x customer %x\n", dc->identity.model,
> -		 dc->identity.revision, dc->identity.customer_id);
> +		dev_info(dev, "Found DC%x rev %x customer %x\n",
> +			 dc->identity.model, dc->identity.revision,
> +			 dc->identity.customer_id);
>   
> -	if (port_count > dc->identity.display_count) {
> -		dev_err(dev, "too many downstream ports than HW capability\n");
> -		ret = -EINVAL;
> -		goto err_rst_assert;
> +		if (port_count > dc->identity.display_count) {
> +			dev_err(dev, "too many downstream ports than HW capability\n");
> +			ret = -EINVAL;
> +			goto err_rst_assert;
> +		}
> +	} else {
> +		/* Fill identity from platform data */
> +		dc->identity.display_count = info->display_count;
> +		dc->identity.formats = info->formats;
>   	}
>   
>   	for (i = 0; i < dc->identity.display_count; i++) {
> @@ -168,7 +217,8 @@ static int vs_dc_probe(struct platform_device *pdev)
>   	return 0;
>   
>   err_rst_assert:
> -	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
> +	if (info->family == VS_DC_FAMILY_DC8000)
> +		reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
>   	return ret;
>   }
>   
> @@ -180,7 +230,8 @@ static void vs_dc_remove(struct platform_device *pdev)
>   
>   	dev_set_drvdata(&pdev->dev, NULL);
>   
> -	reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
> +	if (dc->info->family == VS_DC_FAMILY_DC8000)
> +		reset_control_bulk_assert(VSDC_RESET_COUNT, dc->rsts);
>   }
>   
>   static void vs_dc_shutdown(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h b/drivers/gpu/drm/verisilicon/vs_dc.h
> index ed1016f18758..f0613519af37 100644
> --- a/drivers/gpu/drm/verisilicon/vs_dc.h
> +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
> @@ -31,6 +31,7 @@ struct vs_dc {
>   	struct clk *pix_clk[VSDC_MAX_OUTPUTS];
>   	struct reset_control_bulk_data rsts[VSDC_RESET_COUNT];
>   
> +	const struct vs_dc_info *info;
>   	struct vs_drm_dev *drm_dev;
>   	struct vs_chip_identity identity;
>   };
> diff --git a/drivers/gpu/drm/verisilicon/vs_drm.c b/drivers/gpu/drm/verisilicon/vs_drm.c
> index fd259d53f49f..ff0fc6673006 100644
> --- a/drivers/gpu/drm/verisilicon/vs_drm.c
> +++ b/drivers/gpu/drm/verisilicon/vs_drm.c
> @@ -27,6 +27,7 @@
>   #include "vs_dc.h"
>   #include "vs_dc_top_regs.h"
>   #include "vs_drm.h"
> +#include "vs_hwdb.h"
>   
>   #define DRIVER_NAME	"verisilicon"
>   #define DRIVER_DESC	"Verisilicon DC-series display controller driver"
> @@ -72,12 +73,19 @@ static struct drm_mode_config_helper_funcs vs_mode_config_helper_funcs = {
>   	.atomic_commit_tail = drm_atomic_helper_commit_tail,
>   };
>   
> -static void vs_mode_config_init(struct drm_device *drm)
> +static void vs_mode_config_init(struct drm_device *drm, struct vs_dc *dc)
>   {
>   	drm->mode_config.min_width = 0;
>   	drm->mode_config.min_height = 0;
> -	drm->mode_config.max_width = 8192;
> -	drm->mode_config.max_height = 8192;
> +
> +	if (dc->info->family == VS_DC_FAMILY_DCULTRA_LITE) {
> +		drm->mode_config.max_width = 1920;
> +		drm->mode_config.max_height = 1080;
> +	} else {
> +		drm->mode_config.max_width = 8192;
> +		drm->mode_config.max_height = 8192;
> +	}
> +
>   	drm->mode_config.funcs = &vs_mode_config_funcs;
>   	drm->mode_config.helper_private = &vs_mode_config_helper_funcs;
>   }
> @@ -125,7 +133,7 @@ int vs_drm_initialize(struct vs_dc *dc, struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	vs_mode_config_init(drm);
> +	vs_mode_config_init(drm, dc);
>   
>   	/* Enable connectors polling */
>   	drm_kms_helper_poll_init(drm);
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> index 09336af0900a..39402d75d841 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -78,7 +78,7 @@ static const u32 vs_formats_array_with_yuv444[] = {
>   	/* TODO: non-RGB formats */
>   };
>   
> -static const struct vs_formats vs_formats_no_yuv444 = {
> +const struct vs_formats vs_formats_no_yuv444 = {
>   	.array = vs_formats_array_no_yuv444,
>   	.num = ARRAY_SIZE(vs_formats_array_no_yuv444)
>   };
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> index 92192e4fa086..655cf93ca3aa 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> @@ -14,6 +14,29 @@ struct vs_formats {
>   	unsigned int num;
>   };
>   
> +enum vs_dc_family {
> +	VS_DC_FAMILY_DC8000,
> +	VS_DC_FAMILY_DCULTRA_LITE,
> +};
> +
> +/**
> + * struct vs_dc_info - per-SoC DC platform data
> + * @family:		DC IP family (DC8000, DCUltra Lite, etc.)
> + * @display_count:	number of display outputs (0 = auto-detect from DT/HW)
> + * @has_chip_id:	whether chip identity registers exist
> + * @has_config_ex:	whether CONFIG_EX commit mechanism exists
> + * @regmap_cfg:		regmap configuration for this variant
> + * @formats:		supported pixel formats (NULL = auto-detect from chip ID)
> + */
> +struct vs_dc_info {
> +	enum vs_dc_family family;
> +	u32 display_count;
> +	bool has_chip_id;
> +	bool has_config_ex;
> +	const struct regmap_config *regmap_cfg;
> +	const struct vs_formats *formats;
> +};
> +
>   struct vs_chip_identity {
>   	u32 model;
>   	u32 revision;
> @@ -23,6 +46,8 @@ struct vs_chip_identity {
>   	const struct vs_formats *formats;
>   };
>   
> +extern const struct vs_formats vs_formats_no_yuv444;
> +
>   int vs_fill_chip_identity(struct regmap *regs,
>   			  struct vs_chip_identity *ident);
>   
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index 1f2be41ae496..197d5d683e22 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -55,8 +55,9 @@ static int vs_primary_plane_atomic_check(struct drm_plane *plane,
>   
>   static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int output)
>   {
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_COMMIT);
> +	if (dc->info->has_config_ex)
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				VSDC_FB_CONFIG_EX_COMMIT);
>   }
>   
>   static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
> @@ -69,11 +70,13 @@ static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
>   	unsigned int output = vcrtc->id;
>   	struct vs_dc *dc = vcrtc->dc;
>   
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> +	if (dc->info->has_config_ex) {
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				VSDC_FB_CONFIG_EX_FB_EN);
> +		regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
> +				   VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
> +	}
>   
>   	vs_primary_plane_commit(dc, output);
>   }
> @@ -88,8 +91,9 @@ static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
>   	unsigned int output = vcrtc->id;
>   	struct vs_dc *dc = vcrtc->dc;
>   
> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> -			VSDC_FB_CONFIG_EX_FB_EN);
> +	if (dc->info->has_config_ex)
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> +				VSDC_FB_CONFIG_EX_FB_EN);
>   
>   	vs_primary_plane_commit(dc, output);
>   }
> @@ -126,6 +130,11 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
>   			   VSDC_FB_CONFIG_UV_SWIZZLE_EN,
>   			   vs_state->format.uv_swizzle);
>   
> +	/* DCUltra Lite requires explicit enable/reset bits in FB_CONFIG */
> +	if (!dc->info->has_config_ex)
> +		regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
> +				VSDC_FB_CONFIG_ENABLE | VSDC_FB_CONFIG_RESET);
> +
>   	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
>   
>   	regmap_write(dc->regs, VSDC_FB_ADDRESS(output),
> @@ -133,16 +142,18 @@ static void vs_primary_plane_atomic_update(struct drm_plane *plane,
>   	regmap_write(dc->regs, VSDC_FB_STRIDE(output),
>   		     fb->pitches[0]);
>   
> -	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> -		     VSDC_MAKE_PLANE_POS(state->crtc_x, state->crtc_y));
> -	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> -		     VSDC_MAKE_PLANE_POS(state->crtc_x + state->crtc_w,
> -					 state->crtc_y + state->crtc_h));
>   	regmap_write(dc->regs, VSDC_FB_SIZE(output),
>   		     VSDC_MAKE_PLANE_SIZE(state->crtc_w, state->crtc_h));
>   
> -	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> -		     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> +	if (dc->info->has_config_ex) {
> +		regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
> +			     VSDC_MAKE_PLANE_POS(state->crtc_x, state->crtc_y));
> +		regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
> +			     VSDC_MAKE_PLANE_POS(state->crtc_x + state->crtc_w,
> +						 state->crtc_y + state->crtc_h));
> +		regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
> +			     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
> +	}
>   
>   	vs_primary_plane_commit(dc, output);
>   }
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> index cbb125c46b39..288064760b48 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> @@ -16,6 +16,8 @@
>   #define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
>   
>   #define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
> +#define VSDC_FB_CONFIG_ENABLE			BIT(0)
> +#define VSDC_FB_CONFIG_RESET			BIT(4)
>   #define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
>   #define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13, 11)
>   #define VSDC_FB_CONFIG_ROT(v)			((v) << 11)

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


