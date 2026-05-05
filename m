Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECA4CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 19:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4146210E24E;
	Tue,  5 May 2026 19:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gP1GZCu9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A63EE10E24E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 19:39:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 01CD260181;
 Tue,  5 May 2026 19:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83637C2BCB4;
 Tue,  5 May 2026 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778009948;
 bh=K5AwDX7FfPa71rodjgfq618inTJ4hiG1ghywEeULFwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gP1GZCu9X50ZuXhRtGDWUVXBVTMV2ayTF2kNCKe1eWmdfAPlu7bROwmmJ7b7pXaDb
 adXkDCUs/VZwJmWjN0Aa5mwfkgciSk/ucjM5XOlP4ZsEVKtl6KepahPCsykVS8uiJB
 NFmzPhKq8sdyDVUQK0RXOUKX8Bx2xyeAoCK4grr7Z/7LNYTa6l+0N9ndSifq1tMXTy
 i2Q5XZfwLJIYWBB+BHZ53hlp0RTJN7JmY+ptZ0WUsvvBmKrxMF5R7QVLbGtdQ09xL+
 ThgmwkUQ50U+2+nQnCUpyHB1hDC2yGK1CT+rUg58e+O1NGRSN3QGQOAXV8yWUqGRDj
 jp9F65J3cttwA==
Date: Tue, 5 May 2026 14:39:06 -0500
From: Rob Herring <robh@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Aradhya Bhatia <aradhya.bhatia@linux.dev>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Swamil Jain <s-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/15] dt-bindings: display: ti,am625-oldi: Add optional
 power-domain for OLDI
Message-ID: <20260505193906.GA3796761-robh@kernel.org>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
 <20260420-beagley-ai-display-v1-4-f628543dfd14@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-beagley-ai-display-v1-4-f628543dfd14@ideasonboard.com>
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

On Mon, Apr 20, 2026 at 03:54:11PM +0300, Tomi Valkeinen wrote:
> On some SoCs the OLDI blocks belong to the same power-domain as the main
> DSS block, but on some more recent SoCs the OLDI blocks have a
> controllable power-domain.
> 
> Add the power-domain to the DT binding.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> index 8203ec5e5bb3..61c3eb0a0776 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
> @@ -29,6 +29,10 @@ properties:
>    clock-names:
>      const: serial
>  
> +  power-domains:
> +    maxItems: 1
> +    description: phandle to the associated power domain

Drop generic descriptions.

> +
>    ti,companion-oldi:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> 
> -- 
> 2.43.0
> 
