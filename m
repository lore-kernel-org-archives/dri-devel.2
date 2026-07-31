Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3444CC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 04:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C61E10E16E;
	Fri, 31 Jul 2026 04:50:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P7eBy3QL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB0C10E16E
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:50:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37942600C8;
 Fri, 31 Jul 2026 04:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F69B1F000E9;
 Fri, 31 Jul 2026 04:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785473441;
 bh=h9Iqb8ZaO73Qw5N8l705CQy7jr11HI8Y98F6XzwZDQQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P7eBy3QLZUN72+YEjw//NZtQPeDn8yMWKe1r51+WXAuaH3zRFXInl16ND0WZn5NjB
 9io0yPCqEuS0LCkTrLl2rhdmdfATb0YCmICrLSQtcXg+OcSAjJGTVbNDsr22CGtgLi
 DtHXDksEIUCW9U6ExQ5nM1p6Xo1m/Z66M8tUDcjWtiOxvpRK/etvXT3QWaqGYbgmHC
 c4Y1l8bdulOdhX2sGpMk5NIaXPIPpngfsdPrtWKED1SJqkUTF/FvdQJy2CTJtfH62N
 8X12bSkRFPiyFnAm31NmkbTOt4hB5wSfzZ6MR42SSuhy5GBvdJ3NcBfGjERRpBHLK7
 SnlqUJQXhfWlA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 3/6] pmdomain/rockchip: cycle optional
 power-domain resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260731043507.1832277-4-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
 <20260731043507.1832277-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 04:50:41 +0000
Message-Id: <20260731045041.9F69B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] Using `dev_err()` to log a failure to acquire resets causes log spa=
m when the error is `-EPROBE_DEFER`.

Pre-existing issues:
- [Critical] Critical use-after-free and state corruption due to `pm_genpd_=
remove()` failure during probe error handling.
- [High] Missing cleanup of previously acquired clocks if `of_clk_get()` fa=
ils during initialization.
- [High] Use-after-free on the PM domain's device tree node reference (`pd-=
>node`).
--

--- Patch [3]: [RFC PATCH v3 3/6] pmdomain/rockchip: cycle optional power-d=
omain resets on power-on ---
commit 7b67005dcd951b64c273c1af0e37dfcc0b7586dd
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain/rockchip: cycle optional power-domain resets on power-on

Some Rockchip domains come out of power-on with their bus interface in
an undefined state. On the RK3576 NPU this shows up as a hang on the
first access after a cold power-on; the vendor kernel cycles the
domain's resets at this point and that clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains
that do not declare any behave exactly as before.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index e1857f8786864..82051f60090f3 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -857,6 +866,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>  	if (error)
>  		goto err_put_clocks;

[Severity: High]
This is a pre-existing issue, but does this function leak clock handles if
of_clk_get() fails?

Looking at the loop just before this context:

rockchip_pm_add_one_domain() {
    for (i =3D 0; i < pd->num_clks; i++) {
        pd->clks[i].clk =3D of_clk_get(node, i);
        if (IS_ERR(pd->clks[i].clk)) {
            ...
            return error;
        }
    }
}

If of_clk_get() returns -EPROBE_DEFER for an index > 0, it returns
immediately without calling clk_put() for the clocks successfully acquired =
in
earlier iterations. Should this jump to a cleanup path instead?

[Severity: High]
This is another pre-existing issue in this function, but is it safe to store
pd->node without incrementing its reference count?

In rockchip_pm_domain_probe(), domains are initialized within a loop that
automatically drops the node reference. Later, rockchip_pd_power() uses this
potentially freed node:

rockchip_pm_add_one_domain()
    pd->node =3D node;

rockchip_pd_power()
    devm_of_regulator_get(..., pd->node, ...);

Could this lead to a use-after-free if the node is dynamically removed?

> =20
> +	pd->resets =3D of_reset_control_array_get_optional_exclusive(node);
> +	if (IS_ERR(pd->resets)) {
> +		error =3D PTR_ERR(pd->resets);
> +		dev_err(pmu->dev, "%pOFn: failed to get resets: %d\n", node, error);

[Severity: Low]
Could this dev_err() cause log spam during normal boot?

If of_reset_control_array_get_optional_exclusive() returns -EPROBE_DEFER
because the reset controller hasn't probed yet, this will print an error.
Would dev_err_probe() be better here to suppress the spam and cleanly track
the deferral?

> +		pd->resets =3D NULL;
> +		goto err_unprepare_clocks;
> +	}

[ ... ]

> @@ -945,6 +963,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
> =20
>  	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  	clk_bulk_put(pd->num_clks, pd->clks);
> +	reset_control_put(pd->resets);
> =20
>  	/* protect the zeroing of pm->num_clks */
>  	mutex_lock(&pd->pmu->mutex);

[Severity: Critical]
This isn't a bug introduced by this patch, but could ignoring the return va=
lue
of pm_genpd_remove() lead to a use-after-free and state corruption?

During probe error paths, rockchip_pm_domain_cleanup() tries to remove
domains. If child links aren't removed first, pm_genpd_remove() fails with
-EBUSY. Since this failure is ignored:

rockchip_pm_remove_one_domain()
    ret =3D pm_genpd_remove(&pd->genpd);
    // ret is -EBUSY, but we continue tearing down

    clk_bulk_unprepare(...);
    reset_control_put(pd->resets);

The domain remains active in the global gpd_list, but its internal resources
are freed, and devm eventually frees the rockchip_pm_domain struct. When the
subsystem later iterates over domains, won't it dereference the freed memory
or the newly dangling pd->resets pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731043507.1832=
277-1-gahing@gahingwoo.com?part=3D3
