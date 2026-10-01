Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B6CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046E510E31E;
	Thu,  1 Oct 2026 08:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="baPoY7xW";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE62B10E31E
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 08:29:48 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so37171775e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 01:29:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790843387; cv=none;
 d=google.com; s=arc-20260327;
 b=dCPkFZ2//TnyZmrLxYiTiXxNiEErRQ1fbjx0nznlpg65f2lasNAxIeMd+tzuY8Z2DE
 UCK1t4xNvMk3QGMSmM2Wl0MJw27jpp+Fwx4hCZWfjO/ZZIAJXr9za31ud22ANutvfKtb
 4zBd5UYNFIdQrkER4sv0tX2Qqu/bIeQ6JF8WfEn7WU2EcelEI1e6bqBiON7XcwbCeA39
 2tgWrnJLAMaoomFL3/dooibArmqcj3xQ5EtvLPG2+mTa3/m5jLNzzZbtb+aUQutOGy6W
 XZ8la7EUD3X8JffYHIIKok4EW75X3hSPPHJbPmxq9ZbIcWqb3rSACJHwP9efKiP/p26/
 s3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KdOx0gTEKpUZsHoYWW+nnd+IvZKeex/gkJLuhvb4cno=;
 fh=eX2LCZNELX8I32gyuBLdXw7OpCW5eKmKJrNMWhbbOfI=;
 b=goV3QSWWqwZ2af8/HyiKkQi+6HcIXCBCAjIq5oh6CLCNEDRBTR/yGPmBkEHdiu9ncm
 sLt16OuXU4tBbn/QS1f+i23DA2G6TVEHb5SnkQaWBEwme9dklYRG6IZWPglDsQBYNwKn
 flDSeHxRsNy6iPdVC0GuDVzyg0WoHZdXKw+h6/4K6UTxA39Z1VJbca1ib0mEQMgpkFRj
 d+CDMtvRNGsGcruWOXYyniaFSgoITY5F5EsuYISpRvipIF+1DZ8Gtpe3rLjVFDIqKaNX
 K5XJCIoB/J694NiC41lkHIJZ9Bev0IV0B9FIl1isHSAfpyC2HWeHHNFREVZxq23N9XIe
 3kEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790843387; x=1791448187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KdOx0gTEKpUZsHoYWW+nnd+IvZKeex/gkJLuhvb4cno=;
 b=baPoY7xWh9kN3IcjLm7Exeyk1VI8nJ/5mICa0NPhs3ZWQ5OKXASBXnoBts+6e/OBxF
 7TKsQCjGL3kLNFa/rQzVt6bJMGx/QhpSZZ8bH5D0vihUSkCka5pz7ai0ZKzqA8ZoZmZ3
 8NjOg4/yONBT4BC4fkbRYEQBv6k5yo9GZSq7aVszBRbm1FiEA9ncvlWKpktlEuyGaThH
 flsVEcz4oyu0K4XirUrkConY8b+VJjyDJ+g9jxupYZ9zazLWKP3OJnEN/R2wvzizYlSR
 hyh2PRpB871OFNNYIWOyFDQ4PbgSHg9NVBnmWSaWxURyBneTKfH5UvPLFrvCCM8datS7
 Td4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790843387; x=1791448187;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KdOx0gTEKpUZsHoYWW+nnd+IvZKeex/gkJLuhvb4cno=;
 b=OPtqeWUFhjXsjrYgCZ2sZiKgsnB1H05k1bN3uJHt9qZjwtHRtQgsdMVDf9R3fODiPD
 +OsEZSGJQ17G7JYLKupb1IzWOtkYfgzWxd1s66f5bpqgFQYroJoE+HNWkaczT+AE2RVv
 uHh7YO0MN9eV3Geh5Wl7G4D68XtBaoxaHedoeKR+64JHsbEQume0bRlWJUFRgUEKttUi
 nEszAksNUxaaP6EWr7PLYY3X2B6kZ1Bf2i+i5Gurlh9VlwFhhLZAjMcw2qCs1j5PHnZk
 8R/DErwszskv2bZQc2Ld8ItagQzmKZsAW4O6sv3BEuE5+ObnYCvfRfKZG1g/j6hzJ7uS
 52sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1YP3rOb7JCeO/BIChM0fLKQ1TllRHeTEgJwjJSdDe/eXlYJ4ZqAEJb+/VGxB/Ri2Hd18fq5Zhwb4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+WPFu+IbJuVjMyxpGHCacxhM58BliUgARFbIRg1QTEBhR/ECN
 Fn1G4E6hpi/UxzYjX10Y0RSm4yJ1vZfSUqd8+b5uVBdevVT5wHJ82Rfva3bhHL/r213KYixfylm
 3Lew4CSmAcoIFs9T5ABK/pDaZAUCE8G0=
X-Gm-Gg: AYBFou3epwABu8BqJGTpyKEB56vH0HGInhAqiA1iFRHjxLQ0V1KkqrJq7L9BhquRClA
 CrWGTB+hJuESrq66nIJj4Gc0tgVMGgGrKNCjxWuTwoM4Qsz4Bvp+EvU4YPQ0RgZE+nMu5wP5fRD
 ma+bFtL3WGZoYoD7OKw7dcKU2AMPk4GtzZ71RKkzO+FFN6eS/Iw2Ycbz1c5WZXCcJyWnFnxUOJM
 jhRChbjp1vlCFbF3TnqukXkflbpBR6zV4WXSmk5CXiLQQ4zsbXe+zC5MiKnd6SnwPv/QDzVpBce
 yYVaZLOsp8EXo5W+qZQ88YQ4ZMb0iTmqEFIuulN/uv1kcLUzaQ+hAgagrxgpeEyAvBehYjc7ZWO
 tiXKz0uDnUcxb8iKj9XXl87c17egQ317dbXfFheupqA==
