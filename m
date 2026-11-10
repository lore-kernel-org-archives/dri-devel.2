Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABA60A263A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSSgWphG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C920A10E1EE;
	Tue, 10 Nov 2026 14:47:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B0610E219
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:46:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86B6C472AE;
 Tue, 10 Nov 2026 14:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDFD1F008A3;
 Tue, 10 Nov 2026 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794322015;
 bh=ahpMbNRu+oaU/D+J9CQu8q3KW+PhWHMWtw7yeScr5x4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iSSgWphGAZzZqhQ+c0Be8QZCxHpeK6wmtxK+Sstue5s6HPrFgpFkwJz4UlYxj7bgx
 DmLBVqgbHYgz0bBLBML2qsLjY8ev3tyts5RizUgZ6GZkqxDCb2mvJzQGJ/3EVvnv1N
 LJe5x1LGUGpYgV68dzspFycDUXaXpyIQuOhDux66FbI4BlKd7sRsAFeUWV+066WEkZ
 DqIs3yj7LZPDEX9YK4EJ/QsgSrQVEy58z9dDZMdFWTlCmTqVxJoQgm6/5BHGGrVtSN
 QadY7MBdF0ceyycMMf68yDiAcXNYMkljlC5NDkXV8fQ15HZ62NIKgiqOFph2KR9iIO
 QYQpqtXmvF2/A==
Message-ID: <sashiko-outbox-207210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 5/7] dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB
 bridge child node
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 Frank.Li@kernel.org
In-Reply-To: <20261110-dcif-upstreaming-v11-5-9e13c85ae0d8@oss.nxp.com>
References: <20261110-dcif-upstreaming-v11-0-9e13c85ae0d8@oss.nxp.com>
 <20261110-dcif-upstreaming-v11-5-9e13c85ae0d8@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:46:54 +0000
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
- [Low] dt-bindings: clock: nxp,imx95-blk-ctl: split variant schemas
  with subnodes
--

commit 40c5ccb540e5f895cb96974a17da3a21e1ed5c2d
Author: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

dt-bindings: clock: nxp,imx95-blk-ctl: Add LDB bridge child node

This commit adds a bridge child node pattern to the nxp,imx95-blk-ctl
binding schema for nxp,imx94-lvds-csr to support LVDS Display Bridge
controllers.

> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.ya=
ml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index fbbf1b3f17904..c2aeb434a8102 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -51,6 +51,10 @@ patternProperties:
>      $ref: /schemas/media/fsl,imx95-csi-formatter.yaml#
>      unevaluatedProperties: false
> =20
> +  '^bridge@[0-9a-f]+$':
> +    type: object
> +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> +
>  required:
>    - compatible
>    - reg
> @@ -63,7 +67,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: nxp,imx95-camera-csr
> +            enum:
> +              - nxp,imx94-lvds-csr
> +              - nxp,imx95-camera-csr
>      then:
>        required:
>          - '#address-cells'
> @@ -72,8 +78,24 @@ allOf:
>        properties:
>          '#address-cells': false
>          '#size-cells': false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: nxp,imx95-camera-csr
> +    then:
>        patternProperties:
>          '^formatter@[0-9a-f]+$': false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: nxp,imx94-lvds-csr
> +    then:
> +      patternProperties:
> +        '^bridge@[0-9a-f]+$': false
> =20
>  additionalProperties: false

[Severity: Low]
This isn't a bug, but would it be cleaner to split CSR variants that have
subnodes (such as nxp,imx94-lvds-csr and nxp,imx95-camera-csr) into
separate binding schemas, similar to nxp,imx95-display-master-csr.yaml?

Adding a second variant-specific child node pattern to
nxp,imx95-blk-ctl.yaml requires three separate per-compatible if-then
blocks in allOf to toggle #address-cells, #size-cells, formatter@[0-9a-f]+,
and bridge@[0-9a-f]+ across unrelated CSR blocks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-dcif-upstr=
eaming-v11-0-9e13c85ae0d8@oss.nxp.com?part=3D5
