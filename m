Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D7AC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6862E10F690;
	Fri, 14 Aug 2026 15:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CWc231Cr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A844910F690
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:39:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D35D600C3;
 Fri, 14 Aug 2026 15:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369991F000E9;
 Fri, 14 Aug 2026 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721984;
 bh=lTa/JlR73bsOpoAGF1VRV3Vc6IztNz6I1r+STzAT4qE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CWc231CrL9oIvlwzsk51cqCvOT+51JrWaia3rRztpLCSRdFKVtfVeuqZQXD07Pa0Q
 mfGYuPH6rigJg1WA5qWyZdDuWcSatCNhvnOn0YKq/kjHrRtcDlPAFfG9soe7fPQZuz
 DJcCCspx9gU6ztfPS+KTZJ4lzdpzyWWU8zJ3O2XfZ6+VV+eUn1+9Y9JyLRdzXf78xQ
 nSD2MypiN210e5WAV7fhGpq6YHZ/KcssBgX64hkTxAy+AoWeXjtmUUfrtVwcHYqYoB
 X2VGqRQmATavA6tP1hVrVnbMJiv6zTNPHlVRQSEVrjcOPQd0WVRLKgjU50+nnmZOGW
 w2u7/zgiWD5vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] dt-bindings: reserved-memory: Document Tegra VPR
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org, robh@kernel.org,
 linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, media-ci@linuxtv.org
In-Reply-To: <20260814-tegra-vpr-v5-1-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-1-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:39:43 +0000
Message-Id: <20260814153944.369991F000E9@smtp.kernel.org>
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
- [Low] The examples use 64-bit values for `size` and `alignment` but are m=
issing a parent `reserved-memory` node to define `#size-cells =3D <2>`.
--

--- Patch [1]: [PATCH v5 01/10] dt-bindings: reserved-memory: Document Tegr=
a VPR ---
commit f3aef7e4bf1dca49011b483a566145d2ddfdd64a
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit documents the device tree bindings for the NVIDIA Tegra Video
Protection Region (VPR). It defines a fixed VPR using the "reg" property
and a resizable VPR using "size" and "alignment".

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
Will this cause dt_binding_check to fail?

The 64-bit values for size and alignment contain 2 cells each. This violates
the core reserved-memory.yaml schema when parsed with the default root
node context, which sets #size-cells =3D <1>.

Could the examples be wrapped in a reserved-memory parent node that
explicitly sets #address-cells =3D <2> and #size-cells =3D <2>?

> +      reusable;
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D1
