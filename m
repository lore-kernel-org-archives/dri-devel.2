Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB444C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34D110F065;
	Wed,  9 Sep 2026 09:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lFcips2d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE0810F059;
 Wed,  9 Sep 2026 09:37:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B1B740C4E;
 Wed,  9 Sep 2026 09:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1931F00A3A;
 Wed,  9 Sep 2026 09:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788946649;
 bh=HjXCv/IRivEd/0jUidSfuc1KTFFdu2s/p3PtFBwX+Zs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lFcips2dNZb6YLBKKYInKBk99Ih0a0yB6P8InbZqxryG8B5GvaJoaJZNssN8/bMFK
 g46Mr8oYPQOaUNKjhuB7oS4ptmd8cItVTuWI5Evee03G3Jw2JjwlOH2ZaJDdccHUL0
 UNdggCSq53AH7f+1aoSC9aOEx1+bjxPm+lsDK4FhM8uP6SJPOODnoWIAA+bGbIIy3F
 ofPHZg/XY4vUSH0o4N/4di6RhllmgQBII7peekz7KG6LTTcRCzZC+DtjyQDnVaWcwJ
 D/Wmqk6CTJ/GWioDnYaHXvx+hViUDUeAc9ef6fbY4nYRTh72rDyAMmoJOyg/P8OG3Q
 KXRD4uNgbwQqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/14] drm/panic: Compile KUnit tests as module
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-xe@lists.freedesktop.org, virtualization@lists.linux.dev,
 gary@garyguo.net, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org
In-Reply-To: <20260909085826.64529-15-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-15-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:37:27 +0000
Message-Id: <20260909093728.4E1931F00A3A@smtp.kernel.org>
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
- [High] The KUnit test exit function `drm_test_panic_exit()` fails to clea=
r the global panic description, leaving a dangling pointer that can crash t=
he panic handler.
--

commit 7eb0aee35aa7e3c110129d29f0c30be49ac71dab
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Compile KUnit tests as module

This commit fixes the panic-helper KUnit tests dependency and enables them =
to
be built as a module. It exports necessary interfaces if KUnit is enabled a=
nd
adds cleanup logic for the tests.

> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_pan=
ic_helper.c
[ ... ]
> @@ -815,7 +820,7 @@ static int draw_panic_helper_dispatch(struct drm_scan=
out_buffer *sb,
>  	return ret;
>  }
> =20
> -static void drm_panic_helper_set_description(const char *description)
> +VISIBLE_IF_KUNIT void drm_panic_helper_set_description(const char *descr=
iption)
>  {
>  	u32 len;
> =20
> @@ -830,6 +835,7 @@ static void drm_panic_helper_set_description(const ch=
ar *description)
>  		desc_line->len =3D len;
>  	}
>  }
> +EXPORT_SYMBOL_IF_KUNIT(drm_panic_helper_set_description);
[ ... ]
> diff --git a/drivers/gpu/drm/tests/drm_panic_helper_test.c b/drivers/gpu/=
drm/tests/drm_panic_helper_test.c
[ ... ]
> @@ -86,6 +90,11 @@ static int drm_test_panic_init(struct kunit *test)
>  	return 0;
>  }
> =20
> +static void drm_test_panic_exit(struct kunit *test)
> +{
> +	drm_panic_helper_set_description(NULL);
> +}

[Severity: High]
Does this leave a dangling pointer in the global panic_msg array when the t=
est
module is unloaded?

Looking at drm_panic_helper_set_description() in drm_panic_helper.c, it
checks if the argument is valid before modifying the state:

    if (description) {
        struct drm_panic_line *desc_line =3D &panic_msg[panic_msg_lines - 1=
];
        desc_line->txt =3D description;
        ...
    }

When drm_test_panic_exit() calls drm_panic_helper_set_description(NULL) to
clear the state, the NULL argument is silently ignored.=20

Since drm_test_panic_init() originally sets the description to a string
located in the test module's read-only data, the global panic_msg array will
retain a pointer to this memory even after the module is freed.

If a system panic occurs later, could the panic handler fault when trying to
dereference this stale pointer and fail to render the panic screen?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D14
