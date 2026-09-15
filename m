Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0D8C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABEE410F4B8;
	Tue, 15 Sep 2026 15:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RxB4aWbE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814C410F4B8
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:44:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 05491600D1;
 Tue, 15 Sep 2026 15:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E758B1F00893;
 Tue, 15 Sep 2026 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789487093;
 bh=QEBXUCGA3t5aIDeoUC+JSqnO28lAavBO8vWCn83qxws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RxB4aWbEruBsnXKfNLqbKvd6g9+7Poo7Pnm3+LUo9+LVGTrgtFDCaKPkmxzdVW7ne
 Dsy6w+dNLDG0aYz1QO9z3U1dx7JLTtyXyCGuvx3fmueF+pFM3KZQUD4wzaRatbfs21
 ZdeQ3lYggrSs0YE+aTjFnpL0A0xEmiibJQyRGcrF+78htalUhqvCp4exAGrMf1Asqn
 w120kqakOTpg+sYPWjbPp9hOl1XdK8ddze5sdqzTfQKTG6OQuAw5NHCfJhMPKkDCqK
 /JbNrXTSXBSzwyjkNELDcSDZOs9kgUfRX7+wD5PGvd02D40E7VnjzIH9/RFhM5aLiE
 Zn3mg6Pnw9CVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/20] soc: starfive: Add jh7110-hdmi-subsystem driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev,
 conor+dt@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 robh@kernel.org, olteanv@gmail.com, dri-devel@lists.freedesktop.org,
 vkoul@kernel.org, lee@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-12-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153234eucas1p221dd53b5f1bccb6228c0a5a7d0be8394@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-12-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:44:52 +0000
Message-Id: <20260915154452.E758B1F00893@smtp.kernel.org>
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
- [High] soc: starfive: unsafe 8-bit regmap MMIO accesses for 32-bit HDMI IP
--

commit 0e53205c6430272fda82936e32d4dd11694a8847
Author: Michal Wilczynski <m.wilczynski@samsung.com>

    soc: starfive: Add jh7110-hdmi-subsystem driver

This commit adds the parent driver for the monolithic JH7110 HDMI IP block.
It binds to the starfive,jh7110-hdmi-subsystem node, maps the shared
register block, creates a regmap, and populates child devices.

> diff --git a/drivers/soc/starfive/jh7110-hdmi-subsystem.c b/drivers/soc/s=
tarfive/jh7110-hdmi-subsystem.c
> new file mode 100644
> index 0000000000000..e64a222630459
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
[ ... ]
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +static const struct regmap_config starfive_hdmi_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 8,

[Severity: High]
Does configuring .val_bits =3D 8 cause the regmap-mmio backend to select 8-=
bit
memory accessors (writeb()/readb())?=20

On many 32-bit APB/AHB bus fabrics, issuing byte-wide memory transactions to
32-bit IP registers triggers synchronous external aborts (bus errors leading
to a kernel panic) or results in partial register corruption. This can be
triggered autonomously when the child drivers probe and attempt to read or
write HDMI registers via the shared regmap.

Since the fallback MMIO implementation in the inno-hdmi child driver uses
readl_relaxed() and writel_relaxed(), it appears the IP natively expects
32-bit physical accesses.

Should .val_bits =3D 32 be used here to guarantee regmap-mmio maps to safe
32-bit physical accessors?

> +	.max_register =3D 0x3fff,
> +};
> +
> +static int starfive_hdmi_subsys_probe(struct platform_device *pdev)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D12
