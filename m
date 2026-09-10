Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2E1C79FB7
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 06:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C5510E5A6;
	Thu, 10 Sep 2026 06:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="AZS+uXWP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GEX0t6/D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yIoM7URG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SCKQWkrS";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D5610E5A6
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 06:33:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F5BD21C96;
 Thu, 10 Sep 2026 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789021989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A4iloW0fdM3s8+GEp1xwySC95eY5us7RWUccPBfYWDU=;
 b=AZS+uXWPT+5pPTaHVx0H+swkexh1iFCeIDJ8YFg2alk2yXwNlWpRT4JO9TkMy9J5drWaE4
 26CjZNGojqUlDWo9WHyROJfwYPhkQHzOxFs6gohlOLic/kwCqbJP04qxTTM96sZL3Y6sv5
 IQBZcnfwefHxFNPk4tHb7PkOXKGAGyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789021989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A4iloW0fdM3s8+GEp1xwySC95eY5us7RWUccPBfYWDU=;
 b=GEX0t6/DZWYWM2EOy07PiGfsJmoyzxq53dAx/L1Oa/Epl+6N3eL51j223ILdjoksvWEvNy
 zCyXybWUegnMQwCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yIoM7URG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SCKQWkrS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789021985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A4iloW0fdM3s8+GEp1xwySC95eY5us7RWUccPBfYWDU=;
 b=yIoM7URGrED0awynraOouMvtStKrq319Ge7WdQGJGTL/nshHdDrFRJumUcURLxzjuVVL2K
 A55f1xTXX8nG3ZokIMSu5NWFljW6lObVdVcLJaqjG67xBFtGDFZQPzZKjxdHWXWm50nyIW
 KWtjU1PBPqjEm45qBcdTFxesZPQZeMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789021985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A4iloW0fdM3s8+GEp1xwySC95eY5us7RWUccPBfYWDU=;
 b=SCKQWkrS7JT3dNyUTSnjeRvQvXU8gIP+2jTssMbCCnfRtsNQw6skw7qR8U6STMT8IOgwg0
 ipw6DwQoZeFz6ODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 144CE13433;
 Thu, 10 Sep 2026 06:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7nDNMiBPomq8bAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 10 Sep 2026 06:33:04 +0000
Message-ID: <8376b69e-b69a-45e0-a73b-ec75106f1a45@suse.de>
Date: Thu, 10 Sep 2026 08:33:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/41] drm/vkms: Move frame_info into vkms_plane_state
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com,
 louis.chauvet@bootlin.com, melissa.srw@gmail.com
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
 <20260908-drm-no-more-plane-reset-v4-2-a31b3fcfc989@kernel.org>
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
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-2-a31b3fcfc989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F5BD21C96
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com,ffwll.ch];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.freedesktop.org,gmail.com,bootlin.com];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, suse.de:mid,
 suse.com:url, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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



Am 08.09.26 um 16:46 schrieb Maxime Ripard:
> The vkms_frame_info structure is allocated separately in
> vkms_plane_duplicate_state() and freed in vkms_plane_destroy_state(),
> but has the exact same lifetime as the vkms_plane_state that contains
> it.
>
> This separate allocation is fragile: frame_info is only allocated in
> duplicate_state, so any other path that creates a vkms_plane_state
> produces a state with a NULL frame_info pointer. Both
> vkms_plane_atomic_update() and vkms_plane_destroy_state() dereference
> it unconditionally when a CRTC is set.
>
> Embed frame_info directly in vkms_plane_state. The structure is
> zero-initialized as part of the kzalloc, removing the need for a
> separate allocation and its error handling in duplicate_state, and the
> matching kfree in destroy_state.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

You can also take this r-b for the free-standing patch if you like.

