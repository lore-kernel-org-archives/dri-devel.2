Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A5FC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF74210E7C9;
	Mon, 28 Sep 2026 10:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eK8ZdW0H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA0DA10E7C9
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:06:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EED8601F1;
 Mon, 28 Sep 2026 10:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8951F000FF;
 Mon, 28 Sep 2026 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790590012;
 bh=UY1wjgZ4YiqD21QdMzkmZKSJfV0/BKUbYwAG+89x5Qg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=eK8ZdW0HqolkZgbsMuilZA2XTsjObF22Z6lYhcg7CF+qlYTXXMOcyHtS+3QWRY/RZ
 qL2UT9z5xp4Hpc9y2L/iP5itRjbGOr0xfx6embSs8bRKBlNx0yKF51fIKHx1FJ1kRF
 8IzOjNlYZP/aAe4Xx8CFsx/Pd9kcOgzBKROfULvb0F9DaUQ70QpSoqRkTh6B4FC6cc
 GbdSLNeUrgd7K4o5kPlRhxd1o2THKiCdnfsyN2vuI5GHSuELVRaom9s7F6vbNsiLNK
 CYf2uB4NbjkB5VeZwMI3F2gzzWBpospe620FyH/K6C8AQ26AgI2wFuPPo9Xv/SC9n0
 6HUbByFZJpadQ==
Date: Mon, 28 Sep 2026 12:06:50 +0200
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
Subject: Re: [PATCH v1 18/27] dt-bindings: gpu: panthor: Document AW
 assignment DT property
Message-ID: <20260928-adorable-gazelle-of-variation-e5b714@quoll>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-19-karunika.choo@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260922204535.2850094-19-karunika.choo@arm.com>
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

On Tue, Sep 22, 2026 at 09:45:12PM +0100, Karunika Choo wrote:
> Introduce arm,access-window-mask property to allow partitions to define
> the assigned access windows at probe time.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  .../bindings/gpu/arm,mali-gen5-am-arbitration.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
> index 9ea2b4bb9a344..4e7933829e2be 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.yaml
> @@ -52,6 +52,15 @@ patternProperties:
>            Hardware partition control index. Must identify a partition present on
>            the GPU and be unique among this device's partition nodes.
>  
> +      arm,access-window-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 0xffff
> +        default: 0
> +        description:
> +          Initial access window assignment mask. Bit N selects global
> +          access window ID N. Masks must be disjoint across partitions.
> +          If omitted, no access windows are assigned by default.

You just added this file!

Please read writing bindings document. The bindings MUST BE complete.

Best regards,
Krzysztof

