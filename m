Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBFBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA7F10F7FC;
	Fri, 10 Jul 2026 07:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="G07hH0Kp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZDja15r2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E7qTytVd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Us67Zd5o";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6705010F7FC
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:56:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0EB176676;
 Fri, 10 Jul 2026 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783670209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1HVocjxuucTWEiMHgsGEDPs+K3HA5mr52sd9EdUCifI=;
 b=G07hH0KpnBomhe/LpYBngUDAScM1xUw7b8fILQMVSQ0xpqfiy0q0ZmnklhknS94RAwA3BF
 7HOIfdPbSAJ/G/ou7T0iEn09/N6RJyCcuzNhBjHgk/zTn/nJB1CUHB1lB5n4Y8toemK0mB
 w3J+snvFBglnttLyaoFn3JZgqyD4dZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783670209;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1HVocjxuucTWEiMHgsGEDPs+K3HA5mr52sd9EdUCifI=;
 b=ZDja15r2CW+6lQ9aAREjv8kB2UdhO/bgiYHhPVyz8VvlR91b0LT0RSci2EmLSHP02sgRhm
 1ymihyvn2WvOtGDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E7qTytVd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Us67Zd5o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783670208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1HVocjxuucTWEiMHgsGEDPs+K3HA5mr52sd9EdUCifI=;
 b=E7qTytVdzkP0GYnePI8shVSZ4J5Ql1PthKAlY6Cz62gO6VKiXRoDcRH6OWju9akCWg6tyu
 GU9zdNRjFh+3FfBbnbnWFJkLhsfdvPI9emtLH2Yk7Ds/b/jypnv/AGuhrawTlS6nYtpTDl
 1qQunovQmJVVjAVrOxTK8VokMPb4eCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783670208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1HVocjxuucTWEiMHgsGEDPs+K3HA5mr52sd9EdUCifI=;
 b=Us67Zd5oD1wM9gAhPP/y8rqf2FY18l1z2VYTncR7JSSs0l+e2+ixGS17rHsCaoaa8XJwcR
 WQV+M54LXwoZVNBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B93EC779BD;
 Fri, 10 Jul 2026 07:56:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4pfjK8ClUGr9QQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 10 Jul 2026 07:56:48 +0000
Message-ID: <f88c61fb-53ac-4d15-a0c6-49ee72899a1d@suse.de>
Date: Fri, 10 Jul 2026 09:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/60] drm/simple-kms: Switch to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-7-302d986fe5f0@kernel.org>
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
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-7-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E0EB176676
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email, suse.de:mid]
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



Am 09.07.26 um 13:50 schrieb Maxime Ripard:
> drm_simple_kms_plane_reset() handled three cases: delegating to
> reset_plane, using create_plane_state with manual teardown, or
> falling back to the default helper. This complexity existed to bridge
> the old reset hook with the new create_plane_state hook during the
> transition.
>
> Now that all simple-kms drivers implement create_plane_state instead
> of reset_plane, replace drm_simple_kms_plane_reset() with
> drm_simple_kms_plane_create_state() which only dispatches between
> create_plane_state and drm_atomic_helper_plane_create_state(). Wire
> it to .atomic_create_state instead of .reset.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/gpu/drm/drm_simple_kms_helper.c | 30 ++++++------------------------
>   1 file changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
> index efb643ab6448..c99ff74dca92 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -279,38 +279,20 @@ static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
>   	.end_fb_access = drm_simple_kms_plane_end_fb_access,
>   	.atomic_check = drm_simple_kms_plane_atomic_check,
>   	.atomic_update = drm_simple_kms_plane_atomic_update,
>   };
>   
> -static void drm_simple_kms_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *
> +drm_simple_kms_plane_create_state(struct drm_plane *plane)
>   {
>   	struct drm_simple_display_pipe *pipe;
>   
>   	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
> -	if (!pipe->funcs)
> -		return drm_atomic_helper_plane_reset(plane);
> +	if (!pipe->funcs || !pipe->funcs->create_plane_state)
> +		return drm_atomic_helper_plane_create_state(plane);
>   
> -	if (pipe->funcs->reset_plane)
> -		return pipe->funcs->reset_plane(pipe);
> -
> -	if (pipe->funcs->create_plane_state) {
> -		struct drm_plane_state *state;
> -
> -		if (plane->state) {
> -			pipe->funcs->destroy_plane_state(pipe, plane->state);
> -			plane->state = NULL;
> -		}
> -
> -		state = pipe->funcs->create_plane_state(pipe);
> -		if (WARN_ON(IS_ERR(state)))
> -			return;
> -
> -		plane->state = state;
> -		return;
> -	}
> -
> -	return drm_atomic_helper_plane_reset(plane);
> +	return pipe->funcs->create_plane_state(pipe);
>   }
>   
>   static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
>   {
>   	struct drm_simple_display_pipe *pipe;
> @@ -336,11 +318,11 @@ static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
>   
>   static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
>   	.update_plane		= drm_atomic_helper_update_plane,
>   	.disable_plane		= drm_atomic_helper_disable_plane,
>   	.destroy		= drm_plane_cleanup,
> -	.reset			= drm_simple_kms_plane_reset,
> +	.atomic_create_state	= drm_simple_kms_plane_create_state,
>   	.atomic_duplicate_state	= drm_simple_kms_plane_duplicate_state,
>   	.atomic_destroy_state	= drm_simple_kms_plane_destroy_state,
>   	.format_mod_supported   = drm_simple_kms_format_mod_supported,
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


