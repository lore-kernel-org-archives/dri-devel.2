Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B712CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:53:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A74D10E1C4;
	Tue, 26 May 2026 16:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SyTF3Kf2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2726610E1C4
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:53:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E32D840D5B;
 Tue, 26 May 2026 16:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571DF1F000E9;
 Tue, 26 May 2026 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779814389;
 bh=OpVBqdItn10WijuV1NiWbwskiquoRFfvBAzrrmnP84A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SyTF3Kf2GRv2/2mEejhM8TAd5xPzYuw8ThxF35jLbwvasecCcU/6k1i56GX8e9wX7
 BSi/aQLRPNl3XIx5ZuIKoSW0BHO/BowRuqywg0Zu6O5G5Xc7Xkoz3sVFvC6bZ4GYx5
 0kn9ETubXF2HYZ2yF/Mu3jX8unVvAsftb2yrYdZz/GSmKkqjKGVEKSOq6SvDbRVvCS
 fGQZOqhKvvu+NVhQGgD8HrwzFd7tsfqI2q6Z5Awi7aHFDwIxSAEmams81MdlqhOlUv
 GmAs+PhNOFKZvnz9fiLu8BRiICyKbFhSKEt6lDSr2IoBzF7Jwt1EaOtRb1NmKTwn6c
 Zj5QKgC/hqnWQ==
Date: Tue, 26 May 2026 17:53:05 +0100
From: Conor Dooley <conor@kernel.org>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: mayqueen,pixpaper: add
 pixpaper-426m
Message-ID: <20260526-scrounger-motivate-7079f771f4b4@spud>
References: <20260526-bar-v2-0-c66df9a840c4@gmail.com>
 <20260526-bar-v2-1-c66df9a840c4@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="55YTm001h8+bCEZx"
Content-Disposition: inline
In-Reply-To: <20260526-bar-v2-1-c66df9a840c4@gmail.com>
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


--55YTm001h8+bCEZx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--55YTm001h8+bCEZx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCahXP8QAKCRB4tDGHoIJi
0o8lAP9bdUMQ0S3B1H+ktOtjKETQ0aAt6JZAW9EZpVSp/g75fAD/Sr9X/I25LRo5
wx9QtSBc9htIlsjGraSsXz4rQFUwTQo=
=IBND
-----END PGP SIGNATURE-----

--55YTm001h8+bCEZx--
