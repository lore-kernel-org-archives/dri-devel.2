Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDE7C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A00810F633;
	Fri, 17 Jul 2026 21:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Qa8WNCTN";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB7310F633
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:13:48 +0000 (UTC)
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 00E771F9FE;
 Fri, 17 Jul 2026 23:13:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784322827;
 bh=yMr4YvPSGTUuTkpmhzKNy6bqQMBEMI+em96DebwBIU4=; h=From:To:Subject;
 b=Qa8WNCTNZQoAWiX+O4hlDcq7TKa5qf37Ez5FtotARqbMVnyVjyATdvE5ao5Jqqnqw
 3GuLyDRJ3XOkIAxbUWj6i3qzRhAYgkScI2QOPk2s2zXrh/lNaafOrt0NlneDRnfKJg
 XWG4nmNOSHJMQJLUrZ7jpAUi8hOsuWsQtCv0cBSZaN3Y1UdrHZgNGWD5cnTRPU9Gr3
 7c1vSn4gJLc2Tvcpaa7ejBJrXMmUHyvl18nSfxlFvFf6UgsdnXwXA1A3KFFi7fWMo1
 Ji9bohztIvHjTG8VOd4nSkY8mHP+vTpz7ytj3HXeYRXVIsm2phq3kxgAAjEA5moJSH
 j3XI+HZRUbeLg==
Date: Fri, 17 Jul 2026 23:13:44 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@oss.nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
 robh@kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format
Message-ID: <20260717211344.GC512678@francesco-nb>
References: <20260717121847.488148-1-francesco@dolcini.it>
 <20260717121847.488148-2-francesco@dolcini.it>
 <20260717122808.693211F000E9@smtp.kernel.org>
 <alpQh0ASY1HgdNqE@SMW015318> <20260717205754.GB512678@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717205754.GB512678@francesco-nb>
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

On Fri, Jul 17, 2026 at 10:57:54PM +0200, Francesco Dolcini wrote:
> On Fri, Jul 17, 2026 at 10:55:51AM -0500, Frank Li wrote:
> > On Fri, Jul 17, 2026 at 12:28:07PM +0000, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > - [Low] Introduction of the legacy, non-standard `interface-pix-fmt` property for a standard hardware concept (parallel bus width), violating modern DT principles.
> > > --
> > >
> > > --- Patch [1]: [PATCH v1 1/4] dt-bindings: lcdif: Add interface pixel format ---
> > > commit 7225ea545d2ff50540972dd75d375b8ecea4f315
> > > Author: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >
> > > dt-bindings: lcdif: Add interface pixel format
> > >
> > > This commit updates the fsl,lcdif device tree binding to support the
> > > interface-pix-fmt property. The property is used to describe the hardware's
> > > parallel data bus transfer width to match board wiring and prevent shifted
> > > colors.
> > >
> > > > diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > index 2dd0411ec6516..209ee5a96e393 100644
> > > > --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> > > > @@ -58,6 +58,13 @@ properties:
> > > >      items:
> > > >        - const: rx
> > > >
> > > > +  interface-pix-fmt:
> > > > +    $ref: /schemas/types.yaml#/definitions/string
> > > > +    enum:
> > > > +      - rgb24
> > > > +      - rgb565
> > > > +      - rgb666
> > >
> > > [Severity: Low]
> > > Is this introducing a legacy, non-standard property into the new schema ABI?
> > >
> > > Standard devicetree guidelines usually prefer endpoint properties like
> > > bus-width (defined in video-interfaces.yaml) to describe physical parallel
> > > data line configurations, such as setting bus-width = <18> for RGB666.
> > 
> > Make sense, can we use standard property?
> 
> video-interfaces.yaml is for video capture interfaces (cameras and the
> media/v4l subsystem). It does not apply here for DPI display interfaces.

ok, looking at this closer, it seems this is a used property also in the
DRM subsystem. I'll appreciate a feedback from some DT maintainer before
reworking this patch accordingly.

