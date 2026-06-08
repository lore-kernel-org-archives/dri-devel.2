Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A0CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED8210F009;
	Mon,  8 Jun 2026 09:11:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s7PGgMRa";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9275E10F009
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:11:30 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-68c3421b009so7275142a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909889; cv=none;
 d=google.com; s=arc-20240605;
 b=a4I02ZCDkdmtnd18QjZ8ynWgA7+quM3tYeN9ccQRIk87N/8tM9rsf6UApdKJVuLhWT
 fX+PhYmrcebZfjThVhJ4kifZCpBmd8UOgGZ4nEX1WBUnvrRRtDneFZ8+SSSXpH5iKAVO
 RLWA1L2r7WHfSUC0q9BPlakvtzMp45h6k00CU6P8XxoUPNoM0TSopl0HndPFiz6xP0oj
 roxFGPRnV0gJqkPsqKT/BMOly8/IzGx/ewkT0xGOYblx3r4CZ0PVVloitTVaFca4ud/3
 CgtbY1y4wZpu7dGf8l7+XucPbseHyUY2Q+COswfD/DwoskszaSmIwn+orE7acoBNTCaP
 4fkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WelUToYaunngdS4iiekhxlbrmFbbBfrAT5j9UWPzR4A=;
 fh=rBaQwmhwnuoQlrDM3BbXGqF4QiZg93rhxqUrWesq/hQ=;
 b=EL7ZMY3IRetpU+3VsHNJpW4pNETy4k1eE/sb3nm70oZ6k7aSpFrRlnyh12ICsUmnvX
 YAzrhsISsFH+qrmQ7cXBjELlXdPqspucCmYZk0+n7hetWrNOss1VuKG+uZgaEQ1PzTKL
 RzST01+3Oy0MoFAOtR9M8u6NIdjqUXRZOp3Wp7fVU05azVeP8IhmpvX0MJpRtMmLdsNG
 flFhlso9cQEwCZVizqS8juUeTfShy+d6l2JEMKJZa/99KcQjNLmPn1Pk1h7QjSwnAICF
 d1iYdb1egFHycoZK/JWGJ2oXEnKnry/4eI4CQsDBwYJwbgi468uauuPlPHXPoFvOfRxx
 f/fw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780909889; x=1781514689; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WelUToYaunngdS4iiekhxlbrmFbbBfrAT5j9UWPzR4A=;
 b=s7PGgMRaczdk1/Q49wp240vzTaoSl8KaEJCrun0AVJTK/vFejEboFQdEp59Si34EYH
 fY2So2ll1oK829n3PcpqbYr+mGLA2McldI/cmNjVjd9vmeX5HhM2yVIC81xHhZzmeP4i
 0AkCkDKs3v657Bb16B/pNAE/CnmKZ35rzAB+bl0Br5+XyCizRHOGATh3eVR8zJegjym9
 hroRGimq0rbNkshgssLGM+hDGCm65za4ICKHic36M9LcFU7bOO9yF73D7yQkSu3+x5XK
 NGeqc4EidoMJulGLrSaxcZsDtqQbCzTCguko7ogXv2qtXpWyubOu6dPQf4C1QOF1025s
 TDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909889; x=1781514689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WelUToYaunngdS4iiekhxlbrmFbbBfrAT5j9UWPzR4A=;
 b=lniAna88WIBOwsUkML6YV6xXIxM9UWEU1nxT7iZtlYXyNeTv0iPvTQvchQUoCdMIHG
 bLJJhtgrERfK+KgOMDFm6m32bMGq50TcC0zAZvOBDbTEWbUb+kfQIQU8GQjKBkV08R/g
 8epxCdzzR7NWyvBnaCHWxhASsgDTqs780lmjBWAfNqCw0okY3Z7dcehZUDWSUQfRHYNr
 /7GsVFlucANv8ZMERbhDg4RNsaOcAhsHIbM0QB6AmAp6TnChjoi9JvUAR2R+nzt8b/PN
 7QmoI5uA2p5pyg050a/+tIjHJOsAab4gqnIo15ZDBxHAmnVu+XhuMIT5+s+a6f8Lp2HX
 MjcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/yMhL+FyVL2tZtrkGOkGbgWp9xLIMZABdSGiIN7W7aAwSsG5H0uiSbbllXjQQhgzMJ+LKeRsPuNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM0aDiVap8pxn0+OyfESdSQlEXe/AZWuQN1w/hYuC2oEoAAJLr
 h7IUU0FzFITfPzor6elLlZRvqQ4M+Un9/qzjlSHlsztNdzbv8M3ZXQ76CLIA0a2pSxDvVuGK/Ao
 qD3A49R2yi8DROVeT4ygFM1Seu6F9bak=
