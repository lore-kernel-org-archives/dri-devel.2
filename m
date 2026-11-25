Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB92C606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=h7bx1yzU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOlatSMD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=stlQgf10;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=1qC0Ho7Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2635B10E263;
	Wed, 25 Nov 2026 11:53:33 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CC4F10FBF3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:53:21 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE40D1F7D1;
 Wed, 25 Nov 2026 11:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795607600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MQrvYE7i1TmUMmwwCNKIQpEz/obCTLFv9OjM/sbrX2E=;
 b=h7bx1yzUcenr0efjUFporQFhMWnzKgsQ4E0Neeln6JSppgEHbW1Xsw9V9cZxVdTw9s8sM7
 MuI0KJ2Jvt2OrdxmJ4FFV1VGuSNaTqNkWTe3r/4aeN5O/DQyKQj1PzmGpJZt7hsqh9Rnhv
 PTMdQ5wxtymLvOhaNAJKTCGvme9iSuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795607600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MQrvYE7i1TmUMmwwCNKIQpEz/obCTLFv9OjM/sbrX2E=;
 b=YOlatSMDXHC7Xpy5FycHR7s9IA1Tbo8SCkZMAFL6vZXiR8/pbPLuk06csIQKUFHIN9iYYf
 2qqPL5D+KsRWAjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795607599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MQrvYE7i1TmUMmwwCNKIQpEz/obCTLFv9OjM/sbrX2E=;
 b=stlQgf10C5oiH/PocxCwOOUrh6LrIDUwdq2f/Phm7IHjx6xPwtZvGu/mv6/OMfYLXu4uri
 RCJyq5BX5PKa44ht5OIwmyDUtTzgl9CkK3usaxIELW9C0SnLuJORjLJb6flAdgVzic1wBt
 9C5QCGrDROy12YbwPj6/wgShBCXE3V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795607599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MQrvYE7i1TmUMmwwCNKIQpEz/obCTLFv9OjM/sbrX2E=;
 b=1qC0Ho7Zobl3/dIMnfly4AbsujOJp2wWkNwv9rX8iN9GkQbNzbLf9/GMPI/NlUxM32C1L7
 7Z0n5tnAaPn5e9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 923CA1339F;
 Wed, 25 Nov 2026 11:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7IfrGy/MBmuWQAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 25 Nov 2026 11:53:19 +0000
Message-ID: <4df7445b-f4c8-4615-8f1d-3fcc59f8cba0@suse.de>
Date: Wed, 25 Nov 2026 12:53:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Optimize cursor updates and reduce overhead
To: Herman Semenoff <germanaizek0@gmail.com>, Dave Airlie
 <airlied@redhat.com>, Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <CAMnMt5aufzBXQvs2OeFpBqdh1_VgNUxstvkVX61dPPcfo94QOg@mail.gmail.com>
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
In-Reply-To: <CAMnMt5aufzBXQvs2OeFpBqdh1_VgNUxstvkVX61dPPcfo94QOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCPT_COUNT_SEVEN(0.00)[9];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com,linux.intel.com,kernel.org,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,aizekgroup.ru:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url]
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



Am 25.11.26 um 12:24 schrieb Herman Semenoff:
>  From f9574b5a246bf9021ea75f530a9a8ab7c9995274 Mon Sep 17 00:00:00 2001
> From: Herman Semenoff <GermanAizek@yandex.ru>
> Date: Tue, 24 Nov 2026 12:53:31 +0300
> Subject: [PATCH] drm/ast: Optimize cursor updates and reduce overhead
>
> On server platforms equipped with ASPEED BMC GPUs (such as AST2400 on
> Lenovo RD450X), VRAM is mapped over a slow PCIe link with limited
> bandwidth.
>
> Currently, on every cursor move (e.g. via drmModeMoveCursor or atomic
> commit updating plane coordinates without damage clips),
> ast_cursor_plane_helper_atomic_update() invokes
> drm_atomic_helper_damage_merged(). Because userspace does not provide
> damage clips for pure cursor movements,
> drm_atomic_helper_damage_iter_init() treats the absence of clips as a
> full plane update. Consequently, on every mouse move event:
>   1. ast_cursor_plane_get_argb4444() performs format conversion on CPU
>   2. ast_set_cursor_image() recalculates 32-bit checksum on CPU
>   3. memcpy_toio() pushes 8192 bytes over the slow PCIe link into VRAM
>   4. Cursor base registers are reprogrammed
>
> Fix this by only updating the cursor image and base when the image
> actually changes (fb != old_fb, plane was previously invisible, or
> damage clips were provided). For pure position updates, only update
> the coordinates in the hardware cursor signature and registers,
> skipping VRAM transfer, format conversion, and checksum calculation.
>
> Additionally:
> - Add DRM_FORMAT_XRGB8888 support to ast_cursor_plane_formats and handle
>    it with opaque alpha in ast_cursor_plane_get_argb4444(), preventing
>    compositors from unnecessarily falling back to software cursors on the
>    primary plane
> - Implement .panic_flush in ast_primary_plane_helper_funcs to disable the
>    hardware cursor during kernel panics (CONFIG_DRM_PANIC)

I this is mostly wrong and the patch is terrible. I refuse to further 
deal with any of this.

