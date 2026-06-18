Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F2CCD98DE
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2415D10EC82;
	Thu, 18 Jun 2026 05:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5hhP7TZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0579610EC82
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:14:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 350A760008
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861C31F000E9;
 Thu, 18 Jun 2026 05:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781759660;
 bh=3398tdurdkCJe2odCLbGCin5/Ale8kLa2C6uuKmFS3U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P5hhP7TZ4iFQJM9OWe3V6KC/ge1u58i3M6daxZmIUd2OVgcv1x3CxpcEIKbVl652y
 7eHz50sOqQNeMgafWnOS04FcnjE2IZr0dvh/mTqHs4QVTU0leYQMxM1kJ7UrV0k3BW
 FzXPlGWT0MAYz252V6Bc/4W+AT8f6msACNXUlCrRBDehS1uQoWfkgpBR4e2yJ8JRuC
 36voUdn5xvIBycxbTWgPc58OPbohIqROy9Gc5Plw3vWAP7uW4n44QfmhX5ZNhAKoIU
 VqpaxhxQHr2kLPfpwQaOcQn5qk54q5KCTmg/G1s17a1EeSIHnW4Duhx7QswAV+fDKn
 Uy8HrdugI2dyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] pmdomain: st: ux500: Control DB8500 EPODs
To: "Linus Walleij" <linusw@kernel.org>
Cc: devicetree@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org,
 dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:14:20 +0000
Message-Id: <20260618051420.861C31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Probe error path leaks dynamically allocated memory, fails to unre=
gister PM domains, and lacks rollback for partially added subdomains.
- [High] Hardware RAM retention capabilities are entirely lost, rendering r=
elated state handling logic dead code.
- [Medium] Bisection breakage: Disabling REGULATOR_DB8500_PRCMU causes cons=
umer devices expecting `v-ape-supply` to permanently fail to probe.
--

commit 26ccd884add2c876cdf4c876688df7b868a2fa06
Author: Linus Walleij <linusw@kernel.org>

pmdomain: st: ux500: Control DB8500 EPODs

Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
Keep the old regulator driver mutually exclusive with the pmdomain driver.

> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
[ ... ]
> @@ -26,7 +26,7 @@ menuconfig ARCH_U8500
>  	select PL310_ERRATA_753970 if CACHE_L2X0
>  	select PM_GENERIC_DOMAINS if PM
>  	select REGULATOR
> -	select REGULATOR_DB8500_PRCMU
> +	select UX500_PM_DOMAIN
>  	select REGULATOR_FIXED_VOLTAGE
>  	select SOC_BUS
>  	select RESET_CONTROLLER

[Severity: Medium]
Does this break git bisect by disabling the regulator provider before consu=
mer
devices are updated?

Consumer devices depending on v-ape-supply may receive -EPROBE_DEFER
indefinitely if the regulator driver is disabled here. I see this is fixed =
in
a later commit ("regulator: db8500: Add power domain regulators"), but is it
possible to reorder the changes to avoid breaking bisection?

> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
[ ... ]
> +static int disable_epod(u16 epod_id, bool ramret)
> +{
> +	int ret;
> +
> +	if (ramret) {
> +		if (!epod_on[epod_id]) {
> +			ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		epod_ramret[epod_id] =3D false;
> +	} else {
> +		if (epod_ramret[epod_id]) {
> +			ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);

[Severity: High]
Is the hardware RAM retention capability effectively lost here?

The struct dbx500_powerdomain_info defines is_ramret, but none of the
newly defined domains initialize it to true (e.g., for SVAMMDSP or SIAMMDSP=
).
Because ramret is always false, epod_ramret[] is never set, making
the EPOD_STATE_RAMRET state unreachable. Does this dead code need to
be activated by setting is_ramret on the appropriate domains?

[ ... ]
> +static int ux500_pm_domains_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct genpd_onecell_data *genpd_data;
>  	int i;
> +	int ret;
> =20
>  	if (!np)
>  		return -ENODEV;
[ ... ]
>  	for (i =3D 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -		pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +		pm_genpd_init(ux500_pm_domains[i], NULL, true);
> +
> +	ret =3D ux500_pm_domains_add_subdomains();
> +	if (ret)
> +		return ret;

[Severity: High]
Does this error path leak memory and leave the power domains registered?

If ux500_pm_domains_add_subdomains() fails, it returns an error directly.
This leaves genpd_data allocated and the domains initialized and linked into
the global gpd_list via pm_genpd_init().

If a driver unbind/rebind occurs, could INIT_LIST_HEAD be invoked on elemen=
ts
already in the list, potentially corrupting the doubly linked list and caus=
ing
a kernel panic?

Should pm_genpd_remove() be called for initialized domains, and the added
subdomains be rolled back with pm_genpd_remove_subdomain() before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D6
