Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A6BC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:52:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 100B610F052;
	Thu, 23 Jul 2026 09:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c+RaUYu1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D61C610F052
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:52:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A036600B1;
 Thu, 23 Jul 2026 09:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953501F000E9;
 Thu, 23 Jul 2026 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784800324;
 bh=ATDPs2YydRvacSbpoNUJcY9xw6cEQZY3C8P6osHSgNk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c+RaUYu1wZ+zEja9Oyq1J0YZHQHi1kYuxRbXNUXHKL2FZqThUc30mTlUaArUulNrn
 RZTWTYI7X6qNOVfWRiUdpb5oPukwqtdKKqCjO5hpIbjuola4z88IRyAXqnuLcJ89xg
 bwhoDxOflUC650vJLYlK/nnBABiuEB5cIN7e1iQcetp9REx0dq7ukdpAKxAaLcT5ah
 cZjUuNS1XgZT0zSOxKQJxSnHN3qW7RvLGIeOajlNvocP8r//yudd3CXoilB+SzO1KG
 +6frw+xVOuzESeb14oZ1ewHSDcYrBIl5EJCX9fd0jxZYj+5xrGgr+3LzslWwI6g/dT
 vUyW5vQV45Vdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: lcdif: Add endpoint bus-width property
To: "Francesco Dolcini" <francesco@dolcini.it>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, imx@lists.linux.dev,
 Frank.Li@kernel.org
In-Reply-To: <20260723093813.180089-2-francesco@dolcini.it>
References: <20260723093813.180089-1-francesco@dolcini.it>
 <20260723093813.180089-2-francesco@dolcini.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:52:03 +0000
Message-Id: <20260723095203.953501F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Schema validation bypass for numbered endpoint nodes.
--

--- Patch [1]: [PATCH v2 1/4] dt-bindings: lcdif: Add endpoint bus-width pr=
operty ---
commit 73f976bb84f0f0a26cb8385791e8483235c1fe74
Author: Francesco Dolcini <francesco.dolcini@toradex.com>

dt-bindings: lcdif: Add endpoint bus-width property

The DPI output of the LCD interface can be configured with a bus width
of 16, 18, or 24 bits. Introduce a bus-width property to the output
endpoint, specifying the number of parallel RGB bits connected.

> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/D=
ocumentation/devicetree/bindings/display/fsl,lcdif.yaml
> index 2dd0411ec6516..6931f0ae38297 100644
> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
> @@ -71,6 +71,15 @@ properties:
>      $ref: /schemas/graph.yaml#/properties/port
>      description: The LCDIF output port
> =20
> +    properties:
> +      endpoint:

[Severity: Low]
Will this schema validate device trees with multiple endpoints correctly?

Defining `endpoint:` under `properties` will only match nodes exactly named
"endpoint". Any numbered endpoints like "endpoint@1" or "endpoint@2" will
silently bypass these constraints and the `unevaluatedProperties: false`
check.

Should this be defined using `patternProperties: "^endpoint(@[0-9a-f]+)?$":`
instead to ensure the rules apply to all endpoint nodes?

> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +        unevaluatedProperties: false
> +
> +        properties:
> +          bus-width:
> +            enum: [ 16, 18, 24 ]
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723093813.1800=
89-1-francesco@dolcini.it?part=3D1
