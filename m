Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFCFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D7F210F018;
	Wed,  8 Jul 2026 08:30:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fm0grg32";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B39EC10F018
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 08:30:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 60ADA60008;
 Wed,  8 Jul 2026 08:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353A81F000E9;
 Wed,  8 Jul 2026 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783499435;
 bh=bjtxR6NUe5F9tzlvYSS82b87oLOzar11BDinoTrndlg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fm0grg32GQ29cQ6XWZw8mrwbqmtTGNsuX/EuGF+uW/cSLlZo5vOkZQVFRB4ia9EvZ
 1I0Qnj143U8Jan09r+DQGW2iUdkdVU2WtJ94f49BvlqRWgsrUqtBMohI205zeetcU4
 il+4iNMxqqa/SP7SVYh773xmo7zzl4FkjvtTn8Le3oqOLOoBnBfnYcHcu7f8osM2Q0
 5JniP2rJNYPgVolBC9SkH/LDB02of6ttEnqrYcdvEwKXCwE/BCYrSqAjXlgsTSandQ
 7WwovceXdRAJX4lHs1Ya/gTcrED7QEfTTHP+o7TO6Q+SgsifHerCKYoGxmye5P52cR
 MahYs0gM/PFug==
Date: Wed, 8 Jul 2026 10:30:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, 
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 07/16] dt-bindings: display: renesas,rzg2l-du: Document
 RZ/G3L SoC
Message-ID: <20260708-satisfied-mammoth-from-betelgeuse-d4fe94@quoll>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
 <20260704093433.273672-8-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260704093433.273672-8-biju.das.jz@bp.renesas.com>
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

On Sat, Jul 04, 2026 at 10:34:17AM +0100, Biju wrote:
>        model-dependent. Each port shall have a single endpoint.
>  
>      patternProperties:
> -      "^port@[0-1]$":
> +      "^port@[0-2]$":
>          $ref: /schemas/graph.yaml#/properties/port
>          unevaluatedProperties: false
>  
> @@ -88,7 +89,6 @@ required:
>    - clocks
>    - clock-names
>    - power-domains
> -  - ports

Why doing this change?

>    - renesas,vsps
>  
>  additionalProperties: false
> @@ -108,6 +108,7 @@ allOf:
>              port@0:
>                description: DPI
>              port@1: false
> +            port@2: false

Best regards,
Krzysztof

