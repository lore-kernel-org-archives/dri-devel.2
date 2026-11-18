Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5371606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdmrteqV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E92C10EC5A;
	Wed, 18 Nov 2026 17:45:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E877710EC5A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:45:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83EA64137F;
 Wed, 18 Nov 2026 17:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF211F000C7;
 Wed, 18 Nov 2026 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795023906;
 bh=kPCVIcjd4Uy7hIV1STW08UlAxkE5AsEfZ+SdjyRSVYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SdmrteqVRHStlVhHY6JBf0P53+tuU9Ine1H3m/ep2pR2HjMvqIEytsXQKJ6S21QHf
 Zp/hZvJTKkFQkd/5PMSa/pVIAtTHtd616ZnaGkGIpoALs8dyEilXSTU/KM+TVt1vxC
 3dIgJrCl1woG0sLwRWT2lt6vss0V6g0gCh7TRSvfxEb3lxCbEOEWbnO8yJZScOAkD6
 7Je123ekLArjXvJF1zIlxO58+dpu5JIbKqPhnAj7qOuWKrnHJ0fJ/+4vx8iVexm9fU
 RLVWipOXROn6Hob05pxv9UhlULeIjvw83+QENgNbXAJbFKfRxUoNMiBKiwBBLoO9Pi
 yBqHrlCBe5Ndw==
Date: Wed, 18 Nov 2026 17:45:02 +0000
From: Conor Dooley <conor@kernel.org>
To: pjh456 <pengjunhao409@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: ilitek, ili9881c: add
 Industio Purple Pi OH panel
Message-ID: <20261118-geometric-disparate-d4b80fd12e53@spud>
References: <20261118095905.127658-1-pengjunhao409@gmail.com>
 <20261118095905.127658-3-pengjunhao409@gmail.com>
 <20261118-flattop-crane-25acbbab9b14@spud>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S7UK7GB73bf7skYy"
Content-Disposition: inline
In-Reply-To: <20261118-flattop-crane-25acbbab9b14@spud>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--S7UK7GB73bf7skYy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 18, 2026 at 05:43:58PM +0000, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Oh wait, I just realised this was the thread from earlier... Please
don't add this ack and I will review v4 when you send it tomorrow!


--S7UK7GB73bf7skYy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3kHgAKCRB4tDGHoIJi
0pw+AQCwK8H4zV7rZ5VUZvBMP6fwhRoF2DW/jcmspZPvpDfCFgD/YQ9/jvOGNnpu
+9OHZ2HqC1wICxTf0yFmIRwqeswLpAU=
=7273
-----END PGP SIGNATURE-----

--S7UK7GB73bf7skYy--
