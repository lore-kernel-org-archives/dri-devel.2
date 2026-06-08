Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEC2CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0424710F055;
	Mon,  8 Jun 2026 09:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Af5Tp8iL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885F610F054
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:29:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 365A043F19;
 Mon,  8 Jun 2026 09:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394A11F00893;
 Mon,  8 Jun 2026 09:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780910957;
 bh=45n2A6qyQl1Jvq/S527jcZdIuZO0U+HcYCRAYqjGBug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Af5Tp8iLuShsxL/rs/yDAjsQxog9in6RrGpw/flyw9wcDoMmJJEp0JSMcXm1MRRD8
 HthcoC8QkmVQsqTj1Nix5LD8fjEjWLxHci+FyrmT3Dj+DAFy0ibOPJqAa7ckGe/kug
 Sy+shmKuIxbJ2rGKuM4Q/lW4ZRS2TkcU0p70SyXxlK0UIXdhY7EiIZ/j7gxQj7RDMw
 ntrY8R0BZcI5S3roVUyCsPTbtGZOvYM+Gy63vOGaD8yAayVKcTgNdSKKP6UJrucEYx
 3GNArdyh3TdjxbHYAYVm1agYNlbe1XZjnroJmB+JoM9SjlIXTSlQpZVvrXTJ4+XBi5
 rflrNM41LA+3w==
Date: Mon, 8 Jun 2026 11:29:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Document Raydium
 RM69220 DDIC
Message-ID: <20260608-strict-flashy-peccary-b2c5da@quoll>
References: <20260605-asteroids-panel-support-v2-0-44b96c6eca91@pm.me>
 <20260605-asteroids-panel-support-v2-1-44b96c6eca91@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260605-asteroids-panel-support-v2-1-44b96c6eca91@pm.me>
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

On Fri, Jun 05, 2026 at 06:27:28PM +0000, Alexander Koskovich wrote:
> +
> +  dvdd-supply:
> +    description: Digital voltage rail
> +
> +  vci-supply:
> +    description: Analog voltage rail
> +
> +  vddio-supply:
> +    description: I/O voltage rail
> +
> +required:
> +  - compatible
> +  - dvdd-supply
> +  - port
> +  - reg
> +  - reset-gpios

Keep the same order as in properties.

> +  - vci-supply
> +  - vddio-supply

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

