Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7237CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC1F11A233;
	Thu,  4 Jun 2026 18:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="doHo2H8Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D172511A233
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:43:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AEA860052;
 Thu,  4 Jun 2026 18:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D741F00893;
 Thu,  4 Jun 2026 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780598638;
 bh=VqSS10h2AUJUcCZwvdHE2yhkHcXcmUxZJ3hTKVbdwVU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=doHo2H8YcwaAU0h5DPYQIJ+o+v7I9xaPz6+X9MirSvMzYiCbeiIm/jISGNgS5v9Ch
 1C+15fZQP0L+2WhokPDB2jOFfEclZQvcLF5yi5F90vkoD+MVUn5PNiK9wBTwx4vgr6
 glb2TcxN6oEHp9flZzsjS4yKnnkozacgVK6ST6GX06mdIkEOgAv3+knn5fMCIV4x+/
 qj3NpT+e1UG+EmeXTpTa5iyupVPYbjqDTp7xrb4L1J+v6UIjZtocvDgHchIoJniPO+
 Oe8C0x6EERFbH6+djXsRdDwYQga+befhFHw8zSe2u4/6+r+8zJp9tUxDuYFL64qPVP
 n/393bGOHexbg==
Date: Thu, 4 Jun 2026 13:43:57 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Damon Ding <damon.ding@rock-chips.com>, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v5 1/4] dt-bindings: display: bridge: analogix-dp: Add
 data-lanes support for endpoint
Message-ID: <20260604184357.GA988009-robh@kernel.org>
References: <20260604085220.2862986-2-damon.ding@rock-chips.com>
 <20260604090639.D40751F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604090639.D40751F00893@smtp.kernel.org>
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

On Thu, Jun 04, 2026 at 09:06:37AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `data-lanes` property is defined strictly for the `endpoint` node name, causing schema validation to fail or miss constraints if applied to valid unit-addressed nodes like `endpoint@0`.
> --
> 
> commit c6792a12ea4c785878c85982c6a4537b6a1901d6
> Author: Damon Ding <damon.ding@rock-chips.com>
> 
> dt-bindings: display: bridge: analogix-dp: Add data-lanes support for endpoint
>     
> This commit adds data-lanes property support to the port@1 endpoint in
> the analogix-dp bridge binding to allow physical lane mapping configuration.
> It also updates the Rockchip eDP DT node example to demonstrate its usage.
> 
> > diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> > index 62f0521b09245..ecf206871cdde 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/analogix,dp.yaml
> > @@ -42,13 +42,22 @@ properties:
> >      properties:
> >        port@0:
> 
> [ ... ]
> 
> >        port@1:
> > -        $ref: /schemas/graph.yaml#/properties/port
> > -        description:
> > -          Port node with one endpoint connected to a dp-connector node.
> > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > +        unevaluatedProperties: false
> > +        description: Port node with one endpoint connected to sink device node.
> > +        properties:
> > +          endpoint:
>              ^^^^^^^^
> [Severity: Medium]
> Does restricting this to the exact node name 'endpoint' cause validation
> issues for unit-addressed nodes?
> 
> Because JSON Schema strictly matches object keys, a node named endpoint@0
> under port@1 will bypass this block, meaning the video-interfaces $ref
> and data-lanes validation constraints are never applied.

That could be an issue...

> Should this use patternProperties: "^endpoint(@[0-9a-f]+)?$": instead
> of properties: endpoint: to ensure unit-addressed endpoint nodes don't
> bypass these constraints?

But no, this is fine as-is because it defines that only a single 
endpoint is valid and we'd need to fix everywhere as this is a common 
pattern.

Rob
