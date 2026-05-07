Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6E4CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D7410E18B;
	Thu,  7 May 2026 06:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="iS8wK0tE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b2uwiEXS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iS8wK0tE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b2uwiEXS";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FABF10E18B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 06:07:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA5226C0B9;
 Thu,  7 May 2026 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778134055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yitmUNX5qry8C6kAIHkb/BHeQ8+xsSzpFY0NAW8cW8=;
 b=iS8wK0tECUzCEss3unO8zP0BH5UgRVOcm+a2HyplJuPe3KYjXi7X4UkUPetUBfOgPpjpPR
 +gc74xZ0XIC7/AgToKwiQo1+QL560U1rBi6RXLpNnoMPU3geZLk+Vhut9027nmnTSK+TzI
 9k+GltHDJ4gzrBmQkfpF76fPArpi5aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778134055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yitmUNX5qry8C6kAIHkb/BHeQ8+xsSzpFY0NAW8cW8=;
 b=b2uwiEXSYDZ4Anj7Pm6YTXwRwKPgMQ6iXVSl8m7cch013G5FOyy2lNZFoUrUCfE+Vapo3u
 8MgiN/JiM9C9oqDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778134055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yitmUNX5qry8C6kAIHkb/BHeQ8+xsSzpFY0NAW8cW8=;
 b=iS8wK0tECUzCEss3unO8zP0BH5UgRVOcm+a2HyplJuPe3KYjXi7X4UkUPetUBfOgPpjpPR
 +gc74xZ0XIC7/AgToKwiQo1+QL560U1rBi6RXLpNnoMPU3geZLk+Vhut9027nmnTSK+TzI
 9k+GltHDJ4gzrBmQkfpF76fPArpi5aE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778134055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3yitmUNX5qry8C6kAIHkb/BHeQ8+xsSzpFY0NAW8cW8=;
 b=b2uwiEXSYDZ4Anj7Pm6YTXwRwKPgMQ6iXVSl8m7cch013G5FOyy2lNZFoUrUCfE+Vapo3u
 8MgiN/JiM9C9oqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70C03593A7;
 Thu,  7 May 2026 06:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oVa4GScs/GmkNgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 07 May 2026 06:07:35 +0000
Message-ID: <49290671-92ee-4fbc-aef9-972ac976cf42@suse.de>
Date: Thu, 7 May 2026 08:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm: verisilicon: add support for cursor planes
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>
References: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
 <20260506175610.2542888-3-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260506175610.2542888-3-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com,icenowy.me]; 
 RCPT_COUNT_SEVEN(0.00)[9]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 suse.de:email, suse.de:mid]
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

Hi

Am 06.05.26 um 19:56 schrieb Icenowy Zheng:
> Verisilicon display controllers support hardware cursors per output
> port.
>
> Add support for them as cursor planes.
>
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

You should get commit access to drm-misc, if you haven't already.

https://drm.pages.freedesktop.org/maintainer-tools/committer/commit-access.html

Best regards
Thomas

