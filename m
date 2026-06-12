Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA84CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4091710F48E;
	Fri, 12 Jun 2026 12:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ebsC8Dqt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4DD10EA24
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:10:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 944ED600AB;
 Fri, 12 Jun 2026 12:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3D61F00A3A;
 Fri, 12 Jun 2026 12:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781266220;
 bh=P14RYPFEnEujTt4OsIc6gZvNN8NTU7DfjXJRZ0uJaEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ebsC8Dqt2T74fQ0xehh803V8BEXrIidXu/EMbBo1cPfe9R4aohYgWHrgY/stf4ZXc
 KYBgjK+muNBoYEyfA7Ubr16utzWM1mCJHY3NTJ7ON3jp7tpEfkUPCZd6MmbQqzfXta
 +J0Sfs8C/IYVO6eHdt+9Zw2ZiQUA51yH266kTibzQPt7scbj/WshrkikSE5h3pFlcN
 JszgejWOlAdu3A45XRE3YiS2oMf0nDkzUnrV9qRkJuulVOYEJ+3ms9ZKL4/ffTpYwr
 gM81ytZsw/psh7t1J1IOD5155SfeUsPo+HLz7hzfsAOHQXQXrXj6MXqEXKBhqABrJA
 NJIuTtJSI8QDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260612-dcif-upstreaming-v9-6-8d0ff89aa3c5@oss.nxp.com>
References: <20260612-dcif-upstreaming-v9-6-8d0ff89aa3c5@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 12:10:19 +0000
Message-Id: <20260612121020.0B3D61F00A3A@smtp.kernel.org>
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
- [Medium] The `allOf` conditional block restricts the `ldb` child node exc=
lusively to `nxp,imx94-lvds-csr`, improperly forbidding it for `nxp,imx95-l=
vds-csr`.
--

commit 6a3665e114245286584773223a39379615a4d4fc
Author: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb child node

This commit adds support for the 'ldb' child node to the i.MX95 BLK CTL
bindings. It updates the schema to handle cases where BLK CTL registers
control the LVDS Display Bridge controllers.

> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.ya=
ml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml

[ ... ]

> @@ -46,6 +57,21 @@ required:
>    - power-domains
>    - clocks
> =20
> +allOf:
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            contains:
> +              const: nxp,imx94-lvds-csr

[Severity: Medium]
Does this restriction improperly forbid the ldb child node on i.MX95 device=
s?

The clock driver exposes LDB-related clocks for the i.MX95 variant, so it
seems nxp,imx95-lvds-csr is also an LVDS CSR that controls the LVDS Display
Bridge. By omitting nxp,imx95-lvds-csr from this check, will valid i.MX95
device trees defining the ldb child node fail schema validation?

Should this condition check an enum containing both nxp,imx94-lvds-csr and
nxp,imx95-lvds-csr instead?

> +    then:
> +      patternProperties:
> +        "^ldb@[0-9a-f]+$": false
> +    else:
> +      required:
> +        - '#address-cells'
> +        - '#size-cells'

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-dcif-upstr=
eaming-v9-0-8d0ff89aa3c5@oss.nxp.com?part=3D6
