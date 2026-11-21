Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6595606A32A
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7Vge7og
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCB310E965;
	Sat, 21 Nov 2026 11:09:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480A010E965
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 11:09:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09D0443354;
 Sat, 21 Nov 2026 11:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35EC1F000C0;
 Sat, 21 Nov 2026 11:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795259364;
 bh=jm9iGnEOZUBT4S65MLfIOKx/HquVM3674BVINWFFw9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U7Vge7oguDE5mXpfvowMRoJpoL1YiqyyRwGq/E4QooWLckmIvJLmtSfzVkhZ4mFS6
 KzAyVwejI3acu6T1oEli6UkfekGmAqVoCosFh6hoqGPqPAhHBZBtFPoEWUMDHDW9Tn
 3Vsi7O658H82KzlsmfamCQB2yl2Va2LtX2QPxKK/9YmdRMwy7p3+YXazbRydkjwFzC
 NSUNfHQOzPzIczwWdSKEczUQFGtOOebGUXaDrR5JV8wND98w4/vi687aWVoCYx7cb8
 STaWN4fsjpHlNZ1674Pmtt4idXGujEzmRwB5KQI4VYb8+qyqNJ+sqgOV4dLE2uCqy6
 SxVfTGR1ItUFw==
Date: Sat, 21 Nov 2026 12:09:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adil =?utf-8?Q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: add Novatek NT36525
Message-ID: <20261121-brave-adamant-caribou-b01daa@quoll>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261120114100.978148-1-tadilhusrev@gmail.com>
 <20261120114100.978148-2-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261120114100.978148-2-tadilhusrev@gmail.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 02:40:59PM +0300, Adil H=C3=BCsrev Tepe wrote:
> Add a DT binding for MIPI-DSI video-mode panels based on the Novatek
> NT36525 controller, as fitted on the Samsung Galaxy XCover5 (SM-G525F,
> Exynos850). The panel reset (RESX) is active-low, and the panel needs
> three separate supplies (vdd/vpos/vneg) plus an optional backlight.
>=20
> Signed-off-by: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>

Still incorrectly threaded.

I asked to use b4 for a reason. If you insist on not to, then at least
follow standard process and standard guides of upstreaming work.


> ---
> v3 -> v4: no changes to this binding.
>=20
> v2 -> v3: no content change. Resent as a fresh, standalone patch
> (previously v2 1/2 was a diff on top of v1's own patch instead of a
> complete patch against mainline, which Krzysztof Kozlowski correctly
> flagged as a git-management mistake on my part; see the cover letter).
>=20
> v1 -> v2 (addressing Sashiko AI's review of v1,
> https://sashiko.dev/#/patchset/20261116070212.314228-1-tadilhusrev@gmail.=
com?part=3D1):
> - reset-gpios is the physical RESX pin, which is active-low (asserted
>   low, released high); describe it as such (GPIO_ACTIVE_LOW in the
>   example) instead of GPIO_ACTIVE_HIGH. The matching driver fix is in
>   "drm/panel: add Novatek NT36525 panel driver".
> - Add vpos-supply and vneg-supply: the driver requests three separate
>   regulators ("vdd", "vpos", "vneg"), but the binding only declared
>   "vdd-supply".
> - Add backlight: true so dtbs_check accepts the backlight property the
>   driver already parses via drm_panel_of_backlight(), instead of
>   switching additionalProperties to unevaluatedProperties (which would
>   also pull in every other panel-common.yaml property, not just this
>   one).
> - Fold the compatible string into a single, driver-matching value
>   (novatek,nt36525-xcover5) instead of samsung,xcover5-nt36525, which
>   never matched the driver's of_match_table at all.
> ---
>  .../display/panel/novatek,nt36525.yaml        | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novat=
ek,nt36525.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36=
525.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.=
yaml
> new file mode 100644
> index 000000000..9158125c9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36525.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/novatek,nt36525.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Novatek NT36525 MIPI-DSI panel
> +
> +maintainers:
> +  - Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>
> +
> +description:
> +  A MIPI-DSI video-mode panel driven by a Novatek NT36525 controller,
> +  720x1480. The first compatible string names the specific panel as fitt=
ed
> +  in a device; the second is the NT36525 controller it is based on. The
> +  panel reset (RESX) is active low.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - novatek,nt36525-xcover5

I don't get it, what is xcover5? This claims it is Novatek device. Why
isn't this actual panel manufacturer?


> +      - const: novatek,nt36525
> +
> +  reg:
> +    maxItems: 1
> +    description: DSI virtual channel
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: panel logic power supply (vdd_ldo28, 1.8V)
> +
> +  vpos-supply:
> +    description: LCD positive bias supply
> +
> +  vneg-supply:
> +    description: LCD negative bias supply
> +
> +  backlight: true
> +
> +  port: true

I don't understand why this cannot be part of other bindings... looks
exactly like nt36536 or nt36672a


> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - vdd-supply
> +  - vpos-supply
> +  - vneg-supply
> +  - port

Drop port

> +
> +additionalProperties: false

Best regards,
Krzysztof

