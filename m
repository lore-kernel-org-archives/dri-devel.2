Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C71C5CFDB
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 16:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F53F10E216;
	Sat, 15 Aug 2026 16:33:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="ttLHyqWo";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C5710E216
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 16:33:50 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-51c4436d02cso3164721cf.1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 09:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786811629; cv=none;
 d=google.com; s=arc-20260327;
 b=GhhsofVViq7R/DpqdfLu45e83wIZ1yVgHtbZ06NxzHN85yvhSTV/v2QFzrGewimMLL
 CaWItIsbej9fD+26qoVKLdxtgR/TGTF3MzWAUDiUS2NfX5kMj7vSVntwWU+LieUHylov
 Mx7K/bSOlasdYwjr3+iA/ctKuLK/lK/rm4rk33NvEwfND0G2vwa1+imMzAFlg0XP3+bG
 zHV8+lBnsPsM9Bg9FmGLiOzuomgttqv7h9vO0LPqypSyJrSLdHKsqnHikPDTeOpm3sQH
 8mrqOkSvxOmGV9cTgar3fIAYKx7z4CEstMMCTaxg06ItANa0gUGXzfSKZZJbsd2Pf+Zl
 izAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XWv6R0AYAVNGo+Aet0gzXlLoRnqMgVYYtRRPw5W7opk=;
 fh=87jCGLU7oTV7V/oWfKQHZjD88aM5BnOdlnlPtVkfDuo=;
 b=CAkgOomr0h5rOBohisD58mCJI98le/A01BxnD8Fn1FIcqzf38OJwjWlJXbt1Gy3hIl
 n/+r2qFMuGCMGh31dt5pvzP42cJ0SV63VwaW8hqtX2/WdpKC1mDMFs7hKeoVSPJMV79m
 6Ovg62i74W99Tsm42IWuzULbiroJzJTO9iED6HKQeRxQw7Ah+lIqsSg/eHucocR8qoD2
 Yxw/lMvhs4LHpYmoyJt5+89i+yUcyU+ScAu0rlfEAQZVuceYzREWMNKDFpuEci3SQBci
 YL68CJMGcQ7AjZwajPjuk1tpONyC+fjPVQfZIuyT60l9StVfVz6E1a1RpxmpNaRS+ToE
 nntQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1786811629;
 x=1787416429; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XWv6R0AYAVNGo+Aet0gzXlLoRnqMgVYYtRRPw5W7opk=;
 b=ttLHyqWozzhnFR2CeWYmcnjdVEF0/Cn1sY2Ws/KSJoAnB+GrfdbM2L4oVmd+G3JF0T
 VjhlP/XZvqwkhMuymO+EGjDBcn3MY1XhOQ4LtB6F3VYKSgjreEjML0iFuTsQLYDniJIY
 I22xBRWiz72xFiuR+E1aIEWZ6/ydZpHy3y0RfxiAXiiFxBipFfVJGAqUCpFVzUfuPXRw
 S1vNtjkJsuyhsz5jcZm2yEPpiX76xZYpdc9mUwJcr1QFVKqLaYl3rku0Yz5p4OqeEsYw
 XeQufSo8ERDA31o6yh+W9f+jiUvc5/lOWIDdh7erfwl57v7r2hl1O0gwo+HmNsrLmvLb
 biYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786811629; x=1787416429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XWv6R0AYAVNGo+Aet0gzXlLoRnqMgVYYtRRPw5W7opk=;
 b=IW0NY/cXk7SzgmEQsx1eifrubDkf5ZcccI7K9fBupzZz5Wrxziccl/NAOW3au8V/At
 5IgsiKTXgudNBt2ybCn44ciIakyKGp1vIAIvdN4TVFq3GlBRP5TrfbU8crKaNEkR2tPh
 PMnl2dGXBjgKxY1j9GOhnTog2NTwe1oQXgZe+vY4lW/T9U72TfuQqMDhJqsXUmyfRuzQ
 FeiiHF8jnvBuEqLsvVpNb2oMgWQslM2gF0p4EH06r3PdLpCiXUufSZEXAqpu7tuuAh1L
 yFx/dFlgtXmkYcc+GlTxr7YaaOAhiwGfdtXFcJ+si81AwAbz5N5BIjyqO7OOyvG55h0N
 aAJQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpA2usYoJJv+4Wapdpoe9RLLpfHa+YJfbhWiURFaFsoebI5D6yFCHLLcXW5k4MIxJ4OZcMLCG2IFIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCnh/A2WouVww9NuM4f9sLzcro09Nof1u9d02+lXP2HfzYNJZ7
 Fwb1QIUkx2IHGSSFzv59LEkt+/jfdNf73x+sELPiBByzkMVR9IPNJtMd9WOpan/ISJFjhkjQO07
 sgR984iZF9lIFJ83TAPmAZyLpp1J6Q4CJ8s5goatSuQ==
