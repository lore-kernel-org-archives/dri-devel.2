Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04EDCC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39A410E4C7;
	Tue, 13 Oct 2026 15:47:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D77C10E4C7;
 Tue, 13 Oct 2026 15:46:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EA2440F7D;
 Tue, 13 Oct 2026 15:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB201F000FF;
 Tue, 13 Oct 2026 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791906419;
 bh=zrrwM+OoTQ5n+oUmClj8UHVrIw8n458ireLa+GKP5qM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BdqC9gMjE6f5EWWl1Xlpzgq2aOqELdaPtElELJu1ZCWu54KCsQoAD9g8r5t2rDi4o
 djw2jbEX0/MkPGgXpPDTCGuKmo24p0IuekQLxf6x1cuLJdDC3cunM45pw8Az2kWEfM
 ePK9sXqi3/K6TN1zi7I0dicxeuCMvq1uXcQUYNiL1HyCx5QjqM9G9Dnajn4MMimxwt
 JyEWcIJ1rbyqOG0SOgwVo+XP4LXaRm4mDWWNR/Agx7cClMcB7mcsuVYj4ZlED/P7Yd
 murSJvxLGW7OiJnPcKNfmu+pcczAFox3+JODJeTxENdI/IH+xarXL8w2KS7H0NrGug
 w0poGpFVwgbfg==
Date: Tue, 13 Oct 2026 17:46:56 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Sasha Levin <sashal@kernel.org>, Aaron Kling <webgeek1234@gmail.com>, 
 Diogo Ivo <diogo.ivo@bootlin.com>
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
Message-ID: <as5R_xrDv4eVPdtz@orome>
References: <20261013145210.103565-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nnyddv2boxnoq3dq"
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


--nnyddv2boxnoq3dq
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

Aaron, Diogo,

I'm fairly sure I remember at least one of you mentioning that GM20B
wasn't always working reliably. Would you mind giving this series a spin
on your devices to see if it fixes any issues you were seeing, too?

Thierry

--nnyddv2boxnoq3dq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrOUnAACgkQ3SOs138+
s6E07xAAhV16aE/vTmdXCWNQFDANmFHYGGkbT8iB51pQecVSkYApSpthdGshj822
8aL9r+P3JKo6enP2M0iITNX71JEw6W/s7btdKO9ur0lAmT7OQkZbr0cBbHFDkeek
Rx5fZYDM8M/Xf5t3/Yka+rQTJpmPSWwqljLYcqcQBChdPkG35VuWS/Df5PwTK5tu
9j+SWtpNRg1CPCNIvNiZzltE8Vdkp662vSrucQyzTp9UWws5DIgPI3qhPGTQlbjt
rZVi7cWLawCw2Tnl4WeXOlEPDS0s0sh+w9dmQhpgjeJWBGJYhTms06X7qX7lJ0fd
2ncmditmQrBk0JCu94YQFx7tjSxjUSXTXSPPw+HzZXDtPuHaRAp5+75jqeqg2wIg
zG6Tv3+QIpEONMXKZtdu72/o8cPJuXFnXNTWqMY2GITRFmBR+3zt+DnVgXXwvj7V
JHr0iYWp40CRIZTgq9lcNlQdMnqzjm1g8oV7g1RAXdhZHp3FU6RBpAoe0kUOmyFw
RAqb6V/lXF89WgzrZ0qlSG9s/8NkjmJaMj04wiU7YA3xLNCeBPw4rzR8hMNzteV0
VyK7BQeV8T39SBG+D1Muwyq4quFQO0QLHen6YmPSf3SMdEikNwl5JT2ZGziUGtKq
X/IOENvD1mK9kvYwQFnZ6YCdez2KwN45NDtWe+Tm6MFviXE0WNU=
=ovYf
-----END PGP SIGNATURE-----

--nnyddv2boxnoq3dq--
