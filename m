Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4187CD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B4610EB9B;
	Sun,  7 Jun 2026 21:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HR2xn5MK";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 474FF10EB9B
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:00:24 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bec3ffb95dbso544861066b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780866023; cv=none;
 d=google.com; s=arc-20240605;
 b=RGA+2euenKPmI1QgafzYGZ9X6znIyPRKELwf7I1Udgk9fPNQMOErOuydSPugQ4KqCk
 ABIewZDM9AXdMODVy3MjkhEiXim288yzkrOfN9XKihtO3v4PowmheaJtLoTnHbFZvl3I
 q39cnomafE4S9QxdcG9oaW2xuqEonp9nXMMSF8QBB/xV2AhnD8TtQ3xcPrcp+TWA5Sty
 krEfuaaBLqWcUuCEK9Y+RFyHKz1RB1/hAn47vs+SLqoMM8zsjt4g9jHhnWXzO4pyfCcw
 AZmUjTe46y6UDYlo5kKNrV1p5C2IeQV0txXMmXJ+YTAXasRFKcawtvMtMm5wpnu+dFJp
 E9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ab6NkRbgO8MmT1srYNgG1RYGxHSJUAoP80C+AxzOUBY=;
 fh=woQ/13UEtSEmzPBnq/FUnOqwdiNuGj3KuOArbTY1RLg=;
 b=X6r4xdACMeV4dB8gbi9v1TG2vz5N5Qf/uE1UsPhgiIeWVEJn2gsyGQNTZKvlMs0AQq
 7oYEJu0qBjXEOjTiPFzIw4wfHXuBugd39h7DZIrIGycEK9aFekqG5vQJKtbj87p/m1jB
 kshc+WxCj62FQY8dKEvpQifK1tAHuInkU77IZzIOseQVL2yODfzlZGAecPZOeRilwY0D
 Sibgd3hU0DeXKWMbeSsxpQiQuABx1D1bE/Af0erMasXpG3cO5CLRbeB0u924iDCCgCa1
 HCBrHINMfjV6+jxMYdJ5mA6wdjK6jqTKUIOKpgcEssKDBvwEubdIPLMjwPnisTGJtpYE
 8e6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780866023; x=1781470823; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab6NkRbgO8MmT1srYNgG1RYGxHSJUAoP80C+AxzOUBY=;
 b=HR2xn5MK8e/W7RJdcdOhywqDejlZOrGrmMuSKLOnNUl6/pViPwYycXam1I4809PHTu
 os0wTqR0Tg6sMKsRlnoU4t2JmB2PUD5UmMGFn9NK8McDplorMtgfnXwX1WO3SrHZ6Lci
 rfoWOFWdcOdY2qK7/4DmrwR7BJrDjISwZnT+8tcEIEajCufm7OaN636l9SYgeuIyzAwK
 arl2cH+26+I6Mv/Wdlmf3skqh4qRRoo00KC9p9WQPlU70Uu/500bZaIyfR/3qmA8ldx9
 m1HkzIAlH3JAiMacMCEhA6vb9+wkCpoac0Ps1/+iybmTP0ctNDQp0CksqoKl/wkuA8zU
 7BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780866023; x=1781470823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ab6NkRbgO8MmT1srYNgG1RYGxHSJUAoP80C+AxzOUBY=;
 b=kzyr85NkyNkR7WbsAYnhERYMyUmYLPYJTjLnmVrePxFady+DxLsEJwDVfXuy75ZaOt
 ayyqUlbwU9exCkazXCEJ2AOxIuuoFpnnyBDZclSHLRzsgw/uZOyGl254qmz3Rbu9gah3
 7oFLVTVQzlgxE8wqsUVo51qXVFFiJw7O+huxY+SNbYcmrN42+3Ai5gzCQm2dvTI7CT9R
 DxSEqu1h85rScpbjFTzUdFpYea4Ph29vGU4Sl+/7d6UVsq8D+kryNP5G5lScXPOssUfm
 1a+uXDneB0u2j53TF5QMFBOa6tqzuedvukLjmDCuaxyT0T8HlwlkgStMTWrFC80msXSG
 xM/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zfxMv0K6dsiQ8TENhwOnKFRAnPzVbWgvh18e/3Nx1QsH2wPrsa/N5VVQNZeYEltAXK9VXn2rfXFs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxIgp/u3Qw5FPnnSA/sncIwfMDHowdcEmqFmGctPV2F+8AS1PUQ
 krqbnKabzbS+J9wS2BMKNcWUYqBwXfT/O/INKHjeFtvN8cIFRBs4CO64wnHauIkGERQwE07W+Ux
 tqXV/oPGdh+7spsHNnoj3HXwcvJTWFQs=
