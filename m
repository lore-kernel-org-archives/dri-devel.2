Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A121BCD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6B410E427;
	Tue,  9 Jun 2026 15:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j2xIBZLf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1436310E427
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 15:48:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFBA7416A2;
 Tue,  9 Jun 2026 15:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213F61F00893;
 Tue,  9 Jun 2026 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781020089;
 bh=1qLXop+cTPH+f6hmtY1LlYJw4vNZ4SL4+E5w0mhclL8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j2xIBZLfM6YJpl+WBcmI+rXhbHN9NL1oGqvb2tYqZu+m5Epe3KsrPeSPuRr592nA7
 vD3wbtJ41R4tJ78706Le93f7TxaZKVy7BOZKPMNjSeYaolmHIQwWI1Sxrmdibk1TTS
 Ht4CoQJ+CCif1Kj/Jo0mO+8asfDvChdTv/e9cN/LNcCVrLzFYYQ/QQnXZE1DGmzqkx
 CEx1ZMiuyUdqYpOKh5K+2KJuEgB2z2WRO4g8xOdSZBRw1DaxsS2pWr2J87QRhBHqY+
 +l5jMr2L3wg3yyK0ADEbQGo4AlYhfpEOHDXTM/7h7dcgQhzN1uCUWroX/AsgPSZHAY
 OSsVzkV14tRDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] rust: sync: generic memory barriers
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-rust-barrier-v2-2-30fcc48e1cd0@garyguo.net>
References: <20260609-rust-barrier-v2-2-30fcc48e1cd0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 15:48:08 +0000
Message-Id: <20260609154809.213F61F00893@smtp.kernel.org>
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
- [Low] The import statement `pub use ordering::{Full, Read, Write};` viola=
tes the vertical import style guideline.
--

commit c070c38a2a2dec94e13a6201bf19eb33e82b5478
Author: Gary Guo <gary@garyguo.net>

rust: sync: generic memory barriers

This commit implements a generic interface for memory barriers (full system,
DMA, and SMP) that requires the user to specify their intent. It provides
Read, Write, and Full orderings which map to the existing rmb(), wmb(), and
mb() barriers to reduce code duplication.

> diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
> index 8f2d435fcd944..54c527fdb7605 100644
> --- a/rust/kernel/sync/barrier.rs
> +++ b/rust/kernel/sync/barrier.rs

[ ... ]

> +pub mod ordering {
> +    pub use crate::sync::atomic::ordering::Full;
> +
> +    /// The annotation type for read-read barrier ordering.
> +    pub struct Read;
> +
> +    /// The annotation type for write-write barrier ordering.
> +    pub struct Write;
> +}
> +
> +pub use ordering::{Full, Read, Write};

[Severity: Low]
This isn't a bug, but does this violate the kernel's vertical import style
guidelines?

The subsystem documentation states that commits touching imports should fol=
low
the vertical import style, which places each imported item on its own line
when braces are used to group multiple items.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-rust-barri=
er-v2-0-30fcc48e1cd0@garyguo.net?part=3D2
