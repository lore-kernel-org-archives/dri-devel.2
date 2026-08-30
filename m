Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E836C61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 09:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03B810E168;
	Sun, 30 Aug 2026 09:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RnV1i5HJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317F510E168
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 09:49:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED3BE40418;
 Sun, 30 Aug 2026 09:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AAD1F000E9;
 Sun, 30 Aug 2026 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788083385;
 bh=Xg/ZCzi16B5EX2YvsOjREBDm3uHfDOc/KhDLA5FrAzQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RnV1i5HJSVr99UN7tdJ5TBKSu8NWrPPlOe8ZdP4XLbAWZ2BEraisMKHUueEbH+6KG
 BL6m/uU0RVKPGCUbuHIoUlByMOlL4InMMkcPOfYFjlewECzRrJaGHPjjw5vebZaI4P
 aePGancZ88VoeqYj+iQ0eY+4TwkwA2JeogaFecvok0EX8uqFgdOdVGwzQeZKvquCH+
 YneTax9tSYe7RWMMiyGkX40u56o1UdoWuZR15F9j+dmYXBeUooMxK0p0dck6A3vNpx
 G/8z1RGU6dYajKYAyJOkOxTtOWzmSo4RtfdzVI8+00c5s+xedy4pS/H1cDHf4yvEui
 uNoC3oiDIG3cg==
Date: Sun, 30 Aug 2026 11:49:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: misc: fastrpc: Add memory-region
 property for context bank
Message-ID: <20260830-nondescript-blue-jackdaw-a95a3a@quoll>
References: <20260826-extended-mapping-v1-0-d046c1cb9a9f@oss.qualcomm.com>
 <20260826-extended-mapping-v1-1-d046c1cb9a9f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826-extended-mapping-v1-1-d046c1cb9a9f@oss.qualcomm.com>
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

On Wed, Aug 26, 2026 at 07:15:43PM +0530, Vinayak Katoch wrote:
> Add an optional memory-region property to the context bank node schema.
> The driver uses its presence to identify a context bank as dedicated for
> extended IOVA mapping and programs the SMMU with an iommu-addresses
> range to push allocations into the wider address space.

I hope you are not solving in a third or fourth way the same problem
that Iris/Venus, QDA and one more block have.

> 
> Relax #address-cells to enum: [1, 2] and #size-cells to enum: [0, 2] to
> allow platforms that require 64-bit values in iommu-addresses to pass
> binding validation.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> index e945c8ba75e3..f9830ef37814 100644
> --- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> +++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
> @@ -73,10 +73,10 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>  
>    "#address-cells":
> -    const: 1
> +    enum: [1, 2]
>  
>    "#size-cells":
> -    const: 0
> +    enum: [0, 2]
>  
>  patternProperties:
>    "(compute-)?cb@[0-9]*$":
> @@ -98,6 +98,14 @@ patternProperties:
>          minItems: 1
>          maxItems: 10
>  
> +      memory-region:
> +        maxItems: 1
> +        description:
> +          Phandle to a reserved-memory node whose iommu-addresses property
> +          blocks the lower IOVA range, forcing allocations into the extended
> +          address space. Its presence marks this context bank as an extended
> +          mapping bank.

So far looks the same as:
https://lore.kernel.org/all/20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com/

If it is not the same problem, then please explain. Otherwise wait for
resolution of Iris patchset.

Best regards,
Krzysztof

