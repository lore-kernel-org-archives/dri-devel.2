Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163CFCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 17:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6977710E21F;
	Fri, 15 May 2026 17:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="baUGqypx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1417B10E21F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:34:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A02060098;
 Fri, 15 May 2026 17:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01748C2BCB0;
 Fri, 15 May 2026 17:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778866485;
 bh=JMqgLzDQU+x0NBNFa/inAWoR0D9HxySnqFiIAcoUyNw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=baUGqypxT5nWVLA5b0Yez0dcglKt8BUUuWimPI7/7LNcB8KXVvuAN8cFmSAypuZe0
 HLfrtNmsYaf2CryyT6vlH3pUXdxVcAvGKCzMkz7u4RM2QmwSuIOH6Y8OPLyYzQw2KJ
 9bZA9UyCHyvciCSa8HDVOmFn68YgfzBqTZkOy1pWPocYDBwNIYNOhQLQ4vSpsQ64rl
 LGkYnfoRdyA3qP96cdKr/b1IqKI3wyCzI1aptMbwW1uND3zWjdEaVzsZ5KYHoHHxlF
 ytrxU0vFEQWcIHgtoSZDJs8o2tp/Qvr3XlUCrKDzVoRM1CkUnE82UzkQNKk+JQt+nC
 LgnoaxmUc+GiA==
Date: Fri, 15 May 2026 18:34:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 Simona Vetter <simona@ffwll.ch>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add
 AM-1280800W8TZQW-T00H
Message-ID: <20260515-shorter-crate-c51d3ff6a200@spud>
References: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VbcJbj4m7Q2qtc5C"
Content-Disposition: inline
In-Reply-To: <20260515082232.1766586-1-dario.binacchi@amarulasolutions.com>
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


--VbcJbj4m7Q2qtc5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--VbcJbj4m7Q2qtc5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagdZLwAKCRB4tDGHoIJi
0sCYAP9GiMhwu5r/Vum/TUTQppvWaxo0e6a4c7nlkCNP+tnW6wEA5+LnzGTTPE/g
j6/Nryxy2t2IwctCpCedVg1fjsOw4Qw=
=fwIs
-----END PGP SIGNATURE-----

--VbcJbj4m7Q2qtc5C--
