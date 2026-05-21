Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC4ACD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FC710E4B6;
	Thu, 21 May 2026 16:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ccZrLQhO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870B810E4B6
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 16:54:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0A542601F4;
 Thu, 21 May 2026 16:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724C71F000E9;
 Thu, 21 May 2026 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779382476;
 bh=CPiUBM1CCh4+fwupCgXGj12p6AUKJ3ii5aw/UejUZUA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ccZrLQhOqQ0tJYohaZqVI+HkRDzD8MClngR4ibpzHfdxbrTHjvuDld5kc9Sm05d1A
 7A9ILnAX6gVNepqnmZutIezRg2vmEADM8h7xdBUHUsXKXWOW2LJlmYATKRxqLq7GGW
 wO2+DTys2qrOWtjdSoTr7eBfvR1e3l2yBhUP52jQTHa9eLoMr69OiQm/bsavKgLTEy
 cox8gCehzyV2UnZip5uZosgbGld0JDjw5ChOFP4NV96F/3jFWVAIYZQrPCI+x89qpb
 7xkqubQv5rak0NWj73sNGQurQdb9Njmv3hmCrzZKeDpvu035qMP67jWldAuZWXscvp
 CkLlWrsW5rThg==
Date: Thu, 21 May 2026 17:54:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Vitor Soares <ivitro@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Vitor Soares <vitor.soares@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 04/15] dt-bindings: vendor-prefixes: Add Riverdi
Message-ID: <20260521-contest-paralegal-cc088842405d@spud>
References: <20260521150038.103538-17-ivitro@gmail.com>
 <20260521150038.103538-21-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bdKBY2K+SjDfXSwL"
Content-Disposition: inline
In-Reply-To: <20260521150038.103538-21-ivitro@gmail.com>
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


--bdKBY2K+SjDfXSwL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--bdKBY2K+SjDfXSwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag84xgAKCRB4tDGHoIJi
0gcFAQC4LpPl3BGoUACGvb8sFxOPR84XXJPFojWht4l7o5Cb4wD7BfeIUT2pXyx3
DETSdDP6P7I10GKFgqHRfxIZzz9P+gY=
=rwt5
-----END PGP SIGNATURE-----

--bdKBY2K+SjDfXSwL--
