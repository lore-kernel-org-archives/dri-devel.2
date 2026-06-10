Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A10ACD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 14:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB37810E9D8;
	Wed, 10 Jun 2026 14:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="VhFcql5D";
	dkim-atps=neutral
X-Greylist: delayed 382 seconds by postgrey-1.36 at gabe;
 Wed, 10 Jun 2026 14:34:51 UTC
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7892510E9D8
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 14:34:51 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1781101707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KIoAahAV4CuoU8RbqIQS/+Rbt/OxgplfKmIf4NRFcyo=;
 b=VhFcql5DYudJf2O1tHGaMXlSFbta4Hk/KSAZdvHEIwHdxAevssxXYmt1DQFTU2wg59pr/Z
 Jxh4OBD23Smk9eRs5uoR+Ysku8D1mqYpwZdQnU6IiH4tPqCDOwU8YfyBTWm4TWlHvJNIZr
 Nc+AXrTI011Jg4KyWK8V+kIc+InaporAeG2xb5FBCDO9eHm7UV0w/1/Za+FaNTKF/3wtwN
 3G2FYV3RqMj7tKuBU2TMA8gpfATvlp1ScRWi9g4BtOn7NfLUudpryRB8CrrojBwhwGhTqR
 7hUOW6IaelyYgrpdLchs+sqF226D35NbMxGeKWnN8yT0aPNVH1QO2SSR1Ta9Ag==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 16:28:17 +0200
Message-Id: <DJ5FUW50YM2N.6ZTY4WK27ZP5@cknow-tech.com>
To: "Midgy Balon" <midgy971@gmail.com>, "Diederik de Haas"
 <diederik@cknow-tech.com>
Cc: "Chaoyi Chen" <chaoyi.chen@rock-chips.com>, <tomeu@tomeuvizoso.net>,
 <ogabbay@kernel.org>, <heiko@sntech.de>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joro@8bytes.org>,
 <will@kernel.org>, <robin.murphy@arm.com>,
 <dri-devel@lists.freedesktop.org>, <linux-rockchip@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Simon Xue"
 <xxm@rock-chips.com>, "Finley Xiao" <finley.xiao@rock-chips.com>, "Jonas
 Karlman" <jonas@kwiboo.se>
Subject: Re: [RFC PATCH v3 0/9] accel: rocket: Add RK3568 NPU support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
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
 <CA+GS1Y1xAq-9eMyMmoVE6NG9KLG7XRxgPoSr5RkW=6fT5D820g@mail.gmail.com>
In-Reply-To: <CA+GS1Y1xAq-9eMyMmoVE6NG9KLG7XRxgPoSr5RkW=6fT5D820g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
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

