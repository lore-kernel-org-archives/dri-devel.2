Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5615C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA1F10E6BB;
	Sat, 12 Sep 2026 08:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OCpOTbJn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D37BB10E6BB
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:46:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27ED860219;
 Sat, 12 Sep 2026 08:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F19C1F000FF;
 Sat, 12 Sep 2026 08:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202773;
 bh=ecWOxmhoq7Ic5zx5rNbRf+/ALXOeZ3rZSpCd1T2lK/k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OCpOTbJnTuiITASaRHXfPhN8Ai0zfGYOw4LqP6OLrS76Fu7KIAx4b/hCASfl9SvU5
 3bA/KJNSj0dtUW5HOyH2H1uTBBxa2D7261nupkvRhGWnLkhu26gwr/WnzqZcrYG68L
 6U2agJ+9bVnOaIYWLycC2KQyzkBCfqx0ukwGNk+Vk4IscAXRY34+c/wCCg0wVLgI3H
 eYtRYDMW1e/UBY8UUl7ANlY3F0UFP3V2Q3DOeY54ru5uHg7hWYyq4eQZexyhQ6W2A9
 hMkFRtHdrwyCkvN90q06wpX8ycJj4bdkbG8gpn5X/BwD+fArvERQYsLnSDhFIU30wh
 3kQw3yGdTRSzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/20] clk: qcom: smd-rpm: Add clocks for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, conor+dt@kernel.org,
 linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mfd@lists.linux.dev, robh@kernel.org, lee@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-13-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:46:12 +0000
Message-Id: <20260912084613.4F19C1F000FF@smtp.kernel.org>
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
- [Low] Unnecessary duplication of clock array and descriptor structures fo=
r MSM8952, which are identical to MSM8976.
--

commit cc0d394f5055e6be5a5f88b51a807761e8dafacc
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

clk: qcom: smd-rpm: Add clocks for MSM8952

This commit adds clock definitions for the MSM8952 platform. The commit=20
message notes that MSM8952 shares the same clocks as MSM8976 and MSM8940.

> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rp=
m.c
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -740,6 +740,34 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8940=
 =3D {
>  	.num_icc_clks =3D ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
>  };
> =20
> +static struct clk_smd_rpm *msm8952_clks[] =3D {
> +	[RPM_SMD_XO_CLK_SRC] =3D &clk_smd_rpm_branch_bi_tcxo,
[ ... ]
> +static const struct rpm_smd_clk_desc rpm_clk_msm8952 =3D {
> +	.clks =3D msm8952_clks,
> +	.num_clks =3D ARRAY_SIZE(msm8952_clks),
> +	.icc_clks =3D bimc_pcnoc_snoc_smmnoc_icc_clks,
> +	.num_icc_clks =3D ARRAY_SIZE(bimc_pcnoc_snoc_smmnoc_icc_clks),
> +};
> +
[ ... ]
> @@ -1292,6 +1320,7 @@ static const struct of_device_id rpm_smd_clk_match_=
table[] =3D {
>  	{ .compatible =3D "qcom,rpmcc-msm8936", .data =3D &rpm_clk_msm8936 },
>  	{ .compatible =3D "qcom,rpmcc-msm8937", .data =3D &rpm_clk_msm8937 },
>  	{ .compatible =3D "qcom,rpmcc-msm8940", .data =3D &rpm_clk_msm8940 },
> +	{ .compatible =3D "qcom,rpmcc-msm8952", .data =3D &rpm_clk_msm8952 },

[Severity: Low]
Since the commit message notes that MSM8952 has the exact same clocks as
MSM8976, could we avoid duplicating msm8952_clks and rpm_clk_msm8952 by
simply reusing the existing rpm_clk_msm8976 descriptor here?

Other devices in this driver use this pattern to avoid redundancy, such as
qcom,rpmcc-msm8226 which reuses rpm_clk_msm8974. Would setting the data
pointer to &rpm_clk_msm8976 work for MSM8952 as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D13
