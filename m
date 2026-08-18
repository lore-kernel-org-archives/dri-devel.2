Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E5DC5DF84
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DDD10EB6D;
	Tue, 18 Aug 2026 13:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OP1kGnuz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97CA110EB6C;
 Tue, 18 Aug 2026 13:09:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C90B06020E;
 Tue, 18 Aug 2026 13:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110771F000E9;
 Tue, 18 Aug 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787058556;
 bh=L5WWSul3RAEl4/t2hhe1a784y/wIeSmloPtBdMqkhuo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OP1kGnuz6HJmfYAqQO1vUfRp8kcRYMm9SlHlPPadXtfuvXGSoFCxoT5Chughq2ZSO
 ymFWhX7Rnr/MVtnaoYsTZYt8zn8ULhGv0WBIDFEB4Kysz3LSJXD8qFAj2ay6IIQeME
 RxDiTLQVrZ96syZDo6mYF08edvsChPw4qAEAbCuEuhPxAMn4Li2vRptJoR+9TRTTeR
 Q4CaZqh680IHhAmQYDyX5uXlj0Zv0/RRoJLUgtgRmNR/en69VpSHKI08pzUPW1Ogzd
 NWPcaT2vkr6jrK2Rr4+4GGPTRQtGbyORrPxiXRLggStGEOfvHY/Ezb9E2Y3D3MvKDi
 Xpu+VfWoiDJWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] drm/panic: Pass global module parameters to
 drm_panic_dispatch()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org,
 linux-hyperv@vger.kernel.org, Frank.Li@kernel.org,
 intel-gfx@lists.freedesktop.org, wsa+renesas@sang-engineering.com,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260818125012.468092-7-tzimmermann@suse.de>
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 13:09:15 +0000
Message-Id: <20260818130916.110771F000E9@smtp.kernel.org>
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
- [High] Concurrent debugfs writes or KUnit tests across multiple DRM devic=
es race on global static buffers without adequate synchronization.
--

--- Patch [6]: [PATCH 06/12] drm/panic: Pass global module parameters to dr=
m_panic_dispatch() ---
commit 9f2a1b5158feac614c09a17c83f387591642e034
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Pass global module parameters to drm_panic_dispatch()

This patch sets the panic type and QR version in draw_panic_plane() as a si=
ngle
point of truth, passing these values into the individual drawing functions.
In the test case, it always creates a QR code with version 40.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index ede620b27515a..12c39217cbcb5 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
[ ... ]
> @@ -951,6 +955,11 @@ static void draw_panic_plane(struct drm_plane *plane=
, const char *description)
>  #else
>  	u32 bg_color =3D 0x00000000;
>  #endif
> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
> +	unsigned int qr_version =3D panic_qr_version;
> +#else
> +	unsigned int qr_version =3D 0;
> +#endif
> =20
>  	if (!drm_panic_trylock(plane->dev, flags))
>  		return;
> @@ -966,7 +975,7 @@ static void draw_panic_plane(struct drm_plane *plane,=
 const char *description)
> =20
>  	drm_panic_set_description(description);
> =20
> -	ret =3D draw_panic_dispatch(&sb, fg_color, bg_color);
> +	ret =3D draw_panic_dispatch(&sb, drm_panic_type, fg_color, bg_color, qr=
_version);

[Severity: High]
This is a pre-existing issue, but does the per-device locking in
drm_panic_trylock() adequately protect the global buffers?

Since the lock is per-device (plane->dev->mode_config.panic_lock), concurre=
nt
debugfs writes across multiple DRM devices can still race and mutate global
static variables, such as the zlib stream workspace (struct z_stream_s stre=
am)
or qrbuf1 and qrbuf2.

If a real kernel panic occurs while a debugfs write is concurrently using t=
hese
buffers, the true panic handler could inherit a corrupted zlib workspace st=
ate,
which might lead to a recursive fault and failure to display the panic scre=
en.

Could this be protected by a global lock for non-panic paths?

[ ... ]
> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> index 969a096ec840f..196496238d231 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
> @@ -58,7 +58,7 @@ static int draw_panic_screen_kmsg_default(struct drm_sc=
anout_buffer *sb)
>  #if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>  static int draw_panic_screen_qr_code_default(struct drm_scanout_buffer *=
sb)
>  {
> -	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000);
> +	return draw_panic_screen_qr_code(sb, 0x00ffffff, 0x00000000, 40);
>  }
>  #endif

[Severity: High]
This isn't a bug introduced by this patch, but do the KUnit tests safely ac=
cess
the global drawing state?

It appears the KUnit tests bypass draw_panic_plane() entirely and directly =
call
drawing functions like draw_panic_screen_qr_code() without acquiring any lo=
cks.
Could running the tests race on the global buffers and corrupt the zlib
workspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818125012.4680=
92-1-tzimmermann@suse.de?part=3D6
