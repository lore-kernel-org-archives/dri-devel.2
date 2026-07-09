Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3290AC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81E0E10F5DF;
	Thu,  9 Jul 2026 13:49:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="NRR8+fPW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mfSrcv4x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QnBy3zIF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YEmqk8mK";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D5D10F5DF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 13:49:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B675B75F4C;
 Thu,  9 Jul 2026 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783604983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tw65sIbB/D4xT3jHGXJJ8qRyi3x2xoYLQLypm8XjDUE=;
 b=NRR8+fPW8ElzXYatHG8olsNQm/v5rbYSQxe4BWx2eAIx/bvNQOM991j2QOk43+3NWzjhio
 G2Uf7yJptBFqCu0TxOWpEnN830HnxEfEisoI1S/nIWNW+DMD4L9WCqsro3VIimkDJYgfXq
 zUwb4tIhvRqbf/7aNfe2Ye4SsCB/Vbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783604983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tw65sIbB/D4xT3jHGXJJ8qRyi3x2xoYLQLypm8XjDUE=;
 b=mfSrcv4xJOPjCKpcwVj1jFc+PNWvfJ6jz/47FbnyEkUFeeuHk4BXF9wgKsoaxqfghe1ous
 y0ggRNpoZAzlzIBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QnBy3zIF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YEmqk8mK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783604981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tw65sIbB/D4xT3jHGXJJ8qRyi3x2xoYLQLypm8XjDUE=;
 b=QnBy3zIFbITiocgidj9+fC01Tpwi/X0fei3u5fpPxtooAcZ6FS+Yd1gdPU7ZjLCFf1qIeu
 k8KNsclJINvGoiUpK1jfS81Q/AxAoJGlUDEjpx0M1q0mR3ZWU/m1Yn+ibR9ATMVssbMb1w
 gEhiZmhBLMcL8WHqxT/QDJrpxZ5VaPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783604981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tw65sIbB/D4xT3jHGXJJ8qRyi3x2xoYLQLypm8XjDUE=;
 b=YEmqk8mKbvMo51ufMoWIqcbOqXX2tu65jZoIWr4fGVsxmuBwCRskiJfPIXFKitRbrM+3EC
 9rdzaN1my4FM4jBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D2F9779AA;
 Thu,  9 Jul 2026 13:49:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u88YIfWmT2pFRQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 09 Jul 2026 13:49:41 +0000
Message-ID: <d043767d-585f-4e63-9da0-3cc92361616c@suse.de>
Date: Thu, 9 Jul 2026 15:49:41 +0200
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B675B75F4C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Hi Maxime

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

Have you seen 
https://lore.kernel.org/dri-devel/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com/ 
? Once this lands, simple-kms will have no users left and be gone soon 
after.

I assume that creating that new callback here is the easiest way forward 
for atomic_create_state?

Best regards
Thomas

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


