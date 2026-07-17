Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3E0C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CB910F4AC;
	Fri, 17 Jul 2026 09:04:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C0EMs7l4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCB410F4AC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:04:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73234407D3;
 Fri, 17 Jul 2026 09:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F621F000E9;
 Fri, 17 Jul 2026 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784279085;
 bh=RwOsoX/vjL4MrYp4Va7jdFnjD9fJtLjCAm5EOC09U5g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C0EMs7l4JL/fcYMj3ypZD+9VL201Qkk1OZr7K5AqMMPP9PmmXpXUc2kbcsQZmSsJt
 JwRN6s1hQsrZ2FEnOJfu98rH+bVx87a6TD+V0JFb9W0eM/7+KGdhk5t9MwioTIAaAP
 FwUix9ZxIWGov/TkzTxqe6+ZkXc1Fsa06SuNCVaSTWHp/+OrCcgeEGgRnbejhK4ovp
 wEnUiTP+2LvNPyU82brfCZQZVaMmyU2dH0hx66g+j9wClmV/27F0s9Sz74tIVm5vUl
 pMSVn6RGkpD7KhCEnBjkWQArSjqzrIfDxZd2rkczDjiGwS+c5KAjsy6HqekMaSdykb
 aThaGG9kyRZDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/9] pmdomain/rockchip: cycle optional power-domain
 resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260717085220.3212274-4-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-4-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:04:44 +0000
Message-Id: <20260717090445.03F621F000E9@smtp.kernel.org>
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
- [Medium] Missing `reset_control_put()` in `rockchip_pm_remove_one_domain(=
)` leaks reset controls on probe failure.
--

--- Patch [3]: [RFC PATCH 3/9] pmdomain/rockchip: cycle optional power-doma=
in resets on power-on ---
commit dbabfedb9da6564f3dfbd42512d2a456cfb08c18
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain/rockchip: cycle optional power-domain resets on power-on

This commit adds optional reset line handling to the Rockchip power domain
driver. It explicitly asserts and deasserts the reset lines during domain
power-on to ensure hardware bus interfaces are correctly initialized.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -840,6 +848,14 @@ static int rockchip_pm_add_one_domain(struct rockchi=
p_pmu *pmu,
>  	if (error)
>  		goto err_put_clocks;
> =20
> +	pd->resets =3D of_reset_control_array_get_optional_exclusive(node);
> +	if (IS_ERR(pd->resets)) {
> +		error =3D PTR_ERR(pd->resets);
> +		dev_err(pmu->dev, "%pOFn: failed to get resets: %d\n", node, error);
> +		pd->resets =3D NULL;
> +		goto err_unprepare_clocks;
> +	}
> +

[Severity: Medium]
Since pd->resets is acquired here using a non-managed function, does it need
to be released in rockchip_pm_remove_one_domain()?

If a subsequent domain fails to probe, the error path tears down all
successfully added domains via rockchip_pm_remove_one_domain(). It looks li=
ke
that function destroys the domain and releases its clocks, but might miss
cleaning up these reset controls:

static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
{
        ...
        clk_bulk_unprepare(pd->num_clks, pd->clks);
        clk_bulk_put(pd->num_clks, pd->clks);

        /* pd->resets does not appear to be freed here */
        ...
}

Would calling reset_control_put(pd->resets) in the removal path prevent a
resource leak here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717085220.3212=
274-1-gahing@gahingwoo.com?part=3D3
