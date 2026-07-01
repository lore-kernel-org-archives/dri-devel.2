Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A73C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6B210E3D1;
	Wed,  1 Jul 2026 16:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J5ghedL6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE34D10E3D1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:15:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D29142AD2;
 Wed,  1 Jul 2026 16:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B140D1F000E9;
 Wed,  1 Jul 2026 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782922519;
 bh=aipDvWrWgPOS3T5x8LZ5hocJ9pcLdqwMOe41b3FMRds=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J5ghedL6aUSbTKU7J+IdalinDDMtVrakY/guhUigSeYh6iLaXllutPDDHPhZ0/hRZ
 ihF8+1dUJmBKtfNpNCwaBVjVh5gUthKbI92mV8fOA5F/5cIzbwfC1ZETyI9buCMAkW
 qmOahRciR7Zjp/+522DqxlEifELsihsS5ojG6BUpC6g0I2EF97NjZqjQSj2wCihEZ3
 M8t5Ze96hSo8kyBHD6Nvdw0dQY/8pXfWOmejIhzJ1AJp1vPjcl/suj21NbCZVPPpSf
 KDSougZjtjkrqBxe/zFtAaMatBGFfuP+cKklIVGhsj0jNx4+IcW2sG29g0XAZJ4Gp3
 VXZxPcj1QVbdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/11] dt-bindings: reserved-memory: Document Tegra VPR
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org,
 linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:15:18 +0000
Message-Id: <20260701161518.B140D1F000E9@smtp.kernel.org>
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
- [Low] The examples section lacks a parent `reserved-memory` node defining=
 `#address-cells =3D <2>` and `#size-cells =3D <2>`, causing `make dt_bindi=
ng_check` to fail due to property length mismatches.
--

commit 4ece5321c623dd3f99c7265c3f5b7ed31b2d2efe
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit adds device tree binding documentation for the NVIDIA Tegra
Video Protection Region (VPR). It describes a protected memory region used
for DRM content, supporting both fixed and resizable variants.

> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,teg=
ra-video-protection-region.yaml b/Documentation/devicetree/bindings/reserve=
d-memory/nvidia,tegra-video-protection-region.yaml
> new file mode 100644
> index 0000000000000..1c524bae9ce32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra-vide=
o-protection-region.yaml

[ ... ]

> +examples:
> +  - |
> +    /* resizable VPR */
> +    protected {
> +      compatible =3D "nvidia,tegra-video-protection-region";
> +
> +      size =3D <0x0 0x70000000>;
> +      alignment =3D <0x0 0x100000>;
> +      reusable;
> +    };
> +
> +  - |
> +    /* fixed VPR */
> +    protected@2a8000000 {
> +      compatible =3D "nvidia,tegra-video-protection-region";
> +
> +      /* fixed VPR */
> +      reg =3D <0x2 0xa8000000 0x0 0x70000000>;
> +      no-map;
> +    };

[Severity: Low]
Will this cause make dt_binding_check to fail due to property length
mismatches?=20

The examples use 64-bit values for size, alignment, and reg, which require
2 cells. Without an explicit parent reserved-memory node defining
#address-cells =3D <2> and #size-cells =3D <2>, won't the tooling evaluate =
this
using default 1-cell constraints and report errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D1
