Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C818606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pardini.net header.i=@pardini.net header.a=rsa-sha256 header.s=google header.b=OwS5m4Yz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2038710E714;
	Sun, 22 Nov 2026 17:15:53 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0BF10E0FF
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 11:46:11 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2862775a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pardini.net; s=google; t=1795261570; x=1795866370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5bq54PBPl4YCnVxEmHl/CCwjoHYf0FGqHDDIF9WweFI=;
 b=OwS5m4YzhljEGLiH/g7WVzJEvTSbdek/WgnzQncLnLgVHMsQbmQp85vYeG2xJ4EPNM
 1OhjEDx5Dm8fLaEnlHvUAjOoRbZKCkEFRCfbMspZCOjAsH0WdbrChLWJjAibS0h69N8r
 xhozUEK74l0VtV0oNOgtOs56SACRf9RIYDRWYbfSChib/GbfpGQV0TC10cQ12Pg7YNXb
 hGyCCxCMDyp6MEe9dAMR3EnI2ioRh1d+3pqAO2mFLe153IxLijsWEgwM5Q16FfWxRqv/
 yaZ3Q5BDCRRNa9b3CVUQEKS3N/+acPUX1wdWKpTmJM3wD22gpj19QRrjo8YOibAaW0c5
 7NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795261570; x=1795866370;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5bq54PBPl4YCnVxEmHl/CCwjoHYf0FGqHDDIF9WweFI=;
 b=st3dPCoqT5TiaJQF+u4BWq/k0fsrWM+YsoMUggxwzNAYkDqdS9bN6kBSe5Er3yGE2v
 XsZp+KHd9Dudr6dLgQRbAwGTH8rqhiWkSkJacgiyIeQr4IybDmAz7bMIgmVEtzXu5i7+
 wj1Jy/jIR9CmzT18yXKfzdi5W0taN1ZW7cCukDV2QiF4W9iMVRHNId+sSfvKiM8Vlocm
 gp+UV2kC/nKc92RLoaOVwXxJhvu9suuJmm82+yhq9BnBGIRRc48j8UoAMu7SgYiQ5nMO
 BUK03pwoW7ZtRjq4w1qE5tEdJJ7jFfFPOwGcY+rmzpSdw0o6ymX6taO6Q38j1vvFITV4
 v+LQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF1PXfmKKA1df3LWLbkNAqH1vXCUa4fBBpRJzjxEZWm2tmr9ChmTKqbARIjN9abIvLbjvVj67siVz4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/P0SSVVuavKQ+zvu5D4PoXvbt8dgtgCIHQIbqmfmcBwq1ix6uO
 lcTlWtrDUID88KfctLLpuPZqnOdjcCLxKvEr0OLco2ilXLdVXoTeZ88vLlzyREJzYg==
X-Gm-Gg: AZFdTZdO2fhCEPr79Muus9pcXmoN2TepzdGcB/Uir3GQkZd5dAt5NTtTqjSZYJ8exeM
 FRsbLGsqDts1abuvJlxWBtgNGJoZ226ECnIGBeKUlsWdRqacH4rGLUopBnC+64PxMYLqC9B32W2
 Ej6lGRXDJRIrCUESXDwTjEdEg2IjcvLT0nafUzgM00QbZIHJahGn7yYlbl3A+KaOOk5DiZLzOIg
 px1CeysF8M+zghBP1pvQOnhNS57QNbJltR6/6c0Z/ooTTvKWow0MFaxl/IwGTBaAjyJSx6z0OYJ
 qAHKGp+1ALR9ppffRmuROAFBs0cRo8EiU5FIeXzoe66sOnniRhPQ3eWHXnlmnvXZZsrGw2pvo0E
 zbyiP8EzFpVj/QP82XA9K/6v105zCr8uE4jgF99763JkPZEueMcOcmf5DCHhFe/xRFMdLSM6Yxp
 dwJ6Vkrrp8Qi+4IP+gWpLDjsm5JDian8P67gF372XyS5q4yH3bj8qvoIKW1hW4WmCsRIOC9G5oF
 Q+PjLuKWbnVdOD06wedux1cEg0C0H9DVQmwH4TNi64gWTh3fGst8fJzSpaY5WUBY1HN93uwscaD
 T/L12bdr6OzFF0BT2Zn/VYBBDIY30OfzJyX4EzeM5qjq1ZUyoXus1DK/ePBzAGEuQKngfCsGyRv
 0Vp5lBXG3uWs7mtaLeJYxk0y+7TyS3rUlr3kMLHMP4SMqmTqbYWPpIXhxVAXhVmmAdlcj1j0GC/
 b0
X-Received: by 2002:a05:6402:134a:b0:6b9:c43e:19fb with SMTP id
 4fb4d7f45d1cf-6ba37d632e0mr3291804a12.25.1795261570200; 
 Sat, 21 Nov 2026 03:46:10 -0800 (PST)
Received: from ?IPV6:2a02:a466:4d7a:0:409e:13f1:8f3d:aa19?
 (2a02-a466-4d7a-0-409e-13f1-8f3d-aa19.fixed6.kpn.net.
 [2a02:a466:4d7a:0:409e:13f1:8f3d:aa19])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba854bed08sm173298a12.30.2026.11.21.03.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 03:46:08 -0800 (PST)
Message-ID: <9e4c3ed3-812c-4ad4-aab8-b1a783cec95e@pardini.net>
Date: Sat, 21 Nov 2026 12:46:07 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/23] Synopsys DisplayPort Controller improvements
 for Rockchip platforms
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, Sashiko <sashiko-bot@kernel.org>,
 Igor Paunovic <royalnet026@gmail.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Yury Smirnov <yurymonzon@gmail.com>
References: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
Content-Language: en-US
From: Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <20261114-synopsys-dw-dp-improvements-v12-0-d42d3dc5bdd4@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 22 Nov 2026 17:13:42 +0000
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 14/11/2026 06:00, Sebastian Reichel wrote:
> This patch series updates the Synopsys Designware DisplayPort bridge
> together with the only existing user: The Rockchip RK3576/RK3588:
[...]

Thanks for the series! Tested on a Mekotronics R58X-Pro (RK3588) on
v7.4-rc3 (it needs 941e3acfb358 from linux-next to apply there):

- dp1, full-size DP: Dell U3415W at 3440x1440.
- dp0, DP alt mode through usbdp_phy0 + FUSB302 with an Apple USB-C
   Digital AV Multiport adapter (A2119, pin assignment D, HBR3 x2):
   1080p60 on a small HDMI monitor and 3440x1440@50 on the Dell's HDMI
   input. Works in both orientations, and out-of-band HPD retrains the
   link after a flip. With the adapter plugged in at boot, this also
   needs your "drm/connector: Cache out-of-band hotplug events".
- Audio on both outputs to the Dell's speakers, over S/PDIF
   (spdif_tx2/tx5, simple-audio-card, mclk-fs 512, DAI 1). It also
   needs a clk core workaround I am not sure about: AUPLL's assigned rate
   rounds to the current rate, so the S/PDIF frac notifiers get
   PRE_RATE_CHANGE without POST_RATE_CHANGE and leave the muxes on the
   gated fractional divider; no DMA requests, EIO.

Tested-by: Ricardo Pardini <ricardo@pardini.net> # Mekotronics R58X-Pro 
(RK3588)

mvg,
Ricardo

