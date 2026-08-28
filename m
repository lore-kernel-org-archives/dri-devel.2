Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3085EC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:59:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8614010F3B8;
	Fri, 28 Aug 2026 13:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hArhjcY9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE84310F3B8
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:59:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B751943B76;
 Fri, 28 Aug 2026 13:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40B91F000E9;
 Fri, 28 Aug 2026 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925585;
 bh=136ucrOGxKA9SkLTfq5BiP5n7Q3HPT68H0U7l9wKJho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hArhjcY9XbA5Em3QTc0pG6pAClA0SUc6PiZUg86xXMwiC7+DPzSv7D60iI+YnqNgM
 Ht/3FATal/4FFo9P2wlJY5k8DW8E+olsJlH5AIxUH2HdteLMgzJKoqkJrCtqSq2lyE
 k3VWVEq6XqQp+nYEXnwrLloZHrxPxR00JGlbkvlm9dbqaEkn9VmsZfM2C5ftCy4AsP
 bL+93aGCnQ8FFJMl/0gUL2TCg65GE2pokyvjceuN6RWuPOeCK+4HjE/dHImRSxAAU9
 HQ4g+QxuPFATNJt+XiHdkQuqCmgKfPq9VIOEijIRc9p1DTRstUnRT+X5kzaNMgGS0H
 R8e9cQ9hH9ezw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] soc: starfive: Add jh7110-hdmi-subsystem driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 neil.armstrong@linaro.org, robh@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, lee@kernel.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20260828-jh7110-clean-send-v2-8-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134828eucas1p1b4061de1538ef0d3322dc32f3db6140e@eucas1p1.samsung.com>
 <20260828-jh7110-clean-send-v2-8-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 13:59:44 +0000
Message-Id: <20260828135944.F40B91F000E9@smtp.kernel.org>
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
- [Low] Missing `select REGMAP_MMIO` in Kconfig, leading to potential build=
/link errors.
--

commit 391d2ca299019c57f8ca3f0d4ee7e80cac19c1eb
Author: Michal Wilczynski <m.wilczynski@samsung.com>
Subject: soc: starfive: Add jh7110-hdmi-subsystem driver

This commit adds a parent driver for the monolithic StarFive JH7110 HDMI IP
block. It maps the shared register space and creates separate logical child
devices for the HDMI PHY and controller to break a circular probing
dependency.

> diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
> new file mode 100644
> index 0000000000000..7592d87dea37a
> --- /dev/null
> +++ b/drivers/soc/starfive/Kconfig
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Starfive SoC drivers
> +#
> +
> +if ARCH_STARFIVE || COMPILE_TEST
> +menu "Starfive SoC drivers"
> +
> +config SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM
> +	tristate "StarFive JH7110 HDMI subsystem driver"
> +	depends on OF

[Severity: Low]
Does this Kconfig entry need to select REGMAP_MMIO?

If the kernel is configured with SOC_STARFIVE_JH7110_HDMI_SUBSYSTEM=3Dy (for
example, during a random COMPILE_TEST build) but without any other driver
that enables REGMAP_MMIO, the build will likely fail with a linker error.

[ ... ]

> diff --git a/drivers/soc/starfive/jh7110-hdmi-subsystem.c b/drivers/soc/s=
tarfive/jh7110-hdmi-subsystem.c
> new file mode 100644
> index 0000000000000..d893c1c29f98b
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-hdmi-subsystem.c

[ ... ]

> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +
> +	regmap =3D devm_regmap_init_mmio(dev, regs,
> +				       &starfive_hdmi_regmap_config);

[Severity: Low]
Could the missing REGMAP_MMIO Kconfig selection cause an undefined
reference to __devm_regmap_init_mmio_clk() here during link time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D8
