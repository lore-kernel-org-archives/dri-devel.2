Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C131C982E6
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C75010E7CE;
	Sun, 20 Sep 2026 11:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EJobMpyz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0BC10E7CE
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:12:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A488601FD;
 Sun, 20 Sep 2026 11:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D061F00893;
 Sun, 20 Sep 2026 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789902774;
 bh=SfOkMbGqoJf95+haSaA+DqVFyDYytyE6Ldla0XNPubw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EJobMpyz7txAjwv2b/ggrwF3NgzwID0HXMt78honBc1fbeHpUTITydyCjXGapy41c
 QUOMkggkbShzO2ZkYV0wqfdcPMNb/4SNSYsx4T8kQWgw73nUgmLliGTh47WDAD/cZt
 tfPiYPB3yEBdlp1agW8ACyS6x4xplCpgfD/sS7DroxFyH/1aH7+fRnGn5p+t6U1JHk
 6DhpWZtxOYTsRI1aRXW84D2ronSH07WheKuut0V7uYERFF2cRndKm9NRnIO21AHLCl
 Dk3anSgkCTe25oX1PG/V5OnRWxCNG487hE3jci4JWJHazl4tviu0nNE7D81pdlxvAd
 riPQ3I3ewuJeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: display: panel: samsung,s6e3ha8: Add
 AMB630QY01 panel
To: "David Heidelberg" <david@ixit.cz>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260920-crosshatch-panel-v1-2-de6e9512da96@ixit.cz>
References: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
 <20260920-crosshatch-panel-v1-2-de6e9512da96@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 11:12:53 +0000
Message-Id: <20260920111253.E0D061F00893@smtp.kernel.org>
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
- [Low] dt-bindings: commit message omits deprecation and new compatible st=
ring
--

commit 1def073e2834624beafbcc0f1b404f941e99bc1b
Author: David Heidelberg <david@ixit.cz>

dt-bindings: display: panel: samsung,s6e3ha8: Add AMB630QY01 panel

This commit adds device tree binding support for the AMB630QY01 6.3" flexib=
le
AMOLED panel used in the Google Pixel 3 XL.

> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3=
ha8.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.=
yaml
> --- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha8.yaml

[ ... ]

> @@ -38,12 +60,17 @@ properties:
>    compatible:
>      oneOf:
> -      - const: samsung,s6e3ha8-amb577px01
> +      - enum:
> +          - samsung,s6e3ha8-amb577px01

[Severity: Low]
This isn't a bug, but does this introduce a new compatible string that is
completely undocumented in the commit message? The commit log solely claims=
 to
add support for the AMB630QY01 panel, leaving this change unexplained.

> +          - samsung,s6e3ha8-amb630qy01
>        - const: samsung,s6e3ha8
>          deprecated: true

[Severity: Low]
This isn't a bug, but could the commit message be updated to explain the
deprecation of the original generic compatible string? The change implicitly
deprecates the generic samsung,s6e3ha8 string without explanation in the
commit log.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-crosshatch=
-panel-v1-0-de6e9512da96@ixit.cz?part=3D2
