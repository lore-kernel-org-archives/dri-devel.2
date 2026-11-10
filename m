Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDF606A335
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SyNHoqQK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1e9AouSh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SyNHoqQK;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1e9AouSh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 560C110E2E2;
	Tue, 10 Nov 2026 14:27:35 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B9DE10E2E2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:27:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7FB51F7EC;
 Tue, 10 Nov 2026 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794320842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jbG46sE3PDfCFnv48UQvj3k6Pal99wX6hRdlK6h+ESY=;
 b=SyNHoqQKj+Kvym/uyiawkfxW8IrYqwBibEOUbZsk0ZIuyO7sF86SZI9DAlZzHboGWTnvCe
 aQjA7yZikdr/mV7ofgsJGrvi71eV3jNlt0HznUVcgaFUUHz17Hf27xo+wyK1x549BLQBg6
 dXZ8g8ft25ozWaf0g7WxZzwhWM41DXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794320842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jbG46sE3PDfCFnv48UQvj3k6Pal99wX6hRdlK6h+ESY=;
 b=1e9AouShIaJvLfu9cymmG3HqMaRBijBpxoDne2MZFY1gSDDYkmM1YypVVxXSf2J08x6PXZ
 ESdCqwZSKKp0Z0AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794320842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jbG46sE3PDfCFnv48UQvj3k6Pal99wX6hRdlK6h+ESY=;
 b=SyNHoqQKj+Kvym/uyiawkfxW8IrYqwBibEOUbZsk0ZIuyO7sF86SZI9DAlZzHboGWTnvCe
 aQjA7yZikdr/mV7ofgsJGrvi71eV3jNlt0HznUVcgaFUUHz17Hf27xo+wyK1x549BLQBg6
 dXZ8g8ft25ozWaf0g7WxZzwhWM41DXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794320842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jbG46sE3PDfCFnv48UQvj3k6Pal99wX6hRdlK6h+ESY=;
 b=1e9AouShIaJvLfu9cymmG3HqMaRBijBpxoDne2MZFY1gSDDYkmM1YypVVxXSf2J08x6PXZ
 ESdCqwZSKKp0Z0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BADD91339F;
 Tue, 10 Nov 2026 14:27:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J+xSJsop82rDIgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 10 Nov 2026 14:27:22 +0000
Message-ID: <812bb5ec-ee14-4e62-abb0-b9d4999e6034@suse.de>
Date: Tue, 10 Nov 2026 15:27:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/radeon: Inline drm_crtc_init()
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261110120326.538252-1-tzimmermann@suse.de>
 <20261110120326.538252-5-tzimmermann@suse.de>
 <sashiko-outbox-206999@kernel.org>
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
In-Reply-To: <sashiko-outbox-206999@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.28 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-0.99)[-0.993];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.com:url]
X-Spam-Score: -13.28
X-Spam-Level: 
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 10.11.26 um 13:18 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/radeon: radeon_crtc_init() breaks non-XRGB8888/ARGB8888
>    modesets
> --
>
> commit 084c2fdd462a7f679496ecdf20e1829b6180f22d
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/radeon: Inline drm_crtc_init()
>
> This commit inlines drm_crtc_init() into radeon_crtc_init() by allocating
> a primary plane with __drm_universal_plane_alloc() and initializing the
> CRTC via drm_crtc_init_with_planes().
>
>> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
>> index aac6733ddd82c..4b784df4679f9 100644
>> --- a/drivers/gpu/drm/radeon/radeon_display.c
>> +++ b/drivers/gpu/drm/radeon/radeon_display.c
>> @@ -38,6 +38,7 @@
>>   #include <drm/drm_framebuffer.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>>   #include <drm/drm_modeset_helper.h>
>> +#include <drm/drm_plane_helper.h>
>>   #include <drm/drm_probe_helper.h>
>>   #include <drm/drm_vblank.h>
>>   #include <drm/radeon_drm.h>
>> @@ -47,6 +48,17 @@
>>   #include "radeon.h"
>>   #include "radeon_kms.h"
>>   
>> +static const u32 radeon_primary_plane_formats[] = {
>> +	DRM_FORMAT_XRGB8888,
>> +	DRM_FORMAT_ARGB8888,
>> +};
>> +
>> +static const struct drm_plane_funcs radeon_primary_plane_funcs = {
>> +	.update_plane = drm_plane_helper_update_primary,
>> +	.disable_plane = drm_plane_helper_disable_primary,
>> +	.destroy = drm_plane_helper_destroy,
>> +};
>> +
>>   static void avivo_crtc_load_lut(struct drm_crtc *crtc)
>>   {
>>   	struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
>> @@ -680,20 +692,31 @@ static const struct drm_crtc_funcs radeon_crtc_funcs = {
>>   static void radeon_crtc_init(struct drm_device *dev, int index)
>>   {
>>   	struct radeon_device *rdev = dev->dev_private;
>> +	struct drm_plane *primary;
>>   	struct radeon_crtc *radeon_crtc;
>> +	int ret;
>>   
>> -	radeon_crtc = kzalloc_obj(*radeon_crtc);
>> -	if (radeon_crtc == NULL)
>> +	primary = __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
>> +					      &radeon_primary_plane_funcs,
>> +					      radeon_primary_plane_formats,
>> +					      ARRAY_SIZE(radeon_primary_plane_formats),
>> +					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
> [Severity: High]
> Does restricting radeon_primary_plane_formats[] to only two 32-bit formats
> cause drm_mode_setcrtc() to reject other pixel formats supported by radeon?
>
> Previously, drm_crtc_init() set primary->format_default = true, which made
> drm_mode_setcrtc() skip the drm_plane_has_format() check and leave format
> validation to the CRTC callbacks:
>
> drivers/gpu/drm/drm_crtc.c:drm_mode_setcrtc() {
>      ...
> 		if (!plane->format_default) {
> 			if (!drm_plane_has_format(plane, fb->format->format, fb->modifier)) {
> 				drm_dbg_kms(dev, "Invalid pixel format %p4cc, modifier 0x%llx\n",
> 					    &fb->format->format, fb->modifier);
> 				ret = -EINVAL;
> 				goto out;
> 			}
> 		}
>      ...
> }
>
> Allocating the primary plane via __drm_universal_plane_alloc() leaves
> primary->format_default as false (and follow-up commit "drm: Remove
> drm_crtc_init()" removes format_default altogether). As a result,
> drm_mode_setcrtc() now fails with -EINVAL for 8bpp, 15bpp, 16bpp, and 30bpp
> framebuffers (such as C8, RGB565, XRGB1555, and XRGB2101010) that
> dce4_crtc_do_set_base(), avivo_crtc_do_set_base(), and
> radeon_crtc_do_set_base() handle.

That's likely the case and amdgpu might also be affected. I found the 
old validation logic confusing. will be fixed in the next rev.


>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


