Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EEAC5CFC1
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 03:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822A510EE0F;
	Wed, 12 Aug 2026 03:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fuU7ipvf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DD110EE0F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 03:10:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CCA5C600E2;
 Wed, 12 Aug 2026 03:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6661D1F000E9;
 Wed, 12 Aug 2026 03:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786504246;
 bh=LE3W24wS75BSIMOFlefIC8ZjafXejnzU7cRNPUtlVmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fuU7ipvftV6NBq8GsZ6wtII+FkKlGgo80Jqmt2JbzmsXhE4gnwgJKawgPDN9wG/1B
 Xw8XCIZgy1JFVwCMFUpQcRmaKnDK30nB7/wCogNa0Iy2al1VM5ME5Zr8jL9MCLhsYa
 bwFkvui5xsFY9VpdMACj8p05FGQef82RvfQcqPaDDg3t6xAyFwjFQaE89a8fUIxsJ/
 v42n+fkQI2XcEOHJR8m89ySzGT4WOxXjLJ0IggOB4syQ7a2cvGi//hQP1U7bpcDpIw
 5n8pvvX1+SnYh/nKzqe+7gmFFQ1iYZg/mYlD8/Re1SzLvq6KkIrZ6yMsWLYJJgXR5W
 L+Z8EimPAYWkg==
Date: Tue, 11 Aug 2026 22:10:45 -0500
From: Rob Herring <robh@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: backlight: Add Orient Chip OCP8178
Message-ID: <20260812031045.GA657686-robh@kernel.org>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-2-wf@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806201541.101304-2-wf@dewith.io>
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

On Thu, Aug 06, 2026 at 10:15:40PM +0200, Wim de With wrote:
> Add device tree bindings for the Orient Chip OCP8178 LED backlight
> driver.
> 
> Signed-off-by: Wim de With <wf@dewith.io>
> ---
>  .../bindings/leds/backlight/ocs,ocp8178.yaml  | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> new file mode 100644
> index 0000000000000..9a4df1ef91edd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ocs,ocp8178.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ocs,ocp8178.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Orient Chip OCP8178 backlight
> +
> +maintainers:
> +  - Wim de With <wf@dewith.io>
> +
> +description: |

Don't need '|'.

> +  The Orient Chip OCP8178 is a white LED backlight driver controlled by a single
> +  GPIO line with a vendor-specific onewire protocol.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ocs,ocp8178
> +
> +  enable-gpios:
> +    description: GPIO to use to enable/disable and dim the backlight.
> +    maxItems: 1
> +
> +  default-brightness:
> +    maximum: 31

blank line

> +  max-brightness:
> +    maximum: 31
