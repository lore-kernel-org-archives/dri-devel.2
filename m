Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B00FC43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EC210F64B;
	Fri, 26 Jun 2026 14:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O7nJZh8Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA0910F64B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:56:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B433600C8;
 Fri, 26 Jun 2026 14:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC941F000E9;
 Fri, 26 Jun 2026 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485815;
 bh=XJ0lsQql4atkNgytuLa1UK+zMgT0gow2d0m8x5D8KTI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O7nJZh8QpvuVA9wNci9KlauKmNtfcTkwKdsDFnnkz8yUyOZoDowg1Zon+g+LA14t3
 izCPp4h1tU4hDm/aaa1rr5hf8kJ0/TBV68YT0HjhzFxhPDXma1nToH/gxLbHQeX/hQ
 tb2OZDbCKaDVJUEJsnghoEt46OfnONv5gISCRIJmfc55/PsVauN29pfi0Y0wD8C0kO
 N/SGxDVeTHPhQ82lWR3Y6UHM+LVZv1scFQYeQIHg9rVJy6th5sJj1u9O/iTXt0n97J
 iK5Sa9/y/JR3qBKuo4OPRruX2Lrk4RgUZoXr9730AovgJK46LlgU0wnL5ThA0fsfrD
 VLeMwJxssHM2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/20] rust: io: move `Io` methods to extension trait
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:56:54 +0000
Message-Id: <20260626145654.BFC941F000E9@smtp.kernel.org>
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

> `Io` trait now has a single required methods with many more provided
> methods. Provided methods may want to rely on their implementations to not
> be arbitrarily overridden by implementers for correctness or soundness.
>=20
> Thus, extract these methods to a new trait and provide a blanket
> implementation. This pattern is used extensively in userspace Rust
> libraries e.g. `tokio` where `AsyncRead` has minimum methods and
> `AsyncReadExt` is what users mostly interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> A `size` method is added as an example of methods that users should not
> override.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D12

