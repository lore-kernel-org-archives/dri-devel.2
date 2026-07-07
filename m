Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C353C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E45489119;
	Tue,  7 Jul 2026 16:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZT3RP4DF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDED389119
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:06:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A42AD435B5
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0131F000E9;
 Tue,  7 Jul 2026 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440374;
 bh=6PdIgDW7pO5OC2Ajv9Ec4uUXJ17CMAPVBT2YZnPXm0w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZT3RP4DF127mibtfrhqA/yQgJpJ0fv1tOdMVMfx88cWQKZrQBrxH8kQEo+dJnTVXe
 zquMnhC/zSyPBJ+EGG5FU6Q7uX+Z4Tg3z+Xz3ns4F7Gg6iuxiqDDteW1H0q5piCEg7
 o3JAzCoxO5o0dL+h4YfxY8KabDT6yrF5D5ZseMi0uhT+GQRS2SFKprkkfUReig9g2Q
 gJSZHpEHxSzr7VhWdpQo29SfZ1BJh+EmqespCG2nOk/pMeQr1Qi+XL351qGlHrypvG
 6mcQWCyI8ds9jwtsn0Tx3tLlGyzvDunDk4uac2svfkNQ/HbfgBmusDE7PnXabM26pq
 Yhe706TsrVNMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/37] drm/omap: sdi: Switch to atomic bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-32-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-32-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:06:13 +0000
Message-Id: <20260707160614.5D0131F000E9@smtp.kernel.org>
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
- [High] `sdi_bridge_enable` and `sdi_bridge_disable` call sleeping functio=
ns in atomic context.
--

--- Patch [32]: [PATCH v2 32/37] drm/omap: sdi: Switch to atomic bridge cal=
lbacks ---
commit fe567fd05157eb0a22dd0fa9bede0ea86a947f4e
Author: Maxime Ripard <mripard@kernel.org>

drm/omap: sdi: Switch to atomic bridge callbacks

This commit updates the omap sdi bridge to use atomic bridge callbacks inst=
ead
of legacy non-atomic ones. It modifies the enable and disable bridge callba=
cks
to their atomic counterparts and adds atomic state handlers.

> diff --git a/drivers/gpu/drm/omapdrm/dss/sdi.c b/drivers/gpu/drm/omapdrm/=
dss/sdi.c
> --- a/drivers/gpu/drm/omapdrm/dss/sdi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/sdi.c
[ ... ]
> -static void sdi_bridge_enable(struct drm_bridge *bridge)
> +static void sdi_bridge_enable(struct drm_bridge *bridge,
> +			      struct drm_atomic_commit *commit)
>  {
>  	struct sdi_device *sdi =3D drm_bridge_to_sdi(bridge);
>  	struct dispc_clock_info dispc_cinfo;

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to system
deadlocks by calling sleeping functions from an atomic context?

By wiring this to the atomic_enable callback, it is now executed in the
atomic commit tail path where sleeping is forbidden. Looking at the contents
of sdi_bridge_enable(), it calls:

	r =3D regulator_enable(sdi->vdds_sdi_reg);
	if (r)
		return;

	r =3D dispc_runtime_get(sdi->dss->dispc);

Both regulator_enable() (which acquires a mutex) and dispc_runtime_get()
(which calls pm_runtime_get_sync()) can sleep.

[ ... ]
> -static void sdi_bridge_disable(struct drm_bridge *bridge)
> +static void sdi_bridge_disable(struct drm_bridge *bridge,
> +			       struct drm_atomic_commit *commit)
>  {
>  	struct sdi_device *sdi =3D drm_bridge_to_sdi(bridge);

[Severity: High]
This is a pre-existing issue, but does switching this function to be an
atomic callback introduce sleeping in atomic context warnings here as well?

Similar to the enable path above, sdi_bridge_disable() calls:

	dispc_runtime_put(sdi->dss->dispc);

	regulator_disable(sdi->vdds_sdi_reg);

Could these sleeping functions trigger kernel warnings when called during
display atomic modeset operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D32
