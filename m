Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8861CC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD88A10F68D;
	Fri, 14 Aug 2026 15:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZUUqjPRo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8614E10F68D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:38:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56940415AA;
 Fri, 14 Aug 2026 15:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C41F000E9;
 Fri, 14 Aug 2026 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786721886;
 bh=v7qz5ThTCFyHTE6O0oPuP3P7nK6w6NGbEvsEyMmTBuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZUUqjPRoj6kgW37srNwXgNgZ5K0bsMz5yhSauKNADuNbd2BRjiJF5dGvy9Nz3J5Nl
 7Lfu+YrMowfzRG6oB35kd/pKy6nT/yDwRAINhCCisOy73GqbbsWl3jCGbTxPflU41O
 VvBq1zHHlAIrZ/OePHf6Zc3Pka1bJgaGca6rl3NQnIyXBEHw9LgFDalVuRN2BtHnbM
 F7RM0EMXiEOMLBsUorxIzKYRhcGN6p8qYT0g3JozstKpGYNWp8DAcPA3yrdAoJOYnK
 EvGJ+IX+CKiGnXF2Fe1aNE3ubI6F4M7O2+FPhG2EigJLdrKsCPpEz/oGZrMCfBuYkU
 LBxbVf/ZDT+pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] arm64: tegra: Add VPR placeholder node on
 Tegra234
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, media-ci@linuxtv.org,
 linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, robh@kernel.org,
 linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-8-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-8-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:38:04 +0000
Message-Id: <20260814153804.859C41F000E9@smtp.kernel.org>
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
- [High] The DT template comments out the `no-map` property to satisfy sche=
ma validation for resizable VPRs, but fails to instruct the firmware to add=
 it back for fixed VPRs. Without `no-map`, the kernel will map the hardware=
-protected Video Protection Region into the CPU linear map, leading to fata=
l SError panics from speculative execution.
- [Medium] Mismatch between the commit message instructions and the DT temp=
late regarding the `reg` property. The commit message instructs firmware to=
 remove `reg` for resizable VPRs, but it has already been commented out in =
the code.
--

--- Patch [8]: [PATCH v5 08/10] arm64: tegra: Add VPR placeholder node on T=
egra234 ---
commit 19202d4b4a42362e9866fdb06d4d5ebfaf462002
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Add VPR placeholder node on Tegra234

This commit adds a placeholder device tree node for the Video Protection Re=
gion
(VPR) on Tegra234. It provides properties for both fixed and resizable VPR
configurations, expecting early firmware to finalize the node.

> Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.

[Severity: Medium]
Is this commit message instruction accurate for the final version of the pa=
tch?

The DT template in arch/arm64/boot/dts/nvidia/tegra234.dtsi comments out the
`reg` property by default. If early firmware strictly follows this commit
message and attempts to delete the `reg` property (e.g., using fdt_delprop(=
)),
could it fail and potentially abort boot if it doesn't handle the missing
property gracefully?

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 8e0c51e496e20..52ff11873580d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -29,6 +29,45 @@ aliases {

[ ... ]

> +			/*
> +			 * The below assumes resizable VPR by default. If the
> +			 * firmwares sets up fixed VPR, it is responsible for
> +			 * adding the missing "reg" property, removing any of
> +			 * the unused properties, as well as adding a unit-
> +			 * address matching the "reg" property.
> +			 */
> +
> +			/* fixed VPR */
> +			/*
> +			reg =3D <0x0 0x0 0x0 0x0>;
> +			no-map;
> +			*/

[Severity: High]
Does the firmware also need to be instructed to add the `no-map` property b=
ack
for fixed VPR configurations?

Since `no-map` is completely commented out and omitted from the instruction=
al
comment in the vpr node, firmware might not add it. Without `no-map`, the
kernel's of_reserved_mem_init() will use memblock_reserve() instead of
memblock_mark_nomap().

Could this cause a regression where the kernel maps the hardware-protected =
Video
Protection Region into the CPU linear map, leading to a fatal SError panic =
from
speculative execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D8
