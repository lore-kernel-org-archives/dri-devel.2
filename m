Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB89606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=m1189d/x;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=fKDLwEQv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ED8911233D;
	Thu,  5 Nov 2026 10:39:58 +0000 (UTC)
X-Greylist: delayed 712 seconds by postgrey-1.36 at gabe;
 Thu, 05 Nov 2026 10:39:50 UTC
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A259F112340
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793875171; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=fqZXSa3JLwhAJbmgfOUrRrxwkeIGE3lE1q20elPby10KpnbZHXfL/LB/MGl4b+OOnJ
 b/knkOhtNSolKY9ApR+hWNd5tj3WVjHJOmt+xQVqmbtrtv3MqiZOr8685NdBE41iMByD
 vIU/DVOkK2FAdmTZNTQKm9olRgmR6E0WRxfwUCl2ecIKSOiQTs0+Omhih9RCPl7YUaN6
 I+tCNY654skNsyJedk8wKex26tUm9DQMYDb7t0qoHz6/8L21ffS7Q4n9CT3fZOFM/fGr
 6vQO+2Qk246vIpXWmX/rRYTC1xxypoVwAoO0mZNczGubHpregv3bdtas3u9M78V95tvN
 sRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793875171;
 s=strato-dkim-0002; d=strato.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=QOY1/Aph5M+b+uiCncBnpfm/tHXQ4aDgVh2l56B30Yc=;
 b=G3Foc2BD79VIefqwHGNlNBhfO/7j6snsfirdyZYxqkIrkuIrTmwvPH0Ri77DQbpXkn
 hjbEsq6Gp9q6/qt8Twod/VYwJCkdIMokM9yOeJJcCfOLaEpsWawrH1giZyMzgzcBwZX0
 joKM53tXFM2WPOb2rDTMKbDDCbvr33RSKOIGFMIN/J9FrlA0J5EqJ7qlrn52S2S/r2Kf
 CwvPv0DTnEqLuynw6en+wZzKIJ9h/PlrKlk8rwz8IEz9muGdKjRpTzXVfpJ7Z+2aCQtj
 x/uftRMIHeuxb9hfYlgNxGYMNTUrFVKan/qkuJSY/0vaAzx9ZEUkmFJLPXMuApEjCsJm
 /1xQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793875171;
 s=strato-dkim-0002; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=QOY1/Aph5M+b+uiCncBnpfm/tHXQ4aDgVh2l56B30Yc=;
 b=m1189d/xqAFdGFmoXldTi0i5Eo27ENr6L5NVWGBWy53nCDyx/E1PcbNKdPmHSKl5Ge
 eSMl4N0lco2K431q6nLjKZZHRf+9862H7kk4uK7DU22xiliR//KmqT+wjMKHUZCWMSh5
 w0vHc5I/e8kcULkNETzI84JuAs+fzmHUqrBRGVDb42u2T/JAVWvIf49wmnT+nhiIANuf
 QxrZHHvtqaLUvMXyLzlpka4HLtpdjEZGlLSey/ZfvGJNzNDCi5T4s6t/znDRWm/A9wYY
 wBrWjfYDxPezQHlehb7SAyRbWsAOkCfVFsk07/jHos7UhCuKKNO7wWgt1ARDv25431M0
 F/+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793875171;
 s=strato-dkim-0003; d=goldelico.com;
 h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
 From:Subject:Sender;
 bh=QOY1/Aph5M+b+uiCncBnpfm/tHXQ4aDgVh2l56B30Yc=;
 b=fKDLwEQvq/Rg2H4E/PZr7f233E8WJCFHd8QaYBjs3JX2jUjAKLBhNa/w6eIIGAtuBV
 LF1DWtLmOAIo+0LIE1Cw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV25oGlMiNUOZNJoYXSTSpu/Ae46f1NE9YxyvD"
Received: from smtpclient.apple by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22A5AdUiJQ
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1
 with 256 ECDH bits, eq. 3072 bits RSA))
 (Client did not present a certificate);
 Thu, 5 Nov 2026 11:39:30 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v2 4/5] dt-bindings: display: panel: Add the HiBy LG35583
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20261025191640.13592-5-olivier@mgcrea.io>
Date: Thu, 5 Nov 2026 11:39:00 +0100
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DFF1C7F-E1B7-4B06-BA1C-372F5C5984E2@goldelico.com>
References: <20261025191640.13592-1-olivier@mgcrea.io>
 <20261025191640.13592-5-olivier@mgcrea.io>
To: Olivier Louvignes <olivier@mgcrea.io>
X-Mailer: Apple Mail (2.3826.700.81.1.10)
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

> Am 25.10.2026 um 20:16 schrieb Olivier Louvignes <olivier@mgcrea.io>:
>=20
> The 480x800 parallel RGB panel of the HiBy R1, set up over a 3-wire =
SPI
> bus with 16-bit words.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> .../bindings/display/panel/hiby,lg35583.yaml  | 71 +++++++++++++++++++
> MAINTAINERS                                   |  5 ++
> 2 files changed, 76 insertions(+)
> create mode 100644 =
Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
>=20
> diff --git =
a/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml =
b/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
> new file mode 100644
> index 000000000000..19498910629c
> --- /dev/null
> +++ =
b/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/hiby,lg35583.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiBy LG35583 480x800 panel
> +
> +maintainers:
> +  - Olivier Louvignes <olivier@mgcrea.io>
> +
> +description:
> +  The 480x800 parallel RGB panel of the HiBy R1, which HiBy calls the
> +  LG35583. It is set up over a 3-wire SPI bus with 16-bit words.

I have discussed with the Google AI and it hints at that the controller
is a Novatek NT35510 / NT35580 family or derivative.

It is possible to locate data sheets for comparing the lg35583_init[]
table...

> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: hiby,lg35583

But based on the scarce information I think it is the best solution to
stay with the hiby,lg35583 compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Panel power supply
> +
> +  vccio-supply:
> +    description: I/O power supply
> +
> +  reset-gpios: true
> +  backlight: true
> +  port: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - vccio-supply
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        panel@0 {
> +            compatible =3D "hiby,lg35583";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +
> +            vcc-supply =3D <&vcc_lcd>;
> +            vccio-supply =3D <&vccio_lcd>;
> +            reset-gpios =3D <&gpa 31 GPIO_ACTIVE_LOW>;
> +            backlight =3D <&backlight>;
> +
> +            port {
> +                panel_in: endpoint {
> +                    remote-endpoint =3D <&lcd_out>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57313163e59e..e65500a70c9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8152,6 +8152,11 @@ S: Maintained
> T: git https://gitlab.freedesktop.org/drm/misc/kernel.git
> F: drivers/gpu/drm/tiny/gm12u320.c
>=20
> +DRM DRIVER FOR HIBY LG35583 PANEL
> +M: Olivier Louvignes <olivier@mgcrea.io>
> +S: Maintained
> +F: Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
> +
> DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
> M: Ondrej Jirman <megi@xff.cz>
> M: Javier Martinez Canillas <javierm@redhat.com>
> --=20
> 2.39.5


BR and thanks,
Nikolaus

