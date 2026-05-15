Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA460CD4F47
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 17:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F25E710E436;
	Fri, 15 May 2026 17:09:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="krsDujO8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123F110E436
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 17:09:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 62601601DB;
 Fri, 15 May 2026 17:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA5AC2BCC9;
 Fri, 15 May 2026 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778864970;
 bh=Fns2SznFonb9Py9VHtydcTlcgDaFN6CJlbd+c05s+Js=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=krsDujO8Cnm3POqIIFYZZOf+wAOfWFjEJUE9aHMOKlIqdnMQhTMOnlYxnmErtkXu9
 BUS9COf8+C1znAGfMBcVLAu6dbt8dwEaEcPs/OXje8cz0V4anDFiCuI6cv8RTEJBnK
 pQaRNltZl6SCC35ReWYwhxip+0zzrqtQAuG6JqoZ6emLRvTwOXzxUNS5HPX8etjHvg
 2A2OWySfprW8i0kaZK0Mk4y82MgsTNHD1whVI9RwL7Cqilm8mMMNReOxFVb7YDUsGe
 lWHMnK1aorTGpQ6j/nji0hWx5rPjRnWQ090c+FCOcgZ3HPtUl4ReIPiWH+e5U+GgGI
 QD727DpXBLCYg==
Date: Fri, 15 May 2026 18:09:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: simple: Add NEC
 NL6448BC33-70C panel
Message-ID: <20260515-expel-line-8637d4c6e0ab@spud>
References: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-0-74ab0baa1817@pengutronix.de>
 <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-1-74ab0baa1817@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7KlJ2YL6hZLhvSsg"
Content-Disposition: inline
In-Reply-To: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-1-74ab0baa1817@pengutronix.de>
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


--7KlJ2YL6hZLhvSsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--7KlJ2YL6hZLhvSsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagdTRAAKCRB4tDGHoIJi
0to6AP9+Wy0qXnDSTRPh3EgoPplQWIatAULqXwzMRRxKIRGY9QEAnTH5baXYcVtq
wm4M57V1n8hvEwdn7ZPoADqm3UmomA8=
=xOcb
-----END PGP SIGNATURE-----

--7KlJ2YL6hZLhvSsg--
