Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27494C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DF9710E16F;
	Mon,  6 Jul 2026 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMhM/uI7";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD28F10E16F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:42:10 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso5677143a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 06:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783345329; cv=none;
 d=google.com; s=arc-20260327;
 b=f2BRMtDwGOZRbG5Xlt2VSEtN2xj9iQZlsLFUkyENz+uLquINt45VDzHkhRaAPs/yqu
 iLQTgRuGrnf2M7CR8NF1Ty3DWb2pfEsBi9uiKkFi3iSOk/dni+IHTEOVNicDqVFRPv5+
 vsu/GMoxD1XyTTuBeOWwtKcdGspjLWlFnNMSyfMPndrlF9Sr8Rh/1V6sYUH0KAKhMcVj
 cKZevMzG3CsFzMn5cfG0BBv4wf82Fizs9f5rH1pcKbcgqHs5xLgrXMU9PhWhRWMHq8/X
 LNXnED0rzhFdIGAv0NSNwU3XBkY69dlk+RGqHeeta85cIExCq/Tb3VuwoIFovc6Fjy6w
 RHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OyGJOtfhAErGgCeOnX4Gebofpweeka44vZ90RePrO9s=;
 fh=6XeMsyKBaMDL3gv457T1JJzOsbbFEBfgqRYw4Tjm+xI=;
 b=qBMqehiosYFvJbkKyQfG+7LrQB2UDamusJ9V+KyHknhddjmueQxhXlZgRGBJhSdEyt
 7OLx9reaiG89CXEai7nt+0WAU5iymCY7r7258DzRRXgPVinYv8n7l0i0WIJYtZPWd6pS
 /mE8GI/DM1KcAq1AYk/FaV8Op4+ZBNu2gEh7vewWadzpLAoOkkgJecuNaT8kt/YQPeRi
 2qiBepMDx6MUpdY2dBLbHGcgdVb60sk6kE902T8KDsf4nhp8HJXcLk25Si0eePxAy0W/
 oKPNvcfUksihycjleZT+K0CxOvUfFMl0zDcRuxGEJ7K30EgsFJZcbuxeSbgJQd1ECUsf
 WDkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783345329; x=1783950129; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OyGJOtfhAErGgCeOnX4Gebofpweeka44vZ90RePrO9s=;
 b=AMhM/uI760VxZGMsOyYN9KKEMdW0sKk/Ddxq8/lxuk/bbzgRNAS7GfNFNcp2pi7/CP
 GiOUkMD+THhKG9qe5JXxe02tfNwa3tADfoafNqJV2D+yubzl4VgT8TQg79tJ5iUILoyP
 1a/lWEyviKpep+IIRucuAnT/T4stWpfdtFUE0GH6Gi0bz+caHNcXQu72yZI6mlBj+1zx
 MQ3HbyxKpzkwvNq2CasQ+AuuxyqQx5VSHdW/ELJoCEdFZh0qhQqk0XflOg6VKWi1MBZo
 5q+w35uSX607WFKMC2/jHnJL3xq3cJpoaBv80yCEix1R4VAbQ4XM54G/53TrpZxDb6xw
 5hwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345329; x=1783950129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyGJOtfhAErGgCeOnX4Gebofpweeka44vZ90RePrO9s=;
 b=hPcciH9O8bsSrd5YkrFqDDm7OSJivc0S0T583+U2o6qPdP2qb/7lW9CLYGen9NEFEv
 eoUwF97cT2iwyOXH2R5MF0ZQagJO6LY+mHrYp2ChIr5wxOZpx9P9MHWTc+8pXYRtxkXH
 ZczHW/ROXHJKECJbwwjEzOg1H22S2APtJzZl7tpk5c6bD2ULsb+VsGoscnWSwVOmqUun
 4qHWmN93aq8KvAYLREnt+l3o5KkFnSKsgQfLu+uRiLx6Y1wcDx3MLTGAFXpbyT4UrKvM
 w5tYbCqZMPjv/1xfUJkshNU5Mshj9CAzHH2SS5tmb8A5UPJ3NbiaWTVYHtyXQN4UVcOQ
 Hz7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrX6naeho10W64IfXhc9gwgF1CkjMbmBHOuf8ETpvIx6nsiVRM0arKOJn72FV0Va7M8tNhqIPNtt60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz8e0WHo+pQ6y3Lwj1duy1dwA8a/D7uxlf2SVT1BkAWb5NPOigV
 5XrMS4IyefPfKZWuPGBR7kBVZHJaZOENqs86sJk61cgaV62wJ5jcskDOahG6k3YbCkOXSS4Kjxh
 7Uof4uzsT3jreYmLPVbR3btUQP4GYlrE=
