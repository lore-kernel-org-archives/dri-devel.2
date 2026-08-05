Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFBAC55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637EA10EF47;
	Wed,  5 Aug 2026 16:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D35Wn+Te";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF0510EF47
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:42:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC0C560A5A;
 Wed,  5 Aug 2026 16:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAC51F000E9;
 Wed,  5 Aug 2026 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948155;
 bh=/2u50LLSNyt/+SgkTfxkSFIlaocehhSkMm6dT7KM9Do=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D35Wn+TeXJH/70D/A+Ajam63GsZPjyKuhOcvvj4/QwyDJ8VlntoJ38MFyO96x1t9N
 7qOcAsH19aJh9lIl7icilYZcZ4Ofx9F+WWxl34z91ra7pznnL19qa5H38payo9DLow
 SgVkUCMMsQKe7oIIRpeID3pWMjlQ4fzvcJCTtLEa+FT/5beuheDDZVj1zCgNu6pXl9
 6I6qZHvU88/H0GeLRZPtSjI+xLhdaHdvb9GNBaXBoIuZ5L1E7kA0gEgthKxZJZWJUJ
 Bydsl1SFZoXdmNMFjC+e37/Ys3+wLg7h3LumbROqrliW2dtrkhVdGR44x7odJOtBj8
 Gv7aUsmHOARiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/16] rust: io: register extract offset computation
 to helper rules
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-5-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:42:34 +0000
Message-Id: <20260805164234.DDAC51F000E9@smtp.kernel.org>
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

> Create a helper rule for register offset computation so there can be a
> single rule for fixed offset registers.
>=20
> Similarly, extract stride computation to helper rules.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D5

