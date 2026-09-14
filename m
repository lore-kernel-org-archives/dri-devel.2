Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DFCC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B5910EE0A;
	Mon, 14 Sep 2026 12:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JRQWt0CM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pKF5W324";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uTgSYGVD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J0MY04CB";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AA510E1D8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:11:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75ECF1F457;
 Mon, 14 Sep 2026 12:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789387894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eJq1peufPlqG+KQkJBrDzKBHONxaaFeps9w2MW68dyE=;
 b=JRQWt0CMWE54OzFsZHuUUQLssfYDjWoaEZ2qn2IJ5x+3VQBaJyFFputbgI60gVpGM1pIg3
 BxPqaJr3XyDcdcSgXxUW80Cv4PL7ATJ+j2sGKhNey2hcPSizhIloBnv4Ss1aAZ4Q27kEV1
 PYPE8Nu2MWG8z6dn9iP/gZC01UZqFro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789387894;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eJq1peufPlqG+KQkJBrDzKBHONxaaFeps9w2MW68dyE=;
 b=pKF5W324TcrEJ1JZMPhGOPpe1kQK6sY1gmuwBW839cdUAlk32WYBkTOC21Oz5YdF6+Srsp
 mbcdt59TeN9o8IAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uTgSYGVD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J0MY04CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789387890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eJq1peufPlqG+KQkJBrDzKBHONxaaFeps9w2MW68dyE=;
 b=uTgSYGVDRTrpcc0ziw7dCLpsR7poNkCc4t0x/BX3OBEabz08kSSjAG465VJpRwgBd40ZXE
 0o9OALMfQJGMGpsqlWWPqzY0CNvTIEDdOU+fTd+/04S55VGiTRjLlJcXlAb1qbn3UUbllP
 7xxfZDVSxeglPTtAXdURife5TtrSZPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789387890;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eJq1peufPlqG+KQkJBrDzKBHONxaaFeps9w2MW68dyE=;
 b=J0MY04CBlm6DZUHYNU79vlM/JCTP3AiW5eaBj4LL5n2l3gLAsKNpW6VTLi9guDcBAUNIPF
 Hm3BtxngRNwltsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 223F113515;
 Mon, 14 Sep 2026 12:11:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GX1yOXHkp2qKCQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 14 Sep 2026 12:11:29 +0000
Message-ID: <c8e76f8f-aa64-44f1-93ad-b998c03ea731@suse.de>
Date: Mon, 14 Sep 2026 14:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/imx: replace struct drm_simple_display_pipe with
 regular atomic helpers
To: Ze Huang <ze.huang@oss.qualcomm.com>, Maxime Ripard <mripard@redhat.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, imx@lists.linux.dev
References: <20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com>
 <20260716091459.1D8101F000E9@smtp.kernel.org>
 <DK1XPK73QJHC.JWFUMTTLOD1D@oss.qualcomm.com>
 <63cca05a-ec83-430c-abcf-c2f0b508446f@suse.de>
 <20260720-bold-jasmine-goldfish-d979e5@penduick>
 <DK45JBYJ8H1N.27UGNR6GBI6J5@oss.qualcomm.com>
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
In-Reply-To: <DK45JBYJ8H1N.27UGNR6GBI6J5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 75ECF1F457
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,suse.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
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

