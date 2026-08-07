Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8582FC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8317810E445;
	Fri,  7 Aug 2026 15:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aYLkVVQ7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7616710E445
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:51:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 287CF4004A;
 Fri,  7 Aug 2026 15:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80871F000E9;
 Fri,  7 Aug 2026 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786117901;
 bh=gIpqIEJ1hpxZU+jdGL2zT4kDorAYvLQD53HhekKbuRk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aYLkVVQ7c0l2WVoIIpbvPYPvfyKYPZRBAn185d7bbCQc6iaeaEep5onjdOqi8tPvl
 xSrATgH2XtMDnM5t2uasfEsrv0pOSnsQaCvo28W1bsjNLr47BLOPDB1C8jJ+JAzHIa
 Xb4cQObD0owIsW1Ewqp7lpSTIdI4NBWaoasK0AJEtgZOTUUlRDR14D3y33AMXjwx+V
 Q2S82vr+8GfZTXPTxbKiRw+KTWjjzt0IPdfJvSbwxtrUSu71dsXqETLnTj1cjGnUqc
 X/lLf6b5AFd4GODQCS/pJDF+RRyN7sSig8+zHrdLcw9Ml/XC59OlNWMci9E4IXEkTN
 2qbZR2d1zwhwA==
Date: Fri, 7 Aug 2026 10:51:40 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v11 20/21] dt-bindings: display: rockchip: dw-dp: Fix
 sound DAI cells
Message-ID: <20260807155140.GA882294-robh@kernel.org>
References: <20260806-synopsys-dw-dp-improvements-v11-0-0d508505f383@collabora.com>
 <20260806-synopsys-dw-dp-improvements-v11-20-0d508505f383@collabora.com>
 <20260806174000.668AB1F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806174000.668AB1F000E9@smtp.kernel.org>
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

On Thu, Aug 06, 2026 at 05:39:59PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Device Tree schema validation breakage for existing `rockchip,rk3588-dp` configurations.
> --
> 
> --- Patch [20]: [PATCH v11 20/21] dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells ---
> commit 2c15bbfcf4dec184872abdf4c2e06063a52d1e2f
> Author: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> dt-bindings: display: rockchip: dw-dp: Fix sound DAI cells
> 
> The RK3588 and RK3576 DesignWare DisplayPort controllers both have two
> possible DAI interfaces: I2S and S/PDIF. Thus an argument is needed to
> to select the right interface.
> 
> > diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> > index 2b0d9e23e9432..c4f8959dd65da 100644
> > --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> > +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
> [ ... ]
> > @@ -83,7 +83,8 @@ properties:
> >      maxItems: 1
> >  
> >    "#sound-dai-cells":
> > -    const: 0
> > +    const: 1
> > +    description: 0 for I2S, 1 for S/PDIF
> 
> [Severity: Medium]
> Will this strict constraint update cause make dtbs_check validation to
> fail for existing in-tree device trees?
> 
> The mainline arch/arm64/boot/dts/rockchip/rk3588-base.dtsi still defines
> #sound-dai-cells = <0>; for DP nodes.
> 
> While the commit message notes this breakage is intentional and will be
> fixed up separately, could changing the schema without the accompanying
> DTS updates cause automated CI validation failures and break bisectability?

Yes, and I don't love the intermittent warnings introduced. As long as 
the warnings are on a downward trajectory, I won't notice...

Not saying you have to do something here, but this will get more 
strict...

Rob