>
> Signed-off-by: Herman Semenoff <GermanAizek@yandex.ru>
> Signed-off-by: Herman Semenoff <GermanAizek@aizekgroup.ru>
> ---
>   drivers/gpu/drm/ast/ast_cursor.c | 39 +++++++++++++++++++++++++++++---
>   drivers/gpu/drm/ast/ast_drv.h    |  1 +
>   drivers/gpu/drm/ast/ast_mode.c   |  8 +++++++
>   3 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
> index 690d4cd1db5e..883d1e6f20bd 100644
> --- a/drivers/gpu/drm/ast/ast_cursor.c
> +++ b/drivers/gpu/drm/ast/ast_cursor.c
> @@ -142,7 +142,7 @@ static void ast_set_cursor_location(struct
> ast_device *ast, u16 x, u16 y,
>    ast_set_index_reg(ast, AST_IO_VGACRI, 0xc7, y1);
>   }
>
> -static void ast_set_cursor_enabled(struct ast_device *ast, bool enabled)
> +void ast_set_cursor_enabled(struct ast_device *ast, bool enabled)
>   {
>    static const u8 mask = (u8)~(AST_IO_VGACRCB_HWC_16BPP |
>        AST_IO_VGACRCB_HWC_ENABLED);
> @@ -162,6 +162,7 @@ static void ast_set_cursor_enabled(struct
> ast_device *ast, bool enabled)
>   static const uint32_t ast_cursor_plane_formats[] = {
>    DRM_FORMAT_ARGB4444,
>    DRM_FORMAT_ARGB8888,
> + DRM_FORMAT_XRGB8888,
>   };
>
>   static int ast_cursor_plane_helper_atomic_check(struct drm_plane *plane,
> @@ -229,6 +230,30 @@ static const u8
> *ast_cursor_plane_get_argb4444(struct ast_cursor_plane *ast_curs
>    argb4444 = argb4444_dst[0].vaddr;
>    }
>    break;
> + case DRM_FORMAT_XRGB8888:
> + {
> + struct iosys_map argb4444_dst[DRM_FORMAT_MAX_PLANES] = {
> + IOSYS_MAP_INIT_VADDR(ast_cursor_plane->argb4444),
> + };
> + unsigned int argb4444_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> + AST_HWC_PITCH,
> + };
> + unsigned int x, y;
> + u16 *dst16;
> +
> + drm_fb_argb8888_to_argb4444(argb4444_dst, argb4444_dst_pitch,
> +    shadow_plane_state->data, fb, clip,
> +    &shadow_plane_state->fmtcnv_state);
> +
> + for (y = clip->y1; y < clip->y2; y++) {
> + dst16 = (u16 *)(ast_cursor_plane->argb4444 +
> + y * AST_HWC_PITCH);
> + for (x = clip->x1; x < clip->x2; x++)
> + dst16[x] |= 0xf000;
> + }
> + argb4444 = argb4444_dst[0].vaddr;
> + }
> + break;
>    }
>
>    drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> @@ -261,13 +286,21 @@ static void
> ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
>    unsigned int offset_x, offset_y;
>    u16 x, y;
>    u8 x_offset, y_offset;
> + bool update_image;
>
>    /*
>    * Do data transfer to hardware buffer and point the scanout
> - * engine to the offset.
> + * engine to the offset only if the cursor image actually changed
> + * or the plane became visible. For pure cursor moves, avoid
> + * expensive PCIe bus transfers, format conversion, and checksum
> + * calculation.
>    */
> + update_image = (fb != old_plane_state->fb) ||
> +       !old_plane_state->visible ||
> +       drm_plane_get_damage_clips_count(plane_state);
>
> - if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage)) {
> + if (update_image &&
> +    drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage)) {
>    const u8 *argb4444 = ast_cursor_plane_get_argb4444(ast_cursor_plane,
>      shadow_plane_state,
>      &damage);
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index 4f221b848d68..d846d5cf4f5e 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -542,6 +542,7 @@ int ast_sil164_output_init(struct ast_device *ast);
>   /* ast_cursor.c */
>   long ast_cursor_vram_offset(struct ast_device *ast);
>   int ast_cursor_plane_init(struct ast_device *ast);
> +void ast_set_cursor_enabled(struct ast_device *ast, bool enabled);
>
>   /* ast dp501 */
>   bool ast_backup_fw(struct ast_device *ast, u8 *addr, u32 size);
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 08db132acae8..f94f849d157b 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -639,6 +639,13 @@ static int
> ast_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
>    return -ENODEV;
>   }
>
> +static void ast_primary_plane_helper_panic_flush(struct drm_plane *plane)
> +{
> + struct ast_device *ast = to_ast_device(plane->dev);
> +
> + ast_set_cursor_enabled(ast, false);
> +}
> +
>   static const struct drm_plane_helper_funcs ast_primary_plane_helper_funcs = {
>    DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>    .atomic_check = ast_primary_plane_helper_atomic_check,
> @@ -646,6 +653,7 @@ static const struct drm_plane_helper_funcs
> ast_primary_plane_helper_funcs = {
>    .atomic_enable = ast_primary_plane_helper_atomic_enable,
>    .atomic_disable = ast_primary_plane_helper_atomic_disable,
>    .get_scanout_buffer = ast_primary_plane_helper_get_scanout_buffer,
> + .panic_flush = ast_primary_plane_helper_panic_flush,
>   };
>
>   static const struct drm_plane_funcs ast_primary_plane_funcs = {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