X-Gm-Gg: Acq92OHvdStj0QhPzsZ7Gs8NZF7Uo5WJCNDgfAIZu6zzrIiqSlILPlWXG778mgyPkUT
 dc03CB59PPhZkX41kLh/LRR19G2PaG7dI/pTBKEYc1ZxWj50I76fXeujf+2lf4UY5LH8tKyOAMq
 javQoMeTTunm+wY3GVCUwAKuW+zWfLhVfGF4tp+Gq5OE2NkVW0sc5p0m1oPUBRJns4STpP2pIRW
 1wlGsCVYe1hmDEdoK/haIt4+MrTA1vzA9TBeysf+WBjckLoFHlKxWMI38kOQ6bX4fToFZAg4Pss
 Tg3VxfeDsAFR61uHC8v4HwXrDwSYf9BgVtF47+3ZWC31GE5MSPwGfbvEDcSJxg==
X-Received: by 2002:a17:906:8a42:b0:bb8:fdf7:e132 with SMTP id
 a640c23a62f3a-bf370a673a2mr449071866b.18.1780866022378; Sun, 07 Jun 2026
 14:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
In-Reply-To: <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Sun, 7 Jun 2026 23:03:08 +0200
X-Gm-Features: AVVi8CeDCIQ6l1Xo0XYKychXQqz8K96nj5PXcE7mUgH_L3ruXovyZGyMkFh5fkU
Message-ID: <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, 
 will@kernel.org, robin.murphy@arm.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
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

Hi Chaoyi,

Thanks a lot for looking at this -- input from Rockchip is exactly what thi=
s
series needs.

> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather than v=
1,
> implying it should support 40-bit PAs. Nevertheless, please note that the
> upper limit for DTE is 32 bits.

Understood, and that 32-bit-DTE note is the crux of the trouble I had, so l=
et
me lay out what I see and ask how you'd prefer to solve it.

The mainline node is already v2 (rockchip,rk3568-iommu in rk356x-base.dtsi)=
.
The problem on this 8 GiB board: with the v2 ops the page-table allocations
(gfp_flags =3D=3D 0) can land above 4 GiB, so the DTE ends up > 32 bits and=
 the
NPU's first translation faults with DMA_READ_ERROR. To work around that I h=
ad
switched the NPU MMU to the v1 compatible (rockchip,iommu), whose ops set
GFP_DMA32 and keep the DTE sub-4 GiB. That works in isolation, but because =
the
driver keeps a single global rk_ops, a v1 NPU MMU then trips
WARN_ON(rk_ops !=3D ops) against the SoC's v2 instances (VOP/VDEC), which i=
s why
I based the series on Simon's per-device-ops work.

So my question: with per-device ops in place, what's the intended way to ke=
ep
the NPU MMU on v2 *and* cap its DTE at 32 bits on boards with >4 GiB of RAM=
?
A v2 ops variant carrying GFP_DMA32 for this device, or is there a register=
/
config bit that constrains the DTE address? I'd rather follow the Rockchip
intent here than carry the v1 workaround. (Simon, cc'd -- this is right nex=
t to
your per-device-ops series.)

> Can these operations not be completed via the pmdomain driver?
> If some operations are controlled by TF-A, are you using open source TF-A=
?

Most of it is in pmdomain already. Power-on and NoC de-idle are done by the
RK3568 NPU power domain (genpd) at power-on -- the driver no longer pokes t=
he
PMU directly. Two things remain outside it:

 - vdd_npu: I mark it regulator-always-on in DT rather than wiring it as th=
