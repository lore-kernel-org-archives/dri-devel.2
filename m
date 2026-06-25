Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3791CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3065810F230;
	Thu, 25 Jun 2026 10:25:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BZg/I8ka";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D20A010F235
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:25:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5366B60123
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56171F00A3E;
 Thu, 25 Jun 2026 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782383150;
 bh=9h2j/XNhmhlcvuBt4WXuwaPw+4bYk+FEspXvfL6F6EI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BZg/I8kaLdP6zxv/K8/a+hLHsBA8EVj9+zUTcCXtnSu5PYGGpjVXMpFds8LWvPgBL
 XJh3j3W3pr+LAwsCjL8dIpyDbCuLWOHjizeU0pIIImpcD+EPKyhJGYcud9KgMtmhjp
 ubUkntiYsxWW/6ydMWEPNZdWZeg8HobT+IXg1j3oNwkFT0EARNsAJXKiZzqdXntaCR
 dy5RixaSwELAsDr8LDdi4TijyO+X+B04ht+L/CS6knHY2f/880XPpaN7t5LnVjEZzD
 Yow8hsmiugk0/fwKpEk5sC43Wl6gNbTbBUG4mqBZwUXyqqk+nGplVEOW0l/5/oLW3Z
 O3U+hyUwlxFnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 8/8] rust: page: add `from_raw()`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-8-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:25:49 +0000
Message-Id: <20260625102549.B56171F00A3E@smtp.kernel.org>
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
- [Medium] The `# Safety` documentation for `Page::from_raw` is missing the=
 precondition that `ptr` must point to a valid `struct page`.
--

commit f6aeebdd661d4004190de07e9d991442f793517a
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `from_raw()`

This commit adds a from_raw() method to the Page abstraction. It allows
the construction of a shared reference to a Page instance directly from a=20
raw struct page pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 6dc1c2395acaf..c88fda09ead5a 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> @@ -143,6 +143,20 @@ pub fn nid(&self) -> i32 {
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

[Severity: Medium]
Is the safety documentation missing a requirement here?=20

The # Safety section only requires that ptr is convertible to a shared=20
reference. Under Rust's rules, an uninitialized or dummy pointer could=20
technically be converted to a shared reference if properly aligned.

> +        // INVARIANT: By the function safety requirements, `ptr` refers =
to a valid `struct page`, so
> +        // the returned reference upholds the type invariant of `Page`.

The invariant justification inside the function explicitly relies on the=20
caller guaranteeing that ptr refers to a valid struct page. Could the=20
# Safety documentation be updated to explicitly require that ptr points=20
to a valid, initialized struct page so that callers do not inadvertently=20
violate the Page type invariant?

> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D8
