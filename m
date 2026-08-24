Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72DFC5DF9B
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9AC10E433;
	Mon, 24 Aug 2026 13:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k7eZ+srk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F13AF10E377;
 Mon, 24 Aug 2026 13:21:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 950C340AE6;
 Mon, 24 Aug 2026 13:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0027B1F000E9;
 Mon, 24 Aug 2026 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787577679;
 bh=tqQWdU7qIu7z80Vg+ML+5cNSrgns2KDCFHdeeAvGBcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k7eZ+srkEa6Mjjhy159+Dlxi9kUsa8zInzcYaa9ZfJ4kJ6C6bmwFKCqwfFKwBCLkI
 hqdiYLhjcWzRuyGQRwVUa1+6K/t31eXHV84x1HeVy2HVW7VxOPIjAdJTpEzN2HMzTv
 R2XzFKijKlzLAWUIjp3909DA46jPjHP8gSQZWEBJgyBpdtwg56c8/bCdvRk6plNfYz
 QIQsn/oo6kO76R+JRXmBB0XZgxD5mszoYvhKAImi3NFRvmlBdP5TH8ygRF3NZtiDFa
 7LaCJTzLecy+s1SY87VGHwqkpkx4NEUvOui9SsgoYbkwJUp7NtSLjOcGxihe6HObLR
 sJrmlVyhrl+Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] drm/panic: Retry in dispatch function if panic
 output fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 Frank.Li@kernel.org, linux-hyperv@vger.kernel.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260824125201.218863-8-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:21:18 +0000
Message-Id: <20260824132119.0027B1F000E9@smtp.kernel.org>
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
- [Medium] The commit message claims a change that is not present in the co=
de diff.
- [Medium] Fallback to user mode silently flushes a blank screen if the scr=
een is narrower than a single character, defeating failure preservation.
--

--- Patch [7]: [PATCH v2 07/13] drm/panic: Retry in dispatch function if pa=
nic output fails ---
commit 43648cf544bdeed6f6c85be5e74f3e855c778814
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Retry in dispatch function if panic output fails

This patch introduces explicit fallback to DRM_PANIC_TYPE_USER in
drm_panic_dispatch() when QR code or kmsg outputs fail. It also increases t=
he
minimum QR code test size to 494x494.

> Also pass module parameter drm_panic_type as a parameter to
> drm_panic_dispatch(). This simpifies the implementation. It will later
> allow for moving the function into a helper library.

[Severity: Medium]
This isn't a bug, but the commit message mentions passing drm_panic_type as=
 a
parameter to drm_panic_dispatch(), which isn't present in this patch's code
changes. Was this already implemented in a preceding commit?

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index f597ef04c5bcb..bc7c096c42363 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c

[ ... ]

> @@ -895,13 +886,22 @@ static int draw_panic_dispatch(struct drm_scanout_b=
uffer *sb, enum drm_panic_typ
>  {
>  	int ret;
> =20
> +retry:
>  	switch (panic_type) {
>  	case DRM_PANIC_TYPE_KMSG:
>  		ret =3D draw_panic_screen_kmsg(sb, fg_color, bg_color);
> +		if (ret) {
> +			panic_type =3D DRM_PANIC_TYPE_USER;
> +			goto retry;
> +		}

[Severity: Medium]
Does this fallback logic inadvertently cause the screen to be overwritten w=
ith
a blank screen if the screen is narrower than a single character?

If drm_panic_type is set to KMSG and sb->width < font->width,
draw_panic_screen_kmsg() returns -EINVAL. The retry logic here catches this
and falls back to DRM_PANIC_TYPE_USER.

However, looking at draw_panic_screen_user(), it lacks a similar width chec=
k.
It clears the screen with the background color:

drivers/gpu/drm/drm_panic.c:draw_panic_screen_user() {
    ...
    /* Fill with the background color, and draw text on top */
    drm_panic_fill(sb, &r_screen, bg_color);
    ...
}

It then returns 0 (success) without drawing any text. This success code cau=
ses
draw_panic_plane() to flush the blank screen, destroying the existing visual
evidence instead of preserving it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D7