X-Gm-Gg: AR+sD13m1e2mFZtWo2ok1qkyhN4YPsBUvnpuwysjeKgRKSBb9alandSzw0zx+RL/SyP
 Wmel85Punri3YooCclmH6eEJ/74/cCTXMXdSzpUS3z1pY3D0uMsy+Ap/boShqYRThdB5GWlrl2Q
 lDaz1yFPjuu6LIyEIIbCW1R0imqq1BmVeAU5Q9Ktohvf8nZI08NyrfIcawdru8FZribvoFxEE7t
 AKOKdY297HXmLvIhl6pleKf7xvG1vvSXY+uT394EEvzdgia8LJY9AnKBOST2ZZmSRwYCkufH0wu
 kyx8vyinrh+ETBMYJWW17Q8HS+PyeaWM/pTW+nAHG6KrvugGfnLt7i4=
X-Received: by 2002:ac8:5a95:0:b0:517:5e32:af1e with SMTP id
 d75a77b69052e-52d85303553mr148520281cf.8.1786811629076; Sat, 15 Aug 2026
 09:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <20260801193237.2539957-1-gahing@gahingwoo.com>
 <CAEWPSH7upAFGOxg5Eep9nXA16L7PWtXJtk1+5bsnJYNjxm7joQ@mail.gmail.com>
In-Reply-To: <CAEWPSH7upAFGOxg5Eep9nXA16L7PWtXJtk1+5bsnJYNjxm7joQ@mail.gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Sat, 15 Aug 2026 20:24:02 +0200
X-Gm-Features: AUfX_mwOnz4nX8QwFMh9uVICUp3MpR5JXgvZRYkUxZ2EE4QntTG2QxbgMWZL1s8
Message-ID: <CAPsqS2RRUyG1vz5Nm7990yd0hcKR5E-SWhbt0ishaVYvCqQftw@mail.gmail.com>
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Jiaxing Hu <gahing@gahingwoo.com>, diederik@cknow-tech.com, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, 
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

Hi Igor,

