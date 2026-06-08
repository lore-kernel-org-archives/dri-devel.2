Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55944CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A963110EE9D;
	Mon,  8 Jun 2026 08:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOHrCgKn";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA7710EE9D
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:02:47 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so573609266b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 01:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780905765; cv=none;
 d=google.com; s=arc-20240605;
 b=OGrcREtbte/1yRtXAe2oUeRmtlsEFQhTiuePr3dXBuuZtS9roohX9O+qCE5/EgE2MN
 dVGl3h8Nf3I7w9O+DO4NIxbYRge8eIenW5f1WQ1HhTGDPWzTl5QCwLKONJmnkplA5nxH
 qj8NoefQNjtyF8FfD565v0p10hKaekGyIDePnlST1gPgGCVar+BHyLzM9K5VTV8M6Q7u
 KZGS8X0jy9tIh3LdOy20FFYOEgt++ohoeHwrmkj1Nu0CbUXW9Wu7/qqg2X1oFTqsNkjX
 74mhzLcaDF2mOHjgvNgVn73URR8PS6zKvgv3EEh0yuI0gxQd7l2jpHP+kEO0HNX8BT/P
 3sFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bLq1D7uP5MxHvai6FqrEhNmJ5qKAoR2b/ce+Jxe1kds=;
 fh=FUzLu3cgJvBEemX5PCsvk5pYtiTRsw2yKSIAcCNIM40=;
 b=gdcKVMto6P/QB30/3SGYp7QdadZrWBdgyQhdf9HbM8Q+NHe2//KDuS7Flo3ltyYr9e
 yaI9+fm7yWVnZ3fapt0kjgVi9df3EcZAh+QSsuvfokbooYXufQjfu5eZIAiRrLd8I6jo
 UgGA30bd+WeP/gpchDmBkP7aiUJ2kgEPU7hj0cCrScsWsOPvPUPNG8de++v1hPO02NZj
 VVB2fQb5VC3EgMk4DxlWmAsJgifdYAW93Yaz/WBeA2Ai4KdeDulCvAue1K1Y32vOIsC7
 +vDDC5bXpdRw+ztAH7mr4Ov8gCmP1T6BtBajC4ro2ekMeEwBFgZ6SlV8KUs4ZVTvC1DF
 sCaQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780905765; x=1781510565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bLq1D7uP5MxHvai6FqrEhNmJ5qKAoR2b/ce+Jxe1kds=;
 b=HOHrCgKni5W/myNHrwJzJ/y0gfwHFinZk8l9JKthmwz4v2ZxtN//mC/88XMLtJU/gI
 dblsPVRQX+f9Do0aTK3D5aeBehkMWGvjmfI8msGuYwzeSmwHYgYwUq6eK7yu2IeK3pS4
 em7GG/pmWEnrRDFfCpp6nxmJJ3FJwm8fO0uNoXg5vwjzb8O4BHi8YdOs9mb9Hae4wdhV
 n4GqC6zDI7c5/XP4hdmKNekD/+NQmGBiFQENIHGtOdcnuW7WR9XGAWst0NutidlomX5O
 5kWETWktq3/9iReTKjzxMlFDZo8IxiD4wK/r9yQ/9TnB9PT8D3G9BVo/vcGCDabcklrW
 L4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780905765; x=1781510565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bLq1D7uP5MxHvai6FqrEhNmJ5qKAoR2b/ce+Jxe1kds=;
 b=rVCkPrA1o4RjteOyhrsGzb0+iwkZJ4HdeZX5UVD9dFpq47gEhy8lqMd0EQMFV+huuP
 hcrjwPF5EFX3ZYvRFNZ3lLFkeTYg/UGNxktGLYD8vB0xqBcSV617Rfh+ULpQTkIbNETy
 lgY2vNtTffbqsSuMYpl6kjoBgTn4Scqeq3y+BENp6/DmY2FKfxJVu1JSqkjD8mJf4OEm
 4z5SUwmeR1x3OwGmbmcd8iro/RTcEfiQOT+/2v4FydGDkVxAPMIeqFZDWnbppi/o9wpn
 kRVaGsowrkwuytKWc9cf2Zps6PzxJcxwiOPB+rnF3WnxC7g1reWF1z+GgYHCY/XNawva
 L4TQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ81neo4uV6CUVV994NXqUHpUK4g5KAGjEhUt2EppKEcHhbhIQkPWLX2drdFxBaDX9WsrSUSxtx6Y34=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPePOWCQj7KISo6n+k0lGynANLyd+yg8T6FAxjg19ZvlSHypLf
 jnP8iWUVyfFvuM+6Y77lcMIFUCGKTfJUhtJbFV/3vpNSdzslxJH9rSCgD/NUYGMB/EdhPTqxLmk
 Z0eCpb+0mvMURPXtgTdOsFhQPS48NNNEUaRpiIoG+e47B