e
   domain's domain-supply, because as a domain-supply it created a device-l=
ink
   to the I2C PMIC (rk809) and genpd's power-off QoS-save path then hung
   reading the NPU QoS registers behind the (gated) NoC. If there's a clean=
 way
   to let genpd own vdd_npu without that I2C ordering deadlock I'd much pre=
fer
   that -- pointers welcome.

 - the NPU compute clock (PVTPLL): set from the driver via SCMI, and only
   needed for actual compute, not for bring-up.

One more pmdomain observation from testing, possibly relevant to how the NP=
U
domain should be modelled: the domain's power-off/on cycle doesn't reliably
re-de-idle the NoC. If the NPU is probed after genpd has already powered th=
e
(unused) domain off, the power-on de-idle fails ("failed to set idle on dom=
ain
'npu'") and the NPU IOMMU then takes an external abort on its first MMIO ac=
cess.
Probing the NPU before the unused-domain power-off, or marking the domain
always-on, both avoid it. Is the NoC de-idle expected to work on a genpd
re-power here, or should this domain effectively stay on?

On TF-A: yes -- bl31 is built from upstream arm-trusted-firmware
(github.com/ARM-software/arm-trusted-firmware, RK3568 platform), providing =
PSCI
and the SCMI clock service. The only closed blob in the boot chain is Rockc=
hip's
DDR init (rkbin), which is the standard situation for mainline RK356x.

Kind regards,
Midgy

Le ven. 5 juin 2026 =C3=A0 03:36, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> Hello Midgy,
>
> On 6/4/2026 9:52 PM, Midgy BALON wrote:
> > RFC, not for merge. End-to-end inference does not produce correct outpu=
t
> > yet (see Status), so per the v2 discussion this is a request for design
> > feedback. It now probes, attaches, and submits cleanly on a stock
> > v7.1-rc6 tree; what remains is one hardware-internal issue.
> >
> > The RK3568 has a single NVDLA-derived NPU core, the same IP family as t=
he
> > RK3588 NPU the driver already supports; the register layout matches. Th=
e
> > RK3568 differences are a 32-bit NPU AXI/IOMMU (vs 40-bit) and explicit
> > PVTPLL/PMU bring-up to power and de-idle the NPU before it is reachable=
.
> >
> > Patches:
> >   1-2  rocket: per-SoC data struct, then derive DMA width and core coun=
t
> >        from match data (refactors, no functional change).
> >   3    rocket: RK3568 SoC data + PVTPLL/PMU/NOC bring-up.
> >   4    rocket: reset the NPU before detaching the IOMMU on a job timeou=
t
> >        (the detach otherwise stalls a wedged AXI master and WARNs).
> >   5    rocket: keep the IOMMU domain attached across jobs instead of
> >        re-attaching per job (the per-job rk_iommu handshake on the idle
> >        NPU MMU is slow and noisy).
> >   6    iommu/rockchip: clear AUTO_GATING bit 1 on the RK356x v1 IOMMU s=
o
> >        the page-walker keeps its clock (else a TLB-miss walk never
> >        completes).
> >   7    dt-bindings: add the RK3568 NPU compatible.
> >   8-9  arm64 dts: add the NPU and its IOMMU, and enable them on ROCK 3B=
.
> >
> > Dependency. The NPU MMU is rockchip-iommu v1 (32-bit) while the rest of
> > the RK3568 uses v2 (40-bit). They cannot coexist until the driver carri=
es
> > per-device ops; this series is developed on top of Simon Xue's
> > "iommu/rockchip: Drop global rk_ops in favor of per-device ops" [1].
> > Without it the NPU IOMMU fails to probe on a full RK3568 boot.
> >
>
> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather than
> v1, implying it should support 40-bit PAs. Nevertheless, please note that
> the upper limit for DTE is 32 bits.
>
> > Power bring-up. The NPU is brought up through the power-domain layer (n=
o
> > driver hack): the NPU power-domain keeps its clocks but drops the pm_qo=
s
> > phandle (qos_npu sits behind the gated NPU NoC, so genpd's power-off Qo=
S
> > save faults reading it), and vdd_npu is marked always-on so the rail is
> > up before genpd de-idles the NoC at power-on. The PMU de-idle then ACKs
> > without PVTPLL running; PVTPLL is only needed for compute.
> >
>
> Can these operations not be completed via the pmdomain driver?
> If some operations are controlled by TF-A, are you using open
> source TF-A? Thank you.
>
> > Status. On v7.1-rc6 the driver probes, creates /dev/accel/accel0,
> > attaches an IOMMU domain, and submits jobs; the program controller
> > fetches and broadcasts the command list. Inference output is still wron=
g,
> > and the cause is split across three layers:
> >   - kernel (this series): the RK3568 differences appear handled;
> >   - mesa/Teflon userspace: still emits RK3588-tuned config, wrong for
> >     RK3568 (to be filed separately on mesa-dev);
> >   - hardware: with corrected config the NPU's DMA reads the full input
> >     and weight tensors (confirmed via its DMA bandwidth counters), but
> >     the MAC/output stage never completes, the job times out, and the
> >     output stays at the buffer's zero-point. I have not found the missi=
ng
> >     step; it is not in the command list (replaying the vendor's
> >     byte-exact command list behaves the same). Pointers welcome,
> >     especially from anyone with RK3568 NPU experience.
> >
> > Known residual. On the first IOMMU attach the NPU MMU is idle with pagi=
ng
> > already enabled; the rk_iommu stall/reset handshake does not complete i=
n
> > that state and logs one burst of timeouts before the (kept) domain
> > settles. It is harmless here because the job times out regardless, but =
it
> > points at an idle-MMU reconfiguration corner the rk_iommu code does not
> > handle on this block.
> >
> > [1] https://lore.kernel.org/linux-rockchip/20260310105303.128859-1-xxm@=
rock-chips.com/
> >
> > Changes since v2:
> >   - Tagged RFC; now tested on a stock v7.1-rc6 tree.
> >   - Bring-up moved into the power-domain/DT layer (no initcall hack).
> >   - Added the IOMMU detach-on-timeout and attach-once driver fixes.
> >   - Split the driver patch (Heiko): soc_data / match-data / RK3568.
> >   - Derive DMA width and core count from match data; drop the DT rescan=
s.
> >   - Binding describes the hardware; added the missing $ref on rockchip,=
pmu.
> >   - Disclosed the per-device-ops IOMMU dependency.
> >
> > Midgy BALON (9):
> >   accel: rocket: Introduce per-SoC rocket_soc_data
> >   accel: rocket: Derive DMA width and core count from match data
> >   accel: rocket: Add RK3568 SoC support
> >   accel: rocket: Reset the NPU before detaching the IOMMU on timeout
> >   accel: rocket: Keep the IOMMU domain attached across jobs
> >   iommu/rockchip: Clear AUTO_GATING bit 1 on the RK356x v1 IOMMU
> >   dt-bindings: npu: rockchip,rk3588-rknn-core: Add RK3568
> >   arm64: dts: rockchip: rk356x: Add the NPU and its IOMMU
> >   arm64: dts: rockchip: rk3568-rock-3b: Enable the NPU
> >
> >  .../npu/rockchip,rk3588-rknn-core.yaml        | 18 ++++-
> >  .../boot/dts/rockchip/rk3568-rock-3b.dts      | 14 +++-
> >  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 38 +++++++++++
> >  drivers/accel/rocket/rocket_core.c            | 22 ++++++-
> >  drivers/accel/rocket/rocket_core.h            | 19 ++++++
> >  drivers/accel/rocket/rocket_device.c          | 15 ++---
> >  drivers/accel/rocket/rocket_device.h          |  3 +-
> >  drivers/accel/rocket/rocket_drv.c             | 66 ++++++++++++++++++-
> >  drivers/accel/rocket/rocket_job.c             | 35 ++++++++--
> >  drivers/iommu/rockchip-iommu.c                | 12 ++++
> >  10 files changed, 219 insertions(+), 23 deletions(-)
> >
> >
> > base-commit: 52c800fdcf11888ebeb50c3d707f782cc15b66eb
>
> --
> Best,
> Chaoyi
