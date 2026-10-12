Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06003CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF9410E408;
	Mon, 12 Oct 2026 09:02:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0F710E408
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 09:02:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0D55401A3;
 Mon, 12 Oct 2026 09:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579961F0089B;
 Mon, 12 Oct 2026 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791795761;
 bh=4ygGT1q+20Db1BG+IgE8FMhqgOcpAkXpmhkCaZJrgqw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l3AKoAoCa8Y9bbgyaIHkNnPHlTaVh72F4tloPgu/1sE2Djbtrz5Of2OXIaiQdJ+WB
 VWXbOz6nfBv+j6ERhlidrbMy/1M7qko+3EtW7CcZFQEaSDTQlgdHptzhm16pGTNXMB
 M1HoOGQ82xhoEiLvFGDfCLDK8KGbIz0wmvRuPzQv9qNTbVx+tm6LSBQIlLEoC4MnV9
 i5C/oHX8CPOlPMhSU2L7UA01JuiUPBk+ouoAOL2MyVwFWWXAt+5Vl6hHS5mL6BTSti
 7zJxXIaL0quQ/7KV/x+sU7PIhyGCA/Q2Mswoq4h7nHpoxXPBQVMNulZqWpu0nPwHt+
 56ShISZQv6lwg==
Message-ID: <sashiko-outbox-167879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: display: ti,tpd12s015: Convert to
 DT schema
To: Quchaosheng <quchaosheng000406@163.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261012085237.377612-2-quchaosheng000406@163.com>
References: <20261012085237.377612-1-quchaosheng000406@163.com>
 <20261012085237.377612-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 09:02:40 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: display: ti,tpd12s015: missing minItems and require=
d for gpios
--

commit fc9c522935b9c669ac75f93cec8daaa7860a7102
Author: Chaosheng Qu <quchaosheng000406@163.com>

dt-bindings: display: ti,tpd12s015: Convert to DT schema
   =20
Convert the TPD12S015 HDMI level shifter binding to DT schema.
The TI TPD12S015 is an HDMI companion chip that combines a level shifter
and ESD protection circuitry. Document the two ports it exposes between
the HDMI transmitter and the connector.

> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 0000000000000..5955f2e6421c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
[ ... ]
> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first contr=
ols
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    maxItems: 3
> +
> +  ports:

[Severity: Medium]
Is it possible this schema should enforce a minimum item count and require =
the
gpios property?

If a device tree omits gpios or provides fewer than 3 items, the schema
validation will pass because it only defines maxItems: 3 and omits gpios fr=
om
the required list.

However, the driver unequivocally requires the third GPIO item (index 2).
If absent, the probe fails:

drivers/gpu/drm/bridge/ti-tpd12s015.c:tpd12s015_probe() {
    ...
	gpio =3D devm_gpiod_get_index(&pdev->dev, NULL, 2, GPIOD_IN);
	if (IS_ERR(gpio))
		return PTR_ERR(gpio);
    ...
}

Should the schema enforce minItems: 3 and add gpios to the required list to
match the driver's mandatory requirement?

Additionally, due to a preexisting bug in the driver, if this probe aborts =
it
will leak the tpd->bridge.next_bridge module reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012085237.3776=
12-2-quchaosheng000406@163.com?part=3D1
