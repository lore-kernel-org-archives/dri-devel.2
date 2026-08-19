Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7106BC5DF7D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D748810E041;
	Wed, 19 Aug 2026 00:07:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W5489Kht";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E0610E041
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:07:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 46ADD601DE;
 Wed, 19 Aug 2026 00:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19471F000E9;
 Wed, 19 Aug 2026 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787098041;
 bh=48FE3r+QonZbmUQBtsQ5unKf/Ly9dKoOdjJk4e/1/KQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W5489KhtISxp8+HBambUfvR3P7L8poFH1tDPK85MuRJI0Hu41k98uKG/JLEwHjE3i
 bPXAUnZdIDXvGXFzr9NgjrbweGpc8yD2wtGuLoFeywD0nU3bfjHnOV/fi44mBoCUFT
 swYdI8LTXiIUa1Qr3tFU16TD1+kZOMA4Ur3o+FIIU1jqNIwzpJuZfLv82NARjm8e+/
 rxsao0wgL6QuZqZNP8ZqfVUF+o5cyh9eNwdKLuV8PSbByPsfmqPqvnCkOivS3Y3WeJ
 KQgzadFZUhP4JUntMfHGY1EJqyzwyZSOjZZFyTdZ9+vEG9B568AicTc/so3fkWCpS2
 T9C16tC38CmGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight disable
 into its own function
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818235637.1738055-2-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
 <20260818235637.1738055-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 00:07:20 +0000
Message-Id: <20260819000720.D19471F000E9@smtp.kernel.org>
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
- [High] Calling the sleeping function `drm_edp_backlight_disable()` from w=
ithin the `nv50_sor_atomic_disable` encoder atomic disable callback violate=
s DRM atomic context rules. This problem wasn't introduced by this patch, b=
ut the logic was moved into the new `nv50_sor_atomic_disable_backlight()` i=
nline function.
--

--- Patch [1]: [PATCH 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight disab=
le into its own function ---
commit a8a2b3da8fed6e6d5dafbcd1c4a9bb461b74def0
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Move DPCD backlight disable into its own function

This commit moves the DPCD backlight disable logic into its own separate
inline helper function. Aside from using the state device to access the
drm device, no functional changes are introduced.

Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) chec=
ks in ->disable callbacks")
Cc: <stable@vger.kernel.org> # v5.12+

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[ ... ]
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +static inline void
> +nv50_sor_atomic_disable_backlight(struct nouveau_drm *drm,
> +				  struct nouveau_encoder *nv_encoder,
> +				  struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (!backlight || !backlight->uses_dpcd)
> +		return;
> +
> +	ret =3D drm_edp_backlight_disable(&nv_connector->aux, &backlight->edp_i=
nfo);

[Severity: High]
This is a pre-existing issue, but moving the logic into
nv50_sor_atomic_disable_backlight() preserves a potentially problematic
sleeping call in an atomic context.

Is it safe to call drm_edp_backlight_disable() from this path?

Because nv50_sor_atomic_disable_backlight() is invoked by the encoder atomic
disable callback nv50_sor_atomic_disable(), it executes in an atomic context
where sleeping is forbidden.

The drm_edp_backlight_disable() helper performs DPCD transactions over the
AUX channel. These transactions require taking a hardware mutex and can
sleep or block while waiting for hardware responses.

Could this lead to scheduling while atomic kernel warnings or potential
deadlocks during display disables or modesets?

> +	if (ret < 0)
> +		NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
> +			 nv_connector->base.base.id, nv_connector->base.name, ret);
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818235637.1738=
055-1-lyude@redhat.com?part=3D1
