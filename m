Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CDDC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A1010E909;
	Mon, 28 Sep 2026 10:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLYQInke";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF12610E909
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:06:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8A674065E;
 Mon, 28 Sep 2026 10:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4AF1F000FF;
 Mon, 28 Sep 2026 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790589978;
 bh=H7XMA2MyPtBGtHXeBa0Gg30v8MrdMWY70pIih3+O+nU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nLYQInke1hVftuPeMgwThpqe0Mjj+b2eCbhn3arNW0/pCnjLOpz8fNXhTQRnNHWtV
 e0vY4gCSvnrGfhJKvp9MwAUeB59vS+fAX8GcN+llR6iY9WfbtQN4j80fSAo7yhbbUE
 4/RvgUctm2go+NN9Qxw4YUcQtLwgL2SS8emeN2q9uVV056i4mm5M0uY0v7sqn2IJHM
 c8IyXw5/FzyM7wjyweR2F0cMUsaQHIHHZDzpwQZPSWIp+4tHBou0zJfhz3YMZZ5HPl
 AwvyRtkn0hCWEevXo+k1krz40W2Pz6eksAPd5UabC/SvB/GJ2FK/D+gG9oAE3HflQq
 EBv81YZXp9tgA==
Date: Mon, 28 Sep 2026 12:06:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 12/27] dt-bindings: gpu: panthor: Document
 panthor-arbitration bindings
Message-ID: <20260928-satisfied-rigorous-boobook-9dcef4@quoll>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-13-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922204535.2850094-13-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:06PM +0100, Karunika Choo wrote:
> Mali 5th-Gen AM GPUs expose arbitration registers outside the GPU node.
> The arbitration device contains partition-control and resource-group
> register blocks used to grant, yield, and close access windows.
> 
> Document partition and resource-group child nodes, each with its own
> register range, interrupt and hardware ID.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  .../gpu/arm,mali-gen5-am-arbitration.yaml     | 125 ++++++++++++++++++
>  .../bindings/gpu/arm,mali-gen5-am-system.yaml |   9 ++
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
> new file mode 100644
> index 0000000000000..9ea2b4bb9a344
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +# Copyright 2026 ARM Limited. All rights reserved.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/arm,mali-gen5-am-arbitration.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM Mali 5th-Gen GPU Arbitration Device
> +
> +maintainers:
> +  - Liviu Dudau <liviu.dudau@arm.com>
> +  - Boris Brezillon <boris.brezillon@collabora.com>
> +
> +description:
> +  The arbitration device manages partition-control and resource-group blocks.
> +  Each block is described by a child node with its own register range,
> +  interrupt and hardware ID. Partition and resource-group IDs are separate
> +  namespaces. Access-window IDs are global to the GPU.
> +
> +properties:
> +  $nodename:
> +    const: panthor-arbitration

Same comments. I stopped review here except one more point:


> +
> +  compatible:
> +    const: arm,mali-gen5-am-arbitration
> +
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^partition@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Partition control block and its initial resource assignments.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: Partition control register range.
> +
> +      interrupts:
> +        maxItems: 1
> +        description: Partition control interrupt.
> +
> +      arm,id:
> +        $ref: /schemas/types.yaml#/definitions/uint32

IDs are not allowed. See writing bindings or DTS101 slides.

Best regards,
Krzysztof