X-Gm-Gg: Acq92OGnbiSr3q+OUllE0YAUaCUbEzjhcAh5O7K/ZNjmAndsL81HDHkA9vPi/v1nrJs
 MuKoias5uWdHIXk9/QnzVL6I44avMQfrTbnDZo8oOyErN6lce3Gw3ytr9VhAn3NNL0BaL7YQU3R
 D8ApNH/ijep/O4k2aPfbvlDzP/RbdL9MwFhk79zr/4Q7FxMFA4XAMYnoObUtW+wCxuD/1nHkTVd
 mDqvJTlrpqbiqz5O8kidXJdV5N9tqe+evlk1m6KnDEfKEglPpaYeItMQTeV8+bgH8Qiz4Ai7duJ
 mECrW6ca79JznIlwLw==
X-Received: by 2002:a17:907:2d12:b0:beb:2980:e2d2 with SMTP id
 a640c23a62f3a-bf3a6b13b16mr580109766b.8.1780909888634; Mon, 08 Jun 2026
 02:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
 <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
In-Reply-To: <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Mon, 8 Jun 2026 11:14:17 +0200
X-Gm-Features: AVVi8CefQKT7ky3Sqeq6MkiJ04hcvCvZiupw30w_yNvYYxCVtDBxVUNhbRaFSOk
Message-ID: <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
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

Following up on the need_regulator suggestion -- I implemented and
tested it on the
board, and unfortunately it doesn't avoid the deadlock on RK3568; it
moves it from
boot to the NPU job submit.

What I did: gave the RK3568 NPU power domain a regulator (a DOMAIN_M_R
variant with
need_regulator =3D true), wired domain-supply =3D <&vdd_npu>, and dropped t=
he
regulator-always-on workaround.

Boot is now clean and the NPU probes, but there is a warning during boot:

  rockchip-pm-domain ...: Failed to create device link (0x180) with supplie=
r
  0-0020 for .../power-domain@6

(0-0020 is the rk809 PMIC that supplies vdd_npu.) Then on the first NPU job
submit the board hard-hangs with an RCU stall:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu:     3-...!: (1 GPs behind) ...
  rcu: rcu_preempt kthread starved for 5115 jiffies! ... RCU_GP_WAIT_FQS(5)
  rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expe=
cted

