Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0525C98328
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD8110E774;
	Mon, 28 Sep 2026 05:37:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XkjvhMfR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79ACC10E774
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 05:37:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6883B600E2;
 Mon, 28 Sep 2026 05:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257B91F000FF;
 Mon, 28 Sep 2026 05:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790573834;
 bh=8QhxpW00yraLjdsyXjafndt02JRMMBCzVdcuQl77r+s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XkjvhMfRfahuE79Gj1oGilaIo+aVnkpFIqwL9/vgwvfn1KREvgOHru0lQB08u6ssL
 WFOQHHkAFbjMIbqCu9FlJYQK8Totuh9O6tSg8Lnzq6ltw+hqHWxXvl3P8f+Ed5Vo9Y
 8qFLKTzh7rqofkmB6cuDhGZnKMB6kOGEzmynhnbnqDr+m2fFTDc9hMVKbJNUOykU36
 RlwPrMqYwV9hAdDxvrWIq3NwWEKxSxlo4MHk8lNAlqR3kSys2agzmaTzcur1XdTxDp
 5AjlaSO5pELgXbE3CHhAGRNfDeUIfNQZGoqeC26gvVa9TPkZLfkDKI9T4UJxEGCRAO
 RHeOh8oV+QTAQ==
Date: Mon, 28 Sep 2026 07:37:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH v3 01/18] dt-bindings: power: Convert Ux500 PM domains to
 schema
Message-ID: <20260928-rainbow-adventurous-otter-3aa6a7@quoll>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
 <20260921-ux500-power-domains-v7-1-v3-1-9352be6b86b1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-1-9352be6b86b1@kernel.org>
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

On Mon, Sep 21, 2026 at 12:48:07AM +0200, Linus Walleij wrote:
> +description:
> +  The UX500 power domain controller gates power to one or more peripherals on
> +  the SoC. Domain specifiers use one cell containing one of the DOMAIN_*
> +  indexes defined in dt-bindings/arm/ux500_pm_domains.h.

Use rather full path, so include/dt-bindings/arm/ux500_pm_domains.h

> +
> +allOf:
> +  - $ref: power-domain.yaml#
> +
> +properties:
> +  compatible:
> +    const: stericsson,ux500-pm-domains
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - '#power-domain-cells'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/arm/ux500_pm_domains.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pm_domains: power-controller {
> +        compatible = "stericsson,ux500-pm-domains";
> +        #power-domain-cells = <1>;
> +    };
> +
> +    mmc@80126000 {
> +        compatible = "arm,pl18x", "arm,primecell";
> +        reg = <0x80126000 0x1000>;
> +        interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&pm_domains DOMAIN_VAPE>;
> +    };

Please drop the consumer from the example (thus also arm-gic header).

With these:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

