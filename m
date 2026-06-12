Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AA6CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD1C010EA92;
	Fri, 12 Jun 2026 16:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NV7E1ihB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C6A10EA92
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 16:17:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73F71600C3;
 Fri, 12 Jun 2026 16:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D731F000E9;
 Fri, 12 Jun 2026 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781281047;
 bh=OWWbZyIFi19j+EWcZCzS4VusckZ01Z7f+4v5sT4JcJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NV7E1ihBEgQoUF0VMyMDi2wAShusL7TC1KCRP0r4jcUX/F5/9WSt/uiaeRDSeVvDB
 dvY2nOIbWPeWDgTZ+HWN7uhWEYopFVZzguW3Xr0HXNryg1o/vNl8nxqhajKVLau+B4
 UT1WrNW4G7e5XvJYBkBlja85oHNAgeHLaU2JIkVF46RGcd/cdiooi6kHWzgIt9rR99
 FsH8dHAfa5oOItPyCNUqroBEla3CtNYmClXujG+vZnwFUkrEp7ZVC6PXVP3eSbcnkv
 IFFnapDmXg3gw059fJB0xiM+anU4vfkZJwz02NNlbUBjOCbL1biKelP0vC7gZQHqhl
 jJ6nKdvnsikZw==
Date: Fri, 12 Jun 2026 17:17:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] dt-bindings: display: tegra: Add Tegra264 compatible
 for VIC
Message-ID: <20260612-ascend-bonsai-d330bcda91b7@spud>
References: <20260612-t264-host1x-v1-0-8d934987de67@nvidia.com>
 <20260612-t264-host1x-v1-2-8d934987de67@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o0OMdNtSGtGTVJju"
Content-Disposition: inline
In-Reply-To: <20260612-t264-host1x-v1-2-8d934987de67@nvidia.com>
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


--o0OMdNtSGtGTVJju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--o0OMdNtSGtGTVJju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiwxEgAKCRB4tDGHoIJi
0v83APwMmQtkExjlV1rXRIJAdC8veFtoH4XlazZaj20VnWSx1AEA1HO1dn5W3+Fn
I6+TW43YwKhtZHoR7HaENzMU53R8OQw=
=r/jw
-----END PGP SIGNATURE-----

--o0OMdNtSGtGTVJju--
