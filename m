Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B293C5DF88
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8985E10EE67;
	Wed, 19 Aug 2026 16:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="BDmlpvfX";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC8510EE67
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787156412;
 bh=/Ys6PQN2Gy/gC4sjx/MhtQYooND7k7JjSVUYBnPXkNU=;
 b=BDmlpvfXN7Pg7/KNGe04uDJVcAp0iN29/DtwajPjNjnOZMT/XZdDQu1x1wWE0DdxevYn+QzRT
 Sob6f36eGIp9tYI5+eytXnDPyZbiwo3Ea2n3m0NuCFdh7oeWl33ApPqxte9+MezMjKjPycrZ8+f
 WHk6YFh7LQ86WnFPQv++jFbBO9Y48EFtsCsovXmDjd4v66n0CTE3OK+LSfN1QkkivybFpfswGN8
 xDv8mu+rySF9MSgiFvg3dxqK7mqJkUs16Y/S/XzeiZ/byvTOJa87Zw4piXxAaO1Z+9ALsKlAedC
 w5O1cleIt9mXVtqbnjKyVBJX1L1HOYuFQ91kJJtz5e7w==
X-Forward-Email-ID: 6a85d7ba03d49fd4b86d3e5c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <82c8b17e-7215-45ea-84d1-9991ba6fb541@kwiboo.se>
Date: Wed, 19 Aug 2026 18:20:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
 <20260818072936.41844-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
 <20260819125932.5853-1-royalnet026@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260819125932.5853-1-royalnet026@gmail.com>
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

Hi Igor,

On 8/19/2026 2:59 PM, Igor Paunovic wrote:
> Hi Jonas,
> 
> I promised to determine empirically which clock the NPU PVTPLL needs.
> I ran that today. The answer is not what either of us expected, and it
> comes with two corrections to my previous mail, so those first.
> 
> Correction 1: I wrote that only core 0 requests PCLK_NPU_ROOT in the
> mainline DT. That is wrong - all three rknn-core nodes request it as
> their "pclk" (my grep had truncated the clocks list; verified since in
> the tree and in the live FDT). The hazard window is unchanged in
> practice - the gate still closes whenever all three cores are
> runtime-suspended, which is the normal idle state - but the sentence
> as I wrote it was false.
> 
> Correction 2: my inferred failure mechanism ("the GRF write cannot
> land, the mux still switches, the ring is left unconfigured and the
> failure appears later as a power-on ack timeout") understated reality
> considerably. Measured today:
> 
> Test module, on the same v2.12 firmware discussed earlier: acquire the
> clocks via the core DT node, verify all three cores runtime-suspended,
> then issue one clk_set_rate(scmi npu clk, 600 MHz - a PVTPLL-path
> rate). Serial console at loglevel 8, captured by a recorder on a
> second machine, so the last lines survive whatever happens. Three
> arms, one variable:
> 
>   held during set_rate          outcome
>   pclk_npu_root                 SoC resets, U-Boot 0.58 s after the call
>   pclk + hclk (the PD pair)     identical, 0.58 s
>   nothing (control)             identical, 0.58 s
> 
> No oops, no SError trace, nothing on the console after the set_rate
> marker in any arm - the SoC dies at firmware level and the reset
> latency is constant to the millisecond across all three. Bus clocks
> are simply irrelevant to this failure: my open question ("does the
> ring also need hclk_npu_root?") turns out to be the wrong question.
> No root clock makes a domain-off set_rate safe.

Correct, the power domain must be powered on when PVTPLL is used, I
thought this had already been concluded. It is hard to fully keep track
when context keeps being removed in each new mail ;-)

The GPU/NPU related PVTPLL, GRF etc lives inside its PD, at least on
RK3588. And I also think there was some dependency on the bus clock.
So when PVTPLL is used instead of a normal PLL from CRU, the PD must be
kept alive, and we must switch to a normal PLL before PD is powered off,
it is likely that some bus clock is also needed in addition to PD.

> 
> The explanation most consistent with the data is that the NPU GRF (or
> the PVTPLL block behind it) sits inside the NPU power island, so the
> EL3 write to 0xfd5a2000 with the island off is fatal regardless of any
> bus clock state. I cannot rule out that the firmware dies elsewhere in
> that path, but the clock-independence is measured, not inferred.

I thought it was possible to access the GRF when normal PLL from CRU is
used and clocks where enabled, but maybe there is also a dependency on
PD being powered on to access GRF in normal PLL mode.

> 
> The counterpart run closes the loop: same module, same set_rate to a
> PVTPLL rate (1 GHz), with the cores resumed first - completes cleanly,
> and the GRF readback then matches the firmware table exactly (ring
> length 12 for 1 GHz in CON0_H, cal_cnt 0x18 in CON1, 0x40000 gating
> interval in CON2). So the sequence we discussed is confirmed live in
> the registers, and the domain state is the single discriminating
> variable.
> 
> For the series the consequence is now sharp: every path that can issue
> an SCMI set_rate - governor, sysfs, cooling, OPP init - must guarantee
> the domain is powered first. The hold-all guard stays ordered before
> the devfreq patch, and your pm_runtime_suspended() check in
> config_clks() guards the OPP-initiated paths for exactly the same
> reason. On mainline as-is the NPU exposure is theoretical only because
> nothing scales the clock yet.

It is probably not just set_rate, with PD and/or CLKs disabled just
reading clk_summary to read SCMI clock rate can issue SError or a freeze.
At least that was something I managed to trigger when I was playing
around with using SCMI clock for GPU on RK3588, RK3576 or RK3528.

One option is to fully move GPU/NPU clocks and power domains to SCMI
firmware, and fully hide GPU/NPU related CRU clocks and PDs for from OS.

> 
> One small ask: we tried to read a ring frequency counter in the NPU
> GRF (candidate offset +0x24) to publish measured ring frequency vs
> voltage; it reads zero with the ring demonstrably running, so the
> candidate is wrong. If you happen to know the OSC counter offset in
> the GPU GRF from your experiments, the pointer would save a TRM dig -
> if not, no matter.

To my knowledge there are status regs that can be used to get the
measured rate of the PVTPLL, at least upstream TF-A have a commit [3]
for RK3588 that changes to report the measured rate when PVTPLL mode is
used.

It is possible the measured value only can be read back when PVTPLL mode
is used, ring is configured, PD is alive and bus clock is enabled and
enough time has passed.

[3] https://git.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmware-a.git/+/d2d6928641bacfa2370a9bb38cdddad229d99ad6

Regards,
Jonas

> 
> Regards,
> Igor

