Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214BA606A324
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2O1kHoS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6459410E1F4;
	Sun,  1 Nov 2026 08:47:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEF7410E1F4
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 08:47:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CA0C40A1C;
 Sun,  1 Nov 2026 08:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167FB1F000C1;
 Sun,  1 Nov 2026 08:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793522829;
 bh=/Ahoa7VWtxvlazU/wBlavWiBcSGSWJgvjXBhLUJDGfQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k2O1kHoSc2//U8+bLVWzzgGIyAhT+eIfx1Y9+OXLo0LK33XBrhmdzr80dds4VpbU/
 YH4nY8hvAUfKSDgwMkcuvM08FVVBhCXr47GbmKs4yqe3bDuOkgiAIVhwyDnCo6zXcO
 DgwOC3LR2lGQ8xciNW8M8P9A0MVvnDcyUaxsFrTZnB9S7BvzBwZv3zy6sG3A3XWaZe
 4Af1jcHM1qAsSfqmrqpjsgScOpjnX5P1uSvryNa8vNeLowWxlmZP3C3YbaCbUftZ8d
 IXSdHFNm+LCkE0RCocBrUi9uo5xZ1dE32pjtpkMgDyIPIXBnTQ4b7tLFjWMSMAq4h2
 lCzqcPUMnErwQ==
Message-ID: <sashiko-outbox-192341@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 09/15] pmdomain: rockchip: add optional per-domain
 power-on settle delay
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261101082307.151957-10-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-10-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 08:47:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pmdomain: rockchip: parent-only power-off in rockchip_pm_add_one_d=
omain()
--

commit b6869eb827130372ac40273ce1417cb61dc66c51
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain: rockchip: add optional per-domain power-on settle delay

This commit adds an optional per-domain delay_us to rockchip_domain_info to
wait between releasing the idle request and restoring QoS registers, and se=
ts
a 15 us delay on the RK3576 NPU child domains while marking RK3576_PD_NPU w=
ith
need_regulator =3D true.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index db3879846db67..e3cc60fa22771 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
[ ... ]
> @@ -1314,25 +1325,26 @@ static const struct rockchip_domain_info rk3568_p=
m_domains[] =3D {
>  };
> =20
>  static const struct rockchip_domain_info rk3576_pm_domains[] =3D {
> -	[RK3576_PD_NPU]		=3D DOMAIN_RK3576("npu",    0x0, BIT(0),  BIT(0), 0,  =
     0x0, 0,       0,       0,       false),
> -	[RK3576_PD_NVM]		=3D DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(=
6),  0x4, BIT(2),  BIT(18), BIT(2),  false),
> -	[RK3576_PD_SDGMAC]	=3D DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BI=
T(7),  0x4, BIT(1),  BIT(17), 0x6,     false),
> -	[RK3576_PD_AUDIO]	=3D DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT=
(8),  0x4, BIT(0),  BIT(16), BIT(0),  false),
> -	[RK3576_PD_PHP]		=3D DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(=
9),  0x0, BIT(15), BIT(15), BIT(15), false),
> -	[RK3576_PD_SUBPHP]	=3D DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BI=
T(10), 0x0, 0,       0,       0,       false),
> -	[RK3576_PD_VOP]		=3D DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(=
11), 0x0, 0x6000,  0x6000,  0x6000,  false),
> -	[RK3576_PD_VO1]		=3D DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(=
14), 0x0, BIT(12), BIT(12), 0x7000,  false),
> -	[RK3576_PD_VO0]		=3D DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(=
15), 0,   0x0, BIT(11), BIT(11), 0x6800,  false),
> -	[RK3576_PD_USB]		=3D DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(=
16), 0x0, BIT(10), BIT(10), 0x6400,  true),
> -	[RK3576_PD_VI]		=3D DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(1=
7), 0x0, BIT(9),  BIT(9),  BIT(9),  false),
> -	[RK3576_PD_VEPU0]	=3D DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT=
(18), 0x0, BIT(7),  BIT(7),  0x280,   false),
> -	[RK3576_PD_VEPU1]	=3D DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT=
(19), 0x0, BIT(8),  BIT(8),  BIT(8),  false),
> -	[RK3576_PD_VDEC]	=3D DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(=
20), 0x0, BIT(6),  BIT(6),  BIT(6),  false),
> -	[RK3576_PD_VPU]		=3D DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(=
21), 0x0, BIT(5),  BIT(5),  BIT(5),  false),
> -	[RK3576_PD_NPUTOP]	=3D DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BI=
T(22), 0x0, 0x18,    0x18,    0x18,    false),
> -	[RK3576_PD_NPU0]	=3D DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(=
23), 0x0, BIT(1),  BIT(1),  0x1a,    false),
> -	[RK3576_PD_NPU1]	=3D DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(=
24), 0x0, BIT(2),  BIT(2),  0x1c,    false),
> -	[RK3576_PD_GPU]		=3D DOMAIN_RK3576("gpu",    0x4, BIT(9),  0,      BIT(=
25), 0x0, BIT(0),  BIT(0),  BIT(0),  false),
> +	/*                                            name    p_offset pwr     =
 status  r_status r_offset req      idle     g_mask   delay wakeup */
