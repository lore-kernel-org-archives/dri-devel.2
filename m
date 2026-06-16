Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BBCCD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED5510E803;
	Tue, 16 Jun 2026 18:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FzyQdPv3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB17F10E803
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:05:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 060EB600AB;
 Tue, 16 Jun 2026 18:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54B21F00A3A;
 Tue, 16 Jun 2026 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781633128;
 bh=MmlrOJIvPBzMHeS2Du1IJ56VJHSY/6nqteZkRL7SEo4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FzyQdPv3REDJHiZoTbVHWzcfJ4KyXxBfvvzreCj+r0DsRXVCHa/h4G7atw++RkFVs
 wYUw+ok5qEfI/K2QtTOGOxd4WsJH4MdWMBf++b3VA844SYqY4fO/MmXTE+BkWu4oIf
 3GsOl9Y4zw/oMU3LQi8FNdviTEM5p0etVb/Vl+r2WhkitgbhuvIhyQLj7PWq3H4vIg
 N2oH/WNTTIq3T4hWZ6PBee7YBQp0mFTI2fOUCb9KxVMSq81ec3hMoMFyVICTEjI/gQ
 jSXDgGr/Lw4/N/nL0PC+ueWe163nIc1TcZcyjp2So+Bly6eX6Y+cd29OMysQIkJdA3
 0F6MHNhNPyRmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: img,powervr-rogue: Document
 GE8300 GPU in Renesas R-Car D3
To: =?utf-8?b?TmlrbGFzIFPDtmRlcmx1bmQ=?=
 <niklas.soderlund+renesas@ragnatech.se>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260616175835.2109336-2-niklas.soderlund+renesas@ragnatech.se>
References: <20260616175835.2109336-2-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 18:05:27 +0000
Message-Id: <20260616180527.C54B21F00A3A@smtp.kernel.org>
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
- [Medium] Incorrect use of `enum:` instead of `contains: enum:` in an `if`=
 block breaks schema matching for `compatible` arrays, bypassing power doma=
in validation.
--

commit 911441282d51eed161459bbab16231d9b1fcbca8
Author: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

dt-bindings: gpu: img, powervr-rogue: Document GE8300 GPU in Renesas R-Car =
D3

This commit documents the GE8300 GPU present in the Renesas R-Car R8A77995 =
D3
SoCs. It also updates the power domain constraints to account for the D3
having only one power domain that is always on.

> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml=
 b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index a1f54dbae3f31..b93f49f1fa0a6 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml

[ ... ]

> @@ -159,14 +165,14 @@ allOf:
>    - if:
>        properties:
>          compatible:
> -          contains:
> -            const: thead,th1520-gpu
> +          enum:
> +            - renesas,r8a77995-gpu
> +            - thead,th1520-gpu

[Severity: Medium]
Does this change break the schema matching for these compatible strings?

In Device Tree bindings, the compatible property evaluates as an array of
strings. Using "enum:" directly on the compatible array checks if the entire
array itself equals one of the scalar string values, which will always
evaluate to false.

Should this use "contains:" along with "enum:"? By dropping the "contains:"
keyword during the transition from a single const to an enum, this condition
might silently fail to match both the newly added renesas,r8a77995-gpu and
the preexisting thead,th1520-gpu strings. This would bypass the power domain
validation constraints intended by the block.

>      then:
>        properties:
>          power-domains:
>            items:
> -            - description: The single, unified power domain for the GPU =
on the
> -                TH1520 SoC, integrating all internal IP power domains.
> +            - description: The single, unified power domain for the GPU.
>          power-domain-names: false
>        required:
>          - power-domains

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616175835.2109=
336-1-niklas.soderlund+renesas@ragnatech.se?part=3D1
