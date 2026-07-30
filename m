Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F460C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 11:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB0D10EEEF;
	Thu, 30 Jul 2026 11:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cjLcFQh4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A29E10EEF1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 11:10:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD1C541899;
 Thu, 30 Jul 2026 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758D01F000E9;
 Thu, 30 Jul 2026 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785409823;
 bh=Gll6HzINwAlOOX4o7Y/84ZCGPHbp7y8NVBbP6MOI9tM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cjLcFQh4jOmRVvlH2kMZSamc+JF399zHMK7rJiZi+pW57rWkH8m8MJE5q+GAEbkQK
 SiwP5JPMIXRfVVm7oUjWH9FNxuT2Y2La3XaZUIjBRmxaiONXgG0z+fJmzSA+uFAN9j
 ZDj0dQy9/FzXlOXcqN1pSK2XGHL/rqchGxVRUQ2XRZpGGANXJHoaNEQ/3zKDBkUomy
 OCtfQmyaSN4p902h/a4LAU9F5KIV3dGp8h7SevrjVaHLziFQ3bftYOagqRnf4dJ8er
 gk8px9+OzJRH8Cuc/ExMq7CrNrtboWWfy5SeN7mX/cCXDWrZQTEzxzJ1OiQqdqX/M+
 tsP64RXti5EYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/log: Batch vmap/vunmap and flush for record drawing
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260730105950.670892-1-oushixiong1025@163.com>
References: <20260730105950.670892-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 11:10:22 +0000
Message-Id: <20260730111023.758D01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional clearing of lines 0, 1, and 2 can write past the end=
 of the framebuffer if `scanout->rows` is less than 3.
--

--- Patch [1]: [PATCH v2] drm/log: Batch vmap/vunmap and flush for record d=
rawing ---
commit 59469456017da9a89a891c48422d122f14da3c7a
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/log: Batch vmap/vunmap and flush for record drawing

This commit refactors drm_log_clear_line and drm_log_draw_line to accept a
pre-mapped iosys_map by value, removing the per-line vmap/vunmap/flush
calls. The single vmap/vunmap pair and flush are moved to
drm_log_draw_new_line.

> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/=
drm_log.c
> index e3e02c84a4cfe..97eddae3973f3 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c

[ ... ]

> @@ -134,21 +125,40 @@ static void drm_log_draw_line(struct drm_log_scanou=
t *scanout, const char *s,
>  	scanout->line++;
>  	if (scanout->line >=3D scanout->rows)
>  		scanout->line =3D 0;
> -	drm_client_buffer_vunmap_local(scanout->buffer);
> -	drm_client_buffer_flush(scanout->buffer, &r);
>  }
> =20
>  static void drm_log_draw_new_line(struct drm_log_scanout *scanout,
> -				  const char *s, unsigned int len, unsigned int prefix_len)
> +				  const char *s, unsigned int len,
> +				  unsigned int prefix_len)
>  {
> +	struct iosys_map map;
> +	struct drm_framebuffer *fb =3D scanout->buffer->fb;
> +	u32 height =3D scanout->scaled_font_h;
> +	u32 line =3D scanout->line;
> +	u32 y2;
> +	struct drm_rect dirty;
> +
> +	if (drm_client_buffer_vmap_local(scanout->buffer, &map))
> +		return;
> +
>  	if (scanout->line =3D=3D 0) {
> -		drm_log_clear_line(scanout, 0);
> -		drm_log_clear_line(scanout, 1);
> -		drm_log_clear_line(scanout, 2);
> +		drm_log_clear_line(scanout, 0, map);
> +		drm_log_clear_line(scanout, 1, map);
> +		drm_log_clear_line(scanout, 2, map);

[Severity: High]
This is a pre-existing issue, but can unconditionally clearing lines 0, 1,
and 2 write past the end of the framebuffer if scanout->rows is less than 3?

If the display has a very small vertical resolution, or if the scale module
parameter is set to a large value, scanout->rows can be less than 3.

When scanout->line =3D=3D 0, drm_log_draw_new_line unconditionally clears l=
ine 2.
This calls drm_log_clear_line, which does:

static void drm_log_clear_line(struct drm_log_scanout *scanout, u32 line,
                               struct iosys_map map)
{
        ...
        iosys_map_memset(&map, line * height * fb->pitches[0], 0, height * =
fb->pitches[0]);
}

If line * height exceeds the actual framebuffer height, does this result in
an out-of-bounds memory write that could corrupt adjacent kernel memory?

> +		y2 =3D min(3, scanout->rows) * height;
> +	} else if (scanout->line + 2 < scanout->rows) {
> -		drm_log_clear_line(scanout, scanout->line + 2);
> +		drm_log_clear_line(scanout, scanout->line + 2, map);
> +		y2 =3D (line + 3) * height;
> +	} else {
> +		y2 =3D (line + 1) * height;
> +	}
> +
> -	drm_log_draw_line(scanout, s, len, prefix_len);
> +	drm_log_draw_line(scanout, s, len, prefix_len, map);
> +
> +	drm_client_buffer_vunmap_local(scanout->buffer);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730105950.6708=
92-1-oushixiong1025@163.com?part=3D1
