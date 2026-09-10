Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB0C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741AE10F380;
	Thu, 10 Sep 2026 08:56:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="j5E6vIjp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ru+5Zj8v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0aQWMUOB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KXhL5KkZ";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63FA10F380
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:56:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 221751FD96;
 Thu, 10 Sep 2026 08:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789030572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4rwhxyuBA+qCh6Ot+Pso1MDoW/AxAzW5VW2jyH58NCo=;
 b=j5E6vIjpyvkzfU88r6HNSxv8eaNlsNjSlZegKZE7iOkY79tBn3LlfKpsU9vtCmF/FChsWG
 G6hUq7oeOWRJwvz1BnXXSzn8CICJU6RoWGu5UVc3WtAEb3P1T04JhaCF9SwdLwrhE2Eo5C
 /mnRVTaXzzGtaYkNUaHtxGxaXBNEfbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789030572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4rwhxyuBA+qCh6Ot+Pso1MDoW/AxAzW5VW2jyH58NCo=;
 b=ru+5Zj8vUuYy2pueGmCA4WV430HkZR/BjyS9swwA8OdNtLrbwZcOGuwG+Rf7JDsQEBrzky
 kMPcv+F1U5kQHIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789030568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4rwhxyuBA+qCh6Ot+Pso1MDoW/AxAzW5VW2jyH58NCo=;
 b=0aQWMUOBz7P1cJ2hK3FseSQ3agyCWH57K9oUSqzWSpth+9zcXMqlTIQ8AnWwSHItTLqu7z
 pyXkGu2pQLTDnonE35s9VTU0DzEvItBVpGOEUcqyV5YwMHeBv1zy7/7Y2gar+mOhQJZ6k8
 qY13DFND+H6++JLcXjl+4ATCqvBqqfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789030568;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4rwhxyuBA+qCh6Ot+Pso1MDoW/AxAzW5VW2jyH58NCo=;
 b=KXhL5KkZ+bX+JZtzWtA3XJKqzLG0zeztZbOxKQtfyRGLKhddZwSqF9gDKQQdLzsBBYiH4o
 xCQ+KKZmH8D3GyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C53201321C;
 Thu, 10 Sep 2026 08:56:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lCapLqdwompscAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 08:56:07 +0000
Message-ID: <924e1372-6fe2-42ae-a57a-d44d3cf08f5a@suse.de>
Date: Thu, 10 Sep 2026 10:56:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/verisilicon: set blend mode for the primary plane
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260901171703.1161592-1-zhengxingda@iscas.ac.cn>
 <35cf76a67f7473d5ef86d01c812d680abc41687e.camel@iscas.ac.cn>
 <e2a2f02f-13c4-4919-9344-db7afcd3368b@suse.de>
 <d36bc08a7f954be25b0d3e0fe649698b3944f98a.camel@iscas.ac.cn>
 <e61e51fb-9e29-46c9-888d-5ad377a89311@suse.de>
 <0f79f3bd5175285de4b2112e6419a8f373b0ff81.camel@iscas.ac.cn>
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
In-Reply-To: <0f79f3bd5175285de4b2112e6419a8f373b0ff81.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 iscas.ac.cn:email, suse.de:mid]
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

Am 10.09.26 um 10:45 schrieb Icenowy Zheng:
> 在 2026-09-10四的 10:31 +0200，Thomas Zimmermann写道：
>> Hi
>>
>> Am 10.09.26 um 10:00 schrieb Icenowy Zheng:
>>> 在 2026-09-10四的 09:58 +0200，Thomas Zimmermann写道：
>>>> Hi
>>>>
>>>> Am 10.09.26 um 09:09 schrieb Icenowy Zheng:
>>>>> 在 2026-09-02三的 01:17 +0800，Icenowy Zheng写道：
>>>>>> Blend modes are now required to expose pixel formats w/
>>>>>> alpha.
>>>>>>
>>>>>> As it's the primary plane and blending is explicitly
>>>>>> disabled,
>>>>>> just
>>>>>> expose PIXEL_NONE blend mode.
>>>>> Gently ping for reviews.
>>>> What do these alpha formats do?  Are they a hardware feature?  It
>>>> looks
>>>> like they are programmable, but don't differ from XRGB at all.
>>> I think they're for consistency with overlay planes.
>> But there are no overlay planes in this driver, are there?
>>
>> What I want to get at is that it might be preferable to remove ARGB
>> entirely from the primary plane if it does not to serve a purpose.
>> But
>> if the driver can do something useful with these formats, it might be
>> worth exposing that instead.
> On DC8000 display controllers (support for them is WIP by Joey Lu)
> there seem to be no way to control the blend behavior of the primary
> plane.
>
> On DC8200 display controllers the primary plane does have a blending
> register, although it seems to be blending with pure black.

IIRC there's a background-color property for the CRTC.  So it might be 
possible to expose this as read-only property. (Not sure.)

>
> Maybe it's viable to just remove the ARGB formats now, and re-introduce
> them when overlays are being implemented (and only expose them for the
> overlay)?

I see. Thanks for digging through this. I've meanwhile acked the patches 
as there's at least some support in hardware.

Best regards
Thomas


>
> Thanks,
> Icenowy
>
>> In pl111, we now remove the ARGB foramts because the hardware does
>> not
>> handle them at all. The situation seems less clear in verisilicon.
>>
>> Best regards
>> Thomas
>>
>>
>>> Thanks,
>>> Icenowy
>>>
>>>> Best regards
>>>> Thomas
>>>>
>>>>> Thanks,
>>>>> Icenowy
>>>>>
>>>>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>>>>> ---
>>>>>>     drivers/gpu/drm/verisilicon/vs_primary_plane.c | 3 +++
>>>>>>     1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> index 1f2be41ae496c..8d58682d88ef8 100644
>>>>>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> @@ -7,6 +7,7 @@
>>>>>>     
>>>>>>     #include <drm/drm_atomic.h>
>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>> +#include <drm/drm_blend.h>
>>>>>>     #include <drm/drm_crtc.h>
>>>>>>     #include <drm/drm_fourcc.h>
>>>>>>     #include <drm/drm_framebuffer.h>
>>>>>> @@ -179,5 +180,7 @@ struct drm_plane
>>>>>> *vs_primary_plane_init(struct
>>>>>> drm_device *drm_dev, struct vs_dc
>>>>>>     
>>>>>>     	drm_plane_helper_add(plane,
>>>>>> &vs_primary_plane_helper_funcs);
>>>>>>     
>>>>>> +	drm_plane_create_blend_mode_property(plane,
>>>>>> +					
>>>>>> BIT(DRM_MODE_BLEND_PIXEL_NONE));
>>>>>>     	return plane;
>>>>>>     }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


