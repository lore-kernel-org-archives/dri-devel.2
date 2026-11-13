Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90651606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k00eSQ26
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F31112645;
	Fri, 13 Nov 2026 16:35:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF31112645
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:35:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 429F061406;
 Fri, 13 Nov 2026 16:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870141F000C4;
 Fri, 13 Nov 2026 16:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587717;
 bh=Io3LbBzAum205PwdBFQoAh4sWtN9t475JlKUGXJBp4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k00eSQ26Im9Cz1wumZlPqxD+IFJ+ZLRxg+Htjth7VJ1vsV2AK2DG2TWcsoGb8VdsT
 dW+qT/PULzAibZl8jLhBpCVMw5nwIHoAyQbB163qVcRKIhhrSPniNVY+YOwnx6PIb1
 i+FNg1JbDbT0AGmVlFzrm127ffxUTwLIqDOTG2AQ7GnQ2aXyjt6vHVOOKfj+bpyBmm
 GWt9Tzu5sD0kpFVPCB+Ile2J4WoRXaH7EffLmAqqzhvIGbNm4jl1Wk8oHt/qEmoAWk
 a/9noTiP+bII2DisIat4PbOGmvgFyA2dUyx1DMlVrxOm4v8PmLrJGuzoXF5WWGjyyM
 +2PdKJiTUKo/w==
Message-ID: <sashiko-outbox-213206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/10] dt-bindings: display: tegra: Document Tegra114
 CSI
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261113161819.36847-8-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
 <20261113161819.36847-8-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:35:16 +0000
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
- [Medium] dt-bindings: display: tegra: broken clock-names and clocks
  bounds for Tegra30
- [Low] dt-bindings: display: tegra: unwieldy conditionals for Tegra114
  CSI variant
--

commit bc3414960c2f3dc8bae0883c0237f89de055bb7d
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: display: tegra: Document Tegra114 CSI

This commit adds the nvidia,tegra114-csi compatible string and its clock and
calibration constraints to the Tegra20 CSI binding schema.

> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-csi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra2=
0-csi.yaml
> index a1aea9590769f..0c18ac81c6d6f 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.=
yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-csi.=
yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - nvidia,tegra20-csi
>        - nvidia,tegra30-csi
> +      - nvidia,tegra114-csi
> =20
>    reg:
>      maxItems: 1
> @@ -24,12 +25,18 @@ properties:
>        - description: module clock
>        - description: PAD A clock
>        - description: PAD B clock
> +      - description: A/B lanes clock
> +      - description: C/D lanes clock
> +      - description: E lane clock
> =20
>    clock-names:
>      items:
>        - const: csi
>        - const: csia-pad
>        - const: csib-pad
> +      - const: cilab
> +      - const: cilcd
> +      - const: cile

[Severity: Medium]
Does extending the top-level clock-names items list to 6 entries without
setting minItems: 3 cause dtbs_check to fail on Tegra30 device trees?

Without an explicit minItems at the top level, dtschema defaults clock-names
to minItems: 6, which cannot be relaxed by the minItems: 3 rule in the
nvidia,tegra30-csi allOf branch and causes csi@800 in
arch/arm/boot/dts/nvidia/tegra30.dtsi to fail validation.  In addition,
expanding the top-level clocks and clock-names lists to 6 items leaves
nvidia,tegra30-csi without an upper bound unless maxItems: 3 is added to its
conditional block.

> @@ -125,6 +132,22 @@ allOf:
>          clock-names:
>            minItems: 3
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra114-csi
> +    then:
> +      properties:
> +        "#nvidia,mipi-calibrate-cells": false
> +
> +        clocks:
> +          minItems: 6
> +
> +        clock-names:
> +          minItems: 6
> +
>  additionalProperties: false
> =20
>  required:

[Severity: Low]
Would nvidia,tegra114-csi fit better in a separate binding schema document?

With this addition, every compatible string in nvidia,tegra20-csi.yaml needs
its own if/then block to override clocks, clock-names, and
#nvidia,mipi-calibrate-cells.  Tegra114 CSI also differs in its hardware
layout: it adds CIL C/D and E lane clocks for a third port while the shared
schema restricts patternProperties to ^channel@[0-1]$, and
include/dt-bindings/clock/tegra114-car.h does not define the csia-pad or
csib-pad clocks required here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113161819.3684=
7-1-clamor95@gmail.com?part=3D7
