Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282BCC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C16610F146;
	Wed, 23 Sep 2026 19:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="pT+YETzc";
	dkim-atps=neutral
Received: from mail-vs2-f2.google.com (mail-vs2-f2.google.com [74.125.227.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F46D10F146
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 19:29:54 +0000 (UTC)
Received: by mail-vs2-f2.google.com with SMTP id
 ada2fe7eead31-7a767919411so464061137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1790191793; x=1790796593;
 darn=lists.freedesktop.org; 
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hn1eZ/3UxUJsD61phkFUshvFdrzAv3XAdiABm00xZKE=;
 b=pT+YETzcOHIbRRGoQvn0H2CSojvOx/QC+Zrj+gwjRjWNeXI0HwuX9pKkzI09nCRcjK
 9wTShQbd2BEYN21g5o3kqDxSA4zjs9NsVtaZ6934IgErPa60DMMdLZ1OZoYrJKtCFf6c
 CDQbb8gHRn7cy+Fc0TDO1DRQq9xq8K2i+yTkG9j56aU6+QQ4TU/t6OgbQY43JyrqLpdf
 Nf1D9LbbtMDENPknNcIqJYtYmxKHyCD7p6tk/r7PMYElHdUzfiD+hpUIYrm+JfHUtZSa
 quapXh9ihAE2EP3vj6M25Elv6+zQzRB0eIJmJsy7rTrkUjdd0vtwwN/smkftU2OGkVSR
 qSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790191793; x=1790796593;
 h=mime-version:user-agent:content-type:autocrypt:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hn1eZ/3UxUJsD61phkFUshvFdrzAv3XAdiABm00xZKE=;
 b=C2Khf0KD1O7bWe5Daj0gBzHKV67iW1S7ewvTMG/mebmnKZrTpjdzyECyRjDx31nnW2
 ZCUSPNQvNNap69+8YnUF5GDxJgNsek2nReQ9Rlm9VuJhEIVkuIBv/3PbL0P2TcrU57UV
 Eb0aL9/C1Awq5v4OduiiBZrmn7RtHA4qOff3MZL4hFRG4A3c4z0FBjJ7Aj6ce+x7BZkv
 tB5F2VyMmU4clFAW1hRoW3nLaDhrBRy2jgCBFWkcV4qEzakurXliDKwXk3TqaU/U0neM
 UXQ5wsyCLkLSGEPQUrTXTV0WGFqRTUV1SThTn+OiYfNHQqXRmcwpq2G0P9jK8Jy81wfu
 32gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3DU04XLfeCENo72RdeGkoCu+lEkQYDAM/tXIv3Mzs83PZHcZg2ECxXPnl+9C2Tk+ENy+3RRev6U4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kc2nxsDV58EScj7wrFrv/7wL4LnNXC3xCm29hRm66QWdvbE30d
 Jlx5va8L2HcZTA+IxWBvDQy7VQgKVgbbjIDwmB+MXvieHOzTu7jDVdQ4wIs6D8ZcyZg=
X-Gm-Gg: AYBFou2MUCRJhDZUDAGtRz6NBRxGfYas05fsm0Z8/XSWTYQyDhgJpsf0kRXZ6p+ktoN
 829Xz/xTHJos69GtiDNQWtUEHZ3DHUyM9cJnrd+pBUDIiL8NGNkrSGjD8WyJ3clw+h/5juCWptb
 50BcDyCtbJJktTYQ2f5rJWUjKn9jx+buIguPQSnkryAS9LabtZh4XuC0MV5JeFdwFc/VHyNoB9u
 XrSQXGxqJ7RsFQaZMxt/9ZPgT7jOVI7v7ciSd0sQF2p0b1Z8/2enBEVIVsZkecCpCSIFV++sm++
 n3SEAKqSBh8LFZoaPSox0S+rB5zoKi/uZBTA3fskD+AzorfrpNXONzecWJA4u80rX3CSM0m7aGd
 EbgOccKNOZdpOVB3AafjXiPARcujSkFE7CD1UBSZXWVJGrNXGq1dUE4y2Nx4H9oiRsec+Z/FKQz
 E4+GUk0J3+wtIFBMwkKQn9BWZPhSL5vp4/bIySaErrCTAiU7iHjFlPO7klaWe/58ulgGM9+ltGQ
 wpwAojRtKhJeL4=
X-Received: by 2002:a05:6122:289b:b0:5c9:a60b:e5b5 with SMTP id
 71dfb90a1353d-5cb0b48ad93mr232501e0c.14.1790191792821; 
 Wed, 23 Sep 2026 12:29:52 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f04c161fsm4026701e0c.4.2026.09.23.12.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 12:29:51 -0700 (PDT)
Message-ID: <9cc5365470490b4b66364e60fb614ccda7e86c6f.camel@ndufresne.ca>
Subject: Re: [PATCH v2 00/11] accel/rocket: DVFS for the RK3588 NPU
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Igor Paunovic <royalnet026@gmail.com>, Tomeu Vizoso
 <tomeu@tomeuvizoso.net>,  Oded Gabbay <ogabbay@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>,  Sidong Yang
 <sidong.yang@furiosa.ai>, Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel	 <sebastian.reichel@collabora.com>, Jiaxing Hu
 <gahing@gahingwoo.com>, Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li
 <lgs201920130244@gmail.com>,  =?ISO-8859-1?Q?H=FCseyin?= BIYIK	
 <boogiepop@gmx.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 15:29:49 -0400
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-Jtkqc4cIzSmAlFmMQFAP"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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


--=-Jtkqc4cIzSmAlFmMQFAP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 22 septembre 2026 =C3=A0 10:01 +0200, Igor Paunovic a =C3=A9crit=
=C2=A0:
> The rocket driver runs the NPU at whatever rate the devicetree pinned
> it to: 200 MHz on the RK3588, out of the 1 GHz the hardware reaches.
> This series adds devfreq, the OPP table and the thermal plumbing that
> go with it.
>=20
> v1: https://lore.kernel.org/r/20260904130858.27803-1-royalnet026@gmail.co=
m
>=20
> As Tomeu asked [1], the slot-search fix now leads the series, with the
> two rocket fixes this builds on and, as patch 4, 2/2 of my July
> lifecycle series [2], without which v2 oopsed when one core was unbound,
> bound and unbound again. KASAN found that v1 4/7 (now 8) kept a clk
> handle that unbinding freed; the notes under each --- list the rest.

In future series or update, can you use common formatting in the future, I =
find
your changelog hard to read. Do something like:

  Since v1:
   - Changed patch X with action Z
   - Fix blabla=20
   - ...

Its actually good to be more concise in your communication, "wall of text" =
are
difficult to cope with for maintainers.

cheers,
Nicolas

>=20
> Hardware constraint
> -------------------
>=20
> The three cores share one clock and one supply. The clock comes from a
> PVTPLL inside the NPU power islands: for a PVTPLL rate the firmware
> programs NPU GRF registers inside the islands, for the 200 MHz boot rate
> it only switches CRU selectors to GPLL (clk_npu_set_rate() in
> plat/rockchip/rk3588/drivers/scmi/rk3588_clk.c, TF-A v2.12.0, which
> Nicolas pointed me to). An island powered up while the clock is above
> the boot rate never acknowledges the power-on, and the next register
> access into it takes an asynchronous SError. Returning to the boot rate
> is safe at any time; raising the clock is not, so while it is above the
> boot rate every core is held runtime resumed and no island can
> transition. Unbinding any core takes devfreq down until all are bound
> again.
>=20
> The firmware accepts only the nine rates of its rk3588_npu_pvtpll_table,
> 300 to 1000 MHz in 100 MHz steps plus 200 MHz, and refuses any other.
> The refusal never reaches the caller: clk_change_rate() ignores what
> ->set_rate() returns, so clk_set_rate() reports success and the clock
> stays put. Hence patch 7 names exactly those nine.
>=20
> The table is on all three cores with opp-shared (Nicolas's review);
> the one devfreq device sits on rknn_core_0, the lowest devicetree index.
> Patch 9 explains the maximum over the cores and why runtime suspend
> does not call devfreq_suspend_device().
>=20
> Testing
> -------
>=20
> Orange Pi 5 Plus, 7.3.0-rc2 (drm-misc-next 3afbeb6b99dd) plus this
> series, in-tree rocket, BL31 v2.12.0-10-g70d814213: the edk2-rk3588 TF-A
> branch with upstream d2d6928641ba, so that it reports the PVTPLL rate it
> measures. MobileNetV1 through Teflon, 3 x 20 s per arm, one thread
> pinned to one CPU, CPUs on the performance governor, a bit-exact oracle
> on every inference, polling_interval at the driver's 50 ms, core 0's
> interrupt on a CPU with its deep idle state disabled.
>=20
> cur_freq is only the driver's request and scmi_clk_npu on the GPLL path
> echoes the last accepted rate, so the CRU selector is the witness
> (CLKSEL_CON74 bit 0 =3D PVTPLL, CLKSEL_CON73 =3D GPLL divider), read once=
 a
> second:
>=20
>   200 MHz OPP, userspace     91.15 inf/s   CRU GPLL/6 =3D 198 MHz, 700 mV
>   1000 MHz OPP, userspace   234.45 inf/s   CRU PVTPLL (BL31 1 GHz), 850 m=
V
>   simple_ondemand           232.88 inf/s   OPPs 200-1000 MHz
>   200 MHz OPP again          90.87 inf/s   drift 0.997
>=20
> That is 2.57x pinned and 2.55x under the governor, 0.7 % below pinned;
> the oracle and the interrupts per inference were the same in all four
> arms.
>=20
> Three clients, each with its own oracle, all three cores computing
> together, output bit-exact and identical to a single-client control:
>=20
>   OPP                one client   three clients              total
>   900 MHz, 800 mV      234.42     199.33 + 198.95 + 199.19   597.47 inf/s
>   1000 MHz, 850 mV     240.49     203.16 + 203.01 + 203.46   609.63 inf/s
>=20
> After 25 s of load the governor is at the 200 MHz OPP from the first
> sample (0.24 s apart) through the 60 s idle window: CRU 198 MHz in all
> 60 one-second samples, rail 700 mV. The islands were power-cycled five
> times at 700 mV and powered down once more after a raise to 1000 MHz.
> All six bind orders give bit-exact output, with devfreq and cooling back
> on rknn_core_0 after every rebind.
>=20
> Unbind and reload: 25 rounds of all three cores, 4 of a single core with
> an inference while it was gone, 5 rmmod rounds, and 3 unbinds plus 1
> rmmod with the clock raised (CRU on the PVTPLL before each). Without
> patch 4 the single-core round oopses, as its commit message shows.
>=20
> On a KASAN, kmemleak and PROVE_LOCKING build of the same tree the unbind
> (no client submitting), reload, three-client and island tests gave no
> report and kmemleak nothing from this driver, and a lockdep run through
> the governor, cooling, three clients, and unbind and rmmod with the
> clock raised to the 1 GHz OPP left lockdep enabled.
>=20
> Build: the series was rebased onto drm-misc-next 8ef59ee79407 to send
> it; apart from one comment corrected in 9 (rocket_devfreq.o is
> byte-identical), the patches are the ones tested above. On that base,
> arm64, gcc 13.3: each patch that touches drivers/accel/rocket builds
> with W=3D1 and no warning, and sparse reports nothing in
> drivers/accel/rocket; 9, 10 and 11 also build with W=3D1 and no warning
> with CONFIG_DEVFREQ_THERMAL=3Dn. dt_binding_check at 6 and 11, and
> CHECK_DTBS on rk3588-orangepi-5-plus, rk3588s-orangepi-5 and
> rk3588-edgeble-neu6b-io at the base, 7 and 11, give no schema warning.
> A full Image, modules and dtbs build at 11 completes with no warning
> from drivers/accel/rocket. checkpatch --strict flags only the 75-column
> oops line in 4 and MAINTAINERS for the new files in 9, which
> F: drivers/accel/rocket/ covers.
>=20
> Two corrections to my reply of 9 September [3]: the supply could have
> come down to the 200 MHz voltage even had the clock change failed, since
> the refusal is not reported, so the CRU selector is the witness now; and
> the v1 governor arm was the governor running, not limits pinned by hand.
>=20
> Not done
> --------
>=20
> - Unbinding a core while clients submit is still unsafe. Patch 3 notes
>   that an open file keeps an entity on the departed core's scheduler;
>   on the KASAN build (three clients running, then as root
>   "echo fdac0000.npu > /sys/bus/platform/drivers/rocket/unbind") that
>   is a use-after-free:
>=20
>     BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xb4/0x118
>      drm_sched_rq_remove_entity+0x94/0x2b0 [gpu_sched]
>      drm_sched_entity_select_rq+0x1f4/0x698 [gpu_sched]
>      drm_sched_job_arm+0x50/0x258 [gpu_sched]
>      rocket_job_push+0x2f8/0x6b8 [rocket]
>      rocket_ioctl_submit+0x888/0xd28 [rocket]
>     Freed by: drm_sched_fini <- rocket_job_fini <- rocket_core_fini <-
>               rocket_remove
>=20
>   then a soft lockup: drm_sched_fini() frees the run queues while the
>   entity still points at one. drm-misc-next has the same path (read,
>   not run): rocket_job_open() builds the entity over every core, and
>   rocket_remove() ignores open files. The fixes I see are policy,
>   suppress_bind_attrs (undoing patch 4) or unplugging the DRM device
>   when any core goes. Tomeu, which would you prefer? I will write it.
> - Probe and remove are not serialised against open, and a file opened
>   while a core probes can see its scheduler uninitialised; both predate
>   this series.
> - Lifecycle 1/2 [2] (a devres leak that moves the accel minor up after
>   every full unbind and rebind, invisible to kmemleak) builds on
>   Guangshuo Li's "accel/rocket: clear rdev on device init failure" [4],
>   which is not in drm-misc-next. Sashiko's other pre-existing findings
>   on the standalone slot-search patch, which I agreed with [5], stand
>   unless patch 4 covers them.
> - Not exercised: a devicetree without the OPP table or without
>   assigned-clock-rates (code-read only), throttling at 85 degrees (not
>   reachable here), system suspend (s2idle does not resume on this board,
>   for reasons outside the NPU), kexec from a raised clock, and any other
>   board. No milliwatt figure, no energy model.
>=20
> Routing
> -------
>=20
> Patches 1-4 are fixes with Cc: stable and 9 builds on 1, 2 and 4, so the
> simplest route is all but the two dts patches through drm-misc-next. The
> binding (6) must land before those (7 and 11, Heiko's tree), which I can
> resend once the rest is in. 1-3 supersede their standalone postings
> (links under each ---); 5 is also 01/14 of Jiaxing Hu's RK3576 series,
> and whichever lands first, the other drops it. I have not rebased onto
> that series.
>=20
> Questions
> ---------
>=20
> Q1. DT maintainers: is opp-shared on all three cores the right
>     description of one clock and one supply? v2 leaves opp-suspend out;
>     Nicolas found it "not 100% fit" for 200 MHz but not unfit either,
>     and asked for your view [6].
> Q2. Maximum over the cores, or a summed busy count? And no OPP table
>     means no devfreq and no error, as in panfrost and lima: the policy
>     you want?
> Q3. assigned-clock-rates stays on all three nodes. Jiaxing reports that
>     on the RK3576 it hangs the board before the console when set on the
>     SCMI clock, and that the vendor driver never writes that rate from
>     DT [7]. I have not booted this board without it. Keep it, or drop it
>     in a patch on top?
>=20
> Nicolas also floated the component framework; I have not tried it.
>=20
> Credits
> -------
>=20
> Nicolas Dufresne: review, opp-shared, the TF-A pointer, and a proof of
> concept with the same rates and voltages. Tomeu Vizoso agreed to the
> full-range table [8]. Jiaxing Hu: the RK3576 multi-core corruption the
> three-client test answers, a test and a review. Sidong Yang: the report
> behind patch 3 and a test.
>=20
> Jonas Karlman pointed me at his GPU approach, a .config_clks() that
> checks pm_runtime_suspended() [9][10], and warned that "just reading
> clk_summary to read SCMI clock rate can issue SError or a freeze" [11].
> From the code, not a test: ->get_cur_freq() returns the last request,
> probe reads the boot rate with the domain on, and with the in-tree
> devicetree every set_rate that reaches the firmware, re-read included,
> runs with the cores held.
>=20
> H=C3=BCseyin BIYIK wrote TF-A commit d2d6928641ba, which makes BL31 repor=
t
> the PVTPLL rate it measures rather than the one asked for, and guessed
> early that the clock framework ignores what SCMI answers [12]; for a
> refused set_rate it does.
>=20
> The Assisted-by: LLM tags are Claude (Fable 5.1 and Opus 5; the v1
> cover named only Opus 5, though Fable 5.1 worked on v1 too). We wrote
> the code and these messages together, including the v3 changes to patch
> 4; it also found the silent refusal with me in the clock, OPP and TF-A
> code, wrote and adversarially reviewed the test scripts, and analysed
> the crash patch 4 fixes and the one under Not done. I threw out plenty
> of what it proposed. The board, every boot and measurement, the decision
> to send this and the responsibility for it are mine.
>=20
> [1] https://lore.kernel.org/r/CAPsqS2QXQda2ftbEJb_-Qeva9ay4+4ysdpUtj8jAvb=
yAsYiAJw@mail.gmail.com
> [2] https://lore.kernel.org/r/20260731064933.12548-1-royalnet026@gmail.co=
m
> [3] https://lore.kernel.org/r/20260909091825.10838-1-royalnet026@gmail.co=
m
> [4] https://lore.kernel.org/r/20260708062845.716487-1-lgs201920130244@gma=
il.com
> [5] https://lore.kernel.org/r/20260904135938.8757-1-royalnet026@gmail.com
> [6] https://lore.kernel.org/r/9af28de2a07f7965300b898994481ccf194a30da.ca=
mel@ndufresne.ca
> [7] https://lore.kernel.org/r/20260904110853.85150-1-gahing@gahingwoo.com
> [8] https://lore.kernel.org/r/CAPsqS2RRUyG1vz5Nm7990yd0hcKR5E-SWhbt0ishaV=
YvCqQftw@mail.gmail.com
> [9] https://lore.kernel.org/r/ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo=
.se
> [10] https://github.com/Kwiboo/linux-rockchip/commits/next-20260619-rk35x=
x-scmi-gpu-clk/
> [11] https://lore.kernel.org/r/82c8b17e-7215-45ea-84d1-9991ba6fb541@kwibo=
o.se
> [12] https://lore.kernel.org/r/20260903185147.49411-1-royalnet026@gmail.c=
om
>=20
> Igor Paunovic (11):
>   accel/rocket: search every core slot when a core is removed
>   accel/rocket: number the cores by devicetree position, not bind order
>   accel/rocket: search every core slot when looking up a scheduler
>   accel/rocket: keep core slots stable across unbind and rebind
>   accel/rocket: request the core clocks by name
>   dt-bindings: npu: rockchip: allow DVFS and thermal properties
>   arm64: dts: rockchip: rk3588: add an OPP table for the NPU
>   accel/rocket: restore the NPU clock boot rate before powering the
>     cores down
>   accel/rocket: add devfreq support
>   accel/rocket: register a devfreq cooling device
>   arm64: dts: rockchip: rk3588: add passive cooling to the NPU thermal
>     zone
>=20
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  10 +
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  17 +-
>  arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi  |  54 ++
>  drivers/accel/rocket/Kconfig                  |   2 +
>  drivers/accel/rocket/Makefile                 |   1 +
>  drivers/accel/rocket/rocket_core.c            |  14 +
>  drivers/accel/rocket/rocket_core.h            |  16 +
>  drivers/accel/rocket/rocket_devfreq.c         | 525 ++++++++++++++++++
>  drivers/accel/rocket/rocket_devfreq.h         |  67 +++
>  drivers/accel/rocket/rocket_device.c          |   2 +
>  drivers/accel/rocket/rocket_device.h          |  21 +
>  drivers/accel/rocket/rocket_drv.c             | 192 ++++++-
>  drivers/accel/rocket/rocket_job.c             |  47 +-
>  13 files changed, 945 insertions(+), 23 deletions(-)
>  create mode 100644 drivers/accel/rocket/rocket_devfreq.c
>  create mode 100644 drivers/accel/rocket/rocket_devfreq.h
>=20
>=20
> base-commit: 8ef59ee794076e2b58cff357b12de2ba5d441271

--=-Jtkqc4cIzSmAlFmMQFAP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarQorQAKCRDZQZRRKWBy
9L5vAQC2+yl11puqRiJoi89/+dJOLxIzAm/Izn6yng1tk2+FQwD/StGT2ceNp3FE
dPu70d/pmAb68n+KUfqRXbuwmM/o2gw=
=TFGy
-----END PGP SIGNATURE-----

--=-Jtkqc4cIzSmAlFmMQFAP--