X-Gm-Gg: AfdE7cl8OtvhD4FDv1HuRnJC3JmmWIVfccUjPQ/N+ipd1r2KWAsEfL9v3ERDvSpBTYO
 DlWjI1jCamlLJpTK+oi3pzv74aLUp+vP8j560XsVsPWrT0o3O4SesHQKcWhC+BynN2CuKO3GATW
 zYVoHOsJ214JTnguS6m16zSySxbUZ99/wR5VYA4YoWqtwk0O/QHCSJ6hn/Tv5nhcMuGeW18Q1xv
 R0yjox0IKNG3RwRawejikQc40nyOMn4sgvIntDioj+7B/1f4lOw1m3VwZ4CU+h0usaVNwz+B89K
 UKIJElk=
X-Received: by 2002:aa7:c348:0:b0:697:ea47:ba50 with SMTP id
 4fb4d7f45d1cf-698c10ace6fmr4123599a12.13.1783345328789; Mon, 06 Jul 2026
 06:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
 <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
 <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
 <0919ffcc-81c3-483a-a3ba-404b455c2040@rock-chips.com>
 <42f1f39f-ab2b-4473-a82a-7ccefad41fcf@rock-chips.com>
In-Reply-To: <42f1f39f-ab2b-4473-a82a-7ccefad41fcf@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Mon, 6 Jul 2026 15:45:27 +0200
X-Gm-Features: AVVi8CdTZCAZuzC5BVQZaAlZiwxuJHObM_LaBO73abEeRemH5iddJTzOO64qSis
Message-ID: <CA+GS1Y06qa=brFiEow8M-T-uVKqCf6pF_h87Q+PjVZp+eoTo0Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000d59fb50655f170ea"
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

--000000000000d59fb50655f170ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chaoyi,

Thanks again for the AUTO_GATING fix and the MMU-v2 clarification =E2=80=94=
 both
are in v4.

The mainline `rocket` driver now probes, powers, and **submits** cleanly on
the RK3568 NPU. The
last blocker is purely functional: **a submitted conv never computes** =E2=
=80=94
and I've now localized
it precisely enough that I think it's a question only Rockchip can answer.

## The localization: the CNA weight-fetch DMA never fires

I captured the **working vendor `rknpu`** running our exact conv (`conv2d`,
16=E2=86=92128, 5=C3=975 s2) and
diffed its pipeline against `rocket` running the same conv, both driven to
the **identical
engaged state**:

- both units reach `S_STATUS=3D0x0c`, `S_POINTER=3D0x1000e` (executer bit16
set), `TASKST=3D0xf000`,
  `PC AMOUNTS=3D0x88`;
- the CNA config registers are byte-identical (CONV_CON*, DATA_SIZE*,
WEIGHT_SIZE*, CBUF).

Yet the data-amount counters diverge completely:

| counter | vendor `rknpu` (correct output) | mainline `rocket` (no output)
|
|---|---|---|
| `wt_rd` (0x803c) | **0x1900** | **0** |
| `dt_wr` (0x8034) | **0x6400** (=3D 204800 B, full) | **0** |
| `dt_rd` (0x8038) | 0x32c9 | 0x8b (regcmd fetch only) |

So on identical engaged HW with identical CNA config, the **vendor's CNA
issues its weight-fetch
DMA and the DPU writes the full output; `rocket`'s CNA never issues the
weight read** =E2=80=94 the MAC
array starves and the DPU writes nothing.

