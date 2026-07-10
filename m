Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9157CC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F020110F7ED;
	Fri, 10 Jul 2026 07:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zdYflC81";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4B48zLyj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DvRUWlI2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u99xyAqW";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5023C10F7ED
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:50:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E1ED676394;
 Fri, 10 Jul 2026 07:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lr+csBEyRuR6ZlrAjKiwE+n25Eb6C5TB7eVN4rQnhzE=;
 b=zdYflC819M/LJg/RX4tDK/d3ErPMldG5Hl2szAvA7Mw0JfcafH51QA9n3HOnbHrgoqesFY
 gsT1+rAOFxVVLfrj1J8anWMvyWLtXkmZ0CT4oW/VUz/KDOjF2yWTK74JgPXFugbc5TwTLA
 3Fc9JVjAKUpSthw6ujeevcg6H9bKiI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lr+csBEyRuR6ZlrAjKiwE+n25Eb6C5TB7eVN4rQnhzE=;
 b=4B48zLyjS+w+S7ITt/EOr/bMBKGpSHKWO+o5kIwnbTO1bWgDiACSwGg7V5IjkA9Odq0oFU
 cIuNZ0N5XGk4Y+Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783669827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lr+csBEyRuR6ZlrAjKiwE+n25Eb6C5TB7eVN4rQnhzE=;
 b=DvRUWlI29lM9MbqbEK+0kNpmTlSMKXcunNkFucOwiU2fgKPYVGF2yt2VLKz8j59KyUjcyX
 Tfd+AP7BWYxMMpYzlHJAig2ZKOfjEYXJvcySEAD+Z5HmPD1vMCUvhQDDhRBUHIsAfEyWT9
 DiHcyf9a0Vvz38h/gG26scyrDIrffJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783669827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lr+csBEyRuR6ZlrAjKiwE+n25Eb6C5TB7eVN4rQnhzE=;
 b=u99xyAqWOQUu/8CHZDASQShHyq17J48uIBBBczsdBOiu+Q9MjGmwXDpffZGx3BYGQp542k
 2nE5qTSagATL4KAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA64E779BD;
 Fri, 10 Jul 2026 07:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9aIHLEOkUGrGOwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 07:50:27 +0000
Message-ID: <d7298a95-689d-432f-a341-66cd492ea175@suse.de>
Date: Fri, 10 Jul 2026 09:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/60] drm/simple-kms: Add create_plane_state hook
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-1-302d986fe5f0@kernel.org>
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
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-1-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
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



Am 09.07.26 um 13:50 schrieb Maxime Ripard:
> The simple-kms helper provides a reset_plane hook to let drivers
> override the default plane reset. However, the reset hook is
> overloaded: it is used to create the initial software state at probe
> time, but also to reset both the hardware and software state during
> suspend/resume. These two roles have different expectations, and
> reset is not fallible which makes error handling difficult.
>
> The atomic_create_state pattern was introduced to untangle this by
> providing a hook that only allocates and initializes a pristine state
> without any side effect.
>
> Add a create_plane_state hook to struct
> drm_simple_display_pipe_funcs. When provided,
> drm_simple_kms_plane_reset() will use it to allocate a fresh state,
> falling back to reset_plane and then to the default
> drm_atomic_helper_plane_reset().
>
> This will allow simple-kms drivers to be converted to the
> atomic_create_state pattern.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_simple_kms_helper.c | 23 +++++++++++++++++++++--
>   include/drm/drm_simple_kms_helper.h     |  1 +
>   2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index 8e1d07b9f1e3..efb643ab6448 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -284,14 +284,33 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
>   static void drm_simple_kms_plane_reset(struct drm_plane *plane)
>   {
>   	struct drm_simple_display_pipe *pipe;
>   
>   	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
> -	if (!pipe->funcs || !pipe->funcs->reset_plane)
> +	if (!pipe->funcs)
>   		return drm_atomic_helper_plane_reset(plane);
>   
> -	return pipe->funcs->reset_plane(pipe);
> +	if (pipe->funcs->reset_plane)
> +		return pipe->funcs->reset_plane(pipe);
> +
> +	if (pipe->funcs->create_plane_state) {
> +		struct drm_plane_state *state;
> +
> +		if (plane->state) {
> +			pipe->funcs->destroy_plane_state(pipe, plane->state);

Could be NULL, I think. You might want to duplicate the logic at

https://elixir.bootlin.com/linux/v7.2-rc1/source/drivers/gpu/drm/drm_simple_kms_helper.c#L312

> +			plane->state = NULL;
> +		}
> +
> +		state = pipe->funcs->create_plane_state(pipe);
> +		if (WARN_ON(IS_ERR(state)))
> +			return;
> +
> +		plane->state = state;
> +		return;
> +	}
> +
> +	return drm_atomic_helper_plane_reset(plane);
>   }
>   
>   static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
>   {
>   	struct drm_simple_display_pipe *pipe;
> diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
> index cb672ce0e856..b58f6d532820 100644
> --- a/include/drm/drm_simple_kms_helper.h
> +++ b/include/drm/drm_simple_kms_helper.h
> @@ -42,10 +42,11 @@ struct drm_simple_display_pipe_funcs {
>   	void (*reset_crtc)(struct drm_simple_display_pipe *pipe);
>   	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
>   	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
>   				   struct drm_crtc_state *crtc_state);
>   	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
> +	struct drm_plane_state * (*create_plane_state)(struct drm_simple_display_pipe *pipe);
>   	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
>   	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
>   				    struct drm_plane_state *plane_state);
>   };
>   
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


