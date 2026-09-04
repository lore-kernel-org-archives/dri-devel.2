Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58F6C624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2065910E540;
	Fri,  4 Sep 2026 13:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gpBXPqMS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 395F910E540
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:52:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AAE4601F0;
 Fri,  4 Sep 2026 13:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8241F00A3D;
 Fri,  4 Sep 2026 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788529955;
 bh=JLgwTSSCpM3L6iDJ0ynlXolF/uJm18acCEZZpWdVymM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gpBXPqMS9xzgulJaIs2j+/CHJyl9XJXcCIVop/7FoAmnGIGxVjkGQ0Bt1M3HHXZU5
 0szWoycEbq0vzieUVJayBYrhMw6lrAUWTc6CVrWItFRaUJ0/xyxyP21URl5HAjCeIi
 4+GaztiJvJvT+NwE72sl5AVtstCxs2iD5F0AbxJpR/+6J1Sut+AuX+txXwkAs5nuhp
 tcprpCwS+eLJ442vVGtmiYiIo9ghEacZaF65eMZ8+KhzKuSL5qvzj2ATVyO78te9MD
 fJnbQO3t+DYnCJspgko0DhxABsc9yGxx9Q8/I/rjfE0mLelE175kHc8IY5hP0Ev8CR
 e0UlTKnHDPSnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/19] soc: starfive: Add jh7110-hdmi-subsystem driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, lee@kernel.org,
 mfd@lists.linux.dev, linux-phy@lists.infradead.org, vkoul@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20260904-jh7110-clean-send-v3-11-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132729eucas1p1bd78eb90feaf90b6265c13fc7bf43ada@eucas1p1.samsung.com>
 <20260904-jh7110-clean-send-v3-11-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:52:33 +0000
Message-Id: <20260904135234.5D8241F00A3D@smtp.kernel.org>
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
- [High] Incorrect regmap configuration (.val_bits =3D 8) forces byte-wise =
accesses on a 32-bit register file, which may cause bus faults or ignored w=
rites.
--

commit 83ac96938fc0f15d53cdae0501c6e430a17c1c1d
Author: Michal Wilczynski <m.wilczynski@samsung.com>
soc: starfive: Add jh7110-hdmi-subsystem driver

This commit introduces a parent driver for the monolithic StarFive JH7110
HDMI IP block. It maps the shared register block and creates child devices
for the PHY and controller using a shared regmap.

> diff --git a/drivers/soc/starfive/jh7110-hdmi-subsystem.c b/drivers/soc/s=
tarfive/jh7110-hdmi-subsystem.c
> new file mode 100644
> index 0000000000000..e05b91825be4d
> --- /dev/null
> +++ b/drivers/soc/starfive/jh7110-hdmi-subsystem.c
[ ... ]
> +static const struct regmap_config starfive_hdmi_regmap_config =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 8,

[Severity: High]
Will this regmap configuration cause byte-wise memory accesses on a 32-bit
register file?=20

Setting .val_bits =3D 8 forces the regmap core to use 8-bit readb()/writeb()
accesses instead of 32-bit readl()/writel(). The underlying Innosilicon
HDMI IP has registers spaced by 4 bytes and natively expects 32-bit
accesses.

On RISC-V platforms like the JH7110, byte-wise access to 32-bit APB
peripherals typically triggers a Store/Load Access Fault or results in
silently ignored writes.

> +	.max_register =3D 0x3fff,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D11
