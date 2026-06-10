Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890BCCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 13:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82F510E997;
	Wed, 10 Jun 2026 13:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JC4Q1IBE";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB3910E9A5
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 13:35:33 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so13484277a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 06:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781098532; cv=none;
 d=google.com; s=arc-20240605;
 b=VWrsQUoDptA/wIzVx28UMveA11e8g2nGgY/RwLlvBQ7xR5GtI5EbuSK/7hkrys8DiM
 WMYEiFNdLxC3KsDPhtyMfDE5D06IXTTtKG+E+1fY0wYoEqRpGuag/5gGTTeU94idLrYx
 gwzTbfOMOTDv6HevJhm6InTeMOaX956eB7hR6BAH7ddJnfpXFf2b2hFsqgsGoRYIwn87
 +rNz5Hj4WsyBlKqaU/gT2bbY0VzGgii6E4spXLyw3N+vVTVX4+H8t6n4P7RtpDPYPrHQ
 xKrv1FjJpW9NKlAjw7YQihgWAf2G6TG9kyEZUHhx7KSWs3V3YD1D5mLLem+LrzqIdX05
 eYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WboogWqcoT+OL/ZD2SYskMF+y3oh6ksVJtvN7OeY8rI=;
 fh=xGpKlVKqh4KnEhu4vXggm33cKp30bXDjbAXYi+NvBfc=;
 b=cKstxOby/yPxvkCBn6a7+DInblW+gdLN4UEXiV5uwKOhWlC682rOHK1/1iEj54zrsO
 2/eHZNDa6KAbILZiQDq4vgdMo0bLKWyGwY9vVQZfQV8Ivzl1OQeuWLug5fsoCgbdD2Tt
 fumjTuKtocU0/JP3ISXABNvWL61Rld6uDldG/sdw54WAh/WvdBNtrF9R8hi8eTfOcoxU
 t/gCYj0dpojPbFD1Ph9NoUZ/2pUP5CTB7viz+vHh1usEo0+dZDzG826QR2iEcBMPKsTR
 LWqAuiD9khKP8j+MKf8kY/KtQIOT4VQM7PGC9cE7yiaNWkYfpKmr0IogoRwmxJbuIvGW
 Pzew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781098532; x=1781703332; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WboogWqcoT+OL/ZD2SYskMF+y3oh6ksVJtvN7OeY8rI=;
 b=JC4Q1IBE2HfzJcn5Jr11iEu6DD0VXRf4zqzOK+IgKd1z+6Ve4yk2zDmaO8dofu54fe
 y1ogyf54eJSlNKQpl/5PKbkRduJyQpCoxkvCCv+3mBZWf/CmGf/BZVM7qQdmeFIn3h+S
 OFBHl5I1kfGa30Rl8tOulvJlNDihcRy8KtXKCPrUmb7X1kRQkcNDl9oUeowsJl6iyHB9
 mZI2HQaJxkhmHuxUGpo0nFiEZNoDKoX4cGYQVUvRTMA9LNlmGZZEih8ff2c7VXeppPpr
 Omth8EeZq5k2XX16Qs2AMS9Sc+4EIIp2ZRUaZzVppxUglh20hOZytIzXDA21qONQUUFz
 tWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098532; x=1781703332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WboogWqcoT+OL/ZD2SYskMF+y3oh6ksVJtvN7OeY8rI=;
 b=ZHGZw7w0rf1/2YCEI6APPxfHZQIC12kRIR3KkI9/hm7X+i79tJa6H9JLPj0mppotMp
 f/nzEeectL4UMfS6pqHzGi542IqaLu+zXtCxrP6fZvlvFXbT4srROLRoppJSxW6xOcOk
 48Y/kZBRShUMImyWJ0WW7gYgL1aqOFGuF6LUrx36KX7v8nT+Qqwd3pCYXEK12krDJ6zi
 cyasypmyL6Wz7ZaXoPr+MjTYU2SAXXscOj/3jmLR1iMhGpi6CjwY2Fax5lcoaWsp8WOo
 JLO6P73b6TOfRWiTYaINXECp6p+ynWCx1Fxo9p6FcGqZ+3pAAvYnvs9pgWDWFQ3T2JlT
 fs0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dU9Cqv0VaqgoBvHrIdg4xLJK2O3l6b6PlYB3198tNMihs5tWI+wFYBz+aAwytmQrfnN/qR0t/Vzc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzy2L5/qsin3lTLqEWICKY9AmEZa55U08mw9S9AakBtUwRSYROy
 ed1qSVkmM8LjDylSen7rBxEIm4OyoND+nM56maqeaTYPFBWoflMVCWm19jv1/LZ+zGiVkEdysid
 oWk/996KyWepT2Jd6DXWGh0AgLFbsKgo=
