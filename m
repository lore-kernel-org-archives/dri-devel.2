Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E72BC55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 13:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318BD10E08E;
	Sat,  1 Aug 2026 13:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="biJ+LPQX";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66CFD10E08E
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 13:17:21 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4706f016316so158232f8f.3
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785590240; x=1786195040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1s2LQ7bIi+O1AtHBDgwoi4wpOF24m44GqVYWMvJpv0E=;
 b=biJ+LPQX/MHSnglEo7hzuDXSheStHEFS1gvu3CbKwrWvUdKUEKxCzr6knAURj/ObeA
 VBTPcMfB2+2CijGDkLF+V7fBWfEOc7HEjloSiHiCwqhLk5Kobl5Z1jp0PWZAvPMaWkVz
 wDRBHMhnUl/lLMN38liMr//xrtQDJ1xZpbKrVdZGeB6D1GQlFuvaM60sUKuk9l7K9aUX
 cIq5w8KB6GlTj3AFOf0/4VYCbNsaURo3Wp7CvQdJYlcElvSVDa7EeDT/jnNhh41iDxL1
 RHRreB+E+6jUDNkOGUEOcHtS1pgrhhp/wP5Qpi0Ihnk5RX+fsWXFwewPm2Wc+npeff4P
 +WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785590240; x=1786195040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1s2LQ7bIi+O1AtHBDgwoi4wpOF24m44GqVYWMvJpv0E=;
 b=nPJVB5Ce/zFsaHx/9+i5tc4UK8n0uZPL+vzlGwFiBPwD02dzhxNAZ1MzPSkJM0WBWg
 sCysGPc6DAqf2peG05Xc/l3m38MwtOB4ZAdtCMVlQU61378pOcBfpq5vs7jjPIn4qJqS
 1AE5DZGCcnZJc4ardrsA4/jXx/KAmlDh/CNX2VoZ4sRLcreeUf1rWGupYUbZw8Nfv1/k
 awK97l7FxINuFH0kbkaDDTuIslM6MaXw3aM8jSNEqzzM/a4K9HExnJ7RV4x4U6w6Tuko
 u0l3OOvXSo5e6alPPYm9V825dWaDTOHp2jTrMzS6jEXF4NolE5M+B1gIQK5xO2PI1bfh
 QmPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RquLvt+9DkLUjIWuE+PNqFFuiKEmvpHxqY32OQhXMcj+Og/NNI532sxaMC7cYtiZ1zJR+c65FvFR1c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzadfMxE8A9s0akhgUz/adVkcLSWZv94lhJX1UQlHoYnA/monMF
 R5I5lHiR1cgwelzaaNzj8PaIaeKY044XUlgS13apj1rrTZvOEgidpGzT
X-Gm-Gg: AR+sD13wSjOTxc1q8Co8iKqvb0T6mUEDu66jZUDb9X8ag3mIiD1pRkRh8eXVTtpj+I7
 1TSK0a2gxw3vE9hGil6ml5naJN/F21BVWP2A6l4V/FBqVDQmi0rm4TMi8qkltKEzUBSu5Jzq9fZ
 PSrjAXzYutRGqm2WiwntVCJ4QeIn/9A9nyQx+tLjjw7DzQsy0rd1obt7OWsbB7RWmG4+0gHcMa9
 szCGpTTBY/1RV63XMT91ynsXzzAQE2GeGrwj/CLl27a0nVXzYoltgoGHWCwunu8Rt1P1+wgWQdt
 mJkOBhpz7Zm89MbIfI3N8ByX++coosgBbJiLf9iGU4b6YxKDCZk+PmOS/7AIPoAr57pXhydI+7x
 ixUxnWnHZfyPGv/RDBwyEHa/KsZxfLcD7BfilHX+n2BEsJLmbW72Q87niBfOjg2hTgau+0ENhg2
 HmfTgonP3664IEZyo5svuyC6fVhdvBH0lIXwWscDFeVsY2VTQppuWhmYGbxT8UJo4ObKL1ubOpB
 64VpIbZXeEfzWF0KSfjZKXeEyV0LjAkj61REsrxfZMOn/XEdiA1GP7YlE76sv1277yb
X-Received: by 2002:a05:600c:4686:b0:493:ec89:db4a with SMTP id
 5b1f17b1804b1-4980c6066b5mr28150325e9.0.1785590239488; 
 Sat, 01 Aug 2026 06:17:19 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B870700E64B9F218DE76E46.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:700:e64b:9f21:8de7:6e46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b2a61asm40341835e9.0.2026.08.01.06.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 06:17:18 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Igor Paunovic <royalnet026@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
Subject: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint,
 and some numbers
Date: Sat,  1 Aug 2026 15:16:56 +0200
Message-ID: <20260801131656.58450-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tomeu,

Since you asked for fixes to be sent upfront I have kept poking at the
RK3588 NPU, and I ended up implementing devfreq for rocket locally.  It
works, but on the way there I hit a crash class that I could not find
documented anywhere, and I also measured something about the vendor OPP
table that I did not expect.  Both seem worth sharing before I clean any
of it up for posting, so I would rather ask first than send a series you
may not want in this shape.

Cc'ing Jiaxing since he is working on the clocks and on RK3576.


1. The hardware constraint
==========================

An NPU power domain cannot be switched on or off while the NPU compute
clock is above its DT assigned-clock-rate of 200 MHz.

