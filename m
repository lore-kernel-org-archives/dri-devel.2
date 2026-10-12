Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E49CC6B01
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7C910E646;
	Mon, 12 Oct 2026 18:55:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33AF10E646
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:55:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC9DA40C02;
 Mon, 12 Oct 2026 18:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E7C1F008A1;
 Mon, 12 Oct 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791831302;
 bh=lsoi2vg2LB1YdOz216qy3fyKHo1xGtnZSa2C1EmzQQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=N3ZZ6lS7EyvdRhDCSwPisPwBsfZDf2U/cgYy+PvafbsVnw+LlKjg0ZUagkVZwZD8x
 tI9jNpHjsNM78BddwlUemK9w35pF5YQa2i7hTRy1ifBOgubuR0aGVvZ1TosSpnTXyK
 39GAMsCQZnmBA1siaIrn9LTc+9nk+Pg/I4xieWN1PL0AGWNp0MI613afthXKXiTuq7
 5B7Pjyy00/y0beE/3uIzUxHZdTYn7nf9L+OxxVg9emSgGzUZkYiKdH02aNYixp5gw0
 bceU4cUVi6vW6jm4PWx1y67uj83qgIw4/x4dRSYlk6OevQ2E352Cz/buYJHTwBfNIv
 fFH3BbjZ+LYNQ==
Date: Mon, 12 Oct 2026 19:54:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: "heiko@sntech.de" <heiko@sntech.de>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jesszhan0024@gmail.com" <jesszhan0024@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "noralf@tronnes.org" <noralf@tronnes.org>,
 "robh@kernel.org" <robh@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel-mipi-dbi-spi: Add
 UNIHIKER M10 display
Message-ID: <20261012-brunch-mocker-348f76eb943b@spud>
References: <20261012121718.53481-1-founder@crepuse.com>
 <20261012121718.53481-2-founder@crepuse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l0Q0H+qNTOU6/PQ9"
Content-Disposition: inline
In-Reply-To: <20261012121718.53481-2-founder@crepuse.com>
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

--l0Q0H+qNTOU6/PQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--l0Q0H+qNTOU6/PQ9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas0tAQAKCRB4tDGHoIJi
0kRKAPwKrVSpWbI+CrbQHAuW1z8jJHJOJ2kY7Fd65yZXVaWM/gD+MGhjR/tpHAvV
hoMubh6PI1wdQ4Mso389MlLQbINTdAc=
=CDyY
-----END PGP SIGNATURE-----

--l0Q0H+qNTOU6/PQ9--