## What I''ve already ruled out

- **Command stream / weights / input:** byte-exact replay of the vendor's
captured `conv2d`
  regcmd **+ weight BO + input BO** through the rocket UABI =E2=86=92 still=
 no
compute. Content is not
  the gate.
- **`state_init`:** RK3568's `rk356x_rknpu_config.state_init =3D NULL` (onl=
y
RK3576 has one); we
  also tested the RK3576 `0x1024=3D0x80000000` / S_POINTER `0=E2=86=921=E2=
=86=920x1e` ritual
on RK3568 anyway =E2=86=92
  no change.
- **Reset / power / clocks / IOMMU:** rocket mirrors `rknpu_soft_reset`
(srst assert/deassert,
  SCMI/PVTPLL two-step, NoC de-idle at PMU 0xfdd90000, IOMMU re-establish);
clocks match the
  vendor (SCMI 1 GHz, CLK_NPU/aclk 200 MHz); AUTO_GATING =3D your bit-31 fi=
x.
- **Non-NPU-block writes (captured live, vendor + rocket same boot):** the
only raw non-NPU
  writes the vendor `rknpu` makes are the NoC/PMU de-idle
(`NOC_AUTO=3D0xfffb`,
  `BUS_IDLE_ST=3D0x1ea`, `PWR_STATUS=3D0x7f`) =E2=80=94 rocket makes them
**identically** (`0x1ea`/`0xfffb`).
  No `npu_grf` read-margin and no memory-repair on RK3568 (those exist only
on RK3576/RK3588).
  So GRF/CRU/PMU/NoC are matched too.

## The question

**With the executer engaged (`S_STATUS=3D0x0c`, `S_POINTER` bit16 set) and
the CNA regcmd config
landed, what triggers the CNA's weight-fetch DMA?** The vendor `rknpu`
reaches `wt_rd=3D0x1900`
from a clean submit; `rocket`, same SoC / engage / regcmd, stays `wt_rd=3D0=
`.

I've now matched every software-visible surface I can find =E2=80=94 NPU-bl=
ock job
writes (byte-exact),
non-NPU writes (NoC/PMU/GRF, above), regcmd+weights+input (Method B
replay), power/clocks/reset/
IOMMU =E2=80=94 and the vendor still fetches weights while rocket doesn't. =
So my
remaining hypotheses
are all HW-internal, and I'd value your read on which:
- an **ordering/timing** requirement between engage and the weight-fetch
trigger that a
  byte-identical-but-differently-sequenced submit doesn't satisfy;
- an internal CNA/CBUF **sequencer or credit/handshake** state that the
vendor's power-on or
  first-job path leaves armed and that isn't a CPU-visible register;
- or a genuinely undocumented CNA condition (a CBUF/DCOMP/weight-DMA
enable) needed before the
  fetch will issue.

Is any of these something the RK3568 NPU is known to require? Even a
pointer to "the weight-fetch
won't start unless X" would unblock the mainline driver.


I would be happy to run any targeted register capture on the board.

Thanks a lot,
Midgy

Le lun. 8 juin 2026 =C3=A0 05:40, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a
=C3=A9crit :

