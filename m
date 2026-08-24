Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04FCC5DF9B
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15E3010E7C5;
	Mon, 24 Aug 2026 14:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9wr6Sjt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264EF10E443;
 Mon, 24 Aug 2026 14:11:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D4356011F;
 Mon, 24 Aug 2026 14:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817C91F00A3A;
 Mon, 24 Aug 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787580686;
 bh=NNSqrxhKdKa9IsISn7TuGdTFnKoxHXdqNnZmSpXrJlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z9wr6SjtyDdFI565fEg5Y7ka2qiBRlRSYHSDE4oTcj68lvrC37ievysH8flpSFsGQ
 V6k0ysaCuZcI0BdQbAeTG2KTgEfCTJeYgYM6VihjJ30FqRkMQIpvXzMlm0jzbbQTKr
 sHma8LyvG8V/1vxLLRmMyH/dsN5gB7UU9vfJX/EZnPfbQV+xjks16B5nx75lndLsLh
 iM7XJCTIll7JU50iUrJ/uihq7UDE12/hUfaCAvWQkut8ja7irSLPeuCpA3VDJ7b/Nx
 j5i2EgWhpiU+dbZVc4xJx3Rq8Dtgg3oNJaje9YQ3Kzsaz1eQhSMUPzMTgu8VW+GmY7
 irzAfulRKrnSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] drm/panic: Compile KUnit tests as module
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: intel-xe@lists.freedesktop.org, ojeda@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, Frank.Li@kernel.org, wsa+renesas@sang-engineering.com,
 linux-hyperv@vger.kernel.org
In-Reply-To: <20260824125201.218863-14-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-14-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 14:11:25 +0000
Message-Id: <20260824141126.817C91F00A3A@smtp.kernel.org>
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
- [High] Dangling pointer in panic_msg array causes use-after-free during k=
ernel panic after the test module is unloaded.
--

--- Patch [13]: [PATCH v2 13/13] drm/panic: Compile KUnit tests as module -=
--
commit 9a00d4c3f17fad5dbc6e3335649c2316482a4fad
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/panic: Compile KUnit tests as module
   =20
Fix dependency of the panic-helper KUnit tests on CONFIG_DRM_KUNIT_TEST=3Dy
and make them build as a module. Export the necessary interfaces from the
panic helpers iff the KUnit framework has been enabled.

> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_pan=
ic_helper.c
> index 669f09225f8ed..253262b7e0d4c 100644
> --- a/drivers/gpu/drm/drm_panic_helper.c
> +++ b/drivers/gpu/drm/drm_panic_helper.c

[ ... ]

> -static void drm_panic_helper_set_description(const char *description)
> +VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *descr=
iption)
>  {
>  	u32 len;
> =20
>  	if (description) {
>  		struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1];
> =20
>  		desc_line->txt =3D description;
>  		len =3D strlen(description);
>  		/* ignore the last newline character */
>  		if (len && description[len - 1] =3D=3D '\n')
>  			len -=3D 1;
>  		desc_line->len =3D len;
>  	}
>  }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);

[Severity: High]
This is a pre-existing issue, but since the test can now be built as a modu=
le,
does unloading it leave a dangling pointer in the global panic_msg array?

In drivers/gpu/drm/tests/drm_panic_helper_test.c, drm_test_panic_init()
calls drm_panic_helper_set_description("Kunit testing"), which stores a
pointer to the test module's .rodata.

When the drm_panic_helper_test module is unloaded, this memory is freed. Si=
nce
the test suite lacks an .exit callback to call
drm_panic_helper_clear_description(), the dangling pointer remains in the
global array.

If a real kernel panic occurs later where detail->description is NULL (such=
 as
via kmsg_dump(KMSG_DUMP_PANIC) on some architectures), this function silent=
ly
ignores the NULL input and leaves the dangling pointer intact.

Will this cause a use-after-free read when the panic screen rendering
dereferences desc_line->txt, potentially preventing the panic screen from
displaying during an actual crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D13
