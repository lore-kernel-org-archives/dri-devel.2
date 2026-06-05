Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80492CD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D3C11AA5D;
	Fri,  5 Jun 2026 18:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="l+FIJSoX";
	dkim-atps=neutral
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch
 [109.224.244.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD3111AA5F
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780684638; x=1780943838;
 bh=HnEAjbYdrwt2ZUBl5XxwHoVRcBJydiwq0iDN1d+q7u8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=l+FIJSoX5x3n1UATFHj8/Ype1pLqIadVPMTkCkyWat6I/v0T/WyhWzUrpcFT/Uz2K
 EREYc4rF8m2XTLPaoFwO3L1MDC8mJLS7zJ9XM7u9NHqrPNQfATchTq53w5FtLOn9Uy
 DkROlaYwsgBi76MPt90uBHED51wNNWoCJNDc69GADAMR3xcfeK5adRfrNa6VrZDZVx
 HINt51xDCuxaoUkB/E9Fq6jDaEKyRRS+FOZletyxtjzwCSV4/JJYQztBnk2JlJX/YZ
 PGbvgbjKkKgQ6okNMxrq2sjL5HW1TffD+cKHmytwso0cM3xuTV6fqD2Lr9qKXJkris
 dSCBWQGZC0Cpg==
Date: Fri, 05 Jun 2026 18:37:11 +0000
To: sashiko-reviews@lists.linux.dev
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Document Raydium
 RM69220 DDIC
Message-ID: <bz9vWgofmc_257MBAJFRETCchlU3NkTiEkOl-ADSbDOR0ncCQTluKglcHRQgL8ojI8yXSPPbYzCwnMyaBZQAGSEOWL0DBHXqpfUR9eKbg3w=@pm.me>
In-Reply-To: <20260605183434.273CE1F00893@smtp.kernel.org>
References: <20260605-asteroids-panel-support-v2-1-44b96c6eca91@pm.me>
 <20260605183434.273CE1F00893@smtp.kernel.org>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 28cb9d9c2537be9b600771d9e8ce5df823ee51d2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Friday, June 5th, 2026 at 2:34 PM, sashiko-bot@kernel.org <sashiko-bot@k=
ernel.org> wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The newly added DT binding schema introduces a dtbs_check regress=
ion for an existing dummy panel node in `arch/arm64/boot/dts/qcom/milos-not=
hing-asteroids.dts`. The existing device tree uses `compatible =3D "boe,bf0=
68mwm-td0"` for a simple-framebuffer dummy node, but lacks the strictly req=
uired properties mandated by the new schema.
> --
>=20
> commit 6315e592e65e15de511f78a600454fa1ddbaf9e2
> Author: Alexander Koskovich <akoskovich@pm.me>
>=20
> dt-bindings: display: panel: Document Raydium RM69220 DDIC
>=20
> Document the Raydium RM69220 DDIC and the BOE BF068MWM-TD0 6.77"
> 1080x2392 AMOLED display panel used in the Nothing Phone (3a).
>=20
> > diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm=
69220.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm6922=
0.yaml
> > new file mode 100644
> > index 0000000000000..7423b192d892c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69220.y=
aml
> [ ... ]
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - boe,bf068mwm-td0
> > +      - const: raydium,rm69220
>=20
> [Severity: Low]
> Will this strict compatible requirement trigger dtbs_check failures for t=
he
> existing dummy panel node in
> arch/arm64/boot/dts/qcom/milos-nothing-asteroids.dts?
>=20
> That file currently uses this compatible string for a dummy node:
>=20
> =09=09=09/* Dummy panel for simple-framebuffer dimension info */
> =09=09=09panel: dummy-panel {
> =09=09=09=09compatible =3D "boe,bf068mwm-td0";
> =09=09=09=09height-mm =3D <157>;
> =09=09=09=09width-mm =3D <71>;
> =09=09=09};
>=20
> Since the new schema mandates a two-item array with "raydium,rm69220" and
> several other required properties like dvdd-supply, reg, and port, valida=
ting
> the existing dts against this schema appears to cause validation failures=
.
>=20
> Should the dummy node's compatible string be updated to avoid conflicting=
 with
> the actual hardware schema, or should the dts update be included in this
> series?

The dummy node is being dropped here:
https://lore.kernel.org/linux-arm-msm/20260603-asteroids-drop-simplefb-v1-1=
-34d73477c9d4@pm.me

>=20
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605-asteroid=
s-panel-support-v2-0-44b96c6eca91@pm.me?part=3D1
> 
