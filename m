Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7E606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fkDx/84D;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N16F/WX6;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=fkDx/84D;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=N16F/WX6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4170510EBEC;
	Tue, 20 Oct 2026 14:02:07 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0242910EC0E
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 14:01:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DADF1F7CE;
 Tue, 20 Oct 2026 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792504914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uznkZEUIFvEpXNXHnSwIcWEt6sAuhbyXC6tEGoV81KA=;
 b=fkDx/84DQWnVvNdJp8VDlgtnif9S6JTDikQjmlk+f06hzEK0CzjwGlgLix7VufVxVRBAiK
 pkqqkgFZqKlFFSSq/LQZ3vzpVoKNj/rv5Nnuvhnbxmec1s6J7ew5pAs76eRGZmboMSkOps
 W1BZ9JULMrtSvQGF4jT7aqZz+UEMpmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792504914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uznkZEUIFvEpXNXHnSwIcWEt6sAuhbyXC6tEGoV81KA=;
 b=N16F/WX6RIg/ehk0Xjg4ekB+Qfs/G6Q544Iglt8K+x/5EC6WewN+oUcHUtkWGZ8O70hxu6
 figNjym8lCMf31AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792504914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uznkZEUIFvEpXNXHnSwIcWEt6sAuhbyXC6tEGoV81KA=;
 b=fkDx/84DQWnVvNdJp8VDlgtnif9S6JTDikQjmlk+f06hzEK0CzjwGlgLix7VufVxVRBAiK
 pkqqkgFZqKlFFSSq/LQZ3vzpVoKNj/rv5Nnuvhnbxmec1s6J7ew5pAs76eRGZmboMSkOps
 W1BZ9JULMrtSvQGF4jT7aqZz+UEMpmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792504914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uznkZEUIFvEpXNXHnSwIcWEt6sAuhbyXC6tEGoV81KA=;
 b=N16F/WX6RIg/ehk0Xjg4ekB+Qfs/G6Q544Iglt8K+x/5EC6WewN+oUcHUtkWGZ8O70hxu6
 figNjym8lCMf31AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E46136C6;
 Tue, 20 Oct 2026 14:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z9CKAlJ012qiIgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 20 Oct 2026 14:01:54 +0000
Message-ID: <a051d06b-ff48-497f-a58f-1a42c2aa08c2@suse.de>
Date: Tue, 20 Oct 2026 16:01:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 68/75] drm/ast: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-68-586c9c026823@kernel.org>
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
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-68-586c9c026823@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 suse.de:email]
X-Spam-Score: -4.29
X-Spam-Level: 
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Am 14.10.26 um 19:27 schrieb Maxime Ripard:
> The ast DisplayPort connector reset implementation creates a custom
> state subclass, but only initializes a pristine state without resetting
> any hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

with nitpicks below.

> ---
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   drivers/gpu/drm/ast/ast_dp.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index f22c0c215a21..7708169d0254 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -467,21 +467,22 @@ static int ast_astdp_connector_helper_detect_ctx(struct drm_connector *connector
>   static const struct drm_connector_helper_funcs ast_astdp_connector_helper_funcs = {
>   	.get_modes = ast_astdp_connector_helper_get_modes,
>   	.detect_ctx = ast_astdp_connector_helper_detect_ctx,
>   };
>   
> -static void ast_astdp_connector_reset(struct drm_connector *connector)
> +static struct drm_connector_state *ast_astdp_connector_create_state(struct drm_connector *connector)
>   {
> -	struct ast_astdp_connector_state *astdp_state = kzalloc_obj(*astdp_state);
> +	struct ast_astdp_connector_state *astdp_state;
>   
> -	if (connector->state)
> -		connector->funcs->atomic_destroy_state(connector, connector->state);
> +	astdp_state = kzalloc_obj(*astdp_state);
> +	if (!astdp_state)
> +		return ERR_PTR(-ENOMEM);
>   
> -	if (astdp_state)
> -		__drm_atomic_helper_connector_reset(connector, &astdp_state->base);
> -	else
> -		__drm_atomic_helper_connector_reset(connector, NULL);
> +	__drm_atomic_helper_connector_state_init(&astdp_state->base,
> +						 connector);

No need to break the line here.

> +
> +	return &astdp_state->base;
>   }
>   
>   static struct drm_connector_state *
>   ast_astdp_connector_atomic_duplicate_state(struct drm_connector *connector)
>   {
> @@ -511,11 +512,11 @@ static void ast_astdp_connector_atomic_destroy_state(struct drm_connector *conne
>   	__drm_atomic_helper_connector_destroy_state(&astdp_state->base);
>   	kfree(astdp_state);
>   }
>   
>   static const struct drm_connector_funcs ast_astdp_connector_funcs = {
> -	.reset = ast_astdp_connector_reset,
> +	.atomic_create_state = ast_astdp_connector_create_state,

Should go before atomic_duplicate_state

Best regards
Thomas

>   	.fill_modes = drm_helper_probe_single_connector_modes,
>   	.destroy = drm_connector_cleanup,
>   	.atomic_duplicate_state = ast_astdp_connector_atomic_duplicate_state,
>   	.atomic_destroy_state = ast_astdp_connector_atomic_destroy_state,
>   };
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


