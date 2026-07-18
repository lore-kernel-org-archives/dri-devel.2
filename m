Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE583C4450A
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 03:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FEA10E4C6;
	Sat, 18 Jul 2026 03:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SLNFk26Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC1210E4C6
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:22:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D198E41FBA;
 Sat, 18 Jul 2026 03:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A161F00A3A;
 Sat, 18 Jul 2026 03:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784344970;
 bh=hZZaorNOsTjlLFz6817wQI6en3+FJJDqncHKkhcqc/4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SLNFk26Y3xme+a2wn9ZAUg+hfgsZ5jFvfalkYp9tqqXDbqJWFqv404to03F6QymGH
 sCfk9O8O/psdzVcGBnR6pf3xUgXDBKeOvtx2a53pQPXwVBVqXqrid1/9Zq6aM3L1tm
 v7+fbs2s0HPzCENM/X2+543iOA9z3w22ZWr6OM/dZvjz9D2yCXH1nIn3Lohax7k849
 YG0QuNgWpEeGdf9DD89lso4ZfAuxqBxUWWFRg1626Q1g131Qq0e8hU5wSYSTcyVV1g
 jYRjPZQLhWjCgovRrBn25bofKva3WqR1e6I0oL2g5B8sJzQirubUl4e+yFzbBA/I8Y
 vIoHq44bLBkrQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/8] pmdomain/rockchip: cycle optional
 power-domain resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260718031146.3368811-4-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 03:22:50 +0000
Message-Id: <20260718032250.62A161F00A3A@smtp.kernel.org>
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
- [Critical] Probe error path fails to remove parent power domains (due to =
subdomain links), leaving freed memory linked in the global genpd list, lea=
ding to a Use-After-Free.
--

--- Patch [3]: [RFC PATCH v2 3/8] pmdomain/rockchip: cycle optional power-d=
omain resets on power-on ---
commit 6b47e7abcdceaeb541eb946e08c3911e47f8d51e
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain/rockchip: cycle optional power-domain resets on power-on

This commit adds support for an optional resets property to the rockchip
power domain driver. Resets are now explicitly asserted and deasserted
during the power-on sequence to ensure the hardware interfaces observe
the necessary reset edge.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 1787f62ba3a81..8ce0cc3de0bfb 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -928,6 +945,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
> =20
>  	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  	clk_bulk_put(pd->num_clks, pd->clks);
> +	reset_control_put(pd->resets);

[Severity: Critical]
This is a pre-existing issue, but does this error path leave freed memory
linked in the global genpd list?

When a probe failure triggers cleanup via rockchip_pm_domain_cleanup(), it
iterates over all domains and calls rockchip_pm_remove_one_domain().

Since subdomain links are not explicitly removed first, pm_genpd_remove()
fails with -EBUSY for parent domains and leaves them linked in the global
gpd_list:

rockchip_pm_remove_one_domain()
    ret =3D pm_genpd_remove(&pd->genpd);
    if (ret < 0)
        dev_err(...) // -EBUSY is caught here but ignored

Because devm will subsequently free the rockchip_pm_domain structure which
embeds the genpd structure, could this lead to a use-after-free later when
the genpd core iterates gpd_list, for instance in genpd_power_off_unused()?

> =20
>  	/* protect the zeroing of pm->num_clks */
>  	mutex_lock(&pd->pmu->mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718031146.3368=
811-1-gahing@gahingwoo.com?part=3D3