X-Gm-Gg: Acq92OFtyyeZbrnkzedDHL78Iq69RiOEObSDtoNmZysBegOprxolnrwIy80P3jAJqos
 5QkeKXvyhJ7j5ubgARCumUQ7xKbF1iYF1JCTTx9tcZ8mLelZuPV3pVixIiOQ1T/lMEAYz1CaOSF
 bvEJQwZpcmsmVSinGLei8xDVlPWUrjasuYrhcW50woltobBsIBPuuRIJgoWgn3I6k/PTS2yAyxF
 UWjhe49wQp1Ugpz3PMZVhYNmqajc8bJ/I6SbxwIw5gCrHnb/VBPeZIJaeeS/Ou6C2ayLGpQ8NwV
 RRY99Onm7E4YvOFFOA==
X-Received: by 2002:a17:907:948e:b0:bec:5ebd:e169 with SMTP id
 a640c23a62f3a-bf37263c586mr1377264466b.22.1781098531867; Wed, 10 Jun 2026
 06:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <3d99569e-9c3a-49d1-93fb-1335382523e9@rock-chips.com>
 <CA+GS1Y1s78PwN63X2YJoS8VEGp7CpTERo_K65yKs00U4VRAw4Q@mail.gmail.com>
 <e5058919-9485-4de5-8eea-331ebfc2987c@rock-chips.com>
 <CA+GS1Y3ysdWZ3qCq3ip_Pbw+v4LxHZd95aBo=jwB+orYaMBBNw@mail.gmail.com>
 <CA+GS1Y0kAM_XGLQuKPTphif2HcQg18ZXhd8RHHr2xPOEMCDvXA@mail.gmail.com>
 <bcedaff0-abf8-4585-a0ea-057062cd0411@rock-chips.com>
 <CA+GS1Y2-hRqpGgsknh+oOX+-uZ3DZtdekdP9viTP6a40zhhUhg@mail.gmail.com>
 <b05f7154-e85f-4207-80ae-f080282ba780@rock-chips.com>
 <DJ5A9XL183RZ.20J3ASQ3EWUZ6@cknow-tech.com>
In-Reply-To: <DJ5A9XL183RZ.20J3ASQ3EWUZ6@cknow-tech.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Wed, 10 Jun 2026 15:38:24 +0200
X-Gm-Features: AVVi8Cf8gCpLbNssJy_FW_CB2ltoJNgKiOGOa6bXMaOGRFQOxsnQSP0W6Cmk0Xc
Message-ID: <CA+GS1Y1xAq-9eMyMmoVE6NG9KLG7XRxgPoSr5RkW=6fT5D820g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
To: Diederik de Haas <diederik@cknow-tech.com>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, tomeu@tomeuvizoso.net,
 ogabbay@kernel.org, 
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Simon Xue <xxm@rock-chips.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>
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

Hello Chaoyi & Diederik,

I compared the RK3568 and RK3588 NPU power-domain + DTS as you
suggested, and it lines up
exactly with what you described.

