Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2030C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 03:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0D210E33A;
	Sat, 18 Jul 2026 03:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PWQkKH0+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E828D10E33A
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:20:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 647AD4157B;
 Sat, 18 Jul 2026 03:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1000A1F000E9;
 Sat, 18 Jul 2026 03:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784344836;
 bh=odXcpOwQmd8uyldO3l8CCz4AVEO+Gh5iU9jICwEg1bc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PWQkKH0+HgXcn/HrNqCNhkJYecMuC9gHnJcqG6e71ec+6onOyDF6hrJ5ng7A1ALOK
 pO3PYfOFVqvxryUEL1H35kmvUJRbL0xqguildB4pIjzhnBhHwhXLq9EOK+80FepDpa
 AuApeeGXoiwWhcTtvBP/blNGXuY2xbgWL020feb1OVQngekux0cMW9KGQMUQ/PBaP+
 jfwSzmUI3Ha0t4KAjM+/vnEdtw039ZX86RNKZpPUlevhEZygYT7LXGT6UcjPBpEzj5
 CJzCEmaSs5HD4IeWyo5xsA69KS+LdsDN6sCn/SP82u6cgW5BHvm1sHODyiE3iYinFf
 Z1GsmJO0IvBKg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/8] pmdomain/rockchip: add optional per-domain
 power-on settle delay
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260718031146.3368811-3-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
 <20260718031146.3368811-3-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 03:20:35 +0000
Message-Id: <20260718032036.1000A1F000E9@smtp.kernel.org>
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
- [High] Missing state rollbacks in the error paths of rockchip_pd_power() =
can leave the hardware in an inconsistent or unusable state, leading to a k=
ernel panic.
--

--- Patch [2]: [RFC PATCH v2 2/8] pmdomain/rockchip: add optional per-domai=
n power-on settle delay ---
commit 5d8a3f8a8260643f6533a94cae0393fe9867b0cc
Author: Jiaxing Hu <gahing@gahingwoo.com>

pmdomain/rockchip: add optional per-domain power-on settle delay

This commit adds a per-domain settle delay for the RK3576 NPU domains.
It introduces a delay_us field to rockchip_domain_info and applies the
delay in rockchip_pd_power() before restoring QoS settings.

> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index 490bbb1d1d8e8..1787f62ba3a81 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c

[ ... ]

> @@ -667,6 +668,9 @@ static int rockchip_pd_power(struct rockchip_pm_domai=
n *pd, bool power_on)
>  		if (ret < 0)
>  			goto out;

[Severity: High]
This is a pre-existing issue, but there appears to be a problem with the
error path in rockchip_pd_power() when a domain transition fails.

When the genpd framework attempts to power off a domain and
rockchip_pd_power() is called with power_on set to false, the driver
successfully idles the bus interconnect:

        if (!power_on) {
                rockchip_pmu_save_qos(pd);

                /* if powering down, idle request to NIU first */
                ret =3D rockchip_pmu_set_idle_request(pd, true);
                if (ret < 0)
                        goto out;
        }

If the subsequent call to rockchip_do_pmu_set_power_domain(pd, false) fails
due to a hardware timeout, the function jumps to the out label without
reverting the idle request.

The genpd framework seems to gracefully handle the error by keeping the
domain status as GENPD_STATE_ON. However, when a consumer device later
resumes and attempts to access its MMIO registers, the interconnect remains
physically idled.

Can this cause the bus to hang and raise an SError, leading to a kernel
panic? Would it be appropriate to revert the idle request in the error path
before returning?

> =20
> +		if (pd->info->delay_us)
> +			udelay(pd->info->delay_us);
> +
>  		rockchip_pmu_restore_qos(pd);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718031146.3368=
811-1-gahing@gahingwoo.com?part=3D2