> ---
> Changes in v3:
> - Moved the validity check for max_cursor_size to
>    vs_cursor_plane_init().
> - Removed NULL check for new_plane_state->fb because
>    drm_atomic_helper_check_plane_state() will set visibility to false in
>    such case.
> Changes in v2:
> - Use is_power_of_two instead of switch to validate cursor size.
> - Remove unneeded format check.
> - Skip the whole validity check if the plane is invisible (previously
>    it's only skipped when the plane is not bound to CRTC).
> - Explicitly set modifiers list (linear only).
>
>   drivers/gpu/drm/verisilicon/Makefile          |   3 +-
>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  11 +-
>   drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 272 ++++++++++++++++++
>   .../drm/verisilicon/vs_cursor_plane_regs.h    |  44 +++
>   drivers/gpu/drm/verisilicon/vs_plane.h        |   1 +
>   5 files changed, 328 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane.c
>   create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>
> diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
> index fd8d805fbcde1..426f4bcaa834d 100644
> --- a/drivers/gpu/drm/verisilicon/Makefile
> +++ b/drivers/gpu/drm/verisilicon/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
> -verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o vs_hwdb.o vs_plane.o vs_primary_plane.o
> +verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o vs_hwdb.o \
> +	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
>   
>   obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
> diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c b/drivers/gpu/drm/verisilicon/vs_crtc.c
> index f494017130006..5c9714a3e69a7 100644
> --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> @@ -159,7 +159,7 @@ struct vs_crtc *vs_crtc_init(struct drm_device *drm_dev, struct vs_dc *dc,
>   			     unsigned int output)
>   {
>   	struct vs_crtc *vcrtc;
> -	struct drm_plane *primary;
> +	struct drm_plane *primary, *cursor;
>   	int ret;
>   
>   	vcrtc = drmm_kzalloc(drm_dev, sizeof(*vcrtc), GFP_KERNEL);
> @@ -175,9 +175,16 @@ struct vs_crtc *vs_crtc_init(struct drm_device *drm_dev, struct vs_dc *dc,
>   		return ERR_PTR(PTR_ERR(primary));
>   	}
>   
> +	/* Create our cursor plane */
> +	cursor = vs_cursor_plane_init(drm_dev, dc);
> +	if (IS_ERR(cursor)) {
> +		drm_err(drm_dev, "Couldn't create the cursor plane\n");
> +		return ERR_CAST(cursor);
> +	}
> +
>   	ret = drmm_crtc_init_with_planes(drm_dev, &vcrtc->base,
>   					 primary,
> -					 NULL,
> +					 cursor,
>   					 &vs_crtc_funcs,
>   					 NULL);
>   	if (ret) {
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> new file mode 100644
> index 0000000000000..acb9854fa67ed
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -0,0 +1,272 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Institute of Software, Chinese Academy of Sciences (ISCAS)
> + *
> + * Authors:
> + * Icenowy Zheng <zhengxingda@iscas.ac.cn>
> + */
> +
> +#include <linux/log2.h>
> +#include <linux/regmap.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_print.h>
> +
> +#include "vs_crtc.h"
> +#include "vs_plane.h"
> +#include "vs_dc.h"
> +#include "vs_hwdb.h"
> +#include "vs_cursor_plane_regs.h"
> +
> +#define VSDC_MIN_CURSOR_SIZE 32
> +#define VSDC_MAX_CURSOR_SIZE 256
> +
> +#define VSDC_CURSOR_LOCATION_MAX_POSITIVE BIT_MASK(15)
> +#define VSDC_CURSOR_LOCATION_MAX_NEGATIVE BIT_MASK(5)
> +
> +static bool vs_cursor_plane_check_coord(int32_t coord)
> +{
> +	if (coord >= 0)
> +		return coord <= VSDC_CURSOR_LOCATION_MAX_POSITIVE;
> +	else
> +		return (-coord) <= VSDC_CURSOR_LOCATION_MAX_NEGATIVE;
> +}
> +
> +static int vs_cursor_plane_atomic_check(struct drm_plane *plane,
> +					struct drm_atomic_state *state)
> +{
> +	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
> +										 plane);
> +	struct drm_crtc *crtc = new_plane_state->crtc;
> +	struct drm_framebuffer *fb = new_plane_state->fb;
> +	struct drm_crtc_state *crtc_state = NULL;
> +	struct vs_crtc *vcrtc;
> +	struct vs_dc *dc;
> +	int ret;
> +
> +	if (crtc)
> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(new_plane_state,
> +						  crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  true, true);
> +	if (ret)
> +		return ret;
> +
> +	if (!new_plane_state->visible)
> +		return 0; /* Skip validity check */
> +
> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	dc = vcrtc->dc;
> +
> +	/* Only certain PoT square sizes is supported. */
> +	if (!is_power_of_2(new_plane_state->crtc_w) ||
> +	    new_plane_state->crtc_w < VSDC_MIN_CURSOR_SIZE ||
> +	    new_plane_state->crtc_w > dc->identity.max_cursor_size)
> +		return -EINVAL;
> +
> +	if (new_plane_state->crtc_w != new_plane_state->crtc_h)
> +		return -EINVAL;
> +
> +	/* Check if the cursor is inside the register fields' range */
> +	if (!vs_cursor_plane_check_coord(new_plane_state->crtc_x) ||
> +	    !vs_cursor_plane_check_coord(new_plane_state->crtc_y))
> +		return -EINVAL;
> +
> +	/* Extra line padding isn't supported */
> +	if (fb->pitches[0] !=
> +	    drm_format_info_min_pitch(fb->format, 0, new_plane_state->crtc_w))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int output)
> +{
> +	regmap_set_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +			VSDC_CURSOR_CONFIG_COMMIT |
> +			VSDC_CURSOR_CONFIG_IMG_UPDATE);
> +}
> +
> +static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
> +					   struct drm_atomic_state *atomic_state)
> +{
> +	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
> +								       plane);
> +	struct drm_crtc *crtc = state->crtc;
> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	unsigned int output = vcrtc->id;
> +	struct vs_dc *dc = vcrtc->dc;
> +
> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
> +			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);
> +
> +	vs_cursor_plane_commit(dc, output);
> +}
> +
> +static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
> +					    struct drm_atomic_state *atomic_state)
> +{
> +	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
> +								       plane);
> +	struct drm_crtc *crtc = state->crtc;
> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	unsigned int output = vcrtc->id;
> +	struct vs_dc *dc = vcrtc->dc;
> +
> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
> +			   VSDC_CURSOR_CONFIG_FMT_OFF);
> +
> +	vs_cursor_plane_commit(dc, output);
> +}
> +
> +static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
> +					   struct drm_atomic_state *atomic_state)
> +{
> +	struct drm_plane_state *state = drm_atomic_get_new_plane_state(atomic_state,
> +								       plane);
> +	struct drm_framebuffer *fb = state->fb;
> +	struct drm_crtc *crtc = state->crtc;
> +	struct vs_dc *dc;
> +	struct vs_crtc *vcrtc;
> +	unsigned int output;
> +	dma_addr_t dma_addr;
> +
> +	if (!state->visible) {
> +		vs_cursor_plane_atomic_disable(plane, atomic_state);
> +		return;
> +	}
> +
> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	output = vcrtc->id;
> +	dc = vcrtc->dc;
> +
> +	/* Other sizes should be rejected by atomic_check */
> +	switch (state->crtc_w) {
> +	case 32:
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
> +				   VSDC_CURSOR_CONFIG_SIZE_32);
> +		break;
> +	case 64:
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
> +				   VSDC_CURSOR_CONFIG_SIZE_64);
> +		break;
> +	case 128:
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
> +				   VSDC_CURSOR_CONFIG_SIZE_128);
> +		break;
> +	case 256:
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
> +				   VSDC_CURSOR_CONFIG_SIZE_256);
> +		break;
> +	}
> +
> +	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
> +
> +	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
> +		     lower_32_bits(dma_addr));
> +
> +	/*
> +	 * The X_OFF and Y_OFF fields define which point does the LOCATION
> +	 * register represent in the cursor image, and LOCATION register
> +	 * values are unsigned. To for positive left-top  coordinates the
> +	 * offset is set to 0 and the location is set to the coordinate, for
> +	 * negative coordinates the location is set to 0 and the offset
> +	 * is set to the opposite number of the coordinate to offset the
> +	 * cursor image partly off-screen.
> +	 */
> +	if (state->crtc_x >= 0) {
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_X_OFF_MASK, 0);
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
> +				   VSDC_CURSOR_LOCATION_X_MASK,
> +				   VSDC_CURSOR_LOCATION_X(state->crtc_x));
> +	} else {
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
> +				   -state->crtc_x);
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
> +				   VSDC_CURSOR_LOCATION_X_MASK, 0);
> +	}
> +
> +	if (state->crtc_y >= 0) {
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_Y_OFF_MASK, 0);
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
> +				   VSDC_CURSOR_LOCATION_Y_MASK,
> +				   VSDC_CURSOR_LOCATION_Y(state->crtc_y));
> +	} else {
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> +				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
> +				   -state->crtc_y);
> +		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
> +				   VSDC_CURSOR_LOCATION_Y_MASK, 0);
> +	}
> +
> +	vs_cursor_plane_commit(dc, output);
> +}
> +
> +static const struct drm_plane_helper_funcs vs_cursor_plane_helper_funcs = {
> +	.atomic_check	= vs_cursor_plane_atomic_check,
> +	.atomic_update	= vs_cursor_plane_atomic_update,
> +	.atomic_enable	= vs_cursor_plane_atomic_enable,
> +	.atomic_disable	= vs_cursor_plane_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs vs_cursor_plane_funcs = {
> +	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
> +	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.reset			= drm_atomic_helper_plane_reset,
> +	.update_plane		= drm_atomic_helper_update_plane,
> +};
> +
> +static const u32 vs_cursor_plane_formats[] = {
> +	DRM_FORMAT_ARGB8888,
> +};
> +
> +static const u64 vs_cursor_plane_modifiers[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID, /* sentinel */
> +};
> +
> +struct drm_plane *vs_cursor_plane_init(struct drm_device *drm_dev,
> +				       struct vs_dc *dc)
> +{
> +	int32_t max_cursor_size = dc->identity.max_cursor_size;
> +	struct drm_plane *plane;
> +
> +	if (drm_WARN_ON_ONCE(drm_dev, max_cursor_size < VSDC_MIN_CURSOR_SIZE ||
> +				      max_cursor_size > VSDC_MAX_CURSOR_SIZE))
> +		return ERR_PTR(-EINVAL);
> +
> +	plane = drmm_universal_plane_alloc(drm_dev, struct drm_plane, dev, 0,
> +					   &vs_cursor_plane_funcs,
> +					   vs_cursor_plane_formats,
> +					   ARRAY_SIZE(vs_cursor_plane_formats),
> +					   vs_cursor_plane_modifiers,
> +					   DRM_PLANE_TYPE_CURSOR,
> +					   NULL);
> +
> +	if (IS_ERR(plane))
> +		return plane;
> +
> +	drm_plane_helper_add(plane, &vs_cursor_plane_helper_funcs);
> +
> +	return plane;
> +}
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
> new file mode 100644
> index 0000000000000..99693f2c95b94
> --- /dev/null
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> + *
> + * Based on vs_dc_hw.h, which is:
> + *   Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
> + */
> +
> +#ifndef _VS_CURSOR_PLANE_REGS_H_
> +#define _VS_CURSOR_PLANE_REGS_H_
> +
> +#include <linux/bits.h>
> +
> +#define VSDC_CURSOR_CONFIG(n)		(0x1468 + 0x1080 * (n))
> +#define VSDC_CURSOR_CONFIG_FMT_MASK	GENMASK(1, 0)
> +#define VSDC_CURSOR_CONFIG_FMT_ARGB8888	(0x2 << 0)
> +#define VSDC_CURSOR_CONFIG_FMT_OFF	(0x0 << 0)
> +#define VSDC_CURSOR_CONFIG_IMG_UPDATE	BIT(2)
> +#define VSDC_CURSOR_CONFIG_COMMIT	BIT(3)
> +#define VSDC_CURSOR_CONFIG_SIZE_MASK	GENMASK(7, 5)
> +#define VSDC_CURSOR_CONFIG_SIZE_32	(0x0 << 5)
> +#define VSDC_CURSOR_CONFIG_SIZE_64	(0x1 << 5)
> +#define VSDC_CURSOR_CONFIG_SIZE_128	(0x2 << 5)
> +#define VSDC_CURSOR_CONFIG_SIZE_256	(0x3 << 5)
> +#define VSDC_CURSOR_CONFIG_Y_OFF_MASK	GENMASK(12, 8)
> +#define VSDC_CURSOR_CONFIG_Y_OFF(v)	((v) << 8)
> +#define VSDC_CURSOR_CONFIG_X_OFF_MASK	GENMASK(20, 16)
> +#define VSDC_CURSOR_CONFIG_X_OFF(v)	((v) << 16)
> +
> +#define VSDC_CURSOR_ADDRESS(n)		(0x146C + 0x1080 * (n))
> +
> +#define VSDC_CURSOR_LOCATION(n)		(0x1470 + 0x1080 * (n))
> +#define VSDC_CURSOR_LOCATION_X_MASK	GENMASK(14, 0)
> +#define VSDC_CURSOR_LOCATION_X(v)	((v) << 0)
> +#define VSDC_CURSOR_LOCATION_Y_MASK	GENMASK(30, 16)
> +#define VSDC_CURSOR_LOCATION_Y(v)	((v) << 16)
> +
> +#define VSDC_CURSOR_BACKGROUND(n)	(0x1474 + 0x1080 * (n))
> +#define VSDC_CURSOR_BACKGRUOND_DEFAULT	0x00FFFFFF
> +
> +#define VSDC_CURSOR_FOREGROUND(n)	(0x1478 + 0x1080 * (n))
> +#define VSDC_CURSOR_FOREGRUOND_DEFAULT	0x00AAAAAA
> +
> +#endif /* _VS_CURSOR_PLANE_REGS_H_ */
> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h b/drivers/gpu/drm/verisilicon/vs_plane.h
> index 41875ea3d66a5..60b5b3a1bc22a 100644
> --- a/drivers/gpu/drm/verisilicon/vs_plane.h
> +++ b/drivers/gpu/drm/verisilicon/vs_plane.h
> @@ -68,5 +68,6 @@ dma_addr_t vs_fb_get_dma_addr(struct drm_framebuffer *fb,
>   			      const struct drm_rect *src_rect);
>   
>   struct drm_plane *vs_primary_plane_init(struct drm_device *dev, struct vs_dc *dc);
> +struct drm_plane *vs_cursor_plane_init(struct drm_device *dev, struct vs_dc *dc);
>   
>   #endif /* _VS_PLANE_H_ */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


