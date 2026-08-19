Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C73C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D455D10E557;
	Wed, 19 Aug 2026 11:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eixcbf1s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768AE10E557
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:16:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48CA040984;
 Wed, 19 Aug 2026 11:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2EC1F000E9;
 Wed, 19 Aug 2026 11:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138188;
 bh=4gFEkjgdtbDlOcoq9ICfYCDlv3RSVGhnztjb90jeqaI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Eixcbf1sIjwigjDG3lLxHIoCF2p7l5eAluSRshPYZeIr/VOcf/j/byPvaDJG/TQK+
 ek9WVN6Jw5cSoFJ6w0t7wADzKm4hMchYmJsKzIslLYKwIOPi2blqS7XkXS8R4z9QCT
 ZLBSMN5tUvlpkG4Ii4VPCuqf8kBY7lIA1hsH3LyCmRkLOR43/LvkDT+FJIAcNTpVza
 W8w+Xpz9oRGaSTTvo5+ziViJ5X9BfuFbKDT33EAUFHcMSQpmRxKZRY7bfGwqZeamiu
 Wqs881n+WFTDDS6hmbxaMchtn0EF+XI1Gmmmn1p4rZsaWky8raPZh89WHYRYJj0XVl
 YWo2+CwGu9kdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/16] rust: io: support register projections
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-5-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:16:27 +0000
Message-Id: <20260819111627.EA2EC1F000E9@smtp.kernel.org>
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

> `IoLoc`s themselves just describe a projection from a region to a concrete
> register. Thus, support it in `io_project` macro too. Also, update methods
> that operate on `IoLoc` to use I/O projection.
>=20
> Documentation of `io_project!` is not expanded yet as the example works
> better when `register!` type can specify base type. `io_read!` and
> `io_write!` gains the ability to operate on registers as corollary of the
> capability of `io_project!`. Examples are not added because `read` and
> `write` is still preferrably used instead.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D5

