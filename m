Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A2606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIkTglKw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A2010E7F5;
	Sat, 14 Nov 2026 18:28:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5042D10E7F5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:28:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF683439BE;
 Sat, 14 Nov 2026 18:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B061F000C5;
 Sat, 14 Nov 2026 18:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794680902;
 bh=yV+zvC9zJNFFLUrUjiOIWiO0hlyVGq5vJ+WENaypnBk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hIkTglKwul0uF8eMO4L2jzxtFoWQ/Njy+5R+PTL3VQNA9/jp7pSQejwe2vAhldifM
 B9AxAH9Ns5KL/90laF9+fmD+FTxUaeUKzqv+5qc3dLWNUyOh2y56KR++5WDWr7hBzD
 bk99ec7ZAdjbsgNDBYNYWDdBYxXCuNDwZjvODGZCm589DCOJEGNS2naKZhPucDajWI
 nJ6ystAXB2lkb65N0ZkSehP+XJXetCx9VbgJsj8dQLR1br6irFLfz1rXRPNwy/c3mU
 HmotReFMTT0gmUbe3eoFfoFlPA9KpN5GkXfXtJGnU3lKGhuMbzlUypGK7b8qj4sgww
 4Y64fBq16osGA==
Message-ID: <sashiko-outbox-214902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/25] drm/tests: probe-helper: Add .force_ctx()
 callback coverage
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-25-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-25-20e8a33a2286@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:28:22 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tests: unhandled -EDEADLK injection in
  drm_probe_helper_contender_fn()
--

commit d28b5fe04c94cb62864f25a529c3f378922f36a4
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: probe-helper: Add .force_ctx() callback coverage

This commit adds KUnit tests for the .force_ctx() connector helper
callback, including deadlock backoff handling using a contender kthread.

> diff --git a/drivers/gpu/drm/tests/drm_probe_helper_test.c b/drivers/gpu/=
drm/tests/drm_probe_helper_test.c
> index ebc0392585e72..5d7dc47255181 100644
> --- a/drivers/gpu/drm/tests/drm_probe_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_probe_helper_test.c
[ ... ]
> @@ -212,6 +225,289 @@ static struct kunit_suite drm_test_connector_helper=
_tv_get_modes_suite =3D {
> =20
>  kunit_test_suite(drm_test_connector_helper_tv_get_modes_suite);
> =20
> +/*
> + * Runs an acquire context older than the probe one, which first takes @=
lock,
> + * then waits to be told to also request the connection_mutex held by the
> + * probe context.  Being older, it wounds the probe context, which will =
get
> + * -EDEADLK as soon as it tries to take @lock.
> + */
> +struct drm_probe_helper_contender {
> +	struct drm_device *drm;
> +	struct drm_modeset_lock lock;
> +	struct completion locked;
> +	struct completion go;
> +	struct completion done;
> +	int ret;
> +};
> +
> +static int drm_probe_helper_contender_fn(void *data)
> +{
> +	struct drm_probe_helper_contender *contender =3D data;
> +	struct drm_modeset_acquire_ctx ctx;
> +
> +	drm_modeset_acquire_init(&ctx, 0);
> +
> +	contender->ret =3D drm_modeset_lock(&contender->lock, &ctx);
> +	complete(&contender->locked);
> +
> +	if (!contender->ret) {
> +		if (wait_for_completion_timeout(&contender->go, 5 * HZ))
> +			contender->ret =3D
> +				drm_modeset_lock(&contender->drm->mode_config.connection_mutex,
> +						 &ctx);
> +		else
> +			contender->ret =3D -ETIMEDOUT;
> +	}
> +
> +	drm_modeset_drop_locks(&ctx);

[Severity: Medium]
Can drm_modeset_lock(&contender->drm->mode_config.connection_mutex, &ctx)
return -EDEADLK when CONFIG_DEBUG_WW_MUTEX_SLOWPATH is enabled?

Acquiring connection_mutex is the second lock in ctx (ctx.ww_ctx.acquired
becomes 2), so ww_mutex_lock() runs ww_mutex_deadlock_injection().  When
(ctx.ww_ctx.stamp & 0xf) =3D=3D 0, it injects -EDEADLK after the probe
context backs off and releases connection_mutex, setting ctx.contended.

Because drm_probe_helper_contender_fn() does not handle -EDEADLK,
drm_modeset_drop_locks(&ctx) hits WARN_ON(ctx->contended) and
drm_test_probe_helper_force_ctx_deadlock() fails KUNIT_ASSERT_EQ(test,
contender->ret, 0).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-drm-conn-h=
dmi-cleanup-v1-0-20e8a33a2286@collabora.com?part=3D25
