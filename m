Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01D6CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBF5510E10C;
	Fri, 16 Oct 2026 16:14:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 641AB10E10C
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:14:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1237140422
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6D71F000C4;
 Fri, 16 Oct 2026 16:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792167240;
 bh=M0F+riEqn8NEjDeHBauwvhCI6l7wpn8Dg+H5KuMKm+I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lmX9vIhHvHItEylsXw8lmgbDW9/kwqm1dG2bNBd0ap4WHIkVns+7vmfY3w1XG9wtI
 lnfsda5U9Duqz8DKxUZYxg2wpsd+9TaLLhXomU6gew1nRcm1YZyy3vT0zLbHnCqs6o
 JErPXyTa9JVe8QE0yzpatVJb/vlKO7BIRv0s5AEvyk+Y/s32ELtRWx7m5ecU4TjWMm
 jVZEiOd+zC+uB26nOiDTTWBBB2hQwDjNtFfYCPPMVMcevvg9SgsTO68melUouwaBqs
 9yUCigz/9AGQlmJlQ7u2v1Lcnv4m7PvgKgqHfvzHxmrw3LUQ/DXFLv5j8sdcXUDgec
 bd2EZNrHQGxBQ==
Message-ID: <sashiko-outbox-174613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: gpu: nvidia,gk20a: Require the fuse
 clock
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261016160700.3831336-2-sashal@kernel.org>
References: <20261016160700.3831336-1-sashal@kernel.org>
 <20261016160700.3831336-2-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:13:59 +0000
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
- [Medium] dt-bindings: missing minItems: 4 for nvidia,gm20b makes fuse clo=
ck optional
--

commit ce5f108aa60b7d673901db80f95bfdff4aaaa9a2
Author: Sasha Levin <sashal@kernel.org>

dt-bindings: gpu: nvidia,gk20a: Require the fuse clock

This commit modifies the nvidia,gk20a binding to make the fuse clock
required for all GPUs in this family. It specifies the exact order
of the clocks depending on the GPU compatible string.

> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml b/Do=
cumentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> index 4d856a8b674c5..af0ada6e02557 100644
> --- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> +++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> @@ -86,6 +80,39 @@ required:
>    - reset-names
> =20
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nvidia,gm20b
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: GPU clock
> +            - description: Power clock
> +            - description: Reference clock
> +            - description: Fuse clock
> +
> +        clock-names:
> +          items:
> +            - const: gpu
> +            - const: pwr
> +            - const: ref
> +            - const: fuse

[Severity: Medium]
The commit message states the intent is to make the fuse clock required for
all of them, but will this schema actually enforce it for nvidia,gm20b?

Because the global schema defines `minItems: 3` and `maxItems: 4` for `cloc=
ks`
and `clock-names`, the array validation in this `allOf` conditional for
`nvidia,gm20b` inherits `minItems: 3`.

A device tree with only 3 clocks (gpu, pwr, ref) will successfully validate
against the first 3 items in the list, making the `fuse` clock implicitly
optional.

Should `minItems: 4` be explicitly added to both `clocks` and `clock-names`
in this `then` block to ensure the fuse clock is properly enforced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016160700.3831=
336-1-sashal@kernel.org?part=3D1
