Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077CAC5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 19:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B4910E079;
	Sat,  8 Aug 2026 19:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N1yKt2Je";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92F910E079
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 19:06:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EB344182A;
 Sat,  8 Aug 2026 19:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1911F000E9;
 Sat,  8 Aug 2026 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786216018;
 bh=TP5PC3Fnz00RrBL1TKDcW5utjWZomDFwgs70A2DAmEE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=N1yKt2JejwlLEj3uoI4wukhufiW0f0zDYwTl3ayJX8d1xRsIFHiWqv3pkU+toMEn3
 XR3cswc0kIE7gA6epxZ8tftSe8AUbP3JAXdvna1vCIiPYFri/qmlZG55uTj67xUAKP
 p5xRseV9N/Sg3oyitLiNvGNILh0gABofaBsFH5KzxWf5gEv+Ge2Owr4pzq4/G/vpnb
 h4L5vQejXG1LFE/8yFYHGcEkuk73ymBt+Tm7x46NC8fSlnHP4lxnz59/wJhOdIq3G5
 U2iqbGzKZ84bPo7QCoVDubQHFlmqq06FHdSLHVVPQhxrSpPrSKbyqBGjV8lYp2AUGO
 VyMvQFdqWS8hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7836A
 OLED driver
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260808-ili7836a-v1-1-07a7becc5636@gmail.com>
References: <20260808-ili7836a-v1-0-07a7becc5636@gmail.com>
 <20260808-ili7836a-v1-1-07a7becc5636@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 19:06:57 +0000
Message-Id: <20260808190657.ED1911F000E9@smtp.kernel.org>
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
- [Low] The vendor prefix `retroidpocket` used in the new compatible string=
 is not documented in `vendor-prefixes.yaml`.
--

--- Patch [1]: [PATCH 1/2] dt-bindings: display: panel: add Ilitek ILI7836A=
 OLED driver ---
commit aacb89a0d4e50af14a474c3071ac0dce394b199e
Author: Aaron Kling <webgeek1234@gmail.com>

dt-bindings: display: panel: add Ilitek ILI7836A OLED driver
   =20
This commit introduces a new device tree binding for the Ilitek ILI7836A
OLED driver. It documents the properties and compatible strings required=20
for the MIPI-DSI display used on the Retroid Pocket Nova.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili78=
36a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili7836a.=
yaml
> new file mode 100644
> index 0000000000000..962cf257ed8d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili7836a.yaml
[ ... ]
> +properties:
> +  compatible:
> +    items:
> +      - const: retroidpocket,nova-panel

[Severity: Low]
Is the retroidpocket vendor prefix documented in vendor-prefixes.yaml?
Adding a compatible string with an undocumented vendor prefix will cause a
build warning when running make dt_binding_check.

> +      - const: ilitek,ili7836a
> +
> +  reg:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808-ili7836a-v=
1-0-07a7becc5636@gmail.com?part=3D1
