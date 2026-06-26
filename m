Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D89AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAAB110F643;
	Fri, 26 Jun 2026 15:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q5aAQAAi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98AF810F643
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:03:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 81C2242DA2;
 Fri, 26 Jun 2026 15:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3269C1F000E9;
 Fri, 26 Jun 2026 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486188;
 bh=9soYU7noPvxoZ3QZgn3D8pAdS1VvkbZ2DnOzV4x0JxM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q5aAQAAibRT2JRyrSbIAONZZ6tKayN1U9feHIZBCjhFGnzvWvx4lhvd2F8tYx9m8g
 SAg5kMe7bMyDIjAK3rNkSB9qVn/KhA5bzlqzwhgTvaFZsazk7lSp/Y0RDz5e/0Kx79
 Px2Euts0tkUhN4rJOcF17p4E6oOb3QrjnwQDWakWMseh/nBBnAtKYn31jg89q+02VE
 QTNLFT+b0vOshN+1eK1ENPHWb9T412m2/WnoQrL/zsS6T2Qm27X7DaS4XTstphai4c
 pyiLyZhtXXoFgiqT6OZPFoproB7aT/PPd5hxJoNFciTYxoy8zWZmeU8c83ontT1XvQ
 03/eo4Iv1bhfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/tegra: tegra_dc_pin: chunks>1 error path leaks
 current mapping   from host1x_bo_pin
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626144958.49221-1-vulab@iscas.ac.cn>
References: <20260626144958.49221-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:03:07 +0000
Message-Id: <20260626150308.3269C1F000E9@smtp.kernel.org>
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
- [High] Multiple resource leaks (buffer object references and DMA mappings=
) on error paths in pin_job().
--

commit 6076ffab64411b3ea0b629afb57e0a62e382c1ba
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/tegra: tegra_dc_pin: chunks>1 error path leaks current mapping fro=
m host1x_bo_pin

This commit fixes a memory leak in the tegra_dc_pin() function where an
error triggered by map->chunks > 1 causes the function to jump to the
unpin label before storing the current mapping. The unpin loop only cleans
up previously pinned planes, leaving the current mapping unreleased.

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
This isn't a bug introduced by this patch, but I noticed similar pre-existi=
ng
issues in drivers/gpu/host1x/job.c:pin_job() while looking at this fix.

In the relocs loop of pin_job():

		map =3D host1x_bo_pin(dev, bo, direction, NULL);
		if (IS_ERR(map)) {
			err =3D PTR_ERR(map);
			goto unpin;
		}

		if (map->chunks > 1) {
			err =3D -EINVAL;
			goto unpin;
		}

If map->chunks > 1, does this jump to unpin and leak the newly created map
since it hasn't been added to job->unpins yet?=20

Additionally, do both of these error paths leak the bo reference acquired
earlier via host1x_bo_get() since host1x_job_unpin() won't release it?

Similarly, in the gathers loop of pin_job():

		map =3D host1x_bo_pin(host->dev, g->bo, DMA_TO_DEVICE, NULL);
		if (IS_ERR(map)) {
			err =3D PTR_ERR(map);
			goto unpin;
		}

Does jumping to unpin here bypass the put: label, failing to release the
g->bo reference?

And a little further down in the gathers loop:

			alloc =3D alloc_iova(&host->iova, gather_size >> shift,
					   host->iova_end >> shift, true);
			if (!alloc) {
				err =3D -ENOMEM;
				goto put;
			}

			err =3D iommu_map_sgtable(host->domain, iova_dma_addr(&host->iova, alloc=
),
						map->sgt, IOMMU_READ);
			if (err =3D=3D 0) {
				__free_iova(&host->iova, alloc);
				err =3D -EINVAL;
				goto put;
			}

When these error paths jump to put:, do they correctly release g->bo but
fail to unpin the map created just above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626144958.4922=
1-1-vulab@iscas.ac.cn?part=3D1
