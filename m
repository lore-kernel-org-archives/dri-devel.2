Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4790CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6C611A2FC;
	Thu,  4 Jun 2026 20:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EqSeetLX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61F711A2FC
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:27:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF44A43674
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F81F00893;
 Thu,  4 Jun 2026 20:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604879;
 bh=YBvC4Fda+tKS9v7W4UIElArPjNz9mmn4BPqn1AWLPdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EqSeetLXqhpSDfGyVu4AENk1xy9TWLjtgEM/XscT4En1cRlANf6yYQmkpgoS6yzSO
 /MuEbMyjIwX3fka9SKL03H0uL4SIuwDWw63TvYtbSPchZCX5mmn0Ujm50I3iSSCEO3
 XOrC16OuB0kwgF8woLO7Mk2g5ENxc2RpR7lPNGMFusNyTJtFl+KUPlENgH5h614wnF
 1PAw6l+xxjoxRoNskaswaGFf2jBj7ZxPVstlDs4bOeyIDrZTGgFyL+crbn3dGx3krI
 TfgGJ7ntc2+3Bf9/Az812bxWenUCiFa3PMGAkLZ8+u6LyqAeN5D1FY9cCBtl3dJQl6
 7qWMxonTDYxYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 10/10] rust: page: add `from_raw()`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-10-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:27:59 +0000
Message-Id: <20260604202759.630F81F00893@smtp.kernel.org>
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
- [Low] The `Page::from_raw` method silently bypasses the documented type i=
nvariants of the `Page` struct and lacks an `// INVARIANT:` comment.
--

commit 224010a6541ae8f534f1577d76a1acd3e9bb5d34
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `from_raw()`

This commit adds a new from_raw() method to the Page struct. It enables the
creation of a shared &Page reference directly from a raw struct page C
pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 844c75e541345..d56ae597f6926 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> @@ -214,6 +214,18 @@ pub fn nid(&self) -> i32 {
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
> +        // SAFETY: By function safety requirements, `ptr` is not null an=
d is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }

[Severity: Low]
This isn't a bug, but should this unsafe block include an `// INVARIANT:`
comment to justify the type invariants of the Page struct?

The Page struct has an `# Invariants` documentation section stating that it
has ownership over the page. While that ownership invariant might be an
obsolete leftover, creating a &Page reference here conceptually asserts that
the referenced memory satisfies this type invariant.

Could we add the required `// INVARIANT:` comment or update the outdated
type invariant documentation to clarify this?

> +    }
> +
>      /// Runs a piece of code with this page mapped to an address.
>      ///
>      /// The page is unmapped when this call returns.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D10
