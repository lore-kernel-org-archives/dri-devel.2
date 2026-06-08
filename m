Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21F3CD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307A410F7A1;
	Mon,  8 Jun 2026 17:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I9j4SDSD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF59010F7A5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 17:11:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA9A041ACA;
 Mon,  8 Jun 2026 17:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD91F00893;
 Mon,  8 Jun 2026 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780938678;
 bh=uHkwhHssG6Ajbq+kxDL/0e8WB7yH/kcwATkmbA1AP3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=I9j4SDSDT9ki9u+z7cSyvi9t9iQL/2ZYIZOmJOK8cjgmPDqdNZaCe++QkjvmjjeKS
 0vuXC37r4OurgF+e+cFDban3ikva6YU9DnO+WTlMAy9/y8O4X63E6sWjuOUXruzm3o
 UGP9Dee6imuHGn5VujBSIB22wLnkHh5rU/Sp1ksu8Op/zmn9tdjSiJi0n/mW9z4hDJ
 o4UVF2zaok5sbLNd1S7cDPIP1tat//LWUB80NasQqFvDhBWYMMXr53uLeVcw5JIVa7
 wWxmCfMeu/nf03Xi1BBE/z+PINBgmD8m5xioZ2iSPLPujG8cKM6uCWhOftMEjLYFLM
 bmlyRfCwVINmQ==
Date: Mon, 8 Jun 2026 18:11:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pengyu Luo <mitltlatltl@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: display: panel: himax,hx83121a: add
 optional bl supply
Message-ID: <20260608-tilt-probably-5bd81e84098f@spud>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eoSr/GZJJ3GY74cM"
Content-Disposition: inline
In-Reply-To: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
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


--eoSr/GZJJ3GY74cM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--eoSr/GZJJ3GY74cM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib3sQAKCRB4tDGHoIJi
0j0rAQCvfWv/nj6nvGJdFYHllgXfokFFKjL+XSfhDQO9JKqbBgEAw/0tXEtdVAIU
pbAwVaqJyMR8xgIRaZ5DpD+VZ/dvVwA=
=/RX/
-----END PGP SIGNATURE-----

--eoSr/GZJJ3GY74cM--
