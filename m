Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2659C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F4410FA86;
	Tue, 15 Sep 2026 07:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="De3Ns3t4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DCB710FA86
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:36:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1270141833;
 Tue, 15 Sep 2026 07:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C0D1F000FF;
 Tue, 15 Sep 2026 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789457807;
 bh=+h9++YxbdyS915twl25S2oQKGwfAxLEwTBud6HdsXxk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=De3Ns3t4iFogFruK9wvA748v4aakTzN6Fod4dLFQC4Qcs/tzB2MwRLrsB2YNJK/Bq
 v5RDS1fE0AJxTyeYZqRk8TY3X5RwI2NcqBfhHmmG4ZjI8wFDK9sjiY6aYE8v79sPbE
 uo+U0T4L4sOIaMgUjyJeIlfqfVQo1iRUmkXe5gIAVIedJAnEaeWiLFIGsfwwConAhn
 AKWFCnRH/x1BUPRMYc5C64GTeVWoDdPgnHsC1ux7wTvU9LHpJlSiHQ4Sae64ay39GZ
 5RU48EFwCyvFN2DBxm6FtjZxXxKrtyu7xDawtgiWJCTPH4ZhFcBIULsfInii01/CGo
 NpSR4ve78i1dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] dt-bindings: display: Add ITE IT61620 MIPI DSI
 to HDMI bridge
To: "Pet Weng" <pet.weng@ite.com.tw>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260915-it61620-0714-v10-1-738e2a662c06@ite.com.tw>
References: <20260915-it61620-0714-v10-0-738e2a662c06@ite.com.tw>
 <20260915-it61620-0714-v10-1-738e2a662c06@ite.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:36:46 +0000
Message-Id: <20260915073646.A3C0D1F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: missing maxItems constraint for data-lanes
--

commit 17bcf4f8b4142033bbe40bc85ad49b91b1b814ab
Author: Pet Weng <pet.weng@ite.com.tw>

dt-bindings: display: Add ITE IT61620 MIPI DSI to HDMI bridge

This chip receives MIPI DSI input and outputs HDMI, and is commonly
connected to SoCs via I2C and DSI. IT61620 uses a separate compatible
string from IT6162 due to architectural differences.

> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it61620=
.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
> new file mode 100644
> index 0000000000000..d4f0edeecd0e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml

[ ... ]

> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: Input port for MIPI DSI
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            required:
> +              - data-lanes

[Severity: Low]
Should this data-lanes property include a local constraint to enforce the
hardware limit of 4 lanes?

If a user configures a device tree with 5 to 8 lanes, it seems dt_binding_c=
heck
will incorrectly accept it. The endpoint schema inherits the generic limit =
of 8
from video-interfaces.yaml without imposing the local hardware limit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-it61620-07=
14-v10-0-738e2a662c06@ite.com.tw?part=3D1
