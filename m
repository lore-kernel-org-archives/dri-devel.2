Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E14606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X16lf80J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3621C10F612;
	Tue, 10 Nov 2026 12:00:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 784CC10F61F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:00:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76A8D638CF;
 Tue, 10 Nov 2026 12:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8291F0089F;
 Tue, 10 Nov 2026 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794312044;
 bh=zUUByBFtkt/Jci7QtZBEH6HXtzxT/EGP+IqF1P78chE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=X16lf80J1m+1AsWIYir0Vl7RvVpSQ+oJ9AkM5SwanRE5YGB74h2/wXyTcc2m0NmKM
 MHCuUmySy6FJ+PVUuW/ighENEGvCQdMsmEccv8w7rQdg32dULc6QIFz45WXEMCcqAS
 /mWu817g0VKcvN+7IM9oOIcdKy8x1Ls+z2PHPZni1XN5X7UkZQmA5CQ5DctuqcpcNY
 +Cm/AmiB/FEwoRA8Bl69mYRTCAwlEexYkMGb6fGT3MLtQo6l++9hQVSKAObQ5TMFh1
 Km2SYdSM8KPsWzCDVOMjNUHcGTKV/mydxrOAO63HhiUGfFtZGsXYuiZHrWKxiATZ70
 yNVJ2y322F+ZQ==
Date: Tue, 10 Nov 2026 13:00:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Romain TISSERAND <romain.tisserand@gmail.com>
Cc: Igor Reznichenko <igor@reznichenko.net>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 1/3] dt-bindings: display: panel: ilitek, ili9488: make
 the port optional
Message-ID: <20261110-comical-adder-from-saturn-8c8fbb@quoll>
References: <20261109160706.2272332-1-romain.tisserand@gmail.com>
 <20261109160706.2272332-2-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261109160706.2272332-2-romain.tisserand@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 05:07:04PM +0100, Romain TISSERAND wrote:
> The panel is a MIPI-DSI peripheral, a child node of its DSI host, and the
> driver does not use a graph port. A port is only needed when the host
> links its panel through the graph; other DSI hosts, such as the Allwinner
> sun6i-a31-mipi-dsi one, link the child node and have no output port to
> point at. The PinePhone panel is described that way on the same host,
> without a port.
> 
> Keep the port allowed (panel-common) but no longer required, as for other
> DSI panels such as ilitek,ili9881c.

ilitek,ili7807s and a few others have the same and it is confusing. The
port should be required when this is connected over SPI or I2C, but not
for MIPI DSI. I think that for MIPI DSI port is meaningless so actually
incorrect.

Why was it added in the first place?

> 
> Reviewed-by: Igor Reznichenko <igor@reznichenko.net>
> Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
> ---
>  .../devicetree/bindings/display/panel/ilitek,ili9488.yaml        | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

