Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B7CC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:09:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9350910E585;
	Tue, 28 Jul 2026 13:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CKmqcV/4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70D1A10E585
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 13:09:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 073694126C;
 Tue, 28 Jul 2026 13:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42361F000E9;
 Tue, 28 Jul 2026 13:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785244145;
 bh=rLUY2nqmr5gNrh5OtGeN1PUrcISwt92MZoBlcThllVM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CKmqcV/49WeACj1GKQjYEbHn/wmefzPg22J1p73JM8SnZr+1UOvNnl3/Zk/pbwZwG
 WxUnum7Y8BO7JB8vwZDHjiJ0nVZwJRNp7tM/A62cvcGLHoQnEnx3d5DeyNLa5xwT16
 8tcc3gXebVLjLolvJ4oI7Tj7nfr/XAxF2vlmZnvQp/42ZSuodhzlMiUjrMphSwe7Z0
 YOpkyYGrQz2QU0EaQSd05yeoHZ6+P00MR4OciRQT97EYCXrUhn+sKuxsDJfUoBp3h5
 v2K0+/Rl+5VMLFPzi7IkqLJUnyTH4NisD46cqeOiA44xR9GIP6ANvgH9Ne+RiP/UfO
 asssRjFN9SzPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: display: bridge: cdns, mhdp8546:
 Add no-hpd property to the cadence bridge
To: "Yashas D" <y-d@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728125336.776116-2-y-d@ti.com>
References: <20260728125336.776116-1-y-d@ti.com>
 <20260728125336.776116-2-y-d@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:09:05 +0000
Message-Id: <20260728130905.B42361F000E9@smtp.kernel.org>
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
- [Medium] The `no-hpd` property is documented in the device tree bindings =
but has no corresponding implementation in the driver.
--

--- Patch [1]: [PATCH v5 1/2] dt-bindings: display: bridge: cdns, mhdp8546:=
 Add no-hpd property to the cadence bridge ---
commit 4ac60fbbcafba148711703269045306014cd935a
Author: Rahul T R <r-ravikumar@ti.com>

dt-bindings: display: bridge: cdns, mhdp8546: Add no-hpd property to the ca=
dence bridge

This commit introduces the no-hpd property to the mhdp8546 device tree
bindings. It provides a way to indicate when the hardware HPD line is not
available, specifying that the driver should fall back to auxiliary channel
DPCD reads for hotplug detection.

> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp85=
46.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.ya=
ml
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml

[ ... ]

> @@ -57,6 +57,23 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  no-hpd:
> +    type: boolean
> +    description:
> +      Set if the HPD line on the bridge isn't physically connected to the
> +      DisplayPort connector or cannot be used for hotplug detection.
> +
> +      Valid use cases include:
> +      - HPD pin not routed to the connector on the PCB
> +      - HPD signal muxed with another function (e.g., audio) on the SoC,
> +        making it unavailable for hotplug detection
> +      - Hardware design where HPD cannot reliably detect monitor presence
> +
> +      When this property is set, the driver will use auxiliary channel (=
AUX)
> +      DPCD reads to detect monitor connection instead of relying on the
> +      hardware HPD signal. Monitor detection will use polling rather than
> +      interrupt-driven detection.
> +

[Severity: Medium]
Is the driver implementation missing for this new property?

The binding documentation states that the driver will use polling rather th=
an
interrupt-driven detection when this property is set. However, looking at t=
he
driver in cdns_mhdp_probe(), it unconditionally requires hardware HPD
operations:

drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:cdns_mhdp_probe() {
	...
	mhdp->bridge.of_node =3D pdev->dev.of_node;
	mhdp->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
			   DRM_BRIDGE_OP_HPD;
	mhdp->bridge.type =3D DRM_MODE_CONNECTOR_DisplayPort;
	...
}

Does the driver need logic to parse the no-hpd property and conditionally
adjust these operations to enable polling instead of enforcing hardware HPD?

>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728125336.7761=
16-1-y-d@ti.com?part=3D1
