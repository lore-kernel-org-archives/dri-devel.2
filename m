Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAD8FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:37:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04F810E0DC;
	Tue,  5 May 2026 07:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="l1WiNiLJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J9ADuZwJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l1WiNiLJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J9ADuZwJ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F18110E0DC
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 07:37:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B720E6AF6B;
 Tue,  5 May 2026 07:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777966623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x3lrU6ZbkgS/qIH2x95MHeCVqok7aXmzoUSK9KQZA2Y=;
 b=l1WiNiLJJ1p5VGvdSrKz3AqHs9DHUbEa9PwFAFTA1soZVpGjDmk6YPhGvdVJHP+Ri2Htgx
 Z7k0lvjeiR91uCQnaJ5pXHBl+T07T1p9AzuqvJ6WKFtL9HdMq3mwpZFP7CfODGZ9VFWXmN
 OI+hX6RZORAfSMstMpLHOmp1ILXWWE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777966623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x3lrU6ZbkgS/qIH2x95MHeCVqok7aXmzoUSK9KQZA2Y=;
 b=J9ADuZwJb2LnNlc3UhfUsd/5i4fi1YQImwFyTULgGGGspvRp9RTbwQ7msOjcYtLer9w/5E
 jvEioUyt/+cuR+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777966623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x3lrU6ZbkgS/qIH2x95MHeCVqok7aXmzoUSK9KQZA2Y=;
 b=l1WiNiLJJ1p5VGvdSrKz3AqHs9DHUbEa9PwFAFTA1soZVpGjDmk6YPhGvdVJHP+Ri2Htgx
 Z7k0lvjeiR91uCQnaJ5pXHBl+T07T1p9AzuqvJ6WKFtL9HdMq3mwpZFP7CfODGZ9VFWXmN
 OI+hX6RZORAfSMstMpLHOmp1ILXWWE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777966623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x3lrU6ZbkgS/qIH2x95MHeCVqok7aXmzoUSK9KQZA2Y=;
 b=J9ADuZwJb2LnNlc3UhfUsd/5i4fi1YQImwFyTULgGGGspvRp9RTbwQ7msOjcYtLer9w/5E
 jvEioUyt/+cuR+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770DC593A3;
 Tue,  5 May 2026 07:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X548GR+e+WnoSAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 05 May 2026 07:37:03 +0000
Message-ID: <dec75e9b-2784-4b63-a9c7-f99272e73544@suse.de>
Date: Tue, 5 May 2026 09:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 1/2] drm: verisilicon: add max cursor size to HWDB
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>
References: <20260324060222.2029061-1-zhengxingda@iscas.ac.cn>
 <20260324060222.2029061-2-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260324060222.2029061-2-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch]; 
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com,icenowy.me]; 
 RCPT_COUNT_SEVEN(0.00)[9]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email, suse.com:url, iscas.ac.cn:email]
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



Am 24.03.26 um 07:02 schrieb Icenowy Zheng:
> Different display controller variants support different maximum cursor
> size. All known DC8200 variants support both 32x32 and 64x64, but some
> DC8000 variants support either only 32x32 or up to 256x256.
>
> The minimum size is fixed at 32 and only PoT square sizes are supported.
>
> Add the max cursor size field to HWDB and fill all entries with 64.
>
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
> Changes in v2:
> - Added a comment about the cursor being square.
>
>   drivers/gpu/drm/verisilicon/vs_hwdb.c | 4 ++++
>   drivers/gpu/drm/verisilicon/vs_hwdb.h | 5 +++++
>   2 files changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> index 09336af0900ae..2a0f7c59afa3a 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -95,6 +95,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
>   		.customer_id = ~0U,
>   
>   		.display_count = 2,
> +		.max_cursor_size = 64,
>   		.formats = &vs_formats_no_yuv444,
>   	},
>   	{
> @@ -103,6 +104,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
>   		.customer_id = 0x30B,
>   
>   		.display_count = 2,
> +		.max_cursor_size = 64,
>   		.formats = &vs_formats_no_yuv444,
>   	},
>   	{
> @@ -111,6 +113,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
>   		.customer_id = 0x310,
>   
>   		.display_count = 2,
> +		.max_cursor_size = 64,
>   		.formats = &vs_formats_with_yuv444,
>   	},
>   	{
> @@ -119,6 +122,7 @@ static struct vs_chip_identity vs_chip_identities[] = {
>   		.customer_id = 0x311,
>   
>   		.display_count = 2,
> +		.max_cursor_size = 64,
>   		.formats = &vs_formats_no_yuv444,
>   	},
>   };
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> index 92192e4fa0862..2065ecb730437 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> @@ -20,6 +20,11 @@ struct vs_chip_identity {
>   	u32 customer_id;
>   
>   	u32 display_count;
> +	/*
> +	 * The hardware only supports square cursor planes, so this field
> +	 * is both the maximum width and height in pixels.
> +	 */
> +	int32_t max_cursor_size;
>   	const struct vs_formats *formats;
>   };
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


