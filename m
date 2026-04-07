Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738E4EDB7CC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 08:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95E710E35B;
	Tue,  7 Apr 2026 08:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dtz+EQ+A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050F110E35B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 08:00:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 118AE600AC;
 Tue,  7 Apr 2026 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31486C116C6;
 Tue,  7 Apr 2026 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775548821;
 bh=rHrJHZY3qKMTUorqxjetQ3vNRjHoOGWipORPYTlnWcw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dtz+EQ+A8xG8udTTdM1HoVFU8+4hJXxPzbMZIP+SUCij4EeRR5307rc9i8cFmudGK
 QaMMWdbz0ya9goGUhPoHncL9DTx6f7B3dxKgxyPX5k11sYorU7PzaAiOFnGVi/OXsJ
 /TV7esJHLFqWcsj+iJIGB4q/NQ+qqQHiUybCJI28W1/o6rR8+qMGEeRSa6/51fBse0
 w+IxG+KNgONRpniAzCX8MjOL2xT9wG2Vteorm3WY/2mDJvIBGmRm7SipmkDyvHMgZF
 j0QGGxIpHx45bAnbxBrOZ8oCXFanzTVbSEPNPraWjPoN+wMjZjztjIK81sZscEEkNP
 ozzv8ti9CK2Lg==
Date: Tue, 7 Apr 2026 10:00:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: devicetree@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: bridge: lt9211: Require data-lanes
 on DSI input ports
Message-ID: <20260407-invaluable-pretty-leopard-1e8dfc@quoll>
References: <20260404034123.340818-1-marex@nabladev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260404034123.340818-1-marex@nabladev.com>
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

On Sat, Apr 04, 2026 at 05:40:18AM +0200, Marek Vasut wrote:
> The Lontium LT9211 is capable of 1..4 DSI lanes per input DSI port,
> describe the lane count for each input port in the schema.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---
> NOTE: For example Linux kernel driver does already use that information
>       and fails to probe if it is missing. There are currently no intree

The first sentence must be part of the commit msg. That is important
reason why you are doing this... but I don't see how you achieve any of
this. Look:


>       users for this binding, so no new warnings will be generated once
>       this is applied, but a new user is about to be added.

What warnings? How?

> ---
>  .../display/bridge/lontium,lt9211.yaml        | 37 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
> index 9a6e9b25d14a9..5264fb2b68b78 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9211.yaml
> @@ -36,18 +36,50 @@ properties:
>  
>      properties:
>        port@0:
> -        $ref: /schemas/graph.yaml#/properties/port
> +        $ref: /schemas/graph.yaml#/$defs/port-base

OK, that's correct.

> +        unevaluatedProperties: false
>          description:
>            Primary MIPI DSI port-1 for MIPI input or
>            LVDS port-1 for LVDS input or DPI input.
>  
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false

That's correct.

> +
> +            properties:
> +              data-lanes:
> +                description: array of physical DSI data lane indexes.
> +                minItems: 1
> +                items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4

That's almost redundant in this context - it was already there - and the
point is that it solves noting in the problem you had. Binding still
does not validate the ABI and does not match it, still.

Since commit foo bar, driver needs data-lanes, so what you need to do is
allow them and to require them. You can also specify their constraints
if device can be configured multiple ways, up to 4 lanes.

Best regards,
Krzysztof

