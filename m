Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CE606A333
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GEZ7Swvl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9376810E7A2;
	Wed, 18 Nov 2026 08:37:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA9410E7A2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 08:36:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AAFD061DF2;
 Wed, 18 Nov 2026 08:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FE61F000C5;
 Wed, 18 Nov 2026 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794991014;
 bh=1pi2TQlfH03Ld3iXoAhirthS8AXEERpBTRaQmf6P0lI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GEZ7SwvlN1iBzYsQ/5tWoxP4Et9gYgQz6UGSC9p2/tZweUxHkhPAmBRokpVxRsHHC
 lPq+l8LJcq8W9fim/3M/QH1hMzMDoeJXAsCXKwSxyXAXzNffyShyg2ttWgZIf2vPr9
 G9AXXtbpmz2FnubXjEfTQuWouvyEZ0+AODPoCsGycIs242AOH7bhAQ/go411EM+2Ie
 hiGgq0mnD0Nf8Uw9aNqYBR16vt9+RxWVr8OKsr9+m7OFicIS7i8MVRFUs8gXGiNSu0
 45tJv9pOoM/bGLn5mJ1G1Ht4F1MT26o8/ka+IAZXy5+mnl6WBZS/T1xs7xwEKTjdLR
 GxV1dyefnMRgQ==
Message-ID: <sashiko-outbox-220461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: ilitek, ili9881c: add
 Industio Purple Pi OH panel
To: pjh456 <147148383@qq.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_74E280A130C68EAB42115FE6AE8E6809D109@qq.com>
References: <20261118080338.523572-1-147148383@qq.com>
 <tencent_74E280A130C68EAB42115FE6AE8E6809D109@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 08:36:53 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] dt-bindings: display: panel: undocumented vendor prefix industio
- [Low] dt-bindings: display: panel: redundant width-mm and height-mm
  properties
--

commit 7361c405de28bc487b0531418138b8282051250c
Author: pjh456 <147148383@qq.com>

dt-bindings: display: panel: ilitek, ili9881c: add Industio Purple Pi OH pa=
nel

This commit adds the industio,purple-pi-oh-panel compatible string and
the width-mm and height-mm properties to the Ilitek ILI9881C panel
binding.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili98=
81c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.=
yaml
> index 42e35986fbf60..72d052ef2ccbc 100644
> --- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
> @@ -20,6 +20,7 @@ properties:
>            - bananapi,lhr050h41
>            - bestar,bsd1218-a101kl68
>            - feixin,k101-im2byl02
> +          - industio,purple-pi-oh-panel
>            - raspberrypi,dsi-5inch
>            - raspberrypi,dsi-7inch
>            - startek,kd050hdfia020

[Severity: Low]
Is the "industio" vendor prefix documented in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Adding
industio,purple-pi-oh-panel without registering the prefix triggers
checkpatch.pl and dtbs_check warnings for an undocumented vendor prefix.

> @@ -33,11 +34,13 @@ properties:
>      maxItems: 1
> =20
>    backlight: true
> +  height-mm: true
>    port: true
>    power-supply: true
>    iovcc-supply: true
>    reset-gpios: true
>    rotation: true
> +  width-mm: true
> =20
>  required:
>    - compatible

[Severity: Low]
Are height-mm and width-mm needed in this binding?  Each panel-specific
compatible already implies fixed physical dimensions, and
ili9881c_get_modes() in drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
populates connector->display_info.width_mm and height_mm from the static
mode descriptor rather than reading these properties from Devicetree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_74E280A130C=
68EAB42115FE6AE8E6809D109@qq.com?part=3D1
