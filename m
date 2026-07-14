Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF9EC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7483B10E6A4;
	Tue, 14 Jul 2026 10:23:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oLhgBws4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3ED210ECDE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:23:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 530BA601DE;
 Tue, 14 Jul 2026 10:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74591F000E9;
 Tue, 14 Jul 2026 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784024626;
 bh=jZbB4JpbgaEMlXbIum927A4rbUBbripYkJxFdIqLe1w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oLhgBws4tXMBDAnfevnc1+InvUUsNl9GMnJ2SOUR1C5661gF/osFAZlw2MaeCibFC
 d0LtayNQLhCC60pA/rise+kDScu54uBQi+cbuoQ+b+hiMrEpgd+9H9abhONB1IFdSH
 qeghSbrZW3YeO+qASiRZJISB2JUUuA+T5KdOl7ZGdg8C3nAWqQhiDB3PC/SxsMprSv
 tk0MyikcRJm7bG+zEP4kPz3zmsUtyWtHYmIVhyW1ZUOY4Z8N6d0kYzmI6R3Jj+rbx9
 XMg5LRuxQbGPcMFig5axHVDTfqWKQuYKMNgcd+ALnRkKZjUs/tYk4zCWgNGoPESa43
 RzhibVh9JzYxA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: display: Add GlandaGPU binding
To: "Leander Kieweg" <kieweg.leander@gmail.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260714101146.200416-2-kieweg.leander@gmail.com>
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-2-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:23:44 +0000
Message-Id: <20260714102345.B74591F000E9@smtp.kernel.org>
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
- [Low] Missing newline at the end of the new YAML binding file.
--

--- Patch [1]: [RFC PATCH 1/3] dt-bindings: display: Add GlandaGPU binding =
---
commit 13be4be8578f4fe27e2424184082468464c6c35a
Author: Leander Kieweg <kieweg.leander@gmail.com>

dt-bindings: display: Add GlandaGPU binding

This commit adds Device Tree binding documentation for GlandaGPU, a custom
FPGA-based 2D display controller.

> diff --git a/Documentation/devicetree/bindings/display/glanda,gpu.yaml b/=
Documentation/devicetree/bindings/display/glanda,gpu.yaml
> new file mode 100644
> index 0000000000000..40304e77382a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/glanda,gpu.yaml

[ ... ]

> +examples:
> +  - |
> +    gpu@c0000000 {
> +        compatible =3D "glanda,gpu-1.0";
> +        reg =3D <0xc0000000 0x1000000>;
> +        interrupts =3D <0 43 4>;
> +        clocks =3D <&osc1>;
> +    };
> \ No newline at end of file

[Severity: Low]
This isn't a bug, but should this new YAML file end with a newline?=20

Missing newlines can trigger styling warnings during yamllint checks when
running make dt_binding_check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714101146.2004=
16-1-kieweg.leander@gmail.com?part=3D1
