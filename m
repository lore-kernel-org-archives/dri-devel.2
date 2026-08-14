Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFA8C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F127810F68F;
	Fri, 14 Aug 2026 15:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RSkwIFrt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA86310F68F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:39:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD2F4439BA;
 Fri, 14 Aug 2026 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E391F00A3F;
 Fri, 14 Aug 2026 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721953;
 bh=Lz+BHq6X9x8gkjPFZ43W7rtgt7YRtUAr0PMD0edHYTI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RSkwIFrtPde5Eisj+bN+Pe3n7kMGuDfhyzCEXsCEL+o4E6ih6PPk9NwgQGYtuhjpp
 6da/8oUcQ7HGGtlJY/SuU6CaZ9duX87v2lCyb191bVT1NfoEIEJLRBViH04KE8LV1z
 8jZO5htWrghVtVs6304+/9w7lSs1r/0eMi1zRBvBsHS/r/6Wnyle291By539Lpk9z1
 peygpQBGh7KELSykiQ4PJfuYjk733SqNwIBOTbXPJB9H3f2kwfHw89eaI1OcqNqc4m
 ZMeSVhd/F85WT/hJnv7hrHVGkSx4FjAm0bcbhD8gOY/1jMeh4lkXjFSNuROstRiAPr
 zKq06gU+0Tv0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org,
 media-ci@linuxtv.org, linux-s390@vger.kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-3-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-3-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:39:12 +0000
Message-Id: <20260814153913.02E391F00A3F@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing `memory-region` and `memory-region-names` properties in =
`nvidia,tegra210-nvdec.yaml`
- [Low] Missing word in the commit message sentence describing NVDEC behavi=
or
--

--- Patch [3]: [PATCH v5 03/10] dt-bindings: gpu: host1x: Document memory-r=
egions for NVDEC ---
commit d7576d345a96bd859ab402d685153853ecaa3898
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

This commit documents the memory-region and memory-region-names properties
for NVDEC in the nvidia,tegra234-nvdec.yaml schema. It specifies a reference
to the video protection memory region used for secure video playback.

> The video protection region is a reserved memory region that can be used
> for secure video playback. NVDEC can access this region to decode images
> into securely.

[Severity: Low]
This isn't a bug, but there seems to be a missing word in the commit messag=
e.
Should this be "decode images into it securely"?

> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234=
-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-=
nvdec.yaml
> index 0b7561c8b9bb2..72313f776dbd8 100644
> --- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
> +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
> @@ -60,6 +60,14 @@ properties:
>        - const: dma-mem
>        - const: write
> =20
> +  memory-region:
> +    items:
> +      - description: reference to the video protection memory region
> +
> +  memory-region-names:
> +    items:
> +      - const: protected
> +

[Severity: Medium]
Will this same feature be used on older hardware variants?

The Video Protection Region (VPR) appears to be available on older Tegra
devices as well. Since the schema located at
Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
uses additionalProperties: false, attempting to configure the VPR on older
NVDEC nodes will fail schema validation.

Should memory-region and memory-region-names be added to
nvidia,tegra210-nvdec.yaml too?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D3
