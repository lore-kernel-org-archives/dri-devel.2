Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E44C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2CDA10E144;
	Tue,  8 Sep 2026 17:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TO4wloGH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672FB10E144
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 17:55:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 617A5601DE;
 Tue,  8 Sep 2026 17:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ED41F00A3D;
 Tue,  8 Sep 2026 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788890118;
 bh=765idAEKKbWPuz2USlH1VcNBUvTkzIPKO0MxgkuZDTo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TO4wloGHlbkHv52gHzObnN3VVqxM1a4e/M9o8fBTYihhow1bP9RJBw6jNnSBye4Ao
 ntvkKCjI/vSDGmv+LIgaRXNIvv9lV7tKRSvyLYrKXZ3kzqGMhlPTFk2270uQ9tENoB
 PWeZYkti1K+BEFDbSgGn0TrR4wUYfkknljXNTAtaFI1wjBFUa8OjOsHZ3+KTn9RSzp
 +qCJPDcFTFah7hzjPiNXtM9aE/MORRz3hNqkBV+y0yT3Ditbou1V3KQJQE7h1Py6/A
 gp/ouwO7LrmSgaxukWNxvEzu3I7rPQcOJSL3sciNtmX/oljsFGgv1izTei8qY6pC2q
 TYl6leeLghpDQ==
Date: Tue, 8 Sep 2026 18:55:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Joey Lu <a0987203069@gmail.com>
Cc: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 yclu4@nuvoton.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: display: verisilicon, dc: add support
 for nuvoton,ma35d1-dcu
Message-ID: <20260908-elevating-eggnog-0d11f728f6f2@spud>
References: <20260908092840.225220-1-a0987203069@gmail.com>
 <20260908092840.225220-2-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bxAegO/MuCyNqq2e"
Content-Disposition: inline
In-Reply-To: <20260908092840.225220-2-a0987203069@gmail.com>
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

--bxAegO/MuCyNqq2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--bxAegO/MuCyNqq2e
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqBMAAAKCRB4tDGHoIJi
0iZXAQCE8i0GV0vfMMOm3ja2XjSEnbf+JCqzgRyl/u9zngsMNgD/ZXAx3nxTMtoJ
P39HX+WyJk4Tjo3v5hxRuaPy++cdwwo=
=6YLb
-----END PGP SIGNATURE-----

--bxAegO/MuCyNqq2e--
