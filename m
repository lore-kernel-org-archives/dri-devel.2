Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBD606A327
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6Tmr4oD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F44010E257;
	Sun, 15 Nov 2026 06:27:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83DC410E257
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 574354328E;
 Sun, 15 Nov 2026 06:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC37F1F000C4;
 Sun, 15 Nov 2026 06:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794724024;
 bh=iVTcBxQQMl4QzfL9Wdiozi+f51d/Q7jY5E2o0iqZOks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W6Tmr4oDHfCtdgw/mn8gk1am3AOunmQEzWCVaHlo+C38Q38TIpM/Va0iNihGLgj97
 oWdVVyR1aFu3kSWSyr7BRNSg8FypnDw+lhEPic63LahlAun78swqc/zOt0Z3bRp9Qm
 TZlRreph8au3yoSth1yhBgu/5yAIsYSQwyFUEVcxfiJWaGQsR+oKUMzHINFdAMtlfE
 j3MKvhTFvB8oHPNSRyGdNv1Qa/Dv34VjZ0MVDj5nZJ3XIXiaVf0I/2h00wEkAE2jMY
 gSi4DU+BdNvbkzi/YGmY4ADuVi/5xwg/MD4GoOML4H9HCA6h1KjIitvUlbvZBy35Nv
 MPMe7ebcJ5e2A==
Message-ID: <sashiko-outbox-215249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] clk: sunxi-ng: de2: Export register regmap for DE33
To: "Jernej Skrabec" <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org
In-Reply-To: <20261115061102.229680-3-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-3-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 06:27:03 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] clk: sunxi-ng: de2: missing select REGMAP_MMIO for
  SUN8I_DE2_CCU
--

commit d1c006fcc75e6e1facbfb7f265581bef0d4d672a
Author: Jernej Skrabec <jernej.skrabec@gmail.com>

clk: sunxi-ng: de2: Export register regmap for DE33

This commit removes the hardcoded DE33 plane mapping writes from the clock
driver and exports those registers via an MMIO regmap instead.

> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
> index 6ec6c0dc4c261..f17570efafaae 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c

[ ... ]

> @@ -336,13 +367,19 @@ static int sunxi_de2_clk_probe(struct platform_devi=
ce *pdev)
>  	}
> =20
>  	/*
> -	 * The DE33 requires these additional (unknown) registers set
> +	 * The DE33 requires these additional plane mapping registers set
>  	 * during initialisation.
>  	 */
>  	if (of_device_is_compatible(pdev->dev.of_node,
>  				    "allwinner,sun50i-h616-de33-clk")) {
> -		writel(0, reg + 0x24);
> -		writel(0x0000a980, reg + 0x28);
> +		struct regmap *regmap;
> +
> +		regmap =3D devm_regmap_init_mmio(&pdev->dev, reg,
> +					       &sun8i_de2_ccu_regmap_config);
> +		if (IS_ERR(regmap)) {
> +			ret =3D PTR_ERR(regmap);
> +			goto err_assert_reset;
> +		}
>  	}

[Severity: Medium]
Should SUN8I_DE2_CCU select REGMAP_MMIO in drivers/clk/sunxi-ng/Kconfig?

Without it, enabling SUN8I_DE2_CCU when REGMAP_MMIO is disabled (for
example under COMPILE_TEST=3Dy with ARCH_SUNXI=3Dn) or built as a module wi=
th
SUN8I_DE2_CCU=3Dy breaks compilation on sun8i_de2_ccu_regmap_config or fails
to link __devm_regmap_init_mmio_clk().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115061102.2296=
80-1-jernej.skrabec@gmail.com?part=3D2
