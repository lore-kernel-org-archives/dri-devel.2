Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF23FCD6E4C
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 04:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48E9112D81;
	Mon,  1 Jun 2026 04:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XcWEpd5i";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BFE4112D81
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 04:43:50 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5aa619653e4so1544478e87.1
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 21:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780289028; cv=none;
 d=google.com; s=arc-20240605;
 b=f0XKf8Pa1W/lnQyDUOONW5McDk19PV7zDyS3YrpgTB3+bTyorLqoJD4lo03G49WHyQ
 iGkR/GD5TLahsbj21WINjNg6dTnYSv66di+ANqFMvz4zHB1joXQ2nFl4SFM4y/YSwSh9
 WWPMph7wR32xrUuhyzj37aiudWD7IJPHrNJMiTPR3qzRw6SA+k337oC2EDZm6+P7b5l3
 DMuHUC/aJZ01v0gwWXrtYv7BwtmhcFwWv+9hagKgO/ENL8yAGBUAYjwLT4pl/PXGQmzD
 elo2laGIQ9O+noXoziRRBuE9mQs82Jju4WjN27vdoWMZgsnitkfmHE2rHi4QVN3Moi7N
 lQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zR1cIlAoMp5j8gAxy1mhFkkWhyjEsDYxuuZyh1K4KzI=;
 fh=OGcjNWD5TwBMbjccTTQWqHCQRliOmID7mOpQvTXdPwU=;
 b=gPyugQ+f5ePH/SROApfn77eqs1ruWBMvl3rMGNtwQimjtWXgTn11E/r5oGxvkJQIer
 m2j61nYVWRQ4//R+nmU0izlHLONdwOMdWlm4tAQiK/t+g+06cy/iWSOOyirFhuxHDD3V
 90n6oN5r2uGgrzPtvrzV4ZmkCK0K7JxycAt2KxzHGrBEkYKYFKEcA0I+wb9y0g4tcHk4
 5ah4kRCPaPTLlA/PSbH0DqfieSOX9+bCj5aaG8aWhy2EsJEoCydK2fQFMlWsA1B0kErU
 fYb0CjQN/XzvwXVA2wQTpxsCI4GlpTgQuD+b4M24r4AE1qL0ECJM/VEj6boil6df69OM
 SdOg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780289028; x=1780893828;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR1cIlAoMp5j8gAxy1mhFkkWhyjEsDYxuuZyh1K4KzI=;
 b=XcWEpd5iBJlejYfFCA0v1vQJHm33xNgcjeShC1nGIFx4fFoqyV/IJ9hoIQd2QL5O6k
 gII6ZKqKtizKyp5+v53ZCvdw+Vsur4dYWARViI6LDPDoRtIyRcnG9KiZ5jz+nyDmCyJQ
 g76qjAbQgLqWyG/s01HNBndJ83fjjjGlZI/Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780289028; x=1780893828;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zR1cIlAoMp5j8gAxy1mhFkkWhyjEsDYxuuZyh1K4KzI=;
 b=Qn3RmEm6EoLxcLoNSl6izzY5HYGF42hO5i3dM9WpVe3t9rZVr3Vr4hQ/UMNxbvDcKd
 PYvfr+x91H4BSTyJv6Td91uaRdGs8m/diTk2NNE5CTWqfDL9M/bBFOiEz5kzoqFCG1Yg
 NRb5VOJ4XmS/az4c1zLuRbvL58bV51a1XYSYeHSnYrhTEZk1BqXKR5Kzw6zhNi5hfXQW
 xY0E4jObcuFtw3zBu1Gtq6LoXSf2/eMUiKM+LAUdrvJ6qKwCibWe6b1CBb5GNH5my0UR
 KN2/u4m/TxYN4LDNRBJ7yK4u3avTftWpQv2VUmAZwXIgI/y5lxEk8QSGO3m8FW8ECl1W
 rKUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Wru0v7n10wWYVib80x2pRIZufhTvEvw1U7kK0Mghy90brFGAzXaJS5IkaVzrSd9b0/9xHqQ1RF7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAC94v8vd8IRrriaSMG7Xv4aOdaFb9kb1bii9BDATjOAvNQURT
 FKyGV6Knul2Eoo2vewgp2svXTlip1fhrdAcO88F1SBU/qix8j4Om/mtgqF7P3gBKvCRNQBji1So
 GzpAvnkQSfYNeMdsmdSoyIt9Aaa21wN1pQzj4EjiW
