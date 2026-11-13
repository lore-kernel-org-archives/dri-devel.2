Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAB606A8AE
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=UOeTeFTk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A7F10E09F;
	Fri, 13 Nov 2026 03:47:32 +0000 (UTC)
Received: from mail-m81213.xmail.ntesmail.com (mail-m81213.xmail.ntesmail.com
 [156.224.81.213])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8C810E09F
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 03:47:26 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 5488ddde6;
 Fri, 13 Nov 2026 11:47:22 +0800 (GMT+08:00)
Message-ID: <d8c4201a-7fa5-4831-b2a0-7e603e443567@rock-chips.com>
Date: Fri, 13 Nov 2026 11:47:21 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] drm/rockchip: vop2: Report POST_BUF_EMPTY at most
 once per frame
To: aiyengar1990@gmail.com, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan
 <andyshrk@163.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-6-8218c1cf8ac8@gmail.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261112-vop2-fixes-v2-6-8218c1cf8ac8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa1d30462b203a8kunm6288f08e5bde9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGBkaVhlOS0IeThgaSh8ZGlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=UOeTeFTknFLncW5GEyIIqqIAPAhoP8j7fodDwPUCsy9ptksY/V+zcWtpn4NERrJDm0gn/gfDgrY41ayvsT1WRO0R0/a01ZXggzWwaDtU58ia3adLvT/HqImPAgfGtvR4S3+NAC8HvHZhqZpWt3atIytZl3XG24J1toe9Yl7aGwY=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=m3fmYBaNLptWcqbvTdAs8gd+S3McHL6fxfP2xtMRAWE=;
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

On 11/12/2026 4:33 PM, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> POST_BUF_EMPTY is raised for every line on which the post processing
> stage of a video port finds no data. The interrupt handler only
> rate-limits the error message and leaves the interrupt enabled, so an
> underflowing video port keeps the CPU in the interrupt handler 50000 to
> 300000 times per second, for as long as the configuration that causes
> the underflow stays in place (e.g. 120000 interrupts per second for
> 3840x2160@120 with two full screen layers on one AXI port).
> 
> Mask POST_BUF_EMPTY when it fires and unmask it at the next frame start.
> The frame start (FS) interrupt is enabled for that frame even when
> vblank reporting is off, and disabled again once POST_BUF_EMPTY is
> re-armed or the video port is switched off. VP_INT_EN is write-masked,
> so masking POST_BUF_EMPTY leaves FS alone; FS only needs enabling here
> while vblank reporting has it off. A new per video port lock
> serialises the interrupt enable bookkeeping between the interrupt
> handler and the vblank callbacks. The error is still reported, now at
> most once per frame and video port.
> 
> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 91 ++++++++++++++++++++++++++--
>   drivers/gpu/drm/rockchip/rockchip_drm_vop2.h | 10 +++
>   2 files changed, 97 insertions(+), 4 deletions(-)

Well. This change can indeed reduce CPU interrupt pressure when 
occasional POST_BUF_EMPTY occurs. However, we do not expect this error 
to happen during normal system operation: if POST_BUF_EMPTY shows up, it 
should be resolved by adjusting layers configurations or improving DDR 
bandwidth, rather than being masked.

On the other hand, this approach drops the per-line POST_BUF_EMPTY
information. In complex debugging scenarios we still need the per-line
error reports to locate issues, for example partial line data corruption
with AFBC on Cluster planes. Reporting only one interrupt per frame 
would hide these critical debug details.

So in my opinion, we should keep POST_BUF_EMPTY handling as it is.

Nacked-by: Damon Ding <damon.ding@rock-chips.com>

Best regards,
Damon

