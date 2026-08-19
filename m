Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA29DC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421B310EE65;
	Wed, 19 Aug 2026 16:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RTpn6+02";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D7910EE65
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:14:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B94160A92;
 Wed, 19 Aug 2026 16:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991131F000E9;
 Wed, 19 Aug 2026 16:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787156049;
 bh=Bw6mQUgWH3lmzjLBKoqtFhFSTWDy8KWfreg/eDbl4SQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RTpn6+02fmDBYeUN/BKhxifgN5mw7Ay25oOvwolqHsZOCb4j1jn9Jf8Qp9lWoSCML
 pGsbmuzUv8C3XmfH6nC5Z/wT8PNpw27EY9wBXqr/6LwVUFhcwfpEInn7G1P1ZMfUhX
 Jy3EYi/QivEnaOFiJxdC/QPROC6d8xtq+HigZuAO3gezkz2L4E6UzErkUl+5/7EvEU
 EIqQFOkXKUIphvY5DcUZFwkVTJhIFlPyqNYMt32+TONG70SSDGsJW/bQy4pvWrJ6C9
 1EzQ6FOojyqG9Vm+3si8qx9tKsqMv62NTdQ9G0eJ32dJuEBQ6/cjmDSswEtwGW1SO5
 7+HG09PUT5A0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight
 disable into its own function
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819155934.154125-2-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
 <20260819155934.154125-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 16:14:09 +0000
Message-Id: <20260819161409.991131F000E9@smtp.kernel.org>
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
- [High] The encoder atomic disable callback invokes sleeping functions via=
 the backlight disable helper.
--

--- Patch [1]: [PATCH v2 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight di=
sable into its own function ---
commit a6ddaa482a749f2e2d18fe83acb2593aeea89961
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Move DPCD backlight disable into its own function

This commit extracts the DPCD backlight disable logic from the
nv50_sor_atomic_disable() callback into its own separate helper function.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1561,24 +1561,39 @@ nv50_sor_update(struct nouveau_encoder *nv_encode=
r, u8 head,

[ ... ]

> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +static inline void
> +nv50_sor_atomic_disable_backlight(struct nouveau_drm *drm,
> +				  struct nouveau_encoder *nv_encoder,
> +				  struct drm_atomic_commit *state)
> +{

[ ... ]

> +	ret =3D drm_edp_backlight_disable(&nv_connector->aux, &backlight->edp_i=
nfo);
> +	if (ret < 0)
> +		NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
> +			 nv_connector->base.base.id, nv_connector->base.name, ret);
> +}
> +#endif
> +
>  static void
>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_c=
ommit *state)
>  {

[ ... ]

> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> +	nv50_sor_atomic_disable_backlight(nouveau_drm(state->dev), nv_encoder, =
state);
>  #endif

[Severity: High]
This is a pre-existing issue, but extracting this logic into a helper
highlights a potential problem with the calling context.

Does this call chain execute a sleeping operation while in an atomic contex=
t?

The encoder atomic_disable callback runs in an atomic context where sleeping
is forbidden. However, nv50_sor_atomic_disable() invokes
nv50_sor_atomic_disable_backlight(), which then calls
drm_edp_backlight_disable().

The drm_edp_backlight_disable() function performs DP AUX transactions that
acquire aux->hw_mutex and wait for hardware responses, which are sleeping
operations.

Could this lead to scheduling while atomic warnings or potential deadlocks
during display mode settings, monitor sleep, or teardown on hardware using
DPCD backlights?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819155934.1541=
25-1-lyude@redhat.com?part=3D1
