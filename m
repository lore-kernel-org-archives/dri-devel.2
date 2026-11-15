Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D7606A330
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmryQVy3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64D2510E8BC;
	Sun, 15 Nov 2026 12:07:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2B910E860
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 12:07:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA16B43C95
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 12:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A391F000CB
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794744451;
 bh=pAyFOMytrC+WHeplIQk/P9QT+U18pl2Kv43Ux7MJxzk=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=QmryQVy3E4N4wEuCGP5CyTEkNTyKEYCUZRKbip0gcAAbNA8XjVCONvX1P27ojkmK2
 7wlRSq6lkiWMj3EkWkwQgJdwRLGN7RGgtGvjP8nhcKGYuwoA7jYvt25xAHHvQj7G0+
 zhaffkcEJHF9LY/5rfg8kj/dyKMuUp1emC6EF0WDhzRWkh8e8ehO6K2cwPgIPToN2w
 y1nhTkR+Z2VIr1K7WGDrFwhGbNfmFstNZRPdMB3BL8jzHwGas9wcBEF0bxFKT6y3uc
 /A3bifvu+XZpGDBD9fN14pMIu81f8POg8z4RcF0j/qFeYnsE3dJmsJc176FcysyTvV
 rPFzIWhB+6NuQ==
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-3ae1fd4252fso25741341fa.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 04:07:31 -0800 (PST)
X-Gm-Message-State: APuU4Z+6RW0J8aaToZhV4vE8/6TROtLzSaXtKbAd6qVFxcST3ld3XScF
 SR+jBfh3bAiTN5VxLC9BsnLiVoC8RN23wT5SdDcdlqFVSvpIQf98CNT6+GBp1YChDeHtiXdanyG
 6JmWWiX9zPnnW9msMH0TuotGAb4eDeZk=
X-Received: by 2002:a05:651c:b26:b0:3ab:3bf3:1606 with SMTP id
 38308e7fff4ca-3ae2b52ecbemr25194061fa.24.1794744450062; Sun, 15 Nov 2026
 04:07:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
 <20261115061102.229680-3-jernej.skrabec@gmail.com>
 <sashiko-outbox-215249@kernel.org>
In-Reply-To: <sashiko-outbox-215249@kernel.org>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Sun, 15 Nov 2026 20:07:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v6544+a2Cv65u8ZCsJmP4d6DD8W2Kb3WOtvo8=Q2+snt2w@mail.gmail.com>
X-Gm-Features: AclHuK_eMLnNxsMBol5YFdkTkMTb1ru6MI-INl_vc-Xaa50KKeV9dybfAnsle1E
Message-ID: <CAGb2v6544+a2Cv65u8ZCsJmP4d6DD8W2Kb3WOtvo8=Q2+snt2w@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] clk: sunxi-ng: de2: Export register regmap for DE33
To: sashiko-reviews@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-sunxi@lists.linux.dev, linux-clk@vger.kernel.org, robh@kernel.org, 
 conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 2:27=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] clk: sunxi-ng: de2: missing select REGMAP_MMIO for
>   SUN8I_DE2_CCU

Added while applying.

> --
>
> commit d1c006fcc75e6e1facbfb7f265581bef0d4d672a
> Author: Jernej Skrabec <jernej.skrabec@gmail.com>
>
> clk: sunxi-ng: de2: Export register regmap for DE33
>
> This commit removes the hardcoded DE33 plane mapping writes from the cloc=
k
> driver and exports those registers via an MMIO regmap instead.
>
> > diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-n=
g/ccu-sun8i-de2.c
> > index 6ec6c0dc4c261..f17570efafaae 100644
> > --- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
> > +++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
>
> [ ... ]
>
> > @@ -336,13 +367,19 @@ static int sunxi_de2_clk_probe(struct platform_de=
vice *pdev)
> >       }
> >
> >       /*
> > -      * The DE33 requires these additional (unknown) registers set
> > +      * The DE33 requires these additional plane mapping registers set
> >        * during initialisation.
> >        */
> >       if (of_device_is_compatible(pdev->dev.of_node,
> >                                   "allwinner,sun50i-h616-de33-clk")) {
> > -             writel(0, reg + 0x24);
> > -             writel(0x0000a980, reg + 0x28);
> > +             struct regmap *regmap;
> > +
> > +             regmap =3D devm_regmap_init_mmio(&pdev->dev, reg,
> > +                                            &sun8i_de2_ccu_regmap_conf=
ig);
> > +             if (IS_ERR(regmap)) {
> > +                     ret =3D PTR_ERR(regmap);
> > +                     goto err_assert_reset;
> > +             }
> >       }
>
> [Severity: Medium]
> Should SUN8I_DE2_CCU select REGMAP_MMIO in drivers/clk/sunxi-ng/Kconfig?
>
> Without it, enabling SUN8I_DE2_CCU when REGMAP_MMIO is disabled (for
> example under COMPILE_TEST=3Dy with ARCH_SUNXI=3Dn) or built as a module =
with
> SUN8I_DE2_CCU=3Dy breaks compilation on sun8i_de2_ccu_regmap_config or fa=
ils
> to link __devm_regmap_init_mmio_clk().
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115061102.22=
9680-1-jernej.skrabec@gmail.com?part=3D2
>
