Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D49BFCD0C6
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED87A10E441;
	Wed, 18 Mar 2026 07:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="s8fXPdak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Q+hU6b/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s8fXPdak";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+Q+hU6b/";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C01B10E441
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:36:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA81A4D460;
 Wed, 18 Mar 2026 07:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773819363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t9nzdNk7ywROt/Y7LXFow26yeMB9XyCzwQKYnIVWJZk=;
 b=s8fXPdakpNUjrfe/wajiO0c2rRHe+S9RN1sUExfipAbxakWsJAzGJRvKwWt5pFZyTlDeYV
 lWU4BCjTQh/RdvAX53SMBrvboMcq6ZazJQz4C0L/3sX3iV7W03KJUGqfsqsILLMvue+LX8
 6X5a3S/pdgM45ja914W3ATofu60r/og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773819363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t9nzdNk7ywROt/Y7LXFow26yeMB9XyCzwQKYnIVWJZk=;
 b=+Q+hU6b/Um5N4vrQ6qq207hxt2Ep0GfqxB3yas3cCmpYEfzv7Bwgcls9jixYtenEc3sA7a
 VfUrnEcNNCbFGdCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773819363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t9nzdNk7ywROt/Y7LXFow26yeMB9XyCzwQKYnIVWJZk=;
 b=s8fXPdakpNUjrfe/wajiO0c2rRHe+S9RN1sUExfipAbxakWsJAzGJRvKwWt5pFZyTlDeYV
 lWU4BCjTQh/RdvAX53SMBrvboMcq6ZazJQz4C0L/3sX3iV7W03KJUGqfsqsILLMvue+LX8
 6X5a3S/pdgM45ja914W3ATofu60r/og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773819363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t9nzdNk7ywROt/Y7LXFow26yeMB9XyCzwQKYnIVWJZk=;
 b=+Q+hU6b/Um5N4vrQ6qq207hxt2Ep0GfqxB3yas3cCmpYEfzv7Bwgcls9jixYtenEc3sA7a
 VfUrnEcNNCbFGdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C594273B;
 Wed, 18 Mar 2026 07:36:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GouxHuNVumkXOAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 18 Mar 2026 07:36:03 +0000
Message-ID: <c6013f25-fce0-41ba-a275-96188a6647c1@suse.de>
Date: Wed, 18 Mar 2026 08:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/loongson: stop to set get_vblank_timestamp for 7A1000
 CRTC
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260314165421.1201790-1-zhengxingda@iscas.ac.cn>
 <e716ebde-a4f3-4035-bb21-3c6ab2fe06a4@suse.de>
 <8b52a9190a237a8bb94a23bf06b6a0589394f553.camel@iscas.ac.cn>
 <27689c69-dca3-4d5b-b385-b9ee2391a9d9@suse.de>
 <5a6f224147ad80d9c873b00208e387de429fcb2c.camel@iscas.ac.cn>
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
In-Reply-To: <5a6f224147ad80d9c873b00208e387de429fcb2c.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.com:url,iscas.ac.cn:email];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url, suse.com:url,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:email]
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

