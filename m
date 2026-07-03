Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE30C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D27410E62B;
	Fri,  3 Jul 2026 15:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="thZIok9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="brVsF2c/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="thZIok9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="brVsF2c/";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DEB10E62C
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:29:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E22575BE3;
 Fri,  3 Jul 2026 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783092545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B6sF8RevYAtD/Aj/oOTx+4FO/HSSlgbCyZs+i236I9s=;
 b=thZIok9y2lGw/eDwPFtvrBkCi2JDEfhYFoCmC1pYSn5b15ydXA73Kt7rgMBriYD/frjdxU
 tt7QlfBL+/6khSWBoTwm1wVz2k9Iik8YOZUJOIxX/fK2EC6aSVJjjeT60cId69L4INrs6J
 gP99ZY5diuPFhL3spx3HemoeFCajgyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783092545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B6sF8RevYAtD/Aj/oOTx+4FO/HSSlgbCyZs+i236I9s=;
 b=brVsF2c/2yjupuz/CZfR8mlo7c20Hvhm7Uf7TCd3hRC852g53f8JmZ+KmMWzIHLZKM4mSe
 n5DEYQMK/a3h7WDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783092545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B6sF8RevYAtD/Aj/oOTx+4FO/HSSlgbCyZs+i236I9s=;
 b=thZIok9y2lGw/eDwPFtvrBkCi2JDEfhYFoCmC1pYSn5b15ydXA73Kt7rgMBriYD/frjdxU
 tt7QlfBL+/6khSWBoTwm1wVz2k9Iik8YOZUJOIxX/fK2EC6aSVJjjeT60cId69L4INrs6J
 gP99ZY5diuPFhL3spx3HemoeFCajgyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783092545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B6sF8RevYAtD/Aj/oOTx+4FO/HSSlgbCyZs+i236I9s=;
 b=brVsF2c/2yjupuz/CZfR8mlo7c20Hvhm7Uf7TCd3hRC852g53f8JmZ+KmMWzIHLZKM4mSe
 n5DEYQMK/a3h7WDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28B7B779AA;
 Fri,  3 Jul 2026 15:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q8+tCEHVR2qvVAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 03 Jul 2026 15:29:05 +0000
Message-ID: <8510322c-59d5-4c36-82ec-9103963d9bfd@suse.de>
Date: Fri, 3 Jul 2026 17:29:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vboxvideo: Use damage iterator and plane damage
 clips
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260703151841.375364-1-tzimmermann@suse.de>
 <20260703152810.B08271F000E9@smtp.kernel.org>
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
In-Reply-To: <20260703152810.B08271F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, suse.com:url]
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



Am 03.07.26 um 17:28 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the plane atomic update callback `vbox_primary_atomic_update` calls `mutex_lock(&vbox->hw_mutex)`, which is a sleeping function. Calling a sleeping function in an atomic context violates DRM/KMS design rules.

This is a false positive.

> --
>
> commit 5090cc8b95319e5f88f32549af73d197156ce225
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/vboxvideo: Use damage iterator and plane damage clips
>
> This commit modifies the vboxvideo driver to use the damage iterator
> for plane updates. It also enables damage clips for the plane to minimize
> the display update area.
>
>> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
>> index 8e4e5fc9d3c5a..cd78071b6cbbf 100644
>> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
>> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> [ ... ]
>> @@ -282,9 +283,10 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
>>   									   plane);
>>   	struct drm_crtc *crtc = new_state->crtc;
>>   	struct drm_framebuffer *fb = new_state->fb;
>> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>>   	struct vbox_private *vbox = to_vbox_dev(fb->dev);
>> -	struct drm_mode_rect *clips;
>> -	uint32_t num_clips, i;
>> +	struct drm_rect damage;
>> +	struct drm_atomic_helper_damage_iter iter;
>>   
>>   	vbox_crtc_set_base_and_mode(crtc, fb,
>>   				    new_state->src_x >> 16,
>> @@ -292,22 +294,17 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
>>   
>>   	/* Send information about dirty rectangles to VBVA. */
>>   
>> -	clips = drm_plane_get_damage_clips(new_state);
>> -	num_clips = drm_plane_get_damage_clips_count(new_state);
>> -
>> -	if (!num_clips)
>> -		return;
>> -
>>   	mutex_lock(&vbox->hw_mutex);
> [Severity: High]
> This isn't a bug introduced by this patch, but vbox_primary_atomic_update()
> calls mutex_lock(&vbox->hw_mutex).
>
> Can calling this sleeping function in an atomic context cause kernel warnings
> or deadlocks during non-blocking commits? The same mutex is also acquired
> earlier in this callback by vbox_crtc_set_base_and_mode().
>
>>   
>> -	for (i = 0; i < num_clips; ++i, ++clips) {
>> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_state);
>> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
>>   		struct vbva_cmd_hdr cmd_hdr;
>>   		unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
>>   
>> -		cmd_hdr.x = (s16)clips->x1;
>> -		cmd_hdr.y = (s16)clips->y1;
>> -		cmd_hdr.w = (u16)clips->x2 - clips->x1;
>> -		cmd_hdr.h = (u16)clips->y2 - clips->y1;
>> +		cmd_hdr.x = (s16)damage.x1;
>> +		cmd_hdr.y = (s16)damage.y1;
>> +		cmd_hdr.w = (u16)drm_rect_width(&damage);
>> +		cmd_hdr.h = (u16)drm_rect_height(&damage);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


