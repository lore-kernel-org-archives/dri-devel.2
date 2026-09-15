Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D21C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7D7310E5D7;
	Tue, 15 Sep 2026 10:56:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SDprMq6E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1333C10E5D7
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BAFB341819;
 Tue, 15 Sep 2026 10:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F91F000FF;
 Tue, 15 Sep 2026 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789469817;
 bh=3HcGKiozyOdiTVee3su4+m0qru2V1W2ji42LIr1XCGw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SDprMq6EGXZtA7K6VG7sYMRA5yn5TEbNQBSh9hjjmwhX/PV2hKfryfgPwuP/9wnCJ
 NU6rBUITNg2nczTPPg/yE6/eCKVj8tbcKh9e7PYLY+j2iL2e4c07+DCBst+o3yzuZq
 wad2POMaxvqYoPejxl3wXHBL4lCLD0TqKYpPDQXV6r9md3aVM8o5mrSqrdMv+F15e6
 NGQ+Xsp/x2MwheQoOvf80V/JzWBZ2UEUzFZfXjclZJhC+1rZ1aJAAnYNnEqBPZvGR4
 4VWzL9oLsHM3MCSmOG3cU3KItQL8ZGxlEdXZuHuIHf5PMX5L14CEV6hljZUGAKKeFk
 TK9e3HU5WGnBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/14] pmdomain: rockchip: cycle optional
 power-domain resets on power-on
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260915104328.45901-11-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-11-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 10:56:56 +0000
Message-Id: <20260915105657.500F91F000FF@smtp.kernel.org>
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
- [High] pmdomain: rockchip: UAF of reset control on probe error path
--

commit 7f227aa8bc180bf2cac448c39f64d020d6dc07cf
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain: rockchip: cycle optional power-domain resets on power-on

Some Rockchip domains come out of power-on with their bus interface in an
undefined state. On the RK3576 NPU this shows up as a hang on the first
register access after the domain is switched on, and pulsing the domain's
resets at this point clears it.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 39988efd86aaa..6cc8d6efda905 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>  		if (ret < 0)
>  			goto out;
> =20
> +		/*
> +		 * Optional: some domains need their resets cycled once power
> +		 * is on. This goes BEFORE the settle delay, not after: a
> +		 * domain that asks for both is asking to settle before the
> +		 * QoS registers answer, and a reset deasserted after the
> +		 * delay would leave nothing between it and the QoS writes.
> +		 * On RK3576 the reset being cycled is the NPU core's bus
> +		 * interface, which is what those writes go through.
> +		 */
> +		if (pd->resets) {
> +			reset_control_assert(pd->resets);

[Severity: High]
Can a concurrent call to power the domain trigger a use-after-free here?

If rockchip_pm_domain_probe() fails, the error path calls
rockchip_pm_domain_cleanup(), which invokes rockchip_pm_remove_one_domain().
For domains with attached subdomains, pm_genpd_remove() returns -EBUSY and
the driver ignores this failure, proceeding to free resources.

If pd->resets is freed in rockchip_pm_remove_one_domain() but the domain
remains registered, could a concurrent request to power the domain (via ano=
ther
device probe or sysfs) invoke rockchip_pd_power(), evaluate the dangling
pd->resets pointer as true, and dereference it?

> +			usleep_range(10, 20);
> +			reset_control_deassert(pd->resets);
> +		}
> +
>  		/* Some domains need to settle before the QoS registers answer. */
>  		if (pd->info->delay_us)
>  			udelay(pd->info->delay_us);

[ ... ]

> @@ -949,6 +975,7 @@ static void rockchip_pm_remove_one_domain(struct rock=
chip_pm_domain *pd)
> =20
>  	clk_bulk_unprepare(pd->num_clks, pd->clks);
>  	clk_bulk_put(pd->num_clks, pd->clks);
> +	reset_control_put(pd->resets);

[Severity: High]
Should pd->resets be set to NULL here?

The reset control is freed here, but the pd->resets pointer is left danglin=
g.
This is unlike pd->num_clks below, which is safely cleared.

> =20
>  	/* protect the zeroing of pm->num_clks */
>  	mutex_lock(&pd->pmu->mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915104328.4590=
1-1-gahing@gahingwoo.com?part=3D10
