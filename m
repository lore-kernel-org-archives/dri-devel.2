Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A89C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0D510E77E;
	Mon, 31 Aug 2026 09:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FIvfOYOD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911F10E77E
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:05:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7CF360120;
 Mon, 31 Aug 2026 09:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F3D1F000E9;
 Mon, 31 Aug 2026 09:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167107;
 bh=OJToWJXDrlRzzZ3w1YKtccTy6w5Wwc5hNTuNv2S2OQI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FIvfOYOD19D6gYwLQHob1S3C81JmhGNJJHJRCb+nLLYaMCZBOimsiBlafTTUoL4Tr
 0FGMwyCkMK+lAgi269Nzcu9DdKvzdR+oKCQkyYrnBuT7PVsuAUAATAtiSjPYLcruFF
 aLh3pG3HY0ohU9DZVyR3WZeDyuIK0PsOIbB2mmi0qCtLyl3xNtmOt3LA5SiYUU+FoS
 9sLKZRqd1VJw5EMuQoxm3xOKKteoBMgRaQQ5uOTc74HCEbMRYLpmcqOg1jGwDzT7uW
 93XDXhISbnL+r1fEtgpDGF2OZZImDqT/zLOB9uuZJtuc3DJcutyZ5Walo7edpHwq7f
 dR1kTeiREnY7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/14] pmdomain/rockchip: cycle optional
 power-domain resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260831081956.84871-11-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-11-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:05:06 +0000
Message-Id: <20260831090507.54F3D1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Resource leak of clock references on of_clk_get failure
- [High] Use-after-free when pm_genpd_remove fails during probe error clean=
up
--

commit c4349e9db6c9eecdba71ab60966e3312c6588638
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain/rockchip: cycle optional power-domain resets on power-on

Some Rockchip domains come out of power-on with their bus interface in
an undefined state. On the RK3576 NPU this shows up as a hang on the
first register access after the domain is switched on, and pulsing the
domain's resets at this point clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains
that do not list any are unaffected.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 39988efd86aaa..8f2fd8a83e8e9 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -861,6 +870,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>  	if (error)
>  		goto err_put_clocks;

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the
clocks on of_clk_get() failure?

Looking at rockchip_pm_add_one_domain(), just above this code:

	for (i =3D 0; i < pd->num_clks; i++) {
		pd->clks[i].clk =3D of_clk_get(node, i);
		if (IS_ERR(pd->clks[i].clk)) {
			error =3D PTR_ERR(pd->clks[i].clk);
			dev_err(pmu->dev,
				"%pOFn: failed to get clk at index %d: %d\n",
				node, i, error);
			return error;
		}
	}

If a PM domain has multiple clocks defined in its device tree node, and
of_clk_get() succeeds for the first clock(s) but fails for a subsequent
clock (e.g., returning -EPROBE_DEFER), the function returns the error
directly without calling clk_put() on the successfully acquired clocks.

Could this direct return bypass the err_put_clocks cleanup path and leak
the clocks acquired in previous loop iterations?

> +	pd->resets =3D of_reset_control_array_get_optional_exclusive(node);
> +	if (IS_ERR(pd->resets)) {
> +		error =3D dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
> +				      "%pOFn: failed to get resets\n", node);
> +		pd->resets =3D NULL;
> +		goto err_unprepare_clocks;
> +	}
> +
>  	pd->num_qos =3D of_count_phandle_with_args(node, "pm_qos",
>  						 NULL);

[ ... ]

> @@ -949,6 +967,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
> =20
>  	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  	clk_bulk_put(pd->num_clks, pd->clks);

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free when
pm_genpd_remove() fails during probe error cleanup?

In rockchip_pm_remove_one_domain(), right before this code:

	ret =3D pm_genpd_remove(&pd->genpd);
	if (ret < 0)
		dev_err(pd->pmu->dev, "failed to remove domain '%s' : %d - state may be i=
nconsistent\n",
			pd->genpd.name, ret);

If rockchip_pm_add_subdomain() or pm_genpd_provider_add_of() fails,
rockchip_pm_domain_cleanup() iterates over all domains in reg ID order.
If a child domain has a smaller ID than its parent, the child is removed
first. Because its parent link still exists, pm_genpd_remove() returns
-EBUSY and fails to remove the child from the global gpd_list.

Despite the failure, rockchip_pm_remove_one_domain() returns and the
rockchip_pm_domain structure is freed by devm when the probe fails.

Does this leave a pointer to freed memory in the global gpd_list, leading
to a use-after-free when the list is next accessed (e.g., by
genpd_power_off_unused())?

> +	reset_control_put(pd->resets);
> =20
>  	/* protect the zeroing of pm->num_clks */
>  	mutex_lock(&pd->pmu->mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D10
