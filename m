Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B3C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 16:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC3F510EDDF;
	Tue,  1 Sep 2026 16:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZDKD+YVg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09FF10EDF0
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 16:56:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C99141E44;
 Tue,  1 Sep 2026 16:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D76B1F000E9;
 Tue,  1 Sep 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788281793;
 bh=FxxxYtRiaDFHCV+R3q2mZlvyzfxA8ksELi+XBCAA8AE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZDKD+YVgA0n8nmNycUT00Tc4paMagldD4rZ1oaU1lOrd57Cwmq1EsgTzCLvuenxwk
 0aEXFC29j7yuRhCfDwvrZnGA58o76mecgMByJN2Jrb+kGIWvaR/6iLcMZpn9RO0i7F
 doOkUBxZR199+AbZlwsl2C5SBYXMst0B0yd+ia/TeHngi3ai6DmWP2juFW81O31Drq
 gU+Wt1iFKJunf3NAPVLfjbHvzs6N5xdTMI7BFgjc/OWQn6LvVEUNqjYMhY2SokLHa2
 buHYSKADPvJuhzo9ti1/XCMNnPxvtWXOmDQoqnjjpTvhg+Womnn7+8yZ2QkpRAEMgy
 e/4bxLt3pbGuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:56:32 +0000
Message-Id: <20260901165633.1D76B1F000E9@smtp.kernel.org>
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

> Some API like atomics and I/O operate on primitives only; therefore other
> types would need to converted to these primitive first. Add two traits
> `AsRepr` and `AsReprMut` to indicate that the type can be turned into a
> primitive for these operations.
>=20
> `T: AsRepr` means that `&T` can be viewed as `&T::Repr` and thus it needs
> to support transmutability in one direction. `T: AsReprMut` means that
> `&mut T` can be viewed as `&mut T::Repr` and thus it needs to support
> bi-directional transmutability.
>=20
> To avoid duplicating implementations, all repr types are normalized to
> unsigned integers.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D3

