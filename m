Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A62C5AC67
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 01:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A002510E3D0;
	Wed, 12 Aug 2026 01:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cOaDyWdR";
	dkim-atps=neutral
Received: from mail-m20521016463.xmail.ntesmail.com
 (mail-m20521016463.xmail.ntesmail.com [205.210.164.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1B010E3D0
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 01:25:52 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 49a33dfec;
 Wed, 12 Aug 2026 09:25:48 +0800 (GMT+08:00)
Message-ID: <7759116b-0beb-4d25-b269-c020a8379cef@rock-chips.com>
Date: Wed, 12 Aug 2026 09:25:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm/rockchip: vop2: ACLK_VOP pinned at 500 MHz starves DP 4K120
 on RK3588
To: Igor Paunovic <royalnet026@gmail.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Alexey Charkov <alchark@flipper.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260808104240.13776-1-royalnet026@gmail.com>
 <33bd4a94-11af-4cf3-ae44-b7f8944250f6@collabora.com>
 <c0a7521d-9c19-4197-802b-2b64a6ddea28@rock-chips.com>
 <20260811212358.9980-1-royalnet026@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260811212358.9980-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ff3935a1603a7kunma9ed9a6653df7f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkxCVh5CQksdQ0MeHk0YS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
 5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
 b=cOaDyWdRAxlpsy2UZNaw6jtOHLzKEVO2PH1nfbpU2gGI4ztScBWgDjLI3RaPv+d3AbBmnR09Y0J5rghLR2gFDPknv7vF4fWjrUiRTGMmqaeeQ41edqMZcm9k6cQROed5Gpm6wcA8B8nsdYwH0Iuwi6EktnUe27rSlUwoi2AaoIM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=nNjRP8b2E5ujn/7f/mFvE77jAW/d1Pb5a/2rPLROufo=;
 h=date:mime-version:subject:message-id:from;
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

On 8/12/2026 5:23 AM, Igor Paunovic wrote:
> Hi Chaoyi, Cristian,
> 
> Chaoyi, your reading fits my own measurements better than mine did.
> 
> The link in that test was running YCbCr 4:2:0, so dclk sat at 594 MHz
> for a 3840x2160@120 mode - the interface rate was the cheap part. What
> was not cheap was what the video port had to compose: a single
> full-screen 3840x2160 ARGB plane at 120 Hz. So the case I reported is
> one where the interface was modest and the composition was not, which
> is the direction you are pointing in. I framed it as a DisplayPort
> problem because DisplayPort was the only thing I changed; that was the
> wrong axis.
> 
> I should say what this bears on directly, because it is not
> hypothetical for me. I have a patch here that I have not sent, which
> replaces the frl_enabled condition with a threshold on the pixel clock:
> 
>   static bool vop2_needs_aclk_boost(struct drm_crtc_state *crtc_state)
>   {
>       return vcstate->frl_enabled ||
>              crtc_state->adjusted_mode.crtc_clock > VOP2_HIGH_BW_PIXCLK_KHZ;
>   }
> 
> with VOP2_HIGH_BW_PIXCLK_KHZ at 1000000, so that any video port needing
> the bandwidth can ask for the higher rate. It also guards the refcount
> on the way, since atomic_disable() runs for ports that were never
> enabled and the counter is unsigned. It is written against the
> rockchip-devel branch, on top of the commit Cristian mentions, and I
> was holding it back until I had a threshold I could defend.
> 
> Your reply says the quantity I keyed it on is the wrong one, and I
> cannot argue against that from my own data. The measurement the
> threshold came from is that at 500 MHz a 2560x1440@144 mode stays clean
> while 3840x2160@120 does not. But in both cases the port was composing
> a single full-screen plane at the mode's own resolution, so mode and
> composition moved together and the comparison cannot separate them. If
> the rule belongs in terms of what the port composes, then the pixel
> clock is at best a proxy that happens to fit the two points I have.
> 
> I would rather learn that before sending the patch than after. Two
> things I can run here:
> 
>   - your first case: hold 3840x2160@120 on DP, leave ACLK at 500 MHz,
>     and scan out a 1080p plane instead of the full-screen one. If that
>     comes up clean, the pixel clock is not the variable and the patch
>     as written is keyed on the wrong thing.
> 
>   - your second case: a modest mode with several 4K ARGB planes
>     composed at once. I can drive that over HDMI, without the USB-C
>     adapter in the path, so it is a cleaner test than the first.
> 
> Is there a form of the condition you would consider correct? What your
> description suggests to me is something derived from the composed pixel
> rate summed over a video port's enabled planes, with max() across the
> active ports rather than a refcount - but you know what the hardware
> actually stalls on, and I am inferring it from an interrupt counter.
> 

In fact, this is similar to what we do in the downstream kernel. 
The complete decision flow is as follows[0]:

if (vop_bw_info->plane_num_4k || crtc_num > 1 ||
	crtc->state->adjusted_mode.crtc_hdisplay > 2560 ||
	crtc->state->adjusted_mode.crtc_vdisplay > 2560 ||
	linedur_ns < 7500) {/* 4kp60 linedur_ns roughly equal to 7500 ns */
	
	/* set aclk to 750M */
	funcs->set_aclk(crtc, ROCKCHIP_VOP_ACLK_ADVANCED_MODE, vop_bw_info);
	priv->aclk_adjust_frame_num = 2;
}

I think the condition above should be equivalent to the
"linedur_ns < 7500" here :)

[0]: https://github.com/rockchip-linux/kernel/blob/develop-6.6/drivers/gpu/drm/rockchip/rockchip_drm_fb.c#L204


> Cristian, understood on HDMI. If FRL and TMDS can serve the same mode
> at different fixed rates, the mode cannot determine the rate on its own
> and a bandwidth rule cannot be the whole story there. That answers what
> I asked. Whatever shape this ends up taking should keep working for the
> FRL case you already handle rather than replace it.
> 
> One thing worth carrying across from the dw-dp v11 thread, since not
> everyone on this Cc list is on that one. Heiko reported that on his 4K
> display he gets no output at all at the stock rate, and some output
> after raising ACLK_VOP to 750 MHz, although that output is garbled:
> 
>   https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/
> 
> So the starvation reproduces on hardware other than mine, which until
> now I could not tell apart from a fault in my adapter. The garbling at
> 750 MHz is not something I see here - the picture was correct the
> moment the write landed and stayed correct - so that looks like a
> separate problem, and I have replied to him on that thread rather than
> fold it into this one.
> 
> Igor
> 
> 

-- 
Best, 
Chaoyi
