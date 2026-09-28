Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7459C9833F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F318810E0A1;
	Mon, 28 Sep 2026 10:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GQ17o/57";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A0CC10E0A1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:05:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 047E3400FA;
 Mon, 28 Sep 2026 10:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4121F000FF;
 Mon, 28 Sep 2026 10:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790589933;
 bh=JJDJn44L9MIQQG6KNAreRHrg9uO+c4Os3eCJKsUQEJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GQ17o/57KF9lHOA44UeSTaHk7XtYerxCYLFcQxkJgT3B+b1rxMOjKd7tKnT04DUsl
 kUlNY/ezMrd9xbfDLY70jUnWLKYLNVEINxxeZvTvBZgTEc9bFBN9OZzxfvNrwD4UKR
 a37Vz3YOYDhM8LeHPrnCFT2BkmsfPqUUijXfSB78iw9Vn01y0Zpf/HXhjq0jYO20xk
 osgaS+Fj7XKs/UbIUhfaeyDQn3pjd5U84Vjs6U74Xpao+/NZnpe3VDW/8JrUgjGETw
 zfkmDYhaIMbZcZsktmM81+0GKCMmXYWayBD2wLnG/CjbhbVfW1amMGg2G9vTFywCPe
 YxqSsaOCkLZKA==
Date: Mon, 28 Sep 2026 12:05:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v1 10/27] dt-bindings: gpu: panthor: Document
 panthor-system bindings
Message-ID: <20260928-vehement-incredible-markhor-06685e@quoll>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-11-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922204535.2850094-11-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:04PM +0100, Karunika Choo wrote:
> Mali 5th-Gen AM GPUs expose an AM_SYSTEM block for GPU-wide control
> outside the main GPU register window.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Document the system node compatible, register and interrupt resources,
> GPU clock, and optional GPU regulator supply used by the AM_SYSTEM
> platform driver.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  .../bindings/gpu/arm,mali-gen5-am-system.yaml | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
> new file mode 100644
> index 0000000000000..f0689bb8f05a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright 2026 ARM Limited. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-system.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Mali 5th-Gen GPU System Device
> +
> +maintainers:
> +  - Liviu Dudau <liviu.dudau@arm.com>
> +  - Boris Brezillon <boris.brezillon@collabora.com>
> +
> +properties:
> +  $nodename:
> +    pattern: '^panthor-system@[a-f0-9]+$'

Nope. Why would we name devices based on driver?

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

Drop the nodename completely.

> +
> +  compatible:
> +    oneOf:

Drop

> +      - items:

Probably drop... but:

> +          - const: arm,mali-gen5-am-system

How can this be used alone?


> +
> +  reg:
> +    items:
> +      - description: System register

so just maxItems: 1

> +
> +  reg-names:
> +    items:
> +      - const: system

Drop entire reg-names

> +
> +  interrupts:
> +    items:
> +      - description: System interrupt

keep it simple, maxItems: 1

> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Phandle to the GPU clock.

Drop description, obvious. Can this be something else than phandle? Can
a single clock for GPU can be something else than GPU clock?

> +
> +  gpu-supply: true

This should rather be named based on the pins/domains. Are you sure the
domain is called GPU?

> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    panthor_system: panthor-system@68000000 {

Drop unused label

Best regards,
Krzysztof

