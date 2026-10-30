Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601D606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0L+1KCU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509A710E82C;
	Fri, 30 Oct 2026 06:55:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B4D10E82D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 06:55:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76CC1601EE;
 Fri, 30 Oct 2026 06:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45781F000C1;
 Fri, 30 Oct 2026 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793343337;
 bh=P9QrYaq/DkHGTDvTpt/LwceNqoTYAZ3bEDsNS1lBDO8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N0L+1KCU7gD0tUR70kHsd7E/hhsFrzeVs0qPM38fcNUO+u/N8H1EEHjllXNrcWZt0
 7zkohh73xFr5X49vYoPcbZBcokmeVhuvm2TBQ9+cHUhAkDRpTUViHG2M0+yMShk1v2
 yM53I+29/DI6vp5fZ1kHQU2luINy2Re77+JkijAyvWtu6LkqP6E9hCeY7ZYbNw2QFb
 QtGyv8scIy91NYsnn+Jq1ZrvGQjeBPRxWYvrOn16akdSpcIKQnriD2hxJVh7vkMw2S
 RTH3FQt6nwGufAsvgxOhQ53s9QRbHcVfnMG+Qdv7VnHfMx26Me+K7n2s2/iPqeezYl
 R5VlD2U/lMgHQ==
Message-ID: <sashiko-outbox-190620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: display: rockchip: analogix-dp: Add
 support for RK3568
To: "Damon Ding" <damon.ding@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261030064905.2248999-2-damon.ding@rock-chips.com>
References: <20261030064905.2248999-1-damon.ding@rock-chips.com>
 <20261030064905.2248999-2-damon.ding@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:55:36 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dt-bindings: display: rockchip: unwieldy per-compatible conditionals
--

commit 53ce09e99c75e142a328f4bf2e7535fad7dadeb9
Author: Damon Ding <damon.ding@rock-chips.com>

dt-bindings: display: rockchip: analogix-dp: Add support for RK3568

This commit documents the rockchip,rk3568-edp compatible in
rockchip,analogix-dp.yaml, making rockchip,grf conditional and adding the
avdd-0v9-supply and avdd-1v8-supply properties for RK3568.

> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,=
analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockc=
hip,analogix-dp.yaml
> index 6548f157fd966..f3e70cc3a1236 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogi=
x-dp.yaml

[ ... ]

> @@ -61,11 +72,25 @@ required:
>    - clock-names
>    - resets
>    - reset-names
> -  - rockchip,grf
> =20
>  allOf:
>    - $ref: /schemas/display/bridge/analogix,dp.yaml#
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-edp
> +    then:
> +      properties:
> +        rockchip,grf: false
> +    else:
> +      properties:
> +        avdd-0v9-supply: false
> +        avdd-1v8-supply: false
> +      required:
> +        - rockchip,grf
> +
>    - if:
>        properties:
>          compatible:
> @@ -100,6 +125,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - rockchip,rk3568-edp
>                - rockchip,rk3576-edp
>                - rockchip,rk3588-edp
>      then:

[Severity: Low]
This isn't a bug, but with the addition of rockchip,rk3568-edp, allOf in
Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
now has four separate per-compatible if-then blocks governing almost all
Rockchip-specific properties (clocks, clock-names, resets, reset-names,
rockchip,grf, avdd-0v9-supply, and avdd-1v8-supply), with
rockchip,rk3568-edp matched in two different blocks.

Given these growing variant differences across SoCs, would it be cleaner
to split this binding into separate schema documents rather than adding
more per-compatible conditionals here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030064905.2248=
999-1-damon.ding@rock-chips.com?part=3D1
