Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2A7CDE008
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3868210F229;
	Thu, 25 Jun 2026 10:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nxTZobx/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E2010F229
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:22:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A8E0406A9
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF121F000E9;
 Thu, 25 Jun 2026 10:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782382927;
 bh=kHYninHeoO15QPVSpDTTpGn+Wym7QkYbV3//DkbL/BI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nxTZobx/bitU2o0ayop7tvoh53gpwrRdmRpVhYl4KlS/5ykfnxcEyd7MuLVRtrvYs
 RIkACGKd73+Oacd5MJqOInFt5OZMWjWmL3PF0Fivggqsc30eBddXcYBZLd7Qvvfhgj
 H9UoqYAWuuI7QySS3hZR4EQTWzQhX+9Coi9EJWfkXrsmZfxHNddQHRVGUqlZV1mKtg
 /nQCE0nznwXtcksBfwGDyKwr2kpPucIpowuUY7UQl7e+50UgYSaMVcCrOplt52H3pR
 b+Atlfft2TzxwKTfTzAqqgDXCmDU+LP6LR3Tz7G1F3s4OUXZb08jDFEStylI470aSG
 KWQtgef1KToDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 1/8] rust: alloc: add `KBox::into_non_null`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-unique-ref-v18-1-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-1-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:22:06 +0000
Message-Id: <20260625102207.1DF121F000E9@smtp.kernel.org>
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
- [Low] Mismatch between SAFETY comment and executed code in `into_non_null=
`.
--

commit c2c9f847b4c97663dbc3f96c92652dbd5698f0aa
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: alloc: add KBox::into_non_null

This commit adds an into_non_null() method to Box<T, A> that consumes the b=
ox
and returns a NonNull<T>. It acts as a convenience wrapper around
Self::into_raw() for callers requiring a NonNull pointer.

> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index 35d1e015848dd..d534e8adcf7b3 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
[ ... ]
> @@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>          // which points to an initialized instance of `T`.
>          unsafe { &mut *Box::into_raw(b) }
>      }
> +
> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
> +    ///
> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
> +    #[inline]
> +    pub fn into_non_null(b: Self) -> NonNull<T> {
> +        // SAFETY: `KBox::into_raw` returns a valid pointer.
> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }

[Severity: Low]
This isn't a bug, but there is a mismatch between the safety comment and the
executed code in into_non_null(). The safety comment specifies KBox::into_r=
aw,
but the code executes Self::into_raw(b) on the generic Box<T, A>.=20

Would it be better for the comment to reference the actual generic type met=
hod
being called to prevent reader confusion?

> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D1
