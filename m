Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B9C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0AE10E4AD;
	Mon,  7 Sep 2026 12:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i+Kz8fQB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA1010E4AD
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:01:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B4FC60D83;
 Mon,  7 Sep 2026 12:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8803F1F00A3A;
 Mon,  7 Sep 2026 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788782477;
 bh=B2+CX1iKeAvs4jZi/vkpnwJAkSMw0fBzKnVpJRb9tmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i+Kz8fQBJA3oPpjd6dZp56m4HhBJilmuZuSpwXWm1codPZ6l5Jfz06kuTmjM4bq2y
 kcV4R/yKqP+LckVnIet8+5g8Hj93D4qnupItVU3yQ3HUvtVZo/QOhSEEGDuhp2T4+v
 CDvs8uAdQ+0/F/4UB8p8LVVM0TuZZmRu3hLSg7iHPp0C14lFKl82A5EOQgQROUYni9
 97yMDiTKKbUTg5+A4WkdZ/AQScjeRrhOimLPqFwqWK5SiH4+HZYs3OGmLrBiae1qgQ
 2BwLmN2ERu8xcVcUExo2FBGIH2atytRzJZAuPxenN+aKgOcBGpOjn6h1FqYd8cil4V
 tkhBTTNUGWJmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Samsung AMS662ZS01
To: "Vsevolod Nevorotov" <sevanevorotov29@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260907115130.95394-2-sevanevorotov29@gmail.com>
References: <20260907115130.95394-1-sevanevorotov29@gmail.com>
 <20260907115130.95394-2-sevanevorotov29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:01:17 +0000
Message-Id: <20260907120117.8803F1F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The binding introduces a custom `vout-gpios` property instead of us=
ing a standard property or a regulator node.
- [Low] The device tree example assigns the exact same active pinctrl state=
 to both the default and sleep states.
--

commit 35f05d4d7ea0faa656ae9f5edd021117b1b534c6
Author: Vsevolod Nevorotov <sevanevorotov29@gmail.com>

dt-bindings: display: panel: Add Samsung AMS662ZS01

Add Device Tree binding documentation for the Samsung AMS662ZS01
FHD+ AMOLED DSI panel found in the OnePlus 9RT smartphone.

> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams6=
62zs01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams66=
2zs01.yaml
> new file mode 100644
> index 0000000000000..b2697d140edef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,ams662zs01.=
yaml
[ ... ]
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vout-gpios:
> +    maxItems: 1
> +    description: Panel VOUT enable GPIO line

[Severity: Low]
Is a custom vout-gpios property required here?

Using custom GPIO properties for standard panel functionality like power
enabling fragments the device tree ABI and prevents the use of generic
driver infrastructure.

Could this be modeled with standard paradigms instead, such as
enable-gpios or a regulator-fixed node?

> +
> +  vddio-supply:
> +    description: 1.8V I/O power supply
[ ... ]
> +            vddio-supply =3D <&vreg_l12c_1p8>;
> +            vdd-supply =3D <&vreg_l13c_3p0>;
> +
> +            pinctrl-names =3D "default", "sleep";
> +            pinctrl-0 =3D <&mdp_vsync_active>;
> +            pinctrl-1 =3D <&mdp_vsync_active>;

[Severity: Low]
Should the sleep state use a different pin configuration?

The example assigns the exact same active pinctrl state (&mdp_vsync_active)=
 to
both the default and sleep states.

Since device tree examples are frequently copied verbatim into production
device trees by developers, using the active pin configuration for the
sleep state defeats power management and can lead to increased power
leakage during system suspend.

> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint =3D <&mdss_dsi0_out>;
> +                };
> +            };
> +        };
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907115130.9539=
4-1-sevanevorotov29@gmail.com?part=3D1
