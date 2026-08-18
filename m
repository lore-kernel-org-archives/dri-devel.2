Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009C1C5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660A910EAE3;
	Tue, 18 Aug 2026 12:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jShF+R5h";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED23010EAE3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787055512;
 bh=IIl9f09sAtLyS8+D8lm8fCz9k0/RNdLNbkzXeNjbF6w=;
 b=jShF+R5hUR37kztgNbMutr5kJFnV7BQkl1B3rx0+g2BpDI49U4MYAExo1H5YozNdYYxcjKy8W
 oKAPZotGY044g8ZKVeKseK8dFlSEd+7kozAoQFTppyoXXtO3OQYxXYWDTvlkXnSD828N1iobG+C
 8hbXSbTwquw8QbfDOHE31MryJjQbNTeC4nnzX8wq5OdMVLVIUR9GroTR3mx3sRjn7ZU2qGtxNWW
 eXeuzTHh9Zhguz+H/kf2L1eYmy2PiG2Lt2HwODZ2YWzLTKGi556ZxVDpXfBGhOM/nYQ+pTrSegG
 hhUMFmwVwnWGMGnPPDgSA5+zjCjcu5txjzQ5SiONpXjQ==
X-Forward-Email-ID: 6a844c23b1ee0df32f73bdb3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
Date: Tue, 18 Aug 2026 14:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
To: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Heiko Stuebner <heiko@sntech.de>, Jiaxing Hu <gahing@gahingwoo.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
 <20260818072936.41844-1-royalnet026@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260818072936.41844-1-royalnet026@gmail.com>
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

On 8/18/2026 9:27 AM, Igor Paunovic wrote:
> Hi Nicolas,
> 
>> I'm only looking at the RK3588, I suppose all the issues below
>> related to RK3576 ?
> 
> No - everything in the RFC is RK3588 (Orange Pi 5 Plus, all three
> cores). RK3576 is Jiaxing's enablement series and has its own set of
> problems; nothing I reported came from there.
> 
> I went through the four commits on rock5b-npu-poc-4 today. We
> converged on the same shape independently, which is encouraging:
> 200 MHz kept as the suspend rate, a single devfreq instance modelled
> on panfrost with busy time aggregated across the three cores, and a
> cooling device on top. Your ~2.5x on the SSD pipeline also matches
> the 2.58x I measured here with simple_ondemand against the 200 MHz
> pin.
> 
> The TF-A pointer (rk3588_clk.c, PVTPLL vs normal path) is the most
> valuable part for me - it names the mechanism behind the power-on
> ack failure I could only demonstrate empirically. I will reference
> it in the cover letter once I have checked the firmware source
> myself.

Based on what I learnt when playing around with the SCMI GPU pvtpll [1],
we must keep core block clock enabled as long as PVTPLL mode is enabled
instead of the normal PLL mode.

When PVTPLL mode is enabled, the PVTPLL GRF, PD and GPU block is fully
provided by the PVTPLL clock, i.e. SError when accessing hw regs in
case Linux disables CLK_GPU.

Linux does not know anything about PVTPLL mode, the SCMI clocks are
fully controlled by firmware (tf-a) and basically switches to use PVTPLL
mode for all rates above 100/200/300 MHz.

Vendor kernel typically always changes to use 100/200/300 MHz at system
and runtime suspend to disable use of PVTPLL.

Because this PVTPLL dependency is not really known to Linux we must
use workarounds to hide this, ideally we should fully implement PVTPLL
handling in Linux or ensure firmware always keep dependent clocks
enabled to avoid SError when accessing regs.

For GPU case I depend on the opp-suspend rate to ensure opp and runtime
pm framework make best effort to restore normal mode when GPU is unused.

However, opp framework does not provide any integration into pm runtime
so it will happily clk_set_rate() when pm runtime is suspended. My
workaround to avoid SError was to use a custom .config_clks() ops in
struct dev_pm_opp_config that just checks pm_runtime_suspended().

The RFC series at [1] was never posted on mailing list, but is currently
in use by e.g. Armbian to allow use of full 1 GHz rate of GPU on RK3588.

I am guessing NPU have similar limitations/requirements as the GPU block.

[1] https://github.com/Kwiboo/linux-rockchip/commits/next-20260619-rk35xx-scmi-gpu-clk/

Regards,
Jonas

> 
> Status here: after Tomeu's go-ahead I am preparing the series -
> bindings, a full-range OPP table in the DT (300-1000 MHz plus the
> 200 MHz suspend point, so essentially the table you ended up with),
> a safe-rate-on-suspend guard, the devfreq itself, and a hold-all
> guard that resumes all cores around any rate change. The guard is
> ordered before the devfreq patch so no bisect point has scaling
> without it. The one hard dependency is my "request the core clocks
> by name" v2, still waiting for pickup.
> 
> Agreed on OPP staying optional - the plan in my series is that the
> driver keeps working with no OPP table in the DT, which I saw you
> intend to fix on your side as well.
> 
> One path worth checking in your PoC, because it is the one that
> made me write the hold-all guard: a sysfs min_freq/max_freq write
> while all three cores are runtime-suspended goes straight to
> clk_set_rate, which can select the PVTPLL path while the domain is
> off - exactly the case your TF-A reference explains. With the guard
> in place I measured that write waking the cores and completing
> cleanly.
> 
> One difference in test conditions worth keeping in mind: my numbers
> are with the vendor bl31 that EDK2 bundles, yours is upstream TF-A.
> Comparing SCMI behaviour on both seems wise before either of us
> claims anything firmware-specific.
> 
> Thank you for the "take whatever you like" - anything I lift will
> carry credit, and I will Cc you on the series.
> 
> Regards,
> Igor
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

