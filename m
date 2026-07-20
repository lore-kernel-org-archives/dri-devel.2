Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35635C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B43210E2B1;
	Mon, 20 Jul 2026 15:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DcveVqC7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D320E10E2B1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F64C60254;
 Mon, 20 Jul 2026 15:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773541F000E9;
 Mon, 20 Jul 2026 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784562858;
 bh=h4FtL+GwCY7Mo+W4nkJ1CUNyHo99Pgq0iuKUvWe5hNE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DcveVqC7Fgu3NEKvExRHo/w/gxLBE1kaLqLiFg1uNuhrCYPCD78scfcOdN6DIzVEB
 Svw5cGQvBNW+Yfvr+RHLA5T8UzhpTX2oPn1wT1SKPJKl9dLd6tdwDoqEgtRjWoJ2v5
 fCDLPchrOSFks4mpbuCW6E1iYo63m3GLApCauvxx8ORdIOHvX0C63Ex8tFdjASzE3A
 fEf4VRqIwjtPNk4XYZ5N5HVTVoz7O7a08PDoLEG9CKEzAYe3PtwnSU1Eb8X2o4SC07
 /rqW/i+42Hp1Zu+N3H4Es3ndto56dbneUc0Kus8tzUqb24C+rDPzZLkcttl8FdF+N5
 M9lEpBET7OPyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] drm/drm_simple: remove deprecated
 drm_simple_encoder_init function
To: "Diogo Silva" <diogompaissilva@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, wsa+renesas@sang-engineering.com,
 neil.armstrong@linaro.org
In-Reply-To: <20260720-drm_simple_encoder_init-v2-14-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
 <20260720-drm_simple_encoder_init-v2-14-5020b630668a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:54:18 +0000
Message-Id: <20260720155418.773541F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Removing drm_simple_encoder_init() breaks the build for the gma500 =
driver, which still has unconverted callers.
- [Low] The task to remove `drm_simple_encoder_init()` is still listed in t=
he GPU TODO list, leaving the documentation stale.
--

--- Patch [14]: [PATCH v2 14/15] drm/drm_simple: remove deprecated drm_simp=
le_encoder_init function ---
commit 017140dd8a05d473cb61f897db90d827140d76fc
Author: Diogo Silva <diogompaissilva@gmail.com>

drm/drm_simple: remove deprecated drm_simple_encoder_init function

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting.

All driver users of drm_simple_encoder_init() have been converted to
drm_encoder_init(). Drop the helper and open-code its remaining internal
use in drm_simple_display_pipe_init() to prevent new users.

> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/dr=
m_simple_kms_helper.c
> index 8e1d07b9f1e30..7878b9d7d5248 100644
> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
> @@ -20,16 +20,6 @@ static const struct drm_encoder_funcs drm_simple_encod=
er_funcs_cleanup =3D {
>  	.destroy =3D drm_encoder_cleanup,
>  };
> =20
> -int drm_simple_encoder_init(struct drm_device *dev,
> -			    struct drm_encoder *encoder,
> -			    int encoder_type)
> -{
> -	return drm_encoder_init(dev, encoder,
> -				&drm_simple_encoder_funcs_cleanup,
> -				encoder_type, NULL);
> -}
> -EXPORT_SYMBOL(drm_simple_encoder_init);

[Severity: Low]
Does removing this helper break the build for the gma500 driver?

The commit message states that all driver users have been converted, but
it looks like the gma500 driver still has unconverted callers.

For example, in drivers/gpu/drm/gma500/cdv_intel_crt.c:cdv_intel_crt_init():

    ret =3D drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);

and in drivers/gpu/drm/gma500/cdv_intel_dp.c:cdv_intel_dp_init():

    drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_TMDS);

Removing the definition and declaration here causes implicit function
declaration and undefined reference errors when building with
CONFIG_DRM_GMA500 enabled.

Also, this isn't a bug, but should the task to remove
drm_simple_encoder_init() be removed from Documentation/gpu/todo.rst
as well, since this patch completes that task?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-drm_simple=
_encoder_init-v2-0-5020b630668a@gmail.com?part=3D14
