Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE41AC55182
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2B710ED4E;
	Wed,  5 Aug 2026 07:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YNtUE0ag";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DA510ED4E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:46:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27EAA600AE;
 Wed,  5 Aug 2026 07:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD9B1F000E9;
 Wed,  5 Aug 2026 07:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785916012;
 bh=+K6TBh7eYfJ+ivUoJFixxZ48g2ahOZ8ykarz2J6sKqk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YNtUE0agrw025/Bsx330kLK59dvAXIUwrxyANCmUcrazEKsMrdVudcEP6ihrDKCIh
 ohKYjxZJw+pC1+CwWe8TkV+bBI6eQhLALytY7R7dFtUREy6urOHTRQ7Ir/rWtOWenV
 Fsiy3NDxcRe3Z5jKtQ277ey8GdFE0q0Uo1xbThv8wN2f4zuVRI+fHsBfcMv2zO46i+
 fX2ebMy9r2O29D4+8eonyDusuBuZERN4aciVKdRkqFt8+qT7+ukT0yFFIsjsRaK/r8
 waUE+kO+uAR7QjCfA6w46Gv7QiTIut0aBz9w1YpEkpNk32DqPlCr10hGTKxd57jTq1
 K45C027p8vMNg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 v5 7/8] arm64: dts: rockchip: rk3576: add NPU
 (RKNN) nodes
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260805063826.95682-8-gahing@gahingwoo.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
 <20260805063826.95682-8-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:46:51 +0000
Message-Id: <20260805074652.7AD9B1F000E9@smtp.kernel.org>
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
- [Medium] The device tree nodes are padded with fake power-domain dependen=
cies to bypass the Linux driver core's single-domain auto-attach mechanism.
--

--- Patch [7]: [RFC PATCH v5 v5 7/8] arm64: dts: rockchip: rk3576: add NPU =
(RKNN) nodes ---
commit 2901ef2a9f2683429a8cc97e3be5786a1b6b21b5
Author: Jiaxing Hu <gahing@gahingwoo.com>

arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes

Add the two RKNN cores and their IOMMUs for the rk3576. Both cores are
disabled by default, and boards can enable what they wire up. The NPU
power-domain resets are also added.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
[ ... ]
> @@ -1832,6 +1840,74 @@ qos_npu_m1ro: qos@27f22100 {
[ ... ]
> +		rknn_core_0: npu@27700000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
[ ... ]
> +			resets =3D <&cru SRST_A_RKNN0>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;

[Severity: Medium]
Are these power domains accurately describing the hardware topology, or are=
 they
encoding a software workaround?=20

The commit message mentions that listing both domains prevents the driver c=
ore
from auto-attaching a single domain. Device trees should accurately describ=
e the
hardware instead of encoding software workarounds to bypass driver core beh=
avior.

[ ... ]
> +		rknn_core_1: npu@27708000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
[ ... ]
> +			resets =3D <&cru SRST_A_RKNN1>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU1>, <&power RK3576_PD_NPU0>;

[Severity: Medium]
Will padding the power-domains list with RK3576_PD_NPU0 on rknn_core_1 cause
unintended side effects?

Since this artificially inflates the power-domain count to bypass the OS
auto-attach mechanism, it appears it will cause the system to unnecessarily
power on NPU0 when only Core 1 is active, wasting energy.

> +			iommus =3D <&rknn_mmu_1>;
> +			status =3D "disabled";
> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805063826.9568=
2-1-gahing@gahingwoo.com?part=3D7
