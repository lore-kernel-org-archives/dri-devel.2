Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380C0FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95E6E10E328;
	Tue, 28 Apr 2026 09:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NLxgCfyy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED87510E328
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 09:37:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0ED8F60142;
 Tue, 28 Apr 2026 09:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FBBC2BCAF;
 Tue, 28 Apr 2026 09:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777369042;
 bh=HM9evInCFYKy8es/TsKXHh8GLiXdJjs/TZ6Xikd1hus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NLxgCfyywn0V6zY4za6ewhWgPGQ5lWDL/2Pa2I4YpZflmGrJW7S27qnAOo2AlEKqM
 a0uc2KNAXUvyDs4nom2XXsustejAYuVoAsdyjftRdcaBHwx87GgB80fnqqcgeYrfU/
 qIeZFx0t9z0iqOwkaOYS3RfWY4uZUSPZ592PJsP9INsFTUcfPYzx7QwwD13BIUtKyg
 z8uQF16K+0bEWjK9JUNjl34AUQ/nGBuun0c4ojbzGjep+h+EhJudTHXgD+3InX8cCW
 KP7qOtqSQ5NzWn2KzqB3cs6s8W44lH+VVXyey+CIUh1Fgs+7Iskd4aSTKCL9cu6cNR
 XA1JWIDp9YG5w==
Date: Tue, 28 Apr 2026 11:37:18 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, m.wilczynski@samsung.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, 
 viresh.kumar@linaro.org, bhelgaas@google.com, kwilczynski@kernel.org, 
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, 
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, driver-core@lists.linux.dev, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, 
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Message-ID: <afB-p7vhyVYlcTn6@monoceros>
References: <20260427221155.2144848-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rqxumekpprrd4q5v"
Content-Disposition: inline
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
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


--rqxumekpprrd4q5v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
MIME-Version: 1.0

Hello,

On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
>  drivers/pwm/pwm_th1520.rs             |  14 +-

I didn't try to understand what you do here, but there is nothing
scheduled so far for the pwm_th1520 driver in my tree, so

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

for patches #12 and #19 touching this driver for merging through (I
guess) the rust tree. Maybe Michal wants to say something about the
actual change.

Best regards
Uwe

--rqxumekpprrd4q5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnwf8MACgkQj4D7WH0S
/k7NPgf/WyrJVOG8I34GH5+Ktz8BA9Pxs9vvwKn2Dor40alOMKdMZe9E1/NeIjk4
rRXtLa+EdYtq9IaNCEAbMBviP+iT93opuA2k3RqR/hJoIvYQBokftNexPO9U3Rn6
p33A51jyrZ7rMaijj0caWsANCuPQDj3uYYvgQ+jPtSRx9kDZtBI+XqMAoSkGhRxA
wD0/q4kZHaW1p2W3+wPWQfd3F++cs2cjxqZ1VVVs+BsA3LdZWJ29RI5kqIY1+Z/g
kb2nv/HyhMRzaUfnHuvVi2/OlxnWn+Wt0WfDWaPPqOwNm+vKCuYBhvmhxs6iHfnG
awPuxSiYzaxPXaCkO5cFlKMH2bnmeg==
=08q4
-----END PGP SIGNATURE-----

--rqxumekpprrd4q5v--
