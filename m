Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF00C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10EE810EDE7;
	Wed, 19 Aug 2026 11:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KgyRGR+o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9BE10EDE7
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:16:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08EC840AFF;
 Wed, 19 Aug 2026 11:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9EA1F000E9;
 Wed, 19 Aug 2026 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138218;
 bh=bcALehRv1n2/qmFLx37UWyQWCBtULdXm0JIlL4vEy5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KgyRGR+o+iUKyTDjHTF9rEI73A9E6cHnFKuWJnN2+7anAGQgDJ0qiUB5PgQB/I6gD
 OmLwtLXrX5oj2DoN0fIomJ50FGMkt2d+vbkAB/ZvT27uALK+LQap7Flt/Kx/hRn5JT
 n4zcgc0A2EN0nSEE11XRqC49rqw4/wCWPBxh+KjtyslI3J6LQDKnQ8iyJuga8LdcCV
 ilL943/7vod1vuUlDgk2qklWei6xWto/wmvQdo5trZ4/BnPMb/sjJeoZjyivpSz/ed
 habl5pXv1u1rY4gevWLxl6QEe9hMswEyELN6D0iXVcKgl3xM8z6iratfOHs6Zc5VQP
 SRe/6xxUEmUoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/16] rust: mem: add `transmute` with deferred size
 check
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-2-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:16:58 +0000
Message-Id: <20260819111658.AA9EA1F000E9@smtp.kernel.org>
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

> Implement a `transmute_unchecked/transmute` that checks size at
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D2

