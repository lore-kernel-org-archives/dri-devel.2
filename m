Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E104CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C3810E1DA;
	Tue,  6 Oct 2026 12:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WXmVXP7W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5197610E1DA
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:35:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B24060234;
 Tue,  6 Oct 2026 12:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C911F00893;
 Tue,  6 Oct 2026 12:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791290101;
 bh=QmxIbqvDsq9l5YYyvR9X8Zb0Z4CnWUHkZNsWXAw9LqY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WXmVXP7WQgu+WfHWF15Ga63mp3w1ZfcBx0m4Csdt4S17QyRXKwAVOVVsdsfr+7USs
 +Mdhvbu6OcVt9ky/SavGlEC+LUBdO5Y13oI4sq9TfTVjPPfU1vT2QuEuc/qjrQgrdX
 6Jb6xdtD1zMjSC1mooX4nt4sJuBl6H45LziUV8HxxCxdNsDIR4MImnXADTAUbmxLjs
 9BA72egvEeP09xMcbH5Ut58BcmIrJ83Gca6ep83+QFUReS4296OftEkPgaI33dBDqQ
 U2goEnR+MoAlZrk1/8lT8cFFUf10wT9gU2jIh7b0fkkwDLY8hYrAE18/rPA+98+o9i
 W1OmJv0SawmHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-6-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:34:59 +0000
Message-Id: <20261006123500.94C911F00893@smtp.kernel.org>
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
- [Medium] dt-bindings: missing LDB constraints for nxp,imx95-lvds-csr vari=
ant
--

commit ef256d56e7840a3d6a825d4ac33adad77eacd513
Author: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb child node

Since the BLK CTL registers, like the LVDS CSR, can be used to control the
LVDS Display Bridge controllers, add 'ldb' child node to handle
these use cases.

> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.ya=
ml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index fbbf1b3f17904..97fe816a38f94 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
[ ... ]
> @@ -63,7 +67,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: nxp,imx95-camera-csr
> +            enum:
> +              - nxp,imx94-lvds-csr
> +              - nxp,imx95-camera-csr
>      then:
>        required:
>          - '#address-cells'

[Severity: Medium]
Could this introduce a regression where device tree validation incorrectly =
fails
for i.MX95 devices that define an ldb child node under the LVDS CSR?

This change restricts #address-cells and #size-cells to these two strings,
forcing them to false for nxp,imx95-lvds-csr. Should nxp,imx95-lvds-csr also
be included in this enum?

[ ... ]
> @@ -72,8 +78,24 @@ allOf:
>        properties:
>          '#address-cells': false
>          '#size-cells': false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: nxp,imx95-camera-csr
> +    then:
>        patternProperties:
>          '^formatter@[0-9a-f]+$': false
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: nxp,imx94-lvds-csr
> +    then:
> +      patternProperties:
> +        '^ldb@[0-9a-f]+$': false

[Severity: Medium]
Does this introduce a regression by preventing nxp,imx95-lvds-csr from
declaring an ldb child node?

This explicitly forbids the ldb child node for anything other than
nxp,imx94-lvds-csr, thereby silently prohibiting it for nxp,imx95-lvds-csr.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-dcif-upstr=
eaming-v10-0-bcfb28de0aae@oss.nxp.com?part=3D6
