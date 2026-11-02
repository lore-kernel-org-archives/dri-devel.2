Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D438D60A2636
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Se/JwnRU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B89710E5DF;
	Mon,  2 Nov 2026 11:28:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429D210E5DF
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:28:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EDA5043B2B;
 Mon,  2 Nov 2026 11:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B841F00A18;
 Mon,  2 Nov 2026 11:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793618905;
 bh=YAj/j/4efbhabnnhYe0OawMFMjQPvNoehqB7lBM/oH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Se/JwnRUSvAI174uNSFWm8zut3t4wPxKX5b6eyWLnlfmxFJ3gkN6dGEFZP668euNQ
 OvJYYgJz4nE29c3PBg8TbI/Umvjs0TK8ynMEiLVIgqDsz7l2kU9HQp+ClIUHBtpR91
 x5lS7QhfHyQ953vDyfEQjpGryIcog9WtJ87zbvsoRHiaM6LyQyH7p+fxlzw9wPKzKt
 QBp5oHWfuF1z3Wb2VPyhiBXYb9SAtKTpUFfFj+fCg3opeWkwuw4jdb7P6bJ+1SCAd+
 MU76NXBDYCFd3JJKikrSpY2LrsUKOOZXt/LnFpddxT7kXRQXUhVwWtpeMA2h9IXDRw
 BZesqZeokXJ4Q==
Date: Mon, 2 Nov 2026 12:28:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 Icneowy Zheng <uwu@icenowy.me>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 1/3] dt-bindings: display: bridge: document TH1520 MIPI
 DSI controller
Message-ID: <20261102-spry-snobbish-hound-384cae@quoll>
References: <20261030-th1520-dw-mipi-dsi-v1-0-753f34fd304f@iscas.ac.cn>
 <20261030-th1520-dw-mipi-dsi-v1-1-753f34fd304f@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030-th1520-dw-mipi-dsi-v1-1-753f34fd304f@iscas.ac.cn>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 03:47:49PM +0800, Icenowy Zheng wrote:
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DSI controller APB clock
> +      - description: PHY configuration clock
> +      - description: PHY reference clock
> +      - description: DSI controller input pixel clock gate
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: phy_cfg
> +      - const: ref
> +      - const: pixel
> +
> +  syscon:

Such property names are not allowed. Missing vendor prefix, missing
descriptive name.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the VO subsystem system controller.

For what purpose? How does this device use VO? What is VO subsystem
system?

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - syscon
> +  - ports

Best regards,
Krzysztof

