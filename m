Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8364DCD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 06:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93CC710ECAE;
	Wed,  6 May 2026 06:48:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zIHZEj7V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TV0G8dBV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T0jBtqEK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1F6pxylp";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D550610ECAE
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:48:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 595246B97C;
 Wed,  6 May 2026 06:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778050123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSns/xOXDrwBXoUujPKrOm66kAKDskcsyV9v9LDDqfA=;
 b=zIHZEj7VSkID6OO74+NFV+lV98eShyuBQ0P+t7she1ULmWtIr0pGJF/vcn5RcOrCeU7/jM
 xPHk3L3/uqel4uCzDF7GftycA38hIF6JVAVJbg4Sj0/zWj6WOB0viJ6k0E0TXBpWWSB1hT
 odo9NszvEAB+89+lHGEPwZ2Ul5yZPYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778050123;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSns/xOXDrwBXoUujPKrOm66kAKDskcsyV9v9LDDqfA=;
 b=TV0G8dBV2HwzJ4PeNArhehQtEXQvvZBU261tjpL56WCvPTlnWMtz5UECUYkYIhoxpihMZH
 JZvtmLsT5SMGYhAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T0jBtqEK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1F6pxylp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778050122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSns/xOXDrwBXoUujPKrOm66kAKDskcsyV9v9LDDqfA=;
 b=T0jBtqEKlyJrGDmZ5vJTeDjX/oRl6EPF7N6b1qKmHXQahFFrd2EC5K2/ySJVld3rBvtt3L
 0XrDRm00JoLn30hNbXNtWZbV07wYEFJWXlvIgoL+0u7cLZxBPe5UPCzCAX4NKv3l4oOrIf
 O+1cDzjTazV8FdN8rDxWEqq3SIw9UJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778050122;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CSns/xOXDrwBXoUujPKrOm66kAKDskcsyV9v9LDDqfA=;
 b=1F6pxylpdRDS5ujaHSaYTuzeMwI1FZ0VW3DdlspPhViDJTBmgKNGJPedBPuF4Wt+P/jZqc
 25YUHWo5RcOWW6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A253593A3;
 Wed,  6 May 2026 06:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 19QYBUrk+mklMwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 06 May 2026 06:48:42 +0000
Message-ID: <eae3bec8-5bf6-4fa8-8dcf-8c642cb36541@suse.de>
Date: Wed, 6 May 2026 08:48:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/2] drm: verisilicon: add support for cursor
 planes
To: Icenowy Zheng <uwu@icenowy.me>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>
References: <20260324060222.2029061-1-zhengxingda@iscas.ac.cn>
 <20260324060222.2029061-3-zhengxingda@iscas.ac.cn>
 <69830f02-5687-45e6-84c9-f9d7833e886d@suse.de>
 <403a963f3db0f9847a33266e585eaf5f91a4357b.camel@icenowy.me>
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
In-Reply-To: <403a963f3db0f9847a33266e585eaf5f91a4357b.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[icenowy.me,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.com:url,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, icenowy.me:email]
X-Rspamd-Queue-Id: 595246B97C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Am 05.05.26 um 10:25 schrieb Icenowy Zheng:
[...]
>>> +	/*
>>> +	 * Only certain PoT square sizes is supported, the minimum
>>> supported
>>> +	 * size is 32x32 and the maximum known size is 256x256.
>>> +	 */
>>> +	drm_WARN_ON_ONCE(plane->dev, dc->identity.max_cursor_size
>>> < 32 ||
>>> +				     dc->identity.max_cursor_size
>>>> 256);
>> Rather make this drm_dbg().  User space might just run an
>> atomic_check
>> on an atomic_state to test if it is supported. That should not leave
>> warnings in the logs.
> The thing being checked is the driver's HWDB (instead of user input),
> if this check fails the driver is surely buggy and misoperating.

Got it. It's a hardware limit.

>
> Or maybe this check should be moved to the creating code of cursor
> planes?

Yeah, makes sense. Tested it once when you create the cursor plane.

Best regards
Thomas

