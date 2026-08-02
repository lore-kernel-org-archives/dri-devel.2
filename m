Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A15C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 12:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B060010E406;
	Sun,  2 Aug 2026 12:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K2J6lZdT";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC6D10E406
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 12:04:34 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-66077ebd1d3so282510d50.3
 for <dri-devel@lists.freedesktop.org>; Sun, 02 Aug 2026 05:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785672273; cv=none;
 d=google.com; s=arc-20260327;
 b=Wux7xYZDkUghZwWS9aw40yevSaVULYBqcOPSSP9JDpGzYuURzMwSc9eXq3OvgFD1Tc
 D7zqaV7L2GjF8dg3wLw4T1CVTYw/bGvpEY9nbxyI/8Zylw+c8ymc9qzL7EXSLusXiuLN
 KEqiYEuAqztJcjgNtRKbmWaOR3n6q9m4fS9OJBU2MH5zcZby436zExdj+A9kVrgFdGic
 vLvfnHbD5clHDE9nSxvdcupNg6nWg403RUV/Cf6lahnj4wlrQCl6ONGVnngKMoIGx1kt
 yIOekDAef213MjouyLJ8BSsSztybiE3EqZgNzuhzITW4PPEbLy7a4DbSTi8pJcHaDH4n
 iPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ysVyBPkeqEskGPyKVTjEGSwLzPPY5AWDGGOshgfdzio=;
 fh=J9Ds+4Yq0az9nYnMmXKla/F+Xx72wJ/8RL4aYLGHp0Y=;
 b=G85JM2dibXYHMHhp4mjeuJ64+6vR0j14eor+kAOj5xUg8IFm76KNVxV0lb4+HGgnxI
 bClVr+9yCFf//exRoLddjpPk7Pow5pp1IuFwbunmTzcd8aRRl6nIa5JcjE5py79uKoaf
 g9dOsPxUhJqX1+di+nwe7D0jz2RnzHAnB7CUvBlYgOhBtv2Y/vrmSNCHkg269Vrahtec
 cCxOtEwcg2DiZ0qBD3cTASFP5JAUOz4JT6IH3ya7bMFCA6Pac8EmwaZzr7ui0pF+r+30
 +YVRLextpvFqSP7RFmQ18k5Y4nklHJSaEPbEFVIap88aClJ4F6MpBQyWp6AiY510Qr+E
 O/dg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785672273; x=1786277073; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ysVyBPkeqEskGPyKVTjEGSwLzPPY5AWDGGOshgfdzio=;
 b=K2J6lZdTfBzH1KkCGy1GWudw1T4ILeoiUeaJYjkm4dPBFwKyQGRXYw4KngfFKcBfe2
 /rv9RoQsaTrPNn6rtVtdxFoMLQlndJIIzgGohO4vDTImw+ccM0lt7DTsRuY80C7o2d4A
 hr1QIM70D8hgGEOefVY5/Vrv/vYHwMjwHstNIBIW9FjCADOnogzczNcopazFg+j+q78A
 1kYJEYIl67Idhb2bpW8vIR7W60axoh40/8f6aZUhgqlw3O3PE80c0UYzRzyWRaO2v1zR
 t/x8TlHcdkgE9ZTdl+T+mT2BpPF1mHF2/WcJ990v3edgJ0Iq/AAo+Hpe989Kv/CTXWvg
 H4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785672273; x=1786277073;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ysVyBPkeqEskGPyKVTjEGSwLzPPY5AWDGGOshgfdzio=;
 b=MK4RtJdY9IsQHRAUU1RV+wKWS+B/GABgL+MbLgNUax9VBCdWzEjUgI6fKrr9UUs03Y
 XEs4XE7nz4CPo64CIjSGIKrORzzuTIAe1FvTcfHn9sPwHVoIIBJw5Ex3/wo2zRzEPJlm
 wTP+0d8AezpXdt+aMHiOyssNuvTFwu9FyEkyU+nZhY30OV+tgXONPgTr9aFba5b8JNJN
 h6oFsHFavun7dKhRMis9ORXvHlGDg05fqZCrx4yD7xUi2Fez5cbtG/4GgiRmdyVTmX9I
 uQFYwqkYmmry8/pBtRIUg7OV18hHd1JUUkvdY9lDou3J6GRYYzRzLD/JuRHEQNq/JBbx
 Mxng==
X-Forwarded-Encrypted: i=1;
 AHgh+RpEzhNlhbo6jGfKVVqRHkzMmlOabjC1mldHyJWTcyKPGfk4uMUTEIz+rTLdKlJ/TydOSum+tMXJjfA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWD43Fx5VEJJwEnFWZuzvgrhZ+HXO+kRV2R3N7mSkdNDHS/pq5
 XIWEZ5Q03uxXAI0hnIX99Xm6T074z9Os8THA318TD/jKAH9DYEIeBnrSvtcNHlXkV3MxLXJWJ6L
 R9dxbiMKV0CE6FXQZCFao7rg2hMtON1o=
