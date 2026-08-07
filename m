Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E71EC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D5910F557;
	Fri,  7 Aug 2026 16:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="obIT2Qed";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B111210F557
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 16:05:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99B754067F;
 Fri,  7 Aug 2026 16:05:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203D1F000E9;
 Fri,  7 Aug 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786118754;
 bh=1NVTQqosPep/eMz6+Qtw7pi02Pr/BqCT8FDr9sDxzN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=obIT2QedAtZfeLvVjXuh2QCywSDBkfESspPCccXMSjhDaPovcOEssCGc+YalUl9YQ
 fgiN3oPQBaQpKC5IxfbTPBOO/nMHZ8McHEKVZJIAPRW61rYiveZWZMes0sToByXxpc
 vyBaNK8d5Cv3XDOKzbabRz7FaqA95mPLuu8LowRwazkaL/G8eU9TcWdcqXLnq4s/Hp
 ALyNwZ/ZH/cqxmDkrXLSurQpqIF32/jLFKIgAvdNXrA3a9eL/f9m2gFbOiTTAknNpc
 vNavBclWHwnFyE/kabjrZxvZ4yrU5D3COyMuXfxzof5+jq7pG14pDVQD2OY1WXYXk9
 AiaW3UntpAKaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org, "Heiko
 Carstens" <hca@linux.ibm.com>, robh@kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:05:53 +0000
Message-Id: <20260807160553.C203D1F000E9@smtp.kernel.org>
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
- [Medium] The `memory-region` and `memory-region-names` properties were ad=
ded to `nvidia,tegra234-nvdec.yaml` to support the Video Protection Region =
(VPR) for secure video decoding, but they were omitted from the related `nv=
idia,tegra210-nvdec.yaml` binding which covers earlier generations of the s=
ame hardware family.
--

--- Patch [3]: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document memory-r=
egions for NVDEC ---
commit 97ab5bd4094807d50abd7cf4f4dbbc00d0abb716
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

This commit adds memory-region and memory-region-names properties to the
Tegra234 NVDEC binding. This allows device trees to define a reserved video
protection region for secure video playback.

> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234=
-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-=
nvdec.yaml
> index 4eb325cfd2961..bcaaabca945dc 100644
> --- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
> +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
[ ... ]
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
Since earlier generations of the hardware share this family, should these
properties also be added to nvidia,tegra210-nvdec.yaml?

Because nvidia,tegra210-nvdec.yaml specifies additionalProperties: false, if
older devices (like those using nvidia,tegra186-nvdec) configure the NVDEC
block to use the Video Protection Region by adding the memory-region proper=
ty,
they will fail device tree schema validation.

>    nvidia,memory-controller:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D3
