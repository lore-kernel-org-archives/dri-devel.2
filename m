Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0271606A32C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnNYHsO6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0BC10E114;
	Sat, 21 Nov 2026 08:59:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A4910E114
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 08:59:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBA9940931;
 Sat, 21 Nov 2026 08:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5441F000CA;
 Sat, 21 Nov 2026 08:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795251576;
 bh=NCTFB5JRRg8EpNoDbg3P7LW5zydeMcq3Z/Cv9CKpzbs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bnNYHsO6BstHjlpOWSG1Wi1ZWC7yG+PzG2yWh2EyZY6jyhofF/sGA8f7GhbXJuJh8
 7oSoU0C3jfMuZJtw40NCbMUrlQuPDSi1bdnMlGXKewyhu+gxNLUVCfUAkWkPGRxfb3
 wpm0edZCt4xbudCwbeAW5t6zpsPHhuGwYezoZZyrbB4BcGX0QvLylS66WYP0uaYu4P
 UzgtkoWC2DKv7RCBbvs/bwHESZEVkKgNt1T+SWF39g0QF5gUAN1XJa/D1W9RODUseb
 9a3L8owqfmFHDUiALLvO3NcU3xtitpYmcP+oC5Cvl93Ahkgc3KDA7nIMZfPbxc6qGa
 dnaTxyg21qLXw==
Date: Sat, 21 Nov 2026 09:59:33 +0100
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
Subject: Re: [PATCH v2 1/2] dt-bindings: display: bridge: document TH1520
 MIPI DSI controller
Message-ID: <20261121-rampant-golden-urchin-ceb26c@quoll>
References: <20261119-th1520-dw-mipi-dsi-v2-0-9ab5f9808f87@iscas.ac.cn>
 <20261119-th1520-dw-mipi-dsi-v2-1-9ab5f9808f87@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119-th1520-dw-mipi-dsi-v2-1-9ab5f9808f87@iscas.ac.cn>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 11:50:44PM +0800, Icenowy Zheng wrote:
> T-Head TH1520 SoC contains two DesignWare MIPI DSI host controllers.
> 
> Add a binding document for them, referencing the common dw-mipi-dsi
> binding file.
> 
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  .../display/bridge/thead,th1520-dw-mipi-dsi.yaml   | 102 +++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 

I don't think this was tested. You use properties which do not exist.

Best regards,
Krzysztof