On Wed Jun 10, 2026 at 3:36 PM CEST, Midgy Balon wrote:
> Hello Chaoyi & Diederik,
>
> I compared the RK3568 and RK3588 NPU power-domain + DTS as you
> suggested, and it lines up
> exactly with what you described.
>
> The difference is the `need_regulator` capability. RK3588's NPU domain is
> `DOMAIN_RK3588("npu", =E2=80=A6, false, true)` =E2=80=94 the trailing `tr=
ue` is
> `regulator`/`need_regulator`.
> The mainline RK3568 macro `DOMAIN_RK3568(name, pwr, req, wakeup)` has
> no regulator parameter at
> all, so `RK3568_PD_NPU` can't be marked need_regulator. My v4 adds
> that: a regulator-capable
> RK3568 NPU domain (need_regulator =3D true) plus `domain-supply =3D
> <&vdd_npu>` on the NPU node =E2=80=94
> i.e. the same shape as RK3588.
>
> And the fix you referenced (Frank Zhang's "pmdomain: rockchip: Fix init g=
enpd as
> GENPD_STATE_ON before regulator ready", plus "quiet regulator error on
> -EPROBE_DEFER") is
> already in my base (v7.1-rc6), so the `if (need_regulator)
> rockchip_pd_power(pd, false)`
> default-off path is in effect. That's what resolves the actual problem
> for me: with rocket
> built as a module (the normal config), need_regulator on the NPU
> domain, and those pmdomain
> patches in place, the board boots cleanly and NPU jobs run with no RCU
> stall / no deadlock. My
> earlier hang was an artifact of a self-contained rocket=3Dy image
> probing in the initcalls before
> the I2C regulator core was up =E2=80=94 as a module it loads ~6.8 s in, w=
ell
> after, so it's gone.
>
> I also went back and checked the `fw_devlink=3Dpermissive` question
> myself =E2=80=94 and good news, it
> turns out it is NOT needed. I rebooted the exact same kernel with
> permissive removed from the
> cmdline (strict fw_devlink, the default), and the board boots cleanly,
> the NPU probes
> (`rocket fde40000.npu: Rockchip NPU core 0 version: 0`), and NPU jobs
> submit and run five times
> in a row with no deadlock and no RCU stall. So strict fw_devlink
> resolves the NPU/PMIC ordering
> fine via deferred probe.
>
> The one remaining thing is cosmetic: at power-domain-controller probe
> (~2.94 s) I still get,
> in BOTH modes (with or without permissive):
>
>   rockchip-pm-domain =E2=80=A6: Failed to create device link (0x180) with
> supplier 0-0020 =E2=80=A6power-domain@6
>
> i.e. genpd can't form the link to the rk809 (the I2C PMIC supplying
> vdd_npu) because the PMIC
> isn't registered yet at that point. It's non-fatal =E2=80=94 the domain
> defaults off (Frank's patch),
> the rail comes up via the regulator core, the NPU probes a few seconds
> later, and all jobs run.
>
> One question: on RK3588 with need_regulator, do you also see that
> "Failed to create device
> link =E2=80=A6 supplier <pmic>" line at pmdomain probe, or does it order
> cleanly? If RK3588 is clean,
> is there a DTS detail (e.g. the regulator's bus/probe order) I should
> mirror on RK3568 to make
> the link form in time =E2=80=94 or is this line just expected/harmless an=
d
> best left as-is?

[    2.110935] rockchip-pm-domain fd8d8000.power-management:power-controlle=
r: Failed to create device link (0x180) with supplier 2-0042 for /power-man=
agement@fd8d8000/power-controller/power-domain@8
[    2.557459] sdhci-dwcmshc fe2e0000.mmc: Can't reduce the clock below 52M=
Hz in HS200/HS400 mode
[    2.647174] rockchip-pm-domain fd8d8000.power-management:power-controlle=
r: Failed to create device link (0x180) with supplier 2-0042 for /power-man=
agement@fd8d8000/power-controller/power-domain@8
[    2.945089] rockchip-pm-domain fd8d8000.power-management:power-controlle=
r: Failed to create device link (0x180) with supplier spi2.0 for /power-man=
agement@fd8d8000/power-controller/power-domain@12

8 =3D NPU; 12 =3D GPU

on both nanopc-t6-lts and nanopc-t6-plus (both RK3588).
And on a 6.18 dmesg output I have for Rock 5B, I see the ~ same, but then
it's 1-0042 instead of 2-0042.=20

I don't know if it's bad or harmless, but it is consistent.

HTH,
  Diederik

> @Diederik =E2=80=94 thanks; the DCDC_REG2 change and Jonas's USB-suspend
> series look like generally
> useful RK356x robustness fixes, though for this specific NPU
> device-link the need_regulator +
> Frank's pmdomain patches seem to be the relevant piece. I'll keep them
> in mind for suspend.
>
> The convolution-output / compute-completion issue is still separate
> and open (@Finley =E2=80=94 that's
> the PVTPLL/NoC one); the power-domain side is in good shape for v4.
>
> Thanks y'all for your help :)
>
> Kind regards,
> Midgy
>
> Le mer. 10 juin 2026 =C3=A0 12:05, Diederik de Haas
> <diederik@cknow-tech.com> a =C3=A9crit :
>>
>> Hi,
>>
>> On Wed Jun 10, 2026 at 3:14 AM CEST, Chaoyi Chen wrote:
>> > Hi Midgy,
>> >
>> > On 6/9/2026 7:11 PM, Midgy Balon wrote:
>> >> Hello Chaoyi,
>> >>
>> >> You were right - building rocket as a module fixes it. Thanks for the=
 pointer.
>> >>
>> >> I rebuilt with CONFIG_DRM_ACCEL_ROCKET=3Dm (everything else the same:
>> >> need_regulator on
>> >> the RK3568 NPU power domain via a DOMAIN_M_R variant, domain-supply =
=3D
>> >> <&vdd_npu>, and the
>> >> regulator-always-on workaround dropped). The board now boots cleanly
>> >> and, more importantly,
>> >> an NPU job submit no longer hangs: I ran the test workload five times
>> >> with no RCU stall and
>> >> no freeze.
>> >>
>> >> So with rocket=3Dm the need_regulator approach works on RK3568, and I=
'll
>> >> keep it for v4
>> >> (domain-supply + need_regulator, instead of marking vdd_npu
>> >> always-on). rocket=3Dm is the
>> >> normal configuration anyway; my earlier hang came from building it =
=3Dy
>> >> in a self-contained
>> >> image, so it probed in the initcalls (around 2 s) and the genpd ->
>> >> I2C-PMIC regulator
>> >> transition ran before the system was ready. As a module it loads from
>> >> udev much later
>> >> (~6.8 s here), after the I2C controller and regulator core are fully =
up.
>> >>
>> >> On your question of when the device-link error is printed - it is at
>> >> power-domain
>> >> controller probe, not at the rocket probe:
>> >>
>> >>   [    2.700618] vdd_npu: Bringing 500000uV into 825000-825000uV
>> >>   [    2.749637] rockchip-pm-domain fdd90000.power-management:power-c=
ontroller:
>> >>                  Failed to create device link (0x180) with supplier 0=
-0020 for
>> >>                  /power-management@fdd90000/power-controller/power-do=
main@6
>> >>   [    2.945955] platform fde40000.npu: Adding to iommu group 3
>> >>   ...
>> >>   [    6.840374] rocket: loading out-of-tree module taints kernel.
>> >>   [    6.877647] [drm] Initialized rocket 0.0.0 for rknn on minor 0
>> >>   [    6.879950] rocket fde40000.npu: Rockchip NPU core 0 version: 0
>> >>
>> >> So the device-link to the rk809 PMIC (0-0020) fails to form at ~2.75
>> >> s, well before rocket
>> >> loads at ~6.8 s. It is non-fatal here - the vdd_npu rail is brought u=
p
>> >> by the regulator core
>> >> and all jobs run - and there is no "failed to get ack on domain npu"
>> >> NoC warning this boot
>> >> (the always-on kernel had one). The complete boot log is attached.
>> >>
>> >> Two notes / one question:
>> >> - This boot used fw_devlink=3Dpermissive on the command line. Is the
>> >> "Failed to create device
>> >>   link ... supplier 0-0020" at pmdomain probe expected/benign, or is
>> >> there a clean way to make
>> >>   it order correctly (so it also works without permissive, and a =3Dy
>> >> build wouldn't deadlock in
>> >>   the initcalls)?
>> >
>> > We encountered the same issue on the RK3588 NPU before. And it was
>> > resolved with the following patch at that time.
>> >
>> > https://lore.kernel.org/all/20251216055247.13150-1-rmxpzlb@gmail.com/
>> >
>> > Please compare the differences in NPU pmdomain and DTS configuration
>> > between the RK3568 and RK3588.
>>
>> About a month ago on #linux-rockchip we were discussing PM 'stuff':
>> https://libera.catirclogs.org/linux-rockchip/2026-05-15#39939137;
>> which references this paste
>> https://paste.sr.ht/~diederik/89d9f84e22474e837b55286d213b67f03859ce2e
>> I've since removed the DCDC_REG2 for PineTab2 and the 'fix' should likel=
y
>> be extended to cover all RK3566/RK3568 devices though.
>>
>> It's what I made at the time hoping to fix a suspend/resume issue when
>> trying upstream TF-A. It didn't fix the issue at the time, but may still
>> be useful/needed and I think it's what Chaoyi hinted at.
>>
>> Just yesterday, Jonas posted this patch which may be useful/needed too:
>> https://lore.kernel.org/linux-rockchip/20260609154124.445182-1-jonas@kwi=
boo.se/
>>
>> HTH,
>>   Diederik
>>
>> >> - (The convolution output is still uniform zero-point / the job times
>> >> out - that is the
>> >>   separate NPU compute-completion issue, unrelated to the power-domai=
n
>> >> work. Finley, that is
>> >>   the one I flagged earlier re PVTPLL/NoC.)
>> >>
>> >> Kind regards,
>> >> Midgy
>> >>
>>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

