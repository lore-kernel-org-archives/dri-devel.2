Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44226C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C2910E1A4;
	Sun,  5 Jul 2026 15:44:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B9Qv+aus";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AABFC10E1A4
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 15:44:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA0F661383;
 Sun,  5 Jul 2026 15:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2CB1F000E9;
 Sun,  5 Jul 2026 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783266281;
 bh=Sa8jdhCDuQzGZGcwxGMxwjLf+rQBmxGamD9N86r0hPg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B9Qv+ausO2ouIiVmxUkSECnmoACFqieGSId9pOvnJqVPSZBgKlZPTFPmvwaxKdRXO
 jNc5IGSUvaJbXHJcqCR4JkfK1tIrtGQ9ABC5d38bM1149t8UxtXvUFvDZvvtDFmJ9+
 b5yHqgUcxsyWlE5qLtqdQ3NIK8T/Ko8XeokbObdSnF0491EsTvlYDYgTB8f3pLLafB
 g/cSV/zLWzsG1/2aVd3BE0i9Aoc+KsbA+S9WHhfGmDW8AuSAP7gG+FJNGcwsp7Vf6s
 L29gBVz7Om1P7Q91guKK+dgrXVFYY2ERyc+xSzxA1QikRNbzlH4gtG8sybOqbNFsXU
 +I5qLR61Q24QA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT36536
To: "Pengyu Luo" <mitltlatltl@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260705153515.46147-2-mitltlatltl@gmail.com>
References: <20260705153515.46147-1-mitltlatltl@gmail.com>
 <20260705153515.46147-2-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 15:44:40 +0000
Message-Id: <20260705154441.2D2CB1F000E9@smtp.kernel.org>
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
- [Low] Incorrect use of `additionalProperties: false` instead of `unevalua=
tedProperties: false` in a schema containing an `allOf` reference.
--

commit 40b975ec362c58607cb7c58d87a808388df1aa11
Author: Pengyu Luo <mitltlatltl@gmail.com>

dt-bindings: display: panel: Add Novatek NT36536

This commit adds a new devicetree binding schema for the Novatek NT36536 DSI
panel IC, which supports video mode panels like the dual-link 10-bit CSOT
PP8807HB1-1.

> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36=
536.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.=
yaml
> new file mode 100644
> index 0000000000000..1e86f5329b222
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
[ ... ]
> +allOf:
> +  - $ref: panel-common-dual.yaml#
> +
> +properties:
[ ... ]
> +  vsn-supply:
> +    description: Negative source voltage rail
> +
> +  backlight: true
> +  ports: true

[Severity: Low]
Should these properties be omitted? They are already defined in the referen=
ced
common schemas and appear to be redundantly redefined here solely because of
how additionalProperties is evaluated below.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - reset-gpios
> +  - ports
> +
> +additionalProperties: false

[Severity: Low]
Does this directive incorrectly restrict the schema since there is an allOf
reference above? Using additionalProperties: false will cause dtbs_check to
reject valid board configurations that use standard panel properties define=
d in
panel-common-dual.yaml and panel-common.yaml (such as rotation or width-mm).

Should this be changed to unevaluatedProperties: false instead? Once that is
corrected, the redundant backlight and ports entries above can likely be
removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705153515.4614=
7-1-mitltlatltl@gmail.com?part=3D1
