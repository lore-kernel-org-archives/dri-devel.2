Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7450606A332
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sgkl30Vv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F17010E8A8;
	Mon,  9 Nov 2026 12:50:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8359610F26D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:50:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83D7D63284;
 Mon,  9 Nov 2026 12:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27F51F0089F;
 Mon,  9 Nov 2026 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794228628;
 bh=S6IAQ+Wr+Ko6lWqp8OF42/3E3uNYZA+m3Lorr+E3XXU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sgkl30VvZplfeiYugV/gx2zJsyIWHPeF2WKBDyc8tQY0ELsq13Gi0PqkJK1IpUFoB
 EOP0K20tnqfm21ytOp58Fr6qT71Tc8YQkpADwjObCmbuauCu/08u0QoBhjFEBXqDRf
 YfO/BYaF0lo56gjLGWd8JVJ+ho3IXCsjA7ADlE2uqJKECmR4EHqS+zcT4iMBhKXZTp
 jgR7wIpO/atPHTEwCek8+eOH2k3TrUZtF/C0D5h0ph8YdX+Tgw6Ru+Jtqy+5k0pFto
 6wwA30BdPtJs1L87gDKxrOdKFK3rKd2d1wfOcbDv/ylfe7LzBcs78smSqEuX5RV8y0
 djQrdmHfS8r8g==
Message-ID: <sashiko-outbox-204982@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms
To: "Frank Obergfell" <frank.obergfell@bytesatwork.ch>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261109122250.720757-5-frank.obergfell@bytesatwork.ch>
References: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
 <20261109122250.720757-5-frank.obergfell@bytesatwork.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:50:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] dt-bindings: arm: fsl: standalone SoM compatible entry for
  byteengine-imx93
--

commit 16c85ae9ce2da615e1c5f80c4ecb02932e8f9200
Author: Frank Obergfell <frank.obergfell@bytesatwork.ch>

dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms

This commit adds the bytesatwork vendor prefix and documents the
compatible strings for the byteENGINE i.MX93 System on Module and
byteDEVKIT carrier board.

> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index c8290a83205b6..d342930981d2a 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1555,6 +1555,18 @@ properties:
>                - fsl,imx93-wireless-frdm   # i.MX93 and IW610G WLCSP (Wi-=
Fi + BLE + 802.15.4) SiP FRDM Board
>            - const: fsl,imx93
> =20
> +      - description: i.MX93 boards with bytesatwork byteENGINE and byted=
evkit
> +        items:
> +          - enum:
> +              - bytesatwork,bytedevkit-imx93
> +          - const: bytesatwork,byteengine-imx93
> +          - const: fsl,imx93
> +
> +      - description: i.MX93 boards with bytesatwork byteENGINE OSM Modul=
es
> +        items:
> +          - const: bytesatwork,byteengine-imx93
> +          - const: fsl,imx93

[Severity: Low]
Should this standalone entry for bytesatwork,byteengine-imx93 be dropped?

The byteENGINE i.MX93 is an OSM System-on-Module (represented by
imx93-byteengine.dtsi) that cannot boot without a carrier board, and its
compatible is already covered by the bytesatwork,bytedevkit-imx93 board
entry above.  Having a separate SoM-only entry allows root nodes without
a board compatible to pass schema validation.

Also, the commit message refers to "the byteENGINE carrier board" instead
of the byteDEVKIT carrier board.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109122250.7207=
57-1-frank.obergfell@bytesatwork.ch?part=3D4
