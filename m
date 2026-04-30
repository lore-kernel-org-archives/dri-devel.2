Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41306FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DC910E0F8;
	Thu, 30 Apr 2026 08:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ruUpEgF2";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD0510E0F8
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:28:36 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso351011f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 01:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777537715; cv=none;
 d=google.com; s=arc-20240605;
 b=Teq0TQGReyT7woBHcH5rKWDN/LKTiYeSHYmnIWQ8DIMBI9rzSB7LZgQn178ejQd8i0
 7ffghH4M5JqvldiKT6Aux4txCYxYIwsYT7EVaICKy6BAGYQnZd39HdWRdy6oIn3+BENR
 IcL0yAeeVa9lX+66G+h5ndDYj6EquI81MSlo9OpsXDx2pvj3LH1s+12SgcAcOgmlCUmE
 tlctItZx4nO2j/2DwPeNyyvD4elsVT+Wf9fvaF5HlIuOHEFqYA2rv/mD9nlDY83pHYE2
 3Hzqzj5tAVxkefgaq4cpc3jrzJGkPSe4rVvkMnAVxLSEco2K4L15+JavFrNhMbu5tMRM
 Fv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=73zzoZ4sPyqQM1ddXXgHuIWR1EcT9Ao9jm25y+/BQQM=;
 fh=f1cWVE6T3+KAakBaQSVJBnGUGjpY/olWW7yU67yv/uY=;
 b=I1j2W8zXtIT80+NqDgTNzGi01oYsMqyp+rL7FXiZSQTnvt/jkhfaONMauTj6r+Ybql
 dHYAJV6bcknvuLa4sjVovVteBpMvPPnUduaC0e2nxzbJ6EIEHsvauYqpo5iisBwEwvb5
 r0C7RpdxIM7Mvu8nI9WVvLLbQNYAsf8Dqe7NLht6Skrob1n7NDBP9vbhoVf7ipmZtjRS
 Dft3pDzaWu+YSMTksjV+GexXDVFDfnAWksK4lVKUi57IQdC01ULXXVbQjvP6dCIYsSDG
 xi6RF+AG6IewlpRjysCAxs9aU6CbmFncUQ/njcavMyfxARsopzlXJhsHZHGgTfviRcHk
 ZyMg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777537715; x=1778142515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73zzoZ4sPyqQM1ddXXgHuIWR1EcT9Ao9jm25y+/BQQM=;
 b=ruUpEgF2qAj36SPwbYWFl5x5Gbg+rD7krjbtPpZunWvA5O1gNucB9Q1l87lp6aji5a
 9tDByte4QG776IYOnYiIJk5dPoXGl/TGuni1JyRcP2Z88wMiUZ3qjLAsbWZ48ngTpNNw
 3K73jqnnqgq0+wBJNn2R5JAJlE84HMaPZTefv8z5a6gA5hdY2YzQHn4ykdWFgzK8t4tt
 qfUCOOH+Gz5B3Vh65UK2OqK0k3P18hVmZjJTaHM1prrhYZ4+a6tewityxQkAvivqKoxt
 AxRDKH8fmvpYCIXcKS51iGD4h++VAN2wNwC8lqz1u8QcFfPPvSK6frba1X0f0UT8ALup
 JQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777537715; x=1778142515;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=73zzoZ4sPyqQM1ddXXgHuIWR1EcT9Ao9jm25y+/BQQM=;
 b=SG8TGSWd+DZ5YyDESpdDijWt13s4EFGkzqyxWdUXqiMjiX0FyOF47hSY51AS2rX9Oo
 vejcy02ZQcCWmHJO5Ga2R06JM57nrTWUOO6KWKzjfpWYpX0q2ZiuymECa72M2gNFXXBN
 uxJKWV7kqz6TfLKFdeZPuFnL24IcmX4gXqeB6rZvgp9QRJKncaFSHJYVUslImBgT/fYL
 SzXxR0fVcRovo1SbLJzn6QTG8s/5ZYIyeqjXGUkj2QPckXBkEFm4O1mdy/x7IbIPInU4
 9khf/Epto3lFebYnS/wcnuv9oQlIYRxsWm008FGM6sq65MnCepS5t8/j2Yjz66P8lcjg
 NFJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8SBHA7o0+IVK2v4zJ7pcLMx9JnkjwjJQ97M+ikJm7So/CTjp3v3RcEHdFiyzLDQGHHGGvujoUMQg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy51RiEpx4Jw3xoXrPEy3Vs4DbsW+Q6aXg6pJT8JmuIFAdCln2K
 KRcA+9sDGQt7TJAhDBL+5avs1m9a87nm5w/vX+AgYn28iz7JrU8BP0grhK8osNb/yOAQ5dgWhlp
 mSOG9M5NlaDBzxJtk1aMXmWQdPkTkUH8=
