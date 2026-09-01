Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE16FC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:02:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B13310EDE8;
	Tue,  1 Sep 2026 17:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JrREq5Ks";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31EB210EDE8
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:02:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 586876020D;
 Tue,  1 Sep 2026 17:02:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AAF1F000E9;
 Tue,  1 Sep 2026 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788282147;
 bh=ByYVMag5bEmCjwCVHkw7W/ipKCZmgqVI3FuC5WX29rI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JrREq5KsNP01V9DqagWK/hesrKzGtT3GZ2p4FuO64VJSGLl8Z8wBdmzbxOoLHPOnV
 vtXK+QQGKl95il+zSX/pQGoTaWB1LUGoRr/DhVIPDz9pQkC90RqEh5gf0oPrkuyFSW
 iFyEtV9B4NSllebZmP4LV8bxrdP7/2xNdrDcYYE9nfuwAnsgJ4q6z/de2hFYYgCtlY
 gYTam0WELgxz3pHacz9cBj6PwwahnG7Fa1kXP0fO9qRydz3Wzoo4bFQok9/tcLitdQ
 QinRHu5h/FRlAT00xDvvE0CNonfYwTP3VSE1aD5YkFOaD1+QmtcbGhM2ThOOEsyI8g
 xAH7St2jatxjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/16] rust: io: register: unify handling of register
 with/without bitfields
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260901-typed_register-v4-16-5552b1d59525@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-16-5552b1d59525@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:02:26 +0000
Message-Id: <20260901170226.C6AAF1F000E9@smtp.kernel.org>
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

> Move the `FixedRegister` from a property of register to become a property
> of type. Name the new trait `FixedIoLoc` indicating if I/O location of a
> type is unique for a specific base. Thus, bitfields become just a special
> case of this (where type is unique because we're generating it in the
> register macro), and expose feature to registers without inline bitfield
> definition with the `#[unique]` attribute.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-typed_regi=
ster-v4-0-5552b1d59525@garyguo.net?part=3D16

