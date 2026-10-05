Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399E7CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8582410E24C;
	Mon,  5 Oct 2026 10:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="om8EkMFz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAC0910E24C
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 10:55:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5CFB440E22;
 Mon,  5 Oct 2026 10:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D1C1F000FF;
 Mon,  5 Oct 2026 10:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791197747;
 bh=kPu4cTAyFijp/5LzJz2S7ETVefd0fKnlMAA7BPnhczw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=om8EkMFzf78sjtstoiKOqliBN1xBT1Uf3lRvA/+SK7ToDK9R4IH+WbXFnHFV5kGci
 ZcML1a5WBi898HacD8CGokYWdrD6QKIFa1JB3UBpCelLUu1Ref9HE9Kt6i3cbGgi56
 r/dMh7vyXeYPBNWvUgR+ssgABZsbO5/jOdz1RPrpyiWHug7yYHTR5T++/1e12zf0y8
 pcSsoUXSiPtWIve4kI57oHjZHwdahbWSvv7KaeiCJ3dMrMucZrJ87FGEng9gZZ4k6G
 QEXJx+0t1HdgpKs5Y259PZ+60u5bzxce5tgLq0YyY6DPwWPWcP6orbFtX4Fv2KkMvJ
 6XmiSvjIW2fMg==
Date: Mon, 5 Oct 2026 11:55:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: panel: himax, hx83112b: Tighten
 compatible matching
Message-ID: <asOCLYbmmiuqmd3n@squawk>
References: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
 <20261002-hx83112-compatible-contains-v1-2-d558635ab7fc@fairphone.com>
 <DLWSX9ZHDC8K.1KXUAR8VSMNND@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HV8m08xHwAClXTgt"
Content-Disposition: inline
In-Reply-To: <DLWSX9ZHDC8K.1KXUAR8VSMNND@fairphone.com>
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

--HV8m08xHwAClXTgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--HV8m08xHwAClXTgt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasOCLQAKCRB4tDGHoIJi
0uhgAP9qcGH7w9LpSSRHkLL99d3mDpw6YcqXgX3/+/KeYBQuswEAhVOGqnpwvhWq
M/cWo1qYH8QCbVFjGr7KaGfVW+qmpQE=
=ZH+k
-----END PGP SIGNATURE-----

--HV8m08xHwAClXTgt--
