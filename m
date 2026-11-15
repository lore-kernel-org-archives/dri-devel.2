Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFB606A329
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lq+2rEsF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E3AE10E348;
	Sun, 15 Nov 2026 20:32:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ED710E348
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 20:32:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D5BD60613;
 Sun, 15 Nov 2026 20:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999721F000C4;
 Sun, 15 Nov 2026 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794774765;
 bh=Zdmt3jaBqypK+XeCbxAWVFpPyKwA95vmyKO52U+w3qc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lq+2rEsF6iMpDb1IwoD2+0cgSyLADGlnTXGAu0NOg3cYSd++1gq98o94hulthCOT2
 frDkvHtptfzf1K5CX1f87oErJanLj3TraoJhU2oNk3gSOlrT+JpIc9rp0xVnocUCqc
 846qtgDsGtScwFDSNaZbG+2wP7eLH2weVIbtYPO/W0hG7QvcGuLNHbHWkBm5z7BmDs
 LqRMbnCptKqDxbAWgublLrK1g+91QuYFMf+z8nWpq7S+qsOZxSe0qhhwI02E3HNAgk
 9bA8k+TSgblWGX9bci1282J8z5RCuDlcSNPwSbmyslI/i6j7n17/S5iN/CyIBOi8ur
 R2u5kvaVN5KOw==
Message-ID: <sashiko-outbox-215828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Ilitek ILI97680A
To: "Venkat Yadlapati" <venkat.yadlapati@yahoo.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-vantage-panel-v1-1-30b95bd49216@yahoo.com>
References: <20261116-vantage-panel-v1-0-30b95bd49216@yahoo.com>
 <20261116-vantage-panel-v1-1-30b95bd49216@yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:45 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dt-bindings: display: panel: missing panel-specific
  compatible string
--

commit 7841ad6a366c1d68596c6fd31270d044bd848d2b
Author: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

dt-bindings: display: panel: Add Ilitek ILI97680A

This commit adds a Devicetree binding schema and MAINTAINERS entry for the
Ilitek ILI97680A-based 1264x2780 BOE AMOLED panel found in the Motorola
Signature.

> diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili97=
680a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680=
a.yaml
> new file mode 100644
> index 0000000000000..f3323fbd587f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.ya=
ml
> @@ -0,0 +1,70 @@

[ ... ]

> +description:
> +  1264x2780 BOE AMOLED panel driven by an Ilitek ILI97680A controller ov=
er
> +  four MIPI DSI lanes in command mode with DSC 1.2 compression, as found=
 in
> +  the Motorola Signature.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ilitek,ili97680a

[Severity: Medium]
Should compatible require a specific panel compatible string (such as
boe,<panel-model> or motorola,signature-panel) followed by ilitek,ili97680a
as a fallback?

ILI97680A is the display controller IC driving a specific 1264x2780 BOE
AMOLED panel.  Other panels built around the same controller can have
different resolutions, dimensions, DSC settings, and initialization
sequences, so using the bare controller compatible alone prevents
distinguishing them in future Devicetrees without breaking ABI compatibilit=
y.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-vantage-pa=
nel-v1-0-30b95bd49216@yahoo.com?part=3D1
