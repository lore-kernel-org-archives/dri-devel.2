Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F9CC88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1C510E1CE;
	Wed, 16 Sep 2026 02:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lpWzqEG8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E3610E1CE
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 02:07:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BBA643473;
 Wed, 16 Sep 2026 02:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA991F00893;
 Wed, 16 Sep 2026 02:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789524461;
 bh=GdTFO+hNnDkkylQADHUvrE6dtNafBAzA+VO7Cz6OfTI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lpWzqEG8pD+i+n1i+HBgaqaRNGhRaoQmpoZ07UAZn9PnJm2cIv5UlXWVFtX+6U1Qd
 XxkDuqatj0/9UBJ+Vo8fkDMmPNgz07yMpGXZCz0taylfr0WnclFnsx0IXlTAbNmNbr
 JI5uKu7klvqyLGVkoIv+u9cLmM6j7khM6jA9GU/Sgq7YfNxOAg98g6exiRG8Qa675I
 zGTga+KKKElEuTtb6SYHT/+RSTMaOjO2eBhcw2OEV4chl9YfBY+/NAk3xQTDiSIi6N
 IxGSpOWXp96t9v8skqWSiM2t53M4i/A103YtLW9YDjiPNDkrPVQE03vmsrPc9pQarP
 snTIUKwxeMvEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: ti,tpd12s015: Convert to
 DT schema
To: Quchaosheng <quchaosheng000406@163.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260916015833.112753-1-quchaosheng000406@163.com>
References: <20260915120327.47114-1-quchaosheng000406@163.com>
 <20260916015833.112753-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 02:07:40 +0000
Message-Id: <20260916020740.EDA991F00893@smtp.kernel.org>
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
- [Medium] dt-bindings: validation regression for tpd12s015 gpios maxItems =
constraint
--

commit cd852360cf92f4482c02f981e6fec97ded13c090
Author: Quchaosheng <quchaosheng000406@163.com>

dt-bindings: display: ti,tpd12s015: Convert to DT schema

Converts the TPD12S015 HDMI level shifter binding to DT schema and restricts
the gpios property to three entries based on the assumption that no in-tree
board uses more than three.

> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 0000000000000..96b44bd665f1f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

[ ... ]

> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first contr=
ols
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    minItems: 3
> +    maxItems: 3

[Severity: Medium]
The commit message claims that no in-tree board passes more than three GPIO=
s,
but does this maxItems limit cause a dtbs_check validation regression for
existing boards?

Looking at arch/arm/boot/dts/ti/omap/omap5-igep0050.dts, it appears to defi=
ne
5 items for its tpd12s015 node:

&tpd12s015 {
	gpios =3D <&tca6416 11 0>,	/* TCA6416 P01, CT_CP_HDP */
		<&tca6416 12 0>,	/* TCA6416 P00, LS_OE*/
		<&gpio7 1 0>,		/* 193, HPD */
		<&gpio7 2 0>,		/* 194, SCL */
		<&gpio7 3 0>;		/* 195, SDA */
};

Should the schema accommodate all 5 pins, or does the omap5-igep0050.dts bo=
ard
file need to be updated first before enforcing this constraint?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915120327.4711=
4-1-quchaosheng000406@163.com?part=3D1
