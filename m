Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4142FC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A149510F399;
	Thu, 10 Sep 2026 08:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="WDYzUx1W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q+nnD4YA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t/Jsh+1D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V/2IgPQj";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5BF410F39C
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 08:57:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C07B21A59;
 Thu, 10 Sep 2026 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789030649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8H0Ubz2Ej30SibfxTOH1r29Sy5LjeCmcjTLxVVazWCM=;
 b=WDYzUx1WZQfzJY685aDEGczpzBLCCBn8AL3UvGLV3iHOk27CEF/DDX5qKt4uhVeTzTBFA/
 rwJniW5NerH9xvrcD+hib3gDjfIkeC3Y1ufcRlpDUxUZYaBJ0nRw0r4Ek09kDx72g4OCXU
 rPty8SeQy0euvxCVJeZ4HAs6EZC7708=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789030649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8H0Ubz2Ej30SibfxTOH1r29Sy5LjeCmcjTLxVVazWCM=;
 b=Q+nnD4YAhQQ9Ojp1nksBEbzqBLN13/X5AbLtuufUBpUYadQC2/GLpcMGp6657nhOAw6JmR
 llGcKbkvHw4eFACQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789030645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8H0Ubz2Ej30SibfxTOH1r29Sy5LjeCmcjTLxVVazWCM=;
 b=t/Jsh+1D343/vyR9BnxWkvcHEEAMoN8s87JlOerfvtsKlb2k1opKf92CdplYBI7G9zV6gr
 Xzr9bIrzwcDgooWYF59vy/eBvtpU/wlX3kU9RisNJ/MOE8qV4oaF2dbb08eGS6K5Tjhm6i
 UVoGIhKani0m5IYBtDR5e31CY2v2SCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789030645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8H0Ubz2Ej30SibfxTOH1r29Sy5LjeCmcjTLxVVazWCM=;
 b=V/2IgPQj0ag+XhdGwJZ9Lj3kVw/pV1xbmsL4k/Mi2DcIbvFO7p5vtK4QZwjyHHAmcJRtFy
 QhCtAbHOHwx7/vCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3ED31321C;
 Thu, 10 Sep 2026 08:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cghFI/RwompocQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 08:57:24 +0000
Message-ID: <056f3942-f4ea-4a59-ac25-b2099407784a@suse.de>
Date: Thu, 10 Sep 2026 10:57:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/hibmc: Set up vblank event to be send on the next
 vblank
To: Yongbang Shi <shiyongbang@huawei.com>,
 "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
 "tiantao (H)" <tiantao6@hisilicon.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Chenjianmin <chenjianmin@huawei.com>, shuliubin@huawei.com
References: <20260827082915.61176-1-tzimmermann@suse.de>
 <20260827082915.61176-3-tzimmermann@suse.de>
 <2a5a6bc2-d94b-4102-9c65-cf15dbb20eae@huawei.com>
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
In-Reply-To: <2a5a6bc2-d94b-4102-9c65-cf15dbb20eae@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 huawei.com:email, suse.de:mid, suse.de:email]
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

Am 08.09.26 um 15:23 schrieb Yongbang Shi:
>> Do not send the vblank event when the page flip completes, but when
>> the vblank interrupt fires. Sending the vblank event at the wrong time
>> can break synchronization of the display update with the vblank period.
>>
>> Use the vblank helper drm_crtc_vblank_atomic_flush(), which sets up
>> the vblank event accordingly. In case of an error, it still sends out
>> the vblank event immediately; thus not starving consumers.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 16 ++--------------
>>   1 file changed, 2 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c 
>> b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> index b4ab53db1c08..72ce696e6d11 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
>> @@ -20,6 +20,7 @@
>>   #include <drm/drm_gem_atomic_helper.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>>   #include <drm/drm_vblank.h>
>> +#include <drm/drm_vblank_helper.h>
>>     #include "hibmc_drm_drv.h"
>>   #include "hibmc_drm_regs.h"
>> @@ -420,19 +421,6 @@ static void hibmc_crtc_atomic_begin(struct 
>> drm_crtc *crtc,
>>       /* We can add more initialization as needed. */
>>   }
>>   -static void hibmc_crtc_atomic_flush(struct drm_crtc *crtc,
>> -                    struct drm_atomic_commit *state)
>> -
>> -{
>> -    unsigned long flags;
>> -
>> -    spin_lock_irqsave(&crtc->dev->event_lock, flags);
>> -    if (crtc->state->event)
>> -        drm_crtc_send_vblank_event(crtc, crtc->state->event);
>> -    crtc->state->event = NULL;
>> -    spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
>> -}
>> -
>>   static int hibmc_crtc_enable_vblank(struct drm_crtc *crtc)
>>   {
>>       struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
>> @@ -502,7 +490,7 @@ static const struct drm_crtc_funcs 
>> hibmc_crtc_funcs = {
>>   static const struct drm_crtc_helper_funcs hibmc_crtc_helper_funcs = {
>>       .mode_set_nofb    = hibmc_crtc_mode_set_nofb,
>>       .atomic_begin    = hibmc_crtc_atomic_begin,
>> -    .atomic_flush    = hibmc_crtc_atomic_flush,
>> +    .atomic_flush    = drm_crtc_vblank_atomic_flush,
>>       .atomic_enable    = hibmc_crtc_atomic_enable,
>>       .atomic_disable    = hibmc_crtc_atomic_disable,
>>       .mode_valid = hibmc_crtc_mode_valid,
>
> Reviewed-by: Yongbang Shi <shiyongbang@huawei.com>

Thanks for reviewing. I've merged the patches into drm-misc-next.

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


