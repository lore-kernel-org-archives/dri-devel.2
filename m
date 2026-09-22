Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9D9C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D7910EE6E;
	Tue, 22 Sep 2026 20:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KxAOfnY9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C37210EE6E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:57:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 008E341247;
 Tue, 22 Sep 2026 20:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9374B1F000FF;
 Tue, 22 Sep 2026 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110655;
 bh=aE4VN3PaEhS2/labyEAErQSWe0WL0wa79CAuXQb0A/w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KxAOfnY9KXXkIx6oafSb0rk5URIzMOqF2YRgZrCWfe+3P0+2QZxKv0ycqrxOwosKd
 37TdAQ5goeM4JFhjJyp1I5U3zjVufvkPMRvVd8Ni4Tovz4CdMb42O05unSLWRQ5tea
 APNKhCNuWG+mzc2N6hBItPg2BQnoQ8ow/XIK2iA4EYcXaE4TxeXuv/7UditupL9/an
 8XF6v/fZKIBybGoGB9fOryo5LTfWPXCw8qOPdGcflGDmYtczUoRUKTjYbm5RD2F1Y5
 T0KJq1wB8aMo1ofZooOWfhE0lMGtIpufORfEVIZp5kEcjFFO/Nkt/xdQ9lCT2SHEGO
 wyuHovlLkodMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 18/27] dt-bindings: gpu: panthor: Document AW
 assignment DT property
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260922204535.2850094-19-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-19-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:57:35 +0000
Message-Id: <20260922205735.9374B1F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: gpu: software resource policy in device tree
--

commit c9c432471efad1a2abcbaf062de9fa8ddb5708c3
Author: Karunika Choo <karunika.choo@arm.com>

dt-bindings: gpu: panthor: Document AW assignment DT property
   =20
Introduce arm,access-window-mask property to allow partitions to define
the assigned access windows at probe time.

> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbit=
ration.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitr=
ation.yaml
> index 9ea2b4bb9a344..4e7933829e2be 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.=
yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-arbitration.=
yaml
> @@ -52,6 +52,15 @@ patternProperties:
>            Hardware partition control index. Must identify a partition pr=
esent on
>            the GPU and be unique among this device's partition nodes.
> =20
> +      arm,access-window-mask:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 0xffff
> +        default: 0
> +        description:
> +          Initial access window assignment mask. Bit N selects global
> +          access window ID N. Masks must be disjoint across partitions.
> +          If omitted, no access windows are assigned by default.
> +

[Severity: Low]
Does this new property improperly introduce software policy into the
hardware description bindings?

Encoding dynamic resource assignment with arm,access-window-mask in the
device tree dictates software policy rather than describing pure hardware
topology.=20

This restricts the kernel's flexibility to dynamically assign resources
based on runtime workloads, as it forces an initial hardcoded allocation
upon driver probe.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D18
