Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A817ECC6B16
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB12410EAA1;
	Tue, 13 Oct 2026 15:36:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0678B10EC8D;
 Tue, 13 Oct 2026 15:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C43B1433AB;
 Tue, 13 Oct 2026 15:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2236B1F000FF;
 Tue, 13 Oct 2026 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791905772;
 bh=x/r2qWknVX2TAzPiv1tCSqpXAUTpPajkXsHA7HYPXA8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iXwzVNFE9iJoQ7G94gK/qyzvD4nPXrjp2gI+RhH2u/JDsBAW9S9Jd0j3wTJ+6g2P/
 +KBIeE4v+qFrhldJ8WRBXvguP7p+BD4jv2hvV4bWP3/Z3UyaJjLyvxaOWpuTIGD+Cz
 hwxwWwAe+h7/MoemGZPI+h3eBCxAEnRWazrw3OigTP9x3lfrjKQAysinZ3KFFqL7Qv
 c3qUThFA/xM/YbfSWkUYgBiqYCIXmCJuinDLRUHbVxCZ4aH38KN+g8aGVxkoioKyTY
 FChL2VTbCjZK9eueD7feTUzantIJSs8Ua/MvZG4+J1Tiw4FuNe6UTVmd3WHedV8YLp
 sznf4tMiD4FjA==
Date: Tue, 13 Oct 2026 17:36:09 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Aaron Kling <webgeek1234@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: gpu: nvidia,gk20a: Allow a fuse clock
 after the reference clock
Message-ID: <as5N73fHztX8hVWh@orome>
References: <20261013145210.103565-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="34qab4dj6g2yo5tq"
Content-Disposition: inline
In-Reply-To: <20261013145210.103565-1-sashal@kernel.org>
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


--34qab4dj6g2yo5tq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] dt-bindings: gpu: nvidia,gk20a: Allow a fuse clock
 after the reference clock
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 10:52:08AM -0400, Sasha Levin wrote:
> GM20B needs both its reference clock and the fuse clock while it is
> powered, so allow "fuse" as a fourth clock after "ref".
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml b/Do=
cumentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> index 4d856a8b674c..ecbc20e6adec 100644
> --- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> +++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
> @@ -44,6 +44,7 @@ properties:
>        - description: GPU clock
>        - description: Power clock
>        - description: Reference or fuse clock
> +      - description: Fuse clock
> =20
>    clock-names:
>      minItems: 2
> @@ -51,6 +52,7 @@ properties:
>        - const: gpu
>        - const: pwr
>        - enum: [ ref, fuse ]
> +      - const: fuse

Technically this now allows:

    clock-names =3D "gpu", "pwr", "fuse", "fuse";

I think we may need a very explicit version to cover this now, something
like:

    clock-names:
      oneOf:
        # for GK20A, GP10B, and GV11B
        - minItems: 2
          items:
            - const: gpu
            - const: pwr
            - const: fuse

        # for GM20B
        - minItems: 3
          items:
            - const: gpu
            - const: pwr
            - const: ref
            - const: fuse

We may also want to leave out the minItems property because it turns out
the FUSE clock is indeed required, so we'll need to add it to all device
trees anyway to fix this hang.

The exact list of items could also go into the per-SoC/GPU conditional
sections to be very exact.

Thierry

--34qab4dj6g2yo5tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrOT+YACgkQ3SOs138+
s6HSbA/9GTMrx+cAkk1jspRnNnC4NMPsgoLBelda/o0nNLddHezxqjelJQZe2ITB
BcLwHzvG+yZIoqvcobrIM3ub+u150reF93lLkcJhUyIDUzvEEztSfHPVg39ffBVl
5THw3xMl5EXKrpYH2KGpGiYILz9hGsLLE1tVJnzJXUNJNewbMClq9QaCtPw20fqS
tRCrdaRRCgnfckfg4Q8F0Mwy8CHheHdayMY3qX/u67b85pbYfyx54ZNF/Ro/Z0/j
DP4xiuFsdppuYbb9tSJGc9bEPVn6ReFS1VTREGI0S7NRxIRKivktTaLWFSkH7mAc
wREmsx5iMeUxrxmQ443TQLUdY28h13A+pA2Wb+Nc6m+7LKbuw3nEAShix9ifPGv4
KAI3ukE8RV5JRy8whJLTNk1Pph9oBMf1CkyOVCAlZq1Q8uH++2ZBwbBjgEfacKgE
qPgJyiYTHQ+RsuFvXBsKMiFat2hv3YaVvTWsG7NdO2BAzrh5Oi2zMeGG61R5Jcri
X68hLj4z3ooAyGAO0Af9Dn9pFc21nc8e7Nv4wtPWF7FRv9D2aYr1sL9jEBMbMjp2
XE2PM4N9S+w4QQZiqZOMIuqp4bp9IwJNT3f2RPZ93FmED1ZeAc5L2aKCB4u+X51h
JK2KABvBUdzZeLdvPV+A1tfe2nNtMTUQufpUKEsAZIOKgN2EZSk=
=EVv3
-----END PGP SIGNATURE-----

--34qab4dj6g2yo5tq--
