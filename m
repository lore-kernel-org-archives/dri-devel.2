Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17455606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L/p45r2o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FBB10FFF1;
	Thu,  5 Nov 2026 20:44:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680B010F92D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:44:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2375442E5B;
 Thu,  5 Nov 2026 20:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41591F0089F;
 Thu,  5 Nov 2026 20:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793911446;
 bh=5MhqbY67A44nCefpa5ELa+giN176gkMnyGQbrMOGMEU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L/p45r2oaMY6KWAz+PaAI5fLTcm1m90D4q4mAYW8MfxnLt0NegL26ZpaJsU0TRb3W
 2MiOQ3ED0H+DFI2wJ8GdSrMt80LoNpCgyJzlcW6Glu+GrXX4SaOTVcSOq/y1EOQUlR
 A/t/R1t5gZWEvku4Fw3ojaiLYd2t0HSLjJZUAS+iLGGyGKVqiGClG8jyCgyDY0mZXY
 sjRUkrq+VUC92MjBu5ylIm0jXNKQoJkss+YVDcr1SBRy+lrv9vRzyoF19przLUfrij
 KsjO8UIbbg0B2ENgxAjBjKagPEx/jdvwuBVtQzJmGChWqtcggA2ThdERMM6na1k/T7
 VvpQi29frZawg==
Message-ID: <sashiko-outbox-200128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] GPU: drm: nouveau: Prevent kernel oops on missing
 firmware binary
To: "Jonathan Kuehn" <jonathan.kuehn@aol.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105202757.28703-1-jonathan.kuehn@aol.com>
References: <20261105202757.28703-1-jonathan.kuehn.ref@aol.com>
 <20261105202757.28703-1-jonathan.kuehn@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:44:05 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/nouveau: redundant gr NULL check in nvkm_gr_units() after ca=
ller fix
--

commit f535382c50460cf93f6d91dd265e009e3ef99a0a
Author: Jonathan Kuehn <jonathan.kuehn@aol.com>

GPU: drm: nouveau: Prevent kernel oops on missing firmware binary

This commit adds a NULL check for the gr pointer in nvkm_gr_units() to avoid
a NULL pointer dereference when querying NOUVEAU_GETPARAM_GRAPH_UNITS with
missing firmware binaries.

>     GPU: drm: nouveau: Prevent kernel oops on missing firmware binary
>    =20
>     Prevent null pointer dereference at the call of
>     nouveau_abi16_ioctl_getparams with parameter
>     NOUVEAU_GETPARAM_GRAPH_UNITS when firmware binaries are missing.
>     Fixes crash for certain user-space applications (steamwebhelper,
>     signal-desktop).
>    =20
>     Signed-off-by: Jonathan Kuehn <jonathan.kuehn@aol.com>
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/gr/base.c
> index cd4908b1b4dff..9abeb9732406f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c
> @@ -72,7 +72,7 @@ nvkm_gr_tile(struct nvkm_engine *engine, int region, st=
ruct nvkm_fb_tile *tile)
>  u64
>  nvkm_gr_units(struct nvkm_gr *gr)
>  {
> -	if (gr->func->units)
> +	if (gr && gr->func->units)

[Severity: Medium]
Can a NULL gr pointer still reach nvkm_gr_units() here?

Commit f569473c1393 ("drm/nouveau: prevent NULL deref of gr in
GETPARAM_GRAPH_UNITS") already added a NULL check in
nouveau_abi16_ioctl_getparam(), which is the sole caller of nvkm_gr_units()
in the tree:

drivers/gpu/drm/nouveau/nouveau_abi16.c:nouveau_abi16_ioctl_getparam() {
	...
	case NOUVEAU_GETPARAM_GRAPH_UNITS:
		getparam->value =3D gr ? nvkm_gr_units(gr) : 0;
		break;
	...
}

Since nouveau_abi16_ioctl_getparam() already guards against gr being NULL w=
hen
handling NOUVEAU_GETPARAM_GRAPH_UNITS, does adding a second check in
nvkm_gr_units() without updating the caller just duplicate the check with no
change in runtime behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105202757.2870=
3-1-jonathan.kuehn@aol.com?part=3D1
