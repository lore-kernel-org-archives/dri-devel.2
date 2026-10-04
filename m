Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6084BCA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D21410E11A;
	Sun,  4 Oct 2026 16:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KDOwRhNY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3970E10EA90
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC90160120;
 Sun,  4 Oct 2026 16:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145811F00898;
 Sun,  4 Oct 2026 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791132103;
 bh=lu0Wmai6PhlAM2qoPkAilmqc7RmH1FmzEm/aAa65qi4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KDOwRhNYXac6KdGoBaurjv39MPWcLKJdC7mDyrdu6RtMMrxDccQw0m9HYmqs5qIdv
 /9YLRNlsEqb2BlT0QB9Npw/LaGN709HL2zVI45Rq7NAqjWq6e+rBbiRMGOhOQJCvBD
 KfzutbxW9wUWmV1fJGIUMFjHqo8aE/23awgRiNKW/N2l1Uz7bz/+xonRylkg3KymuE
 gJYyYUThHTRd9IZWxNbx20cq+mxE4RCJvzkHJgLUemZJyuj3NRjM+oYSk3Qvl4h5wr
 o5B7+5G53zwvnVank0dsK4XEDwH8tL9ColiNmA3pIdYJLLd4xkmi0JminJxG1Tv42M
 NM/IYSEpDA7Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261004163114.181800-4-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
 <20261004163114.181800-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 16:41:42 +0000
Message-Id: <20261004164143.145811F00898@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] dt-bindings: required 'compatible' property is undefined in tegr=
a-dbi schema
- [Medium] dt-bindings: invalid example root node causes validation failure
- [Medium] dt-bindings: missing generational constraint for dbi interface
--

commit 9f9bbe3a4b81a4564064134d8bb28bd826d68aac
Author: Svyatoslav Ryhel <clamor95@gmail.com>

dt-bindings: display: tegra: Document 8-bit CPU parallel interface

Document 8-bit CPU parallel MIPI DBI Type B interface provided by
Tegra20/30 SoCs display controller.

> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-db=
i.yaml
> new file mode 100644
> index 0000000000000..184c33d436308
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.ya=
ml
[ ... ]
> +properties:
> +  dc-gpios:
> +    description: Data/command selection pin.

[Severity: Medium]
The properties block completely omits a definition for the required
compatible property.

Because unevaluatedProperties is set to false, wouldn't providing the
compatible property fail validation since it is undefined in this block?

[ ... ]
> +required:
> +  - compatible
> +  - dc-gpios

[Severity: Medium]
This incorrectly requires the compatible property for the dbi node.

Since it is required here, wouldn't omitting it also fail validation,
making it impossible to satisfy the schema?

[ ... ]
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dc@54200000 {
> +        reg =3D <0x54200000 0x00040000>;
> +
> +        dbi {

[Severity: Medium]
Is the example rooted at the parent dc node instead of the dbi node, causing
dt-schema to apply the dbi schema to the parent node and fail?

Since the schema lacks a select or top-level compatible constraint, dt-sche=
ma
will automatically evaluate the example's root node against this schema.

Because the dc node contains properties like reg and dbi that are not defin=
ed
in the schema, and lacks required properties, won't this cause a schema
validation error?

> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20=
-dc.yaml
> index 69be95afd5627..bb280f8dbfc7c 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.y=
aml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.y=
aml
[ ... ]
> @@ -76,6 +76,9 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      description: A list of phandles of outputs that this display control=
ler can drive.
> =20
> +  dbi:
> +    $ref: /schemas/display/tegra/nvidia,tegra-dbi.yaml#
> +

[Severity: Medium]
Does this unconditionally allow the dbi node for all Tegra DC variants,
violating the hardware constraint?

The commit message explicitly states the 8-bit CPU (MIPI DBI) interface is a
feature of Tegra20/30 SoCs. Since nvidia,tegra20-dc.yaml covers later
generations, should this be conditionally constrained to Tegra20 and Tegra30
using an allOf -> if block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004163114.1818=
00-1-clamor95@gmail.com?part=3D3
