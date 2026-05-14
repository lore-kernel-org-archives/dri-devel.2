Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0BFCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 18:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4178D10E0D2;
	Thu, 14 May 2026 18:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I0zWQzmy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6197410E0D2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 18:05:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A2B4460008;
 Thu, 14 May 2026 18:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C68BC2BCB3;
 Thu, 14 May 2026 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778781951;
 bh=6KWlQ8RIVzRCQ77UWcLUxEvtH+ekjdcFQYoM+Oiqfa8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I0zWQzmyww/yiGrsxZC2vAtafAXGKaxJMlqlUTwCconlOcy2zmWCAa17AfoP1Qmy1
 ESfFr9wN9rihRwdzswHzdLT+4DEbDufvpJE3v8AunpRJnSYlFO1xU007JjVhVlx0Zq
 xt9ep1xtBsIyqprGM/UFGrc3ZNnQIAo9+/76yvvq6A2af/IYXZvAzmsDjTTJbKNLZr
 s0GGIaAOO4mV9QYVduz2u0xOX4gpqJ+cfd7rDzhZntnF+74PozkvXjhnDeVC6k0QCp
 fumIBDnDIcdePLc74WY/K0jUZaU34AIOslVmxEWrLotDiTcuA6YFFB42CCNvFV34cC
 zkF9nhen+oGmQ==
Date: Thu, 14 May 2026 19:05:46 +0100
From: Conor Dooley <conor@kernel.org>
To: webgeek1234@gmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Teguh Sobirin <teguh@sobir.in>
Subject: Re: [PATCH v2 2/2] drm/panel: Add panel driver for Chipone ICNA35XX
 based panels
Message-ID: <20260514-sphere-overstep-e564bf7ca609@spud>
References: <20260514-icna35xx-v2-0-45acd1dfa566@gmail.com>
 <20260514-icna35xx-v2-2-45acd1dfa566@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8ucwXBV2pTA92cg3"
Content-Disposition: inline
In-Reply-To: <20260514-icna35xx-v2-2-45acd1dfa566@gmail.com>
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


--8ucwXBV2pTA92cg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2026 at 12:24:50PM -0500, Aaron Kling via B4 Relay wrote:

> +static const struct of_device_id icna35xx_of_match[] = {
> +	{ .compatible = "ayaneo,pocketds-panel-top", .data = &odin2portal_desc },
> +	{ .compatible = "ayntec,odin2portal-panel", .data = &odin2portal_desc },
> +	{ .compatible = "ayntec,odin3-panel", .data = &thor_top_desc },
> +	{ .compatible = "ayntec,thor-panel-top", .data = &thor_top_desc },

This looks like you could be using the fallback compatibles instead of
matching on the panel's. Why aren't you?

> +	{ /* sentinel */ }

--8ucwXBV2pTA92cg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagYO+gAKCRB4tDGHoIJi
0nw+AP41Ku2HWXkra/HXNztY5J9SEr7akWQjJG1cuFKy3o8E2QD/bRXSbw6R7pj0
YNGiZAxKrIe7OiPPDd5I8iHoFIRrVQc=
=7jGk
-----END PGP SIGNATURE-----

--8ucwXBV2pTA92cg3--
