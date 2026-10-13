Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01351CC6B16
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E0B10EC03;
	Tue, 13 Oct 2026 15:37:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0A010EC03;
 Tue, 13 Oct 2026 15:37:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77BD6602C3;
 Tue, 13 Oct 2026 15:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA71F000FF;
 Tue, 13 Oct 2026 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791905863;
 bh=g0v0j3GPIoV5WBVJgFz4OFgpQ37qSKo1OS4tG1mcDzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ibMAGARpuyRzxeZsfJ1ZxatPqrJ3ScinioYonSVO9G5Y+ttiP1lSQUS8Coty6Tyd5
 eJp5DjdFsuoH1CXveQT4IrIh0t7I5bl/cPngZlGH/t54AIs+g2l1WwHG4ogDOACwL9
 qFRoS6CizbEWrMgHp6cTJxLN2dEjLFdT9WlSKO6ma8ihv7gQX4t2TfvG88A5PXX5u7
 UqozSzgAu1Svpn0Eo3v2QDv3uia6CvR2umW5sl7jnJIm3ufv4F1U+2IBc5NcIjkBXR
 weGjUF++il9ye/LPhsfISms3ysDQkvRqh7c48xaTMjImIZ9z/PXo/WL2dVOkPrQjar
 7EUE45XGUsP/Q==
Date: Tue, 13 Oct 2026 17:37:40 +0200
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
Subject: Re: [PATCH 2/3] arm64: tegra: Add the fuse clock to the Tegra210 GPU
Message-ID: <as5QBASu4BxhZfdK@orome>
References: <20261013145210.103565-1-sashal@kernel.org>
 <20261013145210.103565-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rpi2rmgxu3mrx2a6"
Content-Disposition: inline
In-Reply-To: <20261013145210.103565-2-sashal@kernel.org>
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


--rpi2rmgxu3mrx2a6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] arm64: tegra: Add the fuse clock to the Tegra210 GPU
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 10:52:09AM -0400, Sasha Levin wrote:
> The GM20B GPU on Tegra210 needs the fuse clock running while it is
> powered. Describe it so that the GPU driver can keep it enabled.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

We already have that FUSE clock in Tegra194, but since this is now
needed on older models as well, I think we need to add this as far back
as Tegra124, since it likely has the exact same requirements.

Thierry

--rpi2rmgxu3mrx2a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrOUEQACgkQ3SOs138+
s6FLiQ//UlzHqdcmdtoM754i3mPSyncNcmwBSxfIHSasCUhBfrQLOYpvkc/c9CWX
RkWIx6MjZCZ2ryapXPPcMUQbt0C2fp8y+CClREKndIsiUadLSxSctfW/oDlmp8Iq
mozxwUjxr8LIHbRfhrgrL+MFQ7BPr2CQkj3hAJR6SsW6G4GycHp31Ctxsyl6BeRb
lUKjXI7zM/mvJJ/GLiMvWWct2195NueigYugWT+U4/co7CuekhyxltODj3zQ3DnC
UaFmi48VYOSTdXvcJH1AeSG4d56JUK22NkUmI06/d8N78B7bdAF/xJcW9Lb0G69k
536QVNX+vb4M36sxRKU1A36/Z1aIdDz0uvtTuU/AxqOzp95fPw7SHC2VaoHhGD/S
OaxXKVxvAwFH0kZ5E/6hZ9H8SPfVTxeBmlF5xivct+X1xm+3Mt0c0NYGYOpEiEv4
v20HR+wxs3JFpSIRhg3HoUgPkeJ8F42XTcrmYxUNee7gfYpjoMn6b2mLNtbPf93R
NifsPLgSAfwigv8UgGQGVWbEbwKr7D8vmG7tNWiGxlz1VGhEMQxOYEB4W1ORyaEI
Sn/nyHHRWVoMCLVVLADlOYHBy+1RLu3lye517qiozoDiF5cMUSSQrk0cTEXDG8nV
rHKdk2aVlW757CtgPzhTGuDoWr38eAix5qFBOpK8NKpR7XTtz5A=
=mQbV
-----END PGP SIGNATURE-----

--rpi2rmgxu3mrx2a6--
