Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FF6C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A5D10E654;
	Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UtjX7y1c";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7384210E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:30:57 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca8758e7e94so26228a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786195857; x=1786800657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6zYCYgrPHJ1R0IyDM9ZJHQW95fmf52/M7XVvd8snhDU=;
 b=UtjX7y1cHeAzvB7F2x2IpZZ7WSH7Tey3nI0woqSqUjjuOyFDjNlPRuSbb8rRJi2OmD
 MYlQU1LTZTt7S6iFLcWuemn2W9x7mD3HlTYpvHaJqnvP9Nmp0beITsUDXTU/AVCjobQj
 jhJW2VAZe7g80m+WTtVTIa5qYgLCehPsbDPbVKlt1DB1xGCM6rz3dUBP4GKP1pcqeZIt
 tru05FBhZ1ny9O+GC73F3e68j4rDo3WPKZqQtXNogzeYXdhaFmKpIu8imx94+zkwo7lX
 Yo0C/c9y2OkluRIYSvC0A/Y15qZnpYvIzqdKPQLbiSJJBKIMeeFk3N92jSeaAy8p75QR
 nkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786195857; x=1786800657;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6zYCYgrPHJ1R0IyDM9ZJHQW95fmf52/M7XVvd8snhDU=;
 b=WHqdhbCQyDsoME2y84Uo8w0j3ipyXhphKjEVR7IvaMWI4cZ3LnnTOeLHutiSR2MJxa
 vYlt4HrqmvzYAD6cGQwpGDljHk9eQVz+zZkojUX/1K5ALkDztXcTILKjPl9A8EDj7In6
 QZontQJtgxlX5lWdU2Kn5IxS0dE+gb31z/O1+rzYgodU+41/6U2gNI7jAqNwH2z6mwhp
 HCSAVZuCL/CYCtfeVItg1qDYRRuNWw0qxJycr6ffILIc8jcIVbIwcGwuEfVynom9A80m
 Noj9tlObWPlWTFMiRq8GTr4GEd3+3DE5Dw+PX76T6hy8REomrhQN22f8574ChO2GEVIH
 81xw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rokc9Tavj09bkY27fHGaJVSIc0yroJK04q6/FVIUaN4G2cEGuRAAV8D3zcUO1RhmYz+M8ttMW8bOgQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw71sNTssE/SFy6qyWA3JGNRVF7V7GfiTYbahxa55z+1jC04FKV
 /n59r4FUfLdZrfvWQnFM6NAZEax1MrR/WgnEFZFVi5ureyks38C/7Fk8
X-Gm-Gg: AR+sD13MVLZZ5I7n5jeCBHXP67U06ufzaptFfJKTyw88MCbG5kZxaPX6YnP5dsH4w1n
 QzCEdiNTAGMXaEhVlEwHlqCzNmPvcYs37AXmThHFIsgbnuC6Q4h3C7E5J7Wi2J4QASrlo1A70NY
 1jLPIP2iXXkwXqC4SqrUmAWfNbhJhHy5kWWQC/xxbTSDK7nro34xlRioxlPgTZod92iw5fvRV0v
 c+E6dzEmc+cNWVQoojhzvZti72KJnR6c7QBzTwxFF5jG7w+I7jrz/Gh1jAJg2gtr7bFgEtovPy/
 P6IuPLCpXqZw6MklSg87yWh9XvZBuRLrfbYBw0+sEQcC13gXN5ct+dLg4ugkF2HQ+aFrN+bT1iR
 /Vc1uDB/I3bib5lpM96Cn/yOZ3BXIb8qp2uYKTFlTP+KwULSaMDVMY1/zmz0xmx3LNYgChb3Eau
 rqXn7Ykj6IcXEt2d+Zvz2pfVd3t/K9dT3NpkZ6uqSmluhhQ9g3Pw==
X-Received: by 2002:a05:6a00:240c:b0:842:3838:cb03 with SMTP id
 d2e1a72fcca58-84f6b778b44mr5395163b3a.11.1786195856790; 
 Sat, 08 Aug 2026 06:30:56 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a51e9a9sm2125357b3a.37.2026.08.08.06.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:30:56 -0700 (PDT)
Date: Sat, 08 Aug 2026 21:30:52 +0800
Message-ID: <b66d3009f9cf310ca0f068999bd475ac.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 12/17] drm/spacemit: add Innosilicon DP/eDP
 controller bridge driver
