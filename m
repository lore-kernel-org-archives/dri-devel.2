Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4816DC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F02C10E7B3;
	Mon,  6 Jul 2026 07:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zCgjAI6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ZUu++hR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zCgjAI6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ZUu++hR";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E64510E7B3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 07:43:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4C5E759A7;
 Mon,  6 Jul 2026 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783323796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=08mM5gDTURucsGOhS+HdslmQIHzZiRSggy8aPce9TiE=;
 b=zCgjAI6fpA6GmcgNxyuzJYM8KOKA/6QaBBf0JmY261B5Tn5KYNVPyCA9m2XC//t4TExRPd
 WwN9iYO76FPsHxNDYYdEGiutBmdi+h+6KzT05S5arVhHpCnfkl8oY7xNIu1VP8NBiWIVKI
 dtyUShE6tNfCq/tsZoAsCXCxaL3p0VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783323796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=08mM5gDTURucsGOhS+HdslmQIHzZiRSggy8aPce9TiE=;
 b=2ZUu++hRze2+Op2oUeinD/MlR4/Evs+M08V2foYX6ZH6wVqaIjDE62Fggq6bEzBdYmCWd+
 yeGo1nj+hgQsLRCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783323796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=08mM5gDTURucsGOhS+HdslmQIHzZiRSggy8aPce9TiE=;
 b=zCgjAI6fpA6GmcgNxyuzJYM8KOKA/6QaBBf0JmY261B5Tn5KYNVPyCA9m2XC//t4TExRPd
 WwN9iYO76FPsHxNDYYdEGiutBmdi+h+6KzT05S5arVhHpCnfkl8oY7xNIu1VP8NBiWIVKI
 dtyUShE6tNfCq/tsZoAsCXCxaL3p0VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783323796;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=08mM5gDTURucsGOhS+HdslmQIHzZiRSggy8aPce9TiE=;
 b=2ZUu++hRze2+Op2oUeinD/MlR4/Evs+M08V2foYX6ZH6wVqaIjDE62Fggq6bEzBdYmCWd+
 yeGo1nj+hgQsLRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B6AC779AA;
 Mon,  6 Jul 2026 07:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OkawHJRcS2q9fwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 06 Jul 2026 07:43:16 +0000
Message-ID: <17c3bd76-9c01-436c-932d-159e936ef1f1@suse.de>
Date: Mon, 6 Jul 2026 09:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/arcpgu: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: sashiko-reviews@lists.linux.dev, Ze Huang <ze.huang@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
 <20260704184304.6567A1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260704184304.6567A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, qualcomm.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid]
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



Am 04.07.26 um 20:43 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] NULL pointer dereference when enabling CRTC without a primary plane framebuffer.

False positive here. Calling drm_atomic_helper_check_primary_plane() 
from the CRTC's atomic check makes it impossible to enable the CRTC 
without a primary plane.



>
> Pre-existing issues:
> - [High] Unsafe direct access of global plane and CRTC state pointers in atomic commit callbacks.
> --
>
> commit 6344532446cab68117e44660f110ef0c8aec15d7
> Author: Ze Huang <ze.huang@oss.qualcomm.com>
>
> drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic helpers
>
> This commit replaces drm_simple_display_pipe with regular atomic helpers.
> It instantiates the plane, CRTC, and encoder directly, wiring them up with
> standard atomic helpers to remove the dependency on the simple-KMS interface.
>
>> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
>> index c93d61ac0bb75..375cdb79e4e89 100644
>> --- a/drivers/gpu/drm/tiny/arcpgu.c
>> +++ b/drivers/gpu/drm/tiny/arcpgu.c
> [ ... ]
>> @@ -117,7 +117,7 @@ static const u32 arc_pgu_supported_formats[] = {
>>   
>>   static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>>   {
>> -	const struct drm_framebuffer *fb = arcpgu->pipe.plane.state->fb;
>> +	const struct drm_framebuffer *fb = arcpgu->plane.state->fb;
> [Severity: High]
> This isn't a bug introduced by this patch, but does reading the global
> plane->state pointer here instead of using the state passed via the
> drm_atomic_commit parameter cause issues during non-blocking atomic commits?
>
> If multiple non-blocking commits are queued rapidly, the global pointers
> advance to the newest state. When the first commit's commit_tail finally
> executes, reading plane->state directly instead of extracting the specific
> commit's state could cause the older commit to program the hardware using a
> future commit's state.
>
> [Severity: High]
> Can this dereference a NULL pointer if the CRTC is enabled without a primary
> plane framebuffer?
>
> The transition from drm_simple_display_pipe to generic atomic helpers removed
> the underlying protection that previously prevented the CRTC from enabling
> without a valid framebuffer. If userspace performs an atomic commit that
> enables the CRTC but sets the primary plane's framebuffer to 0 (NULL),
> drm_atomic_helper_check_crtc_primary_plane verifies the plane is attached but
> does not enforce plane_state->fb != NULL.
>
> This would allow the commit to proceed to arcpgu_crtc_helper_atomic_enable(),
> which calls arc_pgu_mode_set(), and then arc_pgu_set_pxl_fmt(), blindly
> dereferencing fb->format->format here.
>
>>   	uint32_t pixel_format = fb->format->format;
>>   	u32 format = DRM_FORMAT_INVALID;
>>   	int i;
> [ ... ]
>> @@ -155,7 +155,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struct drm_simple_display_pipe *p
>>   
>>   static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
>>   {
>> -	struct drm_display_mode *m = &arcpgu->pipe.crtc.state->adjusted_mode;
>> +	struct drm_display_mode *m = &arcpgu->crtc.state->adjusted_mode;
> [Severity: High]
> This is a pre-existing issue, but could reading the global crtc->state pointer
> directly cause hardware state corruption or frame tearing?
>
> Similar to the plane state issue above, if rapid non-blocking atomic commits
> are generated, arc_pgu_mode_set() might read from the newest global state
> rather than the specific commit's state object.
>
>>   	u32 val;
>>   
>>   	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
> [ ... ]
>> @@ -218,35 +218,106 @@ static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
>>   			      ~ARCPGU_CTRL_ENABLE_MASK);
>>   }
>>   
>> -static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
>> -			   struct drm_plane_state *state)
>> +static void arcpgu_plane_helper_atomic_update(struct drm_plane *plane,
>> +					      struct drm_atomic_commit *state)
>>   {
>>   	struct arcpgu_drm_private *arcpgu;
>>   	struct drm_gem_dma_object *gem;
>>   
>> -	if (!pipe->plane.state->fb)
>> +	if (!plane->state->fb)
> [Severity: High]
> This is a pre-existing issue, but does arcpgu_plane_helper_atomic_update()
> safely handle non-blocking atomic commits when reading plane->state->fb
> directly?
>
> Reading the global plane->state pointer instead of extracting the new plane
> state from the drm_atomic_commit parameter could result in the same race
> condition during asynchronous commit_tail execution.
>
>>   		return;
>>   
>> -	arcpgu = pipe_to_arcpgu_priv(pipe);
>> -	gem = drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
>> +	arcpgu = dev_to_arcpgu(plane->dev);
>> +	gem = drm_fb_dma_get_gem_obj(plane->state->fb, 0);
>>   	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