X-Gm-Gg: Acq92OEkNo/zrc9bdbyLGVwYWyfssQ8fkEz1YR67vEQfXODe1dJFl3YGsx5nMIk8goL
 3Rkvf29oV8jJsUlcnWZAWz451ju+gWtTclMMHrVjOKf3lFWVC5UC/ldAyOyv447m+l38z4DkSYh
 lgVI9Iw6xKFM16hWfzmV1xrGQa1b6h8AjSyf3qnaK/83H4Hj/ObJ7AOsluOWP+ggE8T+TlSH5R0
 Ctvy0J3tn239hUbswu0KU7/a7qzmdCi+PAXsjClB4Ek6bim25q2DDFCypxOHVyhKNRnKjATr7t3
 aDeR1KamDCDRFevyCLInwvw0jqHGPCMt5b2RZy2Q6czQsQE=
X-Received: by 2002:a05:6512:128b:b0:5a4:a85:ba3b with SMTP id
 2adb3069b0e04-5aa6145b9f6mr2247218e87.19.1780289028315; Sun, 31 May 2026
 21:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20260408065112eucas1p129f600747c27e999ec3d42504bc0fd2b@eucas1p1.samsung.com>
 <20260408065055.1353444-1-wenst@chromium.org>
 <d568fde6-8033-45c1-a2e1-13f8112f1193@samsung.com>
In-Reply-To: <d568fde6-8033-45c1-a2e1-13f8112f1193@samsung.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 1 Jun 2026 12:43:35 +0800
X-Gm-Features: AVHnY4JEx2SIxzD-JGLqt6co1RnSApTjEWdemWCmhyaNJcHSwWHrqMwqc83JIHs
Message-ID: <CAGXv+5HvO3OjBC=u4EZeB6Aza6oSN0KWrvbQgWEnR=jskczvwg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos/fimd: fix register offset type in
 fimd_trigger()
To: Inki Dae <inki.dae@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, May 6, 2026 at 2:35=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 08.04.2026 08:50, Chen-Yu Tsai wrote:
> > Sparse reports:
> >
> >     exynos_drm_fimd.c:992:39: warning: incorrect type in initializer (d=
ifferent address spaces)
> >     exynos_drm_fimd.c:992:39:    expected void *timing_base
> >     exynos_drm_fimd.c:992:39:    got void [noderef] __iomem *
> >     exynos_drm_fimd.c:1005:33: warning: incorrect type in argument 1 (d=
ifferent address spaces)
> >     exynos_drm_fimd.c:1005:33:    expected void const volatile [noderef=
] __iomem *addr
> >     exynos_drm_fimd.c:1005:33:    got void *
> >     exynos_drm_fimd.c:1007:33: warning: incorrect type in argument 2 (d=
ifferent address spaces)
> >     exynos_drm_fimd.c:1007:33:    expected void volatile [noderef] __io=
mem *addr
> >     exynos_drm_fimd.c:1007:33:    got void *
> >
> > Add "__iomem" to *timing_base to fix its type.
> >
> > Fixes: 3854fab24e89 ("drm/exynos: fimd: support LCD I80 interface")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Inki, you missed this patch as well.


ChenYu

> > ---
> > random warning I found while checking for the size_t warning.
> > ---
> >  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm=
/exynos/exynos_drm_fimd.c
> > index b6abdc4f2b0a..695d3515d421 100644
> > --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > @@ -989,7 +989,7 @@ static void fimd_trigger(struct device *dev)
> >  {
> >       struct fimd_context *ctx =3D dev_get_drvdata(dev);
> >       const struct fimd_driver_data *driver_data =3D ctx->driver_data;
> > -     void *timing_base =3D ctx->regs + driver_data->timing_base;
> > +     void __iomem *timing_base =3D ctx->regs + driver_data->timing_bas=
e;
> >       u32 reg;
> >
> >        /*
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
