Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78791C79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA0010F3A7;
	Thu, 10 Sep 2026 09:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dt0BzjCg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B364910F3A7
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:06:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D43241E7D;
 Thu, 10 Sep 2026 09:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6341F000FF;
 Thu, 10 Sep 2026 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031219;
 bh=C2+p1+RQ3g7WvVBVNMvEerJl9JqhQMS+gKbSB5DW1GA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dt0BzjCgRMFggvMlryciNkHf8GCR1WB+6gMhPtkcnhDL5r8mRfOCtv7GWD3Hq9ato
 FQ/ofCdVWZUjdBXLEWxqYIjG777fT1DgGfI+/WJY2upmcnWGL0pxByCaQdEC5GtPzn
 vNax/TgmjWwum+Ho9v1qBO7oj6j8AksJTMt35NVNThFeWpriSQoi9XsS2anyVJogRg
 k4afGLa8DcSOBnXv11P9HKaNvR3Z6MTv2UxJ57fhdyvvifr+ONYI1Mnl53TUcMK5jo
 XuH9ZrlFPaBXRh5GMAmJA4CUbz5jEKJ8xCtBJLW9H8TBVqhzL7Q4iC8NrxSqWwxelM
 7fZ7uL0RCTx5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 2/9] rust: types: Add Ownable/Owned types
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-unique-ref-v21-2-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-2-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:06:58 +0000
Message-Id: <20260910090659.0B6341F000FF@smtp.kernel.org>
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

> From: Asahi Lina <lina+kernel@asahilina.net>
>=20
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unli=
ke
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>=20
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>=20
> [ om:
>   - Split code into separate file and `pub use` it from types.rs.
>   - Make from_raw() and into_raw() public.
>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>   - Usage example/doctest for Ownable/Owned.
> [ ... ]
> [ Andreas: Updated documentation, examples, and formatting. Change safety
>   requirements, safety comments. ]
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D2

