Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D386FCD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3588D10EB9F;
	Sun,  7 Jun 2026 21:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sqhv7J7M";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D2B10EB9F
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:02:18 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-bebb72b845aso524232966b.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780866137; cv=none;
 d=google.com; s=arc-20240605;
 b=Smf9jTSjHUJn1NfiDZYB6iG3We1K/OAwcuEP5bGBopCrVL4Tz9hDu/jkj0MiouD3qb
 DXcfiA38J3EZKpo+oymeprsEc9Mi03b7Rbc/ogWYw3oFco33n4dcUIGILka24CxRGlbf
 dXtn7d77acguCLv6IanXpoMAvbMjieCKdJqHYcDHbk8UT2f3dJTXq2NNh8auEGFnRyN7
 giJoFfAJmHAQE8cdU1Il4fnBSi2tE5LW6eELShCnXmZVVpl23ODcpKv+cGdE9Brly/p/
 QJM2aBddVn4LYLNf5j7JAwhew/zA9dC6HwQSEVSgf/RFqNN7FSAZ/QhBWLcbKAo1X1EV
 ANNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A+9fNpCsE6s4qptEKDyb1NK+xycGWP9ueu0opDX1ZcA=;
 fh=vOuI60ZKpVttOC5EOKGMSLIKemaQCEtXDwsPp7aYqxE=;
 b=jOesAeQJ0dkSiPktm7WoMBSZHkGGGClgFt4UqRDUTh7KGp30rox0YaVIIPz5SszOaS
 gCvwO+z06XZ2Nt3RGGslUX12tSvj7qhHRZNmZ9GMH77RFIStB9d00aEAdN1eS9Vs1vMa
 krPT5z6EUeXNjYq+TUgjuAmczmeVZIQruD5uW8bDBfw1eJJX/nxhWAz62liZsTmI6ZUg
 yawdJUmrPfobzymfi2Z69ZOGDXCCJ3r3Pis2NThVqftevCZHKHPF5d+LYL6dRVaeAXV1
 uekrXVS93LKleHLS2cvfNuIx4JytMNTKz9HSI5tOcODr+iAhKHyhCGaXQ1xXC37BUg6M
 /npA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780866137; x=1781470937; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+9fNpCsE6s4qptEKDyb1NK+xycGWP9ueu0opDX1ZcA=;
 b=Sqhv7J7MH/D+5WlYuF2ff8LHir4b5C5z5SiE1GuYZeGRQDt1qe1KPaQAIxBUrCiGK4
 LSg1fBuER/Dpeq6CgUrJcTphUJsuSbjPaQEwrwBU2QDEmN0Ooogx9stgZ1Oy9H+FGwlY
 ruyCoCIh+sPZAjKh6MmNiLnXrOmjVB6p2X0ikVVieog7uWfB7A9+jaGw+bBs8QFI7gdT
 qeuui8JHWjOIlmWvomk27ZoVtxvLX+eXF5y7xgFdNysk3nFzkyNcfNSs39GHO5nLBXD9
 mbVWP7+m9z86meaUDGSPcZOnAk3/dHFm49WwoxBXesOCO/XWsLuVmjfy5Htf93xR6bgm
 PlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780866137; x=1781470937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A+9fNpCsE6s4qptEKDyb1NK+xycGWP9ueu0opDX1ZcA=;
 b=RoiQK4P5nHKhLDA1CrF73S6apB8d053gKDaHvjIC8F+dv/eZQee44pGXEzO46/iYlF
 F0hiqLQKYuguP7fKcjQaQ1xNJAYtB+g6yLXHaIp2rFpupjXFPFvfa5KC5zR4MxczFunY
 vO9KHVfHmjGAj/lto318FqXsr+oG42eYtWfXhP9xFBp48O0xiMboyQEenUS7jcveaHXy
 rnCscBgrQ8KAx2ZECpi08bHSXWZQ3vKRXvwkVWzZKoO5VTiNGM+Nu6VMn8ToaUxdnNz9
 DcHdz76pZkWaoBRNAigHZFoGes7fSBF//FlRnLN1ixCtxNsHO/KuQ46MDTFuDjHmt7k1
 StLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e9L1n+I1VS7Wk/8aJVGv3ekDJbLZ1zv76dQgxn3IzRzubDTJB2TAG04dB9+bc+NhN1IA39kZU26U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhHpF6y09SkaSmRq6IN9LZvYR8WESath+QMW5kkvsAxVsVYsyf
 ZtJRQzFz1V9ybaXIzxqKljZtshQNefz/OMN9N0CyANxM5o53jhzkDNA/NmPxTNk6n9UB5d88YEe
 hWwAaFzGH6CwA/J98xeRPQt0eEK+rdhE=
