Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BB3C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BB410F054;
	Wed,  1 Jul 2026 16:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lHs0bjiF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A6E10F054
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:32:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 155CF408A1;
 Wed,  1 Jul 2026 16:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE3A1F00A3A;
 Wed,  1 Jul 2026 16:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782923528;
 bh=MuqZMoa1DRV8V04R88+JlOJHWAnC/DrOvyHPNDXDFRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lHs0bjiF5qowFn7aKTZ4RGWT5WmbGHebcCBoXqiC6cITYCmbc1jsnyTlmJ+HfK4HB
 u3LAf+y1oOGAKtbvMDI276jG4zzAn9IfXME6fACxBewWlIg+kjWJ1EPts1QLWP+yUT
 uSMefZqRgacBf3XfPUpNNslZyH1ZG/ZPO1gvYok9yhGHlQwYjtBxg7R0/k5wmxfzrH
 MYQh6FY1k3Drl1LoPPUi9xHgeaTlTuPU7w10gkQSd6FXPb/I5sSI92mloQidOYoq8t
 ZBNNPS1Rtt8zcXwR1JJ4747nBFyI4c8+VOe+sXd3A0iDKBS3KMOscb+DI/77xLybuv
 r8fQjTHjrYpzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/11] arm64: tegra: Add VPR placeholder node on
 Tegra264
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-11-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-11-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:32:06 +0000
Message-Id: <20260701163207.2AE3A1F00A3A@smtp.kernel.org>
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
- [Medium] Meaningful contradiction between the commit message and the actu=
al device tree source regarding the "reg" property for resizable VPR. The c=
ommit message states that 'if the VPR is resizable, the firmware should rem=
ove the "reg" property', implying it is present by default. However, the de=
vice tree node explicitly comments out the `reg` property, and its comment =
states that it 'assumes resizable VPR by default' and that fixed VPR must '=
add the missing "reg" property'.
--

commit 6b6b37b0bf4380a0dd429f1a01402c6ffedb5c1f
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Add VPR placeholder node on Tegra264

This commit adds a placeholder VPR (Video Protection Region) node for Tegra=
264
in the device tree. It includes default properties for a resizable VPR, alo=
ng
with comments indicating how firmware should update the node for either fix=
ed
or resizable VPR scenarios.

> Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.

[Severity: Medium]
Is this description in the commit message accurate? The device tree source
node comments out the "reg" property by default, so firmware wouldn't be ab=
le
to remove it for a resizable VPR. The inline comments in the implementation
also state that firmware should add the missing "reg" property for fixed VP=
R:

> diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra264.dtsi
> --- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
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

Could the commit message be updated to match the implementation, or should =
the
"reg" property be uncommented in the dtsi file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D11
