Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41743606D835
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhKpbDLi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC3910F5D8;
	Tue,  3 Nov 2026 14:05:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3C110F5C5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 14:05:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FB8741AF7;
 Tue,  3 Nov 2026 14:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9067A1F00A2C;
 Tue,  3 Nov 2026 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793714719;
 bh=bF7qGpdtN0WIrQT8+FBNrErYPWOmZTo7dWkERTkp0DY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GhKpbDLia+ePgaenqQHOfJQOjb2rh86uzpnEuGIj8tTEmWCLbyq1lvnZ4EFDyuPxH
 Vv0rd000DCFwH6xiDLBmoAkk7GTDD1IqDLk6hF64Jy3rbTzqzdJ4G1tSurY8v0/YzX
 FvH2io3WUnl1/JErrbGdQBu8ynP4m/azATLPEta2b1s7I2UsTHIVjO+zSoheO5j5qG
 W9j8814TttOmhTo8R448UZseXBdBiOYQtyAXesqB0Wf/VJcGTNdht2Sv+k5M8I0glO
 V1+JrGK55NW7cdIZYxrgga8xmc0BKJAP/pQ4Y9OqI/R9JR7TBKuHOoxJUyvQgW7kII
 hPIt7jsO9Pl3g==
Date: Tue, 3 Nov 2026 14:05:13 +0000
From: Daniel Thompson <danielt@kernel.org>
To: rva333@protonmail.com
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: backlight: add Kinetic KTD3137
Message-ID: <aunqGVkX7-Y61iDA@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com>
 <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-6768-ktd3137-v1-1-b5b4f903c56e@protonmail.com>
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

On Mon, Nov 02, 2026 at 09:58:48PM +0200, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>
> Kinetic KTD3137 is an LED IC, used in various mobile devices for the
> display backlight. Add devicetree bindings documentation for this chip.
>
> Datasheet: https://www.kinet-ic.com/uploads/KTD3137-04a.pdf
>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/leds/backlight/kinetic,ktd3137.yaml   | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 69 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
> new file mode 100644
> index 000000000000..140615640a9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/kinetic,ktd3137.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/kinetic,ktd3137.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Kinetic Technologies KTD3137 LED Backlight
> +
> +maintainers:
> +  - Roman Vivchar <rva333@protonmail.com>
> +
> +description:
> +  The Kinetic Technologies KTD3137 is an I2C LED backlight driver for medium
> +  to large size LCD panels.
> <snip>
> +  led-max-microamp:
> +    minimum: 5000
> +    maximum: 29800
> +    default: 20200
> +
> +  vin-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vin-supply

Why is vin-supply required?


Daniel.
