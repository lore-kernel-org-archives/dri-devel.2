Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0B606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xBT3hkpd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5ocw8uss;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xBT3hkpd;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5ocw8uss
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C8610F034;
	Mon, 16 Nov 2026 13:42:20 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1770810F034
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:42:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 962AE221BD;
 Mon, 16 Nov 2026 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794836527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f1+vxka76e+8hnc4s2/BRUfyzG0x6KSxkUIOdVoU9QI=;
 b=xBT3hkpdIoOC4Pbhq5A+kr6jEtXbBTn+Y6QEhZg89uETHYy5oX/aHp7UHG2Rboiy7fdQoY
 9UDx2HJavxbL5n4TfjSv9jZTHMsn1p/pZB2nX7RT6/M1PtezGdlJsSTFzs3cQqs6W+KQHn
 ZbhpmTndH6F0T1dBQNBAEciNEzlm9Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794836527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f1+vxka76e+8hnc4s2/BRUfyzG0x6KSxkUIOdVoU9QI=;
 b=5ocw8uss8O3+PJfehkW/Jdy2YjgJZf/f2rtjyxNJGpi65R5USn9WU4U7jznd1TYtNj1Rth
 HecujcnJRNuWP2CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794836527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f1+vxka76e+8hnc4s2/BRUfyzG0x6KSxkUIOdVoU9QI=;
 b=xBT3hkpdIoOC4Pbhq5A+kr6jEtXbBTn+Y6QEhZg89uETHYy5oX/aHp7UHG2Rboiy7fdQoY
 9UDx2HJavxbL5n4TfjSv9jZTHMsn1p/pZB2nX7RT6/M1PtezGdlJsSTFzs3cQqs6W+KQHn
 ZbhpmTndH6F0T1dBQNBAEciNEzlm9Nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794836527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f1+vxka76e+8hnc4s2/BRUfyzG0x6KSxkUIOdVoU9QI=;
 b=5ocw8uss8O3+PJfehkW/Jdy2YjgJZf/f2rtjyxNJGpi65R5USn9WU4U7jznd1TYtNj1Rth
 HecujcnJRNuWP2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E2F1334C;
 Mon, 16 Nov 2026 13:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EMJrNi4I+2pENgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 16 Nov 2026 13:42:07 +0000
Message-ID: <9765be24-b9b4-46f4-bdf4-782cd6a551d2@suse.de>
Date: Mon, 16 Nov 2026 14:42:06 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/verisilicon: check old state CRTC in plane
 atomic_disable
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joey Lu <a0987203069@gmail.com>, Han Gao <gaohan@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
References: <20261102075710.1286456-1-zhengxingda@iscas.ac.cn>
 <20261102075710.1286456-5-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20261102075710.1286456-5-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[11];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[iscas.ac.cn:email,suse.com:url,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,oss.qualcomm.com,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org,icenowy.me];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, iscas.ac.cn:email,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

Am 02.11.26 um 08:57 schrieb Icenowy Zheng:
> As atomic_update hooks of both planes would utilize atomic_disable
> functions to disable the plane when it's set to invisible (even when
> technically enabled), the atomic_disable functions need to check whether
> the plane is really enabled before.

Why? Why not just disable the plane?

Also see my review of the other patch. Why not remove that disable call 
from atomic_update?

Best regards
Thomas

>
> Add such a check to prevent NULL dereference.
>
> Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for Verisilicon display controllers")
> Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>   drivers/gpu/drm/verisilicon/vs_cursor_plane.c  | 13 ++++++++++---
>   drivers/gpu/drm/verisilicon/vs_primary_plane.c | 13 ++++++++++---
>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> index 5295dc2f9ee2e..bee19b65b9a4e 100644
> --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> @@ -104,9 +104,16 @@ static void vs_cursor_plane_atomic_disable(struct drm_plane *plane,
>   	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
>   								       plane);
>   	struct drm_crtc *crtc = state->crtc;
> -	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> -	unsigned int output = vcrtc->id;
> -	struct vs_dc *dc = vcrtc->dc;
> +	struct vs_crtc *vcrtc;
> +	unsigned int output;
> +	struct vs_dc *dc;
> +
> +	if (!crtc)
> +		return;
> +
> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	output = vcrtc->id;
> +	dc = vcrtc->dc;
>   
>   	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
>   			   VSDC_CURSOR_CONFIG_FMT_MASK,
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index e687313d6f057..01725e60e5fbd 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -65,9 +65,16 @@ static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
>   	struct drm_plane_state *state = drm_atomic_get_old_plane_state(atomic_state,
>   								       plane);
>   	struct drm_crtc *crtc = state->crtc;
> -	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
> -	unsigned int output = vcrtc->id;
> -	struct vs_dc *dc = vcrtc->dc;
> +	struct vs_crtc *vcrtc;
> +	unsigned int output;
> +	struct vs_dc *dc;
> +
> +	if (!crtc)
> +		return;
> +
> +	vcrtc = drm_crtc_to_vs_crtc(crtc);
> +	output = vcrtc->id;
> +	dc = vcrtc->dc;
>   
>   	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>   			  VSDC_FB_CONFIG_EX_FB_EN);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


