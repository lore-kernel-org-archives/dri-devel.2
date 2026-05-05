Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAB6FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4667E10E48B;
	Tue,  5 May 2026 20:01:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Sus7epih";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E5C10E48B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778011268;
 bh=7HNtK8S648Lsic87QYT+lnKzx+eb5WKvVeeZQId2Nz0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Sus7epihBCq8myXQCu8LuoG487C0KWxTqCxtrmAVC+SbDSnyMC1qhApRG1dpaGFuU
 p6x7ycvA88uFhNGC88shLXxd4XZBaTwOBkvzG89MMoYIQVDOP16uWev4dpxj2ZLUz0
 oyBpuoiJwlLA3q4RKrp0q7eh+Dkmhw1tvDXPCvpWQmVXPpmdNjqpo+eE8rkRp3r522
 +5h1j1CguA1hRZqsD4N8Nx3Wbab3sVtHurEaSm4r8rskmruutnFNx99r5ctv6QUHUB
 2GLXDVUyui6v9xskb78tQaHAroeliBCe+JnEfOc50vxCQ19ceMx30XVD14H8iMu7Qi
 UdhwoTJhsw/OA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DFC8517E0595;
 Tue,  5 May 2026 22:01:07 +0200 (CEST)
Message-ID: <38b2e226-c8f0-44b4-bf71-66caa0b27d43@collabora.com>
Date: Tue, 5 May 2026 23:01:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/bridge: dw-hdmi-qp: seamless handoff sets wrong
 tmds_char_rate, breaking audio on strict HDMI 2.1 sinks
To: Simon Wright <Simon@symple.nz>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ME3P282MB21960D9D68BFF520316BDFCEA83E2@ME3P282MB2196.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
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

Hi Simon,

Thanks for the detailed bug report!

I submitted a while ago a patch series [1] providing clock fixes (among others)
to samsung-hdptx PHY driver, but sadly it hasn't been merged yet.

I think this should also address your audio issue, hence please give it a try
and let me know how it goes.

Regards,
Cristian

[1] https://lore.kernel.org/all/20260227-hdptx-clk-fixes-v1-0-f998f2762d0f@collabora.com/

