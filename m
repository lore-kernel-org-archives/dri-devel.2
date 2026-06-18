Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6DACD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75FB10EC77;
	Thu, 18 Jun 2026 05:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NKd2FRcF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4FA10EC77
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:10:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 026C060008
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 05:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675601F000E9;
 Thu, 18 Jun 2026 05:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781759435;
 bh=L8yDpLryHHHFlQA+V504Avl+bMV1mqW/Jc/Pager9Xw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NKd2FRcFmCQ9DB10o5Py0qxpwqsiIkhV4z09f5xnuMWcFz2KFwGqy/nfaa+iQyZNB
 Ccypqhr7fanI/WUt34pTT5adz2ATxzKGZb9mZZGs+vAczEwKNfHPFiJS6Nz3e070Fd
 DRA1U9NZJrz6xJmrFc6s6DAtSo7GwhRdkJInKdW1x013bC23K/84nvYu4R1ZHeHx3o
 b+nvmQY0cyf2rNFPKRf7MwFctc+hD4LNH+6yU0Y+znGemXmXk/qBO81GfZb9oGFW1w
 9yh6AHby7h/06NjOcD0zjTfYa3Dn3BuhDsWRaJeb5lS4waAQ1dd97gyRiQCuZDhyjv
 +JtWh/bBeHHIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/11] pmdomain: st: ux500: Implement more power domains
To: "Linus Walleij" <linusw@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
 conor+dt@kernel.org, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-3-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-3-eb5e50b1a588@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 05:10:35 +0000
Message-Id: <20260618051035.675601F000E9@smtp.kernel.org>
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
- [Low] The comment regarding Vape_esram0_pwr contradicts the implementatio=
n of ux500_pm_domain_esram_12.
--

commit e7c9ddf5e852fa7ba6bbf083dd8b845efaaf86e5
Author: Linus Walleij <linusw@kernel.org>

pmdomain: st: ux500: Implement more power domains

This starts to implement the power domains that are just skeleton
implementations right now.

> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> index 6896cb4a7b716..7230010046908 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -41,14 +41,137 @@ static int pd_power_on(struct generic_pm_domain *dom=
ain)
>  	return 0;
>  }
> =20
> +/*
> + * Apart from these voltage domains there is also VSAFE which is always
> + * on. Vape_esram0_pwr for eSRAM0 is connected to VSAFE.
> + */
>  static struct generic_pm_domain ux500_pm_domain_vape =3D {

[ ... ]

> +static struct generic_pm_domain ux500_pm_domain_b2r2_mcde =3D {
> +	/* Vape_DSS_pwr DSS (display subsystem) */
> +	.name =3D "B2R2_MCDE",
> +	.power_off =3D pd_power_off,
> +	.power_on =3D pd_power_on,
> +};
> +
> +static struct generic_pm_domain ux500_pm_domain_esram_12 =3D {
> +	/* Vape_esram0_pwr, Vape_esram1_pwr */
> +	.name =3D "ESRAM_12",

[Severity: Low]
Is this comment accurate? An earlier comment states that Vape_esram0_pwr for
eSRAM0 is connected to the always-on VSAFE domain, but it is listed here as
part of the switchable ESRAM_12 power domain. Should this comment refer to
Vape_esram1_pwr and Vape_esram2_pwr instead?

> +	.power_off =3D pd_power_off,
> +	.power_on =3D pd_power_on,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-ux500-powe=
r-domains-v7-1-v1-0-eb5e50b1a588@kernel.org?part=3D3
