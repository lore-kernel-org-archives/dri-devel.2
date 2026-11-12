Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC0606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpZr7Xb2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C22710E5C8;
	Thu, 12 Nov 2026 10:41:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A65110E5C8
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:41:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1BE6E4354A;
 Thu, 12 Nov 2026 10:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B501F00A08;
 Thu, 12 Nov 2026 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794480064;
 bh=beVVKqXDvt9rWFg1f2XfXUSimrRxV8SQAsJgMPdb5a8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SpZr7Xb2tehhmv+ltC8yM6qJnTFiElZ9jCp61z+4I4Ic/TZ69iyuTHpHRYjexgsul
 cU6sYVfpaZE5SdyxZuwvNKuSkm6X7H9EmaY26ezrJbfJ3+N9+TkCgNXGdCq09xHaWS
 cagU+IljbAMiwZtqfAJq/wKJdbW9Vx9eJAgI9k813kxw+39APTUmtAIubhY024I9h3
 WNVBc61ImVlLTD6XegDtoWkEXE5Ci9FIPqpDH/vHODmc9MZY2FvqCdgwY6qABUFrhW
 Xoq/Ic+hNQMs4d/aSXr/zMiNYzDkL4/eQ7X+Tgz3UiLp0mS3Cn1uZtf9ltpwESgU3c
 7qjM7lIsqwXsQ==
Date: Thu, 12 Nov 2026 11:41:00 +0100
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
Subject: Re: [PATCH v3 1/5] dt-bindings: display: panel: ilitek, ili9806e: Add
 Youritech et050fw01-kt
Message-ID: <20261112-gorgeous-favorite-gaur-b92df8@quoll>
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
 <20261111133119.1063210-2-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111133119.1063210-2-frank.obergfell@bytesatwork.ch>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 02:31:15PM +0100, Frank Obergfell wrote:
> Document the vendor prefix for Shenzhen Youritech Co., Ltd. and add the
> compatible string for the Youritech et050fw01-kt panel.
> 
> The Youritech et050fw01-kt is a 480x854 MIPI-DSI LCD panel with
> physical dimensions of 68 mm x 122 mm, driven by an Ilitek ILI9806E
> display controller.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml      | 1 +
>  Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
>  2 files changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

