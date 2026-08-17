Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C678C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE6D10E886;
	Mon, 17 Aug 2026 15:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eX7QuQ24";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C59D10E886
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:41:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4971D601DE;
 Mon, 17 Aug 2026 15:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13271F000E9;
 Mon, 17 Aug 2026 15:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786981287;
 bh=Iyl531ck+0fRSAQwc4mjGKJKCnx6mUdXw4C5HkmXiZ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eX7QuQ24OgjyFbfmL66nNKZ+2eBmh5uIMnPrSvoeIyflncMGtbgbugkz2t685IX9M
 d89bsSkwNrDsGUPFl520sGpz2BEBJGDlB2YEzSsOBbpZ0izsJlSWPGCy1ysQATIbJI
 ZMEN6yxuyIH8Z2hdL2tZ+TAS9ulePPWkdu5uBXPkFMClmaKNmluBHX4qg0Lg9jf/rJ
 LIQcC1lwdyyq+LUIXd9kG8cR+QbMo/aCV8SztUSsTpWvIlnjDF49UcNl0r+Z4vOpi/
 RJmvX4NmNIBBL0aswprQ8wG3H3R+cNP1IJrbnmNUWchwU66f6U7HHSlqez5WOf0J8D
 b7b8McFbxeVXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
To: "Fabio Piparo" <holofermes@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817152500.703770-1-holofermes@gmail.com>
References: <20260817152500.703770-1-holofermes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 15:41:26 +0000
Message-Id: <20260817154126.D13271F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 1-byte out-of-bounds read in ssd132x_update_rect() when the device=
 width is configured to an odd number.
- [High] Pre-existing logic error in atomic_disable callbacks causes ssd132=
x_clear_screen() to be completely unreachable dead code, meaning the patch =
applies a fix to a code path that never executes.
--

--- Patch [1]: [PATCH] drm/ssd130x: Set the address window in ssd132x_clear=
_screen() ---
commit ce857c983f38da1567b74e3e8854ddf27505140a
Author: Fabio Piparo <holofermes@gmail.com>

    drm/ssd130x: Set the address window in ssd132x_clear_screen()
   =20
    ssd132x_clear_screen() sends its zeroes without setting the column and
    row ranges first, so they land in whatever window the last
    ssd132x_update_rect() left programmed. A partial final update then
    leaves the rest of the screen uncleared, with fbcon the last damage is
    typically the cursor cell, so blanking keeps the console content on
    the panel.
   =20
    Set the full-screen window first, as ssd130x_clear_screen() already
    does.

> diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/=
ssd130x.c
> index 0b0fc6fe3df23..256d370e24034 100644
> --- a/drivers/gpu/drm/solomon/ssd130x.c
> +++ b/drivers/gpu/drm/solomon/ssd130x.c
> @@ -900,9 +900,20 @@ static void ssd132x_clear_screen(struct ssd130x_devi=
ce *ssd130x, u8 *data_array)
>  {

[Severity: High]
This is a pre-existing issue, but is ssd132x_clear_screen() ever actually
called during plane disable?

Looking at ssd132x_primary_plane_atomic_disable() where this is used, the
function returns early if the new plane state's crtc is NULL:

drivers/gpu/drm/solomon/ssd130x.c:ssd132x_primary_plane_atomic_disable() {
    ...
	if (!plane_state->crtc)
		return;
    ...
	ssd132x_clear_screen(ssd130x, ssd130x_crtc_state->data_array);
}

Since drm_atomic_get_new_plane_state() returns a state with a NULL crtc
pointer during a disable transition, doesn't this early return always
trigger, preventing the clear_screen fix from executing?

>  	unsigned int columns =3D DIV_ROUND_UP(ssd130x->width, SSD132X_SEGMENT_W=
IDTH);
>  	unsigned int height =3D ssd130x->height;
> +	int ret;
> =20
>  	memset(data_array, 0, columns * height);
> =20
> +	/* Set column start and end */
> +	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_COL_RANGE, 0, columns=
 - 1);
> +	if (ret < 0)
> +		return;
> +
> +	/* Set row start and end */
> +	ret =3D ssd130x_write_cmd(ssd130x, 3, SSD132X_SET_ROW_RANGE, 0, height =
- 1);
> +	if (ret < 0)
> +		return;
> +
>  	/* Write out update in one go since horizontal addressing mode is used =
*/
>  	ssd130x_write_data(ssd130x, data_array, columns * height);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but can ssd132x_update_rect() re=
ad
out of bounds if the device tree configures an odd solomon,width (e.g., 127=
)?

In ssd132x_primary_plane_atomic_check(), the shadow buffer is allocated as
exactly width * height bytes for DRM_FORMAT_R8:

drivers/gpu/drm/solomon/ssd130x.c:ssd132x_primary_plane_atomic_check() {
    ...
	ssd130x_state->buffer =3D kcalloc(pitch, ssd130x->height, GFP_KERNEL);
    ...
}

In ssd132x_update_rect(), the loop increments by segment_width (2):

drivers/gpu/drm/solomon/ssd130x.c:ssd132x_update_rect() {
    ...
	for (i =3D 0; i < height; i++) {
		for (j =3D 0; j < width; j +=3D segment_width) {
			u8 n1 =3D buf[i * width + j];
			u8 n2 =3D buf[i * width + j + 1];
    ...
}

If width is 127, on the last iteration of the last row (i =3D height - 1,
j =3D 126), doesn't buf[i * width + j + 1] read buf[height * 127], which is
1 byte past the end of the allocated buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817152500.7037=
70-1-holofermes@gmail.com?part=3D1
