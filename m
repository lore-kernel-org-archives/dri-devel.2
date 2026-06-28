Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DE3C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:11:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B3B10E639;
	Sun, 28 Jun 2026 15:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T/n/3x2W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60F010E639
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:11:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4DA5043780;
 Sun, 28 Jun 2026 15:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C81C1F000E9;
 Sun, 28 Jun 2026 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659500;
 bh=IDNaMDbZkL2+3AMR66UcrD3jaYziAuRa26pQZJSLqcg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T/n/3x2WVZ+2gFrRl5IV+0rFU1shAVlgAskoohXzdHzQ27UTXBY/5/dK8DSKQtVA8
 O6uxW31I2rO+LH5WP1rZ02FKbprKRVZIrLzfL8hvztGn1om5Vk1ljySsil/RvN+ZfU
 4Opa9FxXDFWkNk44x3bs7ZTpJj6/LUi+5272hfHEgUA11FKyR+n7P72a8BeDvHezYk
 Z2svBc85TIX7rijm7z0AOfNR9FmUU0u5OkWnOde5v6JpgWTDpPOMRPiFxumo5qHKqq
 Agygq1q8XO5xBi0xGgXrYGnoZNZjb4MXmlhTdbVJWuB9bl5i0RqqXuxjrV4UgqDR8I
 W0PVRywFKI1ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin
 error path
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628150228.47948-1-vulab@iscas.ac.cn>
References: <20260628150228.47948-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:11:39 +0000
Message-Id: <20260628151140.0C81C1F000E9@smtp.kernel.org>
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
- [High] Resource leak (BO references and map objects) in pin_job error pat=
hs.
--

commit 385c1315fdf5345a4727ff1380f8b72577ca3566
Author: WenTao Liang <vulab@iscas.ac.cn>

    drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin error path
   =20
    When map->chunks > 1 triggers an error, the function jumps to unpin
    before storing the current map in state->map[i]. The unpin loop only
    cleans up previously pinned planes (indices 0 through i-1), so the
    current mapping returned by host1x_bo_pin is never released via
    host1x_bo_unpin.
   =20
    Suggested-by: Greg KH <gregkh@linuxfoundation.org>
    Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
    Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
> index ffe5f06b770dc..e0b146a0926e7 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -161,6 +161,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct t=
egra_plane_state *state)
>  			 */
>  			if (map->chunks > 1) {
>  				err =3D -EINVAL;
> +				host1x_bo_unpin(map);
>  				goto unpin;
>  			}
> =20

[Severity: High]
This is a pre-existing issue, but the exact same resource leak pattern exis=
ts
in drivers/gpu/host1x/job.c:pin_job().

If host1x_bo_pin() fails, or if map->chunks > 1, the function jumps to the
unpin label:

drivers/gpu/host1x/job.c:pin_job() {
    ...
		reloc->target.bo =3D host1x_bo_get(reloc->target.bo);
		...
		bo =3D reloc->target.bo;
		...
		map =3D host1x_bo_pin(dev, bo, direction, NULL);
		if (IS_ERR(map)) {
			err =3D PTR_ERR(map);
			goto unpin;
		}

		/* ... */
		if (map->chunks > 1) {
			err =3D -EINVAL;
			goto unpin;
		}
    ...
}

Because the acquired bo and map have not yet been added to the job->unpins
array, host1x_job_unpin() will not clean them up. This leaks the bo referen=
ce
if host1x_bo_pin() fails, and leaks both the bo reference and the map if
map->chunks > 1.

Similarly, later in the same function during gather BO processing, if the I=
OVA
allocation fails:

drivers/gpu/host1x/job.c:pin_job() {
    ...
			alloc =3D alloc_iova(&host->iova, gather_size >> shift,
					   host->iova_end >> shift, true);
			if (!alloc) {
				err =3D -ENOMEM;
				goto put;
			}
    ...
}

Jumping to put releases g->bo, but leaks the already created map because it
was not added to job->unpins.

Could similar cleanup logic be added to the error paths in pin_job() to
prevent these memory leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628150228.4794=
8-1-vulab@iscas.ac.cn?part=3D1
