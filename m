Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109AEC5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:40:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F96010E123;
	Wed, 19 Aug 2026 09:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ydUKOMG0";
	dkim-atps=neutral
X-Greylist: delayed 77272 seconds by postgrey-1.36 at gabe;
 Wed, 19 Aug 2026 09:40:21 UTC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D55810E123
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787132421;
 bh=5ZSJ5JiWdzfnEZOyHtVE0gzzOhx3PA5xc4qwHKzsEaI=;
 b=ydUKOMG0smywR4MmBmKHIhAueJYTncDg21uJi66XNVefN8bcXlL4qD6k51LjBqDLxiUWde+y/
 O2v3CfzWfV4f6tMjbP2+1eAwscasIGcCH3gPUlFbexrEm7yox3xdpe34x7xScHXobz9/s0LrL/W
 9sIHcjhO0kL3GMKTkYlwWjrNCeijDmwaxko5+900uTe7DqE3eqssh5lPMwCYWK/2/k7ELYlLc5g
 +NAg5zl+BUvxLC8xwtlewaUeD9WJAdu0hIzuYvgq6FkTDscfPig01NQvbuBR1PPLhdQ3+r4Ri/3
 lT1W28MlXgmkgrHWRIzCWk2mHJcI9XQ68Az8TWR2DZGg==
X-Forward-Email-ID: 6a8579fdcdadef0c83c57015
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <3204a0d0-969d-4ac6-adfd-29c57f1c3e0a@kwiboo.se>
Date: Wed, 19 Aug 2026 11:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] accel/rocket: DVFS on RK3588 - a hardware constraint, and
 some numbers
To: Igor Paunovic <royalnet026@gmail.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Heiko Stuebner <heiko@sntech.de>,
 Jiaxing Hu <gahing@gahingwoo.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org
References: <20260801131656.58450-1-royalnet026@gmail.com>
 <c495dae1976dab842d77f4a4a142217eb77b6fb7.camel@ndufresne.ca>
 <20260818072936.41844-1-royalnet026@gmail.com>
 <ad1e526e-a4cf-4c34-88ff-1884ef2f3dfe@kwiboo.se>
 <286e8418-fae6-4979-96d1-e13abb04b3a1@kwiboo.se>
 <20260819055324.33669-1-royalnet026@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260819055324.33669-1-royalnet026@gmail.com>
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

On 8/19/2026 7:52 AM, Igor Paunovic wrote:
> Hi Jonas,
> 
> On 8/18/2026 2:30 PM, Jonas Karlman wrote:
>> Looking closer at my old commits, it was the PCLK_GPU_ROOT that was
>> needed for e.g. RK3576 and RK3528. This clock is not described in RK3588
>> clock tree so it never gets disabled by Linux clock framework.
>>
>> I suspect similarly one of the NPU root clocks is what drives the NPU
>> PVTPLL and thus always must be kept enabled when PVTPLL mode is used.
> 
> Thank you - the PCLK_GPU_ROOT observation was the missing piece. I went
> through the firmware my board actually runs and can now name the clock
> for the NPU case.
> 
> First a correction to what I told Nicolas earlier: my BL31 is not the
> vendor blob. The boot banner reports v2.12.0-9-gd5c68fd92, which is the
> edk2-rk3588 project's TF-A branch: upstream v2.12.0 plus nine feature
> commits (SCMI voltage domain, eMMC clock, TRNG, ...). The only one of
> those touching rk3588_clk.c adds an eMMC clock; the NPU set_rate/PVTPLL
> path is unmodified mainline v2.12. So Nicolas and I are effectively
> running the same clock code, and the firmware-difference caveat from my
> earlier mail mostly evaporates.
> 
> What clk_npu_set_rate() in plat/rockchip/rk3588/drivers/scmi/rk3588_clk.c
> does:
> 
> - The rate table gives every OPP from 300 MHz up a ring length > 0, so
>   they all take the PVTPLL path; 200 MHz has length 0 and takes the
>   normal GPLL divider path. The 200 MHz suspend rate we both converged
>   on is therefore safe by construction on this SoC.
> 
> - For a PVTPLL rate the firmware programs ring_sel/length/calibration
>   (cal cnt = 24, T = 1 us, i.e. a 24 MHz reference) into NPU GRF at
>   0xfd5a2000 (NPU_PVTPLL_CON0..2), and only then flips the mux in CRU
>   CLKSEL_CON(74) to the PVTPLL path.
> 
> The Linux side is where the NPU differs from your GPU case: the NPU
> root clocks are fully described in clk-rk3588.c. pclk_npu_root is a
> gateable composite (CLKGATE_CON(29) bit 4) and NPU GRF hangs off it
> (pclk_npu_grf, CLK_IGNORE_UNUSED). In the mainline DT only core 0
> (fdab0000) requests PCLK_NPU_ROOT as its "pclk"; cores 1/2 only hold
> their aclk/hclk. So whenever core 0 is runtime-suspended, pclk_npu_root
> has no user left and gets gated.
> 
> An SCMI set_rate to a PVTPLL rate issued in that state programs a GRF
> whose bus clock is off, while the mux write still lands because the CRU
> is always clocked - leaving clk_npu_dsu0 parked on a ring that was
> never configured. That matches the empirical failure in my RFC exactly:
> the sysfs min_freq write while suspended, followed by the power-domain
> power-on ack timeout. (I have not put a scope on the APB bus, so "the
> GRF write cannot land" is inferred from the failure signature plus the
> gate state, not observed directly.)

Ideally the SCMI firmware code should probably be updated to ensure any
required root clock is ungated, and possible also hide some related
clocks from OS. I am not even sure this is feasible option and this may
diverge too much from vendor blobs and may not be backward compatible.

> 
> For the series this reinforces the hold-all guard: resuming all cores -
> core 0 in particular - around every rate change keeps pclk_npu_root
> enabled for the duration of the SCMI call, closing the window for the
> sysfs, governor and cooling paths alike. Your .config_clks() +
> pm_runtime_suspended() check covers the OPP-initiated paths; I will
> reference it and your branch in the cover letter.

I played around with Nicolas patches and created a more updated
config_clks() variant that tries to use the clocks configured for opp
instead of keeping track of the clock, see [2]. Have not done any
runtime testing of that, but wanted to share the link anyway :-)

If I remember correctly for the GPU path on RK3576, keeping the 'bus'
clock enabled at all times helped ensure any root clock was enabled
while GRF is accessed. I cannot remember that I had any issues with GPU
GRF access for PD and sysfs governor paths. The config_clks() helped
ensure set_rate never was called during GPU probe or when governor was
changed. Maybe I missed testing some other paths :-)

[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20260803-rk-hdmi-v6/

> 
> One open point where your GPU experience may help: besides the GRF
> programming interface, do you know whether the ring/monitor logic also
> depends on hclk_npu_root, or is the 24 MHz calibration reference
> (xin24m, always on) the only other input? If you never had to find out,
> I will determine it empirically by holding only pclk and cycling rates.

I do not know, and never looked too deep into it, with the root clk
enabled everything seemed to work great, so I was happy enough with that
and just moved on to next thing :-)

Regards,
Jonas

> 
> Regards,
> Igor

