Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F5DCD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA3410E1E1;
	Thu, 21 May 2026 16:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SXKmy9UF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B69810E1E1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:54:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D01B60210;
 Thu, 21 May 2026 16:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7A71F00A3B;
 Thu, 21 May 2026 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779382451;
 bh=/GRo7o08a1l3ZN6BhgKh2FsIs5V4EFMxUDnDJW7BBe8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SXKmy9UFEKIKSPyYvuaTZ3r1bUQhgnulIc7Mv5IOaMhwGFHGc2Z9mYR1PnMbrjspa
 r3hUYKEQdggxmUzJtx5/0/4+A2t6UVn94gTpM8tFbf6gwtJvEzyg/mQ3NpuMl008gR
 S3o1vVP39k5n1PYUwDeegvjqVXgT4Wdq2Vg2zdZnKJRI4kDNdvyFAqhBTji1+J1vs/
 uOaZCDCoFVd95jtVRW5Y//rXa/6sB6rJNke9a7/5Dx07PPvkEs6GLNK3MY2jRRWxYu
 6LM+8G75IIxTEDnV731/kqo5QgldUXxWoGH3L8uo0Uo/ruiVFYW77TxE9yIfU/WQlp
 5ZfScLGuMV4mA==
Date: Thu, 21 May 2026 17:54:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 14/15] dt-bindings: display: panel-lvds: Add LG LP156WF1
Message-ID: <20260521-eggplant-specimen-fd8cb181f051@spud>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-31-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n8r+0FfwGFiOSm+6"
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-31-ivitro@gmail.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--n8r+0FfwGFiOSm+6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 04:00:50PM +0100, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
>=20
> Add the compatible string for the LG LP156WF1 15.6" FHD (1920x1080)
> dual-channel TFT LCD LVDS panel.
>=20
> Assisted-by: Claude:claude-sonnet-4.6
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> ---
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.y=
aml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> index 45183a1439ce..a6af2b9cc2f9 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
> @@ -58,6 +58,8 @@ properties:
>            - hydis,hv070wx2-1e0
>            # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT =
LCD LVDS panel
>            - jenson,bl-jt60050-01a
> +          # LG LP156WF1 15.6" FHD (1920x1080) dual-channel TFT LCD LVDS =
panel
> +          - lg,lp156wf1
>            # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap =
Touch Mod.
>            - logictechno,lt170410-2whc
>            # Riverdi RVT101HVLNWC00 10.1" WXGA (1280x800) TFT LCD LVDS pa=
nel

Copy pasting a reply from me to sashiko-bot, cos the mail from it only
went to the submitter, dt maintainers and dt list:

|On Thu, May 21, 2026 at 03:27:16PM +0000, sashiko-bot@kernel.org wrote:
|> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
|> - [Medium] The dt-binding fails to enforce the dual-channel requirement =
(the `ports` property) for the newly added `lg,lp156wf1` compatible string.
|> --
|>
|> commit a568203d1851908daadd835b566099e0a123357a
|> Author: Vitor Soares <vitor.soares@toradex.com>
|> dt-bindings: display: panel-lvds: Add LG LP156WF1
|>
|> This commit adds the compatible string for the LG LP156WF1 15.6" FHD
|> dual-channel TFT LCD LVDS panel to the generic panel-lvds schema.
|>
|> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvd=
s.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
|> > index 45183a1439ce9..a6af2b9cc2f9a 100644
|> > --- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
|> > +++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
|> > @@ -58,6 +58,8 @@ properties:
|> >            - hydis,hv070wx2-1e0
|> >            # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color T=
FT LCD LVDS panel
|> >            - jenson,bl-jt60050-01a
|> > +          # LG LP156WF1 15.6" FHD (1920x1080) dual-channel TFT LCD LV=
DS panel
|> > +          - lg,lp156wf1
|>
|> [Severity: Medium]
|> Since the commit message indicates this is a dual-channel panel, shouldn=
't we
|> add an if-then conditional block to require the ports property specifica=
lly for
|> this compatible string?
|
|No idea if this is accurate, but if it is accurate, would the
|lvds-dual-ports bindings come into play?
|
|>
|> Currently, the panel-lvds.yaml schema allows panels to be configured with
|> either a single port or multiple ports. Without a specific conditional b=
lock
|> enforcing required: [ports] for lg,lp156wf1, a device tree incorrectly
|> configuring this dual-channel hardware with only a single port will sile=
ntly
|> pass validation.
|>
|> --
|> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260521150038.1035=
38-17-ivitro@gmail.com?part=3D14

I don't understand these deviecs enough to know if this is a valid
report.

--n8r+0FfwGFiOSm+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag84rQAKCRB4tDGHoIJi
0sSWAQDrnpMcfFxMuM+qUBz6FEBZvmI9LBxIr062YHJ2DO6zwgEA8Gci/LHEtOy2
WtocKXXwwmCkoBNUorqgVE898xBIhAA=
=3CBI
-----END PGP SIGNATURE-----

--n8r+0FfwGFiOSm+6--
