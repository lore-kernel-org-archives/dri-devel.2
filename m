Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1856C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD3410E0B8;
	Fri, 14 Aug 2026 03:22:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NGahWd6S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05F510E0B8
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:22:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A4A27436CE
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1C71F000E9;
 Fri, 14 Aug 2026 03:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786677745;
 bh=7N7nDb7y6zIEtnIc7iqHOUE/47UB8zo9Mm+AOZndLm8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NGahWd6S37aB9ZJ1P5NVLWZP2bjOkZBt+2wvReXuze4Bj1c5dxexTiR1H9iLi/5aP
 EmyLTf9Oqi+JoIE10SXkcJ6mbTFiJB8MHxqXGwUkIYKbLdzH77gv2L0a3PyrveYzSS
 gsS1tFrOUpvcunUeDRijZOlBwWwUx4WSmKS6wakqRYA6AvuuKROoT6QEbHcI1buHnm
 CsCDrllW1RebxyGIdK8Op0WaiGggj83wQj/bi9GpRdHkgtIzFR+eAxS1fjX83PduZ+
 QHSR8vCXJ64kuzSQv4dGBcTii3kyi0g7IW4U+tWW87WCtQK172jIiFmS6d0PFgjzG0
 VzINcM+gbyZvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 77/78] drm/bridge: cdns-mhdp8546: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-77-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-77-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 03:22:20 +0000
Message-Id: <20260814032225.5C1C71F000E9@smtp.kernel.org>
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
- [High] The driver fails to duplicate subclass-specific state fields (`cur=
rent_mode`) in `atomic_duplicate_state` and improperly mutates state during=
 `atomic_enable`, leading to data loss and HPD failures on non-modeset comm=
its.
--

--- Patch [77]: [PATCH v2 77/78] drm/bridge: cdns-mhdp8546: Switch to atomi=
c_create_state ---
commit 1fdd589deb947ec0da52f0a1985e0d7446f7455f
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: cdns-mhdp8546: Switch to atomic_create_state
   =20
The cdns-mhdp8546 bridge atomic_reset implementation is semantically
an atomic_create_state: it allocates and initializes a pristine state
without side effects.

Switch to the atomic_create_state callback, and rename the function
accordingly.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index b9574289c247f..504a3186ebb3a 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -2051,7 +2051,7 @@ static const struct drm_bridge_funcs cdns_mhdp_brid=
ge_funcs =3D {
>  	.detach =3D cdns_mhdp_detach,
>  	.atomic_duplicate_state =3D cdns_mhdp_bridge_atomic_duplicate_state,
>  	.atomic_destroy_state =3D cdns_mhdp_bridge_atomic_destroy_state,
> -	.atomic_reset =3D cdns_mhdp_bridge_atomic_reset,
> +	.atomic_create_state =3D cdns_mhdp_bridge_atomic_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential problem
with how bridge state duplication is handled in
cdns_mhdp_bridge_atomic_duplicate_state().

When a non-modeset commit (like a cursor update) duplicates the state,
cdns_mhdp_bridge_atomic_duplicate_state() allocates a new state but fails to
copy the current_mode pointer from the old state.=20

Because it's a non-modeset commit, cdns_mhdp_atomic_enable() (which mutates
the state by setting current_mode) is not invoked. This leaves current_mode
as NULL in the new state, while the old state is destroyed and its
current_mode is freed.

Could this cause hotplug detection and link re-training to fail later when
cdns_mhdp_update_link_status() is triggered, since it encounters the NULL
current_mode and aborts?

>  	.atomic_get_input_bus_fmts =3D cdns_mhdp_get_input_bus_fmts,
>  	.detect =3D cdns_mhdp_bridge_detect,
>  	.edid_read =3D cdns_mhdp_bridge_edid_read,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D77
