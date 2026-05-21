Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BE4CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 19:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA5A10E57E;
	Thu, 21 May 2026 19:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PdI6OOrp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9928410E57E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 19:55:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC9B160098;
 Thu, 21 May 2026 19:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDBC1F000E9;
 Thu, 21 May 2026 19:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779393339;
 bh=meelOKHExJiwf8dynD+pHxph07bjWntIQSl7UMpCqm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=PdI6OOrpIL4LgeV5Vo4QOWYf/HBJKgrjF81ZhU+jZby9j7ApcGEerRAgG/SuiYW69
 RnojvW0ZWjQx27UD7I3EDER8WPvzaqDZgQIdJWMgYW135hQcGeb5awNXe5MizYILY0
 VL6Z6B+3zy1DvKAOV6cuwFrwIuq12Tu/cmy9FHn7qjjR09MHHrtvbFylMdRmzPhC2U
 i66GkzIa75R0Y17c0nAQ2Zm1FjsVzoA0VeWX2htLE9xYmmPnVBdq43sKtr9zQnJ0vv
 VZVW6OE8qHpG4Gzc61uXOC2IEeFbZzMeNI9PsUDXQ3qUdBBXtBf2BDK/Uqz79IphnN
 acOM/lcssn/Hw==
Date: Thu, 21 May 2026 20:55:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
Message-ID: <20260521-pants-discourse-463c9b3d9491@spud>
References: <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-0-dd5700299390@linaro.org>
 <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-1-dd5700299390@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e2cD1x5BYJY6k8mo"
Content-Disposition: inline
In-Reply-To: <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-1-dd5700299390@linaro.org>
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


--e2cD1x5BYJY6k8mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--e2cD1x5BYJY6k8mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag9jNgAKCRB4tDGHoIJi
0kOTAP9uDgLuQHo/c1M+3xHNQXDDibJiTEVAoM6FFPBUM+RAFAD+IHlM0//Pnhkf
WTeXPlHUfSPbptIRpicFxSEkiYH/4A4=
=szSe
-----END PGP SIGNATURE-----

--e2cD1x5BYJY6k8mo--