> On 6/8/2026 9:45 AM, Chaoyi Chen wrote:
> > Hi Midgy,
> >
> > On 6/8/2026 5:05 AM, Midgy Balon wrote:
> >> Hi Chaoyi,
> >>
> >>> As I said, it is v2. Could you please try using the code below instea=
d
> and
> >>> see if it works?
> >>> [ auto_gate =3D read(RK_MMU_AUTO_GATING); auto_gate |=3D BIT(31);
> write(...) ]
> >>
> >> Thanks -- that's clearly the right shape (read-modify-write, before
> paging is
> >> enabled, keeping the reset value instead of my clobbering 0x2).
> >>
> >> I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-device-op=
s
> work)
> >> using your bit-31 version and tested it on a ROCK 3B: the NPU IOMMU
> comes up and
> >> services the NPU's DMA cleanly -- the NPU probes, attaches its domain,
> and runs
> >> repeated conv submissions with no DMA_READ_ERROR and no page-walk
> stall. No
> >> regression from the write.
> >>
> >> To be precise about what I can and can't show: I tested both ways on
> v7.1-rc6 --
> >> with your bit-31 write, and on the reset value (0x3) -- and the NPU
> >> IOMMU services
> >> the NPU's reads with zero faults in both cases (no DMA_READ_ERROR, no
> page-walk
> >> stall). So I don't have a failing baseline here that bit-31 visibly
> >> fixes. Is the
> >> AUTO_GATING write needed on current mainline, or only under conditions
> I'm not
> >> reproducing (a particular traffic pattern / silicon rev)? I'll keep th=
e
> patch in
> >> your form unless you'd prefer to drop it.
> >>
> >> One question so I document it correctly: what does bit 31 of
> RK_MMU_AUTO_GATING
> >> control on the v2 block -- is it a master "disable internal auto
> clock-gating"
> >> for the page-table walker (i.e. so a TLB-miss walk's AXI master keeps
> its clock
> >> to completion)? The RK3568 TRM I have doesn't cover the IOMMU
> registers, so a
> >> one-line description would let me write an accurate comment.
> >>
> >
> > Glad to hear this works. Please refer to the commit below.
> >
> > [0]:
> https://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e738aaeebc=
3637c50ebd74cae
> > [1]:
> https://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a2309e24079=
1bc3aad63b7324e
> >
>
> It looks like RGA needs this patch too, and it has already been merged :)=
.
>
>
> https://lore.kernel.org/all/20260428-spu-iommudtefix-v2-1-f592f579e508@pe=
ngutronix.de/
>
> --
> Best,
> Chaoyi
>

--000000000000d59fb50655f170ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Chaoyi,<br><br>Thanks again for the AUTO_GATING fix and=
 the MMU-v2 clarification =E2=80=94 both are in v4.<br><br>The mainline `ro=
cket` driver now probes, powers, and **submits** cleanly on the RK3568 NPU.=
 The<br>last blocker is purely functional: **a submitted conv never compute=
s** =E2=80=94 and I&#39;ve now localized<br>it precisely enough that I thin=
k it&#39;s a question only Rockchip can answer.<br><br>## The localization:=
 the CNA weight-fetch DMA never fires<br><br>I captured the **working vendo=
r `rknpu`** running our exact conv (`conv2d`, 16=E2=86=92128, 5=C3=975 s2) =
and<br>diffed its pipeline against `rocket` running the same conv, both dri=
ven to the **identical<br>engaged state**:<br><br>- both units reach `S_STA=
TUS=3D0x0c`, `S_POINTER=3D0x1000e` (executer bit16 set), `TASKST=3D0xf000`,=
<br>=C2=A0 `PC AMOUNTS=3D0x88`;<br>- the CNA config registers are byte-iden=
tical (CONV_CON*, DATA_SIZE*, WEIGHT_SIZE*, CBUF).<br><br>Yet the data-amou=
nt counters diverge completely:<br><br>| counter | vendor `rknpu` (correct =
output) | mainline `rocket` (no output) |<br>|---|---|---|<br>| `wt_rd` (0x=
803c) | **0x1900** | **0** |<br>| `dt_wr` (0x8034) | **0x6400** (=3D 204800=
 B, full) | **0** |<br>| `dt_rd` (0x8038) | 0x32c9 | 0x8b (regcmd fetch onl=
y) |<br><br>So on identical engaged HW with identical CNA config, the **ven=
dor&#39;s CNA issues its weight-fetch<br>DMA and the DPU writes the full ou=
tput; `rocket`&#39;s CNA never issues the weight read** =E2=80=94 the MAC<b=
r>array starves and the DPU writes nothing.<br><br>## What I&#39;&#39;ve al=
ready ruled out<br><br>- **Command stream / weights / input:** byte-exact r=
eplay of the vendor&#39;s captured `conv2d`<br>=C2=A0 regcmd **+ weight BO =
+ input BO** through the rocket UABI =E2=86=92 still no compute. Content is=
 not<br>=C2=A0 the gate.<br>- **`state_init`:** RK3568&#39;s `rk356x_rknpu_=