X-Received: by 2002:a05:600c:4fd5:b0:49f:fed0:fc47 with SMTP id
 5b1f17b1804b1-4a01ad90a51mr66571105e9.1.1790843386944; Thu, 01 Oct 2026
 01:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
 <20260930133257.23210-5-biju.das.jz@bp.renesas.com>
 <CA+V-a8tQZONUkeZYFBTvO+L+FTnrq6AE_aJQsm7MFX9CBnA-8w@mail.gmail.com>
 <TY3PR01MB1134680E91884A191791DEC4D868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB1134680E91884A191791DEC4D868A2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 1 Oct 2026 09:29:20 +0100
X-Gm-Features: AclHuK8vK2trvJG7pwZyhY7YNxMxLrfAscaVvEO95lXZ7MjfGAVxGE8Vb69_9TE
Message-ID: <CA+V-a8u4E8XSSXH73YEUmGJ0GCBKjmZJtBS0bHJQangU_-Wkxg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] drm: renesas: rzg2l_mipi_dsi: Add support for DSI
 PWRRDY
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "magnus.damm" <magnus.damm@gmail.com>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Biju,

On Thu, Oct 1, 2026 at 9:15=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.com=
> wrote:
>
> Hi Prabhakar,
>
> Thanks for the feedback.
>
> > -----Original Message-----
> > From: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: 01 October 2026 09:07
> > Subject: Re: [PATCH v4 4/9] drm: renesas: rzg2l_mipi_dsi: Add support f=
or DSI PWRRDY
> >
> > Hi Biju,
> >
> > Thank you for the patch.
> >
> > On Wed, Sep 30, 2026 at 3:47=E2=80=AFPM Biju <biju.das.au@gmail.com> wr=
ote:
> > >
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > The register for controlling power to the DSI region is in the SYSC
> > > (System Controller) block. Add support for controlling the DSI PWRRDY
> > > signal so the driver can efficiently manage power to the DSI region.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v3->v4:
> > >  * Dropped pwrrdy variable from struct rzg2l_mipi_dsi_hw_info and ins=
tead
> > >    using feature flag RZ_MIPI_DSI_FEATURE_PWRRDY
> > >  * Dropped rzg2l_mipi_dsi_pwrrdy_off() as it is taken care by
> > >    devm_pwrseq_get().
> > > v2->v3:
> > >  * Updated powerseq API names.
> > > v1->v2:
> > >  * Switched to power sequence for handling pwrrdy signal.
> > >  * Dropped header file regmap.h and mfd/syscon.h
> > >  * Added header file pwrseq/consumer.h
> > > ---
> > >  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 27 +++++++++++++++++=
++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > index d67e1230b70c..5263b2b8f1ca 100644
> > > --- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > +++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/of_graph.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/pwrseq/consumer.h>
> > >  #include <linux/reset.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/units.h>
> > > @@ -38,6 +39,7 @@ MODULE_IMPORT_NS("RZV2H_CPG");
> > >  #define RZG2L_DCS_BUF_SIZE     128 /* Maximum DCS buffer size in ext=
ernal memory. */
> > >
> > >  #define RZ_MIPI_DSI_FEATURE_16BPP      BIT(0)
> > > +#define RZ_MIPI_DSI_FEATURE_PWRRDY     BIT(1)
> > >
> > >  struct rzg2l_mipi_dsi;
> > >
> > > @@ -87,6 +89,8 @@ struct rzg2l_mipi_dsi {
> > >         struct clk *vclk;
> > >         struct clk *lpclk;
> > >
> > > +       struct pwrseq_desc *pwrseq;
> > > +
> > >         enum mipi_dsi_pixel_format format;
> > >         unsigned int num_data_lanes;
> > >         unsigned int lanes;
> > > @@ -1396,6 +1400,25 @@ static const struct dev_pm_ops rzg2l_mipi_pm_o=
ps =3D {
> > >   * Probe & Remove
> > >   */
> > >
> > > +static int rzg2l_mipi_dsi_pwrrdy_init(struct rzg2l_mipi_dsi *dsi) {
> > > +       if (!(dsi->info->features & RZ_MIPI_DSI_FEATURE_PWRRDY))
> > > +               return 0;
> > > +
> > > +       dsi->pwrseq =3D devm_pwrseq_get(dsi->dev, "dsi-pwrrdy");
> > > +       if (IS_ERR(dsi->pwrseq)) {
> > > +               /*
> > > +                * This platform requires a sequencer. If we can't ge=
t it, we
> > > +                * must return the error (including -EPROBE_DEFER to =
wait for
> > > +                * the provider to appear)
> > > +                */
> > > +               return dev_err_probe(dsi->dev, PTR_ERR(dsi->pwrseq),
> > > +                                    "Failed to get required power se=
quencer\n");
> > > +       }
> > > +
> > > +       return pwrseq_enable(dsi->pwrseq);
> > Do we want to add a devm action to disable the pwrseq when the DSI driv=
er is removed?
>
> It is taken care by devm_pwrseq_put() the release handler
> that calls pwrseq_disable().
>
>         if (desc->powered_on)
>                 pwrseq_disable(desc);
>
Ahh perfect!

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar
