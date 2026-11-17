Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CECD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FgyifT/H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VRwK3SEO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BulXAFGk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JXDl1KRK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFECD10EA8A;
	Tue, 17 Nov 2026 07:25:21 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A47110EA8A
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:25:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA15122351;
 Tue, 17 Nov 2026 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794900309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNXepqh9JdZhE9EcvMeKfVeYD+3mbZeYYqcw1j7/1MY=;
 b=FgyifT/HhKR2tcWdav5hQno/evyImYZTELegCq/fUhEld2rCx9glMzX6L10Skr+ndrX8zJ
 VbrMtd0QYZS9bH93IOewdxbl4cn/npY5T8IKyiKmBoqq3CULyoPfAnYc002068sWHasTp4
 sy9DW+oo+lML7I+lMOFiluEheMoekGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794900309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNXepqh9JdZhE9EcvMeKfVeYD+3mbZeYYqcw1j7/1MY=;
 b=VRwK3SEOsYWtgUUtuc0LRZPgbep9JST4qixE5BBGl7Dcz/TTddFP9r62UL4nIWEH2at4gx
 xUcDSMbUTSeU0VCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BulXAFGk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JXDl1KRK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794900308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNXepqh9JdZhE9EcvMeKfVeYD+3mbZeYYqcw1j7/1MY=;
 b=BulXAFGkgXbJMEAJan28yxNOXpR71wKn4MtkqeuxQqS181+Hkxw30HszbIW21HKjuoU472
 YwnPRzCc1RFUPQlLM5kZic3WJzv4fS/scHqQzdfx6YbrT0bD9pBTZRhVRGSADNtidUq/zD
 XDgIS+ga8+RM1keLEYQQz5g2X3wzK5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794900308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FNXepqh9JdZhE9EcvMeKfVeYD+3mbZeYYqcw1j7/1MY=;
 b=JXDl1KRK6hhzZHsuTwEmyieuWe4Ai82Cg4v+5DWQeaLvdKOSIRQ/pDRcVBL3PbkzyKHbrc
 7mrwW7Djb05MY0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FAD41334C;
 Tue, 17 Nov 2026 07:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bydRBVQB/GpffwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 07:25:08 +0000
Message-ID: <a96e7813-6918-44f5-82e2-ca40051abea0@suse.de>
Date: Tue, 17 Nov 2026 08:25:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/verisilicon: nuke planes' atomic_enable hooks
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261102075710.1286456-1-zhengxingda@iscas.ac.cn>
 <20261102075710.1286456-3-zhengxingda@iscas.ac.cn>
 <8e3b36c6-e2d8-4746-aefe-462bba1a4b05@suse.de>
 <5830251f1420c152b2efc2ee37248057bdfc901d.camel@iscas.ac.cn>
 <55991183-ab5f-4445-afce-37a79310ef27@suse.de>
 <83aa9fb5be26fb407c7f1393bc01099d374cf51f.camel@iscas.ac.cn>
 <7e4b4fd185f47404bb5f18e7c2c8086d24e673f4.camel@iscas.ac.cn>
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
In-Reply-To: <7e4b4fd185f47404bb5f18e7c2c8086d24e673f4.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:url,bootlin.com:url,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,oss.qualcomm.com,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.50
X-Spam-Level: 
X-Rspamd-Queue-Id: CA15122351
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 17.11.26 um 06:19 schrieb Icenowy Zheng:
[...]
>>> Sure, but is that a problem for this hardware?
>> For the cursor plane, the unchecked coordinate might be improper for
>> the registers.
>>
>> For the primary plane, if the plane is found to be totally off by
>> drm_atomic_helper_check_plane_state(), the check for can_position,
>> which is below the code snippet I referenced, would be bypassed, and
>> such plane would be programmed to be visible by the atomic_update
>> hook
>> even if it shouldn't be visible.
> Well I am now thinking that bound-but-invisible situation is commonly
> ignored by drivers.
>
> For drm/verisilicon, maybe I'd remove both atomic_disable and
> atomic_enable; however I think the atomic helpers may need some flag to
> consider bound-but-invisible planes when calling atomic_{dis,en}able.

I don't think I really understand what you're up to, but it seems you're 
overthinking the whole thing. Other drivers only care about plane on/off 
and the contained image. That's also what the 3 callbacks are for. It 
usually works nicely. Hence me asking. But maybe verisilicon is 
different, IDK.