The difference is the `need_regulator` capability. RK3588's NPU domain is
`DOMAIN_RK3588("npu", =E2=80=A6, false, true)` =E2=80=94 the trailing `true=
` is
`regulator`/`need_regulator`.
The mainline RK3568 macro `DOMAIN_RK3568(name, pwr, req, wakeup)` has
no regulator parameter at
all, so `RK3568_PD_NPU` can't be marked need_regulator. My v4 adds
that: a regulator-capable
RK3568 NPU domain (need_regulator =3D true) plus `domain-supply =3D
<&vdd_npu>` on the NPU node =E2=80=94
i.e. the same shape as RK3588.

And the fix you referenced (Frank Zhang's "pmdomain: rockchip: Fix init gen=
pd as
GENPD_STATE_ON before regulator ready", plus "quiet regulator error on
-EPROBE_DEFER") is
already in my base (v7.1-rc6), so the `if (need_regulator)
rockchip_pd_power(pd, false)`
default-off path is in effect. That's what resolves the actual problem
for me: with rocket
built as a module (the normal config), need_regulator on the NPU
domain, and those pmdomain
patches in place, the board boots cleanly and NPU jobs run with no RCU
stall / no deadlock. My
earlier hang was an artifact of a self-contained rocket=3Dy image
probing in the initcalls before
the I2C regulator core was up =E2=80=94 as a module it loads ~6.8 s in, wel=
l
after, so it's gone.

I also went back and checked the `fw_devlink=3Dpermissive` question
myself =E2=80=94 and good news, it
turns out it is NOT needed. I rebooted the exact same kernel with
permissive removed from the
cmdline (strict fw_devlink, the default), and the board boots cleanly,
the NPU probes
(`rocket fde40000.npu: Rockchip NPU core 0 version: 0`), and NPU jobs
submit and run five times
in a row with no deadlock and no RCU stall. So strict fw_devlink
resolves the NPU/PMIC ordering
fine via deferred probe.

The one remaining thing is cosmetic: at power-domain-controller probe
(~2.94 s) I still get,
in BOTH modes (with or without permissive):

  rockchip-pm-domain =E2=80=A6: Failed to create device link (0x180) with
supplier 0-0020 =E2=80=A6power-domain@6

i.e. genpd can't form the link to the rk809 (the I2C PMIC supplying
vdd_npu) because the PMIC
isn't registered yet at that point. It's non-fatal =E2=80=94 the domain
defaults off (Frank's patch),
the rail comes up via the regulator core, the NPU probes a few seconds
later, and all jobs run.

One question: on RK3588 with need_regulator, do you also see that
"Failed to create device
link =E2=80=A6 supplier <pmic>" line at pmdomain probe, or does it order
cleanly? If RK3588 is clean,
is there a DTS detail (e.g. the regulator's bus/probe order) I should
mirror on RK3568 to make
the link form in time =E2=80=94 or is this line just expected/harmless and
best left as-is?

@Diederik =E2=80=94 thanks; the DCDC_REG2 change and Jonas's USB-suspend
series look like generally
useful RK356x robustness fixes, though for this specific NPU
device-link the need_regulator +
Frank's pmdomain patches seem to be the relevant piece. I'll keep them
in mind for suspend.

The convolution-output / compute-completion issue is still separate
and open (@Finley =E2=80=94 that's
the PVTPLL/NoC one); the power-domain side is in good shape for v4.

Thanks y'all for your help :)

Kind regards,
Midgy

Le mer. 10 juin 2026 =C3=A0 12:05, Diederik de Haas
<diederik@cknow-tech.com> a =C3=A9crit :
>
> Hi,
>
> On Wed Jun 10, 2026 at 3:14 AM CEST, Chaoyi Chen wrote:
> > Hi Midgy,
> >
> > On 6/9/2026 7:11 PM, Midgy Balon wrote:
> >> Hello Chaoyi,
> >>
> >> You were right - building rocket as a module fixes it. Thanks for the =
pointer.
> >>
> >> I rebuilt with CONFIG_DRM_ACCEL_ROCKET=3Dm (everything else the same:
> >> need_regulator on
> >> the RK3568 NPU power domain via a DOMAIN_M_R variant, domain-supply =
=3D
> >> <&vdd_npu>, and the
> >> regulator-always-on workaround dropped). The board now boots cleanly
> >> and, more importantly,
> >> an NPU job submit no longer hangs: I ran the test workload five times
> >> with no RCU stall and
> >> no freeze.
> >>
> >> So with rocket=3Dm the need_regulator approach works on RK3568, and I'=
ll
> >> keep it for v4
> >> (domain-supply + need_regulator, instead of marking vdd_npu
> >> always-on). rocket=3Dm is the
> >> normal configuration anyway; my earlier hang came from building it =3D=
y
> >> in a self-contained
> >> image, so it probed in the initcalls (around 2 s) and the genpd ->
> >> I2C-PMIC regulator
> >> transition ran before the system was ready. As a module it loads from
> >> udev much later
> >> (~6.8 s here), after the I2C controller and regulator core are fully u=
p.
> >>
> >> On your question of when the device-link error is printed - it is at
> >> power-domain
> >> controller probe, not at the rocket probe:
> >>
> >>   [    2.700618] vdd_npu: Bringing 500000uV into 825000-825000uV
> >>   [    2.749637] rockchip-pm-domain fdd90000.power-management:power-co=
ntroller:
> >>                  Failed to create device link (0x180) with supplier 0-=
0020 for
> >>                  /power-management@fdd90000/power-controller/power-dom=
ain@6
> >>   [    2.945955] platform fde40000.npu: Adding to iommu group 3
> >>   ...
> >>   [    6.840374] rocket: loading out-of-tree module taints kernel.
> >>   [    6.877647] [drm] Initialized rocket 0.0.0 for rknn on minor 0
> >>   [    6.879950] rocket fde40000.npu: Rockchip NPU core 0 version: 0
> >>
> >> So the device-link to the rk809 PMIC (0-0020) fails to form at ~2.75
> >> s, well before rocket
> >> loads at ~6.8 s. It is non-fatal here - the vdd_npu rail is brought up
> >> by the regulator core
> >> and all jobs run - and there is no "failed to get ack on domain npu"
> >> NoC warning this boot
> >> (the always-on kernel had one). The complete boot log is attached.
> >>
> >> Two notes / one question:
> >> - This boot used fw_devlink=3Dpermissive on the command line. Is the
> >> "Failed to create device
> >>   link ... supplier 0-0020" at pmdomain probe expected/benign, or is
> >> there a clean way to make
> >>   it order correctly (so it also works without permissive, and a =3Dy
> >> build wouldn't deadlock in
> >>   the initcalls)?
> >
> > We encountered the same issue on the RK3588 NPU before. And it was
> > resolved with the following patch at that time.
> >
> > https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
> >
> > Please compare the differences in NPU pmdomain and DTS configuration
> > between the RK3568 and RK3588.
>
> About a month ago on #linux-rockchip we were discussing PM 'stuff':
> https://libera.catirclogs.org/linux-rockchip/2026-05-15#39939137;
> which references this paste
> https://paste.sr.ht/~diederik/89d9f84e22474e837b55286d213b67f03859ce2e
> I've since removed the DCDC_REG2 for PineTab2 and the 'fix' should likely
> be extended to cover all RK3566/RK3568 devices though.
>
> It's what I made at the time hoping to fix a suspend/resume issue when
> trying upstream TF-A. It didn't fix the issue at the time, but may still
> be useful/needed and I think it's what Chaoyi hinted at.
>
> Just yesterday, Jonas posted this patch which may be useful/needed too:
> https://lore.kernel.org/linux-rockchip/20260609154124.445182-1-jonas@kwib=
oo.se/
>
> HTH,
>   Diederik
>
> >> - (The convolution output is still uniform zero-point / the job times
> >> out - that is the
> >>   separate NPU compute-completion issue, unrelated to the power-domain
> >> work. Finley, that is
> >>   the one I flagged earlier re PVTPLL/NoC.)
> >>
> >> Kind regards,
> >> Midgy
> >>
>
