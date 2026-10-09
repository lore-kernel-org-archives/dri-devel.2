Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEC5CA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DADC10E9B4;
	Fri,  9 Oct 2026 11:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B2reEFgz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C56A112059
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:03:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23F7E60534;
 Fri,  9 Oct 2026 11:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1791F00893;
 Fri,  9 Oct 2026 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791543837;
 bh=eCR2rVOxljXIgaUHxUERrq3IAIM7n1o13GUJ6/FeG0I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B2reEFgzgDrXm8laDOTo/HqkQTpR27aNEwkD/ANN9gVY3WliWPn3aa5MBW+8REmY1
 cp3WQst26on6jClVjGRxhyPnYmr63FFnVdqH6gE/5WLQpb9THYQEGQPrxaVru2Wsr+
 IUsBIehDHFsFJnH4/4y4LXWNKRvkl5Fqk9MQzS6Bz7mCtt119/inECA+QiDoAZBCNV
 0cHpt+kmKC7TKH1GvnRi2zEzudAM3gjVXoeHu9mS/eBo5SsA9TKaheb7j9Gcg7G/pf
 xvcRf/ynqT6EJud9GWvjf4mAMrBXa1R7HDj1ZTlc0vpLc0TYYbMRVgSWco6IVO56E4
 +oMSj4xwrAtog==
Message-ID: <sashiko-outbox-165306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ti,tpd12s015: Convert to DT
 schema
To: Quchaosheng <quchaosheng000406@163.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261009105356.300188-2-quchaosheng000406@163.com>
References: <20261009105356.300188-1-quchaosheng000406@163.com>
 <20261009105356.300188-2-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:03:57 +0000
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
- [Low] dt-bindings: display: ti,tpd12s015: missing minItems: 3 for gpios
--

commit d5e502558b023b930dba87dd54c3fb7121502833
Author: Chaosheng Qu <quchaosheng000406@163.com>

dt-bindings: display: ti,tpd12s015: Convert to DT schema
   =20
Convert the TPD12S015 HDMI level shifter binding to DT schema, documenting
the ports and compatible fallbacks.

> diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
> new file mode 100644
> index 0000000000000..1927da3bd7361
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

[ ... ]

> +  gpios:
> +    description:
> +      The CT CP HPD, LS OE and HPD GPIOs, in that order. The first contr=
ols
> +      the level shifter, the second enables the level shifter outputs and
> +      the third reads the hot-plug detect line.
> +    maxItems: 3

[Severity: Low]
Does this property need a minItems: 3 constraint?

If a device tree developer omits the first two optional GPIOs without using
<0> placeholders, the array will have fewer than 3 elements. This will pass
YAML schema validation.

However, the drivers handling this device (both ti-tpd12s015.c and
encoder-tpd12s015.c) unconditionally request the HPD GPIO at index 2 using
devm_gpiod_get_index(&pdev->dev, NULL, 2, GPIOD_IN).

If the array has fewer than 3 elements, the driver probe will immediately
fail at runtime with -ENOENT. Adding minItems: 3 would ensure the dt-schema
validation catches incomplete arrays earlier.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009105356.3001=
88-1-quchaosheng000406@163.com?part=3D1
