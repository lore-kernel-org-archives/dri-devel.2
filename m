Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B9AFCD0C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14EB10E0B5;
	Wed, 18 Mar 2026 07:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VpWlTlH0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zWXPTdyo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VpWlTlH0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zWXPTdyo";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D4510E0B5
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:29:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18EF55BDD0;
 Wed, 18 Mar 2026 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773818958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NoxLiVapLiQH4fHf6SMIkJtqW8S60ZX8frDru9DGNG0=;
 b=VpWlTlH0Cap4H8xA9DThEfWCUdLuCSOHu8BZS+U+vkAErFUXyrSDS1LBCqTYrtFjdLlLaK
 7AIkfM43QxMglU5A+sZ5hbVf4QVn9F9gu/KtvLeoux3VG1Pfg2xwM+7kvIr+jK1mPMoGfK
 ojZyECB+7S1NxmJV6fPZjZcvrfD8WNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773818958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NoxLiVapLiQH4fHf6SMIkJtqW8S60ZX8frDru9DGNG0=;
 b=zWXPTdyodaVZ/u825P3NA3hCMonS1RxyW0WP4p3kP8xnxMGv9ldF1OuaHlsLXp16NHcj/M
 xpWolXBUXPU1BVDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773818958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NoxLiVapLiQH4fHf6SMIkJtqW8S60ZX8frDru9DGNG0=;
 b=VpWlTlH0Cap4H8xA9DThEfWCUdLuCSOHu8BZS+U+vkAErFUXyrSDS1LBCqTYrtFjdLlLaK
 7AIkfM43QxMglU5A+sZ5hbVf4QVn9F9gu/KtvLeoux3VG1Pfg2xwM+7kvIr+jK1mPMoGfK
 ojZyECB+7S1NxmJV6fPZjZcvrfD8WNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773818958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NoxLiVapLiQH4fHf6SMIkJtqW8S60ZX8frDru9DGNG0=;
 b=zWXPTdyodaVZ/u825P3NA3hCMonS1RxyW0WP4p3kP8xnxMGv9ldF1OuaHlsLXp16NHcj/M
 xpWolXBUXPU1BVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C53A34273B;
 Wed, 18 Mar 2026 07:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mbSyLk1UumndMAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 18 Mar 2026 07:29:17 +0000
Message-ID: <2efefedd-a36a-4b3c-a2cd-89db3499ebdb@suse.de>
Date: Wed, 18 Mar 2026 08:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/ast: DisplayPort edid supports 256 bytes
To: Jammy Huang <jammy_huang@aspeedtech.com>, Dave Airlie
 <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
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
In-Reply-To: <20260317-upstream_ast_dp_edid-v2-1-31166703c491@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[aspeedtech.com,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, bootlin.com:url, suse.com:url,
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

(cc Villa, Jani)

Hi

Am 17.03.26 um 13:19 schrieb Jammy Huang:
> DisplayPort supports EDID up to 256 bytes (blocks 0 and 1). Update the
> block check to allow these two blocks while returning 0 for any
> additional extension blocks.
>
> Furthermore, remove the manual EDID byte manipulation logic. The DRM
> core (drm_edid) already handles error correction and checksum
> validation.

Does that really work? AFAICT

- The allocations in _drm_do_get_edid() [1] do not guarantee that the 
memory is cleared to zero.
- If the helper detects an error, it will conditionally print an error [2].
- As ast is polling the EDID, it'll fill the kernel log over time with 
these warnings.

I think we'd still need some sort of 'valid error state' that signals an 
EOF that is not an error, but still counts as an invalid header.

Best regards
Thomas


[1] 
https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid.c#L2366
[2] 
https://elixir.bootlin.com/linux/v6.19.8/source/drivers/gpu/drm/drm_edid.c#L1919

>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
> ASPEED DisplayPort's EDID size can be 256 bytes at most. Thus, EDID
> blocks fetched can be 0 and 1.
> ---
> Changes in v2:
> Becasue drm-edid will handle invalid EDID if happen, we have 2 changes
> below.
> - Return 0 for the number of block more than 1.
> - Remove modification of EDID
> - Link to v1: https://lore.kernel.org/r/20260313-upstream_ast_dp_edid-v1-1-2a75b7c091b2@aspeedtech.com
> ---
>   drivers/gpu/drm/ast/ast_dp.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> index 9d07dad358c..282c694218c 100644
> --- a/drivers/gpu/drm/ast/ast_dp.c
> +++ b/drivers/gpu/drm/ast/ast_dp.c
> @@ -88,8 +88,8 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
>   	int ret = 0;
>   	unsigned int i;
>   
> -	if (block > 0)
> -		return -EIO; /* extension headers not supported */
> +	if (block > 1)
> +		return 0;
>   
>   	/*
>   	 * Protect access to I/O registers from concurrent modesetting
> @@ -154,20 +154,6 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
>   		ediddata[2] = ast_get_index_reg(ast, AST_IO_VGACRI, 0xda);
>   		ediddata[3] = ast_get_index_reg(ast, AST_IO_VGACRI, 0xdb);
>   
> -		if (i == 31) {
> -			/*
> -			 * For 128-bytes EDID_1.3,
> -			 * 1. Add the value of Bytes-126 to Bytes-127.
> -			 *		The Bytes-127 is Checksum. Sum of all 128bytes should
> -			 *		equal 0	(mod 256).
> -			 * 2. Modify Bytes-126 to be 0.
> -			 *		The Bytes-126 indicates the Number of extensions to
> -			 *		follow. 0 represents noextensions.
> -			 */
> -			ediddata[3] = ediddata[3] + ediddata[2];
> -			ediddata[2] = 0;
> -		}
> -
>   		memcpy(buf, ediddata, min((len - i), 4));
>   		buf += 4;
>   	}
>
> ---
> base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
> change-id: 20260313-upstream_ast_dp_edid-5fe6adf7ad36
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