X-Gm-Gg: AeBDieuLeChiBm6C5YjEtZ5wFn/p3T8ktCDpBZsxcDSvtbsivz1c+vhr7O4D2C6QsCJ
 p1P1QURK7u5r7NkSmT9w+jYkFEePDwYIinglQGHM4XbRgZdWtQKjHb3n0EPp3TYorIKwUMjIlM5
 BX4JtH4xB0mLz6xKqVvCOFSnn5Q7AF+YTiYMMWLe0zKL4mmBCMPN2o2yOrx8Ei3ON7WNTLaCFVq
 Mgil/MkBZkgrqpx83qmJWLUBlMsdJ9ShqjdeUho1h0u5NwhgeuviEznGMzkDIlLXNNtRYUWMxkV
 eCfyj0vlXMuVwxSQx+3v9DsOqOCwThfQqdG0MHy16lUqL+4Npt+T58gFXyLllkvu6cTGlEGx4jX
 3E4HEu78PiR0kcP7H
X-Received: by 2002:a05:6000:136c:b0:449:9aee:4581 with SMTP id
 ffacd0b85a97d-4499aee4685mr984254f8f.12.1777537714956; Thu, 30 Apr 2026
 01:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260429170012.366537-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUne5vUermQ7NnN67-QL_PM-SxJQogFpmSVUo1ussohXw@mail.gmail.com>
In-Reply-To: <CAMuHMdUne5vUermQ7NnN67-QL_PM-SxJQogFpmSVUo1ussohXw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 30 Apr 2026 09:28:08 +0100
X-Gm-Features: AVHnY4LhGhTKHDnRjjANWtMgzHHdQKdgB_6XkN5IfVS_13v0QQhibAF2kKLjvfg
Message-ID: <CA+V-a8uGycC4gJ4X=j4mXTuWsRWx7OjtUkg7ttHgNNKHh--g=w@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm: renesas: rz-du: Add support for RZ/T2H SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Geert,

On Thu, Apr 30, 2026 at 8:55=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Wed, 29 Apr 2026 at 19:00, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The RZ/T2H (R9A09G077) SoC includes a DU with a DPI interface,
> > supporting resolutions up to WXGA with two RPFs for layer blending.
> > Unlike earlier RZ/G2L SoCs, RZ/T2H requires explicit assertion of a
> > DPI output-enable signal (DU_MCR0_DPI_EN) during CRTC startup.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
> > @@ -20,6 +20,8 @@
> >  struct device;
> >  struct drm_property;
> >
> > +#define RZG2L_DU_FEATURE_DPIO_OE       BIT(0)  /* Has DPIO output enab=
le control */
>
> Note that this addition conflicts with
>
>     #define RZG2L_DU_FEATURE_SMUX2_DSI_CLK BIT(0) /* Per output mux */
>
> in "[PATCH v6 15/21] drm: renesas: rz-du: Add RZ/G3E support"
> https://lore.kernel.org/11313371ef0b31cb5f014e171ba0d9868eb0710d.17756368=
98.git.tommaso.merciai.xr@bp.renesas.com/
>
Tommaso has kindly agreed to rebase his patches on top of T2H, as the
G3E DU design is still under discussion, and the T2H DU pipeline is
simpler than the G3E one.

Cheers,
Prabhakar

> > +
> >  enum rzg2l_du_output {
> >         RZG2L_DU_OUTPUT_DSI0,
> >         RZG2L_DU_OUTPUT_DPAD0,
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