> +	[RK3576_PD_NPU]		=3D DOMAIN_RK3576_R("npu",  0x0, BIT(0),  BIT(0), 0,  =
     0x0, 0,       0,       0,       0,    false),
> +	[RK3576_PD_NVM]		=3D DOMAIN_RK3576("nvm",    0x0, BIT(6),  0,      BIT(=
6),  0x4, BIT(2),  BIT(18), BIT(2),  0,    false),
> +	[RK3576_PD_SDGMAC]	=3D DOMAIN_RK3576("sdgmac", 0x0, BIT(7),  0,      BI=
T(7),  0x4, BIT(1),  BIT(17), 0x6,     0,    false),
> +	[RK3576_PD_AUDIO]	=3D DOMAIN_RK3576("audio",  0x0, BIT(8),  0,      BIT=
(8),  0x4, BIT(0),  BIT(16), BIT(0),  0,    false),
> +	[RK3576_PD_PHP]		=3D DOMAIN_RK3576("php",    0x0, BIT(9),  0,      BIT(=
9),  0x0, BIT(15), BIT(15), BIT(15), 0,    false),
> +	[RK3576_PD_SUBPHP]	=3D DOMAIN_RK3576("subphp", 0x0, BIT(10), 0,      BI=
T(10), 0x0, 0,       0,       0,       0,    false),
> +	[RK3576_PD_VOP]		=3D DOMAIN_RK3576("vop",    0x0, BIT(11), 0,      BIT(=
11), 0x0, 0x6000,  0x6000,  0x6000,  0,    false),
> +	[RK3576_PD_VO1]		=3D DOMAIN_RK3576("vo1",    0x0, BIT(14), 0,      BIT(=
14), 0x0, BIT(12), BIT(12), 0x7000,  0,    false),
> +	[RK3576_PD_VO0]		=3D DOMAIN_RK3576("vo0",    0x0, BIT(15), 0,      BIT(=
15), 0x0, BIT(11), BIT(11), 0x6800,  0,    false),
> +	[RK3576_PD_USB]		=3D DOMAIN_RK3576("usb",    0x4, BIT(0),  0,      BIT(=
16), 0x0, BIT(10), BIT(10), 0x6400,  0,    true),
> +	[RK3576_PD_VI]		=3D DOMAIN_RK3576("vi",     0x4, BIT(1),  0,      BIT(1=
7), 0x0, BIT(9),  BIT(9),  BIT(9),  0,    false),
> +	[RK3576_PD_VEPU0]	=3D DOMAIN_RK3576("vepu0",  0x4, BIT(2),  0,      BIT=
(18), 0x0, BIT(7),  BIT(7),  0x280,   0,    false),
> +	[RK3576_PD_VEPU1]	=3D DOMAIN_RK3576("vepu1",  0x4, BIT(3),  0,      BIT=
(19), 0x0, BIT(8),  BIT(8),  BIT(8),  0,    false),
> +	[RK3576_PD_VDEC]	=3D DOMAIN_RK3576("vdec",   0x4, BIT(4),  0,      BIT(=
20), 0x0, BIT(6),  BIT(6),  BIT(6),  0,    false),
> +	[RK3576_PD_VPU]		=3D DOMAIN_RK3576("vpu",    0x4, BIT(5),  0,      BIT(=
21), 0x0, BIT(5),  BIT(5),  BIT(5),  0,    false),
> +	[RK3576_PD_NPUTOP]	=3D DOMAIN_RK3576("nputop", 0x4, BIT(6),  0,      BI=
T(22), 0x0, 0x18,    0x18,    0x18,    15,   false),
> +	[RK3576_PD_NPU0]	=3D DOMAIN_RK3576("npu0",   0x4, BIT(7),  0,      BIT(=
23), 0x0, BIT(1),  BIT(1),  0x1a,    15,   false),
> +	[RK3576_PD_NPU1]	=3D DOMAIN_RK3576("npu1",   0x4, BIT(8),  0,      BIT(=
24), 0x0, BIT(2),  BIT(2),  0x1c,    15,   false),

