Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49020C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC6910E5D4;
	Thu, 10 Sep 2026 11:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uhXbmsJu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJz56hU6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0FER41Kx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MpRYXXlM";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C62510E5D4
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 11:03:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C782D21C40;
 Thu, 10 Sep 2026 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789038208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wWqhgF1J2JRbMZMddiRQ+EjnJbf+ErBMlr9RMj9sbNY=;
 b=uhXbmsJumbeXhcl9C46oL4wXQkRxZUMj8Up3YX3M8bvZ9I8E1v9Apd2XQVnGpzhniyiTV+
 OiJ/iGQDqT6ieowCLldLCng3Vh3qDPwwMi53dNm8W4GcQH7UBzkyzveWCyYat1IT8cojeb
 TojFQfGXDvgwC8hpTzPMhM7yvLR4MjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789038208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wWqhgF1J2JRbMZMddiRQ+EjnJbf+ErBMlr9RMj9sbNY=;
 b=xJz56hU6SsvWbQpKhCmJmL8CsEX1xvZJQhAIutP3fxtul8sRu16M2wibpigz531UmAwkMy
 dnOtTdhgGakOQXCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0FER41Kx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MpRYXXlM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789038204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wWqhgF1J2JRbMZMddiRQ+EjnJbf+ErBMlr9RMj9sbNY=;
 b=0FER41Kxs2yd3e5eAq6c7WNcOL1DoSI2MpAq7HOEJs731DyWi7hsc0B0lylMZ0GB0QUZpa
 4McvmCNCruQKc6hC9Wo8XptyAoWb54LJI2XCv77IjuJC94RM/Y0MmyWzxEx2mSLEFgyXVV
 7WqpPntff8v05oJDlMZhFclrW7MjwRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789038204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wWqhgF1J2JRbMZMddiRQ+EjnJbf+ErBMlr9RMj9sbNY=;
 b=MpRYXXlMwLiSnwlNkUFMhW257O1+rO9hw4YadG9uB9tW1eAHN+fO7DEorAMvYbi/vfcci9
 STOiCvR3okNkDLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD3313180;
 Thu, 10 Sep 2026 11:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hOydDHyOompscgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 11:03:24 +0000
Message-ID: <5ba5cc8c-37fc-4490-a4d4-0ede476035de@suse.de>
Date: Thu, 10 Sep 2026 13:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/verisilicon: add primary modifier for format
 tables
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>
References: <20260910095000.3505878-1-zhengxingda@iscas.ac.cn>
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
In-Reply-To: <20260910095000.3505878-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C782D21C40
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,icenowy.me];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:dkim, suse.de:email,
 suse.de:mid, iscas.ac.cn:email, imap1.dmz-prg2.suse.org:rdns,
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

Hi

Am 10.09.26 um 11:49 schrieb Icenowy Zheng:
> Currently the format tables are only used for the primary plane.
>
> Add primary modifiers to names related to the tables.
>
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

for both patches.

> ---
>   drivers/gpu/drm/verisilicon/vs_hwdb.c          | 12 ++++++------
>   drivers/gpu/drm/verisilicon/vs_hwdb.h          |  4 ++--
>   drivers/gpu/drm/verisilicon/vs_primary_plane.c |  4 ++--
>   3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> index 2a0f7c59afa3a..56aa450443068 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
> @@ -10,7 +10,7 @@
>   #include "vs_dc_top_regs.h"
>   #include "vs_hwdb.h"
>   
> -static const u32 vs_formats_array_no_yuv444[] = {
> +static const u32 vs_primary_formats_array_no_yuv444[] = {
>   	DRM_FORMAT_XRGB4444,
>   	DRM_FORMAT_XBGR4444,
>   	DRM_FORMAT_RGBX4444,
> @@ -44,7 +44,7 @@ static const u32 vs_formats_array_no_yuv444[] = {
>   	/* TODO: non-RGB formats */
>   };
>   
> -static const u32 vs_formats_array_with_yuv444[] = {
> +static const u32 vs_primary_formats_array_with_yuv444[] = {
>   	DRM_FORMAT_XRGB4444,
>   	DRM_FORMAT_XBGR4444,
>   	DRM_FORMAT_RGBX4444,
> @@ -79,13 +79,13 @@ static const u32 vs_formats_array_with_yuv444[] = {
>   };
>   
>   static const struct vs_formats vs_formats_no_yuv444 = {
> -	.array = vs_formats_array_no_yuv444,
> -	.num = ARRAY_SIZE(vs_formats_array_no_yuv444)
> +	.primary_array = vs_primary_formats_array_no_yuv444,
> +	.primary_num = ARRAY_SIZE(vs_primary_formats_array_no_yuv444)
>   };
>   
>   static const struct vs_formats vs_formats_with_yuv444 = {
> -	.array = vs_formats_array_with_yuv444,
> -	.num = ARRAY_SIZE(vs_formats_array_with_yuv444)
> +	.primary_array = vs_primary_formats_array_with_yuv444,
> +	.primary_num = ARRAY_SIZE(vs_primary_formats_array_with_yuv444)
>   };
>   
>   static struct vs_chip_identity vs_chip_identities[] = {
> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> index 2065ecb730437..616076d931a57 100644
> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
> @@ -10,8 +10,8 @@
>   #include <linux/types.h>
>   
>   struct vs_formats {
> -	const u32 *array;
> -	unsigned int num;
> +	const u32 *primary_array;
> +	unsigned int primary_num;
>   };
>   
>   struct vs_chip_identity {
> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> index 1f2be41ae496c..8e94491693019 100644
> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
> @@ -168,8 +168,8 @@ struct drm_plane *vs_primary_plane_init(struct drm_device *drm_dev, struct vs_dc
>   
>   	plane = drmm_universal_plane_alloc(drm_dev, struct drm_plane, dev, 0,
>   					   &vs_primary_plane_funcs,
> -					   dc->identity.formats->array,
> -					   dc->identity.formats->num,
> +					   dc->identity.formats->primary_array,
> +					   dc->identity.formats->primary_num,
>   					   NULL,
>   					   DRM_PLANE_TYPE_PRIMARY,
>   					   NULL);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


