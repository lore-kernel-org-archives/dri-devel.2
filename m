Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F46EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E514910F2F8;
	Wed,  8 Jul 2026 21:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AgCm2ae5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE5E710F2F2
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:54:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97BA8405D4;
 Wed,  8 Jul 2026 21:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2879A1F000E9;
 Wed,  8 Jul 2026 21:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783547694;
 bh=6w+R1mf0TlvlvB1TKHCcuq+a4bqdxoEHhEQSGGmNSk8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AgCm2ae5GjSC73o8AIlDs0/hieZBjH8lMFcTxWhgq1cFtQ+ZHB6cIFILxq5k1w0oz
 tuTwyiaUMZ+HuLCzH+6WS27rW7nZQnJwMSIA/DXyzQSeSBfFkgA78g6GqClI8yglNU
 vfzQZhISIKwCH08+zYHjGmh3PxwjRjeq3aPgb3utQFNOtwGc38taZFY/6IFbOsoMVH
 3mRZvUr6aYY5Y6i5faSPiIyS2A6fN5JD1JEaB4mr7gese97ciCOTEA8/HluPHDY6xG
 tprSz3m/AXvWl9juq+yOvBYAh29c4Qc72QC0hU/0vTZLxIzAeREwbvsUURkv+MSoEM
 jBhq8wpmK7pQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: display: panel: add compatible for
 DCLTek 300250 9.35in panel
To: "Marc-Olivier Champagne" <marc-olivier.champagne@savoirfairelinux.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260708213500.1867092-5-marc-olivier.champagne@savoirfairelinux.com>
References: <20260708213500.1867092-1-marc-olivier.champagne@savoirfairelinux.com>
 <20260708213500.1867092-5-marc-olivier.champagne@savoirfairelinux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:54:53 +0000
Message-Id: <20260708215454.2879A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added compatible string `dcltek,dt300250` will not be =
probed by the panel driver due to missing `of_match_table` entry.
- [Low] Redundant assignment of `jadard->panel.prepare_prev_first =3D true;=
`.
--

--- Patch [4]: [PATCH 4/5] dt-bindings: display: panel: add compatible for =
DCLTek 300250 9.35in panel ---
commit eaec789ca9baff9cff690aca5a539d1f1eb81d5f
Author: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>

dt-bindings: display: panel: add compatible for DCLTek 300250 9.35in panel

The DCLTek dt300250 is a panel using the jadard-jd9365da controller.
Add a new compatible for it.

> diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd936=
5da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365=
da-h3.yaml
> index 4eae802de9fd5..9e20e2faf82fa 100644
> --- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.=
yaml
> +++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.=
yaml
> @@ -19,6 +19,7 @@ properties:
>            - anbernic,rg-ds-display-bottom
>            - anbernic,rg-ds-display-top
>            - chongzhou,cz101b4001
> +          - dcltek,dt300250

[Severity: Medium]
Will the panel driver successfully bind to this new compatible string?

Looking at jadard_of_match in drivers/gpu/drm/panel/panel-jadard-jd9365da-h=
3.c,
it seems neither this new compatible string nor a generic fallback is prese=
nt
in the match table:

drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c:jadard_of_match[] =3D {
    {
        .compatible =3D "anbernic,rg-ds-display-bottom",
        ...

Without a matching entry in the of_match_table, does this regression cause
the device to fail to probe?


[Severity: Low]
Looking at the driver changes introduced earlier in this series by commit
1a793dbc7476, is there a redundant assignment to prepare_prev_first?

drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c:jadard_dsi_probe() {
    ...
    jadard->panel.prepare_prev_first =3D true;
    ...
    jadard->panel.prepare_prev_first =3D true;
    ...
}

Could this regression be a duplicated assignment in the same function?

>            - kingdisplay,kd101ne3-40ti
>            - melfas,lmfbx101117480
>            - radxa,display-10hd-ad001

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708213500.1867=
092-1-marc-olivier.champagne@savoirfairelinux.com?part=3D4
