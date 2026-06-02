Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9C8CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A9110F318;
	Tue,  2 Jun 2026 17:01:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bky1Jb/N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DF9210F307
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:01:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B6D2660098;
 Tue,  2 Jun 2026 17:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3568C1F00893;
 Tue,  2 Jun 2026 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780419712;
 bh=DFC1w7p/0qB073AfNGNffsBQG0WW8QDMDzU+cxdEF3I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bky1Jb/NZnBNnpwQWDthgWcFz+0+/2sBzSQPyI4DBzbC+DqHPsQmwq0TIDeA3S8YQ
 4GztI70qPsv4c3cr5aC9lAbt9fvpuEXpELLyzEc17RtM1X4AQ0n58ujkkJRUENg1D5
 9wu/KclcM6CCvBteSIE0h4HHUOHL1NChBZsVLDtJAAEphTkxQcHBiivFS9f+9tFvrA
 ZIQjPG/h0IYzH10Q7LnC4m1+j3RhmjVqGPcAAW0deWQCP/Iw6YnShJVWe9nxvH0c3G
 3UeILGuiQ3G2yL7WwjrlStDjgys4kA/sU0Lrn3ALZ2c9yROXndGMFuL0RZ3LcyzYla
 dVsXrxwU/V46A==
Date: Tue, 2 Jun 2026 18:01:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 01/11] dt-bindings: display: rockchip: analogix-dp:
 Fix hclk as third clock for RK3588
Message-ID: <20260602-cranial-aerobics-9db5af2159ec@spud>
References: <20260601065100.1103873-1-damon.ding@rock-chips.com>
 <20260601065100.1103873-2-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tXJ/OuPN5ucFNEVK"
Content-Disposition: inline
In-Reply-To: <20260601065100.1103873-2-damon.ding@rock-chips.com>
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


--tXJ/OuPN5ucFNEVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--tXJ/OuPN5ucFNEVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8MeQAKCRB4tDGHoIJi
0qXGAQD9vbj7tixbtiXhoJz2EzXrSh78kjxJNRDo8PGjKDfIbgEA2afp9CeVcHz9
lbuu8IN7ZAF7QMTIEkFKWyqOc2Z6rgQ=
=7N8P
-----END PGP SIGNATURE-----

--tXJ/OuPN5ucFNEVK--
