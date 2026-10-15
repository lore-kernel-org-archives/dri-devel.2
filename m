Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96C7CCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318C4112411;
	Thu, 15 Oct 2026 18:39:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420C7112425
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:39:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2697F435DF;
 Thu, 15 Oct 2026 18:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E2C1F000C4;
 Thu, 15 Oct 2026 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792089575;
 bh=0TMliFj79vUjQOar0oTZ6/IIkqx7PD6OLi0ypU8KDYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Lv1sNf8ITEjifdupJdaiv+/BVBH+ewGV1epAFWwRyrK4PZTwoUHY068GnoDWI1i85
 z9pCjG/CfiX49ACr3D/CsYlqypdEoX4uLkwRRs0O7mfBRRpllt9IqtaifoTlYwl/vS
 Pov0k0t6qrQSCSbWXorqP6JpMLjmRVdGY3VUTIprFNPSHNSM418cn/vcne86Wdu0p0
 oRxzR9kiroesdPwdEVQ7b2fHkP3pwfWYt+TWBtQmCwlwKtGSrWBkzj75go/SrRq4Vh
 KTJzERCpm9GF4Jcv749kCdvUONd5ylmaeTAHbzaIlk+Hyfv+kAv5dya4PHAhXqkqSp
 H5Bj3VkPb1IJA==
Date: Thu, 15 Oct 2026 19:39:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 mfd@lists.linux.dev
Subject: Re: [PATCH 3/9] dt-bindings: regulator: add Qualcomm LCDB regulator
Message-ID: <d5a4c692-0995-43b8-bd47-323f9da5a654@sirena.org.uk>
References: <20261015-sm8150-display-card-v1-0-5c14928cef29@oss.qualcomm.com>
 <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CNEKc9Hb6b/6hsIC"
Content-Disposition: inline
In-Reply-To: <20261015-sm8150-display-card-v1-3-5c14928cef29@oss.qualcomm.com>
X-Cookie: Tax and title extra.
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


--CNEKc9Hb6b/6hsIC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 11:58:40AM +0300, Dmitry Baryshkov wrote:
> Several Qualcomm PMICs have an LCDB block providing the positive and
> negative bias rails for LCD panels. It is not supported by Linux, so
> boards using it either model the rails as dummy fixed regulators and
> depend on the state left by the bootloader.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--CNEKc9Hb6b/6hsIC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrRHd4ACgkQJNaLcl1U
h9DTtwf+MKwL6GiC/Pony46O5/oHLasnxzugndmBEekM6q+aYIODirqMzGKygiMT
BEPBGGLXlfumpW5Uy173xgd1zflK1NDJH/jomQGrWwOKquGw1qOXBC/BUb+9brM0
KsIObIy6tWNQ7grpC7cDv8Stre9fz1d+aga0tkjZvGLJpOcpFUC5LAsky6gjnLVK
xWMWOwaDJ7USQ/zRQyqLhvaK6m+daft37p58rrGOFgPAmfv59fliaSE+kaLhknbW
M+oTbkLhV4nhAZRkDv4OVpU9p9TgrVk5XL6/j8OIfbZxFFijc+OIyTCvRhX4Lgjq
H4AgVXQNsXhvFdiSXD2uesqffgHUkw==
=BJGF
-----END PGP SIGNATURE-----

--CNEKc9Hb6b/6hsIC--
