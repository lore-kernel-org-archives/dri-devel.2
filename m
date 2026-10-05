Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C19CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC9D10E234;
	Mon,  5 Oct 2026 16:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P7IqcPkZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F006610E234
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 16:31:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DFBD260204;
 Mon,  5 Oct 2026 16:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CD91F00893;
 Mon,  5 Oct 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791217897;
 bh=w9KjakV6Ms9jin0wX9osmpzk77dx7kQIFeLApUKCnxk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=P7IqcPkZqOXmZp1QAhv6wsHZG7M8U/SR/dOIoI3eWTjJiCZuK/Y/G3sF5+NcNiyzP
 mGwySL1nUlU6y2kbb4BrMGagAm02WFOjtrVMi5ThzENnVBNgXT7Aapr/RrMgIQmBof
 fTGR/gcop636uC6n6dsjZyqdASXVPy4PPa38Pv0h7q5NCUz6ciqhq/Kv59CMFwlprg
 s9LHxpGMDOB5JY9T2Qh2N9YxnMBhG2avB5bLay51hpVOx7swoi0Z7STXlwAkIoJKzb
 73+Dt5M2ZwLxqbg44tCkKo1P5YiGCuDAxFLBkNPWd4BVsfR7nDw8+G2D2Wvnk7Q7hz
 BcirUN376L+mQ==
Date: Mon, 5 Oct 2026 17:31:32 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mfd: Document Skyworks AAT2870
Message-ID: <asPQ5FgHe87XQJBT@aspen.lan>
References: <20261004164121.193514-1-clamor95@gmail.com>
 <20261004164121.193514-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004164121.193514-2-clamor95@gmail.com>
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

On Sun, Oct 04, 2026 at 07:41:19PM +0300, Svyatoslav Ryhel wrote:
> Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
> Management Unit.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/leds/skyworks,aat2870.yaml       | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> new file mode 100644
> index 0000000000000..014678616076f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
> @@ -0,0 +1,127 @@
> [snip]
> +  backlight:
> +    $ref: /schemas/leds/backlight/common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      compatible:
> +        const: skyworks,aat2870-backlight
> +
> +      led-max-microamp:
> +        minimum: 450
> +        maximum: 27900
> +        default: 450
> +
> +      max-brightness:
> +        default: 255

Should there be a min/max here as well?


Daniel.
