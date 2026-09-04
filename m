Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0275FC61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:59:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF3810FA9E;
	Fri,  4 Sep 2026 10:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HFcr9HD8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D50810FA9E
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:59:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43A28600CB;
 Fri,  4 Sep 2026 10:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0C41F00A3D;
 Fri,  4 Sep 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788519554;
 bh=Q+wqxRlCl56rmCgZUANVMFMBl1TB3QdhwDp33qiHBpQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HFcr9HD8XjwG6DfLthj7/5e6PXE6rBFFnBzTLpo4gtQNg+PP/PT6XSI/IN7CKzsvs
 OW2SDkt7/p7dPO5ibUgrdc3/g3ZnAoi6/BQmkirChU1+65n2F0kewHCRMD1bln+BoO
 zbSe6mjSrKeIiOz6GewzQ3NFEWoZt+fd4lU6RW21xX6Y+onLRRYFmXyieAmneOAx9g
 vmIpaePsV5raRB6fzVMubIAUhhT8iFSR/eLMPMaffi1bO3d02S5Kfp+WGDIswtzKfR
 X7rtIY67ftrJ0+1lQIBd/W39/SYFzQ7mG7QCOEHapKd9bU+NMM9qlwDSx05j9Vubzx
 4aQ+RnawBtOBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/12] dt-bindings: reserved-memory: Document Tegra VPR
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 robh@kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-1-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-1-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:59:12 +0000
Message-Id: <20260904105913.4A0C41F00A3D@smtp.kernel.org>
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
- [Low] The examples fail to provide a `reserved-memory` parent node to est=
ablish the `#address-cells` and `#size-cells` context, leading to schema va=
lidation failures.
--

commit f2d3906971093a4dcbac5c42465c2d0d7ce5d0a8
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit adds device tree bindings for the NVIDIA Tegra Video Protection
Region (VPR), documenting both fixed and resizable variants.

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

[Severity: Low]
Will this fail make dt_binding_check during schema validation?

Since the example lacks an explicit reserved-memory parent node to establish
the #address-cells and #size-cells context, dtschema wraps this in a dummy
root node with a default of #size-cells =3D <1>. Supplying 2 cells for the
size here exceeds that implicit constraint.

> +      alignment =3D <0x0 0x100000>;

[Severity: Low]
Similarly, does this 2-cell alignment array violate the implicit
#size-cells =3D <1> constraint for the same reason?

> +      reusable;
> +    };
> +
> +  - |
> +    /* fixed VPR */
> +    protected@a8000000 {
> +      compatible =3D "nvidia,tegra-video-protection-region";
> +
> +      /* fixed VPR */
> +      reg =3D <0xa8000000 0x70000000>;

[Severity: Low]
Without a shared parent node to explicitly declare #address-cells and
#size-cells contexts, does this 2-cell reg property parse under the default
1-cell context (treating address=3D0xa8000000 and size=3D0x70000000)?

This creates a semantic mismatch with the 64-bit lengths intended in the
first example. Wrapping the examples in a reserved-memory parent node might
resolve these context issues.

> +      no-map;
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D1
