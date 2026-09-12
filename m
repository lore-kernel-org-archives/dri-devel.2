Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9564CC88E45
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D5410E635;
	Sat, 12 Sep 2026 07:04:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NSvOkcrB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9670E10E635
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 07:04:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B7264600D4;
 Sat, 12 Sep 2026 07:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC671F00898;
 Sat, 12 Sep 2026 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789196668;
 bh=4dv41HOpv0fan4sCVCNO2u51UEEvzvPSNfZ78nUngdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NSvOkcrBAAG5P015+DoiE9fkNOydNAoArz6dW2CC4D4GTj0W3CsP5wPPHgm4Ax5j7
 tB+8zb2fnsQ4xXqZP3S3lTPrNGPxm4W+KbVWC2MQYUMA3BGTsct4jI1b6INPpQR1px
 sumiQGyNV81wvGj7PptzsVULCFh09pA8uMikZFy3S4jnDVGB6gD1sC73/WoF2ZJKFp
 /4VXpVChwGIBpU3ZM6X5HO8DKvRr8sJ7lVMax3iV3YIV5AFUZ5+SSQCPebGu4kFV5q
 LHTYnNZ1hOVf7QRLG+BuUTHNdF+R1DqIRCI3ifUSQFTXsw6RkOjt5rXU8oxrAs7gJP
 HhR9h6PFG2mhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/14] pmdomain: rockchip: cycle optional
 power-domain resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260912065053.1519165-11-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
 <20260912065053.1519165-11-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 07:04:27 +0000
Message-Id: <20260912070428.1FC671F00898@smtp.kernel.org>
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
- [High] Massive Use-After-Free of genpd structures if probe fails and pm_g=
enpd_remove() fails during error cleanup.
--

commit 82ba89727b40b24aa0ac406b6e9c71489c988d78
Author: Jiaxing Hu <gahing@gahingwoo.com>

    pmdomain: rockchip: cycle optional power-domain resets on power-on
   =20
    Some Rockchip domains come out of power-on with their bus interface in =
an
    undefined state. On the RK3576 NPU this shows up as a hang on the first
    register access after the domain is switched on, and pulsing the domain=
's
    resets at this point clears it.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -949,6 +975,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
> =20
>  	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  	clk_bulk_put(pd->num_clks, pd->clks);
> +	reset_control_put(pd->resets);
> =20
>  	/* protect the zeroing of pm->num_clks */
>  	mutex_lock(&pd->pmu->mutex);

[Severity: High]
This is a pre-existing issue, but does this error cleanup path leave a freed
structure in the global gpd_list if probe fails?

During error cleanup, rockchip_pm_domain_cleanup() iterates forward through
the domains array:

    for (i =3D 0; i < pmu->genpd_data.num_domains; i++) {
        genpd =3D pmu->genpd_data.domains[i];
        if (genpd) {
            pd =3D to_rockchip_pd(genpd);
            rockchip_pm_remove_one_domain(pd);
        }
    }

Since parent domains typically appear before their children in the array, t=
he
parent is visited first.=20

When rockchip_pm_remove_one_domain() attempts to remove the parent domain,
pm_genpd_remove() fails with -EBUSY because the child is still attached:

    ret =3D pm_genpd_remove(&pd->genpd);
    if (ret < 0)
        dev_err(pd->pmu->dev, "failed to remove domain '%s' : %d...",

The domain is left in the global gpd_list and the function continues without
retrying.

Because rockchip_pm_add_one_domain() allocates the domain structure with
devm_kzalloc():

    pd =3D devm_kzalloc(pmu->dev, sizeof(*pd), GFP_KERNEL);

When probe returns an error, such as -EPROBE_DEFER, devres automatically fr=
ees
the memory backing the parent domain.=20

Can this leave a dangling pointer in the global gpd_list that could trigger=
 a
use-after-free or kernel panic when the list is next traversed, such as
during pm_genpd_poweroff_unused()? Should rockchip_pm_domain_cleanup() be
updated to iterate backwards to ensure children are removed before their
parents?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912065053.1519=
165-1-gahing@gahingwoo.com?part=3D10