Changing the rate while a domain is already on is fine - I have taken it
to 1 GHz and back many times without a single error.  It is the domain
transition that breaks.

What happens when a domain is moved at a high rate:

  rockchip-pm-domain ...: failed to get ack on domain 'nputop', val=0xa9ffe
  rocket fdab0000.npu: devfreq: cannot power up for rate change: -110

The domain is then wedged: genpd still believes it is on, but the first
MMIO into it raises an asynchronous SError and the box panics.  Captured
over the serial console:

  Kernel panic - not syncing: Asynchronous SError Interrupt
  Comm: rmmod
   _regmap_read
   regmap_read
   rockchip_pd_power
   rockchip_pd_power_off
   _genpd_power_off        <- rollback
   genpd_power_off
   genpd_power_on          <- failed
   genpd_runtime_resume
   device_release_driver

This is not specific to nputop.  I have the same message for 'npu2'
(val=0xa9fff), which matches the DT: all three NPU domains list the NPU
clock among their handshake clocks - rk3588-base.dtsi lines 864, 877 and
885, for RK3588_PD_NPUTOP, RK3588_PD_NPU1 and RK3588_PD_NPU2.

So the clock the domains need for their idle/ack handshake is the same
clock we would be scaling.  My best explanation is that the PLL that
produces it lives inside the domain, so once the domain drops, the clock
state goes with it and the handshake can never complete.  I cannot
confirm that part - reading the PVTPLL registers is documented as
hanging the machine, so I have not tried.  The behaviour itself is
reproducible and cost me four hard hangs before I understood it.

I mention it because it is a trap for anyone adding DVFS here, including
the RK3576 work, and because it is invisible until the first time you
let the NPU idle at a raised clock.


2. What ended up working
========================

Runtime PM callbacks are not enough.  The domains are powered on by the
driver core before probe, powered off from a workqueue after detach, and
system sleep bypasses runtime PM references entirely - so the driver
never sees all the transitions.

What does work is hooking the transitions themselves:
dev_pm_genpd_add_notifier() on all three cores, and on GENPD_NOTIFY_PRE_ON
and GENPD_NOTIFY_PRE_OFF force the clock back to the DT rate, vetoing the
transition with notifier_from_errno() if that fails.  Every path -
runtime PM, system sleep, attach at probe, detach after unbind - goes
through _genpd_power_on()/_genpd_power_off(), so nothing can slip past.
If a transition does happen, the boost cancels itself and says so,
rather than leaving the driver claiming a rate the hardware is not
running.

This has now survived everything that used to kill the box, including
repeated sleep/wake cycles at a raised clock and rmmod while boosted.


3. The numbers, which are the surprising part
=============================================

Measured with MobileNetV1 through Teflon, one inference thread pinned to
one A76, and a bit-exact oracle: sha256 over intermediate tensors on
every iteration, zero tolerance.  The 600, 900 and 1000 MHz rows are
30-minute runs of 275k-280k inferences each and the oracle passed
bit-exact in all three, so none of this is instability; the 200 MHz row
is a shorter control from the same session.

  nominal    supply    throughput
  200 MHz    800 mV     68.5 inf/s      (the current fixed rate)
  600 MHz    800 mV    155.4 inf/s
  900 MHz    850 mV    152.4 inf/s
  1000 MHz   850 mV    152.9 inf/s

600 MHz is the optimum.  900 and 1000 are indistinguishable from each
other and both land about 4% below 600, on a quieter and cooler machine.
The vendor OPP table decoded from the downstream DTB asks for 700 mV up
to 700 MHz, 750 mV at 800, 800 mV at 900 and 850 mV at 1000, and I ran
the top of that range at the voltage it asks for - it does not help.

Backing out an effective clock from the per-chunk time, nominal 600
appears to deliver more than nominal 900 or 1000 do.  I would not lean
on that decode, but the throughput ordering does not depend on it.

Thermals were never a factor: the highest I saw all day was 50.8 degC,
against a critical trip at 115.  This is one board and one model, and
MobileNetV1 is memory-heavy, so a compute-dense network may well behave
differently - but for this workload the top half of the vendor table
buys nothing.

If that holds up elsewhere, an OPP table for rocket probably should not
simply mirror the vendor one.


4. Thermal, separately
======================

While looking at this I noticed npu-thermal has only a critical trip at
115 degC - no passive trip, no cooling map, polling-delay-passive is 0 -
while gpu-thermal, a few lines above in the same file and on the same
tsadc, has both.  That was harmless while the NPU was pinned at 200 MHz
because it could not be slowed down anyway; with DVFS it stops being
harmless.

I have two small patches for that (a #cooling-cells binding update and
the thermal zone itself), but they only make sense once something
registers a cooling device, so they would belong with the driver work
rather than on their own.


5. What I am asking
===================

- Is DVFS for rocket something you want upstream at all, or is it better
  left alone for now?

- Does the genpd-notifier approach look right to you, or is there a
  cleaner hook I have missed?

- Given the measurements, would you want the OPP table to stop at
  600 MHz rather than follow the vendor range?

- If you do want a series, I will need to clean the code up first - it
  still keeps its state file-static rather than in rocket_device, and it
  bypasses the OPP layer for the rate change because our own direct
  writes leave the OPP cache stale.  Both are fixable; I would rather
  know the shape you want before rewriting.

Happy to send the current code as-is off-list if that is easier to
comment on than prose.

Thanks,
Igor
