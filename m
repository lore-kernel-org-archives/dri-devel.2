Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E036C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F3610F0B6;
	Thu, 27 Aug 2026 14:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="xBEIQA3x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mIX4BbA3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AGZsoRoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GxRUaVBp";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2BDA10F0B6
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:40:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AD821FB32;
 Thu, 27 Aug 2026 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787841633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9NhmnwAY3zQtddsW+n18+q9WpvJ+kUU3nXAO3crVuNQ=;
 b=xBEIQA3xRu783NZ5z651ZEYQcYzoKh9XbPfSg1Zx83P9DponKnycrbX7LMTnopHA6h482t
 G+/arDx7pFdyXL4y+lqKYC8b1DKHctPuY+sw9SW6KtAkKxBEZHLKXDPikB+pMZ7qSN9vA8
 k36s6jYG2m4VZB6QWVM3G53kO4m8uRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787841633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9NhmnwAY3zQtddsW+n18+q9WpvJ+kUU3nXAO3crVuNQ=;
 b=mIX4BbA3kPPwAsq6KinCd1opMoTs7AqkkyzCTVT63pH9GviQ4VAKyerFjTpsd2VeJ2mDW0
 paujlBWkKcaxUHAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AGZsoRoE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GxRUaVBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787841629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9NhmnwAY3zQtddsW+n18+q9WpvJ+kUU3nXAO3crVuNQ=;
 b=AGZsoRoEL/XwFjMfR6C+sFBB9UP7cJf+tiuBafaRMG3HO494gEkVzRafPqfaGc4BYHSbX6
 MXcIAHHwW0XOCmxN7oyOn09BQKTIDsXZvCnm1XZG7stpgFDGa2DkhRNQ8qfeS5+xdrwmeq
 6jE/hKVJw861kQ1WatSwVy/wyvL9b/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787841629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9NhmnwAY3zQtddsW+n18+q9WpvJ+kUU3nXAO3crVuNQ=;
 b=GxRUaVBpdiQpmtDuj8SMabAzbgK/+b12NVtsDJrHuGauO2YJDbrvF3EvxthcK6IGeNDfIY
 UjubrMAlLNztqNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 037191352C;
 Thu, 27 Aug 2026 14:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uFI9O1xMkGpXNgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 14:40:28 +0000
Message-ID: <b336b262-4662-44f7-b1b7-db3b42f6d7e0@suse.de>
Date: Thu, 27 Aug 2026 16:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/edid: Add drm_edid_get_preferred_size()
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260827140726.420734-1-tzimmermann@suse.de>
 <20260827140726.420734-2-tzimmermann@suse.de>
 <20260827141954.2AC011F000E9@smtp.kernel.org>
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
In-Reply-To: <20260827141954.2AC011F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AD821FB32
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid,suse.com:url];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
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



Am 27.08.26 um 16:19 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Pointer Dereference and Logic Error in drm_edid_get_preferred_size

This is just a pretty stupid typo. Will be fixed.

> - [High] Missing EDID Hardware Validation for Detailed Timing Descriptor

Will also be fixed.


> --
>
> commit 2d529ec582fce7d82757afd45c986da44f50ceb6
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Subject: drm/edid: Add drm_edid_get_preferred_size()
>
> This commit adds drm_edid_get_preferred_size() to extract the panel's
> preferred display resolution from a given EDID. This is required for
> DRM's panel orientation quirks.
>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index df3c25bac761d..650ccd05977be 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
> [ ... ]
>
>> @@ -2844,6 +2844,46 @@ u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
>>   }
>>   EXPORT_SYMBOL(drm_edid_get_panel_id);
>>   
>> +/**
>> + * drm_edid_get_preferred_size - Get a panel's preferred size from EDID
>> + * @drm_edid: EDID that contains panel ID.
>> + * @width: Returns the panel's width in pixels per scanline, if given
>> + * @height: Returns the panel's height in scanlines, if given
>> + *
>> + * This function detects the preferred size of a panel from the given
>> + * EDID. There is no such information stored in the EDID block directly,
>> + * but the preferred mode often corresponds to the panel's native geometry.
>> + *
>> + * Return: Zero on success, or a negative errno code otherwise.
>> + */
>> +int drm_edid_get_preferred_size(const struct drm_edid *drm_edid,
>> +				unsigned int *width, unsigned int *height)
>> +{
>> +	const struct edid *edid = drm_edid->edid;
>> +	const struct detailed_pixel_timing *pt;
>> +
>> +	if (drm_edid->size < EDID_LENGTH)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Use whatever the Preferred Timing Descriptor tells us. For old
>> +	 * and obscure displays, we might need better heuristics.
>> +	 */
>> +
>> +	if (edid->revision < 4 && !(edid->features & DRM_EDID_FEATURE_PREFERRED_TIMING))
>> +		return -EINVAL; /* no Preferred Timing Descriptor */
>> +
>> +	pt = &edid->detailed_timings[0].data.pixel_data;
> [Severity: High]
> Does this safely handle non-compliant or corrupted EDIDs where the first
> detailed timing block might be a Display Descriptor rather than a pixel
> timing descriptor?
>
> In the EDID specification, a detailed timing block is only a Detailed Timing
> Descriptor if its pixel clock is non-zero. If the pixel clock is 0, the block
> is a Display Descriptor like an ASCII monitor name. By unconditionally
> accessing it as pixel data without validating it, could we end up reading
> overlapping union fields and returning garbage display geometry data to the
> driver?
>
>> +
>> +	if (*width)
>> +		*width = (pt->hactive_hblank_hi & 0xf0) << 4 | pt->hactive_lo;
>> +	if (*height)
>> +		*height = (pt->vactive_vblank_hi & 0xf0) << 4 | pt->vactive_lo;
> [Severity: High]
> Does this logic incorrectly dereference the pointers before checking if they
> are valid?
>
> The kernel doc mentions that width and height are optional, which implies
> callers might pass a NULL pointer. If a caller passes NULL for width or
> height, evaluating if (*width) will cause a NULL pointer dereference crash.
>
> Additionally, if a caller passes a valid pointer to a 0-initialized variable,
> evaluating if (*width) will result in false, skipping the assignment entirely
> and leaving the output as 0. Should these conditions check if (width) and
> if (height) instead?
>
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_edid_get_preferred_size);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


