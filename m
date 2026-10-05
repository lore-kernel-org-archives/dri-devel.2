Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F82CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207A210E18F;
	Mon,  5 Oct 2026 10:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZaeausFF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C6610E18F
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 10:54:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A02AF6022E;
 Mon,  5 Oct 2026 10:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCE51F000FF;
 Mon,  5 Oct 2026 10:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791197691;
 bh=4aOphlxRPVBxuWoEocxLm5Po9OeaVNbNJM8xAl/MU5I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZaeausFFJYnLsWIPauJzCjGNEytEx2XpHyKTPBa+6hq1wC5ouXkOvcOq0qKPvtpsC
 QKw1NrbPto94WEc3DypNPEZDz2NPGyQkfAwxyIqnhZ6/ul+8si2C9W+U3ImMuxZwI0
 tWtkivT/kY+1fEYuHawJ4JqoQDvMW0bZgtj8wNanLhb0YqnzeSb6HejFkcMlHbZaRA
 DpcOawhFZfu1O26eGAKZmlzkGKd/+pEs0gKQ76aO/c10vf+Z6Hb7vI05D5+7tiL5m2
 nyYA/ysEShT3est/VhxLpoG+3QDldT+Jfo0Q63pAZaRjsOCZD7AUF5amKiYJXzABfN
 7Largm3793xkw==
Date: Mon, 5 Oct 2026 11:54:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: himax, hx83112a: Tighten
 compatible matching
Message-ID: <asOB9azB6OCN5fYH@squawk>
References: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
 <20261002-hx83112-compatible-contains-v1-1-d558635ab7fc@fairphone.com>
 <9be89803-974c-4746-8af0-a13e5a19fb33@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RIqa/r0/keXy6YTE"
Content-Disposition: inline
In-Reply-To: <9be89803-974c-4746-8af0-a13e5a19fb33@linaro.org>
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

--RIqa/r0/keXy6YTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--RIqa/r0/keXy6YTE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasOB9QAKCRB4tDGHoIJi
0ioTAQCm9zEIddkeZKgrUFGRAvTEXyK9EGR5tMTlusa2quGuuAD7BHGyTr47xeBU
y2PDNwtEgnc2DyFZx2ys0wU/gewdpAY=
=pQsR
-----END PGP SIGNATURE-----

--RIqa/r0/keXy6YTE--
