Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2004CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5228810E6F6;
	Mon, 22 Jun 2026 13:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="WSW+KGXc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amvQ6r9l";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WSW+KGXc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amvQ6r9l";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B627D10E6F6
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:47:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C1E775A3D;
 Mon, 22 Jun 2026 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782136068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r8K+kw0SwEfViXnLi4P5/7r34wfYnENukcZ2lHUfwDs=;
 b=WSW+KGXcVRUXvSo/TntPt5HJi9tWs5U+spapv2Wsy6Pv8gW3/y+tAENRitrFAAFyWqTs4V
 TkZsWEOTe5LzQEYNuPCoFxLVzFWgGP1pHMZfMSXVShpIXfyzFxOsZIoqW6M4fNqwKiTteJ
 xKhJCkSB5McP6EdbM9m/ROQeUAYDc8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782136068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r8K+kw0SwEfViXnLi4P5/7r34wfYnENukcZ2lHUfwDs=;
 b=amvQ6r9lJt2pwZ5z5blGULRUa/+8UbmzEx80kKnGukJL47ANVAlfpww26adpzq357Q8hAG
 ncyWfloxmnpNZ2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782136068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r8K+kw0SwEfViXnLi4P5/7r34wfYnENukcZ2lHUfwDs=;
 b=WSW+KGXcVRUXvSo/TntPt5HJi9tWs5U+spapv2Wsy6Pv8gW3/y+tAENRitrFAAFyWqTs4V
 TkZsWEOTe5LzQEYNuPCoFxLVzFWgGP1pHMZfMSXVShpIXfyzFxOsZIoqW6M4fNqwKiTteJ
 xKhJCkSB5McP6EdbM9m/ROQeUAYDc8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782136068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r8K+kw0SwEfViXnLi4P5/7r34wfYnENukcZ2lHUfwDs=;
 b=amvQ6r9lJt2pwZ5z5blGULRUa/+8UbmzEx80kKnGukJL47ANVAlfpww26adpzq357Q8hAG
 ncyWfloxmnpNZ2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24263779A8;
 Mon, 22 Jun 2026 13:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jIUpBwQ9OWo0OAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 22 Jun 2026 13:47:48 +0000
Message-ID: <6ef94244-c6e6-4210-99da-768ce51a07e6@suse.de>
Date: Mon, 22 Jun 2026 15:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drm/sysfb: simpledrm: Validate mmap size against
 framebuffer size
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-6-tzimmermann@suse.de>
 <20260622133308.DBE891F000E9@smtp.kernel.org>
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
In-Reply-To: <20260622133308.DBE891F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid, suse.com:url,
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



Am 22.06.26 um 15:33 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The validation check comparing the memory resource size against the required framebuffer size is inverted, causing valid device tree configurations to fail probing and bypassing protection for undersized framebuffers.
> - [Low] The condition `if (size < PAGE_SIZE)` functions as a check for a zero-sized framebuffer rather than an alignment overflow guard, resulting in a misleading error message.
> --
>
> commit fe687b775049a45634b1930d3d958d911916b07a
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/sysfb: simpledrm: Validate mmap size against framebuffer size
>
> The size of the mmap'ed framebuffer could be smaller than the minimum
> required framebuffer size. Validate the resource size against the
> framebuffer size.
>
> Buggy firmware that triggers this check should be fixed up with a quirk
> on a case-by-case base.
>
>> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
>> index 76b9a3f5c4efa..a04f0c852ea48 100644
>> --- a/drivers/gpu/drm/sysfb/simpledrm.c
>> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> [ ... ]
>
>> @@ -704,6 +706,15 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   		}
>>   		stride = pitch;
>>   	}
>> +	if (check_mul_overflow(height, stride, &size)) {
>> +		drm_err(dev, "framebuffer size exceeds maximum\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +	size = ALIGN(size, PAGE_SIZE);
>> +	if (size < PAGE_SIZE) {
>> +		drm_err(dev, "framebuffer alignment exceeds maximum\n");
> [Severity: Low]
> Does this code accurately report an alignment overflow?
>
> Because both height and stride are bounded by INT_MAX, their product
> (size) cannot exceed ~2^62, meaning the ALIGN operation will not overflow
> a 64-bit integer.

This protects against overflowing in the ALIGN() call. While we cannot 
trigger this problem now, it is still the safer thing to do this.

>
> The condition size < PAGE_SIZE will only be true if size was exactly 0
> before alignment. While rejecting a zero-sized framebuffer is correct,
> the error message 'framebuffer alignment exceeds maximum' might be
> misleading for developers debugging initialization failures.

Neither height nor stride can be 0 IIRC. We should not see size being 0.

>
>> +		return ERR_PTR(-EINVAL);
>> +	}
>>   
>>   	sysfb->fb_mode = drm_sysfb_mode(width, height, width_mm, height_mm);
>>   	sysfb->fb_format = format;
> [ ... ]
>
>> @@ -729,6 +740,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   
>>   		drm_dbg(dev, "using system memory framebuffer at %pr\n", mem);
>>   
>> +		if (resource_size(mem) > size) {
>> +			drm_err(dev,
>> +				"framebuffer size of %llu exceeds memory range %pr\n",
> [Severity: High]
> Is the validation check here inverted?
>
> The condition evaluates to true when the provided memory region is larger
> than the required framebuffer size, which is a valid configuration when
> the reserved-memory region is larger than the exact resolution requires.

Arghh, when I tested with bochs, I hit exactly the case of mem == size, 
so it worked. :/

>
> This logic inversion causes the driver to incorrectly log 'framebuffer size...
> exceeds memory range' and abort probing for valid configurations, while
> allowing memory regions that are actually too small.
>
> Will this bypass the intended validation and potentially lead to out-of-bounds
> memory accesses if the framebuffer is not fully backed by the memory resource?
>
>> +				size, mem);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +
>>   		screen_base = devm_memremap(dev->dev, mem->start, resource_size(mem), MEMREMAP_WC);
>>   		if (IS_ERR(screen_base))
>>   			return screen_base;
> [ ... ]
>
>> @@ -762,6 +780,13 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
>>   			mem = res;
>>   		}
>>   
>> +		if (resource_size(mem) > size) {
>> +			drm_err(dev,
>> +				"framebuffer size of %llu exceeds memory range %pr\n",
> [Severity: High]
> Is this check also inverted for the I/O memory path?
>
> Similar to the system memory path above, this will reject valid framebuffers
> that fit within the memory range and allow undersized ones.
>
>> +				size, mem);
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +
>>   		screen_base = devm_ioremap_wc(&pdev->dev, mem->start, resource_size(mem));

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


