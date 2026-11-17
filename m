Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC47606A338
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZs3ch23
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C64B10E5A3;
	Tue, 17 Nov 2026 12:51:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761EC10E5A3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:51:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A26FC63473;
 Tue, 17 Nov 2026 12:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC091F000C4;
 Tue, 17 Nov 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794919902;
 bh=fGtOVnCx5r8R49kbtcig0TmxQsowQ/HRgdElWSS2vuU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BZs3ch23n8V47XS155+s+EALMGasR76F8dOmeD3n4ATVEQEF9FpBgST05M1SMFgNW
 EePcCYr6Dt2HWQab9NlrDayzW7Zq7sTJk30GWwYhkMxtp9BVnGk8vqcazod8Lygpjs
 Vtb8pSx90JA/1IW2Q50bEP0DtqcLi36XmSJ+dJ5xQbdsfHAzCoFJC0kLpjhpn3HnBz
 QtuWmtfbUclGrK5feg49dz58uABQ52g0KMgzaVSskk6is6LNWymfKFvuVVcKEHzDKK
 fn8fqxed0/K2yKaYOEBL7BMqPZTXD4AbB3E67RogiOsUkzaQAwGID8hnlFfWn1jN92
 CnMrPqHEs/XqA==
Message-ID: <sashiko-outbox-218810@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/11] dt-bindings: display: panel: add LG SW43103
To: rofikkerneldev <rofikcoga@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20261117123946.668557-5-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
 <20261117123946.668557-5-rofikcoga@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 12:51:41 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: display: panel: lg,sw43103: handle used instead of
  real name
- [Low] MAINTAINERS: LG SW43103 PANEL DRIVER added out of alphabetical
  order
--

commit 8f35306c3ad9479ca0f821358a8333dce583f152
Author: rofikkerneldev <rofikcoga@gmail.com>

> dt-bindings: display: panel: add LG SW43103
>
> Document the SW43103 FHD+ AMOLED panel used by the LG V60. The panel
> uses DSI command mode with DSC and DCS backlight control.
>
> Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
> ---
>  .../bindings/display/panel/lg,sw43103.yaml    | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw=
43103.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43103.y=
aml b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> new file mode 100644
> index 0000000000000..edd007e2c0d76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/lg,sw43103.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LG / BOE SW43103 1080x2460 DSI cmd mode panel
> +
> +maintainers:
> +  - rofikkerneldev <rofikcoga@gmail.com>

[Severity: High]
The commit Author, Signed-off-by trailer, DT binding schema maintainers
entry, and MAINTAINERS M: entry all use the handle "rofikkerneldev" instead
of a full real name.  Under the Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst and the MAINTAINERS file
requirements, these must use a real name in the form
"FullName <address@domain>".

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c88fc0e019296..e7e32c23ba2fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15231,6 +15231,11 @@ Q:	http://patchwork.linuxtv.org/project/linux-me=
dia/list/
>  T:	git git://linuxtv.org/mkrufky/tuners.git
>  F:	drivers/media/dvb-frontends/lgdt3305.*
> =20
> +LG SW43103 PANEL DRIVER
> +M:	rofikkerneldev <rofikcoga@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
> +

[Severity: Low]
This new section is out of alphabetical order in MAINTAINERS, which causes
scripts/parse-maintainers.pl --order to warn.  Since a space sorts before
digits and letters, "LG SW43103 PANEL DRIVER" should be placed after
"LG LAPTOP EXTRAS" and before "LG2160 MEDIA DRIVER".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117123946.6685=
57-1-rofikcoga@gmail.com?part=3D4
