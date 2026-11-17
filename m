Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CAF606A339
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hT9/RG+r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F99910F8D0;
	Tue, 17 Nov 2026 19:39:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF01A10F8D0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 19:39:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9ACE54050E;
 Tue, 17 Nov 2026 19:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CCD1F000C4;
 Tue, 17 Nov 2026 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944365;
 bh=rj4/yU3Ef/aUBJSMi8YMnFqrbci/YNnHa0upd+SN5Z0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hT9/RG+rRpEkT4IozMC9bRCUWb1qS6zd0zGYzfgDt+wCgo0mUHwzwqyfDC28ATCO+
 s8hhus94B7ztUYtOLqnNC6QczFLVS0pxPVfCA3QVyXO6V9RFdC78s5GfhDI2VWybVJ
 qW3Xf1lVp8PJRADcEHqMnRGQ/xlcvo4MeDW5aSL0o3c2BYZyc8ki64SMrgNns/22I3
 2T/ZQSKR4s5YgfghsicCsVGq0cpyAQZlvKzZ1yYK5Rln0mreLDZucosu6eP/SynHx+
 pjSW3YVQRxpZN8MZXMwAr9tg6IuuU8XItLnkEafEnPz3Cs7KXMtXBEvyltcPvIqiUM
 Qk2kc1TPV0pNw==
Message-ID: <sashiko-outbox-219508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Add hdmi-phy child node
To: "Ronald Claveau" <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
 vkoul@kernel.org, olteanv@gmail.com
In-Reply-To: <20261117-meson-drm-create-hdmitx-phy-v1-3-9e0ac931381c@aliel.fr>
References: <20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr>
 <20261117-meson-drm-create-hdmitx-phy-v1-3-9e0ac931381c@aliel.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:39:24 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: soc: amlogic: unwieldy conditionals in
  meson-gx-hhi-sysctrl.yaml
--

commit 2922cae8c47e87d6a0fd71e91e4a07690e4d0f66
Author: Ronald Claveau <linux-kernel-dev@aliel.fr>

dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Add hdmi-phy child node

This commit adds an optional hdmi-phy child node to the Amlogic Meson
system controller binding for amlogic,meson-gx-hhi-sysctrl and forbids it
on the other system controller variants.

> diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-=
gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic=
,meson-gx-hhi-sysctrl.yaml
> index 285edac4c0821..97e47592aff2e 100644
> --- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-=
sysctrl.yaml
> +++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-=
sysctrl.yaml
> @@ -36,6 +36,9 @@ properties:
>    phy:
>      type: object
> =20
> +  hdmi-phy:
> +    $ref: /schemas/phy/amlogic,meson-hdmi-tx-phy.yaml
> +
>  allOf:
>    - if:
>        properties:
> @@ -50,6 +53,7 @@ allOf:
> =20
>          pinctrl: false
>          phy: false
> +        hdmi-phy: false
> =20
>    - if:
>        properties:
> @@ -80,6 +84,7 @@ allOf:
> =20
>          power-controller: false
>          phy: false
> +        hdmi-phy: false
> =20
>    - if:
>        properties:
> @@ -104,6 +109,7 @@ allOf:
>            oneOf:
>              - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
>              - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
> +        hdmi-phy: false

[Severity: Low]
Would it make sense to split these system controller variants into
separate schema documents instead of adding more per-compatible
exclusions here?

This schema covers five system controller compatibles across different SoC
families and register blocks (HHI and AO), where nearly every child node
property (clock-controller, power-controller, pinctrl, phy, and now
hdmi-phy) differs across variants and has to be overridden or forbidden in
overlapping allOf if-then branches.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-meson-drm-=
create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr?part=3D3
