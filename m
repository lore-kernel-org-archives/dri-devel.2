Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE57CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B41510E8FF;
	Mon, 28 Sep 2026 08:51:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nbfgf2ZT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD7110E905
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:51:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 559CD43B63;
 Mon, 28 Sep 2026 08:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44DD1F00893;
 Mon, 28 Sep 2026 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790585470;
 bh=2/xOsFTDG4fxFcaqIIDqRaBYrYlg6DzwkvWNS27clnk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nbfgf2ZTLru5S7YMWXxlReVLVCMGc5eO6B8fuEzw5yIgwZeYG+K307hQeVAFpEGmC
 rLCBrC3bsE+g4WuLGByCCGN3ENfL0pXnFTf80xMg5nqt2p6JRqEj+ivSm8XaaJvpbq
 8I18kx25tJaTJVekvVLLoRnHZTldKykm3nOyDj3NVSk48YjSfrIq3u+pU2ZPr13hhM
 ycKnQW7zIrEJYv3SIqjfwjwkwONmdhR13DagzXsQcuzLUvj3b4P8dkhnkbeusOshNB
 eslNMeBMCjA3dMW7ViE93CFCTd6tVnA2IdXqagVCtMre85vdnHlCH8GPkFNcjvkcEb
 zieubo6c8IsUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] rust: alloc: add Vec::try_push_init
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: gary@garyguo.net, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-1-f04504c262c2@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-1-f04504c262c2@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:51:09 +0000
Message-Id: <20260928085109.D44DD1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] on try_push_init()
--

commit 5b0998c4906cb7b8fa1c27d53ac13078b73e0f91
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: alloc: add Vec::try_push_init

This commit adds Vec::try_push_init for fallible initializers along
with a new PushInitError sum type. It allows the original initializer
to be returned to the caller if the allocation fails.

> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index c7546b9da4fa3..a2b72a7779d9d 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
[ ... ]
> @@ -359,6 +367,49 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result=
<(), AllocError> {
>          Ok(())
>      }
> =20
> +    /// Appends an element to the back of the [`Vec`] instance by initia=
lizing it in place.
> +    ///
> +    /// Unlike [`Vec::push`], the initializer may be fallible. If the al=
location fails, the
[ ... ]
> +    /// let mut v: KVec<Element> =3D KVec::new();
> +    /// v.try_push_init(Element::new(), GFP_KERNEL)?;
> +    /// assert!(v[0].buf.is_empty());
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn try_push_init<I, E>(&mut self, init: I, flags: Flags) -> Resu=
lt<(), PushInitError<I, E>>
> +    where
> +        I: Init<T, E>,
> +    {

[Severity: Low]
Should try_push_init() be annotated with #[inline]?

The Rust subsystem coding guidelines recommend that small functions in
abstractions should be annotated with #[inline] to allow the compiler
to better optimize them.

> +        if self.reserve(1, flags).is_err() {
> +            return Err(PushInitError::AllocError(init));
> +        }
> +        // SAFETY: The call to `reserve` was successful, so there is at =
least one spare slot.
> +        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cast=
::<T>()) }
> +            .map_err(PushInitError::InitError)?;
> +        // SAFETY: The call to `__init` returned `Ok`, so the first spar=
e slot now holds an
> +        // initialized `T`. The new length does not exceed the capacity =
because `reserve` ensured
> +        // the capacity is greater than the length by at least one.
> +        unsafe { self.inc_len(1) };
> +        Ok(())
> +    }
> +
>      /// Appends an element to the back of the [`Vec`] instance without r=
eallocating.
>      ///
>      /// Fails if the vector does not have capacity for the new element.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-b4-nvkv-v3=
-0-f04504c262c2@nvidia.com?part=3D1
