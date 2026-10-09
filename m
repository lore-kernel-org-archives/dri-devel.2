Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A97CA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E30311202F;
	Fri,  9 Oct 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lal6Z+0Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BDB9112018
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 09:56:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9491160DBB;
 Fri,  9 Oct 2026 09:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208C21F000FF;
 Fri,  9 Oct 2026 09:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791539816;
 bh=uw5r0ZU13pOmnED84qreFU1ulMbb9W8LjLFZZD/VgW4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lal6Z+0QLy9I9ohEoPWE28GtdEnKcSOYiDDAsNHvJ4Aqo6mszsIWKJ76vNGVxsnyH
 Xo2lUvoiRERpWQBPZ3VAKGvqOoXaAcFOe3N/6i2unJY/ZQz0XC+9A3HDAQiRmb14bP
 3lSZn3j0TnRN88Rt5S/3Nsq37pWj/W+Oxyup8/OEsy+/2f2R/Q5DDsMuuY9m8I+T70
 nLbMN9Yo3vgQdW22AjT7hyftdkkk9bWeK27OlEvddDKJUqGrLZlhKxPvqg4lmJa8zx
 X0OTNekIQIQgH2MQmhtsOUMhCLzCK9m+1ncyHFJNU1vJYeCN850cVGSgU/tUz3hi29
 OrVZu5pAlVvuw==
Date: Fri, 9 Oct 2026 11:56:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: misc: qcom, fastrpc: add iommu-ranges
 support for context bank
Message-ID: <20261009-space-crane-of-prosperity-bba4d7@quoll>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
 <20261007-extended-mapping-v2-1-5dca3aa2c2d3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007-extended-mapping-v2-1-5dca3aa2c2d3@oss.qualcomm.com>
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

On Wed, Oct 07, 2026 at 05:07:48PM +0530, Vinayak Katoch wrote:
> The driver uses the presence of iommu-ranges on a context bank node to
> identify it as dedicated for extended IOVA mapping. iommu-ranges lists
> the IOVA ranges the IOMMU allocator may use for that device; any range
> not listed is left unused.
> 
> Add iommu-ranges to the compute-cb subnode properties so the DT
> validator accepts it on context bank nodes.

Example looks incomplete now. Please add a new example showing complete
picture of this device with all new properties.

> 
> Relax #address-cells to enum: [1, 2] and #size-cells to enum: [0, 2] to
> allow platforms that require 64-bit values in iommu-ranges to pass
> binding validation.

Which platforms are these?

> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Looks like this needs some dependencies.

Best regards,
Krzysztof