Am 18.03.26 um 08:15 schrieb Icenowy Zheng:
> 在 2026-03-18三的 08:09 +0100，Thomas Zimmermann写道：
>> Hi
>>
>> Am 18.03.26 um 07:16 schrieb Icenowy Zheng:
>>> 在 2026-03-16一的 08:53 +0100，Thomas Zimmermann写道：
>>>> Am 14.03.26 um 17:54 schrieb Icenowy Zheng:
>>>>> As there's no known hardware capability about querying vblank
>>>>> on
>>>>> the
>>>>> 7A1000 display controller, setting get_vblank_timestamp will
>>>>> mislead the
>>>>> kernel about the support of DC-backed high precision vblank
>>>>> query.
>>>>>
>>>>> Drop this function pointer in the CRTC function table for
>>>>> 7A1000.
>>>>>
>>>>> This solves a kernel warning when booting Linux 7.0-rc3 on a
>>>>> 3A4000+7A1000 Haier Boyue G51 laptop (with injected EDID for
>>>>> replicating
>>>>> the display timing set by the firmware).
>>>>>
>>>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>>> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Well, is my following understand right?
>>>
>>> - A hardware that does not have hardware vblank timing/counting
>>> ability
>>> shouldn't set .get_vblank_timestamp .
>>> - A hardware that supports vblank counting but not timing should
>>> set
>>> .get_vblank_timestamp to the
>>> drm_crtc_vblank_helper_get_vblank_timestamp helper to allow vblank
>>> timing estimate with counter.
>> Setting drm_crtc_vblank_helper_get_vblank_timestamp() also requires
>> to
>> read out the x/y positions. See get_scanout_position. You can leave
>> out
>> get_vblank_timestamp entirely and DRM will approximate the values
>> with
>> the system timer. For reading the vblank counter, there's
>> get_vblank_counter if the hardware supports it.
> It seems that the loongson driver already implemented
> .get_scanout_position hook.
>
> Is both .get_scanout_position and .get_vblank_counter requirement for
> drm_crtc_vblank_helper_get_vblank_timestamp() to work?

Just grep for it [1]. You won't need a HW counter nor the HW X/Y 
position. If neither exists, DRM will estimate these values from the 
system timer and the display mode's pixel clock. The goal here is to 
correctly estimate the time of the next page flip. HW support helps with 
calculating that time, but is not strictly necessary.

[1] 
https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_vblank.c#L232

Best regards
Thomas

>
>>> (P.S. There's a DisplayCurrentLocation register that is valid for
>>> 7A1000, which returns the current X and Y positions; but I wonder
>>> whether this is meaningful for vblank querying.
>> That sounds like the functionality required for get_scanout_position.
>>
>>> In addition, this DC looks quite similar to Verisilicon DCNano,
>>> which
>>> was used by i.MX8ULP (although many functionality on the i.MX8ULP
>>> manual is missing, things until cursor0 match between LS7A2000
>>> manual
>>> and i.MX8ULP manual). I wonder whether NXP people abandoned the
>>> mainlining of DCNano driver because of drm/loongson?)
>> IDK anything about that.
> Well I wonder about such kind of "similar display hardware on different
> bus" things, because PCI devices usually use different memory
> management system than platform devices (the former usually use TTM and
> the latter usually directly use dma memory).
>
> In fact LS7A1000 contains a Vivante GPU that isn't supported by etnaviv
> driver yet (and the etnaviv driver now hardcodes to use DMA memory,
> although the GPU has private memory that is shared with DC (currently
> managed by DC driver's TTM)).
>
>>
>>> P.S.2. I saw that Sui Jingfeng's mailbox is bouncing and the driver
>>> is
>>> going to be orphaned. If he wouldn't react with other ways, maybe I
>>> could try to maintain this driver? I have Loongson-3A4000 +
>>> LS7A1000
>>> and Loongson-3A6000 + LS7A2000 hardwares at home.
>> Yes, the driver is now orphaned.  No one else from Loongson has shown
>> up
>> to maintain it either. If you want it, just send a patch to add you
>> as
>> maintainer with a short rational.
>>
>> Best regards
>> Thomas
>>
>>>>> ---
>>>>>     drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
>>>>>     1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>>> b/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>>> index 587fbe285e9ef..b3af8e0cdb15f 100644
>>>>> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>>> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
>>>>> @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs
>>>>> ls7a1000_crtc_funcs = {
>>>>>     	.late_register = lsdc_crtc_late_register,
>>>>>     	.enable_vblank = lsdc_crtc_enable_vblank,
>>>>>     	.disable_vblank = lsdc_crtc_disable_vblank,
>>>>> -	.get_vblank_timestamp =
>>>>> drm_crtc_vblank_helper_get_vblank_timestamp,
>>>>>     	.atomic_print_state = lsdc_crtc_atomic_print_state,
>>>>>     };
>>>>>     

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


