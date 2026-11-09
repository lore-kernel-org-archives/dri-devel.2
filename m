Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B6606A33F
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IE2MCKFF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD61110F205;
	Mon,  9 Nov 2026 12:15:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F305D10F205
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:15:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C8E363169;
 Mon,  9 Nov 2026 12:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7851F0089F;
 Mon,  9 Nov 2026 12:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794226502;
 bh=F/qByzTe+KcUp8tgIGYWQnDAqtdqoJO6RFLIIg0+kwU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IE2MCKFFZEgj7Sjp/pSEQXFcmpmZzxNN6iMyE68TlxX3GCLPyPaOi663RPaTwQy/1
 9u1v5mdIt283cFR3cbYkSXsyBTpIkjOzeJOpYYTX98fjlq6teskboX3U6LW5alLwl5
 6UF9+vfdjA/bJ4wcAkfjjbusNvnqJ3eVuQqBbd1pvbMDvkUxrxyhnFK1HPNZkVe5x+
 xT87XWdImRB51R6mep8yxkSBPPWkhqIP5wz5GPc253zLUUqZKXigIOFQdCBJotBqka
 8pUKakrj9EmuQJUzIfvUlocwNU1RQzcecX8BC7FsYrKv6+5SyUzyXBrn2pyPSZa3Eg
 zja0tm4JmJ4Zw==
Message-ID: <sashiko-outbox-204921@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: gpu: Add CIX Sky1 Mali support
To: "Cunyuan Liu" <cunyuan.liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261109120902.125242-2-cunyuan.liu@cixtech.com>
References: <20261109120902.125242-1-cunyuan.liu@cixtech.com>
 <20261109120902.125242-2-cunyuan.liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 12:15:01 +0000
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
- [Low] dt-bindings: gpu: arm,mali-valhall-csf: unwieldy per-compatible
  conditionals
--

commit db19953a0ba8128d65457c4ba6cdd6315dce5402
Author: Cunyuan Liu <cunyuan.liu@cixtech.com>

dt-bindings: gpu: Add CIX Sky1 Mali support

This commit adds the CIX Sky1 compatible string, resource requirements, and
example to the Arm Mali Valhall CSF GPU binding schema.

> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.y=
aml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> index 8eccd4338a2b2..a93acc6d91ec8 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml

[ ... ]

> @@ -51,6 +52,9 @@ properties:
>            - stacks
>        - const: stacks
> =20
> +  resets:
> +    maxItems: 1
> +
>    nvmem-cells:
>      items:
>        - description: bitmask of functional shader cores
> @@ -146,6 +150,34 @@ allOf:
>          - nvmem-cells
>          - nvmem-cell-names
>          - power-domains
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: cix,sky1-mali
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: core
> +            - const: stacks
> +        power-domains:
> +          maxItems: 1
> +        power-domain-names: false
> +        mali-supply: false
> +        sram-supply: false
> +        nvmem-cells: false
> +        nvmem-cell-names: false
> +      required:
> +        - clock-names
> +        - resets
> +        - power-domains
> +    else:
> +      properties:
> +        resets: false

[Severity: Low]
This isn't a bug, but adding resets at the top level and another large
if/then/else block to disable variant-specific properties makes the
per-compatible conditionals in this schema unwieldy. Would it be cleaner
to split the binding into separate schema documents for the SoC variants
instead of piling more conditionals onto arm,mali-valhall-csf.yaml?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109120902.1252=
42-1-cunyuan.liu@cixtech.com?part=3D1
