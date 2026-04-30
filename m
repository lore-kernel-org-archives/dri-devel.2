Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82022FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EFEC10E42C;
	Thu, 30 Apr 2026 08:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U31Bp+Aa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0221310E42C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:52:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 03B0960180;
 Thu, 30 Apr 2026 08:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225AFC2BCB3;
 Thu, 30 Apr 2026 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777539163;
 bh=u545+Ezl95chpjeL8Alf9JRet/fhJTbzn6AdcvXJRR0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U31Bp+AaKSjV9qvCEmBiZyCDFj8wqkn71QzWNqtMh1lfRlPNjM7XVFP2P1tfJlPh0
 o8QE0GNsiqpugdduwlezvg8SDHO0xGf3WNUOKu3aDHEm1mdIquheAhOdz4fl+cViu4
 1uLRHSOtGltJSWF2/bElKyXatrK4db9j8SI0mEVcUr3sUV+VMuGfqb45PrrFrMdzcZ
 /Zepegd0tekyMG8H2APX4NPXwx6x/um+a99BaziS2HCvDa/uPU9zTp6+bOVRCIYTn+
 EVgn5qZjIEfbuguA+KaYDATc68k5tu/yPh5/GVurDqIekWJu+inQaMalbtHNeq/tA+
 yCTl0LlEx9Ugw==
Date: Thu, 30 Apr 2026 10:52:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: William Bright <william.bright@imd-tec.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: panel-simple-dsi: Add Team Source
 Display TST070WSNE-196C
Message-ID: <20260430-notorious-delicate-skylark-f9ad2e@quoll>
References: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
 <20260428-imdt-dsi-display-v2-1-cf7294b5d7d6@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428-imdt-dsi-display-v2-1-cf7294b5d7d6@imd-tec.com>
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

On Tue, Apr 28, 2026 at 04:17:24PM +0100, William Bright wrote:
> Add device tree binding documentation for the Team Source Display
> TST070WSBE-196C, a 7" 1024x600 MIPI-DSI TFT LCD panel
> using an EK79007AD controller.
> 
> Signed-off-by: William Bright <william.bright@imd-tec.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

