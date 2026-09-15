Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E843C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E1C10E00D;
	Tue, 15 Sep 2026 15:42:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m4AcCZ4e";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6160310E624
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:42:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D84E4600C8;
 Tue, 15 Sep 2026 15:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6931F00893;
 Tue, 15 Sep 2026 15:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486966;
 bh=e8CA6A8+NEtvZVDKgf3JyCaOYgWoKmHI1CSRlYOsO9U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m4AcCZ4eN0PJYC+6Kr7kdugxed4FtiCo+2MZR2ao2+V/K3jD/uQOz2YbShVwzBtnG
 kb8ceIGGiJrLDSgWcSrBDx+i+XOBtes+rTK56qKzLUcfOY/N4Yk2q1CdV+/mF2x+DR
 9cx3gStlE8ZGuZBtt+730Upg4dV2aaSrmZoOwJ/0odxds0hvjgPkRpT1wtha8+/jc3
 dMjwlEF5RIrzsO/kj7UIPQpySbf1l9c86TzYQO9zo1GeTOLRN5bCkc2TBjZ0y8uvnP
 vacuhVgtLIs+z+NVPFOa8i1c73FjjWzUbnp+loePtkTW1CJ4jvtBErEVtyp+WYj0XC
 UHkScHcGqvppg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/20] soc: starfive: Add jh7110-vout-subsystem driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, olteanv@gmail.com,
 mfd@lists.linux.dev, lee@kernel.org, vkoul@kernel.org,
 linux-phy@lists.infradead.org, neil.armstrong@linaro.org,
 linux-clk@vger.kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-13-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153236eucas1p1712930425e569f894c870299f245e99f@eucas1p1.samsung.com>
 <20260915-jh7110-clean-send-v4-13-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:42:45 +0000
Message-Id: <20260915154246.1F6931F00893@smtp.kernel.org>
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
- [Medium] soc: starfive: NoC bus clock leaks power during system sleep
--

commit f4b88d3831df8dc30fb442edb24499643c924a58
Author: Michal Wilczynski <m.wilczynski@samsung.com>
soc: starfive: Add jh7110-vout-subsystem driver

This commit adds a parent driver for the StarFive JH7110 video output
subsystem. It claims the NoC display bus clock and reset, and holds a runti=
me
PM reference to keep the PD_VOUT power domain active for as long as any chi=
ld
device exists.

> diff --git a/drivers/soc/starfive/jh7110-vout-subsystem.c b/drivers/soc/s=
tarfive/jh7110-vout-subsystem.c
> new file mode 100644
> index 0000000000000..af632692e2139
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-vout-subsystem.c

[ ... ]

> +	bus_clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(bus_clk),
> +				     "Failed to enable NoC bus clock\n");
> +
> +	bus_rst =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);

[Severity: Medium]
Does this cause a power leak during system suspend? The NoC bus clock is
enabled here, but the pointer to bus_clk is discarded. This means it cannot
be disabled later during system sleep transitions.=20

While the genpd framework manages the PD_VOUT domain during system sleep, t=
he
clock framework doesn't automatically disable clocks. The software enable
count will remain greater than zero, which could keep the NoC bus clock and
its parent PLLs active and leak power during suspend (e.g., suspend-to-RAM).

[ ... ]

> +static struct platform_driver jh7110_vout_subsys_driver =3D {
> +	.probe =3D jh7110_vout_subsys_probe,
> +	.driver =3D {
> +		.name =3D "jh7110-vout-subsystem",
> +		.of_match_table =3D jh7110_vout_subsys_of_match,
> +	},
> +};
> +module_platform_driver(jh7110_vout_subsys_driver);

[Severity: Medium]
Because the driver struct lacks a .pm field with system suspend and resume
callbacks, it seems there is no mechanism to disable the NoC bus clock when
the system goes to sleep. Should the driver store the clock pointer in a
private structure and implement dev_pm_ops callbacks to handle disabling
and re-enabling the clock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D13