>
>>> +
>>> +	if (!is_power_of_2(new_plane_state->crtc_w) ||
>>> +	    new_plane_state->crtc_w < 32 ||
>>> +	    new_plane_state->crtc_w > dc-
>>>> identity.max_cursor_size)
>>> +		return -EINVAL;
>>> +
>>> +	if (new_plane_state->crtc_w != new_plane_state->crtc_h)
>>> +		return -EINVAL;
>>> +
>>> +	/* Check if the cursor is inside the register fields'
>>> range */
>>> +	if (!vs_cursor_plane_check_coord(new_plane_state->crtc_x)
>>> ||
>>> +	    !vs_cursor_plane_check_coord(new_plane_state->crtc_y))
>>> +		return -EINVAL;
>>> +
>>> +	if (fb) {
>> Not needed. The case of !fb would have been detected by
>> drm_atomic_helper_check_plane_state(). Best regards Thomas
> Yes, I checked this function and it will set visible to false (thus
> here early return is triggered) when no FB is bound.
>
> Thanks,
> Icenowy
>
>>> +		/* Extra line padding isn't supported */
>>> +		if (fb->pitches[0] !=
>>> +		    drm_format_info_min_pitch(fb->format, 0,
>>> +					      new_plane_state-
>>>> crtc_w))
>>> +			return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int
>>> output)
>>> +{
>>> +	regmap_set_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>>> +			VSDC_CURSOR_CONFIG_COMMIT |
>>> +			VSDC_CURSOR_CONFIG_IMG_UPDATE);
>>> +}
>>> +
>>> +static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
>>> +					   struct drm_atomic_state
>>> *atomic_state)
>>> +{
>>> +	struct drm_plane_state *state =
>>> drm_atomic_get_new_plane_state(atomic_state,
>>> +								
>>>       plane);
>>> +	struct drm_crtc *crtc = state->crtc;
>>> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	unsigned int output = vcrtc->id;
>>> +	struct vs_dc *dc = vcrtc->dc;
>>> +
>>> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>>> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
>>> +			   VSDC_CURSOR_CONFIG_FMT_ARGB8888);
>>> +
>>> +	vs_cursor_plane_commit(dc, output);
>>> +}
>>> +
>>> +static void vs_cursor_plane_atomic_disable(struct drm_plane
>>> *plane,
>>> +					    struct
>>> drm_atomic_state *atomic_state)
>>> +{
>>> +	struct drm_plane_state *state =
>>> drm_atomic_get_old_plane_state(atomic_state,
>>> +								
>>>       plane);
>>> +	struct drm_crtc *crtc = state->crtc;
>>> +	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	unsigned int output = vcrtc->id;
>>> +	struct vs_dc *dc = vcrtc->dc;
>>> +
>>> +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>>> +			   VSDC_CURSOR_CONFIG_FMT_MASK,
>>> +			   VSDC_CURSOR_CONFIG_FMT_OFF);
>>> +
>>> +	vs_cursor_plane_commit(dc, output);
>>> +}
>>> +
>>> +static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
>>> +					   struct drm_atomic_state
>>> *atomic_state)
>>> +{
>>> +	struct drm_plane_state *state =
>>> drm_atomic_get_new_plane_state(atomic_state,
>>> +								
>>>       plane);
>>> +	struct drm_framebuffer *fb = state->fb;
>>> +	struct drm_crtc *crtc = state->crtc;
>>> +	struct vs_dc *dc;
>>> +	struct vs_crtc *vcrtc;
>>> +	unsigned int output;
>>> +	dma_addr_t dma_addr;
>>> +
>>> +	if (!state->visible) {
>>> +		vs_cursor_plane_atomic_disable(plane,
>>> atomic_state);
>>> +		return;
>>> +	}
>>> +
>>> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
>>> +	output = vcrtc->id;
>>> +	dc = vcrtc->dc;
>>> +
>>> +	/* Other sizes should be rejected by atomic_check */
>>> +	switch (state->crtc_w) {
>>> +	case 32:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_32);
>>> +		break;
>>> +	case 64:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_64);
>>> +		break;
>>> +	case 128:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_128);
>>> +		break;
>>> +	case 256:
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_SIZE_MASK,
>>> +				   VSDC_CURSOR_CONFIG_SIZE_256);
>>> +		break;
>>> +	}
>>> +
>>> +	dma_addr = vs_fb_get_dma_addr(fb, &state->src);
>>> +
>>> +	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
>>> +		     lower_32_bits(dma_addr));
>>> +
>>> +	/*
>>> +	 * The X_OFF and Y_OFF fields define which point does the
>>> LOCATION
>>> +	 * register represent in the cursor image, and LOCATION
>>> register
>>> +	 * values are unsigned. To for positive left-top
>>> coordinates the
>>> +	 * offset is set to 0 and the location is set to the
>>> coordinate, for
>>> +	 * negative coordinates the location is set to 0 and the
>>> offset
>>> +	 * is set to the opposite number of the coordinate to
>>> offset the
>>> +	 * cursor image partly off-screen.
>>> +	 */
>>> +	if (state->crtc_x >= 0) {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
>>> 0);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_X_MASK,
>>> +				   VSDC_CURSOR_LOCATION_X(state-
>>>> crtc_x));
>>> +	} else {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
>>> +				   -state->crtc_x);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_X_MASK,
>>> 0);
>>> +	}
>>> +
>>> +	if (state->crtc_y >= 0) {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
>>> 0);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_Y_MASK,
>>> +				   VSDC_CURSOR_LOCATION_Y(state-
>>>> crtc_y));
>>> +	} else {
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_CONFIG(output),
>>> +				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
>>> +				   -state->crtc_y);
>>> +		regmap_update_bits(dc->regs,
>>> VSDC_CURSOR_LOCATION(output),
>>> +				   VSDC_CURSOR_LOCATION_Y_MASK,
>>> 0);
>>> +	}
>>> +
>>> +	vs_cursor_plane_commit(dc, output);
>>> +}
>>> +
>>> +static const struct drm_plane_helper_funcs
>>> vs_cursor_plane_helper_funcs = {
>>> +	.atomic_check	= vs_cursor_plane_atomic_check,
>>> +	.atomic_update	= vs_cursor_plane_atomic_update,
>>> +	.atomic_enable	= vs_cursor_plane_atomic_enable,
>>> +	.atomic_disable	= vs_cursor_plane_atomic_disable,
>>> +};
>>> +
>>> +static const struct drm_plane_funcs vs_cursor_plane_funcs = {
>>> +	.atomic_destroy_state	=
>>> drm_atomic_helper_plane_destroy_state,
>>> +	.atomic_duplicate_state	=
>>> drm_atomic_helper_plane_duplicate_state,
>>> +	.disable_plane		= drm_atomic_helper_disable_plane,
>>> +	.reset			= drm_atomic_helper_plane_reset,
>>> +	.update_plane		= drm_atomic_helper_update_plane,
>>> +};
>>> +
>>> +static const u32 vs_cursor_plane_formats[] = {
>>> +	DRM_FORMAT_ARGB8888,
>>> +};
>>> +
>>> +static const u64 vs_cursor_plane_modifiers[] = {
>>> +	DRM_FORMAT_MOD_LINEAR,
>>> +	DRM_FORMAT_MOD_INVALID, /* sentinel */
>>> +};
>>> +
>>> +struct drm_plane *vs_cursor_plane_init(struct drm_device *drm_dev,
>>> +				       struct vs_dc *dc)
>>> +{
>>> +	struct drm_plane *plane;
>>> +
>>> +	plane = drmm_universal_plane_alloc(drm_dev, struct
>>> drm_plane, dev, 0,
>>> +					   &vs_cursor_plane_funcs,
>>> +					
>>> vs_cursor_plane_formats,
>>> +					
>>> ARRAY_SIZE(vs_cursor_plane_formats),
>>> +					
>>> vs_cursor_plane_modifiers,
>>> +					   DRM_PLANE_TYPE_CURSOR,
>>> +					   NULL);
>>> +
>>> +	if (IS_ERR(plane))
>>> +		return plane;
>>> +
>>> +	drm_plane_helper_add(plane,
>>> &vs_cursor_plane_helper_funcs);
>>> +
>>> +	return plane;
>>> +}
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>> b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>> new file mode 100644
>>> index 0000000000000..99693f2c95b94
>>> --- /dev/null
>>> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
>>> @@ -0,0 +1,44 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +/*
>>> + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
>>> + *
>>> + * Based on vs_dc_hw.h, which is:
>>> + *   Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
>>> + */
>>> +
>>> +#ifndef _VS_CURSOR_PLANE_REGS_H_
>>> +#define _VS_CURSOR_PLANE_REGS_H_
>>> +
>>> +#include <linux/bits.h>
>>> +
>>> +#define VSDC_CURSOR_CONFIG(n)		(0x1468 + 0x1080 * (n))
>>> +#define VSDC_CURSOR_CONFIG_FMT_MASK	GENMASK(1, 0)
>>> +#define VSDC_CURSOR_CONFIG_FMT_ARGB8888	(0x2 << 0)
>>> +#define VSDC_CURSOR_CONFIG_FMT_OFF	(0x0 << 0)
>>> +#define VSDC_CURSOR_CONFIG_IMG_UPDATE	BIT(2)
>>> +#define VSDC_CURSOR_CONFIG_COMMIT	BIT(3)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_MASK	GENMASK(7, 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_32	(0x0 << 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_64	(0x1 << 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_128	(0x2 << 5)
>>> +#define VSDC_CURSOR_CONFIG_SIZE_256	(0x3 << 5)
>>> +#define VSDC_CURSOR_CONFIG_Y_OFF_MASK	GENMASK(12, 8)
>>> +#define VSDC_CURSOR_CONFIG_Y_OFF(v)	((v) << 8)
>>> +#define VSDC_CURSOR_CONFIG_X_OFF_MASK	GENMASK(20, 16)
>>> +#define VSDC_CURSOR_CONFIG_X_OFF(v)	((v) << 16)
>>> +
>>> +#define VSDC_CURSOR_ADDRESS(n)		(0x146C + 0x1080 * (n))
>>> +
>>> +#define VSDC_CURSOR_LOCATION(n)		(0x1470 + 0x1080 *
>>> (n))
>>> +#define VSDC_CURSOR_LOCATION_X_MASK	GENMASK(14, 0)
>>> +#define VSDC_CURSOR_LOCATION_X(v)	((v) << 0)
>>> +#define VSDC_CURSOR_LOCATION_Y_MASK	GENMASK(30, 16)
>>> +#define VSDC_CURSOR_LOCATION_Y(v)	((v) << 16)
>>> +
>>> +#define VSDC_CURSOR_BACKGROUND(n)	(0x1474 + 0x1080 * (n))
>>> +#define VSDC_CURSOR_BACKGRUOND_DEFAULT	0x00FFFFFF
>>> +
>>> +#define VSDC_CURSOR_FOREGROUND(n)	(0x1478 + 0x1080 * (n))
>>> +#define VSDC_CURSOR_FOREGRUOND_DEFAULT	0x00AAAAAA
>>> +
>>> +#endif /* _VS_CURSOR_PLANE_REGS_H_ */
>>> diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h
>>> b/drivers/gpu/drm/verisilicon/vs_plane.h
>>> index 41875ea3d66a5..60b5b3a1bc22a 100644
>>> --- a/drivers/gpu/drm/verisilicon/vs_plane.h
>>> +++ b/drivers/gpu/drm/verisilicon/vs_plane.h
>>> @@ -68,5 +68,6 @@ dma_addr_t vs_fb_get_dma_addr(struct
>>> drm_framebuffer *fb,
>>>    			      const struct drm_rect *src_rect);
>>>    
>>>    struct drm_plane *vs_primary_plane_init(struct drm_device *dev,
>>> struct vs_dc *dc);
>>> +struct drm_plane *vs_cursor_plane_init(struct drm_device *dev,
>>> struct vs_dc *dc);
>>>    
>>>    #endif /* _VS_PLANE_H_ */

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


