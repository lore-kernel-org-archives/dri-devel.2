Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEFC44506
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE69210E160;
	Fri, 10 Jul 2026 09:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="hpEXybam";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pe5OydWZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="19N0abh1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZEsO4mlr";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6AB10E160
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 09:20:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC5AD75812;
 Fri, 10 Jul 2026 09:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783675215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYQOZ2ZJlZLhMyn49dZB/YvdeR8VX1jrQuLVtd0Ybk4=;
 b=hpEXybam+Zdf5qRCKPNh0nTQd9x/+NijKOBP1qoRcwZAq5dS3t0VFz0cq3AnCrR5ovkE+c
 eQv+A4vX1HohNRaNFfKLkh/6hVjulzYmyYqlRYAWZKJNOgTzIo2MbRWmuy+pLybPpYi9wG
 3Q/09g28UY+bYLfZ0PVNhq4VmoGMQD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783675215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYQOZ2ZJlZLhMyn49dZB/YvdeR8VX1jrQuLVtd0Ybk4=;
 b=pe5OydWZccIE2eOGfwbU5jTGxfwNeX94geKmFMQGsNwtru7RV+vedeSy26Hlah3vmSA7wr
 KAQb/BR4owTGF7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783675213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYQOZ2ZJlZLhMyn49dZB/YvdeR8VX1jrQuLVtd0Ybk4=;
 b=19N0abh1zbcHOKtpqfowYN+xZ8sIisOW+oEAcHpEEQredil0ZH0x7bqSOJuPjfAOtlHHsJ
 s+pRLm5Pcrz6XG0raP3/disgqUTTHEN7FK93fIvioBuwh+i6dRmc9W2TU9ZqQ/8/Pap3mJ
 t5CbSVUMRx+RwpLdh4MSxqEkJ4XIA+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783675213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYQOZ2ZJlZLhMyn49dZB/YvdeR8VX1jrQuLVtd0Ybk4=;
 b=ZEsO4mlrT2mxiAYoSKVHg5yHqS/UIhvbZhtcs0744Cq9qd4IIXomkcxKMfNtH/TDloHmar
 0nNx1STgH3bDQGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5F42779BD;
 Fri, 10 Jul 2026 09:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2/pVJ025UGqPFAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 09:20:13 +0000
Message-ID: <2e5e0fb4-da13-4250-8395-d59ad5700cf5@suse.de>
Date: Fri, 10 Jul 2026 11:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/gm12u320: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: sashiko-reviews@lists.linux.dev, Ze Huang <ze.huang@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
 <20260704184538.E20261F000E9@smtp.kernel.org>
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
In-Reply-To: <20260704184538.E20261F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email, suse.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Am 04.07.26 um 20:45 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Race condition and potential NULL pointer dereference due to direct access to `plane->state` and missing visibility checks in atomic callbacks.
>
> Pre-existing issues:
> - [High] Sleeping in atomic context within CRTC and plane atomic callbacks.
> --
>
> commit a10b3d5781e3b7143f432c86643ef47e8ddc3a9a
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic helpers
>
> Convert gm12u320 to direct primary plane, CRTC and encoder setup.
> Keep shadow-plane helper state, framebuffer access helpers and
> no-scaling plane-state check from simple-KMS path.
>
>> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
>> index 4ad074337af07..b476793d0401e 100644
>> --- a/drivers/gpu/drm/tiny/gm12u320.c
>> +++ b/drivers/gpu/drm/tiny/gm12u320.c
> [ ... ]
>
>> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					       struct drm_atomic_commit *commit)
>>   {
>>   	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
>> -	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
>> +	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
>> +	struct drm_plane_state *plane_state = crtc->primary->state;
> [Severity: High]
> Will this cause a NULL pointer dereference if a subsequent commit disables
> the plane?

Primary is for (old) non-atomic DRM drivers.

>
> Because non-blocking commits execute asynchronously, crtc->primary->state
> reflects the state of the most recently queued commit, rather than the
> commit currently executing. If a fast subsequent commit disables the plane,
> plane_state->fb could be NULL.
>
> Should this use drm_atomic_get_new_plane_state(commit, crtc->primary) to
> get the state tied to this specific commit?

No. Changes that require plane state should go into the plane's 
atomic_enable or atomic_update.

>
>>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
>>   
>>   	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
>>   	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
>>   }
>>   
>> -static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
>> +static void gm12u320_crtc_helper_atomic_disable(struct drm_crtc *crtc,
>> +						struct drm_atomic_commit *commit)
>>   {
>> -	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
>> +	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
>>   
>>   	gm12u320_stop_fb_update(gm12u320);
> [Severity: High]
> This isn't a bug introduced by this patch, but does gm12u320_stop_fb_update()
> sleep in atomic context?

This is a false positive.

Best regards
Thomas

>
> gm12u320_stop_fb_update() calls cancel_delayed_work_sync() and mutex_lock().
> Since CRTC atomic disable callbacks can run in atomic context during
> non-blocking commits, sleeping here is forbidden and could cause kernel
> warnings or deadlocks.
>
>>   }
>>   
>> -static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
>> -				 struct drm_plane_state *old_state)
>> +static void gm12u320_plane_helper_atomic_update(struct drm_plane *plane,
>> +						struct drm_atomic_commit *commit)
>>   {
>> -	struct drm_plane_state *state = pipe->plane.state;
>> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
>> +	struct drm_plane_state *state = plane->state;
> [Severity: High]
> Could accessing plane->state directly here lead to a crash?
>
> Similar to the CRTC enable function, reading plane->state directly instead of
> using drm_atomic_get_new_plane_state(commit, plane) accesses the future
> state.
>
> If a subsequent commit disables the plane, state->fb will be NULL. In this
> scenario, drm_atomic_helper_damage_merged() returns true for plane
> disablements, leading to gm12u320_fb_mark_dirty() being called with a NULL
> fb, which will oops when trying to dereference fb->dev.
>
> This wasn't possible before because the drm_simple_kms_helper explicitly
> checked if (!plane->state->visible) before calling the update hook, but
> that protection is dropped in this conversion.
>
>> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>>   	struct drm_rect rect;
>>   
>> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>> +	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>>   		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
> [Severity: High]
> This is a pre-existing issue, but does gm12u320_fb_mark_dirty() sleep in
> atomic context?
>
> It calls mutex_lock(&gm12u320->fb_update.lock), which is unsafe to call
> from a plane update callback during non-blocking commits, as these run
> in atomic context.
>
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