config.state_init =3D NULL` (only RK3576 has one); we<br>=C2=A0 also tested=
 the RK3576 `0x1024=3D0x80000000` / S_POINTER `0=E2=86=921=E2=86=920x1e` ri=
tual on RK3568 anyway =E2=86=92<br>=C2=A0 no change.<br>- **Reset / power /=
 clocks / IOMMU:** rocket mirrors `rknpu_soft_reset` (srst assert/deassert,=
<br>=C2=A0 SCMI/PVTPLL two-step, NoC de-idle at PMU 0xfdd90000, IOMMU re-es=
tablish); clocks match the<br>=C2=A0 vendor (SCMI 1 GHz, CLK_NPU/aclk 200 M=
Hz); AUTO_GATING =3D your bit-31 fix.<br>- **Non-NPU-block writes (captured=
 live, vendor + rocket same boot):** the only raw non-NPU<br>=C2=A0 writes =
the vendor `rknpu` makes are the NoC/PMU de-idle (`NOC_AUTO=3D0xfffb`,<br>=
=C2=A0 `BUS_IDLE_ST=3D0x1ea`, `PWR_STATUS=3D0x7f`) =E2=80=94 rocket makes t=
hem **identically** (`0x1ea`/`0xfffb`).<br>=C2=A0 No `npu_grf` read-margin =
and no memory-repair on RK3568 (those exist only on RK3576/RK3588).<br>=C2=
=A0 So GRF/CRU/PMU/NoC are matched too.<br><br>## The question<br><br>**Wit=
h the executer engaged (`S_STATUS=3D0x0c`, `S_POINTER` bit16 set) and the C=
NA regcmd config<br>landed, what triggers the CNA&#39;s weight-fetch DMA?**=
 The vendor `rknpu` reaches `wt_rd=3D0x1900`<br>from a clean submit; `rocke=
