Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FF6C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5686C10E0AA;
	Fri, 14 Aug 2026 01:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="jy6NpMPI";
	dkim-atps=neutral
Received: from mail-m16023653209.xmail.ntesmail.com
 (mail-m16023653209.xmail.ntesmail.com [160.236.53.209])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A228610E1D1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 01:18:07 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 49ef6fdfd;
 Fri, 14 Aug 2026 09:18:03 +0800 (GMT+08:00)
Message-ID: <8d521014-3202-4f62-ba1a-ebe126506048@rock-chips.com>
Date: Fri, 14 Aug 2026 09:18:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
To: Igor Paunovic <royalnet026@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Alexey Charkov <alchark@flipper.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260813094614.9072-1-royalnet026@gmail.com>
 <20260813100027.349761F000E9@smtp.kernel.org>
 <20260813101307.10945-1-royalnet026@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260813101307.10945-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9ffdd8f94d03a7kunm270703397b358
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSBpIVh5MSEJCH00eQx4aSlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=jy6NpMPIEbDZlGuNoX291gdYX0VQAcedLCzPYKreLEEpWtqzIYmDm0pR0//ONnM54d4pMnpnGBoyvyiHJ5BPbJ13C2dSPm2V1dB7rQI+u5nFnOKVqmuCURDhrQfFdoMoI6oh1VncTFxhFe76lXnVXqMeRS3loQA0rLwFLLGC+6o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=3dtL6bOxO5qHs+QF6jriizna7ttJ8SGK3f5tUylWokY=;
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

On 8/13/2026 6:13 PM, Igor Paunovic wrote:
> The review bot found three things on v2 and all three are right. I am
> answering rather than sending a v3 straight away, because the fix for
> the two High ones is a single change that touches a file shared by
> every Rockchip SoC, and I would rather ask about that than guess.
> 
> Both High findings come from the same shortcut. v2 keeps the
> requirement in a global atomic state object, which I still think is the
> right container, but it applies the rate from vop2_crtc_atomic_enable()
> and _disable() rather than from the commit tail:
> 
>   - Out of order commits. Two non-blocking commits on different CRTCs
>     share only the private object, and nothing orders them, so a commit
>     that took its snapshot before another CRTC raised the rate can land
>     after it and lower it again.
> 
>   - Multi-CRTC disable. atomic_disable() runs once per CRTC, and the
>     first one already sees a state in which every participating CRTC is
>     off, so the rate drops while the others are still scanning out and
>     waiting for dsp_hold_completion.
> 
> vc4 solves both of these for its core clock, and what I did was take
> half of that pattern instead of all of it:
> 
>   - vc4_atomic_commit_setup() records a pending commit per channel in
>     the private state and the next commit waits on it with
>     drm_crtc_commit_wait(). That is the ordering v2 has no equivalent
>     of.
> 
>   - vc4_atomic_commit_tail() holds max(old, new) for the length of the
>     commit and only drops to the new rate after
>     drm_atomic_helper_wait_for_flip_done(). That is exactly the window
>     the second finding describes.
> 
> Hence the question. Doing the same in rockchip means adding both
> .atomic_commit_setup and .atomic_commit_tail to
> rockchip_mode_config_helpers in rockchip_drm_fb.c, which today carries
> only .atomic_commit_tail = drm_atomic_helper_commit_tail_rpm and is
> shared by every SoC this driver supports, VOP as well as VOP2. The
> commit tail would be a thin wrapper around the rpm helper with the
> clock work on either side of it, and both hooks would do nothing on
> anything that is not RK3588.
>

As you said, placing it in atomic_commit_tail is precisely because
atomic_flush is insufficient to handle multiple CRTC cases. 
So it's okay for me. Let's see if others have any comments. 

> Is that acceptable, or would you rather this stayed inside vop2 in some
> other shape? I am happy to write it either way, but I would rather find
> that out before than after.
> 
> The Medium finding needs no discussion: if
> drm_atomic_private_obj_init() fails, the jump to err_crtcs does not
> undo rockchip_rgb_init(). It is also new in this patch, since before it
> nothing after rockchip_rgb_init() could fail, so it is mine and it will
> be fixed in the next version whatever shape the rest takes.
> 
> Igor
> 
> 

-- 
Best, 
Chaoyi
