Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01957C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1A610E08B;
	Wed,  1 Jul 2026 15:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="BMuyIvya";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kZIEh43U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HFFzaV0s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8dHuZEdB";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E98210E08B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 15:12:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACF7B73CA1;
 Wed,  1 Jul 2026 15:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782918722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ujg+vtUnBUkcn7uviv9/aDnhHZF7ivi24qrblUlDVCs=;
 b=BMuyIvyao2NbmLgd4tfQiqcJtrbtmGiG0rCMfOqnKfj9rNv/pz0AVItygpsHmuPe1vOlHm
 uLOepuZOVfM3NIt2Cce1gp8xechL1bXxrIgQcrwonrqm8Z3MU5JI/FhbCGQjK9BwwTZHVn
 NjPHE/uLKq7Waveal2a6Zcyhb1OTqIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782918722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ujg+vtUnBUkcn7uviv9/aDnhHZF7ivi24qrblUlDVCs=;
 b=kZIEh43UUM4nmbhu0ppeIuhXlRUMThF0/1TT/ukQ+7j4rDYV3laxxaF3SPP+E3Kp/r5bC9
 g6hJ6phiDohRaxBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782918721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ujg+vtUnBUkcn7uviv9/aDnhHZF7ivi24qrblUlDVCs=;
 b=HFFzaV0sQ46F8/nlD6dwWvbcPqlKK8OTYhQXQws6AWhoZuyEqkSLWhVc+keZjPQdCxX55Q
 Yr47S/vJVrnPHdZKPEQ33+6mHGYtxVeNtwgP15R96+z7ddj4g/jbe6fQy/ZnXU/LVAyNDH
 y+RI4a1W4t+6pFPpj+Bf09XNmI23eGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782918721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ujg+vtUnBUkcn7uviv9/aDnhHZF7ivi24qrblUlDVCs=;
 b=8dHuZEdBfQXyHszo8KRIm77kEVFYe7NFAdAdGqIBTK1LCOjeBxmYO075wkZM3JQSgcquiP
 tZd48CDAOOBTXhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96BAF779AA;
 Wed,  1 Jul 2026 15:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cm9gI0EuRWoKcAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Jul 2026 15:12:01 +0000
Message-ID: <9044e7b8-7cec-400c-a1fd-a12f2198ff05@suse.de>
Date: Wed, 1 Jul 2026 17:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260701130929.234695-1-tzimmermann@suse.de>
 <20260701132359.BE4101F000E9@smtp.kernel.org>
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
In-Reply-To: <20260701132359.BE4101F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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



Am 01.07.26 um 15:23 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm_atomic_helper_check_plane_damage() is placed too late in the atomic check pipeline and conditionally bypassed, breaking the damage clipping contract during modesets.

This is intentionally. We need check_plane_damage only for the call to 
damage iterators that comes next.

> --
>
> commit 5c79bcf5010895b431b3c2135c7b80a5163d8e9f
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/i915/display: Handle struct drm_plane_state.ignore_damage_clips
>
> This commit introduces a call to drm_atomic_helper_check_plane_damage() in
> intel_psr2_sel_fetch_update() to selectively ignore damage clipping in certain
> framebuffer changes.
>
>> diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
>> index 92af21d823a37..5a155f60110fb 100644
>> --- a/drivers/gpu/drm/i915/display/intel_psr.c
>> +++ b/drivers/gpu/drm/i915/display/intel_psr.c
> [ ... ]
>> @@ -2949,6 +2949,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
>>   		src = drm_plane_state_src(&new_plane_state->uapi);
>>   		drm_rect_fp_to_int(&src, &src);
>>   
>> +		/* Prepare plane-damage state before using it */
>> +		drm_atomic_helper_check_plane_damage(&state->base, &new_plane_state->uapi);
>> +
>>   		if (!drm_atomic_helper_damage_merged(&old_plane_state->uapi,
> [Severity: High]
> Is this call to drm_atomic_helper_check_plane_damage() placed too late in the
> atomic check pipeline?
>
> By placing it here in intel_psr2_sel_fetch_update() (which runs during the CRTC
> check phase), intel_plane_atomic_check() has already run and called
> intel_plane_copy_uapi_plane_damage(). That means new_plane_state->damage was
> already calculated using the unsanitized fb_damage_clips before this check
> could clear them during a full modeset.
>
> Additionally, this loop selectively skips planes on non-PSR2 CRTCs or planes
> with changed visibility (e.g. via the continue statements earlier in the loop).
> Doesn't this mean the damage state is left unsanitized for those skipped
> planes, potentially causing visual corruption when restricted clip rectangles
> are used instead of updating the full plane?
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


