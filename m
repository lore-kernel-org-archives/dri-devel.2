Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAD6EBFD03
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF8F10E31F;
	Mon, 13 Apr 2026 06:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SYNH6BTE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32B010E31F
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:52:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AAF7408DE;
 Mon, 13 Apr 2026 06:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE24C2BCB1;
 Mon, 13 Apr 2026 06:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776063121;
 bh=zUqAAQfxQkgm1L+orXnWkgiT2yfCQDcQl2Ic8bOCAt8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SYNH6BTENC4BdUvaXolabjGi1gFboGAhzv/4yOxAfwDslD7CrfvkgvvWqQmC2+10C
 TpTM4WTvIOMMpAjcE09IBwNeGgsCZKf9/6D0jL7HQbj3K79SYBJ95tmJWhvp2wbR5L
 AZ3CN0ENARZ+Oe7uGXq40Q8UzJ+rD0lr/1/FlLG1ch6rx4zYns3cNXNG8RnYtJCiCg
 FvwBzKLd+vqxR2a/sKGHNmcoebIMHjleFBPx9/ZUx+d6fLwcqgUtnWhGxRpK2h/1vB
 xh1nWhy3IacGpAXO6Dp4iEogQ2GYElSQj/zazf0q6xaHIvKCmMXo7btkINAKT/3Zaq
 BQ/jC9upJd/mA==
Date: Mon, 13 Apr 2026 08:51:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Joseph Guo <qijian.guo@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: display: waveshare, dsp2dpi: describe
 DSI2LVDS setup
Message-ID: <20260413-thick-lionfish-of-dignity-19d6e9@quoll>
References: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
 <20260412-ws-lcd-v3-1-db22c2631828@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412-ws-lcd-v3-1-db22c2631828@oss.qualcomm.com>
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

On Sun, Apr 12, 2026 at 08:32:24PM +0300, Dmitry Baryshkov wrote:
> Several the Waveshare DSI LCD panel kits use DSI2LVDS ICN6202 bridge
> together with the LVDS panels. Define new compatible for the on-kit
> bridge setup (it is not itmized and it uses Waveshare prefix since the
> rest of the integration details are not known).
> 
> Note: the ICN6202 / ICN6211 bridges are completely handled by the board
> itself, they should not be programmed by the host (which otherwise might
> override correct params), etc. As such, it doesn't make sense to use
> those in the compat strings. I consider those to be an internal detail
> of the setup.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/display/bridge/waveshare,dsi2dpi.yaml    | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

