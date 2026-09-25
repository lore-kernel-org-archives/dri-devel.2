Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31528C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A7E10E23A;
	Fri, 25 Sep 2026 07:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ADPMwDDG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CDBA10E23A
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:12:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B2EA6022E;
 Fri, 25 Sep 2026 07:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF11F000FF;
 Fri, 25 Sep 2026 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790320359;
 bh=NVNtdfaFuhQM5ZtGJkq2qCGOSaGMPFe6Csf0NwoMr4E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ADPMwDDGlI1Ole2f5pmjuNSwhTO5ZOFXTT6tUkRNc9DzHzjfqVfOd/pN9jJV8jn3i
 qT2fNuyssbqufUBk/mMFQd+CsvQt0etIzKlLqj1TMmW+97tQfmBZtTSQzJBNvDgU9M
 LAckJm9k4e1zXG6swQB/xV8cN2MMl2txkYae4KRNd0zHfDsM5yUFWwEszb5tK/IuvZ
 AJOHkHilUkr5lM4JjLSL6QkXTUPxlXuawQmY42x7NMl9f8F8QuxCcB+PnHEDDXhMrX
 4xWCMBgfqY9A5kREODTP7NHq4GtyooMt4hn6bZ4Sy73eEwLZMXl9lC/ns5NMtEtWGn
 kiwkZO+Xl02EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: visionox,vtdr6130: Add
 Retroid Pocket 6 panel
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260925-rp6-panel-v2-1-19c425e523de@gmail.com>
References: <20260925-rp6-panel-v2-0-19c425e523de@gmail.com>
 <20260925-rp6-panel-v2-1-19c425e523de@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 07:12:38 +0000
Message-Id: <20260925071239.09DF11F000FF@smtp.kernel.org>
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
- [Medium] dt-bindings: vdd-supply validation dropped for visionox,vtdr6130
--

commit a3a48cee05612d79cd6eb27b26e83813b38aff64
Author: Aaron Kling <webgeek1234@gmail.com>

dt-bindings: display: visionox,vtdr6130: Add Retroid Pocket 6 panel

The vtdr6130 is a display driver integrated circuit, a common chip used
for various panels. One such panel is used in the Retroid Pocket 6.

> diff --git a/Documentation/devicetree/bindings/display/panel/visionox,vtd=
r6130.yaml b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6=
130.yaml
> index c99f4146f1bb0..682f30dc9ee43 100644
> --- a/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.y=
aml
> +++ b/Documentation/devicetree/bindings/display/panel/visionox,vtdr6130.y=
aml

[ ... ]

> @@ -25,13 +29,13 @@ properties:
>    vdd-supply: true
>    port: true
>    reset-gpios: true
> +  rotation: true
> =20
>  required:
>    - compatible
>    - reg
>    - vddio-supply
>    - vci-supply
> -  - vdd-supply

[Severity: Medium]
By dropping vdd-supply globally from the required list, does this cause
incomplete schema validation for the original visionox,vtdr6130 hardware?

Device trees using compatible =3D "visionox,vtdr6130" might now erroneously
omit the previously required vdd-supply property and silently pass schema
validation.

Should this be solved using an allOf and if-then block to conditionally
require vdd-supply only for the original hardware?

>    - reset-gpios
>    - port
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rp6-panel-=
v2-0-19c425e523de@gmail.com?part=3D1