X-Gm-Gg: Acq92OFf5F8BmHlBGRoTtXcU73kpYhKu7URl0BA0hbP8jRGGIORbhErDCArVnQgM+V9
 R7ax1gsNAfbI1wX+RF17AHS6gCj948CKi/HSZWS0MtfhO7woOFdGnjuTUI4wr9l2qzWHx2EnCx3
 xyKchwtNnuXCmMqDC7rPaHK+O6qRWKmUpkr4BMaVKJZb+CIQAf79vmu6YYwo33R1v8Oe4FO8FIp
 lW3JHsY05Tb9TVqr7T2pj5GRj0BOxyJxMubBKncMOJcC8AzFM2PTGdAXE4i3imn8pVCKzQ/iyYL
 ffc90lz9yUYiVIZUJA==
X-Received: by 2002:a17:906:8a46:b0:bec:4b96:5fb9 with SMTP id
 a640c23a62f3a-bf3701806dcmr422529166b.3.1780905765057; Mon, 08 Jun 2026
 01:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
In-Reply-To: <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Mon, 8 Jun 2026 10:05:33 +0200
X-Gm-Features: AVVi8Cc-kS2uobepJQqeen5fwApM6uunQz9mBN_BXk5X1LlYp7Vi43yabrw2ZY0
Message-ID: <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, 
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Simon Xue <xxm@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>
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

Hello Chaoyi,

Thanks -- this is exactly what I needed.

