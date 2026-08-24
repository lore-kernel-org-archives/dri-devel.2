Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B78C61DB4
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF4C10E1A5;
	Mon, 24 Aug 2026 13:13:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z5jsjHvl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B51E410E154;
 Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3712E43BF3;
 Mon, 24 Aug 2026 13:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1B41F00A3A;
 Mon, 24 Aug 2026 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787577231;
 bh=tMcak/Mf+DuOibRI3q5Ttd/E3iSnBN8Ex3krV5Y5x2E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z5jsjHvl++N5+Cqf/fa/CRHm3AkmM+TJzjbQAIRNmIy5wXViUvyMJ+t+/HI+BZLRL
 AQXy9/WzAth1nZayvtu+FkCWXbjeCXH+9OCH+h9/ZGvsdPXNfT2f5TuGfl///HmLB4
 GFagqrMNy9ynD68mxBmeuV/Px5Pi4e+RvSM5Urb/ZMmyrF02+zFEUCv2PC8JYyUXVV
 dGzADONQstvTSrahGM0+z9ZaZDH8dMAyzQI0tvUWxlWd2S+Z/UTQJy56dhNoH4KjmX
 0BsZY2MkTaEh3MaMXgxy3yXY4+QidsctdkOpw82X6Rv4gjuzfaWrxc3BIX+8Ba91nb
 tbVddvTQ+3CoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] drm/panic: Pass colors to draw_panic_dispatch()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-xe@lists.freedesktop.org, Frank.Li@kernel.org, ojeda@kernel.org,
 imx@lists.linux.dev, wsa+renesas@sang-engineering.com,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260824125201.218863-6-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:13:50 +0000
Message-Id: <20260824131350.8F1B41F00A3A@smtp.kernel.org>
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
- [Medium] Using KUNIT_ASSERT_EQ with unmanaged resources causes kernel mem=
ory leaks on test failure.
--

--- Patch [5]: [PATCH v2 05/13] drm/panic: Pass colors to draw_panic_dispat=
ch() ---
commit dfb1a50d1181cba2ccd93fe314ac428958a579a7
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Pass colors to draw_panic_dispatch()

This commit sets the panic-screen colors in a central location and passes
them to the individual drawing functions. In the test cases, it hardcodes
these colors to remove test dependencies on the exact config values.

> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> index fdd77b0cc54c9..969a096ec840f 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c
[ ... ]
> @@ -48,10 +41,27 @@ struct drm_test_mode {
>  	.width =3D w, \
>  	.height =3D h, \
>  	.format =3D f, \
> -	.draw_screen =3D draw_panic_screen_##name, \
> +	.draw_screen =3D draw_panic_screen_ ## name ## _default, \

[Severity: Medium]
When params->draw_screen(sb) fails, does this cause the test to leak fb?

In drm_test_panic_screen_user_map(), the KUNIT_ASSERT_EQ() macro aborts the
test before vfree(fb) can execute:

drivers/gpu/drm/tests/drm_panic_test.c:drm_test_panic_screen_user_map() {
    ...
	fb =3D vmalloc(fb_size);
    ...
	ret =3D params->draw_screen(sb);
	KUNIT_ASSERT_EQ(test, ret, 0);
    ...
	vfree(fb);
}

Similarly, does drm_test_panic_screen_user_page() leak the allocated pages
when the test fails? An abort here skips the free_pages cleanup block:

drivers/gpu/drm/tests/drm_panic_test.c:drm_test_panic_screen_user_page() {
    ...
	ret =3D params->draw_screen(sb);
	KUNIT_ASSERT_EQ(test, ret, 0);
    ...
free_pages:
	for (p =3D 0; p < npages; p++)
		__free_page(pages[p]);
	kfree(pages);
}

>  	.fname =3D #name, \
>  	}, \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D5
