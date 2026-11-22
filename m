Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A268606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=dWk5wVF+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C272510E259;
	Sun, 22 Nov 2026 15:09:57 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADF010E259
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 15:09:51 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F6BF177;
 Sun, 22 Nov 2026 16:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795360038;
 bh=IMRAy5bUasbpD/Tw7zcQxXeVbhBdEkFoZeMY9+96wKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dWk5wVF+6fLHQBBzxh8b2SS8ij5qaN6OUs6mMgqr5B56aWY/s8wpt4WGX6K5RokYX
 YetOQSn/qU3V41NW6+zsFVBBquu+Wf2EV61tExw2fhKOBFkLcWcAUeoPycSmgCVhy7
 dM165WjS6P2F6oQMPZOEbbMXDZ5ydXwQnm5mmVkQ=
Date: Sun, 22 Nov 2026 17:09:48 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@flipper.net>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v12 06/23] drm/bridge: synopsys: dw-dp: Fix AUX transfer
 timeout race condition
Message-ID: <20261122150948.GA2881876@killaraus.ideasonboard.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
 <20261114-synopsys-dw-dp-improvements-v12-6-d42d3dc5bdd4@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-6-d42d3dc5bdd4@collabora.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 14, 2026 at 06:00:39AM +0100, Sebastian Reichel wrote:
> The DP AUX transfer method uses a completion triggered by an interrupt,
> which can timeout. If the function runs into the timeout and the
> interrupt fires afterwards, the following DP aux transfer completion
> would trigger immediately without waiting for the interrupt. This in
> turn means the next one would also be broken and so on.
> 
> Fix this potential issue by re-initializing the completion directly
> before sending the AUX command.
> 
> As this is racy (the interrupt might arrive between the completion
> re-init and the new command being programmed), also reset the AUX
> controller on timeouts and synchronize pending interrupts to guarantee
> that there are no pending AUX transfers when the dw_dp_aux_transfer()
> returns.
> 
> Due to lack of a sink, which generates AUX timeouts, this change is
> effectively untested.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
> Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5+
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> index 7351b70bdac9..df0b98cbbaab 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
>  	if (WARN_ON(msg->size > 16))
>  		return -E2BIG;
>  
> +	reinit_completion(&dp->complete);
> +
>  	switch (msg->request & ~DP_AUX_I2C_MOT) {
>  	case DP_AUX_NATIVE_WRITE:
>  	case DP_AUX_I2C_WRITE:
> @@ -1491,6 +1493,12 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
>  	status = wait_for_completion_timeout(&dp->complete, timeout);
>  	if (!status) {
>  		dev_err(dp->dev, "timeout waiting for AUX reply\n");
> +		regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL,
> +				   AUX_RESET, FIELD_PREP(AUX_RESET, 1));

As this is just one bit, I'd find

		regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL,
				   AUX_RESET, AUX_RESET);

more readable. Same below with s/AUX_RESET);/);0/. Up to you.

> +		usleep_range(10, 20);

fsleep() uses udelay() for delays up to 10µs included. Is there a
particular reason to sleep ?

Please also document somewhere (the commit message is fine) where the
value of the delay comes from.

> +		regmap_update_bits(dp->regmap, DW_DP_SOFT_RESET_CTRL,
> +				   AUX_RESET, FIELD_PREP(AUX_RESET, 0));
> +		synchronize_irq(dp->irq);
>  		return -ETIMEDOUT;
>  	}
>  

-- 
Regards,

Laurent Pinchart