On Sun, Aug 2, 2026 at 2:04=E2=80=AFPM Igor Paunovic <royalnet026@gmail.com=
> wrote:
>
> Hi Tomeu, hi Jiaxing,
>
> I need to correct the measurements in my first mail. The conclusions I
> drew from them do not survive better methodology, and since two of my
> questions to Tomeu were based on those conclusions, I would rather fix
> this now than have anyone reason from bad data.
>
> Short version: the numbers were real, but they measured my interrupt
> configuration, not the NPU.
>
>
> 1. What was wrong
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Each inference generates 41 interrupts on this driver (one per task,
> more on that below).  All of them were landing on CPU0, a Cortex-A55
> that was also entering its shallow idle state (exit latency 220 us)
> between interrupts.  So every inference paid a large, frequency-
> independent CPU-side cost, which compressed the differences between
> NPU frequencies and produced the inversion I reported.
>
> Three changes, none of them driver code:
>
>   - NPU IRQ affinity moved to an idle A76
>   - cpu-sleep (state1) disabled on that core
>   - performance cpufreq governors during measurement
>
> With that, the picture changes completely.  Even the fixed 200 MHz
> baseline moves from 68.5 to ~91 inf/s - a quarter of the stock
> performance was lost to configuration alone.  I should have caught
> this; the per-inference interrupt count was in my own telemetry.
>
>
> 2. Corrected numbers
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Same rig as before otherwise: MobileNetV1 through Teflon, one inference
> thread pinned to one A76, bit-exact sha256 oracle over intermediate
> tensors on every deep-check, zero tolerance, oracle passed in every run
> quoted here.  Kernel 7.0.0 + local devfreq for rocket.  Ambient
> controlled, die temperature logged per row (all rows 42.5-45.3 degC).
> Every row is an ~80 s run; key points were replicated 2-5x across the
> day, spread within 1%.
>
>   inf/s            800 mV    850 mV    950 mV
>   200 MHz           91.1      90.7      90.8
>   300 MHz          161.7     170.9     185.1
>   400 MHz          187.3     196.2     211.4
>   500 MHz          208.8     216.7     226.6
>   600 MHz          221.1     227.9     236.5
>   700 MHz          227.4     233.0     240.7
>   800 MHz             -      232.2     241.9
>   900 MHz             -      233.8     241.4
>   1000 MHz            -      235.0     242.8
>
> (The 800 mV column stops at 700 because my local safeguard refuses
> higher OPPs on that rail.  The identical 200 MHz row across all three
> rails is the negative control - at 200 MHz voltage headroom is
> irrelevant, and the rig reproduces to 0.5%.)
>
> Corrections to my three claims, in order:
>
> a) "600 MHz is the optimum" - withdrawn.  The curve is monotonic to
>    ~700 MHz and flat above it.  There is no inversion; the inversion
>    was the A55 paying 41 wakeups per inference.
>
> b) "Voltage does not help" - withdrawn.  At the same nominal clock,
>    raising the rail 800 -> 950 mV buys +14% at 300 MHz and +7% at
>    600 MHz.  Consistent with the clock being PVT-controlled: more
>    voltage lets the PLL deliver a higher actual clock for the same
>    nominal request.  (This also means the flat region above 700 is
>    partly voltage-limited, not purely memory-limited: the per-chunk
>    floor is ~72.5 us at 850 mV but ~69 us at 950 mV.)
>
> c) "Should the OPP table stop at 600?" - wrong question, please ignore
>    it.  The plateau is this board's memory (LPDDR4X-2112) plus the
>    voltage effect above; boards with LPDDR5 should keep scaling
>    further.  The table should carry the full vendor range and let each
>    board cap via max_freq / thermal policy.
>
> One methodological note that may be useful to anyone benchmarking this
> hardware: the largest error sources I quantified today were, in order -
> interrupt placement (+32% at stock clock), a busy desktop session
> sharing the SoC (up to 18%), die temperature (~0.5%/degC via the PVT
> loop), and an open browser (~1%).  The silicon was the most
> reproducible part of the whole setup.
>
>
> 3. Jiaxing's points
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> > Those lines list CLK_NPU_DSU0, but the clock the driver holds as
> > "npu" [...] is <&scmi_clk SCMI_CLK_NPU>. [...] Worth a look at
> > clk_summary first.
>
> You are right about the identity, and thanks for pushing me to check
> it properly.  Decoded from the live DT: "npu" is SCMI_CLK_NPU (SCMI
> clock id 6); aclk/hclk/pclk come from the CRU.  The domains list
> CLK_NPU_DSU0, which devfreq never touches.
>
> I then took clk_summary snapshots idle, mid-benchmark at nominal 600,
> and mid-benchmark at nominal 1000:
>
>                     idle      during 600   during 1000
>   clk_npu_dsu0      250 MHz   250 MHz      250 MHz
>   aclk_npu0/1/2     250       250          250
>   hclk_npu0/1/2     198       198          198
>   pclk_npu_root     100       100          100
>
> So the handshake-side clocks never move - this driver already does
> exactly what your vendor sample shows (compute clock scaled, dsu/aclk/
> hclk parked at boot rates).  And yet the domain transition still fails
> whenever the SCMI compute clock is raised, reproducibly.  So the
> constraint tracks the compute clock itself, not the DSU clock, and
> "pick a clock outside the domain lists" unfortunately does not exist
> here: the only rate anyone scales is already outside them.
>
> Whether the mechanism is a PLL inside the domain remains my hypothesis
> - the TRM's NPU chapter is silent on PVTPLL and I still have not risked
> reading its registers.  The constraint itself is empirical.
>
> A caveat worth passing on: clk_summary reports SCMI_CLK_NPU at
> 200 MHz even mid-benchmark at nominal 1000 - the CCF cache is stale for
> firmware clocks, so clk_summary genuinely cannot answer this question.
> I verified the actual rate two ways: clk_get_rate() (which round-trips
> to firmware), and the per-chunk NPU time scaling 236 -> 69 us across
> the sweep.
>
> > your plateau looks memory bound [...] Maybe worth one compute dense
> > model before cutting the table there.
>
> Fair, and the answer is a few lines up: I am no longer proposing to cut
> the table anywhere.  I did run the compute-dense model you asked for:
> InceptionV1 (quant), same rig, 850 mV.  One caveat first: on this stack
> Teflon leaves ~79% of an Inception inference on the CPU (many more ops
> fall back than for MobileNet), so total throughput barely moves with
> clock and the honest metric is the NPU-side time per inference, which
> the harness separates out:
>
>   nominal     NPU-side per inference    total
>   300 MHz     7.2 ms                    43.7 inf/s
>   700 MHz     4.16 ms                   50.5 inf/s
>   1000 MHz    4.17 ms                   50.2 inf/s
>
> It scales 300 -> 700 and then flattens at exactly the same knee as
> MobileNetV1 (whose NPU-side time goes 4.54 -> 3.00 -> 2.97 ms over the
> same points).  So on this board the plateau is the platform, not
> MobileNetV1's memory profile - consistent with the LPDDR4X explanation,
> and it does not change the conclusion: full table, per-board cap.
> Boards with faster memory may well keep scaling; mine cannot test that.
>
> (Two incidental data points from the same runs: Inception jobs get
> scheduled across two NPU cores here - 33+27 interrupts per inference
> against MobileNet's 41 on one core - and the bit-exact oracle passed at
> every frequency for this model too.)
>
> On your RK3576 SCMI experiment (zero jobs, 83 timeouts): one cross-data
> point - on RK3588 the SCMI/PVTPLL path is what we use successfully for
> the GPU (Mali-G610 at 1 GHz via SCMI, measured and stable), and the NPU
> compute clock here is SCMI-routed and scales fine while the domain is
> up.  So the SCMI plumbing itself can work on this family; whatever
> failed on RK3576 may be specific to that port rather than the approach.
>
>
> 4. Thermal, update
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The missing NPU cooling chain from my first mail is now running here
> end-to-end: #cooling-cells on the NPU node, a passive trip at 85 degC
> with a cooling map, and devfreq_cooling registered by the driver - the
> kernel bound them together without manual intervention.  So the two DT
> patches are ready whenever the driver work lands; they need nothing
> beyond what devfreq already provides.
>
>
> 5. Where this leaves the questions to Tomeu
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The two RFC questions that survive unchanged: whether you want DVFS
> for rocket upstream at all,

Sure!

> and whether the genpd-notifier shape is
> acceptable.

To be honest, I don't feel qualified to answer that. If you don't get
an answer here or know whom to ask (you could check git blame), you
can just send your best try to elicit a discussion.

> The OPP question is answered above (full table, per-board
> cap).

Right.

>  The code cleanup questions stand as written.

Regarding code organization, please check how devfreq is used in other
DRM drivers for ideas.

Thanks,

Tomeu

> Sorry for the noise, and thanks to Jiaxing for the push to verify the
> clock tree - the numbers are better for it.
>
> Igor
