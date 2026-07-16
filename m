Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F245FC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B0010E2F7;
	Thu, 16 Jul 2026 07:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="A/O6gv2R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/g4jUZz1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lwB2BVxZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="avDpyJLb";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEB710E2F7
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:29:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15C603E3B;
 Thu, 16 Jul 2026 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784186987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g3LIyX3WKvKZKCDiNegcjdvV9KrE5GuZqI1LGl55y+k=;
 b=A/O6gv2RvyfqNmGxk0Oy8S/zaZ2s9aPqEUGDtAfVgBtQxMp43nD7bgoYvzJfuoq6yxW5Zj
 w3HLB/wCHiq7T7NJhCFqYp5XowEnxU/dWGpvqIEdiBOeVJk8THp7jJkzy4vZHVmN6jUobp
 Hm/ewXdNrJR1rXul/R7U1XO9TMH+STg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784186987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g3LIyX3WKvKZKCDiNegcjdvV9KrE5GuZqI1LGl55y+k=;
 b=/g4jUZz1Z9+NweA40yV+/qeyjxaf6sn/R06knr+Oke7O/UtDdVqP8Do2Y+slPio3DbhHNZ
 ZcNvyli9PHX3eWCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lwB2BVxZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=avDpyJLb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784186986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g3LIyX3WKvKZKCDiNegcjdvV9KrE5GuZqI1LGl55y+k=;
 b=lwB2BVxZRa0GrUlin+WmK61EopznlDzcm5bzidyRFH+3N902mujlYb0N5KLJRDVK2dMQ47
 2XFpLwCMUgAE/eoIYUqOE1NDCm4h+AdGlvHVL54NrpZOhz2Dtmjvg+UlwOFpQ52Pr4CwLM
 nIFGB0OCUynHt3uEzr3ZcHNb8hpYlgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784186986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g3LIyX3WKvKZKCDiNegcjdvV9KrE5GuZqI1LGl55y+k=;
 b=avDpyJLbi45/FV0c1zvSK6pnKbEza7yevXJJn7a64VxHTQQxqPKzOg/3ARhOAFUn5O8fsw
 nILGjPvmVD4ACPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D844A779AD;
 Thu, 16 Jul 2026 07:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kTCbM2mIWGpsHAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 16 Jul 2026 07:29:45 +0000
Message-ID: <1a10cacd-46da-44dd-822f-898966bd7c63@suse.de>
Date: Thu, 16 Jul 2026 09:29:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/vboxvideo: Use damage iterator and plane damage
 clips
To: hansg@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
References: <20260703151841.375364-1-tzimmermann@suse.de>
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
In-Reply-To: <20260703151841.375364-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 15C603E3B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:email, suse.de:mid,
 suse.com:url]
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

gentle reminder to review this patch

Am 03.07.26 um 17:18 schrieb Thomas Zimmermann:
> Use damage iterator to handle updates without damage clips correctly.
> If no damage clips have been given, drivers should update the entire
> display area.
>
> Also enable damage clips for the plane to minimize the area of each
> display update.
>
> v2:
> - fix plane-state order when calling _damage_iter_init() (Sashiko)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/vboxvideo/vbox_mode.c | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> index 8e4e5fc9d3c5..cd78071b6cbb 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> @@ -15,6 +15,7 @@
>   
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_damage_helper.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_fb_helper.h>
>   #include <drm/drm_fourcc.h>
> @@ -282,9 +283,10 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
>   									   plane);
>   	struct drm_crtc *crtc = new_state->crtc;
>   	struct drm_framebuffer *fb = new_state->fb;
> +	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   	struct vbox_private *vbox = to_vbox_dev(fb->dev);
> -	struct drm_mode_rect *clips;
> -	uint32_t num_clips, i;
> +	struct drm_rect damage;
> +	struct drm_atomic_helper_damage_iter iter;
>   
>   	vbox_crtc_set_base_and_mode(crtc, fb,
>   				    new_state->src_x >> 16,
> @@ -292,22 +294,17 @@ static void vbox_primary_atomic_update(struct drm_plane *plane,
>   
>   	/* Send information about dirty rectangles to VBVA. */
>   
> -	clips = drm_plane_get_damage_clips(new_state);
> -	num_clips = drm_plane_get_damage_clips_count(new_state);
> -
> -	if (!num_clips)
> -		return;
> -
>   	mutex_lock(&vbox->hw_mutex);
>   
> -	for (i = 0; i < num_clips; ++i, ++clips) {
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
>   		struct vbva_cmd_hdr cmd_hdr;
>   		unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
>   
> -		cmd_hdr.x = (s16)clips->x1;
> -		cmd_hdr.y = (s16)clips->y1;
> -		cmd_hdr.w = (u16)clips->x2 - clips->x1;
> -		cmd_hdr.h = (u16)clips->y2 - clips->y1;
> +		cmd_hdr.x = (s16)damage.x1;
> +		cmd_hdr.y = (s16)damage.y1;
> +		cmd_hdr.w = (u16)drm_rect_width(&damage);
> +		cmd_hdr.h = (u16)drm_rect_height(&damage);
>   
>   		if (!vbva_buffer_begin_update(&vbox->vbva_info[crtc_id],
>   					      vbox->guest_pool))
> @@ -539,6 +536,7 @@ static struct drm_plane *vbox_create_plane(struct vbox_private *vbox,
>   		goto free_plane;
>   
>   	drm_plane_helper_add(plane, helper_funcs);
> +	drm_plane_enable_fb_damage_clips(plane);
>   
>   	return plane;
>   
>
> base-commit: a2d82f27ac35c691c1c65b40c72b13d8b2a7f91f
> prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
> prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
> prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
> prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


