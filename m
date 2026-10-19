Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC6CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E2410E74D;
	Mon, 19 Oct 2026 07:45:38 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EEC10E74D
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:45:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5BCEF1F7E9;
 Mon, 19 Oct 2026 07:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792395925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=easGoBZSXnUfEEQ5s2Lw5lSXXtrn96heP55j8/0IsLs=;
 b=MC7Lz2ZZo5VyQSkcjVoSUOnop9TEq0qhdHOtAy4l7/0fQn4o9XdPews2gEyysnxTHiKd+L
 KCKjACmM8XbzBngaPlTcjvhhsZVLqupmb34Yyv0Ohi3qPZDGijpZe3UKddhW9eIAnuqd30
 MvlsgbPRUu1aDaFjNC6DZJRYEasfO1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792395925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=easGoBZSXnUfEEQ5s2Lw5lSXXtrn96heP55j8/0IsLs=;
 b=k/IKbehKvZ0fEUmWXAhwwRe8fYo06s2Uw3rfPIlDRdtV1zfSgjh1Re2G3DdHrllnwawHaf
 6Q7OjsJEZQu+K6Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792395925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=easGoBZSXnUfEEQ5s2Lw5lSXXtrn96heP55j8/0IsLs=;
 b=MC7Lz2ZZo5VyQSkcjVoSUOnop9TEq0qhdHOtAy4l7/0fQn4o9XdPews2gEyysnxTHiKd+L
 KCKjACmM8XbzBngaPlTcjvhhsZVLqupmb34Yyv0Ohi3qPZDGijpZe3UKddhW9eIAnuqd30
 MvlsgbPRUu1aDaFjNC6DZJRYEasfO1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792395925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=easGoBZSXnUfEEQ5s2Lw5lSXXtrn96heP55j8/0IsLs=;
 b=k/IKbehKvZ0fEUmWXAhwwRe8fYo06s2Uw3rfPIlDRdtV1zfSgjh1Re2G3DdHrllnwawHaf
 6Q7OjsJEZQu+K6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A0541373D;
 Mon, 19 Oct 2026 07:45:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2CIxOpTK1WqrNAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 07:45:25 +0000
Message-ID: <23f0313d-8aba-43b9-80c4-678b970f8541@suse.de>
Date: Mon, 19 Oct 2026 09:45:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/format-helper: Add XRGB8888 to UYVY conversion
To: Jie Feng <hjf3108@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
References: <20261012170857.199561-1-hjf3108@gmail.com>
 <64707239-eac7-4259-a8ff-7ec43d13860e@suse.de>
 <CABOQOSXgG2kBzs2sBEE69mmPcO0cKVgjyk_6DG5RST_4uL2+sg@mail.gmail.com>
 <c9460a8d-3fdf-439f-9655-82b60617b85c@suse.de>
 <CABOQOSUE17pQQYydLxCLHg1Jg90dwCEvMZYyo6TzYHMn9RAL2Q@mail.gmail.com>
 <fdc5b911-407f-437f-ab05-33d1287e20da@suse.de>
 <CABOQOSWf1Yqt2E+hXC5bPxJhjKNJ_W3AMX30k-stNZzQG32F9g@mail.gmail.com>
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
In-Reply-To: <CABOQOSWf1Yqt2E+hXC5bPxJhjKNJ_W3AMX30k-stNZzQG32F9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:email]
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

Am 14.10.26 um 18:19 schrieb Jie Feng:
> On Wed, 14 Oct 2026 at 17:03, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>>>> ...
>>>>>>> +             v = drm_pixel_rgb2_to_v_bt601(r, g, b);
>>>>>>> +             u = drm_pixel_rgb2_to_u_bt601(r, g, b);
>>>>>>> +
>>>>>>> +             transfer_buffer[dst_offset++] = u;
>>>>>>> +             transfer_buffer[dst_offset++] = y1;
>>>>>>> +             transfer_buffer[dst_offset++] = v;
>>>>>>> +             transfer_buffer[dst_offset++] = y2;
>>>>>> Rather that writing bytes individually, use put_unaligned_le32() or a
>>>>>> similar helper.  Byte order within a pixel is little endian, although
>>>>>> I'm not sure what this means for UYVY.
>>>>> This is meant to be sent over a usb transfer, so byte order needs to be
>>>>> the same on both little and big endian systems.
>>>> DRM formats always refer to little endian. As it is implemented now,
>>>> it's not clear what the endianess of your output is. Please duplicate
>>>> the other helpers' logic. They all pack the output with appropriate
>>>> helpers. If the USB device requires BE, you have to write a separate
>>>> conversion helper for that.
>>>>
>>>> BTW, you have an OOB access if the line width is not a multiple of 2.
>>> How should I handle this? Rounding it within the helper doesn't seem
>>> to make sense and the function return is a void, so it can't return -EINVAL.
>> It's the callers responsibility to pass in enough pixels. You'll have to
>> take care of it in the driver by rounding the damage area accordingly.
>> It's not optimal but it's not a big deal either.
>>
>> In the line-conversion helper, simply round down to the nearest multiple
>> of 2.
> Yes, that is already done in my driver.
>
>>> Other helpers ignore the -ENOMEM error when drm_format_conv_state_reserve
>>> fails, so should it follow this convention?
>> Do you have a specific example?
> The call chain goes like this:
> drm_fb_xrgb8888_to_rgb888
> drm_fb_xfrm
> __drm_fb_xfrm:
>          stmp = drm_format_conv_state_reserve(state, sbuf_len, GFP_KERNEL);
>          if (!stmp)
>              return -ENOMEM;
>
> Since drm_fb_xrgb8888_to_rgb888 is a void, it calls drm_fb_xfrm without
> checking for the return value. Similarly for other drm_fb_xrgb8888_to*
> functions. For the uyvy helper it could just return without
> doing any work if it is not a multiple of 2, like in the -ENOMEM case.

Ok, that's what you mean.  We run these conversion functions in 
atomic_update, when it's too late to do anything with the return value. 
So we drop the return value.

You should rather not return an error if the width is not a multiple of 
2. Even then, there's some data available for output to the user.

Errors and problems need to be detected by atomic_check, prepare_fb or a 
similar callback that runs before atomic_update.

Best regards
Thomas


>
>>> Alternatively, drm_fb_xfrm can be exported, and let the driver define
>>> the rgb->yuv coefficients? But I think it is fine since _to_gray8 also
>>> cites BT.601.
>> The current constants seem fine. With the 2-pixel alignment, there
>> shouldn't be any other cases required.
>>
>> Best regards
>> Thomas
>>
>>
>>
>> --
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
>> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
>>
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


