Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197A606A330
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Fbu7h1EG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB24410E8D1;
	Wed, 25 Nov 2026 13:33:47 +0000 (UTC)
Received: from mail-m12839.netease.com (mail-m12839.netease.com
 [103.209.128.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF6610E8D1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 13:33:41 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55facbdab;
 Wed, 25 Nov 2026 21:33:37 +0800 (GMT+08:00)
Message-ID: <cb5cc4d5-150a-4215-a894-3b9c66db06fd@rock-chips.com>
Date: Wed, 25 Nov 2026 21:33:37 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/rockchip: analogix_dp: Disable pclk if setting
 eDP mode fails
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Alexandre Marquet <tb@a-marquet.fr>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20261125114319.1089186-1-n.zhandarovich@fintech.ru>
 <20261125114319.1089186-3-n.zhandarovich@fintech.ru>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20261125114319.1089186-3-n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa212e96d3f03a8kunm52d5496e780fb0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUsYVhhDGksaTBgdHkxLQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Fbu7h1EGwVDk53lKVh4LIyAnmsdPnxl4yb1tAARl8moDFvuRqvHebHDAjcY7+ygNmqCfvDDBJiNNAOaHcoq8fBe/S5EVONIj4Cf1Jrq4wwq77bM70T+jzX4C/wVtulDYJ8blQbhqpMb/0b/mv1bXa+gErk6lQF9Bzt2qTcW3/0g=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=xN9G4ryMMM9+3du3bk45iP+b6+/ThJuYMnDmmu96Klc=;
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

Hi Nikita,

On 11/25/2026 7:43 PM, Nikita Zhandarovich wrote:
> The eDP-mode register write via rockchip_grf_field_write() call can
> fail after pclk has been enabled. To prevent this, disable pclk before
> returning that error so the platform power_on callback, in turn,
> releases the clock reference it acquired on failure.
> 
> Fixes: 729f8eefdcad ("drm/rockchip: analogix_dp: Add support for RK3588")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>   drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 3a80600eece1..a9056303a987 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -145,8 +145,10 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
>   	}
>   
>   	ret = rockchip_grf_field_write(dp->grf, &dp->data->edp_mode, 1);
> -	if (ret != 0)
> +	if (ret != 0) {
>   		DRM_DEV_ERROR(dp->dev, "failed to set edp mode %d\n", ret);
> +		clk_disable_unprepare(dp->pclk);
> +	}
>   
>   	return ret;
>   }

For the earlier rockchip_dp_pre_init(), I think a goto-based error path
might be cleaner.

Best regards,
Damon

