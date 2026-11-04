Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DE606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pvz2YZjf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E8110FADA;
	Wed,  4 Nov 2026 10:19:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADF710FADA
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 10:19:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 539C34086B;
 Wed,  4 Nov 2026 10:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D61F00919;
 Wed,  4 Nov 2026 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793787591;
 bh=BMJAeeHG0qYGoI2GU3+poE+h3EQOoLT+qGKvd7z2UJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Pvz2YZjfwVSEC87caXNLTPxgsuZ1LrbWeiT3mvV0+MgYYN9KGE7E3KXcb6eSDiHsS
 X7H+lCu3PiSjfyInOu8XFDFw72+CuN43tGcqjQLFPE6LHcN4xoKXy+lMRualnn7xjs
 lpZfa3Tcr8FF++rOSiedk5OtKzCcsbD1PLrYem/3gbIwUKLQXy06fg6PeMiAEeQCLs
 XAsWi/iBszSHAUlOv/kjtAXLNgzHL7P/tghGLtGcqNoMwCib7dTs45gIY0DrPQP3yL
 HCNpwaOirw+lPwhlwmQzXCPvqycjcyzxzK2BGTOGMyussZm+f+rYMwwRlsSMb39CJF
 jHUtmTyjmud5A==
Date: Wed, 4 Nov 2026 11:19:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: tomm.merciai@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com, 
 linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 02/10] dt-bindings: display: Document Renesas RZ/G3E
 display subsystem
Message-ID: <20261104-lurking-griffin-of-tornado-ca7ac8@quoll>
References: <cover.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
 <71044c23cbd6698d495db101527725bd7607197f.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71044c23cbd6698d495db101527725bd7607197f.1792770965.git.tommaso.merciai.xr@bp.renesas.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 06:47:35PM +0200, Tommaso Merciai wrote:
> The Renesas RZ/G3E (R9A09G047) SoC has two LCD Controllers, LCDC0 and
> LCDC1, each containing a Display Unit (DU). The two DUs are separate
> instances of the same IP, with their own registers, interrupt, clocks,
> reset and VSP, and are therefore described by two device tree nodes.
> 
> The DSI encoder and channel 1 of the LVDS encoder can be fed by either
> DU, the source being selected at runtime. Driving those outputs from
> either DU requires handling both DUs as a single display subsystem.
> 
> Document the renesas,r9a09g047-display-subsystem node that groups the
> two Display Unit instances.
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> ---
> v8->v9:
>  - New patch.
> 
>  .../renesas,r9a09g047-display-subsystem.yaml  | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml b/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
> new file mode 100644
> index 000000000000..e23cc53a1fea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/renesas,r9a09g047-display-subsystem.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/renesas,r9a09g047-display-subsystem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/G3E Display Subsystem
> +
> +maintainers:
> +  - Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> +
> +description:
> +  The Renesas RZ/G3E display subsystem is a virtual device needed to list the

We do not take bindings for virtual devices, because you do not need
them. Instantiate your driver from existing bindings, instead of
creating fake device just for Linux drivers.

> +  Display Unit instances that comprise the graphics subsystem.
> +
> +properties:
> +  compatible:
> +    const: renesas,r9a09g047-display-subsystem
> +
> +  ports:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

Properties have only one type and ports is already defined as object for
graph.

Why isn't this a graph?

Best regards,
Krzysztof