X-Gm-Gg: AR+sD1243cpnDGLpiw5eN0RUOBbCnQaQ+vu3p4zf+eh60Hgy/BtIVIg5GP3TwUWX2QQ
 1bAevnjx3COXjsrE9BzvrKbxfW16Q8m5kuk+OURLJrJHj924UX3rykYmOVg5Qvs/VreHrJjCIAU
 qJ7kBn/AFBAocNWWGwzOWVYJukKyyCmBd6aLorpU8Q0Evv9VQ4tsMk2SrYgoYPcC3W6lxo4hJ1d
 R8n2l3oUjKNCoFGGpFNqVGFE4IxoDEKeY7Qj5w+gk3mF95raehAybQ4ipm3AND1MnCjm01W6rLX
 FgE+HuzLyldCcaW6Ky/z1TtAtKHnP5yi9z229O8hYqS+bq+EuYC17kk3XlUP0WykCcdF/vUd+kZ
 lyQ==
X-Received: by 2002:a05:690c:19:b0:80f:3e90:f021 with SMTP id
 00721157ae682-81fd4c1e165mr85262697b3.4.1785672272829; Sun, 02 Aug 2026
 05:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <20260801193237.2539957-1-gahing@gahingwoo.com>
In-Reply-To: <20260801193237.2539957-1-gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Sun, 2 Aug 2026 14:04:21 +0200
X-Gm-Features: AUfX_myQSl23x_z5DDTMRMYkim7ewNsbSwXYShTn0yIY_ENHwr8L-geTd22bE9M
Message-ID: <CAEWPSH7upAFGOxg5Eep9nXA16L7PWtXJtk1+5bsnJYNjxm7joQ@mail.gmail.com>
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, diederik@cknow-tech.com, heiko@sntech.de, 
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Tomeu, hi Jiaxing,

I need to correct the measurements in my first mail. The conclusions I
drew from them do not survive better methodology, and since two of my
questions to Tomeu were based on those conclusions, I would rather fix
this now than have anyone reason from bad data.

Short version: the numbers were real, but they measured my interrupt
configuration, not the NPU.


1. What was wrong
=================

Each inference generates 41 interrupts on this driver (one per task,
more on that below).  All of them were landing on CPU0, a Cortex-A55
that was also entering its shallow idle state (exit latency 220 us)
between interrupts.  So every inference paid a large, frequency-
independent CPU-side cost, which compressed the differences between
NPU frequencies and produced the inversion I reported.

Three changes, none of them driver code:

  - NPU IRQ affinity moved to an idle A76
  - cpu-sleep (state1) disabled on that core
  - performance cpufreq governors during measurement

With that, the picture changes completely.  Even the fixed 200 MHz
baseline moves from 68.5 to ~91 inf/s - a quarter of the stock
performance was lost to configuration alone.  I should have caught
this; the per-inference interrupt count was in my own telemetry.


2. Corrected numbers
====================

Same rig as before otherwise: MobileNetV1 through Teflon, one inference
thread pinned to one A76, bit-exact sha256 oracle over intermediate
tensors on every deep-check, zero tolerance, oracle passed in every run
quoted here.  Kernel 7.0.0 + local devfreq for rocket.  Ambient
controlled, die temperature logged per row (all rows 42.5-45.3 degC).
Every row is an ~80 s run; key points were replicated 2-5x across the
day, spread within 1%.

  inf/s            800 mV    850 mV    950 mV
  200 MHz           91.1      90.7      90.8
  300 MHz          161.7     170.9     185.1
  400 MHz          187.3     196.2     211.4
  500 MHz          208.8     216.7     226.6
  600 MHz          221.1     227.9     236.5
  700 MHz          227.4     233.0     240.7
  800 MHz             -      232.2     241.9
  900 MHz             -      233.8     241.4
  1000 MHz            -      235.0     242.8

(The 800 mV column stops at 700 because my local safeguard refuses
higher OPPs on that rail.  The identical 200 MHz row across all three
rails is the negative control - at 200 MHz voltage headroom is
irrelevant, and the rig reproduces to 0.5%.)

Corrections to my three claims, in order:

a) "600 MHz is the optimum" - withdrawn.  The curve is monotonic to
   ~700 MHz and flat above it.  There is no inversion; the inversion
   was the A55 paying 41 wakeups per inference.

b) "Voltage does not help" - withdrawn.  At the same nominal clock,
   raising the rail 800 -> 950 mV buys +14% at 300 MHz and +7% at
   600 MHz.  Consistent with the clock being PVT-controlled: more
   voltage lets the PLL deliver a higher actual clock for the same
   nominal request.  (This also means the flat region above 700 is
   partly voltage-limited, not purely memory-limited: the per-chunk
   floor is ~72.5 us at 850 mV but ~69 us at 950 mV.)

