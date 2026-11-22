Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF32606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=GL0q54Lr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B3A10E4C0;
	Sun, 22 Nov 2026 09:41:00 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A21810E4C0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 09:40:54 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-7086-3000--a06.rev.dnainternet.fi [IPv6:2001:14ba:7086:3000::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDD82ABF;
 Sun, 22 Nov 2026 10:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795340301;
 bh=yTMMp7PT3K2LyuvelR0MmDh6s2VsGr4kgwTbxEVPAwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GL0q54LrHkSn2pAjjFMO58LLdrGwbsOPFXG57oU5XxCd+1cPoP2nCvPVBSf7C9dxv
 TwU3KgbXpSkLaiHRp58caVX9suZEC3zznR0xZJI3ZJmN/2t9/W96BG8p9UYKDAh5Bh
 89KCH1L23XRTnHsOCB1YCLTR2uu+yfQ3WGQNisZ0=
Date: Sun, 22 Nov 2026 11:40:50 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Arun Iyengar <aiyengar1990@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Andy Yan <andyshrk@163.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>,
 Igor Paunovic <royalnet026@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Dmitry Baryshkov <lumag@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v12 06/23] drm/bridge: synopsys: dw-dp: Fix AUX transfer
 timeout race condition
Message-ID: <20261122094050.GB2739410@killaraus.ideasonboard.com>
References: <20261114-synopsys-dw-dp-improvements-v12-6-d42d3dc5bdd4@collabora.com>
 <179533990370.107225.5765165679182115805@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179533990370.107225.5765165679182115805@gmail.com>
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

On Sun, Nov 22, 2026 at 09:31:43AM -0000, Arun Iyengar wrote:
> On Sat, Nov 14, 2026 at 06:00:39AM +0100, Sebastian Reichel wrote:
> > @@ -1491,6 +1493,12 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
> >  	status = wait_for_completion_timeout(&dp->complete, timeout);
> >  	if (!status) {
> >  		dev_err(dp->dev, "timeout waiting for AUX reply\n");
> 
> This still drops a reply the sink did send when the IRQ thread runs
> more than 10 ms late. On RK3588 (7.3, KASAN on, v11 of this series:
> same 06/23), with a SCHED_FIFO hog at the IRQ thread's priority on its
> CPU (busy 40 ms of every 200 ms), 1410 DPCD reads gave 183 timeouts.
> Checking for the reply once more before giving up gave 0 timeouts,
> with 127 late replies taken:
> 
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1493,2 +1493,6 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
>  	status = wait_for_completion_timeout(&dp->complete, timeout);
> +	if (!status) {
> +		synchronize_irq(dp->irq);
> +		status = try_wait_for_completion(&dp->complete);
> +	}
>  	if (!status) {
> 
> Feel free to fold it in.
> 
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> 
> Claude (Anthropic) wrote this change; I reviewed and tested it.

There's something missing here. You may have reviewed (whatever that
means) and tested it (probably), it doesn't seem you've understood it.
All of this screams of a big hack.

-- 
Regards,

Laurent Pinchart
