Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51614C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A14410EF68;
	Wed,  5 Aug 2026 16:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfOM8m8c";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE8E10EF58
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:48:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 720654150F;
 Wed,  5 Aug 2026 16:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162641F000E9;
 Wed,  5 Aug 2026 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948487;
 bh=8IOD1K+MNA+JCsGD/3AayBdJoG0Qr+sjwqjnC+Ixm5s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfOM8m8cM8aoFn3e9dATK6qcaOMfvJearRESjg1kXvOzzIYb1UWXftRKHXMZ6+JUy
 jeY3kO9juknSf2DgLFBOqRwoEYbkBntuZvP2gHAoI9JcElXuLCWMkbmNECjO9GMLId
 YV0hRhB6bdKM7htsNvnEkDezbwtorG062TZbXH1Xvo+yhUzh31sjufdYU3b9yPs76i
 fL+OFLDxzM3hqx+tDTQOkPXqLimSzNPevSyTZ/o2KfCLKCOeo9mHgumnAyNpizKgzV
 yBvkr7tY9Ix3q5IFwVkhlvc9GKzCkYbwHdkB7oN+f58r8+g4V/KflFsDdIZivZAPB4
 Fxj0qOw5bVxpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/16] rust: io: register: remove `Register` trait
 and cleanup macro
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-15-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:48:06 +0000
Message-Id: <20260805164807.162641F000E9@smtp.kernel.org>
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

> With the removal of relative registers, there are only two type of
> registers left, fixed register and register arrays. There is not much
> benefit in having a common super trait for them anymore, thus remove it,
> and cleanup the macro rules associated with it.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D15

