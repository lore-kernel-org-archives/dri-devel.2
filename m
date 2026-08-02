Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB4C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 12:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C5310E16A;
	Sun,  2 Aug 2026 12:29:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H2OmZJER";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B5B10E16A
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 12:29:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id BFFF043B77;
 Sun,  2 Aug 2026 12:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C46541F000E9;
 Sun,  2 Aug 2026 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785673758;
 bh=SHSGsM0vu6t3zdEJHGFOqvnDDQ/hs9cDuA8s50LeKfA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H2OmZJERCYxtrOOph6nrStzZdf9Px2+Qu52EKRUMyRnmj4QfSbClOGXvOwLQl/4aA
 QXrUGppcGBhRWhY9tW992RTQ83AkGGQJozNyGViEgllW7DJ8ayJ1pfg/mDZfKLYM+O
 iaCJu9ozHHoC9OJbqbp8GE2FXVc48vGCq9wTtZKsOYsPdu40/jveDStEa4FnAS8dvh
 eBwmazAysE+S1N5/1Od2as8vkHZiBiRzJzW/3NReG/Vr6BQSlyRO9SCgOFK91LoO0Z
 4Wat2UmYU94tkzX5l86TF3Srukt7Yi+4nQ/P5F5pqFRu3Ol3LaLh9TJ1K2EelnS/lt
 PpuVHx/cRwcTg==
Date: Sun, 2 Aug 2026 14:29:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
 Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Lee Jones <lee@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>,
 Paul Walmsley <pjw@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Richard Cochran <richardcochran@gmail.com>, Jens Wiklander <jenswi@kernel.org>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 YC Hung <yc.hung@mediatek.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Sean Wang <sean.wang@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-arm-msm@vger.kernel.org, 
 linux-ide@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, 
 mfd@lists.linux.dev, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 linux-pm@vger.kernel.org, netdev@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Correct white-space style
Message-ID: <am83ac93gyowUgSQ@monoceros>
References: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ynduf7ixmtnk7fvw"
Content-Disposition: inline
In-Reply-To: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
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


--ynduf7ixmtnk7fvw
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: Correct white-space style
MIME-Version: 1.0

On Sat, Aug 01, 2026 at 09:56:14PM +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues, like double space after '=3D' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> [...]
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml b/Docu=
mentation/devicetree/bindings/pwm/pwm-sifive.yaml
> index bae993128981..40397bdf2d69 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.yaml
> @@ -62,7 +62,7 @@ additionalProperties: false
> =20
>  examples:
>    - |
> -    pwm:  pwm@10020000 {
> +    pwm@10020000 {
>        compatible =3D "sifive,fu540-c000-pwm", "sifive,pwm0";
>        reg =3D <0x10020000 0x1000>;
>        clocks =3D <&tlclk>;

I'm ok with this change (as &pwm is unused in the example), I also don't
care much about this not being a whitespace only change and thus not
really matching the commit log.

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org> # for Documentation/devi=
cetree/bindings/pwm

Best regards
Uwe

--ynduf7ixmtnk7fvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpvOBgACgkQj4D7WH0S
/k5+WQf8CivH89faKCp48CBlupnrahHpA3qdaBm48BnUdJduo4BaximYlTqDGSxO
NXL529LwysgvuiHkOxrg9bUdk/Lx68V5xZboTmO5BFwMGnqiXaazc9iWfyHrau7M
YVderOTLj5yWcB/0FkMdHb59nmaH6H3DTA7lTyzhEH2rK1e56Xe0bWxXn5wPx//K
Fg6BzFpjoO28RLKp88OCsgzFiu3Y6yaJNenCx2MeV0T15/L721ZmHJDKsQqu5iDJ
iXzPSntzwtR7HAs/3NUW1jSaAV2Jq41LUqlqjX4CeZDwSDaX6iquowVSJDhJvYuK
ZtKTkgqchOdbv2qhQEqje3UkwK9pWQ==
=9CRH
-----END PGP SIGNATURE-----

--ynduf7ixmtnk7fvw--
