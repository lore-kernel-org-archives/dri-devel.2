Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9DBC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 19:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B28B910E818;
	Mon, 31 Aug 2026 19:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YO4V6WjJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A3910E818
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:31:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4846A601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 19:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C0F1F000E9;
 Mon, 31 Aug 2026 19:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788204673;
 bh=GMUkLy9MMovLUBCW1EjwPW8tvpfn5z3f/1esx7mK0c8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YO4V6WjJdluhrAmiXDh5Dqor+oQsKZZpikDgbCfhxA47EGJ7WTnezHXIFS/VAsard
 JqxS0HEvpMV7K4EAZ0mAsH6q6A2B6YpGL9YUQ74USC3f4y5TvHgwWMHAt1ofXHo8Pk
 9jPnBVKUH8ZhbyN8Q7Q2NCKjzJyu9u6eCQ3B6UEeFSQHSo6Goz1lPuHrRQ1ornf3KP
 dM1WMSAj2qtyPyPAWfrHpz45go3ooYVCvbTRirna7eRwH5zkAj4VhouVooHfNJJpol
 YtPDKYy/Y8n3ogd9WSui5aQfu9faFfj5WzDRaWEa5XFC1N+5nPvpE9P9cNWXkcALFu
 fUTWBjQuHbk2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/40] drm/hisilicon/kirin: Convert to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-6-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-6-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:31:12 +0000
Message-Id: <20260831193112.C7C0F1F000E9@smtp.kernel.org>
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
- [High] Use-After-Free during driver cleanup due to premature freeing of D=
RM mode objects embedded in `struct kirin_drm_private`.
--

commit 263cd9f02efa601fc3d304e38a61e0c61ac2a73e
Author: Maxime Ripard <mripard@kernel.org>

drm/hisilicon/kirin: Convert to atomic_create_state

The plane only initializes a pristine state in its reset hook
using drm_atomic_helper_plane_reset(), which is equivalent to what
atomic_create_state expects. Convert to it.

[ ... ]

> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gp=
u/drm/hisilicon/kirin/kirin_drm_ade.c
> index 5f4e738bc94e3..bca839dd600bd 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -837,7 +837,7 @@ static struct drm_plane_funcs ade_plane_funcs =3D {
>  	.update_plane	=3D drm_atomic_helper_update_plane,
>  	.disable_plane	=3D drm_atomic_helper_disable_plane,
>  	.destroy =3D drm_plane_cleanup,
> -	.reset =3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,
>  	.atomic_duplicate_state =3D drm_atomic_helper_plane_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_plane_destroy_state,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the kirin DRM
driver, I noticed a pre-existing use-after-free issue during driver cleanup.

In drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c,
kirin_drm_private_cleanup() frees the memory backing the DRM planes and CRT=
Cs:

drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c:kirin_drm_private_cleanup()=
 {
    ...
	devm_kfree(dev->dev, kirin_priv);
    ...
}

However, both the initialization error path and the unbind path call this
cleanup before drm_mode_config_cleanup():

drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c:kirin_drm_kms_init() {
    ...
err_private_cleanup:
	kirin_drm_private_cleanup(dev);
err_mode_config_cleanup:
	drm_mode_config_cleanup(dev);
    ...
}

The same pattern appears in the unbind path:

drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c:kirin_drm_kms_cleanup() {
    ...
	kirin_drm_private_cleanup(dev);
	drm_mode_config_cleanup(dev);
    ...
}

Can this lead to a use-after-free? When drm_mode_config_cleanup() executes,=
 it
iterates over dev->mode_config.plane_list and accesses the plane objects
embedded in the kirin_priv structure that was just freed by devm_kfree().

Additionally, since the structure is devm-managed, could userspace holding =
the
DRM file descriptor open trigger a use-after-free if the DRM core accesses =
the
freed objects after unbind completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D6
