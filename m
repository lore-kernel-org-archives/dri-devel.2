Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ECAC5ACAB
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 21:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CC510E32A;
	Fri,  7 Aug 2026 21:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FCsmZMOR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DEEB10E32A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 21:43:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D36F243AC9;
 Fri,  7 Aug 2026 21:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3AF1F000E9;
 Fri,  7 Aug 2026 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786139006;
 bh=O0GWgFWa+KBYW+SsUAsbFeygA58QMJKApP/borqb9+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FCsmZMORxswv2bDdmcWQFXbFXcIjplPP1RneiT0TWSZiPP8H0kubyXerByucctfk8
 FtIlCV4dr4M15leD5VGrIfr+wGoGA9cRwUF9v+3wfLmmW6mlSlUVf7MSGaA5HNFFj3
 PnEtyivYrP6jJvQeWzCUv0KUcGBFUj9LE6bim8hQoC1H/eQ+LRXMcYLLCfcy2vkQKD
 YeK6DWtGst5v2i3fobrRN38C8ZOZqZTmsdtCX3x5Q8+76XcaFeSTiA4D/PQXkFMb//
 GCfer1AOJQmHmTEIOfy/ja9FMLnssIPt8tUxvRvgztwx5p209uONfwwRPSk7Xcs9Xy
 KCKM7ZsYKkVUw==
Date: Fri, 7 Aug 2026 16:43:25 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: lcdif: Add endpoint bus-width property
Message-ID: <20260807214325.GA2070489-robh@kernel.org>
References: <20260723093813.180089-1-francesco@dolcini.it>
 <20260723093813.180089-2-francesco@dolcini.it>
 <amI3HKLECuZBHLs0@SMW015318>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amI3HKLECuZBHLs0@SMW015318>
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

On Thu, Jul 23, 2026 at 10:45:32AM -0500, Frank Li wrote:
> On Thu, Jul 23, 2026 at 11:38:08AM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >
> > The DPI output of the LCD interface can be configured with a bus width
> > of 16, 18, or 24 bits. Introduce a bus-width property to the output
> > endpoint, specifying the number of parallel RGB bits connected.
> >
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> > v2: use the common bus-width property instead of the legacy interface-pix-fmt
> > ---
> >  Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > index 2dd0411ec651..6931f0ae3829 100644
> > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > @@ -71,6 +71,15 @@ properties:
> >      $ref: /schemas/graph.yaml#/properties/port
> >      description: The LCDIF output port
> >
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> 
> Is it better by use video-interfaces.yaml# ?

Yes.

Rob
