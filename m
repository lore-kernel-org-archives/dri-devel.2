Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC261606B9D7
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VtJdMc6C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3757310EF01;
	Tue, 10 Nov 2026 09:44:49 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Tue, 10 Nov 2026 09:44:42 UTC
Received: from mail-m16023652234.xmail.ntesmail.com
 (mail-m16023652234.xmail.ntesmail.com [160.236.52.234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FF610EEF2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:44:42 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54265f641;
 Tue, 10 Nov 2026 17:39:36 +0800 (GMT+08:00)
Message-ID: <e273e7c7-1fce-4079-bd8f-dd2aca66aa90@rock-chips.com>
Date: Tue, 10 Nov 2026 17:39:31 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] drm/rockchip: vop2: RK3588 clocking, sync polarity,
 AXI port and window fixes
To: aiyengar1990@gmail.com
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1c4d3c7fd03a7kunm4d0e6b6e711669
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHx9NVk1IGB0ZHUlJSRhITVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=VtJdMc6CdaxJQcjfXajoPmjCFrA2gOlY6F4VXoUV1KNNdx3jWkUroaMc1kRyaF4rATtK35P+7eEqeOTc1t+NvJ7cnK8ewDvybGzKCG/tY8WjMBcheT00SqiBL0JGD4YPNhqGxc83+vj3oZ2RVYUXVqyrN7aUKrGRi7jCl7OTwEk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=hnD12FtXfPhLj7ywO2z/F7Du4Nry3+tvwvKHT+IXeJY=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Arun,

On 11/10/2026 3:18 PM, Arun Iyengar via B4 Relay wrote:
> This series collects fixes for the RK3588 VOP2 found while bringing up
> HDMI and DisplayPort output on an Orange Pi 5 (RK3588S).
> 
> Patches 1 and 2 fix the RK3588 interface setup: rk3588_calc_cru_cfg()
> leaves dividers it does not use uninitialised and the garbage ends up in
> VP_CLK_CTRL, and rk3588_get_hdmi_pol() decodes the POLFLAG bits it is
> handed as DRM mode flags, so the GRF sync polarity bits are wrong for
> most modes.
> 
> Patch 3 stops the RK3588 Cluster windows from advertising AFBC with the
> lossless colour transform (YTR) for RGB565/BGR565, which the decoder
> cannot display (black picture plus POST_BUF_EMPTY).
> 
> Patches 4 and 5 deal with POST_BUF_EMPTY underflows. The VOP2 fetches
> through two AXI read ports but the port of each window is fixed in the
> window table, so the usual primary plane plus overlay configuration of
> a video port puts both layers on one port while the other sits idle.
> One port cannot sustain two full screen 4K@120Hz layers (measured: the
> fetch rate collapses from ~6 GB/s to ~3 GB/s and about half of all
> lines underflow). Patch 4 assigns the port when a window starts
> fetching, balancing the estimated load; patch 5 rate-limits the
> POST_BUF_EMPTY interrupt to once per frame, since an underflowing port
> otherwise keeps the CPU in the interrupt handler 50000 to 300000 times
> per second.
> 

Have you checked the aclk_vop rate?

> Patches 6 to 8 are smaller fixes: the start mixer search skipped
> Esmart3 (for_each_set_bit() was given the highest window id as the bit
> count), a gamma LUT update cleared the other fields of LUT_PORT_SEL
> (the VP0/VP2 dclk source selection and the VP0/VP1 merge enable), and
> the AFBC tile count and transform offset were wrong for a source that
> starts inside a 16 pixel superblock.
> 
> Tested on an Orange Pi 5 (RK3588S) with an HDMI 2.1 TV and a
> DisplayPort monitor, pictures judged with a camera. Patches 1 and 2:
> VP0_CLK_CTRL reads back without the garbage dclk_out divider, the sync
> polarities seen by the HDMI controller (VIDEO_INTERFACE_STATUS0) match
> the mode flags for +/+ (1080p, 2160p) and -/- (720x480, 640x480) modes,
> and the picture is correct over TMDS and FRL modes from 27 to
> 1188 MHz. Patch 3: RGB565 is offered on the Cluster windows only
> without YTR, and those planes scan out correctly on three Cluster
> windows. Patches 4 and 5: 3840x2160@120 with a full screen overlay
> (previously ~120000 POST_BUF_EMPTY per second and a scrambled picture)
> and a dual-display session (HDMI 4K@60 plus DP 4K@30, two video players,
> ten minutes) run with zero underflows. Patches 6 to 8 were found while
> driving Esmart3 and partial AFBC overlays: an AFBC overlay placed at
> x=1001 shows correctly. All eight have been in the board's kernel for
> the display test runs since.
> 
> This series was developed with Claude (Anthropic) as a coding assistant:
> it wrote the code and the commit messages, and I reviewed and tested
> every change as described above.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
> Arun Iyengar (8):
>       drm/rockchip: vop2: Don't use uninitialised dividers on RK3588
>       drm/rockchip: vop2: Fix the HDMI sync polarity on RK3588
>       drm/rockchip: vop2: Don't accept AFBC YTR for RGB565 on RK3588
>       drm/rockchip: vop2: Balance window fetches across both AXI ports on RK3588
>       drm/rockchip: vop2: Report POST_BUF_EMPTY at most once per frame
>       drm/rockchip: vop2: Find the first mixer of a video port with Esmart3 too
>       drm/rockchip: vop2: Keep the other LUT_PORT_SEL fields on gamma LUT updates
>       drm/rockchip: vop2: Fix the AFBC offsets of a source that starts inside a superblock
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 186 +++++++++++++++++++++++++--
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  24 ++++
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c |  27 +++-
>  3 files changed, 223 insertions(+), 14 deletions(-)
> ---
> base-commit: 8deaade4a5a4ff635df91e246e42139ab2b33f6d
> change-id: 20261110-vop2-fixes-fa45142799c1
> 
> Best regards,
> --  
> Arun Iyengar <aiyengar1990@gmail.com>

-- 
Best, 
Chaoyi
