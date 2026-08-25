Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370BCC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770DF10E9F1;
	Tue, 25 Aug 2026 11:49:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ROShbCK7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ub6ffh8n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzWQJxu/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OejX3832";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FAB10E9EB
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 11:49:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68DC11F7A8;
 Tue, 25 Aug 2026 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787658586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nFF/gan8dlD9AeRZZSrrzUVp6gqPZ1dDiqv5lIt4htU=;
 b=ROShbCK7Dqnnyo40fJNr7kFxc/ggQe9JTB4TB/QJiI7jGLozxNwUMM7Luc+PGYr4sGIJZj
 RgQ6HMLkcT68uxsiw2//FMBjgKdMKVAOJ/LR6q3g3EZExyLsYKERSDHf8DoDUGigcL5ewu
 sIbV5xVgI34Eg2hylWw3e8uSGqDtHK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787658586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nFF/gan8dlD9AeRZZSrrzUVp6gqPZ1dDiqv5lIt4htU=;
 b=ub6ffh8nsZuxqoQmweGC2Rd9kNfFha0XxFvGjLXJviOiP5zgfpGV/HjTvL2CPNa3zo4ymQ
 aY8tJu0YDa6be4CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787658582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nFF/gan8dlD9AeRZZSrrzUVp6gqPZ1dDiqv5lIt4htU=;
 b=YzWQJxu/MYjHURVM2Xcvl2yZHDF4OrI0etalMJh3lxTD8QR6qtg3XhfBM4Ldn7dzTgBNy1
 ALPG81x4zxYaIgbNx4BkPUChrO4lIo3vMUH7rp6anS0sQR46yY5rN4VOIDnidEXOpKkXo5
 96f0vNYlW4hhxaiQo3LKgx+SPF4ENcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787658582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nFF/gan8dlD9AeRZZSrrzUVp6gqPZ1dDiqv5lIt4htU=;
 b=OejX3832oUrBTlYfV+n22FkL0xW00fpmPx5A/LkUmqYZuOLJjMm0wDO2tmoZdVaAiSdQgW
 CgAMiX+TLZNf7FAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3167E13331;
 Tue, 25 Aug 2026 11:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CenDClaBjWpiVQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 25 Aug 2026 11:49:42 +0000
Message-ID: <732b5615-a2e3-4c04-8269-a0c95da132aa@suse.de>
Date: Tue, 25 Aug 2026 13:49:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] drm/sysfb: Fix atomic_disable to use dst
 coordinates instead of src
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20260825104117.667943-1-oushixiong1025@163.com>
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
In-Reply-To: <20260825104117.667943-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[163.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,kylinos.cn];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, kylinos.cn:email]
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

Am 25.08.26 um 12:41 schrieb oushixiong1025@163.com:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> drm_sysfb_plane_helper_atomic_disable() constructs the clear rectangle
> from plane_state->src_* coordinates. This is inconsistent with
> drm_sysfb_plane_helper_atomic_update() which uses plane_state->dst
> — the destination rectangle already computed by the DRM core with panel
> orientation applied.
>
> Use plane_state->dst directly, matching the approach in atomic_update.

Thanks for bringing this up.  I think the issue needs to be addressed in 
a different way.  The plane's video memory is behind dst_vmap. It needs 
to be cleared to 0 entirely without considering any user-given sizes.  
The relevant size can be found in the fb_mode.

Here's some pseudo code:

   drm_rect_init(dst_clip, 0, 0, sysfb->fb_mode.width, 
sysfb->fb_mode_height).

   lines = drm_rect_height(dst_clip);
   linepixels = drm_rect_width(dst_clip);
   linesize = drm_format_info_min_pitch(sysfb->fb_format, 0, linepixels);

   dst_size = min(linesize, dst_pitch);

   for (i < lines) {
     memset_io(dst_vmap, 0, dst_size);
     dst_vmap += dst_pitch
   }

This should safely clear the visible part of the buffer without touching 
any non-visible bytes at the end of each line. It also does not depend 
on user-controlled size input.

Do you want to provide an updated patch  or shall I send it?

Best regards
Thomas

>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> index d2de29caf89e..18466de886aa 100644
> --- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> +++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
> @@ -380,14 +380,10 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
>   	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
>   	unsigned int dst_pitch = sysfb->fb_pitch;
>   	const struct drm_format_info *dst_format = sysfb->fb_format;
> -	struct drm_rect dst_clip;
> +	struct drm_rect dst_clip = plane_state->dst;
>   	unsigned long lines, linepixels, i;
>   	int idx;
>   
> -	drm_rect_init(&dst_clip,
> -		      plane_state->src_x >> 16, plane_state->src_y >> 16,
> -		      plane_state->src_w >> 16, plane_state->src_h >> 16);
> -
>   	lines = drm_rect_height(&dst_clip);
>   	linepixels = drm_rect_width(&dst_clip);
>   
>
> Content-type: Text/plain
>
> No virus found
> 		Checked by Hillstone Network AntiVirus

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


