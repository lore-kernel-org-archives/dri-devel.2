Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E4606EE87
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FyyalHoT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8CAE10E13E;
	Thu,  5 Nov 2026 20:08:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1282610F908
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:08:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C7EB60232
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07BB1F0089F;
 Thu,  5 Nov 2026 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793909279;
 bh=4q4s7pWDPbbZ69TJ3Vj/VJgX9F4fGTs8z7uMX0gVhmg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FyyalHoTOP5FBBJe8rlJCW+k7POovHM/SN0FSgGb1TciJDlXePENw5Z+6crQLNsBM
 9wIW05yP0c7qRr/+z8mX5+vzSKZHe1gl1pdnxRwv6kn9EmhW5Z4ekG7NCtEk0emPHc
 p197S7OxXVEmti/cqbVtNofTv1JSEF4LSiN1CAFLp34WUvVsqmr7lJ219NRmEi4OR8
 a/EpjBZDINwx5D6T/psict82biBlQ5cmXwZZtYELuqvyl76PlWdVbnN/Ux20VeiD+S
 xk4HcWeGoPqUSYkqP+D6iROuj7Wo+YCdhcAQ2jMPJlQO1nIMCd/GLJRp8PyVJ813dM
 RbRg69iOzUt2g==
Message-ID: <sashiko-outbox-200075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 45/83] drm/sti: Switch to
 drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-45-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-45-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:07:59 +0000
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
- [High] drm/sti: late initial state creation and broken error unwind in st=
i_bind()
--

commit 90a65d66556bc446b84f7842f4301480a5997e74
Author: Maxime Ripard <mripard@kernel.org>

drm/sti: Switch to drm_mode_config_create_initial_state

This commit replaces the call to drm_mode_config_reset() in sti_bind() with
drm_mode_config_create_initial_state() and adds an error path to unregister
the DRM device if initial state creation fails.

> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index d02d71866f2a9..0ca6c6b41f18d 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -202,12 +202,16 @@ static int sti_bind(struct device *dev)
>  	if (ret)
>  		goto err_cleanup;
> =20
> -	drm_mode_config_reset(ddev);
> +	ret =3D drm_mode_config_create_initial_state(ddev);
> +	if (ret)
> +		goto err_unregister;
> =20
>  	drm_client_setup(ddev, NULL);
> =20
>  	return 0;
> =20
> +err_unregister:
> +	drm_dev_unregister(ddev);
>  err_cleanup:
>  	sti_cleanup(ddev);

[Severity: High]
If drm_mode_config_create_initial_state() fails in sti_bind() (for example,
when plane or CRTC state allocation fails with -ENOMEM), jumping to
err_unregister and falling through to err_cleanup calls sti_cleanup():

drivers/gpu/drm/sti/sti_drv.c:sti_cleanup() {
	...
	drm_kms_helper_poll_fini(ddev);
	drm_atomic_helper_shutdown(ddev);
	drm_mode_config_cleanup(ddev);
	...
}

Because crtc->state is still NULL when initial state creation fails before
allocating CRTC states (or when drm_dev_register() fails before initial sta=
te
creation is reached), does calling
sti_cleanup() -> drm_atomic_helper_shutdown() ->
drm_atomic_helper_disable_all() -> drm_atomic_get_crtc_state() ->
drm_atomic_helper_crtc_duplicate_state() trigger a WARN_ON(!crtc->state) and
cause drm_atomic_helper_shutdown() to fail?

In addition, in sti_bind(), drm_dev_register() is called right before
drm_mode_config_create_initial_state():

drivers/gpu/drm/sti/sti_drv.c:sti_bind() {
	...
	ret =3D drm_dev_register(ddev, 0);
	if (ret)
		goto err_cleanup;

	ret =3D drm_mode_config_create_initial_state(ddev);
	if (ret)
		goto err_unregister;
	...
}

Since drm_dev_register() exposes the DRM device nodes and connector sysfs
attributes to userspace while plane->state, crtc->state, and
connector->state are still NULL, and drm_mode_config_create_initial_state()
subsequently populates those state pointers without holding modeset locks,
can a userspace process opening the device right after registration trigger
a NULL pointer dereference in drm_mode_object_get_properties() ->
drm_atomic_get_property()?

Should drm_mode_config_create_initial_state() be called before
drm_dev_register(), and should drm_atomic_helper_shutdown() be avoided on
error paths where initial modeset state has not been fully created?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D45
