Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007A606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BdsKOFx8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D701E10E42A;
	Fri,  6 Nov 2026 17:17:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B2510E42A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 17:17:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 86A1B601BF;
 Fri,  6 Nov 2026 17:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F8D1F0089F;
 Fri,  6 Nov 2026 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793985438;
 bh=9oKtJzzwarYUJiv7jlPjh+yzmRSqn2gjanS9mNX4SlA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BdsKOFx8Fo9DJdwDbgz2wj26tgTqPDVvzevk5w5vP8mQcA8jVXw3UYC/USvw9o44h
 cdyea92E4IFG01B5luPNipM0sDj8iD7OMpMMQjowEIZMatkgGLO1qq1TOJ5lnWadsz
 mma+h33PEMEpwd+hBxaJbzYSLYNaFWCcbt0TZig4BThotUQH5QF9+x9XJyZRO+Zd+A
 x7DRIpClp98U/ceBQg5rSHCPjxOGmqiUttil8hh2YP+DlC9v+kQjlNvHQZ6GpMRr+p
 7KFB5e9uxQlvk7zwGC1mDpnTlxhSgrcD3KS6Jlt0F0krvhBmweGXrB7SX524xeUrA3
 34k3GljwueBwg==
Date: Fri, 6 Nov 2026 17:17:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Cunyuan Liu <cunyuan.liu@cixtech.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, gary.yang@cixtech.com, fugang.duan@cixtech.com,
 daniel.almeida@collabora.com, aliceryhl@google.com,
 p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 cix-kernel-upstream@cixtech.com, robin.wang@cixtech.com
Subject: Re: [PATCH 1/3] dt-bindings: gpu: Add CIX Sky1 Mali support
Message-ID: <20261106-overjoyed-uprising-bcda8196d8b1@spud>
References: <20261106104735.1651267-1-cunyuan.liu@cixtech.com>
 <20261106104735.1651267-2-cunyuan.liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TL3BuhlNyfu8TC1S"
Content-Disposition: inline
In-Reply-To: <20261106104735.1651267-2-cunyuan.liu@cixtech.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--TL3BuhlNyfu8TC1S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--TL3BuhlNyfu8TC1S
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4LmAAKCRB4tDGHoIJi
0qkCAP4lUa8NxvJSR4tsLoNVyXaFW5xl+a+v4xBkMN56edTbEwEAvt6berL7udJW
J6YV6LryD66prWkFjrzJlKzTHuNVkwI=
=bAJc
-----END PGP SIGNATURE-----

--TL3BuhlNyfu8TC1S--
