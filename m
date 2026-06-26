Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561CACDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F35810E35B;
	Fri, 26 Jun 2026 12:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GoxYzMV1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F6410E35B
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:01:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3603340DD7
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E844C1F000E9;
 Fri, 26 Jun 2026 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475261;
 bh=khjGmYHEPhF/pA6xHxKQr52lgEJocPMDHM6JFbmBuSA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GoxYzMV1DB7OA8P58p0V6MY4G9uJg/kGvbq7Q4mWm1kePVC9wnwd+BXvYmqQw8nyx
 NpshZgzCF7khmf6KOF70UmmrmQTyy6PQNR8ywi3CysMtygkk3JOnOkG6EJa5mz0VQ1
 iHdC6DkFxzdEJH/a/38aCb4AENTY4oyVEz/DSKVg/zIhnua9x8IapcCT2+PSOgX4Pr
 mPsz0T9NKZPvGbmUPJ6kC9Aa8ceafdXDQ0aE7DzVDYnvbzzHcXoU5M0wnHd3DAIP1S
 d6RZ6GXfJvcAluTNjxf6p44phAQ+sWcIiNJBBE5NbKqfqWjOEGKVZK86uCI2nFgns+
 TReYBd/NcOkaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/8] rust: alloc: add `KBox::into_non_null`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260626-unique-ref-v19-1-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-1-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:01:00 +0000
Message-Id: <20260626120100.E844C1F000E9@smtp.kernel.org>
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
- [Low] The SAFETY comment refers to `KBox::into_raw`, but the code calls `=
Self::into_raw` for a generic `Box<T, A>`.
--

commit b26e998f8fbb891dd6bb1b2e1c41a63a8ecd7700
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: alloc: add `KBox::into_non_null`

This commit adds a method to consume a `Box<T, A>` and return a `NonNull<T>=
`.
It serves as a convenience wrapper around `Self::into_raw` for callers that
need a `NonNull` pointer rather than a raw pointer.

> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
[ ... ]
> @@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>          // which points to an initialized instance of `T`.
>          unsafe { &mut *Box::into_raw(b) }
>      }
> +
> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.

[Severity: Low]
This isn't a bug, but there appears to be a missing space after the comma in
`Box<T,A>`. Should this be updated to `Box<T, A>` to match standard kernel
formatting?

> +    ///
> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
> +    #[inline]
> +    pub fn into_non_null(b: Self) -> NonNull<T> {
> +        // SAFETY: `KBox::into_raw` returns a valid pointer.

[Severity: Low]
This isn't a bug, but the SAFETY comment references `KBox::into_raw`, while
the method is implemented for the generic `Box<T, A>` and directly calls
`Self::into_raw`.=20

Since `KBox` is an alias specifically for the `Kmalloc` allocator, should t=
he
comment refer to `Self::into_raw` or `Box::into_raw` to accurately reflect
that this works for any allocator?

> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D1