[Severity: High]
As reported by Sashiko on v14 [1], what happens in rockchip_pm_domain_probe=
()
when a bootloader leaves the NPU domains powered on?

In rk3576_pm_domains[], RK3576_PD_NPU uses DOMAIN_RK3576_R (setting
need_regulator =3D true and delay_us =3D 0), while its child domain
RK3576_PD_NPUTOP and grandchild domains RK3576_PD_NPU0 and RK3576_PD_NPU1
carry the 15 us delay_us, NIU idle masks, and QoS registers, but use
DOMAIN_RK3576 with need_regulator =3D false.

During probe, rockchip_pm_domain_probe() registers parent domains before
visiting subdomains via rockchip_pm_add_subdomain():

drivers/pmdomain/rockchip/pm-domains.c:rockchip_pm_add_one_domain() {
	...
	if (pd->info->need_regulator)
		rockchip_pd_power(pd, false);
	...
	pm_genpd_init(&pd->genpd, NULL,
		      !rockchip_pmu_domain_is_on(pd) ||
		      (pd->info->mem_status_mask && !rockchip_pmu_domain_is_mem_on(pd)));
}

Because only RK3576_PD_NPU has need_regulator =3D true,
rockchip_pm_add_one_domain() calls rockchip_pd_power(pd, false) on the pare=
nt
domain RK3576_PD_NPU while its child domains RK3576_PD_NPUTOP, RK3576_PD_NP=
U0,
and RK3576_PD_NPU1 are still active, and never powers off those child domai=
ns
at probe.

If the child status bits in repair_status_offset and mem_status_offset still
report RK3576_PD_NPUTOP as on after RK3576_PD_NPU is powered off,
RK3576_PD_NPU is initialized in GENPD_STATE_OFF while RK3576_PD_NPUTOP is
initialized in GENPD_STATE_ON. When rockchip_pm_add_subdomain() then links
them:

rockchip_pm_add_subdomain()
 -> pm_genpd_add_subdomain()
    -> genpd_add_subdomain()

drivers/pmdomain/core.c:genpd_add_subdomain() {
	...
	if (!genpd_status_on_unlocked(genpd) &&
	    genpd_status_on_unlocked(subdomain)) {
		ret =3D -EINVAL;
		goto out;
	}
}

won't pm_genpd_add_subdomain() fail with -EINVAL and abort
rockchip_pm_domain_probe() for all power domains on the SoC?

Conversely, even if cutting RK3576_PD_NPU forced the child domains off in
hardware (or if hardware ignored the parent power-off while children are
active), wouldn't that either cut power to the child domains without idling
their NIU bus interfaces and saving their QoS registers, or leave the child
domains in GENPD_STATE_ON so that the 15 us delay_us in rockchip_pd_power()=
 is
still skipped on the first power-on?

[1] https://lore.kernel.org/r/20260924102135.92217-10-gahing@gahingwoo.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101082307.1519=
57-1-gahing@gahingwoo.com?part=3D9
