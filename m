Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA062606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ny7X4Hvn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D03A911202D;
	Thu, 12 Nov 2026 10:41:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C74110FFEF
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:41:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DFA260D68;
 Thu, 12 Nov 2026 10:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D83D1F00A05;
 Thu, 12 Nov 2026 10:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794480096;
 bh=ZP3U5tKFMTHhfEkSOkzIHCLH+O/mUp11WA5Kb/PScQc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ny7X4Hvn9UH6mVup1UvEbkAfGc8JY7VlNNNI96Rh8wwN1bR0EwV4gzt8yE+wqa/8r
 oF5fVa29etzTNaKAy2YFBaeku48E1mY07UDW65GViK2gQOq3h2y/ZTXQ7V9b+zMIJR
 /xaYSk9mqAXQzWRMgbmjxUrtEL60BJ8U79nESmxJvPqfA6zYl0FKsxIIrBCj65czpo
 JseNY5/q1Yy2av2SqkHLCDr9k1PG+D3Kx7PXkKJBC54BqxM0mQKD+GyG7L7VGhI1Px
 BWxrlY7uEVtl6B08t8IPWbz3pNrXrTecf4zGnvQPSku6vZe0qhvEHV62uYgKYD2oty
 QrtzyroSYsGcA==
Date: Thu, 12 Nov 2026 11:41:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Obergfell <frank.obergfell@bytesatwork.ch>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: arm: fsl: Add byteENGINE i.MX93
 platforms
Message-ID: <20261112-acoustic-natural-koel-053ef8@quoll>
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
 <20261111133119.1063210-5-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111133119.1063210-5-frank.obergfell@bytesatwork.ch>
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

On Wed, Nov 11, 2026 at 02:31:18PM +0100, Frank Obergfell wrote:
> Document the vendor prefix for bytesatwork AG and add the compatible
> strings for the byteENGINE i.MX93 System on Module (SoM) on the
> byteDEVKIT carrier board.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml         | 7 +++++++
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  2 files changed, 9 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