t`, same SoC / engage / regcmd, stays `wt_rd=3D0`.<br><br>I&#39;ve now matc=
hed every software-visible surface I can find =E2=80=94 NPU-block job write=
s (byte-exact),<br>non-NPU writes (NoC/PMU/GRF, above), regcmd+weights+inpu=
t (Method B replay), power/clocks/reset/<br>IOMMU =E2=80=94 and the vendor =
still fetches weights while rocket doesn&#39;t. So my remaining hypotheses<=
br>are all HW-internal, and I&#39;d value your read on which:<br>- an **ord=
ering/timing** requirement between engage and the weight-fetch trigger that=
 a<br>=C2=A0 byte-identical-but-differently-sequenced submit doesn&#39;t sa=
tisfy;<br>- an internal CNA/CBUF **sequencer or credit/handshake** state th=
at the vendor&#39;s power-on or<br>=C2=A0 first-job path leaves armed and t=
hat isn&#39;t a CPU-visible register;<br>- or a genuinely undocumented CNA =
condition (a CBUF/DCOMP/weight-DMA enable) needed before the<br>=C2=A0 fetc=
h will issue.<br><br>Is any of these something the RK3568 NPU is known to r=
equire? Even a pointer to &quot;the weight-fetch<br>won&#39;t start unless =
X&quot; would unblock the mainline driver.<br><br><br>I would be happy to r=
un any targeted register capture on the board.<br><br>Thanks a lot,<br>Midg=
y</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr=
" class=3D"gmail_attr">Le=C2=A0lun. 8 juin 2026 =C3=A0=C2=A005:40, Chaoyi C=
hen &lt;<a href=3D"mailto:chaoyi.chen@rock-chips.com">chaoyi.chen@rock-chip=
s.com</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">On 6/8/2026 9:45 AM, Chaoyi Chen wrote:<br>
&gt; Hi Midgy,<br>
&gt; <br>
&gt; On 6/8/2026 5:05 AM, Midgy Balon wrote:<br>
&gt;&gt; Hi Chaoyi,<br>
&gt;&gt;<br>
&gt;&gt;&gt; As I said, it is v2. Could you please try using the code below=
 instead and<br>
&gt;&gt;&gt; see if it works?<br>
&gt;&gt;&gt; [ auto_gate =3D read(RK_MMU_AUTO_GATING); auto_gate |=3D BIT(3=
1); write(...) ]<br>
&gt;&gt;<br>
&gt;&gt; Thanks -- that&#39;s clearly the right shape (read-modify-write, b=
efore paging is<br>
&gt;&gt; enabled, keeping the reset value instead of my clobbering 0x2).<br=
>
&gt;&gt;<br>
&gt;&gt; I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-devic=
e-ops work)<br>
&gt;&gt; using your bit-31 version and tested it on a ROCK 3B: the NPU IOMM=
U comes up and<br>
&gt;&gt; services the NPU&#39;s DMA cleanly -- the NPU probes, attaches its=
 domain, and runs<br>
&gt;&gt; repeated conv submissions with no DMA_READ_ERROR and no page-walk =
stall. No<br>
&gt;&gt; regression from the write.<br>
&gt;&gt;<br>
&gt;&gt; To be precise about what I can and can&#39;t show: I tested both w=
ays on v7.1-rc6 --<br>
&gt;&gt; with your bit-31 write, and on the reset value (0x3) -- and the NP=
U<br>
&gt;&gt; IOMMU services<br>
&gt;&gt; the NPU&#39;s reads with zero faults in both cases (no DMA_READ_ER=
ROR, no page-walk<br>
&gt;&gt; stall). So I don&#39;t have a failing baseline here that bit-31 vi=
sibly<br>
&gt;&gt; fixes. Is the<br>
&gt;&gt; AUTO_GATING write needed on current mainline, or only under condit=
ions I&#39;m not<br>
&gt;&gt; reproducing (a particular traffic pattern / silicon rev)? I&#39;ll=
 keep the patch in<br>
&gt;&gt; your form unless you&#39;d prefer to drop it.<br>
&gt;&gt;<br>
&gt;&gt; One question so I document it correctly: what does bit 31 of RK_MM=
U_AUTO_GATING<br>
&gt;&gt; control on the v2 block -- is it a master &quot;disable internal a=
uto clock-gating&quot;<br>
&gt;&gt; for the page-table walker (i.e. so a TLB-miss walk&#39;s AXI maste=
r keeps its clock<br>
&gt;&gt; to completion)? The RK3568 TRM I have doesn&#39;t cover the IOMMU =
registers, so a<br>
&gt;&gt; one-line description would let me write an accurate comment.<br>
&gt;&gt;<br>
&gt; <br>
&gt; Glad to hear this works. Please refer to the commit below.<br>
&gt; <br>
&gt; [0]: <a href=3D"https://github.com/rockchip-linux/kernel/commit/7f8158=
fb41b5cc8e738aaeebc3637c50ebd74cae" rel=3D"noreferrer" target=3D"_blank">ht=
tps://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e738aaeebc3637=
c50ebd74cae</a><br>
&gt; [1]: <a href=3D"https://github.com/rockchip-linux/kernel/commit/6a355e=
5f9a2069a2309e240791bc3aad63b7324e" rel=3D"noreferrer" target=3D"_blank">ht=
tps://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a2309e240791bc3=
aad63b7324e</a><br>
&gt; <br>
<br>
It looks like RGA needs this patch too, and it has already been merged :).<=
br>
<br>
<a href=3D"https://lore.kernel.org/all/20260428-spu-iommudtefix-v2-1-f592f5=
79e508@pengutronix.de/" rel=3D"noreferrer" target=3D"_blank">https://lore.k=
ernel.org/all/20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de/</a=
><br>
<br>
-- <br>
Best, <br>
Chaoyi<br>
</blockquote></div>

--000000000000d59fb50655f170ea--
