Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0173C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0514610EE6A;
	Tue, 22 Sep 2026 20:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hibyFyvI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DEEF10EE6A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:56:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0945140DA8;
 Tue, 22 Sep 2026 20:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB691F000FF;
 Tue, 22 Sep 2026 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110572;
 bh=br27E775Ef6V3hjYJ5DVqLcsFln+S0c6xgQgfQvHvJU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hibyFyvIOOCtCx3BSErDRrtLoc+XVW5xUCE80tCMM/oXDv69GssePRoTH0VeDZvJd
 BcrhCHm11/yaQ32ZGgyzfiIMIDaE58UcruNOu8eGYpV6tTbTJOkKA/TgpxIch5ezOn
 75M2Wbgk5SXn59NPAS48dMT0EwD0s5H8N4NEJNnudUrSUNsSd9hYtb7PUiyUbowmEi
 ydgMuO8eZqLsRAst2LwLCUpOFqUN3ft2yqoOH6O6g9YlpP9HE7gEIfJndrF2kQjU9a
 DnKipBCK5j+hA0zZKEqP5VNrinBVIrdS6XH/VH5nFUbC556l3PYrIPz1ihGzmWOfNQ
 kRZ1M2Td86kAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/27] dt-bindings: gpu: panthor: Document
 panthor-system bindings
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260922204535.2850094-11-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-11-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:56:12 +0000
Message-Id: <20260922205612.9CB691F000FF@smtp.kernel.org>
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
- [Low] dt-bindings: use of OS-specific driver name 'panthor' in DT node na=
me
--

commit ee6d231b5dc0544f3b9572b62d9e84b81e33eedd
Author: Karunika Choo <karunika.choo@arm.com>

dt-bindings: gpu: panthor: Document panthor-system bindings

This commit introduces DT bindings for the ARM Mali 5th-Gen AM GPU's
AM_SYSTEM block. It documents the compatible string, registers, interrupts,
clocks, and regulators for this system node.

> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-syste=
m.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
> new file mode 100644
> index 0000000000000..f0689bb8f05a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-gen5-am-system.yaml
[ ... ]
> +properties:
> +  $nodename:
> +    pattern: '^panthor-system@[a-f0-9]+$'

[Severity: Low]
Does this node name pattern violate the Device Tree specification's generic
names recommendation?

Device tree bindings are expected to describe the underlying hardware in an
OS-agnostic manner. Since 'panthor' is the name of the Linux DRM driver
rather than the hardware itself (ARM Mali 5th-Gen AM GPU's AM_SYSTEM block),
should this use a generic class name like '^gpu-system@[a-f0-9]+$' or
'^system-controller@[a-f0-9]+$' instead?

[ ... ]
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    panthor_system: panthor-system@68000000 {

[Severity: Low]
Similarly, this example demonstrates the OS-specific node name. Should it
be updated to match a generic functional name as well?

> +      compatible =3D "arm,mali-gen5-am-system";
> +      reg =3D <0x68000000 0x10000>;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D10
