Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51121EDB7CC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 07:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E9010E361;
	Tue,  7 Apr 2026 07:47:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="J62vqnD/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wqguoxvg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J62vqnD/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wqguoxvg";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8449610E361
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 07:47:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36B565BD52;
 Tue,  7 Apr 2026 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775548058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ez3Ds+Gka04y9/JCj7oAeQ7ND4je+f4Jxy74oie9wJA=;
 b=J62vqnD/FI4Lgk1+4F1CmztDHZhE8Kr4v3V6ER77HmkpGwS+VsHzy3Rf9FajOCgPvPb2vT
 R5pVSD4Q5mHkGHTo4JUQpbkuT2Lju2q08LmLQsnZNKgpruC61sOstCw0UqLR0qbgZUSw2x
 STuCm2TWpWPb7/SCW5c5rXu1lniERW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775548058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ez3Ds+Gka04y9/JCj7oAeQ7ND4je+f4Jxy74oie9wJA=;
 b=WqguoxvgjX6WXBX6kmvSkb+5m6KcdHjI0CNzL55JkpMj/BbPhbEvfHp85mjQzajLZDxiSW
 WVzZM5VvgbGO7KAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775548058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ez3Ds+Gka04y9/JCj7oAeQ7ND4je+f4Jxy74oie9wJA=;
 b=J62vqnD/FI4Lgk1+4F1CmztDHZhE8Kr4v3V6ER77HmkpGwS+VsHzy3Rf9FajOCgPvPb2vT
 R5pVSD4Q5mHkGHTo4JUQpbkuT2Lju2q08LmLQsnZNKgpruC61sOstCw0UqLR0qbgZUSw2x
 STuCm2TWpWPb7/SCW5c5rXu1lniERW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775548058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ez3Ds+Gka04y9/JCj7oAeQ7ND4je+f4Jxy74oie9wJA=;
 b=WqguoxvgjX6WXBX6kmvSkb+5m6KcdHjI0CNzL55JkpMj/BbPhbEvfHp85mjQzajLZDxiSW
 WVzZM5VvgbGO7KAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCDB94A0B0;
 Tue,  7 Apr 2026 07:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id x8C2NJm21GlUbQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 07 Apr 2026 07:47:37 +0000
Message-ID: <c8c6b2a0-4ef4-44df-9f38-4f5b8d50dac4@suse.de>
Date: Tue, 7 Apr 2026 09:47:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/fb-helper: Fix a locking bug in an error path
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Bart Van Assche <bvanassche@acm.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
References: <20260403205355.1181984-1-bvanassche@acm.org>
 <1c03e4d8-0eac-4863-a18d-1ea750c853fb@suse.de>
Content-Language: en-US
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
In-Reply-To: <1c03e4d8-0eac-4863-a18d-1ea750c853fb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,amd.com,oss.qualcomm.com,redhat.com,gmail.com,ffwll.ch,lists.freedesktop.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email, suse.com:url, suse.de:mid,
 suse.de:email, acm.org:email, amd.com:email]
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

(cc: dri-devel)

Am 07.04.26 um 09:44 schrieb Thomas Zimmermann:
> Hi
>
> Am 03.04.26 um 22:53 schrieb Bart Van Assche:
>> The name of the function __drm_fb_helper_initial_config_and_unlock() and
>> also the comment above that function make it clear that all code paths
>> in this function should unlock fb_helper->lock before returning. Add a
>> mutex_unlock() call in the only code path where it is missing. This has
>> been detected by the Clang thread-safety analyzer.
>>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Christian König <christian.koenig@amd.com> # radeon
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # msm
>> Cc: Javier Martinez Canillas <javierm@redhat.com>
>> Fixes: 63c971af4036 ("drm/fb-helper: Allocate and release fb_info in 
>> single place")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Thanks a lot.
>
> Best regards
> Thomas
>
>> ---
>>   drivers/gpu/drm/drm_fb_helper.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_fb_helper.c 
>> b/drivers/gpu/drm/drm_fb_helper.c
>> index 05803169bed5..16bfbfb0af16 100644
>> --- a/drivers/gpu/drm/drm_fb_helper.c
>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>> @@ -1641,8 +1641,10 @@ 
>> __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper 
>> *fb_helper)
>>       drm_client_modeset_probe(&fb_helper->client, width, height);
>>         info = drm_fb_helper_alloc_info(fb_helper);
>> -    if (IS_ERR(info))
>> +    if (IS_ERR(info)) {
>> +        mutex_unlock(&fb_helper->lock);
>>           return PTR_ERR(info);
>> +    }
>>         ret = drm_fb_helper_single_fb_probe(fb_helper);
>>       if (ret < 0) {
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


