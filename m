Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A6606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeRWTFiC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC5D10E704;
	Sun,  8 Nov 2026 07:31:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122C310E704
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 07:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F5FE60E25;
 Sun,  8 Nov 2026 07:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD0D1F0089F;
 Sun,  8 Nov 2026 07:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794123095;
 bh=7RKFHqwk0H3/Xr+rH96hEVDs+5/VajORWI7ljuPqOY0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jeRWTFiCKGw5wUSW4QLMHZc/u7EVyqKpZ47q2ekV9UN/kU0XFQNFEVPCSywxdr6NP
 tQb774no6oCTuNorxIjUnoBBU+JU/35ZmlRsBxrGvRE/0qQVQ32ybrWk+GzedENh20
 aFbobxefW/eVDbvJi3hXJpew8PRa/xc1Eo/zZ8SaOT4lfEYqbiP2txgtMnLV/6Fkmi
 zyqEm2t+WKSkJ8sAYsgJpIQmSg3p+Safqts/S3nfTR4uGnNXGEminyyFHYug1W2M5I
 1aKTTAnnwQO4wT8hap/GfUu0qC8alyIc01E89dLUJDISeNvEwisbnNTuOsvzhpeHWi
 //BUStJQyD7aA==
Message-ID: <sashiko-outbox-203627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 09/16] pmdomain: rockchip: add optional per-domain
 power-on settle delay
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261108065917.135194-10-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
 <20261108065917.135194-10-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:31:35 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] pmdomain: rockchip: parent-only power-off in
  rockchip_pm_add_one_domain()
--

commit 5d8e79daba54d22313c6250b1a4b08b82d2c38cf
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain: rockchip: add optional per-domain power-on settle delay

This commit adds an optional per-domain delay_us field to wait after
releasing the NIU idle request and before restoring QoS registers, and
sets a 15 us delay on the RK3576 NPUTOP, NPU0, and NPU1 domains while
enabling need_regulator on the RK3576 NPU parent domain.

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
15), 0x0, BIT(11), BIT(11), 0x6800,  false),
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
When the bootloader leaves the NPU powered on, does setting
need_regulator only on the parent RK3576_PD_NPU domain cause
rockchip_pm_domain_probe() to either fail in pm_genpd_add_subdomain() or
leave the child NPU domains in an inconsistent power state?

During probe, rockchip_pm_add_one_domain() runs top-down on
RK3576_PD_NPU before rockchip_pm_add_subdomain() visits its child
RK3576_PD_NPUTOP and grandchildren RK3576_PD_NPU0 and RK3576_PD_NPU1:

drivers/pmdomain/rockchip/pm-domains.c:rockchip_pm_add_one_domain() {
	...
	if (pd->info->need_regulator)
		rockchip_pd_power(pd, false);
	...
	pm_genpd_init(&pd->genpd, NULL,
		      !rockchip_pmu_domain_is_on(pd) ||
		      (pd->info->mem_status_mask && !rockchip_pmu_domain_is_mem_on(pd)));
}

Because RK3576_PD_NPUTOP, RK3576_PD_NPU0, and RK3576_PD_NPU1 still use
DOMAIN_RK3576 (need_regulator =3D false), rockchip_pm_add_one_domain()
never powers them off.  If RK3576_PD_NPU powers off while
RK3576_PD_NPUTOP still reports on via its repair_status_mask and
mem_status_mask bits, RK3576_PD_NPU initializes as GENPD_STATE_OFF and
RK3576_PD_NPUTOP initializes as GENPD_STATE_ON, causing
pm_genpd_add_subdomain() to return -EINVAL and abort probe for all
domains on the SoC.  Conversely, if hardware refuses to power off
RK3576_PD_NPU while its children are on (with the rockchip_pd_power()
error ignored), all NPU domains stay in GENPD_STATE_ON without enabling
the supply regulator or running the 15 us delay; or if cutting parent
power forces child status bits low in hardware, it cuts power while child
NIU buses are un-idled and leaves child pwr_offset 0x4 control bits set,
so once RK3576_PD_NPU powers back on, rockchip_pd_power(pd, true) on the
children sees rockchip_pmu_domain_is_on(pd) =3D=3D true and returns early
without running udelay() or rockchip_pmu_restore_qos().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108065917.1351=
94-1-gahing@gahingwoo.com?part=3D9
