Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F9C55175
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:34:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528F410E4B2;
	Mon,  3 Aug 2026 08:34:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NPXLqTlI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC7210E4B2
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:34:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0937600FF;
 Mon,  3 Aug 2026 08:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9151F000E9;
 Mon,  3 Aug 2026 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785746051;
 bh=ocpvpi2NArcOC90TKmTQCVuO5qbsZgPqGuWVp8yEIuI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NPXLqTlIUfHO078x2ULmPwHFX1vR8hBeUdnGadGMw4sVH6YS043Vf/FDqGeMlVt7f
 +wsEx8DqIGWTUKy6p9xZ5QEYNV5JQ/kullic4Do43hNeCfaza65gKYylchNLo754r7
 Cm3vsqWnl3y6bZdXuH7PkTafqWvfPzZQllH96NWhHoMUWx3tJ8Smhyby84cfkO9EqX
 HJ3w/q1y/tIWjVVII164anOsoZY0xijCTOJPEIfN8t/fzMw6WDR6F7nJYVtSmsYyzF
 vkkZ3/Q7AGpKPX3RmgV1BmwuNwOwJvbWyE5s4wbsgZ9mX7wfKp9U3G4PhOL89QQDXA
 NCS12Mf9uTGuw==
Date: Mon, 3 Aug 2026 10:34:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 01/16] dt-bindings: display: bridge: renesas,dsi:
 Document RZ/G3L
Message-ID: <20260803-prodigious-brave-myna-08deb7@quoll>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
 <20260729125516.230757-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729125516.230757-2-biju.das.jz@bp.renesas.com>
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

On Wed, Jul 29, 2026 at 01:54:53PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> The RZ/G3L DSI IP is similar to the RZ/G2L but has different global PHY
> timings and also the PLLCLK is ungateble clock. Add the compatible
> string "renesas,r9a08g046-mipi-dsi" to handle these difference for the
> Renesas RZ/G3L SoC. The power to DSI region is controlled by SYSC block.
> Document renesas,sysc-pwrrdy property to handle the power control.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped renesas,sysc-pwrrdy property as it is modelled as power
>    sequence.
> ---
>  .../devicetree/bindings/display/bridge/renesas,dsi.yaml          | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

