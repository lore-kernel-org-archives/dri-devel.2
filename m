Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4669AC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF49410EDDB;
	Tue,  1 Sep 2026 16:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nhqCVzJJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F0510EDDB
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DC13437CD;
 Tue,  1 Sep 2026 16:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA71F00A3A;
 Tue,  1 Sep 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281944;
 bh=e3UlQvfsBCgYPhIPS4h5GwPnyntILhUACVh/wBzK3ho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nhqCVzJJubcl/KHRw30/pIjxBkIvr4Zd75H/z3mE9SZcps4PtoTGFpqES5mzx1XEB
 nxKiFJAcD+3Z8Alwh3BG+KVgRmuBOJTZbM/GV1D6vXZu3wbSmi04Rz3wM/5DvdT/ak
 xZc02/Q0WPg2OZwh/mmsJmCGz0Y1akzWF/rebtLr0zLsVt7GSsouDPLONP4zBPze99
 tcdcowxs/DYXcr4Ra+bg/8Lx7gCNrYNznHPqB71EIEBVbs7IV4ln3ILsLMvP7DHtPm
 pxijb6YOe6l4xjFQAcP//jgD9AOiC5zFuvFuRgkd0UsDNJjzYyQ43u5OkA2SEme8WA
 ezysGObTw3SgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/16] rust: mem: add `transmute` with deferred size
 check
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:59:03 +0000
Message-Id: <20260901165903.C5DA71F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> Implement a `transmute/safe_transmute` that checks size at
> monomorphization time instead of type-checking time. This allows more cas=
es
> where we know that the size matches but this is not generically checkable.
>=20
> The signature is equivalent to the unstable `transmute_neo` function in t=
he
> standard library. A safe variant is provided to use with types implementi=
ng
> `FromBytes` and `IntoBytes`.
>=20
> Existing users of `transmute_copy` to bypass size checks are converted.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D2

