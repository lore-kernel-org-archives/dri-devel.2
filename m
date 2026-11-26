Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF208606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EURWSsxN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BE610E978;
	Thu, 26 Nov 2026 11:55:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884C310E978
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:55:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C7FD62372;
 Thu, 26 Nov 2026 11:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47DA1F000C0;
 Thu, 26 Nov 2026 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795694138;
 bh=1zGW3pllRvA3FOZs+LKbltrqJfqwCGhY2Thw21POvOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EURWSsxNtYDAWii5/Ty1+1rdVUDiPjgMXQNl1vGmEeyIgglrzkHeO0WVFJI1M/6tR
 RduLAidiLHZEANkdr8x1csv1YYqyO0pEOPRQ5REYMBf7qmktMv/EgRyikeZ4rhddBv
 GkG2QdelZjRlci+r/ugjn3zspGrMC14eMTS8tl6bvEhcO7Icrl8g/6Xpbjs+uSRnic
 YtekxSyb9ANdlBhg/vz5IlUotaK2iAL8QU7bEeywGvKh6JFvWETpynMmu7DdvKzYOH
 VdYBDYq9p3LtBSj+GwuGVQmuk/7q6Iv0gSAJnkJwWQJlzpg/OoCt9Vuta1SVjx+MKa
 7m2YrevExoL/w==
Message-ID: <sashiko-outbox-235438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/43] drm/vkms: Add KUnit test for device lifecycle
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-12-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-12-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:55:38 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] drm/vkms: missing vkms_destroy() call in uncreated-device
  KUnit test
- [Medium] drm/vkms: missing second vkms_destroy() in
  vkms_lifecycle_test_double_destroy()
- [Low] drm/vkms: missing connector detach before vkms_destroy() in
  KUnit test
- [Low] drm/vkms: non-portable KASAN and KUNIT_ALL_TESTS in .kunitconfig
- [Low] drm/vkms: EXPORT_SYMBOL_IF_KUNIT(vkms_create) placed after
  vkms_init()
--

commit 638d5ac8d39529e98a29a3faec3aa7ef9239a4d3
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Add KUnit test for device lifecycle

This commit adds a KUnit test suite exercising VKMS device creation,
destruction, and reference-counted configuration object lifetimes, and
exports vkms_create() and vkms_destroy() for KUnit testing.

> diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vk=
ms/tests/.kunitconfig
> index 6a2d87068edc5..c9752bde84874 100644
> --- a/drivers/gpu/drm/vkms/tests/.kunitconfig
> +++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
> @@ -2,3 +2,13 @@ CONFIG_KUNIT=3Dy
>  CONFIG_DRM=3Dy
>  CONFIG_DRM_VKMS=3Dy
>  CONFIG_DRM_VKMS_KUNIT_TEST=3Dy
> +CONFIG_KASAN=3Dy
> +CONFIG_KASAN_INLINE=3Dy
> +CONFIG_KASAN_VMALLOC=3Dy
> +CONFIG_KUNIT_ALL_TESTS=3Dn

[Severity: Low]
Will hardcoding these KASAN options and CONFIG_KUNIT_ALL_TESTS=3Dn break
kunit.py runs?

kunit.py rejects .kunitconfig options that are missing from the final
.config, so CONFIG_KASAN_INLINE=3Dy and CONFIG_KASAN_VMALLOC=3Dy fail on
architectures or build modes that do not support them (such as 32-bit
targets or UML with CONFIG_STATIC_LINK=3Dy).  CONFIG_KUNIT_ALL_TESTS=3Dn al=
so
conflicts with tools/testing/kunit/configs/all_tests.config when running
kunit.py with --alltests, causing kunit_kernel.py to abort with a multiple
values ConfigError.

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c b/drivers/g=
pu/drm/vkms/tests/vkms_lifecycle_test.c
> new file mode 100644
> index 0000000000000..7f7b313687101
> --- /dev/null
> +++ b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c

[ ... ]

> +static void vkms_lifecycle_test_destroy_uncreated_device(struct kunit *t=
est)
> +{
> +	struct vkms_config *config;
> +
> +	config =3D vkms_config_default_create(true, true, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +
> +	KUNIT_ASSERT_NULL(test, config->dev);
> +
> +	vkms_config_destroy(config);
> +}

[Severity: Medium]
Should vkms_lifecycle_test_destroy_uncreated_device() call
vkms_destroy(config) before vkms_config_destroy(config)?  Without it, the
!config->dev early return in vkms_destroy() is never exercised.

> +
> +static void vkms_lifecycle_test_double_destroy(struct kunit *test)
> +{
> +	struct vkms_config *config;
> +	int ret;
> +
> +	config =3D vkms_config_default_create(true, true, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +	vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +	ret =3D vkms_create(config);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	vkms_destroy(config);
> +	KUNIT_ASSERT_NULL(test, config->dev);
> +
> +	vkms_config_destroy(config);
> +}

[Severity: Medium]
Is a second vkms_destroy(config) call missing here?  Calling
vkms_destroy(config) only once leaves double destruction untested.

[ ... ]

> +static void vkms_lifecycle_test_connector_static_drmm_release(struct kun=
it *test)
> +{
> +	struct vkms_config *config;
> +
> +	config =3D vkms_config_default_create(true, true, false, false);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +	vkms_lifecycle_test_set_unique_name(test, config, test->name);
> +
> +	KUNIT_ASSERT_EQ(test, vkms_create(config), 0);
> +
> +	/* vkms_destroy() runs the drmm action, which frees and detaches the co=
nnector. */
> +	vkms_destroy(config);
> +	vkms_config_destroy(config);
> +}

[Severity: Low]
Does vkms_lifecycle_test_connector_static_drmm_release() actually test
releasing the last connector reference from the drmm action?

Even after commit "drm/vkms: Introduce back pointer to connector" adds
vkms_connector_static_cfg_release(), config->connectors still holds its
reference when vkms_destroy(config) runs unless the connector or config is
destroyed first, so this test only repeats a single iteration of
vkms_lifecycle_test_create_destroy_default().

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 24572bc779b41..f73f136e5588e 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c

[ ... ]

> @@ -252,6 +253,7 @@ static int __init vkms_init(void)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_IF_KUNIT(vkms_create);

[Severity: Low]
This isn't a bug, but EXPORT_SYMBOL_IF_KUNIT(vkms_create) is placed after
vkms_init() instead of right after vkms_create().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D12
