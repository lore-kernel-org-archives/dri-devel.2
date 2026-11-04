Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787CC606A864
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Bg9GoV+Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85E210E8C9;
	Wed,  4 Nov 2026 20:38:18 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85BE710E8C9
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 20:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793824691;
 bh=ZyQWW1wCUyxgX5lh8xj5l7gQjS6rGe83Ig2v6D8kRco=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Bg9GoV+ZPTgROm1ZJusnJY1kYsZvbhM+sKMBFfy3xgpe4rP+DGeHre8m1lwwQAC0i
 WWnjnjILknGW5VX4vv8B4DXAeG5DsbqPgHWBYEz9p0ffJmThorskM1KObk16V8z16t
 utNEtiEzwKBu6NgCPhWN+5NQbbRk8cVQ0bjYK1WmQAC3GyNmbx+Lum+WEXBJl2tXNN
 WOYjWTpf827xMUS8KxuHHsvVNJ9WWtK13OTWw1Ajg5KkbGa6c2G+vkpt64h0/rJ/Vy
 PwrMheYZy2Jhat0yZQYrpwQcjfO6dtf0+U6sCMGE00RuMIU46p3hVaPZ5I+nVbrp1X
 ccio0OVYj/FjA==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0687B17E066C;
 Wed, 04 Nov 2026 21:38:09 +0100 (CET)
Message-ID: <c823ced3-693a-4620-8a88-81cca7062c01@collabora.com>
Date: Wed, 4 Nov 2026 22:38:09 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] drm/rockchip: vop2: Avoid DCLK source switch for
 10-bit YUV422 output
To: Daniel Stone <daniel@fooishbar.org>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Daniel Stone <daniels@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, kernel@collabora.com,
 Andy Yan <andyshrk@163.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
References: <20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com>
 <20261014-dw-hdmi-qp-yuv-v5-8-6fab0fe43a9b@collabora.com>
 <CAPj87rPsh_cVQWtGEisDrXWiT+Zj6D6n5wXpmbuoFvMKtOi7TA@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAPj87rPsh_cVQWtGEisDrXWiT+Zj6D6n5wXpmbuoFvMKtOi7TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 10/30/26 1:42 PM, Daniel Stone wrote:
> Hi,
> 
> On Tue, 13 Oct 2026 at 23:51, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>         if (vop2->pll_hdmiphy0 || vop2->pll_hdmiphy1) {
>> -               unsigned int bpc = vcstate->output_bpc ?: 8;
>> +               /*
>> +                * YUV422 always transmits two 12-bit components per clock
>> +                * cycle, regardless of the color depth, which from a rate
>> +                * perspective is equivalent to three 8-bit RGB components.
>> +                * Force 8 bpc here so the bandwidth check reflects the actual
>> +                * TMDS rate and avoids an unnecessary DCLK source switch.
>> +                */
>> +               unsigned int bpc = vcstate->output_mode == ROCKCHIP_OUT_MODE_YUV422 ?
>> +                                       8 : (vcstate->output_bpc ?: 8);
> 
> The nested ternary is pretty violent; please write it out explicitly.
> Either way, the equivalent clock adjustment for YUV420 is handled in
> the setup_intf_mux() handler, so would it be better for YUV422 to also
> live there, rather than mashed in with bpc here?

Moving YUV422 into setup_intf_mux() wouldn't work, because that function returns
the real DCLK rate.  The YUV420 halving there is justified, but for YUV422 the
DCLK simply equals the pixel clock.

What's actually not great here is the bandwidth check, as it tries to rebuild
the TMDS rate from DCLK.

Apart from the YUV422 special handling, there's another complication: when vop2
processes multiple pixels per clock cycle, DCLK is only a fraction of the pixel
clock, e.g. RK3576 halves it for pixel clocks above 600 MHz.  This will
interfere with upcoming HDMI 2.1 support - e.g. FRL mode such as 4K@120Hz 8-bit
RGB, with a pixel clock of 1188 MHz, ends up with a 594 MHz DCLK, which slips
under the limit and wrongly selects the HDMI PHY PLL as DCLK source.

I've reworked the source switch logic to rely on the actual TMDS character rate
computed by the HDMI connector state helpers, which already accounts for the
output color format and depth.  It gives the same result as today for RGB and
YUV420, corrects the behaviour for YUV422 and upcoming FRL, and removes the bpc
handling entirely.

Thanks,
Cristian
