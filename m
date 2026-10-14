Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912CAC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4AA410EA81;
	Wed, 14 Oct 2026 18:10:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1C610EA90
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:10:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7882D60229
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F901F000C5;
 Wed, 14 Oct 2026 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792001416;
 bh=vWGVZgYW1wtf1MpuocIzOIjO6MchkbXmbRm3hCcrLAc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jkFO5kr7wjQFzeC8JzKXH2/GY2h1wHfECpRsfXGo3W4GGhFiKHBxnxYlFy2n8ECZa
 MU+PV6zQV3sSCst8To3CZMcoo9OfVVXuKBnx8SKm2d1fJPGygUbEkG8FFAUyaE62k8
 s4qyzj6dmhmJxsGQHdzOdZKGX+DltmtvdT5NZkMlSWjIjyBj+IB2TbogLlPQ1b2qCu
 oZoyR6X3Jv4G3m0Awvt+zVa96Afx4mZX7v0SJc5dWbryRE0/Dd+Uz9VaNGySN+2Bn5
 fJQOF/KHNi65TudwzzUtuOwV3DphYPDPtwSL85QrkwnxAsKzTm0cC/EuqXNEh7l3hA
 jlxs2OK8exjpw==
Message-ID: <sashiko-outbox-171669@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 64/75] drm/vc4: vec: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-64-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-64-586c9c026823@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 18:10:15 +0000
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
- [High] drm/vc4: NULL pointer deref in drm_atomic_helper_connector_tv_stat=
e_init
--

commit 0f9d479612175281e5b2697d74e34321440ab363
Author: Maxime Ripard <mripard@kernel.org>

drm/vc4: vec: Convert to atomic_create_state

This commit converts the vc4 VEC connector reset implementation to an
atomic_create_state hook. It creates a pristine state and initializes
the analog TV properties without performing hardware resets.

> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c

[ ... ]

> -static void vc4_vec_connector_reset(struct drm_connector *connector)
> +static struct drm_connector_state *
> +vc4_vec_connector_create_state(struct drm_connector *connector)
>  {
> -	drm_atomic_helper_connector_reset(connector);
> -	drm_atomic_helper_connector_tv_state_init(connector->state, connector);
> +	struct drm_connector_state *connector_state;
> +
> +	connector_state =3D drm_atomic_helper_connector_create_state(connector);
> +	if (IS_ERR(connector_state))
> +		return connector_state;
> +
> +	drm_atomic_helper_connector_tv_state_init(connector_state, connector);

[Severity: High]
Will this cause a NULL pointer dereference during display initialization?

The core DRM function drm_mode_config_connector_reset_with_create_state()
explicitly sets connector->state to NULL before invoking the
atomic_create_state hook.

This means connector->state is NULL when
drm_atomic_helper_connector_tv_state_init() is called here.

Looking at drm_atomic_helper_connector_tv_state_init() in
drm_atomic_state_helper.c, it ignores the local state parameter when
initializing margins and instead passes connector->state:

void drm_atomic_helper_connector_tv_state_init(
        struct drm_connector_state *state,
        struct drm_connector *connector)
{
        ...
        drm_atomic_helper_connector_tv_margins_state_init(connector->state,
                                                          connector);
}

Because connector->state is NULL in this context, does calling this
helper result in a guaranteed crash when the margins initializer
attempts to dereference the state parameter?

> +
> +	return connector_state;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-drm-no-mor=
e-connector-reset-v1-0-586c9c026823@kernel.org?part=3D64
