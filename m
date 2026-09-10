Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2451C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D1810E167;
	Thu, 10 Sep 2026 09:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FpN+QqH3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093DD10E167
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:14:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8203E600CB;
 Thu, 10 Sep 2026 09:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F7A1F00893;
 Thu, 10 Sep 2026 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789031651;
 bh=H8PFvjkgLnvGlQ0YmBY8hPylGgzpIXwfgLMu+qWREyY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FpN+QqH3JlGwzdGiKb5hiN7RDO/O0lgHfG548D6B+o3LaxMxaBncmHMYB4D8NC/af
 YuXnMbOL3KeDcSzTpjqQok1qqExNd6cPdwSmHWGIGa8k+X42kglJmNLz827vkzHZlj
 153dYiyfaItp35vpRQ1EUvmaauhxvhkfXDqF9ggBiw8q3LWdcOcssLCmv3JWbh7hEw
 IsH1mhrLLWIiYZVRItuik25U185LVJjTRDYSVUiyJFzwcrdPx1aFHtd8QnBrAkIikE
 SOW1LCA6pxYgRNoo0YWCMF2tb9JI+mf3ZE3hKlGNEV/beJ+Svfks/6fRa5fWmqngfb
 fj1cG5+d1mQMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 9/9] rust: page: add `ExclusivePage` for race-free
 page access
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-unique-ref-v21-9-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-9-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:14:10 +0000
Message-Id: <20260910091410.E5F7A1F00893@smtp.kernel.org>
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
- [Low] The `ExclusivePage::alloc_page` method is missing the `#[inline]` a=
ttribute, violating the Rust subsystem guidelines for small abstraction fun=
ctions.
--

commit 3d93318174c0f08ec348e7d20ff2086b2a3244a6
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add `ExclusivePage` for race-free page access

`ExclusivePage` wraps a regular page but adds an invariant that the
page data area does not incur data races. This means `ExclusivePage`
cannot be mapped to user space or shared with devices.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index cd394b0656c0c..4e5b1c2f43466 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs

[ ... ]

> +impl ExclusivePage {
> +    /// Allocates a new `ExclusivePage`.
> +    pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {

[Severity: Low]
This isn't a bug, but should this abstraction wrapper around
bindings::alloc_pages() have an #[inline] attribute?

The Rust subsystem guidelines specify that abstraction functions forwarding=
 to
C binding calls should be annotated with #[inline].

> +        // SAFETY: Depending on the value of `gfp_flags`, this call may =
sleep. Other than that, it
> +        // is always safe to call this method.
> +        let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
> +        let page =3D NonNull::new(page).ok_or(AllocError)?;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D9
