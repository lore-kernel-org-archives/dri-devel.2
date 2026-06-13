Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF195CD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEBC10ECD2;
	Sat, 13 Jun 2026 07:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DBexUrON";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2407B10ECD2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 07:21:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEE7340504;
 Sat, 13 Jun 2026 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876DE1F000E9;
 Sat, 13 Jun 2026 07:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781335315;
 bh=lyeoeZB4baecDgPEDL9d2+mnsOQkh9CxE9zeseja7XY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DBexUrONr5lk83nbkKVxlbuaMcQNhcG1emWqTiGGCESf3cUUZ1Ld0q/Hvn23WB0gA
 5ArqNHaZ0HN3j5+ACCBSB9uUvmO3wK4pxCclRWsh1I0nUmbiFwowuqu+LMdSKXWhpU
 TbK5EGu/krrBvuQRBkdkPNsmHvDhQ4OUSEe5Bty5sFRhJMEHAP1FpvfmzhxiUWN2RH
 /ToPqxvLNyyypusmUaZneAPSdJNqbfTzO5uxuOJ9RLODon5ommHuPognHJw3Xjf9nN
 qa8vU0BCQNSkJMD5D31s/8GVJG9TV1zeE99jKyLoZazkSyXKZRYV1EZcIsNizrMTGU
 2PxTeRPPWERBA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 9/9] pmdomain: rockchip: Add a regulator to the
 RK3568 NPU power domain
To: MidG971 <midgy971@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260613070116.438906-10-midgy971@gmail.com>
References: <20260613070116.438906-10-midgy971@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 07:21:55 +0000
Message-Id: <20260613072155.876DE1F000E9@smtp.kernel.org>
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
- [High] Unhandled error from `rockchip_pd_power()` during probe leaves the=
 power domain in an inconsistent state, causing `genpd` to wrongly assume t=
he domain is ON.
--

commit 08758fdfbdda5f83d100c68fb3b2bbe8fd467ea7
Author: Midgy BALON <midgy971@gmail.com>

pmdomain: rockchip: Add a regulator to the RK3568 NPU power domain

This patch gives DOMAIN_RK3568 a regulator parameter, allowing the NPU
domain to set need_regulator. This enables genpd to manage the NPU rail
wired up as the domain's domain-supply instead of marking it always-on.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..19db307e3811d 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
[ ... ]
> @@ -1274,15 +1288,15 @@ static const struct rockchip_domain_info rk3562_p=
m_domains[] =3D {
>  };
> =20
>  static const struct rockchip_domain_info rk3568_pm_domains[] =3D {
> -	[RK3568_PD_NPU]		=3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false),
> -	[RK3568_PD_GPU]		=3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false),
> -	[RK3568_PD_VI]		=3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false),
> -	[RK3568_PD_VO]		=3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false),
> -	[RK3568_PD_RGA]		=3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false),
> -	[RK3568_PD_VPU]		=3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false),
> -	[RK3568_PD_RKVDEC]	=3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false),
> -	[RK3568_PD_RKVENC]	=3D DOMAIN_RK3568("venc", BIT(3), BIT(7),  false),
> -	[RK3568_PD_PIPE]	=3D DOMAIN_RK3568("pipe", BIT(8), BIT(11), false),
> +	[RK3568_PD_NPU]		=3D DOMAIN_RK3568("npu",  BIT(1), BIT(2),  false, true=
),

[Severity: High]
This is a pre-existing issue, but by setting need_regulator to true here,
does this expose the NPU domain to a potential probe failure and system
hang?

Looking at rockchip_pm_add_one_domain(), the return value of
rockchip_pd_power(pd, false) is currently ignored:

drivers/pmdomain/rockchip/pm-domains.c:rockchip_pm_add_one_domain() {
	...
	if (pd->info->need_regulator)
		rockchip_pd_power(pd, false);
	...
}

If the bootloader leaves the PMU MTCMOS register ON but the external
regulator is OFF, rockchip_pd_power() attempts to send an idle request.
Because the IP is physically unpowered, it cannot assert the ACK signal
and the request times out:

drivers/pmdomain/rockchip/pm-domains.c:rockchip_pd_power() {
	...
	ret =3D rockchip_pmu_set_idle_request(pd, true);
	if (ret < 0)
		goto out;
	...
}

Since the timeout error is ignored in rockchip_pm_add_one_domain(), the PMU
MTCMOS register remains ON, which causes pm_genpd_init() to incorrectly
initialize the domain as ON. When the consumer driver later requests power,
genpd assumes the domain is already active and skips enabling the regulator,
causing the driver to access an unpowered IP block.

Should the error handling in rockchip_pm_add_one_domain() be fixed to
properly synchronize the domain state before enabling this feature for the
NPU?

> +	[RK3568_PD_GPU]		=3D DOMAIN_RK3568("gpu",  BIT(0), BIT(1),  false, fals=
e),
> +	[RK3568_PD_VI]		=3D DOMAIN_RK3568("vi",   BIT(6), BIT(3),  false, false=
),
> +	[RK3568_PD_VO]		=3D DOMAIN_RK3568("vo",   BIT(7), BIT(4),  false, false=
),
> +	[RK3568_PD_RGA]		=3D DOMAIN_RK3568("rga",  BIT(5), BIT(5),  false, fals=
e),
> +	[RK3568_PD_VPU]		=3D DOMAIN_RK3568("vpu",  BIT(2), BIT(6),  false, fals=
e),
> +	[RK3568_PD_RKVDEC]	=3D DOMAIN_RK3568("vdec", BIT(4), BIT(8),  false, fa=
lse),
> +	[RK3568_PD_RKVENC]	=3D DOMAIN_RK3568("venc", BIT(3), BIT(7),  false, fa=
lse),
> +	[RK3568_PD_PIPE]	=3D DOMAIN_RK3568("pipe", BIT(8), BIT(11), false, fals=
e),
>  };
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613070116.4389=
06-1-midgy971@gmail.com?part=3D9
