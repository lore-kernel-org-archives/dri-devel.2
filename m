Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7BFC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABD210F3AE;
	Thu, 10 Sep 2026 09:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kn18P9RN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D72910F3AE
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:11:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 35EF04032B;
 Thu, 10 Sep 2026 09:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BDC1F000FF;
 Thu, 10 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031499;
 bh=ojxyxkwDmQtIJDXEqgQXqbCoPgT0ftxJMe7E+KDyKmc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kn18P9RNNkw+fJyLAZSfuSCbvwEBtXpPzdBd/RboVNv6S+tdaxrifuuAlSCf9/XrG
 JjVWW1tUZe3yLJ8CdO0sw+yzMKOTMkd+2j3UcKiGsTfX1hQss/MAOQfgoRre0CaP7w
 KKk0lEwvi8ZVaL4Yt2zYauxDeIQPbxTgu0spKY7gxkoRyp0x0xoXHqHf7e0iT1KcPd
 3BXCOfsDt59xwoXaBmF2HnCOduhAN47zjIuDu9/4v7MHMc9N0xan0voBxnT5+Ny7IP
 yBnK8pXo4CKgXru0UrLon/IawiOUbWM6UeSrdVgpgXJLkP7sWncrR08vVMLma85TqU
 wviKb9zJTtZVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 8/9] rust: page: add `from_raw()`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-unique-ref-v21-8-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-8-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:11:38 +0000
Message-Id: <20260910091138.C6BDC1F000FF@smtp.kernel.org>
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
- [High] Insufficient `# Safety` requirements for `Page::from_raw` leading =
to unsoundness.
--

commit e6799a35c42d6949e4edb57a0982fc37d7af34f7
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `from_raw()`

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index a2610774c7499..cd394b0656c0c 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -146,6 +146,20 @@ pub fn nid(&self) -> i32 {
>          unsafe { bindings::page_to_nid(self.as_ptr()) }
>      }
> =20
> +    /// Create a `&Page` from a raw `struct page` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be convertible to a shared reference with a lifetime =
of `'a`.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
> +        // INVARIANT: By the function safety requirements, `ptr` refers =
to a valid `struct page`, so
> +        // the returned reference upholds the type invariant of `Page`.

[Severity: High]
Are the safety requirements for Page::from_raw() sufficient?

The documented requirement allows passing a pointer to a valid struct page
that has a zero reference count or is unmanaged (e.g. stack allocated or
reserved).

If safe Rust code later casts this &Page to an ARef<Page> (via .into()
or .clone()), this invokes inc_ref() (get_page()) on an unmanaged or
0-refcount page.

Couldn't this cause memory corruption or trigger a VM_BUG_ON_PAGE? Should
the safety documentation and type invariant require that the page is managed
by the page reference count (i.e. has a non-zero refcount)?

> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D8