c) "Should the OPP table stop at 600?" - wrong question, please ignore
   it.  The plateau is this board's memory (LPDDR4X-2112) plus the
   voltage effect above; boards with LPDDR5 should keep scaling
   further.  The table should carry the full vendor range and let each
   board cap via max_freq / thermal policy.

One methodological note that may be useful to anyone benchmarking this
hardware: the largest error sources I quantified today were, in order -
interrupt placement (+32% at stock clock), a busy desktop session
sharing the SoC (up to 18%), die temperature (~0.5%/degC via the PVT
loop), and an open browser (~1%).  The silicon was the most
reproducible part of the whole setup.


3. Jiaxing's points
===================

> Those lines list CLK_NPU_DSU0, but the clock the driver holds as
> "npu" [...] is <&scmi_clk SCMI_CLK_NPU>. [...] Worth a look at
> clk_summary first.

You are right about the identity, and thanks for pushing me to check
it properly.  Decoded from the live DT: "npu" is SCMI_CLK_NPU (SCMI
clock id 6); aclk/hclk/pclk come from the CRU.  The domains list
CLK_NPU_DSU0, which devfreq never touches.

I then took clk_summary snapshots idle, mid-benchmark at nominal 600,
and mid-benchmark at nominal 1000:

                    idle      during 600   during 1000
  clk_npu_dsu0      250 MHz   250 MHz      250 MHz
  aclk_npu0/1/2     250       250          250
  hclk_npu0/1/2     198       198          198
  pclk_npu_root     100       100          100

So the handshake-side clocks never move - this driver already does
exactly what your vendor sample shows (compute clock scaled, dsu/aclk/
hclk parked at boot rates).  And yet the domain transition still fails
whenever the SCMI compute clock is raised, reproducibly.  So the
constraint tracks the compute clock itself, not the DSU clock, and
"pick a clock outside the domain lists" unfortunately does not exist
here: the only rate anyone scales is already outside them.

Whether the mechanism is a PLL inside the domain remains my hypothesis
- the TRM's NPU chapter is silent on PVTPLL and I still have not risked
reading its registers.  The constraint itself is empirical.

A caveat worth passing on: clk_summary reports SCMI_CLK_NPU at
200 MHz even mid-benchmark at nominal 1000 - the CCF cache is stale for
firmware clocks, so clk_summary genuinely cannot answer this question.
I verified the actual rate two ways: clk_get_rate() (which round-trips
to firmware), and the per-chunk NPU time scaling 236 -> 69 us across
the sweep.

> your plateau looks memory bound [...] Maybe worth one compute dense
> model before cutting the table there.

Fair, and the answer is a few lines up: I am no longer proposing to cut
the table anywhere.  I did run the compute-dense model you asked for:
InceptionV1 (quant), same rig, 850 mV.  One caveat first: on this stack
Teflon leaves ~79% of an Inception inference on the CPU (many more ops
fall back than for MobileNet), so total throughput barely moves with
clock and the honest metric is the NPU-side time per inference, which
the harness separates out:

  nominal     NPU-side per inference    total
  300 MHz     7.2 ms                    43.7 inf/s
  700 MHz     4.16 ms                   50.5 inf/s
  1000 MHz    4.17 ms                   50.2 inf/s

It scales 300 -> 700 and then flattens at exactly the same knee as
MobileNetV1 (whose NPU-side time goes 4.54 -> 3.00 -> 2.97 ms over the
same points).  So on this board the plateau is the platform, not
MobileNetV1's memory profile - consistent with the LPDDR4X explanation,
and it does not change the conclusion: full table, per-board cap.
Boards with faster memory may well keep scaling; mine cannot test that.

(Two incidental data points from the same runs: Inception jobs get
scheduled across two NPU cores here - 33+27 interrupts per inference
against MobileNet's 41 on one core - and the bit-exact oracle passed at
every frequency for this model too.)

On your RK3576 SCMI experiment (zero jobs, 83 timeouts): one cross-data
point - on RK3588 the SCMI/PVTPLL path is what we use successfully for
the GPU (Mali-G610 at 1 GHz via SCMI, measured and stable), and the NPU
compute clock here is SCMI-routed and scales fine while the domain is
up.  So the SCMI plumbing itself can work on this family; whatever
failed on RK3576 may be specific to that port rather than the approach.


4. Thermal, update
==================

The missing NPU cooling chain from my first mail is now running here
end-to-end: #cooling-cells on the NPU node, a passive trip at 85 degC
with a cooling map, and devfreq_cooling registered by the driver - the
kernel bound them together without manual intervention.  So the two DT
patches are ready whenever the driver work lands; they need nothing
beyond what devfreq already provides.


5. Where this leaves the questions to Tomeu
===========================================

The two RFC questions that survive unchanged: whether you want DVFS
for rocket upstream at all, and whether the genpd-notifier shape is
acceptable.  The OPP question is answered above (full table, per-board
cap).  The code cleanup questions stand as written.

Sorry for the noise, and thanks to Jiaxing for the push to verify the
clock tree - the numbers are better for it.

Igor
