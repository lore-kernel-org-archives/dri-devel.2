Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D30CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30FA10F5DA;
	Fri, 22 May 2026 13:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="OT9XjWCb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oTCD+481";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wcjtJpsR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sKripMDz";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE3C10F5DA
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:24:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF4C866E99;
 Fri, 22 May 2026 13:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779456246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
 b=OT9XjWCbOOI5MMAiFo+3Md6Tt1BUPOFCLxCN23TTBPO1MfJG1S6IT5AC63ztal7hKnUt3F
 MA0Wu8x9rysxe/SsQdAQ1GKzICAr7cAP9MHMd+ogdyRP25ESwBn7P1glFGgrg88/Ha8F5h
 5eJMiSoR3OsbdXcwsoeK/LkSNtBEYjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779456246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
 b=oTCD+4814lWIUlRhDzd2RcxNkMsYsfGnRqRPWQoconmCet/tcclE5S4FcbcEVi6Ewf7fzq
 LgwmlMGMKiqPANCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779456245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
 b=wcjtJpsRlRanv4/JZokBVgfj9LpFqjAyzDHQs0VDZ9VwJXntdNKXm4IPxhNBVhtTj3Xqme
 JqRDBVQee8ws4UhhoI/niXsvgawOd8vmpDqX2D0ALVqXPP5MVoiWfnSOvA5ZcqECM7ZT8i
 hoUav1aAiha+arHB+k43PQF+67DmkEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779456245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZ+0ozTeC95GVs+zn1nU36tePjWc71LaXoy5Wu1qDZY=;
 b=sKripMDzRWw6fOseJDFgrA3JqU3VkZ9eaGqECb7N61BoTu9MKDlc15bUnHe+I/RyhpmPoF
 pEnxg5oZgexxxlAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82F48593A8;
 Fri, 22 May 2026 13:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id StNxHvVYEGp+LgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 13:24:05 +0000
Message-ID: <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
Date: Fri, 22 May 2026 15:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, stable@vger.kernel.org
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
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
In-Reply-To: <ahBWayIcQUHuAt4i@intel.com>
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
 FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org,icenowy.me];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, bootlin.com:url,
 suse.com:url, suse.de:mid]
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

Am 22.05.26 um 15:13 schrieb Ville Syrjälä:
> On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
>>> Currently the implementaion of drm_client_modeset_wait_for_vblank()
>>> assumes drm_vblank_get() will fail when the CRTC isn't active. However
>>> it seems that this is not true, and running fbcon on a device with the
>>> first CRTC inactive will lead to kernel warning in some cases (which
>>> could be reproduced with the loongson driver).
>>>
>>> Change the implementation to add a check for the active state (atomic) /
>>> enabled state (non-atomic) before calling drm_vblank_get(). As the
>>> assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
>>> error status of drm_vblank_get() can now be exported too.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
>>> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>>> ---
>>>    drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
>>> index bb49b8361271a..1b03bf351256e 100644
>>> --- a/drivers/gpu/drm/drm_client_modeset.c
>>> +++ b/drivers/gpu/drm/drm_client_modeset.c
>>> @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>>>    {
>>>    	struct drm_device *dev = client->dev;
>>>    	struct drm_crtc *crtc;
>>> -	int ret;
>>> +	int ret = 0;
>>>    
>>>    	/*
>>>    	 * Rate-limit update frequency to vblank. If there's a DRM master
>>> @@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
>>>    	 * Only wait for a vblank event if the CRTC is enabled, otherwise
>>>    	 * just don't do anything, not even report an error.
>>>    	 */
>>> +	if (drm_drv_uses_atomic_modeset(dev)) {
>>> +		if (!crtc->state || !crtc->state->active)
>>> +			goto out;
>>> +	} else {
>>> +		if (!crtc->enabled)
>>> +			goto out;
>>> +	}
>>> +
>> This part is good.
> Locking is missing.

Ok

>
>>>    	ret = drm_crtc_vblank_get(crtc);
>>>    	if (!ret) {
>>>    		drm_crtc_wait_one_vblank(crtc);
>>>    		drm_crtc_vblank_put(crtc);
>>>    	}
>>>    
>>> +out:
>>>    	drm_master_internal_release(dev);
>>>    
>>> -	return 0;
>>> +	return ret;
>> But this isn't. There can be CRTCs without any vblank at all. We still
>> want to fail silently for them. So we still have to return 0 here.
>>
>> Having set this, fixing this helper is only partially what you want.
>> Since your device has vblanking, the emulation should check on the
>> correct CRTC. IOW you need to pass the right CRTC index at
>>
>> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L237
>> https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_fb_helper.c#L920
>>
>> I'm not quite sure how to support this. The CRTC is under
>> fb_helper->client.modesets.crtc. You'd have to figure out which is the
>> relevant one and use that. But that's also not so great, as fbdev ioctls
>> only support CRTC 0. Doing internal re-mappings only complicates matters.
>>
>> But why does your HW use CRTC 1 in the first place.
> Could be eg. the enabled outputs can't be driven with CRTC 0.
>
> I guess what you want to do is pick the first crtc from modesets[]
> which is enabled. Or perhaps even "pick the Nth enabled crtc from
> modesets[] based on the ioctl argument".

The enable-status of each CRTC could change later on, which might lead 
to problems.  Picking the one CRTC/output with the lowest spec and 
mirroring it to the others might work. This CRTC would then be the one 
to wait for.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


