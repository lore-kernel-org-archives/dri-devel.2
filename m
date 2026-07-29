Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7C1C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEC010E963;
	Wed, 29 Jul 2026 11:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AZ6SQfaS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA5810E82A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 11:19:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28BAE60A99;
 Wed, 29 Jul 2026 11:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F701F000E9;
 Wed, 29 Jul 2026 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785323947;
 bh=nwPkYfXnuT7PkwPYsvO93vWfRFik3bXnbhYyulrFdww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AZ6SQfaSbuwwBlZ3MEh7CtOeD0zoOlU0X3QksZ+IURTURJxHfArZXUSPyPaJkitUY
 Ug8phUAjTqfEaKBZPC33St6s3LQvEMB+AdRcVX1BGQxMUmRdNFxxcJLB3AKvU9wSkE
 HyPP2tXxIqP9rRT+wIiIBQX8By2emPDbqbrRfw3KXoL00qYC1x6yARQF9iukpxAQZ2
 uNihatGLSAftkxw9p8Xk0IPWYXQoI/aIYfgD9jgM27+K/EAdezCQRM2WzGTqzpgKD2
 n/eLwH0oFgSCigFG4kDEeV5usHaNDfNhfambgNEVZQTV6WP/tSf9x6B+ctorG/BcRC
 VIFzOJZriKYXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/log: Fix division by zero when scale module
 parameter is 0
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729105840.865696-1-oushixiong1025@163.com>
References: <20260729105840.865696-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 11:19:07 +0000
Message-Id: <20260729111907.B1F701F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded module parameter scale causes integer overflow leading t=
o division by zero.
- [High] TOCTOU race in scale evaluation causes out-of-bounds memory read i=
n blitter.
- [High] Unbounded scale causes scanout->columns to evaluate to 0, creating=
 a fatal infinite loop.
- [High] Unbounded scale causes massive out-of-bounds memset when clearing =
console lines.
--

--- Patch [1]: [PATCH v2] drm/log: Fix division by zero when scale module p=
arameter is 0 ---
commit e2670bb0ffa13ef9c42c7647657baa7cbc2302c7
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/log: Fix division by zero when scale module parameter is 0

The scale module parameter can be set to 0 via kernel command line or
sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
causing a division by zero in the rows/columns calculation.

Introduce a drm_log_scale() helper that returns scale ?: 1, and use it
at all read sites. This avoids a race that a setter-based clamp would
have between param_set_uint() and the subsequent check, where another
CPU could observe scale =3D=3D 0.

> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/=
drm_log.c
> index e3e02c84a4cfe..fc30dfc048ae9 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c

[ ... ]

> @@ -76,13 +81,13 @@ static void drm_log_blit(struct iosys_map *dst, unsig=
ned int dst_pitch,
>  {
>  	switch (px_width) {
>  	case 2:
> -		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, scale, =
color);
> +		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, drm_log=
_scale(), color);

[Severity: High]
This isn't a bug introduced by this patch, but does evaluating the scale
parameter dynamically during rendering create a time-of-check to time-of-use
race?

If the scale parameter is modified concurrently between modeset and renderi=
ng:

drm_draw.c:drm_draw_blit16() {
    ...
	for (y =3D 0; y < height; y++)
		for (x =3D 0; x < width; x++)
			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
    ...
}

Can the loop execute based on old, larger height bounds while dividing y by=
 a
new, smaller scale, causing the font glyph array indices to drastically exc=
eed
the bounds of the unscaled font source buffer?

>  		break;

[ ... ]

> @@ -213,8 +218,8 @@ static int drm_log_setup_modeset(struct drm_client_de=
v *client,
>  		return -ENOMEM;
>  	}
>  	mode_set->fb =3D scanout->buffer->fb;
> -	scanout->scaled_font_h =3D scanout->font->height * scale;
> -	scanout->scaled_font_w =3D scanout->font->width * scale;
> +	scanout->scaled_font_h =3D scanout->font->height * drm_log_scale();
> +	scanout->scaled_font_w =3D scanout->font->width * drm_log_scale();

[Severity: High]
This is a pre-existing issue, but can this multiplication overflow 32-bit
arithmetic if the scale module parameter is set to a very large value?

Because scale is unbounded, a large value like 0x10000000 could cause the
result to wrap exactly to 0.

>  	scanout->rows =3D height / scanout->scaled_font_h;

[Severity: High]
This isn't a bug introduced by this patch, but if scanout->scaled_font_h
wraps to 0 due to an overflow, does this result in the same division by zero
panic that this patch is attempting to fix?

>  	scanout->columns =3D width / scanout->scaled_font_w;

[Severity: High]
This is a pre-existing issue, but if an excessively large scale is provided
such that scanout->scaled_font_w is greater than width, does scanout->colum=
ns
evaluate to 0?

If columns becomes 0, could this trap the logging thread in an infinite loop
when drawing records?

drm_log.c:drm_log_draw_kmsg_record() {
    ...
    while (len > scanout->columns) {
        ...
        len -=3D scanout->columns;
    }
    ...
}

If scanout->columns is 0, len will never decrease and the loop will never
terminate.

Additionally, this isn't a bug introduced by this patch, but can an unbound=
ed
scale cause an out-of-bounds memset when clearing console lines?

drm_log.c:drm_log_draw_new_line() {
    ...
    drm_log_clear_line(scanout, 2);
    ...
}

drm_log.c:drm_log_clear_line() {
    ...
    iosys_map_memset(&map, r.y1 * fb->pitches[0], 0, height * fb->pitches[0=
]);
    ...
}

If the excessively large scale makes scaled_font_h extremely large, could t=
he
attempt to unconditionally clear the first three lines overwrite memory
completely outside the bounds of the framebuffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729105840.8656=
96-1-oushixiong1025@163.com?part=3D1
