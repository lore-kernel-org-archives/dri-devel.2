Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D56C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FEBA10EE4B;
	Tue,  7 Jul 2026 16:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wmjd9ws+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7041B10EE4B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:07:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3513C432C2;
 Tue,  7 Jul 2026 16:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3FD1F000E9;
 Tue,  7 Jul 2026 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440443;
 bh=pnF/wRn5YW3lX7u2Wmu6DmObsFq+jMNmJPE5BpAe5pw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wmjd9ws+O4QJqkbJT5kbTWmdHHl2/KjGDEdCTgn9zR3Mcy3sh17uVi5LKRDc7USXC
 0JsPXao/1HZHBdlNkEqRwjnGldOTssNDVkpRIKNKh94anU/JWzHBMUP1thX7/BxmKk
 V54TcydjDipKvCE9Fj3/XS37moSujyR7NCtvz3BD3HN+IvKbTXusiQa3APGH/jO4p/
 evgPgd5lmzu6Jq5mcEoMdXWr+TQ+p6zXknA1UOcFwaiJl5HQc9sHSDqmdqZyIsz6S5
 1NuE7OkrKDB7+ralWCaCYhdn557y6f4XIIlnVsIlu/CpebQSi1uw8WnTxwnKlLQ1Fj
 CH64wOu1HgnMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: drm: fix GEM object pointer safety docs
To: "Yilin Chen" <1479826151@qq.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <tencent_37A376A02B95E3DBE7E5C64882B7A4F90807@qq.com>
References: <tencent_37A376A02B95E3DBE7E5C64882B7A4F90807@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:07:22 +0000
Message-Id: <20260707160722.DF3FD1F000E9@smtp.kernel.org>
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
- [High] Unsound Safety Contract in IntoGEMObject::from_raw
--

--- Patch [1]: [PATCH] rust: drm: fix GEM object pointer safety docs ---
commit 83b1634421cc950ce3b8ca23f3c9ab5c476d4697
Author: Yilin Chen <1479826151@qq.com>

rust: drm: fix GEM object pointer safety docs

This commit updates the Safety documentation for IntoGEMObject::from_raw()
to state that the argument must be a valid pointer to struct drm_gem_object
rather than a pointer to Self.

> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index c8b66d8168719..90b256093e4cb 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -118,7 +118,7 @@ pub trait IntoGEMObject: Sized + super::private::Seal=
ed + AlwaysRefCounted {
>      ///
>      /// # Safety
>      ///
> -    /// - `self_ptr` must be a valid pointer to `Self`.
> +    /// - `self_ptr` must be a valid pointer to `struct drm_gem_object`.

[Severity: High]
Does this change make the safety contract unsound?

By removing the requirement that the pointer originates from an instance of
Self, the safety contract no longer protects against passing an arbitrary
valid drm_gem_object pointer.

If a caller satisfies this new documentation by passing a valid
drm_gem_object pointer that is not embedded in an instance of Self, won't
the container_of macro in the trait implementation yield an invalid pointer
and cause out-of-bounds memory access when fields of Self are accessed?

>      /// - The caller promises that holding the immutable reference retur=
ned by this function does
>      ///   not violate rust's data aliasing rules and remains valid throu=
ghout the lifetime of `'a`.
>      unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &=
'a Self;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_37A376A02B9=
5E3DBE7E5C64882B7A4F90807@qq.com?part=3D1