>
> ---
>
> Cc: hamohammed.sa@gmail.com
> Cc: louis.chauvet@bootlin.com
> Cc: melissa.srw@gmail.com
> ---
>   drivers/gpu/drm/vkms/vkms_composer.c | 30 +++++++++++-----------
>   drivers/gpu/drm/vkms/vkms_drv.h      |  2 +-
>   drivers/gpu/drm/vkms/vkms_formats.c  | 48 ++++++++++++++++++------------------
>   drivers/gpu/drm/vkms/vkms_plane.c    | 21 +++-------------
>   4 files changed, 44 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 899120cd07ac..0fc915a954ba 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -309,11 +309,11 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
>   				   int *src_y_start, int *dst_x_start, int *pixel_count)
>   {
>   	/* By default the start points are correct */
>   	*src_x_start = src_line->x1;
>   	*src_y_start = src_line->y1;
> -	*dst_x_start = current_plane->frame_info->dst.x1;
> +	*dst_x_start = current_plane->frame_info.dst.x1;
>   
>   	/* Get the correct number of pixel to blend, it depends of the direction */
>   	switch (direction) {
>   	case READ_LEFT_TO_RIGHT:
>   	case READ_RIGHT_TO_LEFT:
> @@ -337,23 +337,23 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
>   		if (*src_x_start < 0) {
>   			*pixel_count += *src_x_start;
>   			*dst_x_start -= *src_x_start;
>   			*src_x_start = 0;
>   		}
> -		if (*src_x_start + *pixel_count > current_plane->frame_info->fb->width)
> -			*pixel_count = max(0, (int)current_plane->frame_info->fb->width -
> +		if (*src_x_start + *pixel_count > current_plane->frame_info.fb->width)
> +			*pixel_count = max(0, (int)current_plane->frame_info.fb->width -
>   				*src_x_start);
>   		break;
>   	case READ_BOTTOM_TO_TOP:
>   	case READ_TOP_TO_BOTTOM:
>   		if (*src_y_start < 0) {
>   			*pixel_count += *src_y_start;
>   			*dst_x_start -= *src_y_start;
>   			*src_y_start = 0;
>   		}
> -		if (*src_y_start + *pixel_count > current_plane->frame_info->fb->height)
> -			*pixel_count = max(0, (int)current_plane->frame_info->fb->height -
> +		if (*src_y_start + *pixel_count > current_plane->frame_info.fb->height)
> +			*pixel_count = max(0, (int)current_plane->frame_info.fb->height -
>   				*src_y_start);
>   		break;
>   	}
>   }
>   
> @@ -372,24 +372,24 @@ static void blend_line(struct vkms_plane_state *current_plane, int y,
>   {
>   	int src_x_start, src_y_start, dst_x_start, pixel_count;
>   	struct drm_rect dst_line, tmp_src, src_line;
>   
>   	/* Avoid rendering useless lines */
> -	if (y < current_plane->frame_info->dst.y1 ||
> -	    y >= current_plane->frame_info->dst.y2)
> +	if (y < current_plane->frame_info.dst.y1 ||
> +	    y >= current_plane->frame_info.dst.y2)
>   		return;
>   
>   	/*
>   	 * dst_line is the line to copy. The initial coordinates are inside the
>   	 * destination framebuffer, and then drm_rect_* helpers are used to
>   	 * compute the correct position into the source framebuffer.
>   	 */
> -	dst_line = DRM_RECT_INIT(current_plane->frame_info->dst.x1, y,
> -				 drm_rect_width(&current_plane->frame_info->dst),
> +	dst_line = DRM_RECT_INIT(current_plane->frame_info.dst.x1, y,
> +				 drm_rect_width(&current_plane->frame_info.dst),
>   				 1);
>   
> -	drm_rect_fp_to_int(&tmp_src, &current_plane->frame_info->src);
> +	drm_rect_fp_to_int(&tmp_src, &current_plane->frame_info.src);
>   
>   	/*
>   	 * [1]: Clamping src_line to the crtc_x_limit to avoid writing outside of
>   	 * the destination buffer
>   	 */
> @@ -409,21 +409,21 @@ static void blend_line(struct vkms_plane_state *current_plane, int y,
>   	 * - Invert the rotation. This assumes that
>   	 *   dst = drm_rect_rotate(src, rotation) (dst and src have the
>   	 *   same size, but can be rotated).
>   	 * - Apply the offset of the source rectangle to the coordinate.
>   	 */
> -	drm_rect_translate(&src_line, -current_plane->frame_info->dst.x1,
> -			   -current_plane->frame_info->dst.y1);
> +	drm_rect_translate(&src_line, -current_plane->frame_info.dst.x1,
> +			   -current_plane->frame_info.dst.y1);
>   	drm_rect_rotate_inv(&src_line, drm_rect_width(&tmp_src),
>   			    drm_rect_height(&tmp_src),
> -			    current_plane->frame_info->rotation);
> +			    current_plane->frame_info.rotation);
>   	drm_rect_translate(&src_line, tmp_src.x1, tmp_src.y1);
>   
>   	/* Get the correct reading direction in the source buffer. */
>   
>   	enum pixel_read_direction direction =
> -		direction_for_rotation(current_plane->frame_info->rotation);
> +		direction_for_rotation(current_plane->frame_info.rotation);
>   
>   	/* [2]: Compute and clamp the number of pixel to read */
>   	clamp_line_coordinates(direction, current_plane, &src_line, &src_x_start, &src_y_start,
>   			       &dst_x_start, &pixel_count);
>   
> @@ -537,11 +537,11 @@ static int check_iosys_map(struct vkms_crtc_state *crtc_state)
>   {
>   	struct vkms_plane_state **plane_state = crtc_state->active_planes;
>   	u32 n_active_planes = crtc_state->num_active_planes;
>   
>   	for (size_t i = 0; i < n_active_planes; i++)
> -		if (iosys_map_is_null(&plane_state[i]->frame_info->map[0]))
> +		if (iosys_map_is_null(&plane_state[i]->frame_info.map[0]))
>   			return -1;
>   
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 0933e4ce0ff0..381483aa4fb0 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -147,11 +147,11 @@ struct conversion_matrix {
>    *		     struct vkms_plane_state must ensure that this pointer is valid
>    * @conversion_matrix: matrix used for yuv formats to convert to rgb
>    */
>   struct vkms_plane_state {
>   	struct drm_shadow_plane_state base;
> -	struct vkms_frame_info *frame_info;
> +	struct vkms_frame_info frame_info;
>   	pixel_read_line_t pixel_read_line;
>   	struct conversion_matrix conversion_matrix;
>   };
>   
>   struct vkms_plane {
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 964b574d9ed7..7f1f29b589e8 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -319,14 +319,14 @@ EXPORT_SYMBOL_IF_KUNIT(argb_u16_from_yuv161616);
>   static void function_name(const struct vkms_plane_state *plane, int x_start,			\
>   			      int y_start, enum pixel_read_direction direction, int count,	\
>   			      struct pixel_argb_u16 out_pixel[])				\
>   {												\
>   	struct pixel_argb_u16 *end = out_pixel + count;						\
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
> +	int step = get_block_step_bytes(plane->frame_info.fb, direction, 0);			\
>   	u8 *src_pixels;										\
>   												\
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0, &src_pixels);		\
> +	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0, &src_pixels);		\
>   												\
>   	while (out_pixel < end) {								\
>   		pixel_type *(pixel_name) = (pixel_type *)src_pixels;				\
>   		*out_pixel = (callback)(__VA_ARGS__);						\
>   		out_pixel += 1;									\
> @@ -377,20 +377,20 @@ static void function_name(const struct vkms_plane_state *plane, int x_start,			\
>   static void Rx_read_line(const struct vkms_plane_state *plane, int x_start,
>   			 int y_start, enum pixel_read_direction direction, int count,
>   			 struct pixel_argb_u16 out_pixel[])
>   {
>   	struct pixel_argb_u16 *end = out_pixel + count;
> -	int bits_per_pixel = drm_format_info_bpp(plane->frame_info->fb->format, 0);
> +	int bits_per_pixel = drm_format_info_bpp(plane->frame_info.fb->format, 0);
>   	u8 *src_pixels;
>   	int rem_x, rem_y;
>   
> -	WARN_ONCE(drm_format_info_block_height(plane->frame_info->fb->format, 0) != 1,
> +	WARN_ONCE(drm_format_info_block_height(plane->frame_info.fb->format, 0) != 1,
>   		  "%s() only support formats with block_h == 1", __func__);
>   
> -	packed_pixels_addr(plane->frame_info, x_start, y_start, 0, &src_pixels, &rem_x, &rem_y);
> +	packed_pixels_addr(&plane->frame_info, x_start, y_start, 0, &src_pixels, &rem_x, &rem_y);
>   	int bit_offset = (8 - bits_per_pixel) - rem_x * bits_per_pixel;
> -	int step = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> +	int step = get_block_step_bytes(plane->frame_info.fb, direction, 0);
>   	int mask = (0x1 << bits_per_pixel) - 1;
>   	int lum_per_level = 0xFFFF / mask;
>   
>   	if (direction == READ_LEFT_TO_RIGHT || direction == READ_RIGHT_TO_LEFT) {
>   		int restart_bit_offset;
> @@ -501,19 +501,19 @@ static void function_name(const struct vkms_plane_state *plane, int x_start,			\
>   		 struct pixel_argb_u16 out_pixel[])						\
>   {												\
>   	u8 *plane_1;										\
>   	u8 *plane_2;										\
>   												\
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0,				\
> +	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0,				\
>   			       &plane_1);							\
> -	packed_pixels_addr_1x1(plane->frame_info,						\
> -			       x_start / plane->frame_info->fb->format->hsub,			\
> -			       y_start / plane->frame_info->fb->format->vsub, 1,		\
> +	packed_pixels_addr_1x1(&plane->frame_info,						\
> +			       x_start / plane->frame_info.fb->format->hsub,			\
> +			       y_start / plane->frame_info.fb->format->vsub, 1,			\
>   			       &plane_2);							\
> -	int step_1 = get_block_step_bytes(plane->frame_info->fb, direction, 0);			\
> -	int step_2 = get_block_step_bytes(plane->frame_info->fb, direction, 1);			\
> -	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);		\
> +	int step_1 = get_block_step_bytes(plane->frame_info.fb, direction, 0);			\
> +	int step_2 = get_block_step_bytes(plane->frame_info.fb, direction, 1);			\
> +	int subsampling = get_subsampling(plane->frame_info.fb->format, direction);		\
>   	int subsampling_offset = get_subsampling_offset(direction, x_start, y_start);		\
>   	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;		\
>   												\
>   	for (int i = 0; i < count; i++) {							\
>   		pixel_1_type *(pixel_1_name) = (pixel_1_type *)plane_1;				\
> @@ -546,24 +546,24 @@ static void planar_yuv_read_line(const struct vkms_plane_state *plane, int x_sta
>   {
>   	u8 *y_plane;
>   	u8 *channel_1_plane;
>   	u8 *channel_2_plane;
>   
> -	packed_pixels_addr_1x1(plane->frame_info, x_start, y_start, 0,
> +	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0,
>   			       &y_plane);
> -	packed_pixels_addr_1x1(plane->frame_info,
> -			       x_start / plane->frame_info->fb->format->hsub,
> -			       y_start / plane->frame_info->fb->format->vsub, 1,
> +	packed_pixels_addr_1x1(&plane->frame_info,
> +			       x_start / plane->frame_info.fb->format->hsub,
> +			       y_start / plane->frame_info.fb->format->vsub, 1,
>   			       &channel_1_plane);
> -	packed_pixels_addr_1x1(plane->frame_info,
> -			       x_start / plane->frame_info->fb->format->hsub,
> -			       y_start / plane->frame_info->fb->format->vsub, 2,
> +	packed_pixels_addr_1x1(&plane->frame_info,
> +			       x_start / plane->frame_info.fb->format->hsub,
> +			       y_start / plane->frame_info.fb->format->vsub, 2,
>   			       &channel_2_plane);
> -	int step_y = get_block_step_bytes(plane->frame_info->fb, direction, 0);
> -	int step_channel_1 = get_block_step_bytes(plane->frame_info->fb, direction, 1);
> -	int step_channel_2 = get_block_step_bytes(plane->frame_info->fb, direction, 2);
> -	int subsampling = get_subsampling(plane->frame_info->fb->format, direction);
> +	int step_y = get_block_step_bytes(plane->frame_info.fb, direction, 0);
> +	int step_channel_1 = get_block_step_bytes(plane->frame_info.fb, direction, 1);
> +	int step_channel_2 = get_block_step_bytes(plane->frame_info.fb, direction, 2);
> +	int subsampling = get_subsampling(plane->frame_info.fb->format, direction);
>   	int subsampling_offset = get_subsampling_offset(direction, x_start, y_start);
>   	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
>   
>   	for (int i = 0; i < count; i++) {
>   		*out_pixel = argb_u16_from_yuv161616(conversion_matrix,
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 6ee5c3f3207c..2fd4edf2d190 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -53,25 +53,15 @@ static const u32 vkms_formats[] = {
>   
>   static struct drm_plane_state *
>   vkms_plane_duplicate_state(struct drm_plane *plane)
>   {
>   	struct vkms_plane_state *vkms_state;
> -	struct vkms_frame_info *frame_info;
>   
>   	vkms_state = kzalloc_obj(*vkms_state);
>   	if (!vkms_state)
>   		return NULL;
>   
> -	frame_info = kzalloc_obj(*frame_info);
> -	if (!frame_info) {
> -		DRM_DEBUG_KMS("Couldn't allocate frame_info\n");
> -		kfree(vkms_state);
> -		return NULL;
> -	}
> -
> -	vkms_state->frame_info = frame_info;
> -
>   	__drm_gem_duplicate_shadow_plane_state(plane, &vkms_state->base);
>   
>   	return &vkms_state->base.base;
>   }
>   
> @@ -79,21 +69,18 @@ static void vkms_plane_destroy_state(struct drm_plane *plane,
>   				     struct drm_plane_state *old_state)
>   {
>   	struct vkms_plane_state *vkms_state = to_vkms_plane_state(old_state);
>   	struct drm_crtc *crtc = vkms_state->base.base.crtc;
>   
> -	if (crtc && vkms_state->frame_info->fb) {
> +	if (crtc && vkms_state->frame_info.fb) {
>   		/* dropping the reference we acquired in
>   		 * vkms_primary_plane_update()
>   		 */
> -		if (drm_framebuffer_read_refcount(vkms_state->frame_info->fb))
> -			drm_framebuffer_put(vkms_state->frame_info->fb);
> +		if (drm_framebuffer_read_refcount(vkms_state->frame_info.fb))
> +			drm_framebuffer_put(vkms_state->frame_info.fb);
>   	}
>   
> -	kfree(vkms_state->frame_info);
> -	vkms_state->frame_info = NULL;
> -
>   	__drm_gem_destroy_shadow_plane_state(&vkms_state->base);
>   	kfree(vkms_state);
>   }
>   
>   static void vkms_plane_reset(struct drm_plane *plane)
> @@ -141,11 +128,11 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>   
>   	fmt = fb->format->format;
>   	vkms_plane_state = to_vkms_plane_state(new_state);
>   	shadow_plane_state = &vkms_plane_state->base;
>   
> -	frame_info = vkms_plane_state->frame_info;
> +	frame_info = &vkms_plane_state->frame_info;
>   	memcpy(&frame_info->src, &new_state->src, sizeof(struct drm_rect));
>   	memcpy(&frame_info->dst, &new_state->dst, sizeof(struct drm_rect));
>   	frame_info->fb = fb;
>   	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
>   	drm_framebuffer_get(frame_info->fb);
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


