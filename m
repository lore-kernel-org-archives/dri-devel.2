Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2091CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA1B910E4D5;
	Wed, 14 Oct 2026 09:03:53 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C16910FC29
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:03:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 450E01F7C9;
 Wed, 14 Oct 2026 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791968620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oKQqxm6OFPCcoen8OcNLWepnPvxoN36WQr2RSIk6B1c=;
 b=EZnT4x8tH8/9tP3nabsHyj0KdhIq4M6qgrO0dVl82YL3LiNoSkTiiaDfXNXeECWfOrvthu
 Q06LYLNBiKfM4wjlZRDRx26GTdLIFQ5xSv31oUxq9FEDj01DvBwHYkIac+rsGZhFh/6Mzb
 YYPkJfOdeIB/xekK6sCukBCOkwv/cNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791968620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oKQqxm6OFPCcoen8OcNLWepnPvxoN36WQr2RSIk6B1c=;
 b=ydFZka5dHSLNjIRth3BY8e0iIjjo0p0Zgp+/+yB7Wwmao6rzR4Cj9+E3HwHq87ssnMLSzP
 W73/erecWRMnD+Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MvYI37zZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="7gVYws/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791968619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oKQqxm6OFPCcoen8OcNLWepnPvxoN36WQr2RSIk6B1c=;
 b=MvYI37zZBnhhcjMxHvxqbcJb93RFyXenWj+oYl4PYOTV0e2BC3+XirgtfxcMnezx+zbXfe
 GV0h3SNBp7Gz3m1tf0G0JKLuU5bgDj3tAjP0wNzG01FXMdRWHDz1SvvB/O1MbHh9NB15gt
 ozh5rEiUgnmz9uwZysP712DMEoYpXok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791968619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oKQqxm6OFPCcoen8OcNLWepnPvxoN36WQr2RSIk6B1c=;
 b=7gVYws/D7fF3RbMAAc+dPQdyy9YF4sys6nSl+8o9/nCvdm68APlq/GVjBh2AgyXkcuDetw
 21yDQJQiWPPvF0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE90A133F1;
 Wed, 14 Oct 2026 09:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xkVaKmpFz2qnEQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 14 Oct 2026 09:03:38 +0000
Message-ID: <fdc5b911-407f-437f-ab05-33d1287e20da@suse.de>
Date: Wed, 14 Oct 2026 11:03:38 +0200
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
In-Reply-To: <CABOQOSUE17pQQYydLxCLHg1Jg90dwCEvMZYyo6TzYHMn9RAL2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 450E01F7C9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,kernel.org,gmail.com,ffwll.ch,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.com:url]
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

Am 13.10.26 um 15:07 schrieb Jie Feng:
> On Tue, 13 Oct 2026 at 20:32, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 13.10.26 um 14:17 schrieb Jie Feng:
>>> On Tue, 13 Oct 2026 at 15:11, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>> Hi
>>>>
>>>> Am 12.10.26 um 19:08 schrieb Ho Jie Feng:
>>>>> Add a helper for devices that use packed UYVY but accept XRGB8888
>>>>> framebuffers.
>>>> Is there a description of UYVY available somewhere?
>>> This is for a reverse engineered usb display adapter, which accepts
>>> input in bytes of U, Y, V, Y in that order. I'm not sure what
>>> counts as a description, apart from it matching DRM_FORMAT_UYVY?
>> I see. The format exists already in DRM.
>>
>>> This patch is meant to move this out of the driver:
>>> https://github.com/rhgndf/ms912x/blob/main/ms912x_transfer.c#L153
>>>
>>>>> Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
>>>>> ---
>>>>> This is used for a driver, ms912x that I will be submitting. It only
>>>>> supports uyvy framebuffers.
>>>> Please resubmit as part of the driver series. We're not going to merge
>>>> it without callers anyway.
>>>> ...
>>>> For naming, please follow the conventions used by the other helpers in
>>>> this file.
>>> Will send the driver in with this patch and its fixes, thanks for the review.
>>>
>>>> ...
>>>>> +             v = drm_pixel_rgb2_to_v_bt601(r, g, b);
>>>>> +             u = drm_pixel_rgb2_to_u_bt601(r, g, b);
>>>>> +
>>>>> +             transfer_buffer[dst_offset++] = u;
>>>>> +             transfer_buffer[dst_offset++] = y1;
>>>>> +             transfer_buffer[dst_offset++] = v;
>>>>> +             transfer_buffer[dst_offset++] = y2;
>>>> Rather that writing bytes individually, use put_unaligned_le32() or a
>>>> similar helper.  Byte order within a pixel is little endian, although
>>>> I'm not sure what this means for UYVY.
>>> This is meant to be sent over a usb transfer, so byte order needs to be
>>> the same on both little and big endian systems.
>> DRM formats always refer to little endian. As it is implemented now,
>> it's not clear what the endianess of your output is. Please duplicate
>> the other helpers' logic. They all pack the output with appropriate
>> helpers. If the USB device requires BE, you have to write a separate
>> conversion helper for that.
>>
>> BTW, you have an OOB access if the line width is not a multiple of 2.
> How should I handle this? Rounding it within the helper doesn't seem
> to make sense and the function return is a void, so it can't return -EINVAL.

It's the callers responsibility to pass in enough pixels. You'll have to 
take care of it in the driver by rounding the damage area accordingly. 
It's not optimal but it's not a big deal either.

In the line-conversion helper, simply round down to the nearest multiple 
of 2.

>
> Other helpers ignore the -ENOMEM error when drm_format_conv_state_reserve
> fails, so should it follow this convention?

Do you have a specific example?

>
> Alternatively, drm_fb_xfrm can be exported, and let the driver define
> the rgb->yuv coefficients? But I think it is fine since _to_gray8 also
> cites BT.601.

The current constants seem fine. With the 2-pixel alignment, there 
shouldn't be any other cases required.

Best regards
Thomas



-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


