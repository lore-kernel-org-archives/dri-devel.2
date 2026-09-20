Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E699C982DA
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 23:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DF610E2CF;
	Sun, 20 Sep 2026 23:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mM4XGNQf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C3110E2CF
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:04:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2023D41AC0
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 23:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BFB1F000FF;
 Sun, 20 Sep 2026 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789945465;
 bh=Oh484vqStnymfsvQXpkqyTCv7WpvymOc4ncgA/Irasg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mM4XGNQfJua5ef0O1ssjJb+Sbt145oe0Xov5woty8kDSUiB4B9Bs4XDLAj+1uSeIp
 1uvtGPUkkR46ogRCbQuctRk0Qd5MVSZVCgWLksuzhWKY+RTPI+0LX4POfNqHQ6Q5yA
 mO1oWCInPRlTYrMGddvRh/vd5Zl86EZJgi94PfoE4Y+pcATHTaqowxaqjY2TicrNBR
 D563gqO7XEoSCfwIKMhGDj4kywBcX2oh5hU9Kia7d6PqBtLl9I3YHoETi+KmY/6l2T
 EBoooar9v/+D5slXlOol+MB6IDbdFuslCEMcmhB8pSR5aeM2qWyr5aq/w6aRImU1E4
 6rSdSsGH6Ghbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/18] pmdomain: st: ux500: Control DB8500 EPODs
To: "Linus Walleij" <linusw@kernel.org>
Cc: conor+dt@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, vkoul@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-12-9352be6b86b1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 23:04:24 +0000
Message-Id: <20260920230424.87BFB1F000FF@smtp.kernel.org>
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
- [High] pmdomain: ux500: missing RAM retention flags in power domains
- [Medium] pmdomain: ux500: power leak from initializing domains as OFF
--

commit 9e8ecf92bb791471023c621b0664e285a95b3ad6
Author: Linus Walleij <linusw@kernel.org>

pmdomain: st: ux500: Control DB8500 EPODs

This commit moves the DB8500 EPOD state handling into the Ux500 power-domain
driver. It also keeps the old regulator driver mutually exclusive with the
pmdomain driver.

> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> index d90a563cd6f37..b31a36a4acd17 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
[ ... ]
> +static int enable_epod(u16 epod_id, bool ramret)
> +{
> +	int ret;
> +
> +	if (ramret) {
> +		if (!epod_on[epod_id]) {
> +			ret =3D db8500_prcmu_set_epod(epod_id, EPOD_STATE_RAMRET);

[Severity: High]
Are the RAM retention branches in enable_epod() and disable_epod() dead cod=
e?

The dbx500_powerdomain_info struct defines an is_ramret boolean, and these
functions check it to use EPOD_STATE_RAMRET. However, none of the 16 domains
initialized in ux500_pm_domains set .is_ramret =3D true.

[ ... ]
> -static struct generic_pm_domain ux500_pm_domain_sva_mmdsp =3D {
> +static struct dbx500_powerdomain_info ux500_pm_domain_sva_mmdsp =3D {
>  	/* Vape_SVA_MMDSP_pwr */
> -	.name =3D "SVA_MMDSP",
> -	.power_off =3D pd_power_off,
> -	.power_on =3D pd_power_on,
> +	.genpd =3D {
> +		.name =3D "SVA_MMDSP",
> +		.power_off =3D pd_power_off,
> +		.power_on =3D pd_power_on,
> +	},
> +	.epod_id =3D EPOD_ID_SVAMMDSP,
>  };

[Severity: High]
Will the omission of .is_ramret =3D true here cause SRAM data loss or preve=
nt
the domain from entering retention during suspend?

In the old regulator driver, domains such as SVAMMDSP, SIAMMDSP, ESRAM12,
and ESRAM34 explicitly had this flag set. Because the flag is never set in
the new PM domain driver, it defaults to false. This means normal runtime PM
transitions will fully power off the domains (EPOD_STATE_OFF) instead of
retaining their state.

[ ... ]
> @@ -186,11 +304,12 @@ static int ux500_pm_domains_probe(struct platform_d=
evice *pdev)
[ ... ]
>  	genpd_data->num_domains =3D ARRAY_SIZE(ux500_pm_domains);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -		pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +		pm_genpd_init(ux500_pm_domains[i], NULL, true);

[Severity: Medium]
Could initializing these domains as software-OFF (is_off =3D true) lead to a
power leak if the bootloader leaves them enabled?

When initialized as OFF (true), the genpd framework does not set stay_on
and considers the domain to be already powered off in software. Because of
this, genpd_power_off_unused() sees them as already OFF and skips calling
pd_power_off().

Consequently, any domain left ON by the bootloader without an active kernel
consumer is never powered off, failing to replicate the late init cleanup
behavior of the old regulator driver.

> +
> +	ret =3D of_genpd_add_provider_onecell(np, genpd_data);
> +	if (ret)
> +		goto remove_genpds;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-ux500-powe=
r-domains-v7-1-v3-0-9352be6b86b1@kernel.org?part=3D12
