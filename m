Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608CE606D80F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeFlOSXA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C70F710E2BA;
	Thu,  5 Nov 2026 18:12:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9438A10E2BA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:12:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDF12600E4
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5311E1F00919;
 Thu,  5 Nov 2026 18:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793902344;
 bh=ox8SqL5dw/59GJ2J+ff3nOybh8b+e2KOG6VQi4U4skk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZeFlOSXAQF21O/f17wOEjsPxYKxAv3Sfuu8QcvN2DCrdbJ8fOkVBN13z3GdcwYUg6
 XTQ5+YVo9sV3shTJl4ig0ETX9SBbcIsPk9xWt82UPf799pzYQYnhRvK8rwHMeWBaHr
 GeHV06s9cjcJ9RmP7236kt/8qftkutJwpOim3lBB91MBP7wGFNDfm93v4H/RhhVGdJ
 engtSiDiM25LK/76/c91YcdbG7gLhKfoWbX0xYJ9yXKPSdZSIkE/iJvgzEyoh/mZSa
 eq+kwGSRurDnwFQkhdW5JoTebDEyxT4VPsVphFY07H+5z8u5E1Oq2C0Qv616CveeMB
 A1G5nKWiDwy0g==
Message-ID: <sashiko-outbox-199703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 20/83] drm/ingenic: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-20-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-20-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 18:12:23 +0000
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
- [Medium] drm/ingenic: drm_mode_config_create_initial_state() called befor=
e private_obj
--

commit 7ffae382d87f4623df938c8f5b08713c0f72e24e
Author: Maxime Ripard <mripard@kernel.org>

drm/ingenic: Switch to drm_mode_config_create_initial_state

This commit replaces the probe-time call to drm_mode_config_reset() in
ingenic_drm_bind() with drm_mode_config_create_initial_state() and checks
its return value.

> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/=
ingenic/ingenic-drm-drv.c
> index 625ec76cf04d8..63198fd594984 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1354,7 +1354,9 @@ static int ingenic_drm_bind(struct device *dev, boo=
l has_components)
>  		goto err_drvdata;
>  	}
> =20
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		goto err_drvdata;

[Severity: Medium]
Should drm_mode_config_create_initial_state(drm) be called after
priv->private_obj is initialized with drm_atomic_private_obj_init(), or
should drm_atomic_private_obj_init() be moved before this call?

In drivers/gpu/drm/drm_mode_config.c, drm_mode_config_create_initial_state()
iterates over dev->mode_config.privobj_list to allocate the initial state f=
or
registered private objects and propagate any allocation error:

drivers/gpu/drm/drm_mode_config.c:drm_mode_config_create_initial_state() {
	drm_for_each_privobj(privobj, dev) {
		struct drm_private_state *privobj_state;

		if (privobj->state)
			continue;

		if (!privobj->funcs->atomic_create_state)
			continue;

		privobj_state =3D privobj->funcs->atomic_create_state(privobj);
		if (IS_ERR(privobj_state))
			return PTR_ERR(privobj_state);

		privobj->state =3D privobj_state;
	}
	...
}

In drivers/gpu/drm/ingenic/ingenic-drm-drv.c, ingenic_drm_bind() currently
initializes priv->private_obj later in the function without checking its
return value:

drivers/gpu/drm/ingenic/ingenic-drm-drv.c:ingenic_drm_bind() {
	...
	ret =3D drm_mode_config_create_initial_state(drm);
	if (ret)
		goto err_drvdata;
	...
	drm_atomic_private_obj_init(drm, &priv->private_obj,
				    &ingenic_drm_private_state_funcs);
	...
}

Because priv->private_obj is not yet on drm->mode_config.privobj_list when
drm_mode_config_create_initial_state(drm) runs, it is skipped. If
ingenic_drm_create_state() fails with -ENOMEM during
drm_atomic_private_obj_init() (or once drm_atomic_private_obj_init() stops
allocating state directly), priv->private_obj is left on
drm->mode_config.privobj_list with priv->private_obj.state set to NULL.
When the first atomic commit duplicates the private state (for example via
drm_client_setup()), ingenic_drm_duplicate_state() will dereference NULL:

drivers/gpu/drm/ingenic/ingenic-drm-drv.c:ingenic_drm_duplicate_state() {
	struct ingenic_drm_private_state *state =3D to_ingenic_drm_priv_state(obj-=
>state);

	state =3D kmemdup(state, sizeof(*state), GFP_KERNEL);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D20
