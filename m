Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75186606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXHnsUQz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9B410E5FE;
	Sun, 22 Nov 2026 16:59:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B3F410E5FE
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 16:59:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3E71E61120;
 Sun, 22 Nov 2026 16:59:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC811F000CA;
 Sun, 22 Nov 2026 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795366739;
 bh=5KT/akQqJfPobK/Gnh5/Clx5Z1xrij4GwAcSxJvS7Gg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FXHnsUQz4t7cbWldltOLuYKWx2ib4DEnDlS0X1/37hYfx67vp4xhRzJ4D///TI44H
 IoITN0O0k81L9PzfpD1mHulb/0ZdkWyAHIj0zb/UUSFmwiBvL/K7NZZr1KGk911T4T
 +rcJsMkmweKZULlb4Tpu7u8clHRH1mUk29bZvQkat/3xJ671m6Br76/+Hl4XjugTli
 4G1tsk3tVoSqtFwN/+5cxVaqf+qhz0ROZ532Rt0jtQSBRUyRxlvTML9rPEOBM+/AjD
 x/hCivPUnUzK6IRZ1CChBXzeUdJojejhtY9W641lkeEMl7fFzA9XrZ7s8GevVL7Hfp
 fK2l+w1y/3QMQ==
Date: Sun, 22 Nov 2026 17:58:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Cunyuan Liu <cunyuan.liu@cixtech.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com, 
 liviu.dudau@arm.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 gary.yang@cixtech.com, fugang.duan@cixtech.com, daniel.almeida@collabora.com, 
 aliceryhl@google.com, p.zabel@pengutronix.de, daniel@fooishbar.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, robin.wang@cixtech.com
Subject: Re: [PATCH v3 3/7] dt-bindings: gpu: arm,mali-valhall-csf: Add
 system-cache policies
Message-ID: <20261122-greedy-cuddly-hog-06c4ac@quoll>
References: <20261119123850.2994625-1-cunyuan.liu@cixtech.com>
 <20261119123850.2994625-4-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119123850.2994625-4-cunyuan.liu@cixtech.com>
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

On Thu, Nov 19, 2026 at 08:38:46PM +0800, Cunyuan Liu wrote:
> Describe system-cache allocation policies for Mali GPUs with SYSC_ALLOC
> registers. The policy depends on how the GPU is integrated with the rest
> of the system and belongs in DT rather than a platform table in the driver.

Explain why.


> 
> Use entries containing a source ID and separate read and write policies.
> When the property is present, omitted sources use L2 allocation. Without
> the property, the driver leaves the register settings unchanged.
> 
> Signed-off-by: Cunyuan Liu <cunyuan.liu@cixtech.com>
> ---
>  .../bindings/gpu/arm,mali-valhall-csf.yaml    | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index 8eccd4338a2b..4d50427edd87 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> @@ -97,6 +97,30 @@ properties:
>  
>    dma-coherent: true
>  
> +  arm,sysc-alloc:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 32
> +    items:
> +      items:
> +        - description: GPU internal source ID
> +          minimum: 0
> +          maximum: 31
> +        - description: Read allocation policy
> +          enum: [0, 2, 3, 4, 5]
> +        - description: Write allocation policy
> +          enum: [0, 2, 3, 4, 5]
> +    description:
> +      System-cache allocation policies for GPU architecture 11.0.3 and later.
> +      Each entry contains a source ID, a read policy and a write policy.
> +      Source IDs must be unique. Reserved source IDs and access directions
> +      not supported by the GPU must use zero policies. Policy values are
> +      0 for L2 allocation, 2 for never allocate, 3 for always allocate,
> +      4 for partial allocation and 5 for L2 partial allocation. When present,
> +      all source policies start at zero and the listed entries override them.
> +      Omitted sources therefore use L2 allocation. If absent, the register
> +      defaults are preserved.

Looks like integration specific, so implied by the compatible.

Best regards,
Krzysztof

