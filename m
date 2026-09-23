Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8D4C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6A710E133;
	Wed, 23 Sep 2026 15:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mK3vguQQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B5A10E133
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:07:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5586D600AA;
 Wed, 23 Sep 2026 15:07:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22A61F000FF;
 Wed, 23 Sep 2026 15:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790176057;
 bh=S/G7qAIDh4xZmy6mFlSx2HvhL7LQ+Nq2/3G033lFXPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mK3vguQQ7BmTGYPZ5WB/w0b/RcLVfhAhweyJF9IS/rT06BdutLM5qXytakjemkrNH
 ep5fizxiL61s4VyC8rK8zOJBMGtVdWLNS8+3ELJRVPgfjBVtSilvOBgfy6JCo1rQ07
 514PdNdiLctz/xk1U3RvH8GPUFwvsSVY4OMqF8sUHO1W2dm0KmkwbvRXgNcg8ynTVf
 oINrP5nXTdeZn7uP72sYGAZuZvobLb14Hf1XYDo0UEoMnmhWtOxmn/p82RBqASIrPR
 4LamYgkML1c3Ty/pw0CUlv8par+lFZTOYOzlUcoHv7wpMpU2/X+VH/ZwLFa4A7ClcG
 lRxkE2hQ42ZTw==
Date: Wed, 23 Sep 2026 10:07:35 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] dt-bindings: panel: Add JDI NT35596S
Message-ID: <20260923150735.GE27237-robh@kernel.org>
References: <20260921232609.3130272-1-robh@kernel.org>
 <20260921233127.C2F1E1F000FF@smtp.kernel.org>
 <20260922-stress-creole-094d9e68fe6a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-stress-creole-094d9e68fe6a@spud>
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

On Tue, Sep 22, 2026 at 07:03:29PM +0100, Conor Dooley wrote:
> On Mon, Sep 21, 2026 at 11:31:27PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] dt-bindings: incorrect use of additionalProperties instead of unevaluatedProperties
> > --
> > 
> > commit e0dc4d49c687f6d5568ce2c31031086acb6cd5e6
> > Author: Rob Herring (Arm) <robh@kernel.org>
> > 
> > dt-bindings: panel: Add JDI NT35596S
> > 
> > This commit adds a new device tree binding schema for the JDI FHD
> > NT35596S MIPI-DSI panel. It documents properties such as the DSI reg value,
> > reset GPIO, backlight, port, and various power supplies.
> > 
> > > diff --git a/Documentation/devicetree/bindings/display/panel/jdi,fhd-nt35596s.yaml b/Documentation/devicetree/bindings/display/panel/jdi,fhd-nt35596s.yaml
> > > new file mode 100644
> > > index 0000000000000..aefc9ae5d8abd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/jdi,fhd-nt35596s.yaml
> > 
> > [ ... ]
> > 
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: jdi,fhd-nt35596s
> > 
> > [ ... ]
> > 
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios
> > > +  - vddio-supply
> > > +  - vddneg-supply
> > > +  - vddpos-supply
> > > +  - port
> > > +
> > > +additionalProperties: false
> > 
> > [Severity: Low]
> > Does the use of additionalProperties: false here incorrectly reject standard
> > inherited panel properties?
> > 
> > Because this schema references panel-common.yaml in an allOf block,
> > additionalProperties does not traverse the $ref references. This blocks
> > standard properties like rotation and forces the redundant declaration of
> > properties like backlight, reset-gpios, and port just to pass static JSON
> > schema validation during a make dt_binding_check.
> > 
> > Should this use unevaluatedProperties: false instead?
> 
> This seems to be the new thing that Sashiko whines about, any binding I
> see with additionalProperties: false seems to get complained about.

That and needing labels to be resolved in examples it consistently gets 
wrong. Probably need to work on the guidance...

Rob
