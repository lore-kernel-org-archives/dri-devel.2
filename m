Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21947606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXWG0hcP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE9910E112;
	Wed, 18 Nov 2026 17:44:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB37910E112
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:44:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 824196121B;
 Wed, 18 Nov 2026 17:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C71F000C5;
 Wed, 18 Nov 2026 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795023842;
 bh=9utLSuKm5nNEmffDdFwJgwnJ/+R0ezxr8iyL18d71Jc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HXWG0hcPbMCxJ915vxAGOhqL2u4fKPK5bk49qM9mmFFFJ9oaLNBxCfE3jzR4Ot0KT
 db2uL73mpuVonGev8OB3ODmhd5ZktIjN7m97qUg9ZyY1iVtNVu1iE/CCuCsvwLbTf/
 TITCl9FpL1bKeg5sFm5s3TRXijv7g34+oKjPrM1k0HPcltLpFBuyB/ewxkfSZhvtOn
 lJcGDnnzS9lXKT4Fz2EkzwAF4kihqvwbh0hHr7yQD8txVbaZq9W3PEC5q+wk7q2Pzs
 +eDipNWIcpdVObj8gfv4hONjP8ywz+SkKyKGj0v5mxZgs9AQsmUQNmkOvF1NxR0021
 Dh75l5rv+lUWQ==
Date: Wed, 18 Nov 2026 17:43:58 +0000
From: Conor Dooley <conor@kernel.org>
To: pjh456 <pengjunhao409@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: ilitek, ili9881c: add
 Industio Purple Pi OH panel
Message-ID: <20261118-flattop-crane-25acbbab9b14@spud>
References: <20261118095905.127658-1-pengjunhao409@gmail.com>
 <20261118095905.127658-3-pengjunhao409@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n8iH9ulcLLghpic8"
Content-Disposition: inline
In-Reply-To: <20261118095905.127658-3-pengjunhao409@gmail.com>
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

--n8iH9ulcLLghpic8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--n8iH9ulcLLghpic8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3j3gAKCRB4tDGHoIJi
0h82AP92QBXpHuHXrUwCudydjX/rSTGytlz3ETzAnAKFg2JwhgD/XThP0378nO3w
A9g/IWa9DrgZoYd7F3hqhoiD55x8AAs=
=T7oF
-----END PGP SIGNATURE-----

--n8iH9ulcLLghpic8--