X-Gm-Gg: Acq92OE1NABEnAqsMbj7Gx/prPKbzDeshH6ejHt+U5uLOJrrNyFHzKgthQNUVURNJqs
 8ob7iU46fWC3vpqzGb/T6+sJNaHjlCsYKMpPXEd/vla2dvzMvrjWNeqkFeoGz4BR/Ogx3/zVfWo
 2/PcWuVK1jc9kxft2ZelgMUd1U9Oj1GRpo3plGpfI+byMrcDNZxoXZuuCGGWKZvNziyVjSCT2D9
 w7ORcy/vyQIm/EYm2/ENBPW1KMeJXTDReAMFk1hpqVvxnTEPDzUf/qcrHXgg0rTPrRwl1TvYa7s
 tOHxNcZvSCRxkgmbnwlTqG1cMgJs0WzWmn7fi6B9a/3hJ84g1Eo=
X-Received: by 2002:a17:907:2718:b0:bea:f4e0:c7b9 with SMTP id
 a640c23a62f3a-bf370d638ccmr437637066b.19.1780866136465; Sun, 07 Jun 2026
 14:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
 <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
In-Reply-To: <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Sun, 7 Jun 2026 23:05:03 +0200
X-Gm-Features: AVVi8Cf-JVkWYJtDYXL1xfOVyosnpbnb7w4PJV4kFFggOhSQTxoQOwyJz0V_ZFQ
Message-ID: <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
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

Hi Chaoyi,

> As I said, it is v2. Could you please try using the code below instead an=
d
> see if it works?
> [ auto_gate =3D read(RK_MMU_AUTO_GATING); auto_gate |=3D BIT(31); write(.=
..) ]

Thanks -- that's clearly the right shape (read-modify-write, before paging =
is
enabled, keeping the reset value instead of my clobbering 0x2).

I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-device-ops wor=
k)
using your bit-31 version and tested it on a ROCK 3B: the NPU IOMMU comes u=
p and
services the NPU's DMA cleanly -- the NPU probes, attaches its domain, and =
runs
repeated conv submissions with no DMA_READ_ERROR and no page-walk stall. No
regression from the write.

To be precise about what I can and can't show: I tested both ways on v7.1-r=
c6 --
with your bit-31 write, and on the reset value (0x3) -- and the NPU
IOMMU services
the NPU's reads with zero faults in both cases (no DMA_READ_ERROR, no page-=
walk
stall). So I don't have a failing baseline here that bit-31 visibly
fixes. Is the
AUTO_GATING write needed on current mainline, or only under conditions I'm =
not
reproducing (a particular traffic pattern / silicon rev)? I'll keep the pat=
ch in
your form unless you'd prefer to drop it.

One question so I document it correctly: what does bit 31 of RK_MMU_AUTO_GA=
TING
control on the v2 block -- is it a master "disable internal auto clock-gati=
ng"
for the page-table walker (i.e. so a TLB-miss walk's AXI master keeps its c=
lock
to completion)? The RK3568 TRM I have doesn't cover the IOMMU registers, so=
 a
one-line description would let me write an accurate comment.



Kind regards,
Midgy

Le ven. 5 juin 2026 =C3=A0 03:59, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> Hello Midgy,
>
> On 6/4/2026 9:52 PM, Midgy BALON wrote:
> > On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
> > auto clock-gating of the page-table walker, so the walker's AXI master
> > loses its clock between transactions; a TLB-miss page walk then never
> > completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).
> >
> > Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
> > so the walker keeps its clock. This is required for the RK3568 NPU MMU.
> >
> > Signed-off-by: Midgy BALON <midgy971@gmail.com>
> > ---
> >  drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index 4da80136933c4..e3d8b6e9ca12b 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> >
> >       ret =3D rk_iommu_enable_paging(iommu);
> >
> > +     if (!ret) {
> > +             /*
> > +              * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page=
-walker
> > +              * auto clock-gating; the walker's AXI master then loses =
its clock
> > +              * between transactions and a TLB-miss page walk never co=
mpletes,
> > +              * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE). =
 Clear
> > +              * bit 1 (keep bit 0, the slave-port gate) once paging is=
 enabled.
> > +              */
> > +             for (i =3D 0; i < iommu->num_mmu; i++)
> > +                     rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATIN=
G, 0x2);
> > +     }
> > +
> >  out_disable_stall:
> >       rk_iommu_disable_stall(iommu);
> >  out_disable_clocks:
>
> As I said, it is v2. Could you please try using the code below
> instead and see if it works? Thank you.
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 0013cf196c57..89e3a83a0251 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -930,6 +930,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>         struct iommu_domain *domain =3D iommu->domain;
>         struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
>         int ret, i;
> +       u32 auto_gate;
>
>         ret =3D clk_bulk_enable(iommu->num_clocks, iommu->clocks);
>         if (ret)
> @@ -948,6 +949,10 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>                                rk_ops->mk_dtentries(rk_domain->dt_dma));
>                 rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CAC=
HE);
>                 rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_I=
RQ_MASK);
> +
> +               auto_gate =3D rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_=
GATING);
> +               auto_gate |=3D BIT(31);
> +               rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_=
gate);
>         }
>
>         ret =3D rk_iommu_enable_paging(iommu);
>
> --
> Best,
> Chaoyi