On 5/5/26 11:18 AM, Simon Wright wrote:
> [Resent in plain text — first attempt was rejected by the list's HTML filter.]
> 
> Hi,
> 
> I have tracked down a bug in dw-hdmi-qp that silences audio on strict
> HDMI 2.1 sinks (tested: LG G3 OLED) when booting with HDMI seamless
> handoff from U-Boot. HDMI 2.0 sinks are unaffected. The root cause is
> a mismatch between the AVI InfoFrame colour depth and the ACR embedded
> CTS value.
> 
> Hardware tested:
>   Source:       ArmSoM Sige5 (Rockchip RK3576)
>                 Armbian-edge kernel 7.0.2 (Linux mainline v7.0 plus
>                 Armbian board-enable patches; not a BSP kernel)
>   Failing sink: LG G3 OLED 4K (HDMI 2.1, strict embedded-CTS mode)
>   Passing sink: Various HDMI 2.0 TVs (self-measuring CTS, unaffected)
> 
> The bug is structural and is expected to affect RK3588 under the same
> boot sequence.
> 
> 
> Root cause
> ----------
> 
> When the system boots with seamless handoff active, U-Boot has configured
> the PHY for 8-bit 1080p60 (TMDS = 148,500,000 Hz). The DRM connector
> state, negotiated from EDID, selects 10-bit deep colour (TMDS =
> 185,625,000 Hz). In dw_hdmi_qp_bridge_atomic_enable():
> 
>     hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
> 
> This stores 185,625,000. The PHY ops->init() is called but the PHY is
> already running at 148,500,000 from U-Boot and is not reconfigured.
> 
> The result is an inconsistency between what the sink is told over HDMI
> and what the wire actually carries:
> 
>   AVI InfoFrame:     declares 10-bit deep colour at the connector-state
>                      TMDS rate (185.625 MHz)
>   ACR embedded CTS:  driver uses hdmi->tmds_char_rate = 185,625,000 Hz
>                      to compute CTS via dw_hdmi_qp_set_sample_rate(),
>                      producing CTS = 185,625 (internally consistent
>                      with the AVI declaration)
>   Wire TMDS clock:   PHY untouched from U-Boot, still running at
>                      148,500,000 Hz (8-bit)
> 
> The dmesg signature (full pr_err output, lower in this report) confirms
> both AVI and ACR are computed from the nominal 185.625 MHz value:
> "tmds=185625000 ... cts=185625".
> 
> A standard HDMI 2.0 sink does not cross-check AVI against the wire TMDS
> in any way that matters for audio, so the mismatch is harmless. A strict
> HDMI 2.1 sink (LG G3) measures the wire TMDS and verifies it matches the
> AVI declaration; with declared 185.625 MHz vs measured 148.5 MHz, the
> check fails and audio is muted, permanently, until the next mode set.
> 
> The N/CTS values themselves are correct CEA-861 ratios. At a wire TMDS
> of 148.5 MHz with N=6144, CTS=148,500 yields f_audio = 48 kHz; at a
> wire TMDS of 185.625 MHz with N=6144, CTS=185,625 also yields f_audio
> = 48 kHz. The driver picks one TMDS, computes a self-consistent N/CTS
> pair, and embeds it. The bug is solely that the TMDS the driver picks
> (connector-state nominal) differs from the TMDS on the wire (PHY
> actual).
> 
> 
> Dmesg diagnostic signature
> --------------------------
> 
> Failing (seamless handoff, DRM selects 10-bit 1080p from EDID):
> 
>     dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \
>         tmds_candidate=185625000 is_hdmi=1
>     DW_HDMI_QP set_sample_rate: tmds=185625000 sr=48000 n=6144 cts=185625
>     [audio silent on LG G3]
> 
> Working (8-bit mode forced, see workaround below):
> 
>     dwhdmiqp-rockchip 27da0000.hdmi: atomic_enable: \
>         tmds_candidate=148500000 is_hdmi=1
>     DW_HDMI_QP set_sample_rate: tmds=148500000 sr=48000 n=6144 cts=148500
>     [audio working on LG G3]
> 
> The difference is entirely in which tmds_char_rate bridge_atomic_enable()
> receives. If the PHY and DRM state agree (both 148.5 MHz), audio works
> because what the AVI declares matches what the wire carries. If they
> disagree (DRM: 185.625 MHz, PHY: 148.5 MHz), the AVI declares 185.625
> but the wire carries 148.5, and any sink that cross-checks the wire
> TMDS against the declared rate (e.g. LG G3 OLED) mutes audio.
> 
> 
> Confirmed workaround
> --------------------
> 
> In dw_hdmi_qp_bridge_tmds_char_rate_valid(), reject 185,625,000 Hz:
> 
>     if (rate == 185625000)
>         return MODE_CLOCK_HIGH;
> 
> This forces DRM to select 8-bit mode (148,500,000 Hz). bridge_atomic_enable()
> then stores the correct tmds_char_rate, the AVI InfoFrame declares 8-bit,
> the ACR CTS is computed correctly, and the LG G3 produces audio.
> 
> Note: 185,625,000 Hz (1080p@60 10-bit) is only selected via EDID
> negotiation during seamless handoff. A genuine modeset at that rate would
> correctly reconfigure the PHY and the AVI/ACR inconsistency would not
> arise. Blocking this rate in tmds_char_rate_valid() therefore has no
> correct-use-case cost on RK3576 with the current BSP. 4K@60Hz (594 MHz)
> is unaffected and continues to work correctly, including audio.
> 
> 
> Proposed proper fix
> -------------------
> 
> The fundamental issue is that bridge_atomic_enable() accepts
> conn_state->hdmi.tmds_char_rate without verifying it against the PHY's
> actual output frequency.
> 
> Option A (no display disruption):
> 
>   The HDPTX PHY PLL is already registered as a clock provider. On
>   RK3576, rk3576.dtsi gives the hdptxphy node #clock-cells = <0>;
>   VOP2 consumes it as "pll_hdmiphy0". If the bridge driver adds a
>   new clk pointer (e.g. hdmi->tmds_clk) populated via
>   devm_clk_get_optional() at probe and queries clk_get_rate()
>   in bridge_atomic_enable(), it can detect the seamless-handoff
>   mismatch and use the actual rate:
> 
>       /* hdmi->tmds_clk added in struct dw_hdmi_qp; populated at
>        * probe via devm_clk_get_optional(dev, "tmds") or similar */
>       actual_rate = hdmi->tmds_clk ? clk_get_rate(hdmi->tmds_clk) : 0;
>       if (actual_rate && actual_rate != conn_state->hdmi.tmds_char_rate) {
>           dev_warn(hdmi->dev,
>               "seamless handoff: PHY at %lu Hz, DRM selected %llu Hz; "
>               "using actual PHY rate for audio\n",
>               actual_rate, conn_state->hdmi.tmds_char_rate);
>           hdmi->tmds_char_rate = actual_rate;
>       } else {
>           hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
>       }
> 
>   This corrects the ACR CTS and AVI InfoFrame without touching the
>   PHY configuration or causing a display blank.
> 
> Option B (correct but causes brief blank):
> 
>   If the driver detects a mismatch, call phy.ops->init() to bring
>   the PHY into agreement with the DRM-negotiated state. All
>   parameters become consistent at the cost of a single mode change
>   on first enable after seamless handoff. This is arguably the more
>   correct approach if the intent is to honour what the EDID reports.
> 
> Option A is preferred for a seamless user experience. Option B is
> preferable if the seamless-handoff-inherited U-Boot mode is not
> otherwise suitable for production use.
> 
> 
> Relation to Collabora's HDMI 2.0 patch series
> ----------------------------------------------
> 
> The "Add HDMI 2.0 support to DW HDMI QP TX" series (v3, January 2026)
> addresses high-TMDS-clock-ratio and scrambling. It does not appear to
> address the seamless-handoff tmds_char_rate mismatch described here.
> If a revision of that series reads PHY state at probe time it may
> incidentally close this gap, but that is not a stated goal. Reviewers
> may wish to verify the seamless-handoff path is exercised in testing.
> 
> 
> Summary
> -------
> 
>   Bug:        bridge_atomic_enable() takes EDID-negotiated
>               tmds_char_rate (185,625,000) while PHY runs at U-Boot
>               rate (148,500,000); the AVI InfoFrame and the ACR CTS
>               both reflect the connector-state nominal value, but
>               the wire TMDS clock disagrees with what AVI declares
>   Symptom:    audio silent on any HDMI 2.1 sink that cross-checks
>               wire TMDS against the AVI declaration; HDMI 2.0 sinks
>               unaffected (no such cross-check)
>   Scope:      RK3576 confirmed; RK3588 structurally identical
>   Not a bug:  N/CTS table, IEC60958 channel status, ARC, ALSA path
>   Workaround: reject 185,625,000 Hz in tmds_char_rate_valid() so
>               DRM picks 8-bit 1080p (148,500,000 Hz) which matches
>               the actual PHY rate
>   Fix:        compare conn_state->hdmi.tmds_char_rate against actual
>               PHY clock at bridge_atomic_enable() and use the
>               measured rate when they disagree (Option A) or
>               reconfigure the PHY (Option B)
> 
> I am happy to test patches on Sige5 + LG G3.
> 
> Regards,
> Simon
> Symple Solutions, Dunedin, New Zealand