My suggestion is therefore to remove _enable and _disable and keep all 
logic in _update.

atomic_update()
{
     if (plane_state->visible) {
         // do update
         // enable hw plane
     } else {
         // disable hw plane
     }
}

If you have any special cases where you want visible to be false (or 
true), detect them in atomic_check and set the flags accordingly.

atomic_check()
{
drm_atomic_helper_check_plane_state()     if (awkward coords)
          plane_state->visible = false;
}

Best regards
Thomas

>
> Thanks,
> Icenowy
>
>> Thanks,
>> Icenowy
>>
>>> Best regards
>>> Thomas
>>>
>>>> The end of drm_atomic_helper_check_plane_state() says:
>>>>
>>>> ```
>>>> 	if (!plane_state->visible)
>>>> 		/*
>>>> 		 * Plane isn't visible; some drivers can handle
>>>> this
>>>> 		 * so we just return success here.  Drivers that
>>>> can't
>>>> 		 * (including those that use the primary plane
>>>> helper's
>>>> 		 * update function) will return an error from
>>>> their
>>>> 		 * update_plane handler.
>>>> 		 */
>>>> 		return 0;
>>>> ```
>>>>
>>>> Thanks,
>>>> Icenowy
>>>>
>>>>> [1]
>>>>> https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/drm_atomic_helper.c#L3030
>>>>>
>>>>> Best regards
>>>>> Thomas
>>>>>
>>>>>>     };
>>>>>>     
>>>>>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> index 8e94491693019..fca692f4f7d5c 100644
>>>>>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>>>>>> @@ -59,25 +59,6 @@ static void vs_primary_plane_commit(struct
>>>>>> vs_dc
>>>>>> *dc, unsigned int output)
>>>>>>     			VSDC_FB_CONFIG_EX_COMMIT);
>>>>>>     }
>>>>>>     
>>>>>> -static void vs_primary_plane_atomic_enable(struct drm_plane
>>>>>> *plane,
>>>>>> -					   struct
>>>>>> drm_atomic_commit *atomic_state)
>>>>>> -{
>>>>>> -	struct drm_plane_state *state =
>>>>>> drm_atomic_get_new_plane_state(atomic_state,
>>>>>> -
>>>>>> 							
>>>>>> 	       plane);
>>>>>> -	struct drm_crtc *crtc = state->crtc;
>>>>>> -	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>>>>> -	unsigned int output = vcrtc->id;
>>>>>> -	struct vs_dc *dc = vcrtc->dc;
>>>>>> -
>>>>>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>>>>>> -			VSDC_FB_CONFIG_EX_FB_EN);
>>>>>> -	regmap_update_bits(dc->regs,
>>>>>> VSDC_FB_CONFIG_EX(output),
>>>>>> -			
>>>>>> VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
>>>>>> -			
>>>>>> VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
>>>>>> -
>>>>>> -	vs_primary_plane_commit(dc, output);
>>>>>> -}
>>>>>> -
>>>>>>     static void vs_primary_plane_atomic_disable(struct
>>>>>> drm_plane
>>>>>> *plane,
>>>>>>     					    struct
>>>>>> drm_atomic_commit *atomic_state)
>>>>>>     {
>>>>>> @@ -144,13 +125,18 @@ static void
>>>>>> vs_primary_plane_atomic_update(struct drm_plane *plane,
>>>>>>     	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
>>>>>>     		     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
>>>>>>     
>>>>>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>>>>>> +			VSDC_FB_CONFIG_EX_FB_EN);
>>>>>> +	regmap_update_bits(dc->regs,
>>>>>> VSDC_FB_CONFIG_EX(output),
>>>>>> +			
>>>>>> VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
>>>>>> +			
>>>>>> VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
>>>>>> +
>>>>>>     	vs_primary_plane_commit(dc, output);
>>>>>>     }
>>>>>>     
>>>>>>     static const struct drm_plane_helper_funcs
>>>>>> vs_primary_plane_helper_funcs = {
>>>>>>     	.atomic_check	= vs_primary_plane_atomic_check,
>>>>>>     	.atomic_update	= vs_primary_plane_atomic_update,
>>>>>> -	.atomic_enable	= vs_primary_plane_atomic_enable,
>>>>>>     	.atomic_disable	=
>>>>>> vs_primary_plane_atomic_disable,
>>>>>>     };
>>>>>>     

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


