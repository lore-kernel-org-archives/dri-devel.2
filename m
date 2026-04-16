Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F36F8A144
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 386E610E1AC;
	Thu, 16 Apr 2026 08:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="2ZRcQynz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+EO67X/T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qCdnQIDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ISalJF5D";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2155F10E1AC
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 08:35:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B8E086A7F8;
 Thu, 16 Apr 2026 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776328537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OAa6i+74sv/RURV3xjP4ayGSWUA6nNPrBdYtcXkWFY4=;
 b=2ZRcQynz9DjvhciItheVjnOr4Q5SpE5RGCaulonMJXczr+IdOPF1kTjpIEot38lDGs7ZXZ
 o1yGfsSBrUueerFtpcTZ4SD/6o9BAArb/Ilh3USwJCH+ZtYlfa0O3zjJw+B/CaN5cr446I
 1u5QciEtqROoC/6GFxgZuQo14pW9xG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776328537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OAa6i+74sv/RURV3xjP4ayGSWUA6nNPrBdYtcXkWFY4=;
 b=+EO67X/TOpO+4IvZNu/Y0DfdwfHQEq8XO0mo14zQbtbNPYUtDdX2to33cVNMnzHJg2zcqJ
 Vb2ocOZiC8pOojCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776328536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OAa6i+74sv/RURV3xjP4ayGSWUA6nNPrBdYtcXkWFY4=;
 b=qCdnQIDIWIf17e3hFvDh9crus8wyDEuXLmlpjPTp0UNvlceQ8N2ji3q/YOhP2fl6cpRSy7
 SKMYOZEHtNItsa/jBKRyxtcaHPAfzMsZ1iTFAfyXPpUpJYuZ6Z9vM3EHsW5EkqyX2JLFKC
 q6uWMCr9JJn/LDj5yGL8BkGX5uJr9dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776328536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OAa6i+74sv/RURV3xjP4ayGSWUA6nNPrBdYtcXkWFY4=;
 b=ISalJF5D6sPyxBIbJQ/zg1IcmqKyqa0mX2oD2g+TI7HPcd5K7ITNLaWXkHV8U4xjspGy9a
 DaFaEJr36e77ETDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 887074BE81;
 Thu, 16 Apr 2026 08:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L2RlH1if4GmcNAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 16 Apr 2026 08:35:36 +0000
Message-ID: <e2e9206e-ab65-415a-bab3-8cd72ce5a92a@suse.de>
Date: Thu, 16 Apr 2026 10:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/mgag200: Simplify offset calculation
To: Jocelyn Falempe <jfalempe@redhat.com>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org
References: <20260415152625.101710-1-tzimmermann@suse.de>
 <20260415152625.101710-4-tzimmermann@suse.de>
 <99d0ae68-9168-4c1c-ac72-993f650e5dd9@redhat.com>
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
In-Reply-To: <99d0ae68-9168-4c1c-ac72-993f650e5dd9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url, suse.de:mid,
 suse.de:email, suse.com:url, imap1.dmz-prg2.suse.org:helo]
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

Hi Jocelyn

Am 16.04.26 um 09:34 schrieb Jocelyn Falempe:
> On 15/04/2026 17:23, Thomas Zimmermann wrote:
>> The offset value sets the distance in bytes between two consecutive
>> scanlines. Reduce the calculation to the minimum.
>>
>> According to the Matrox programming manual, Sec 4.6.5, the offset
>> is the scanline pitch in bits divided by 128. The field pitches[0] in
>> struct drm_framebuffer stores the scanline pitch in bytes, so we have
>> to divide by 16 only. Reducing the existing bpp-shift look-up and
>> offset calculations also returns exactly this for all formats.
>>
> I've sent a similar patch a few years ago with:
> https://patchwork.freedesktop.org/patch/531878/?series=116381&rev=1

Ah, that was part of the 24-bit change so it didn't make it in. Let me 
give you at least credit for the work.

Co-developed-by: Jocelyn Falempe <jfalempe@redhat.com>

Best regards
Thomas

>
> So that looks good to me.
>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/mgag200/mgag200_mode.c | 28 +-------------------------
>>   1 file changed, 1 insertion(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c 
>> b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> index 5b526aebaeb8..57c9f731a4bf 100644
>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>> @@ -298,37 +298,11 @@ void mgag200_set_mode_regs(struct mga_device 
>> *mdev, const struct drm_display_mod
>>       WREG8(MGA_MISC_OUT, misc);
>>   }
>>   -static u8 mgag200_get_bpp_shift(const struct drm_format_info *format)
>> -{
>> -    static const u8 bpp_shift[] = {0, 1, 0, 2};
>> -
>> -    return bpp_shift[format->cpp[0] - 1];
>> -}
>> -
>> -/*
>> - * Calculates the HW offset value from the framebuffer's pitch. The
>> - * offset is a multiple of the pixel size and depends on the display
>> - * format.
>> - */
>> -static u32 mgag200_calculate_offset(struct mga_device *mdev,
>> -                    const struct drm_framebuffer *fb)
>> -{
>> -    u32 offset = fb->pitches[0] / fb->format->cpp[0];
>> -    u8 bppshift = mgag200_get_bpp_shift(fb->format);
>> -
>> -    if (fb->format->cpp[0] * 8 == 24)
>> -        offset = (offset * 3) >> (4 - bppshift);
>> -    else
>> -        offset = offset >> (4 - bppshift);
>> -
>> -    return offset;
>> -}
>> -
>>   static void mgag200_set_offset(struct mga_device *mdev,
>>                      const struct drm_framebuffer *fb)
>>   {
>>       u8 crtc13, crtcext0;
>> -    u32 offset = mgag200_calculate_offset(mdev, fb);
>> +    u32 offset = fb->pitches[0] / 16;
>>         RREG_ECRT(0, crtcext0);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