My reading: vdd_npu is on the rk809 *I2C* PMIC, so when genpd
enables/disables the
regulator during the NPU's runtime-PM power transition, the I2C
transfer runs in a
context that starves RCU and the box freezes. (I suspect
need_regulator is fine on
the RK3588 NPU because its supply isn't behind an I2C PMIC.) The always-on
workaround avoids this precisely because genpd never touches the I2C
regulator in
that path.

So: for an NPU domain whose supply is an I2C PMIC, is there a
supported way to let
genpd own the regulator without performing the I2C op in the
power-transition path
(a deferred/async regulator enable, or a flag), or should RK3568 keep vdd_n=
pu as
regulator-always-on? For v4 I'll keep always-on unless there's a cleaner pa=
th.


Thanks,
Midgy

Le lun. 8 juin 2026 =C3=A0 10:05, Midgy Balon <midgy971@gmail.com> a =C3=A9=
crit :
>
> Hello Chaoyi,
>
> Thanks -- this is exactly what I needed.
>
> - v2/DTE: will do. I'll keep building on Simon's per-device-ops series --=
 with
>   that in place the NPU MMU can use the 32-bit-DTE ops (the per-ops GFP_D=
MA32
>   that's already in mainline) without the global rk_ops conflict. I'll
> keep it as
>   a stated dependency of the v4 cover letter.
>
> - vdd_npu:  I'll switch the RK3568 NPU
>   power domain to need_regulator + domain-supply =3D <&vdd_npu> and drop =
the
>   regulator-always-on workaround. I suspect that's also the right fix for=
 the
>   power-off/on de-idle issue I described -- the always-on was really
> just papering
>   over the domain not being modelled with a regulator. I'll confirm on
> the board.
>
> - AUTO_GATING: thanks for the commit references -- I'll keep the bit-31
>   read-modify-write form with your Suggested-by and write the comment
> from those.
>   For the record: on v7.1-rc6 the NPU MMU also completes translations
> on the reset
>   value (I couldn't reproduce a page-walk stall without the write), so I'=
ll note
>   in the commit that it matches the vendor clock-gating handling rather t=
han
>   fixing a failure I can reproduce here -- happy to drop it if the iommu
>   maintainers would prefer.
>
> - PVTPLL/NoC: I'll follow up with Finley. First I'll check whether the
>   need_regulator change resolves the NoC re-power de-idle on its own;
> if it still
>   I'll bring him the details (the genpd power-on de-idle ack and the
>   BUS_IDLE_ST state).
>
> I'll send a v4 with these. Thanks again for the quick, detailed answers.
>
> Kind regards,
> Midgy
>
> Le lun. 8 juin 2026 =C3=A0 03:40, Chaoyi Chen <chaoyi.chen@rock-chips.com=
> a =C3=A9crit :
> >
> > Hi Midgy,
> >
> > On 6/8/2026 5:03 AM, Midgy Balon wrote:
> > > Hi Chaoyi,
> > >
> > > Thanks a lot for looking at this -- input from Rockchip is exactly wh=
at this
> > > series needs.
> > >
> > >> Hmmm. If I understand correctly, the NPU IOMMU should be v2 rather t=
han v1,
> > >> implying it should support 40-bit PAs. Nevertheless, please note tha=
t the
> > >> upper limit for DTE is 32 bits.
> > >
> > > Understood, and that 32-bit-DTE note is the crux of the trouble I had=
, so let
> > > me lay out what I see and ask how you'd prefer to solve it.
> > >
> > > The mainline node is already v2 (rockchip,rk3568-iommu in rk356x-base=
.dtsi).
> > > The problem on this 8 GiB board: with the v2 ops the page-table alloc=
ations
> > > (gfp_flags =3D=3D 0) can land above 4 GiB, so the DTE ends up > 32 bi=
ts and the
> > > NPU's first translation faults with DMA_READ_ERROR. To work around th=
at I had
> > > switched the NPU MMU to the v1 compatible (rockchip,iommu), whose ops=
 set
> > > GFP_DMA32 and keep the DTE sub-4 GiB. That works in isolation, but be=
cause the
> > > driver keeps a single global rk_ops, a v1 NPU MMU then trips
> > > WARN_ON(rk_ops !=3D ops) against the SoC's v2 instances (VOP/VDEC), w=
hich is why
> > > I based the series on Simon's per-device-ops work.
> > >
> > > So my question: with per-device ops in place, what's the intended way=
 to keep
> > > the NPU MMU on v2 *and* cap its DTE at 32 bits on boards with >4 GiB =
of RAM?
> > > A v2 ops variant carrying GFP_DMA32 for this device, or is there a re=
gister/
> > > config bit that constrains the DTE address? I'd rather follow the Roc=
kchip
> > > intent here than carry the v1 workaround. (Simon, cc'd -- this is rig=
ht next to
> > > your per-device-ops series.)
> > >
> >
> > If Simon's method works, please use it :)
> >
> > >> Can these operations not be completed via the pmdomain driver?
> > >> If some operations are controlled by TF-A, are you using open source=
 TF-A?
> > >
> > > Most of it is in pmdomain already. Power-on and NoC de-idle are done =
by the
> > > RK3568 NPU power domain (genpd) at power-on -- the driver no longer p=
okes the
> > > PMU directly. Two things remain outside it:
> > >
> > >  - vdd_npu: I mark it regulator-always-on in DT rather than wiring it=
 as the
> > >    domain's domain-supply, because as a domain-supply it created a de=
vice-link
> > >    to the I2C PMIC (rk809) and genpd's power-off QoS-save path then h=
ung
> > >    reading the NPU QoS registers behind the (gated) NoC. If there's a=
 clean way
> > >    to let genpd own vdd_npu without that I2C ordering deadlock I'd mu=
ch prefer
> > >    that -- pointers welcome.
> > >
> >
> > Please refer to the patch below regarding the RK3588 NPU pmdomain.
> > In short, you need to set a "need_regulator" for the RK3568 NPU pmdomai=
n.
> >
> > https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
> >
> > >  - the NPU compute clock (PVTPLL): set from the driver via SCMI, and =
only
> > >    needed for actual compute, not for bring-up.
> > >
> > > One more pmdomain observation from testing, possibly relevant to how =
the NPU
> > > domain should be modelled: the domain's power-off/on cycle doesn't re=
liably
> > > re-de-idle the NoC. If the NPU is probed after genpd has already powe=
red the
> > > (unused) domain off, the power-on de-idle fails ("failed to set idle =
on domain
> > > 'npu'") and the NPU IOMMU then takes an external abort on its first M=
MIO access.
> > > Probing the NPU before the unused-domain power-off, or marking the do=
main
> > > always-on, both avoid it. Is the NoC de-idle expected to work on a ge=
npd
> > > re-power here, or should this domain effectively stay on?
> > >
> >
> > Not quite sure what's going on with PVTPLL and NOC.
> > Maybe @Finley knows about this?
> >
> > > On TF-A: yes -- bl31 is built from upstream arm-trusted-firmware
> > > (github.com/ARM-software/arm-trusted-firmware, RK3568 platform), prov=
iding PSCI
> > > and the SCMI clock service. The only closed blob in the boot chain is=
 Rockchip's
> > > DDR init (rkbin), which is the standard situation for mainline RK356x=
.
> >
> > --
> > Best,
> > Chaoyi