Am 21.07.26 um 11:46 schrieb Ze Huang:
> On Mon Jul 20, 2026 at 10:08 PM CST, Maxime Ripard wrote:
>> On Mon, Jul 20, 2026 at 02:36:19PM +0200, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 18.07.26 um 21:12 schrieb Ze Huang:
>>> [...]
>>>>>> -	if (event) {
>>>>>> -		crtc->state->event = NULL;
>>>>>> +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *plane,
>>>>>> +					      struct drm_atomic_commit *commit)
>>>>>> +{
>>>>>> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
>>>>>> +	struct drm_crtc *crtc = plane_state->crtc;
>>>>>> +	struct drm_crtc_state *crtc_state = NULL;
>>>>>> -		spin_lock_irq(&crtc->dev->event_lock);
>>>>>> +	if (crtc)
>>>>>> +		crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
>>>>>> -		if (crtc->state->active && drm_crtc_vblank_get(crtc) == 0)
>>>>>> -			drm_crtc_arm_vblank_event(crtc, event);
>>>>>> -		else
>>>>>> -			drm_crtc_send_vblank_event(crtc, event);
>>>>>> +	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
>>>>> [Severity: High]
>>>>> Can fetching the CRTC state this way cause a kernel panic in the core atomic
>>>>> helpers?
>>>>>
>>>>> If userspace submits a commit that modifies only plane properties without
>>>>> affecting the CRTC, the CRTC is not implicitly added to the atomic commit
>>>>> state.
>>>>>
>>>>> In this scenario, drm_atomic_get_new_crtc_state() returns NULL. Passing this
>>>>> NULL pointer directly to drm_atomic_helper_check_plane_state() causes a crash
>>>>> when it dereferences crtc_state->enable.
>>>>>
>>>>> Could this use drm_atomic_get_crtc_state() instead to ensure the state is
>>>>> brought into the commit if it is missing?
>>>> I think it is fine here; I'll just copy the pattern from [1].
>>>>
>>>> [1] https://elixir.bootlin.com/linux/v7.1.2/source/drivers/gpu/drm/mgag200/mgag200_mode.c#L487
>>> It could be that there's a long standing problem in the overall logic. Not
>>> having a CRTC (and hence crtc_state) should also mean !fb, so we'd return at
>>> [1]. If we have a CRTC on the plane but pass a crtc_state of NULL, we could
>>> get a panic at [2], where it does crtc_state->crtc.  I'm not aware of any
>>> bug reports about this problem, but it's still an issue.
>>>
>>> A number of drivers get this wrong by using
>>> drm_atomic_helper_get_new_crtc_state(). The bot suggests to use
>>> drm_atomic_helper_get_crtc_state() instead.  This helper also returns the
>>> new state. But  if there's no new state, it duplicates the CRTC's existing
>>> state. That's a bit of an overhead, but probably not an issue.  Several
>>> drivers use this helper, but also get it wrong. They tend to return early in
>>> the case of !crtc or !fb without calling _check_plane_state(). See [3] and
>>> [4] for examples.
>>>
>>> I think, going with the bot's suggestion to use
>>> drm_atomic_helper_get_crtc_state() might be the best resolution for now. It
>>> still needs a crtc pointer, so the pattern is
>>>
> Thank you Thomas and Maxime for the detailed explanations.
>
> I will follow the suggested pattern here:
>
>>> crtc_state = NULL
>>> if (plane_state->crtc)
>>>      crtc_state = drm_atomic_helper_get_crtc_state(plane_state->crtc)
>>>
>>> _check_plane_state(plane_state, crtc_state);

Is there an update to this patch available?

> IIUC, atomic_check is the last stage where valid to extend commit state.
> After that, the state is fixed and helpers should only use
> get_new_crtc_state() or get_old_crtc_state().
>
> My only remaining question is about the doc warning [1]:
>
>    * WARNING: Drivers may only add new CRTC states to a @state if
>    * drm_atomic_state.allow_modeset is set, or if it's a driver-internal
>    * commit not created by userspace through an IOCTL call.

I don't think this affects your work. If you just inline the existing 
simple-pipe it should be all good. (Or you duplicated existing bugs, but 
that doesn't make it worse either. :)

Best regards
Thomas

>
> if we end up adding the CRTC state for a userspace non-modeset commit,
> it could hit the requested/affected CRTC warning in
> drm_atomic_check_only() [2]. That would still be more acceptable than
> crashing, though.
>
> [1] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_atomic.c#L355
> [2] https://elixir.bootlin.com/linux/v7.1.3/source/drivers/gpu/drm/drm_atomic.c#L1746
>
> Thanks,
> Ze
>
>>> And in this case, _check_plane_state() should work correctly. But you can
>>> only use _get_crtc_state() in the atomic_check helpers! In the
>>> atomic_update, atomic_enable, etc helpers, it's too late for the helper to
>>> copy the CRTC state.
>>>
>>> I think some other DRM dev should look over this as well. It's one of the
>>> trickier things in DRM to get right.
>> drm_atomic_helper_get_crtc_state is safe in atomic_check. It's
>> everything after that must use either get_new_crtc_state or
>> get_old_crtc_state, as the global state cannot be modified anymore.
>>
>> Maxime
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


