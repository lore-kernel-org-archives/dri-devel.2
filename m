Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3511EC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B1B10E1A2;
	Fri,  4 Sep 2026 11:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mwDTDxzC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE66510E1A2
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 470B4600CB;
 Fri,  4 Sep 2026 11:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799131F00A3F;
 Fri,  4 Sep 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788519840;
 bh=03WZ/RbYT1BfhS6cRy0LG4WhNbveMON3bVI/gDXIpsY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mwDTDxzCsttYTDz6tbb7e7YKyHUNmfColuvkU5BbDJIJT5SsuM7S3X5TE+6rh29ei
 lWaB+cMhoOfrEsoMx5vpNCNUu9yJsEWyuPCHtnn/MQ0XJPj7JKD6VhPtnz2aLy/Js9
 ABr443ro3hlJX01wKiI9Kk5I4b4ylLY6ihX0BafwJwX+VqszexCvVelrev4w2gdLv4
 L1RtK0ynMMz1MTUpNUgj2omdRkqoTcjJDb0y4b6LBiNIQJn0vnMwIy9rdqmGC8n/re
 eGun6hzackKav1aaqpUZaM5nspbS1awbJ0TNCb5zkGQBC4GSu1lt+aW5ws+5ctueNt
 iAT/H4MorXbkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/12] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org, media-ci@linuxtv.org,
 devicetree@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-3-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-3-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:03:59 +0000
Message-Id: <20260904110359.799131F00A3F@smtp.kernel.org>
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
- [Medium] The `memory-region` and `memory-region-names` properties for the=
 Video Protection Region (VPR) were added to the Tegra234 NVDEC binding but=
 omitted from the older NVDEC binding (`nvidia,tegra210-nvdec.yaml`) which =
covers Tegra210, Tegra186, and Tegra194. Other hardware blocks on these old=
er chips (such as VIC and DC) already document and use `memory-region` for =
the VPR, indicating that the hardware shares the same capability. Failing t=
o update the related YAML files in the same family causes schema validation=
 to fail for complete device trees.
--

commit c5ee297bfa8219c2a7d714b86f0738c220914705
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234=
-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-=
nvdec.yaml
> index 4eb325cfd2961..bcaaabca945dc 100644
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

[Severity: Medium]
Should these properties also be added to the older NVDEC binding
(nvidia,tegra210-nvdec.yaml) which covers Tegra210, Tegra186, and Tegra194?

Other hardware blocks on these older chips (such as VIC and DC) already
document and use memory-region for the Video Protection Region, indicating
that the hardware shares the same capability.

If a device tree for Tegra210, Tegra186, or Tegra194 correctly specifies
the Video Protection Region for NVDEC, will it fail schema validation
because the properties are undocumented and additionalProperties: false
is set in the older binding?

> +
>    nvidia,memory-controller:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D3