- v2/DTE: will do. I'll keep building on Simon's per-device-ops series -- w=
ith
  that in place the NPU MMU can use the 32-bit-DTE ops (the per-ops GFP_DMA=
32
  that's already in mainline) without the global rk_ops conflict. I'll
keep it as
  a stated dependency of the v4 cover letter.

- vdd_npu:  I'll switch the RK3568 NPU
  power domain to need_regulator + domain-supply =3D <&vdd_npu> and drop th=
e
  regulator-always-on workaround. I suspect that's also the right fix for t=
he
  power-off/on de-idle issue I described -- the always-on was really
just papering
  over the domain not being modelled with a regulator. I'll confirm on
the board.

- AUTO_GATING: thanks for the commit references -- I'll keep the bit-31
  read-modify-write form with your Suggested-by and write the comment
from those.
  For the record: on v7.1-rc6 the NPU MMU also completes translations
on the reset
  value (I couldn't reproduce a page-walk stall without the write), so I'll=
 note
  in the commit that it matches the vendor clock-gating handling rather tha=
n
  fixing a failure I can reproduce here -- happy to drop it if the iommu
  maintainers would prefer.

- PVTPLL/NoC: I'll follow up with Finley. First I'll check whether the
  need_regulator change resolves the NoC re-power de-idle on its own;
if it still
  I'll bring him the details (the genpd power-on de-idle ack and the
  BUS_IDLE_ST state).

I'll send a v4 with these. Thanks again for the quick, detailed answers.

Kind regards,
Midgy

Le lun. 8 juin 2026 =C3=A0 03:40, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> Hi Midgy,
>
> On 6/8/2026 5:03 AM, Midgy Balon wrote:
> > Hi Chaoyi,
> >
> > Thanks a lot for looking at this -- input from Rockchip is exactly what=
 this
> > series needs.
> >
> >> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather tha=
n v1,
> >> implying it should support 40-bit PAs. Nevertheless, please note that =
the
> >> upper limit for DTE is 32 bits.
> >
> > Understood, and that 32-bit-DTE note is the crux of the trouble I had, =
so let
> > me lay out what I see and ask how you'd prefer to solve it.
> >
> > The mainline node is already v2 (rockchip,rk3568-iommu in rk356x-base.d=
tsi).
> > The problem on this 8 GiB board: with the v2 ops the page-table allocat=
ions
> > (gfp_flags =3D=3D 0) can land above 4 GiB, so the DTE ends up > 32 bits=
 and the
> > NPU's first translation faults with DMA_READ_ERROR. To work around that=
 I had
> > switched the NPU MMU to the v1 compatible (rockchip,iommu), whose ops s=
et
> > GFP_DMA32 and keep the DTE sub-4 GiB. That works in isolation, but beca=
use the
> > driver keeps a single global rk_ops, a v1 NPU MMU then trips
> > WARN_ON(rk_ops !=3D ops) against the SoC's v2 instances (VOP/VDEC), whi=
ch is why
> > I based the series on Simon's per-device-ops work.
> >
> > So my question: with per-device ops in place, what's the intended way t=
o keep
> > the NPU MMU on v2 *and* cap its DTE at 32 bits on boards with >4 GiB of=
 RAM?
> > A v2 ops variant carrying GFP_DMA32 for this device, or is there a regi=
ster/
> > config bit that constrains the DTE address? I'd rather follow the Rockc=
hip
> > intent here than carry the v1 workaround. (Simon, cc'd -- this is right=
 next to
> > your per-device-ops series.)
> >
>
> If Simon's method works, please use it :)
>
> >> Can these operations not be completed via the pmdomain driver?
> >> If some operations are controlled by TF-A, are you using open source T=
F-A?
> >
> > Most of it is in pmdomain already. Power-on and NoC de-idle are done by=
 the
> > RK3568 NPU power domain (genpd) at power-on -- the driver no longer pok=
es the
> > PMU directly. Two things remain outside it:
> >
> >  - vdd_npu: I mark it regulator-always-on in DT rather than wiring it a=
s the
> >    domain's domain-supply, because as a domain-supply it created a devi=
ce-link
> >    to the I2C PMIC (rk809) and genpd's power-off QoS-save path then hun=
g
> >    reading the NPU QoS registers behind the (gated) NoC. If there's a c=
lean way
> >    to let genpd own vdd_npu without that I2C ordering deadlock I'd much=
 prefer
> >    that -- pointers welcome.
> >
>
> Please refer to the patch below regarding the RK3588 NPU pmdomain.
> In short, you need to set a "need_regulator" for the RK3568 NPU pmdomain.
>
> https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
>
> >  - the NPU compute clock (PVTPLL): set from the driver via SCMI, and on=
ly
> >    needed for actual compute, not for bring-up.
> >
> > One more pmdomain observation from testing, possibly relevant to how th=
e NPU
> > domain should be modelled: the domain's power-off/on cycle doesn't reli=
ably
> > re-de-idle the NoC. If the NPU is probed after genpd has already powere=
d the
> > (unused) domain off, the power-on de-idle fails ("failed to set idle on=
 domain
> > 'npu'") and the NPU IOMMU then takes an external abort on its first MMI=
O access.
> > Probing the NPU before the unused-domain power-off, or marking the doma=
in
> > always-on, both avoid it. Is the NoC de-idle expected to work on a genp=
d
> > re-power here, or should this domain effectively stay on?
> >
>
> Not quite sure what's going on with PVTPLL and NOC.
> Maybe @Finley knows about this?
>
> > On TF-A: yes -- bl31 is built from upstream arm-trusted-firmware
> > (github.com/ARM-software/arm-trusted-firmware, RK3568 platform), provid=
ing PSCI
> > and the SCMI clock service. The only closed blob in the boot chain is R=
ockchip's
> > DDR init (rkbin), which is the standard situation for mainline RK356x.
>
> --
> Best,
> Chaoyi
