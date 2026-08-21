Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5DAC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 17:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7227010E333;
	Fri, 21 Aug 2026 17:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KW0EItDg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CF510E333
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 17:23:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FEDC61126;
 Fri, 21 Aug 2026 17:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D8F1F000E9;
 Fri, 21 Aug 2026 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787333008;
 bh=YWUzwAz2gglOPhDQRZ+3MLEbMpUfiyg15km1lbgLClE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KW0EItDg/p2K/B1rbN/IC5VfFeikrMXLMG8LKHHGxgMBR41alZRlnd9N8i4yCSopc
 Kie9qLO3Avt9UTxiwhby0P0xq+HTL78U7anbXvLc9oZ/dRVSnoEMqTH5VKV6uC+a06
 yolEOo2QkGsOwLydFzPr5Os4ldXqWeSscMTtCp1ck9LSZ0I8CMP32CVU4E0YUK6yIP
 PqkEksuu2CFKuVi/IoZdQqJ5j5+T3OSE3pQ8QHrOhyuC4t9D1M7e+n8RFkkK1xBnYh
 UwZVcjEG5mSokn2BsRrg1TI+0l+kj6rZkPLOZF7KIJik2v2JieoRXONnFx79tOrd7T
 XbxLuD+e0KrDg==
Date: Fri, 21 Aug 2026 18:23:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Document 10"
 Raspberry Pi Touch Display 2
Message-ID: <20260821-naturist-eagle-f691527ae813@spud>
References: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P/iFS2tr70btybGJ"
Content-Disposition: inline
In-Reply-To: <20260820185506.84448-1-marek.vasut+renesas@mailbox.org>
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

--P/iFS2tr70btybGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 08:54:27PM +0200, Marek Vasut wrote:
> Document the 10" Raspberry Pi Touch Display 2 MIPI-DSI TFT LCD panel.
> The panel is based on the Ilitek ILI79600A controller.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jessica Zhang <jesszhan0024@gmail.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Extend existing ilitek,il79900a.yaml document instead of introducing
>     new one. Note that the il79900a should likely be il_i_79900a, but the
>     binding document already shipped in Linux 6.19.y , so this can not be
>     fixed anymore ?

Should it? Website says il79900a:
https://www.ilitekholding.com/en/product/Mobile (ctrl + f)

Your new device also has no second I there.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Cheers,
Conor.
> ---
>  .../bindings/display/panel/ilitek,il79900a.yaml     | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,il799=
00a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.=
yaml
> index 02f7fb1f16dc7..f8644e9a4478d 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,il79900a.yaml
> @@ -14,10 +14,15 @@ allOf:
> =20
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - tianma,tl121bvms07-00
> -      - const: ilitek,il79900a
> +    oneOf:
> +      - items:
> +          - enum:
> +              - raspberrypi,dsi-10inch
> +          - const: ilitek,ili79600a
> +      - items:
> +          - enum:
> +              - tianma,tl121bvms07-00
> +          - const: ilitek,il79900a
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.53.0
>=20

--P/iFS2tr70btybGJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaoiJigAKCRB4tDGHoIJi
0nMeAP9lEw/ySMu5b7F8tSgGWV0PUvqqjkIrOhlKMp0LJvc1aQD8COjKK1tTBCyC
msN5oMXiKpEgYQpp7zKg/ZQykN6NNwM=
=04aB
-----END PGP SIGNATURE-----

--P/iFS2tr70btybGJ--
