Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB67606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b4crzSM0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38AF811201D;
	Thu, 29 Oct 2026 07:56:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F7E11201D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:56:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D67443900
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA521F031E1;
 Thu, 29 Oct 2026 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793260597;
 bh=EH27bS4gkh7DLPkH0dzXdV7IanMWrhgpX/CwuaQirY8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b4crzSM09lO+OvcYWAyQi+uxUE7K9wC0zU3A3gxlvQPzBCPeFGmXXDUrSuEAKfl1l
 rBQUaM5i8qHX+QYG+wX7HBmhDFK8rN/f91qGLlTRHscZod2pXZkIQOJAi+k3bomsKS
 kWjTdJUwvexaiUC/T527XG3eALJkTGg8iNCduGwJrxbbYR9XtYQosy7Hj034r4L7gE
 jkdnHOp5M/aTB4G8KBBp0Di1JkYg81yU0vTGd6dAn/+/zyxbRsc6mDpGz8MPpPzgBB
 LZerJ4SckKFU6sBnXdFWj/wpX9ogjtwFHtEX+hMJxzTkM3dvG99tsrsWtCL0uafPzT
 fDyuiXjevhJCQ==
Message-ID: <sashiko-outbox-188924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/34] drm/tests: kunit: Add a drm_printer helper
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-drm-state-readout-v7-24-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
 <20261029-drm-state-readout-v7-24-25e5163d75c3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 07:56:36 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/tests: wrong constant family in drm_kunit_helper_printer() kern=
el-doc
--

commit 886820e203ca83b1374826ea99ea6f649c1fd41e
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: kunit: Add a drm_printer helper

This commit adds drm_kunit_helper_printer() to create a drm_printer that
forwards messages to kunit_log() at a specified log level.

> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/=
tests/drm_kunit_helpers.c
> index 63d0249465005..fad911772ee59 100644
> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
> @@ -8,6 +8,7 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_kunit_helpers.h>
>  #include <drm/drm_managed.h>
> +#include <drm/drm_print.h>
> =20
>  #include <kunit/device.h>
>  #include <kunit/resource.h>
> @@ -18,6 +19,83 @@
> =20
>  #define KUNIT_DEVICE_NAME	"drm-kunit-mock-device"
> =20
> +struct drm_printer_ctx {
> +	struct drm_printer	p;
> +	int			level;
> +	struct kunit		*test;
> +};
> +
> +/*
> + * kunit_log() is a macro that only accepts a compile-time log level,
> + * so the level has to be dispatched to the matching kunit_log() call.
> + */
> +static void drm_kunit_printf(struct drm_printer *p, struct va_format *va=
f)
> +{
> +	struct drm_printer_ctx *ctx =3D p->arg;
> +
> +	switch (ctx->level) {
> +	case LOGLEVEL_EMERG:
> +		kunit_log(KERN_EMERG, ctx->test, "%pV", vaf);
> +		break;

[ ... ]

> +/**
> + * drm_kunit_helper_printer - Creates a &drm_printer logging into a KUni=
t test log
> + * @test: The test context object
> + * @level: The log level to log the messages at, one of the KERN_* const=
ants

[Severity: Low]
Should the kernel-doc for @level in drm_kunit_helper_printer() refer to the
LOGLEVEL_* constants instead of KERN_*?

The KERN_* macros are string literals, whereas drm_kunit_helper_printer()
takes an int level and drm_kunit_printf() switches on ctx->level against
LOGLEVEL_EMERG through LOGLEVEL_INFO. Passing a KERN_* constant here will
trigger a pointer-to-integer conversion warning and fall through to the
default case in drm_kunit_printf().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-drm-state-=
readout-v7-0-25e5163d75c3@kernel.org?part=3D24
