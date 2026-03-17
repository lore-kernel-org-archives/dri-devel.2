Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3227BF3380A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8926A10E4A8;
	Tue, 17 Mar 2026 07:33:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CA8CgmxO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C80910E4A8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:33:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4620B40ABD;
 Tue, 17 Mar 2026 07:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEB8C4CEF7;
 Tue, 17 Mar 2026 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773732785;
 bh=IFqjMBE1/ZQMZCgU1rzj3A/SIfAKjPz7mxOs6XM0BFg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CA8CgmxOrqFgkTQwayqb0nuuNjWAwzUKKxov6JFm4QtcRbPCwhaj7FgM0RLggFo0/
 assnYE0Hbq8Vq6ZumES14AHqvXSUSO2mVREm3t+0jN/jOSCComIc2iEzmyvg/W1YpC
 +ISDEjkiwY/Pi8/dgPdYEtPWyexF6Rscd7BR4MZiTg9QdgvSOLQmSwShtA82ZBr3Q7
 tc2OcdwI6dVXoq0rrAy84ofbC096LkTsGMhCwia/URX/AgMrrwIKW5d8iWWqFF/PjN
 zs8CoMjYzrSl+nCy7NN9uvguL51IJ4liNlUZOQuQIRzdzXCB7ZT/sJPdwfFPMG83tb
 kMwceiNcANLgA==
Date: Tue, 17 Mar 2026 08:33:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver bindings
Message-ID: <20260317-helpful-proficient-pronghorn-ef5e1f@quoll>
References: <20260317-ch13726a-v2-0-28aa46bcd6d0@gmail.com>
 <20260317-ch13726a-v2-1-28aa46bcd6d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317-ch13726a-v2-1-28aa46bcd6d0@gmail.com>
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

On Tue, Mar 17, 2026 at 12:23:07AM -0500, Aaron Kling wrote:
> The Chip Wealth Technology CH13726A display driver is a single chip
> solution for AMOLED using MIPI-DSI. This is used for the AYN Thor bottom
> panel.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Also drop all references to "display driver", even if you meant hardware
thing.  Driver in hardware is suitable only to motors, haptics and LEDs,
but not to displays. AMOLED driver is fine, display driver too confusing.


> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../display/panel/chipwealth,ch13726a.yaml         | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..b490c6757bb98c0752ded78b8fea3aaec853c7b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Chip Wealth Technology CH13726A display driver
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description:
> +  Chip Wealth Technology CH13726A is a single-chip solution
> +  for AMOLED connected using a MIPI-DSI video interface.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ayntec,thor-panel-bottom

Why compatible is completely different than commit msg, description and
title are saying?

> +
> +  port: true

This goes before reset-gpios

> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +  vdd1v2-supply: true
> +  avdd-supply: true
> +
> +  reset-gpios: true
> +

Drop blank line here (it is port+reset-gpios+rotation in three lines).


> +  rotation: true
> +

Best regards,
Krzysztof

