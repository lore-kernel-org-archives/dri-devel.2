Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ECDCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBFD810F221;
	Mon,  8 Jun 2026 11:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="R3ygMS8J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UuQ4bQXA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R3ygMS8J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UuQ4bQXA";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E77D10F221
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:25:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC81A6A8C4;
 Mon,  8 Jun 2026 11:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780917927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5PhUKRNrkFo6QJIIpFgB6mvHPtqJ+3EPkKVjktRuz+Q=;
 b=R3ygMS8JBDzEcakqmn6JWQjquy5PKia1xVyQS/cz7W5zCEVE0EwWcCcsUbtrkoLRwlcSV6
 3tB/hfkP4ypdeTka4vFXkXjuJGCdztCRy4jD5TOxwj9PT/wrLhWSOf4BTpdoUZhI/CdBeo
 7zZPWuShePGc8de6K5Pb/zFqcuSM66U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780917927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5PhUKRNrkFo6QJIIpFgB6mvHPtqJ+3EPkKVjktRuz+Q=;
 b=UuQ4bQXAnAOYMZ1I/JxpIuag5+M73jsmDyFZCVImKXPE/4xEMjcO+9RBQVXgMs7TvXPbBj
 oBKjqSMHvQ6d40Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780917927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5PhUKRNrkFo6QJIIpFgB6mvHPtqJ+3EPkKVjktRuz+Q=;
 b=R3ygMS8JBDzEcakqmn6JWQjquy5PKia1xVyQS/cz7W5zCEVE0EwWcCcsUbtrkoLRwlcSV6
 3tB/hfkP4ypdeTka4vFXkXjuJGCdztCRy4jD5TOxwj9PT/wrLhWSOf4BTpdoUZhI/CdBeo
 7zZPWuShePGc8de6K5Pb/zFqcuSM66U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780917927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5PhUKRNrkFo6QJIIpFgB6mvHPtqJ+3EPkKVjktRuz+Q=;
 b=UuQ4bQXAnAOYMZ1I/JxpIuag5+M73jsmDyFZCVImKXPE/4xEMjcO+9RBQVXgMs7TvXPbBj
 oBKjqSMHvQ6d40Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B93B7779A7;
 Mon,  8 Jun 2026 11:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oN3rK6emJmobfAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Jun 2026 11:25:27 +0000
Message-ID: <b80a379d-87e4-45c4-a078-09e84a840895@suse.de>
Date: Mon, 8 Jun 2026 13:25:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
References: <20260607210203.229613-1-deller@gmx.de>
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
In-Reply-To: <20260607210203.229613-1-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 FREEMAIL_TO(0.00)[gmx.de,vger.kernel.org,lists.freedesktop.org];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[gmx.de:email,suse.com:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email, imap1.dmz-prg2.suse.org:helo,
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

Hi

Am 07.06.26 um 23:02 schrieb Helge Deller:
> The text display code used in the Risc PC kernel image decompression
> code uses arch/arm/boot/compressed/font.c, which includes
> lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
>
> Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
> glyph pitch and size") <linux/font.h> contains inline functions that
> require __do_div64, which is not linked into the ARM kernel
> decompressor. This makes Risc PC zImages fail to build.
>
> There is no need to use 64-bit division code here, so resolve this issue
> by using plain standard addition and shift maths.

Why is there a 64-bit division at all?

>
> Fixes: 97df8960240a ("lib/fonts: Provide helpers for calculating glyph pitch and size")
> Reported-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   include/linux/font.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/linux/font.h b/include/linux/font.h
> index 6845f02d739a..67d32268989d 100644
> --- a/include/linux/font.h
> +++ b/include/linux/font.h
> @@ -11,7 +11,6 @@
>   #ifndef _VIDEO_FONT_H
>   #define _VIDEO_FONT_H
>   
> -#include <linux/math.h>
>   #include <linux/types.h>
>   
>   struct console_font;
> @@ -35,7 +34,7 @@ struct console_font;
>    */
>   static inline unsigned int font_glyph_pitch(unsigned int width)
>   {
> -	return DIV_ROUND_UP(width, 8);
> +	return (width + 7) >> 3;

Ok by me, if that's what's necessary. But can we try to keep a 
documented macro for the division to make the code explain itself? Does 
it work with DIV_ROUND_UP_POW2() ?

Best regards
Thomas

>   }
>   
>   /**

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


