Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66ECCCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 18:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DECAC10E103;
	Sun, 18 Oct 2026 18:53:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6ABB10E103
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 18:53:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EAB060D9D;
 Sun, 18 Oct 2026 18:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00AB1F000C4;
 Sun, 18 Oct 2026 18:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792349620;
 bh=Csfu+p7DecNNEaF3nmVC8sIFseRFu0794bq3QCYty+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jjA4CUndG4pAHeZbrm1BxDlNpX+HwJnx5LMzyQhuRncmok2Is9Ye8llG9g5VDAMjg
 x0jPf3L6EIV5jtbCf0rrWHecI+WUgQ2BYjvJ7U79qlJ2tlyaEvMDG2WkxVZMG9nzKN
 g9xNf6xCxfV0Wbo+ntKJTxxnYs57ATObOtUGAj08h4M8VKPpDHSsEDMTD44dFVas0W
 RQ9L3b8Nrml2q2PgegnN1dqxu0GPb8trAEyETF8LmgJnn4CH9oB8DjF+GGT7FpsTwi
 8ThRNHtvUjIjNA9yU4XuEbZK7tzUhg6jDqQRrBnfrG1PsgMKQNhzILU/VJ4yMs+ZlL
 QJewmA3n03Pmg==
Date: Sun, 18 Oct 2026 19:53:35 +0100
From: Conor Dooley <conor@kernel.org>
To: tianshi12127 <tianshi12127@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, devicetree@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: panel: add Smartisan TD4362
Message-ID: <20261018-snorkel-mollusk-0bfba29ae1f8@spud>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
 <20261017103250.800109-3-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lC/VVTF4dvcK+DOZ"
Content-Disposition: inline
In-Reply-To: <20261017103250.800109-3-tianshi12127@gmail.com>
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

--lC/VVTF4dvcK+DOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--lC/VVTF4dvcK+DOZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUVrwAKCRB4tDGHoIJi
0qsmAQDCxEOSqGcSTiPp8dYp93pj9cpI6gg97r3RkkHx9lbjaQEAu81O/c5LeMu5
GPjVL9aFsE6ayuPTU9LuBlQWBOl8RQY=
=NMlV
-----END PGP SIGNATURE-----

--lC/VVTF4dvcK+DOZ--