In-Reply-To: <5537a40f12e80b89e330f37032016de6f3b9f4c7.camel@pengutronix.de>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-12-6de34d80e86c@gmail.com>
 <5537a40f12e80b89e330f37032016de6f3b9f4c7.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Philipp,

On Mon, 27 Jul 2026 09:49:58 +0200, Philipp Zabel wrote:
> On Sa, 2026-07-25 at 00:51 -0400, Cody Kang via B4 Relay wrote:
> > From: Cody Kang <codykang.hk@gmail.com>
> >
> > Add the DP/eDP controller that sits downstream of the Saturn DPU. Two
> > identical instances share one compatible; the eDP-vs-DP role is board
> > wiring, so it is taken from the devicetree: an eDP panel always sits
> > under an aux-bus child node, an external DP connector never does.
> >
> > The link is driven through the generic PHY framework, so the controller
> > never touches a PLL register. The controller's HPD interrupt is gated by
> > the DP pixel clock, which can be off exactly when a plug has to be
> > caught, so the connector is also polled and the interrupt path re-reads
> > the live level when it does fire.
> >
> > Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> > ---
> >  drivers/gpu/drm/spacemit/Kconfig            |   19 +
> >  drivers/gpu/drm/spacemit/Makefile           |    3 +
> >  drivers/gpu/drm/spacemit/spacemit_inno_dp.c | 2443 +++++++++++++++++++++++++++
> >  drivers/gpu/drm/spacemit/spacemit_inno_dp.h |  328 ++++
> >  4 files changed, 2793 insertions(+)
> >
> [...]
> > diff --git a/drivers/gpu/drm/spacemit/spacemit_inno_dp.c b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
> > new file mode 100644
> > index 000000000000..e88731d9b18b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
> > @@ -0,0 +1,2443 @@
> [...]
> > +static int inno_dp_probe(struct platform_device *pdev)
> > +{
> [...]
> > +	dp->reset = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>
> Since this is only asserted in probe and deasserted in remove, you
> could use devm_reset_control_get_optional_exclusive_deasserted() [1].

Thanks for the review. Will do in v2. The binding marks resets as
required, which means I shouldn't use _optional in the first place.
I will use the non-optional devm_reset_control_get_exclusive_deasserted().

> [1] https://docs.kernel.org/driver-api/reset.html#c.devm_reset_control_get_optional_exclusive_deasserted
>
> > +	if (IS_ERR(dp->reset)) {
> > +		ret = dev_err_probe(dev, PTR_ERR(dp->reset),
> > +				    "failed to get reset\n");
> > +		return ret;
> > +	}
> > +
> > +	dp->pxclk = devm_clk_get(dev, "pxclk");
> > +	if (IS_ERR(dp->pxclk)) {
> > +		ret = dev_err_probe(dev, PTR_ERR(dp->pxclk),
> > +				    "failed to get pxclk\n");
> > +		return ret;
> > +	}
> > +
> > +	if (dp->edp_mode) {
> > +		dp->bridge.type = DRM_MODE_CONNECTOR_eDP;
> > +		/*
> > +		 * OP_DETECT is required: without it
> > +		 * drm_bridge_connector_detect() hard-codes CONNECTED for any
> > +		 * eDP connector and fbdev wedges at bind.
> > +		 */
> > +		dp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> > +				 DRM_BRIDGE_OP_HPD;
> > +	} else {
> > +		dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> > +		/*
> > +		 * No OP_HPD: the HPD interrupt is gated by the DP pixel clock.
> > +		 * Leaving it out marks the connector POLL_CONNECT |
> > +		 * POLL_DISCONNECT instead.
> > +		 */
> > +		dp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> > +				 DRM_BRIDGE_OP_MODES;
> > +	}
> > +
> > +	if (dp->reset) {
>
> This check is not necessary, reset_control_deassert() handles NULL
> pointers.
>
> > +		ret = reset_control_deassert(dp->reset);
>
> If the _deasserted() variant is used above, this can be removed and the
> reset control doesn't need to be stored in dp.
>
> > +		if (ret) {
> > +			dev_err(dev, "failed to deassert reset: %d\n", ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> [...]
> > +	return 0;
> > +
> > +err_clk:
> > +	clk_disable_unprepare(dp->pxclk);
> > +err_reset:
> > +	if (dp->reset)
> > +		reset_control_assert(dp->reset);
>
> Same as above. Remove the unnecessary check or manual assertion
> entirely.

Agree, all of these will be fixed in v2.

Cody
