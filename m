Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BAFCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 16:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB25112233;
	Fri, 29 May 2026 16:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H41QF7v6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5996C112233
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 16:32:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0D9B44733;
 Fri, 29 May 2026 16:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74091F00898;
 Fri, 29 May 2026 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780072367;
 bh=F0eusMqTsmVOySOOobpQHl8ClXyjcHV6wDgvEo4tVP0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H41QF7v67iTCAiuXHcqn2XTdr9avXqAl9Mi9uTEu6Dk1ChLhE0j1om9ktPB+LcGhQ
 zuKlkQzAxqhvcEc+Jrx+ai96WSs+vEV5cvn/2RCUuCXe/0TIDhR1g3dqc4ieb7ZhYB
 G4d757/ynDcJ867kTe4Gvwxljg7uQLEVEaoSzSoEpGhmz1W/320NANEmMh9o76jxiG
 gNUCovOZ4YCXzu26SKQgyUViCRHJ+saf1i2haabXh26Kwvtaqfi3wUUHBwkpUB8bvR
 0wLOtbalODIblzuAcD5HMvIyeHB72oRpc0+yKzhO3imKcbuM0mbvKW2fvf3YxW+qEL
 lPteVGO1x7IJw==
Date: Fri, 29 May 2026 17:32:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Add LG LP156WF1
Message-ID: <20260529-neglector-reptile-871529be473a@spud>
References: <20260529110518.624454-4-ivitro@gmail.com>
 <20260529110518.624454-5-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BARr7Ixa8gc2gzG/"
Content-Disposition: inline
In-Reply-To: <20260529110518.624454-5-ivitro@gmail.com>
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


--BARr7Ixa8gc2gzG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BARr7Ixa8gc2gzG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahm/qQAKCRB4tDGHoIJi
0tEtAQCdpXdaqBga6bfZCGQnQyl0kTI3NOSMeLXMs7pVoCNX2gD/cgIDJGUaHRsW
UfyqdBUswIjy4EqTy99yPm2J14WiHQA=
=D/7C
-----END PGP SIGNATURE-----

--BARr7Ixa8gc2gzG/--
