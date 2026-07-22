Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F7DC4453A
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 19:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 382FD10EE7D;
	Wed, 22 Jul 2026 19:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="tIxVz/nc";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1EA10EEA4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 19:47:05 +0000 (UTC)
Received: from francesco-nb (93-38-170-58.ip71.fastwebnet.it [93.38.170.58])
 by mail11.truemail.it (Postfix) with ESMTPA id E38471FA0B;
 Wed, 22 Jul 2026 21:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784749623;
 bh=Ijtk+bxGjefd3BFxrgHKuzhrZVrVdvf6txD8HAvKjiw=; h=From:To:Subject;
 b=tIxVz/ncyyxwhfpXs4BsHyZ87BzwiyGF33dzBYOGa4veP8xDdcPnykumghVoVeZeH
 7/5IbfHEVS8Z3rvkTpH6e8VIlkazuBSSN1+dQvQ4yPiZMOIBaYm4YKFDP9R7I7yspZ
 ups5PQqMbYTjRPEqSYiOrxoHShXvfsxy41qMEXfTFQd8CXQK18XQN4DePQYa654gle
 cVDLmr5qcXx975kdgYOr0qWaRs0e0mtM+xestJ8Hy/WhdAj+XaKq5hpbnIX5eHAI1j
 XzPColBP3DOqGFC1bNcWSzuHYM7NvGNH4ZeZmF5Oi4puQrfZUKv3M5ilJaN56Ad2KO
 jHP/BA50vt7YA==
Date: Wed, 22 Jul 2026 21:46:56 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Frank Li <Frank.li@oss.nxp.com>, sashiko-reviews@lists.linux.dev,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format
Message-ID: <20260722194656.GA73938@francesco-nb>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-2-francesco@dolcini.it>
 <20260717122808.693211F000E9@smtp.kernel.org>
 <alpQh0ASY1HgdNqE@SMW015318> <20260717205754.GB512678@francesco-nb>
 <20260717211344.GC512678@francesco-nb>
 <20260722193044.GA1489843-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722193044.GA1489843-robh@kernel.org>
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

Hello Rob,

On Wed, Jul 22, 2026 at 02:30:44PM -0500, Rob Herring wrote:
> On Fri, Jul 17, 2026 at 11:13:44PM +0200, Francesco Dolcini wrote:
> > On Fri, Jul 17, 2026 at 10:57:54PM +0200, Francesco Dolcini wrote:
> > > On Fri, Jul 17, 2026 at 10:55:51AM -0500, Frank Li wrote:
> > > > On Fri, Jul 17, 2026 at 12:28:07PM +0000, sashiko-bot@kernel.org wrote:
> > > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > > - [Low] Introduction of the legacy, non-standard `interface-pix-fmt` property for a standard hardware concept (parallel bus width), violating modern DT principles.
> > > > > --
> > > > >
> > > > > --- Patch [1]: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format ---
> > > > > commit 7225ea545d2ff50540972dd75d375b8ecea4f315
> > > > > Author: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > >
> > > > > dt-bindings: lcdif: Add interface pixel format
> > > > >
> > > > > This commit updates the fsl,lcdif device tree binding to support the
> > > > > interface-pix-fmt property. The property is used to describe the hardware's
> > > > > parallel data bus transfer width to match board wiring and prevent shifted
> > > > > colors.
> > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > > > index 2dd0411ec6516..209ee5a96e393 100644
> > > > > > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > > > @@ -58,6 +58,13 @@ properties:
> > > > > >      items:
> > > > > >        - const: rx
> > > > > >
> > > > > > +  interface-pix-fmt:
> > > > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > > > +    enum:
> > > > > > +      - rgb24
> > > > > > +      - rgb565
> > > > > > +      - rgb666
> > > > >
> > > > > [Severity: Low]
> > > > > Is this introducing a legacy, non-standard property into the new schema ABI?
> > > > >
> > > > > Standard devicetree guidelines usually prefer endpoint properties like
> > > > > bus-width (defined in video-interfaces.yaml) to describe physical parallel
> > > > > data line configurations, such as setting bus-width = <18> for RGB666.
> > > > 
> > > > Make sense, can we use standard property?
> > > 
> > > video-interfaces.yaml is for video capture interfaces (cameras and the
> > > media/v4l subsystem). It does not apply here for DPI display interfaces.
> > 
> > ok, looking at this closer, it seems this is a used property also in the
> > DRM subsystem. I'll appreciate a feedback from some DT maintainer before
> > reworking this patch accordingly.
> 
> I reject any custom properties for describing the format of the parallel 
> interface. 

v2 is coming tomorrow using the common bus-width property

thanks for the feedback

