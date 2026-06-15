Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A5CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4ED10E565;
	Mon, 15 Jun 2026 16:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f8LcJjd/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F290D10E565
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:49:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A4A8D40E00;
 Mon, 15 Jun 2026 16:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60B41F000E9;
 Mon, 15 Jun 2026 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781542151;
 bh=rL3bZLrnUYURF8thqtoxReFNhkZUU/y7H9FUEGpZHlk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=f8LcJjd/1HjAnpmX20Vn9djIiVGiZCV/WTc3HJ/wfaEmbciM09pyS4RAPgOhcfF/j
 IJL/Tlx6f87EiSalmrO8wzxxYefAy4aeCCWtl0SCdOy2Cpu0jQFCfZqsF4nZYix5lm
 sIURhYzU2tWr3Mkw4DzebDua/cQ9LjMAGWX7GEC5jSjf+A9l0EkUSqf709XLumEfjQ
 ChScSOOykIT35cJu0rYeX9FPqhvGFwfvmfzcPE3WjCpJ/nu+EPSJ9vvx26tJ43wT43
 gOtMN/srrm53JcLut48+BgAjo+xmTUnNspwRY5WpwH5bwiP06SjBMd6gAAqzy/9Ivw
 cPfZdf0OUzvWQ==
Date: Mon, 15 Jun 2026 17:49:06 +0100
From: Conor Dooley <conor@kernel.org>
To: MidG971 <midgy971@gmail.com>
Cc: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xxm@rock-chips.com, chaoyi.chen@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, jonas@kwiboo.se
Subject: Re: [RFC PATCH v4 6/9] dt-bindings: npu: rockchip,rk3588-rknn-core:
 Add RK3568
Message-ID: <20260615-drift-dreamlike-0323a8dc5ce9@spud>
References: <20260613070116.438906-1-midgy971@gmail.com>
 <20260613070116.438906-7-midgy971@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CNSFopl0nkQ6YS29"
Content-Disposition: inline
In-Reply-To: <20260613070116.438906-7-midgy971@gmail.com>
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


--CNSFopl0nkQ6YS29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--CNSFopl0nkQ6YS29
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAtAQAKCRB4tDGHoIJi
0jbdAP4q0Xsijjrii0xb5mKoYRM8X3GV+zM9Ls2VeJvRKSouvQEAiryegcy5biWz
HQrV9PRAFwdCKCO1WUIBrZR7rlOn1Ao=
=kTnb
-----END PGP SIGNATURE-----

--CNSFopl0nkQ6YS29--
