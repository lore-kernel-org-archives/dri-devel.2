Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEC0C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBCE10F561;
	Fri,  7 Aug 2026 16:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TU2lP0ms";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E35B10F561
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 16:08:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEC2F40C48;
 Fri,  7 Aug 2026 16:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC51F000E9;
 Fri,  7 Aug 2026 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786118885;
 bh=Mln1bvhJz1E5kIqI7M1efSQXW8KH8cV3OVz8x8Ispdk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TU2lP0msn/r9JB6hcZEHmstbnkRUljtgCowxyZJdEL7qoErKzKA55cH7VtPcuAb+Q
 oHBPXwH0T51LlbkoeSbpTE3UrrnnCxYmOtr3iVwSctBJVDMNWJ6FoRv45rQb7wubyp
 OjoBzSHW3/Q1dOxvVyX8gJ9arLsuYreew2SmAD2Bfa2MW0xPOGOlAdJ5IwwLTcScSJ
 IyQ5TuO/jpbOsqN3l2W8Td9J0UNohWKD3mCmJ+RBRYTax97G0bHBMPBlr7kklASyUE
 1V5Ef+IkbeIMnM//N0rOYvKzvY0qBNFND/KknfY3hsxT3NiieHgDLJ/jiIDMDM+8L5
 whJaPzVqsZg+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: reserved-memory: Document Tegra VPR
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, devicetree@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260807-tegra-vpr-v4-1-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-1-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:08:03 +0000
Message-Id: <20260807160805.01FC51F000E9@smtp.kernel.org>
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
- [Low] The dt-schema examples for the VPR omit the parent `reserved-memory=
` node context, causing 64-bit multi-cell values to be incorrectly parsed a=
gainst 1-cell defaults.
--

--- Patch [1]: [PATCH v4 01/10] dt-bindings: reserved-memory: Document Tegr=
a VPR ---
commit 8113c8e6ae5fc4a5f07530aed37855cc00e7b6cc
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit adds device tree binding documentation for the Video
Protection Region (VPR) on NVIDIA Tegra chips. It supports both fixed
and resizable memory regions for DRM protected content playback.

> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,teg=
ra-video-protection-region.yaml b/Documentation/devicetree/bindings/reserve=
d-memory/nvidia,tegra-video-protection-region.yaml
> new file mode 100644
> index 0000000000000..862bfd3913786
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

[Severity: Low]
Will this example fail semantic validation during make dt_binding_check?

Because #size-cells and #address-cells default to <1> at the root level,
omitting the parent reserved-memory node wrapper causes these 64-bit
multi-cell values to be parsed against 1-cell defaults. The size and
alignment properties here provide 2 cells and will be evaluated as arrays
of two 32-bit values rather than single 64-bit values.

> +      reusable;
> +    };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D1
