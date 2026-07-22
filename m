Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9858C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DB110E217;
	Wed, 22 Jul 2026 19:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MicShiMn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7C110E217
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:30:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F17D60051;
 Wed, 22 Jul 2026 19:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73741F000E9;
 Wed, 22 Jul 2026 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784748644;
 bh=3j/QOD0vnHlFRoYcnlJW/d2NjKmuDjzpQav1pRPJ1d8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MicShiMn+2IDzvdux8jhTGz4/VqiFUjE/WeK8ciYocW3H2uEFKlAS4cje53cwZJDQ
 LvHwD53wmBM4RHr84QBSX5uDz/w5DJxH6KmNCyPUYYumKol7NQ3FGcO8TVnxIgH2u5
 pTvCMQfuF6xnwrucRex5X/6yAU7ZIK0tg+bzTdx4/rUDAdcal89/m7fbrTpXFH3tOm
 mO7yR3N+EIZJWvoOYTpiDDkIy/vyYB2gxtrYXc7t2qMyjmyTDypH0DFoRDaoOIa1Ts
 d9WjuuaISZfpl+Ss10XQaHHRRjwloE0JNFI8fGwCbGrwa39UwJrf11ioD1ElxQLgVH
 L1kEcW2qgGN3A==
Date: Wed, 22 Jul 2026 14:30:44 -0500
From: Rob Herring <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Frank Li <Frank.li@oss.nxp.com>, sashiko-reviews@lists.linux.dev,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format
Message-ID: <20260722193044.GA1489843-robh@kernel.org>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-2-francesco@dolcini.it>
 <20260717122808.693211F000E9@smtp.kernel.org>
 <alpQh0ASY1HgdNqE@SMW015318> <20260717205754.GB512678@francesco-nb>
 <20260717211344.GC512678@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717211344.GC512678@francesco-nb>
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

On Fri, Jul 17, 2026 at 11:13:44PM +0200, Francesco Dolcini wrote:
> On Fri, Jul 17, 2026 at 10:57:54PM +0200, Francesco Dolcini wrote:
> > On Fri, Jul 17, 2026 at 10:55:51AM -0500, Frank Li wrote:
> > > On Fri, Jul 17, 2026 at 12:28:07PM +0000, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > - [Low] Introduction of the legacy, non-standard `interface-pix-fmt` property for a standard hardware concept (parallel bus width), violating modern DT principles.
> > > > --
> > > >
> > > > --- Patch [1]: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format ---
> > > > commit 7225ea545d2ff50540972dd75d375b8ecea4f315
> > > > Author: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > >
> > > > dt-bindings: lcdif: Add interface pixel format
> > > >
> > > > This commit updates the fsl,lcdif device tree binding to support the
> > > > interface-pix-fmt property. The property is used to describe the hardware's
> > > > parallel data bus transfer width to match board wiring and prevent shifted
> > > > colors.
> > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > > index 2dd0411ec6516..209ee5a96e393 100644
> > > > > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > > @@ -58,6 +58,13 @@ properties:
> > > > >      items:
> > > > >        - const: rx
> > > > >
> > > > > +  interface-pix-fmt:
> > > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > > +    enum:
> > > > > +      - rgb24
> > > > > +      - rgb565
> > > > > +      - rgb666
> > > >
> > > > [Severity: Low]
> > > > Is this introducing a legacy, non-standard property into the new schema ABI?
> > > >
> > > > Standard devicetree guidelines usually prefer endpoint properties like
> > > > bus-width (defined in video-interfaces.yaml) to describe physical parallel
> > > > data line configurations, such as setting bus-width = <18> for RGB666.
> > > 
> > > Make sense, can we use standard property?
> > 
> > video-interfaces.yaml is for video capture interfaces (cameras and the
> > media/v4l subsystem). It does not apply here for DPI display interfaces.
> 
> ok, looking at this closer, it seems this is a used property also in the
> DRM subsystem. I'll appreciate a feedback from some DT maintainer before
> reworking this patch accordingly.

I reject any custom properties for describing the format of the parallel 
interface. 

Rob
