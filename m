Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362B7CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:06:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7BD10F5A4;
	Fri, 26 Jun 2026 12:06:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VHEyf3vT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1490410F5A4
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FD3E60132
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45EE1F00A3A;
 Fri, 26 Jun 2026 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475591;
 bh=kA3E2g3ttE8yH6xTuGwPiUWm4eg6v9MsNrIT9t2Sh9A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VHEyf3vTqV7IHp+OjWluIJUsYMrl9sK1u94HHyETLIc/au6uPK02ipseKe7J2GFTi
 4h1pUn0/RLTRODaTWwSZLcKZ+7v2G4I1rYO6kHVPRc1dYvWrT8CVTo9+Od8ri1+C2U
 Hf+eG+sqPCH9RDFE1Abv0eVfLOC99KXH2cDboDM3xkinzcc+w3tkWbNgJxj4We8B6B
 lLisp07yginLrGLHySaaefG1p6ZopNGmtJ1eJUobFSB9TbTVTXVBPgZdD2u/pTdabn
 rd1HuzSNukVhbtUzpv3NC505Li2+MbBi4ZTcIPUkPR1FYW6qfzZD2hLXRFsE4f8tkX
 KV77aWFgqZ92A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 8/8] rust: page: add `from_raw()`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260626-unique-ref-v19-8-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-8-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:06:29 +0000
Message-Id: <20260626120630.C45EE1F00A3A@smtp.kernel.org>
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
- [Medium] The `# Safety` documentation for `Page::from_raw` fails to requi=
re that `ptr` points to a valid kernel `struct page`.
--

commit 06f58b70c6165ba4fd1569c291c6f0d211dba674
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: page: add from_raw()

This commit adds a method to Page that allows construction of an instance
from a struct page pointer.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
[ ... ]
> +    /// Create a &Page from a raw struct page pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// ptr must be convertible to a shared reference with a lifetime of=
 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {

[Severity: Medium]
Does the safety documentation for from_raw() need to explicitly require
that ptr points to a valid kernel struct page?

The current safety requirements only demand that ptr is convertible to a
shared reference (non-null, aligned, valid memory). However, the internal
INVARIANT comment explicitly relies on ptr being a valid struct page.

Could a caller technically satisfy the safety requirements with a
stack-allocated or dummy struct page, but break the type invariant
and cause issues when methods like page_to_nid() are called later?

> +        // INVARIANT: By the function safety requirements, ptr refers to=
 a valid struct page, so
> +        // the returned reference upholds the type invariant of Page.
> +        // SAFETY: By function safety requirements, ptr is not null and =
is convertible to a shared
> +        // reference.
> +        unsafe { &*ptr.cast() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D8
