Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C5CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 18:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46BE10F30E;
	Thu,  7 May 2026 18:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FVNZ2V1l";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0174A10F30E
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778177021;
 bh=wrAzBvN495bkOFIYpdDRCnF+YrgQs4GzP4K6gY0sbCs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FVNZ2V1ljY17TcqsYRfPWcEBQrta29nFZ3RXvLSJOEmF29w0NjZ+OPh0wTpu3hKLj
 sbw51M5WTlBuW0nKCNCThTdufmmF7bLS9tLoYVi4ci+1xnU7wzCj43cC2W7SPBtbu7
 5AYB7/1xg03gwukRgeEX6sBWk1CeTABv2G1TRWESZvCl8kijgqB/WfAem/zZaSaSCd
 XsTsKhkICnHHamrzikqtCCPfrqST/boWNczs9trdpwOI4mRC+IRtQ7Tlv3QQhgpvMM
 o2s6fi8wORceosUTI6ez87f3iLqy4UvKyeMXbV+IsE4Ag+jQIzkqdWl3lvrvm8G+uY
 w+jJfRAJaMq7g==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 681C617E125C;
 Thu,  7 May 2026 20:03:41 +0200 (CEST)
Message-ID: <61e86f45-cc62-433b-b929-2df66ab0f1ff@collabora.com>
Date: Thu, 7 May 2026 21:03:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong
 tmds_char_rate, breaking audio on strict HDMI 2.1 sinks
To: Simon Wright <Simon@symple.nz>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
 <38b2e226-c8f0-44b4-bf71-66caa0b27d43@collabora.com>
 <ME3P282MB2196C1D097CB4A61D2376FAFA83C2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ME3P282MB2196C1D097CB4A61D2376FAFA83C2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 5/7/26 1:39 PM, Simon Wright wrote:
> Hi Cristian,
> 
> Thanks for the pointer. Quick test results before writing back.
> 
> Test rig: NanoPi R76S (RK3576) on Armbian-edge mainline 7.0.1, LG G3
> OLED sink (the same strict HDMI 2.1 sink that surfaced the original
> audio bug). Stack: hdptx-clk-fixes v1 + frl-enable-gpios v2 patch 3/13
> + SCDC v5 patch 5 (hand-ported to v7.0; `.detect` kept instead of
> `.detect_ctx` so the OOT module loads against unpatched vmlinux).
> 
> Tested-by for hdptx-clk-fixes v1: dmesg shows phy_configure /
> phy_power_on / atomic_enable consistent at rate=185625000 bpc=10 with
> no recalc drift -- exactly what the cover letter promises. Happy to
> add the trailer to the v1 cover and any individual patch.

Please provide the trailer and maybe also a kind reminder for the maintainers to
get the series applied.. :-)

> 
> That said, audio still mutes at high-bpc / high-TMDS rates on the
> LG G3 even with your series applied:
> 
>     1080p60  8-bit (148.5  MHz): audio plays  -- already worked
>     1080p60 10-bit (185.625 MHz): muted        -- original bug regime
>     4K@60   8-bit (594.0  MHz):  muted        -- production cast path
> 
> The "muted" rates are precisely those not in `common_tmds_cts_table[]`.
> For those, `dw_hdmi_qp_find_cts()` returns 0, the override path is
> skipped, and the QP IP falls back to its auto-CTS measurement -- which
> the LG G3 cross-check rejects. The BSP-derived dw-hdmi-qp.c
> (develop-6.6) carries an in-source comment attributing this to the
> auto-circuit measuring at half the actual TMDS rate; I haven't read
> that register out myself to confirm the specific value, so I can only
> report that empirically the override path with explicit CTS works on
> the LG G3 and the bare auto path doesn't.
> 
> The fix is to compute CTS from N when the table misses, and feed it
> through the standard override path. Six lines + comment in
> `dw_hdmi_qp_set_sample_rate()`, between find_cts() and set_cts_n():
> 
>     /*
>      * When no CTS table entry exists for the given TMDS rate, compute
>      * CTS from N rather than relying on the IP's auto-measure path,
>      * which mis-measures on this controller at high TMDS rates and
>      * produces incorrect ACR timing on strict HDMI 2.1 sinks.
>      * Computed CTS = (TMDS * N) / (128 * Fs) per HDMI spec.
>      */
>     if (!cts && n) {
>         u64 computed = (u64)tmds_char_rate * n;
>         do_div(computed, 128ULL * sample_rate);
>         cts = (unsigned int)computed;
>     }
> 
> With this on top of your series, all three regimes above play audio
> cleanly -- including the 1080p 10-bit case from my original bug
> report and the 4K@60 path on our production cast rig.
> 
> That makes my earlier rate-block patch
> (linux-rockchip 2026-May/070673) redundant -- I'm happy to withdraw
> it on its thread once you've decided where the CTS-from-N fix should
> land.

Nice catch, will try to reproduce this on my end. 

Regardless, the fix should be submitted as a separate patch, as it's not
(directly) related to any of the existing serieses posted on ML. 
I.e. you mentioned "... mis-measures on this controller at high TMDS rates", but
the 1080p60 10-bit (185.625 MHz) use case falls under HDMI 1.4, hence the
problem doesn't seem to be limited to HDMI 2.x.

> 
> Two questions:
> 
> 1. Where would you like the CTS-from-N fix? Its own small thread, 

Yep, dedicated submission, per the above.

a
>    trailer on hdptx-clk-fixes, or folded into the SCDC series --
>    whichever fits your workflow.
> 
> 2. The kernel 7.0 announcement flagged controller-side FRL as "not
>    yet landed". Is that still on Collabora's roadmap

Yes, I'm currently preparing a new revision of the HDMI 2.0 patchset, then I
will focus on the HDMI 2.1 FRL support. The latest version of these patches is
already available in our rockchip-devel branch, which contains all the
necessary dependencies:

 https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rockchip-devel?ref_type=heads

> , or open for me
>    to send a develop-6.6-derived prototype as RFC once I've ported it
>    to mainline? Happy to wait if you have a series in flight.
> 
> Reproducer for the audio fix is the stack above plus a small libdrm
> helper to hold the mode against fbcon (modetest releases DRM master
> on exit). I can share the helper if useful.

Yes, please detail the reproducer steps.  So far, I've only tried playing audio
using speaker-test while switching the modes via modetest and it works as
expected.

> 
> Sige5/Sige7 DTS follow-ups to your frl-enable-gpios v2 series are in
> draft against the schematics; both boards are on order so I'll
> validate on my own hardware before sending. I'll start a separate
> thread on the v2 series for those rather than burying them here.

That series has been applied and is available in linux-next since next-20260506.
It also handles the rk3576-armsom-sige5 board, do you need anything else for
this particular one?

Regards,
Cristian
