Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C637C531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B87A10F2A6;
	Fri, 24 Jul 2026 09:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ITGaH58d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5A010F2A6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 09:55:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC882600AD;
 Fri, 24 Jul 2026 09:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C7D1F000E9;
 Fri, 24 Jul 2026 09:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784886950;
 bh=4GIrrcMk6JokeZ01gAtuDEZ+WrIu9l+M5RXtW7uNr84=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ITGaH58diJxBCmPQEf5T5hV26voL5PB67MDmmpuIH5RvbU6N2GXDnPdgk6haJseSA
 rhVXxLl+ZRzrt59/yUulsmRuh9K6ICu4EGa7BO3e5FneKoWTU3RWwO2mDGOgUipoU8
 vygmtB+4zB9K0BxTIRUK7w7lES9vX0RKeJC0DA/2CzMpcRAqALLWKtxCq89BPaQ4OU
 TGEl+neuHtkaHDnJxFL7mUmUMUABQv6MF/axrSCwzDABLqQMG6tDIyLUzt16BAz9kz
 Oyb+j2nlcFx/rk6x6y0KYYzQBTMbW3RPcXaNUs1JfkXig63R7/h5FSPtxpmyiB+vZ8
 D/fiEhoeaLnCQ==
Date: Fri, 24 Jul 2026 11:55:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: Add Ampire
 AM-800480N3TZQW-00H
Message-ID: <20260724-debonair-brass-serval-e6bfc1@quoll>
References: <20260723-support-am-800480n3tzqw-00h-v1-0-6a4ae0575a19@bootlin.com>
 <20260723-support-am-800480n3tzqw-00h-v1-1-6a4ae0575a19@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260723-support-am-800480n3tzqw-00h-v1-1-6a4ae0575a19@bootlin.com>
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

On Thu, Jul 23, 2026 at 06:31:49PM +0200, Paul Louvel wrote:
> Add compatible for the AM-800480N3TZQW-00H from Ampire Co. Ltd.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

