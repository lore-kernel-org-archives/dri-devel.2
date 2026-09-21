Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABEFC982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732C910E34F;
	Mon, 21 Sep 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XGB9J7l3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBA610E34F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:29:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9655F439A0;
 Mon, 21 Sep 2026 18:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A7C1F000FF;
 Mon, 21 Sep 2026 18:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015361;
 bh=H62gcGWcKbrWTMkCd01zYMB7sv2iKehtP20WLbKlyIs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XGB9J7l3gJREfd1Qyl8enfohbQD20I1vJdBiXfoF0uwrIJ3bWBPwrpVDcJyP4S8co
 ag5+ahJTnQOa2CMFQleiMxg9BTkj3RhML5jkYUKEpERbx4eQuW6IliiHSpRlhTpjcg
 /fPynkQMx4C01qvCjYL2IjLDwjLPEN47xeylnSdok1nBzBPn4+zObvivXOG4+NHMFQ
 IM9QCu2ftE/qgR33maeYHQFdEyDGLFx6BIViw4Aaa5/JTbO9CxeRNY6l1bRAEgCP6V
 IbQ8+d6YEEW4CbGMQ5tFiFwILsVnvKSaEwVs/fOwZPvC8MYJeW1ILdpV4Ph6/WJMAH
 wiifybudk+ehg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/19] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 linux-clk@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 mfd@lists.linux.dev
In-Reply-To: <20260921-msm8952-initial-support-v3-18-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-18-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:29:20 +0000
Message-Id: <20260921182920.F3A7C1F000FF@smtp.kernel.org>
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
- [Medium] input: touchscreen: goodix: incomplete GT970 support causes conf=
ig length mismatch
--

commit fb8dc3b0be08be515a9f9b03de04ea7da115bf6f
Author: Muzaffer Kadir <muzafferkadir@mainlining.org>

dt-bindings: input: touchscreen: goodix: Add binding for GT970

This commit adds the goodix,gt970 compatible string to the DT binding.
It specifies that the GT970 should fall back to the goodix,gt911
compatible string to use the GT911 driver configuration.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.y=
aml b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> index a26a54d63a1c0..4be2c137abd7c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.yaml
> @@ -14,21 +14,26 @@ allOf:
> =20
>  properties:
>    compatible:
[ ... ]
> +      - items:
> +          - enum:
> +              - goodix,gt970
> +          - const: goodix,gt911

[Severity: Medium]
Will this require a corresponding driver change to work correctly?

When the driver probes the device, it uses goodix_get_chip_data() to choose
configuration parameters based on the hardware ID read from the device, rat=
her
than the DT compatible string.

Because "970" is missing from the goodix_chip_ids[] array in
drivers/input/touchscreen/goodix.c, it appears the driver will ignore this =
DT
fallback and apply the generic 240-byte configuration instead of GT911's
186-byte configuration.

Could this incorrect configuration length cause the driver to read or write
past the end of the configuration registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D18
