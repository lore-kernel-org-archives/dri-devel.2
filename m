Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA304C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 09:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6C910E108;
	Sun, 28 Jun 2026 09:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mHWv3cbL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9098810E108
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 09:58:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4EF2600AA;
 Sun, 28 Jun 2026 09:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6A31F000E9;
 Sun, 28 Jun 2026 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782640693;
 bh=fqMJ2EPU/Ez5u8ULLm+sZ7KU78PXEkLQmaq7v9EFlCQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mHWv3cbLcPNecs6TcOtIbt20zdFFybsa6STuxGqf8JnFcafmjVLpW6oLfsGwzsfUn
 ry5JJpZlm0skYEIG4PaE2ilK/FD7gD//poSxACkKpQHn2M4ETc29Qu0c/zY+syr0bX
 F//ZT1LBmmyDU2EVKujPqcQUQhP9UI1N3cnni+/WJ/+UfgU/qnDnwSfZPpEwwuulCx
 +PUd10oO91fYDwrWCx6KwRolyWyg2vQK/6R14r7iqhAyr3U2PAkE8xuOrF+TPj3bji
 C3Ft9qZ4J7JxL0U4LG5/5p5Gu+B+bkXBTIqp9I7VbJ+OEssjNxAHRxe3xSxPIysnLx
 rRrQ2mqGvBgvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: "Trevor Chan" <trev@trevrosa.dev>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260628095132.47753-1-trev@trevrosa.dev>
References: <20260628095132.47753-1-trev@trevrosa.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 09:58:12 +0000
Message-Id: <20260628095813.2D6A31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `inc_ref` function body for `Chip<T>` still uses the undefined =
`self` identifier instead of the new `obj` parameter.
- [Low] Safety comments in multiple files still reference `self` instead of=
 the renamed `obj` parameter.
--

commit 26c2b1b363c343fdcaf27bbc75d1dde6b5b4dbfc
Author: Trevor Chan <trev@trevrosa.dev>

rust: aref: make AlwaysRefCounted::inc_ref an associated function

This commit changes inc_ref from a method to an associated function to
prevent accidental calls. All implementors of AlwaysRefCounted are
updated to reflect this change.

Link: https://github.com/Rust-for-Linux/linux/issues/1177

> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index 4764d7b68f2a7..c955cbd884b8b 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -57,9 +57,9 @@ unsafe impl Sync for Mm {}
>  // SAFETY: By the type invariants, this type is always refcounted.
>  unsafe impl AlwaysRefCounted for Mm {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The pointer is valid since self is a reference.
> -        unsafe { bindings::mmgrab(self.as_raw()) };
> +        unsafe { bindings::mmgrab(obj.as_raw()) };

[Severity: Low]
This isn't a bug, but should the SAFETY comment be updated to say "since
obj is a reference" instead of "self"?

[ ... ]

> diff --git a/rust/kernel/pwm.rs b/rust/kernel/pwm.rs
> index 6c9d667009ef7..c95b442a972e6 100644
> --- a/rust/kernel/pwm.rs
> +++ b/rust/kernel/pwm.rs
> @@ -631,7 +631,7 @@ pub fn new<'a>(
>  // SAFETY: Implements refcounting for `Chip` using the embedded `struct =
device`.
>  unsafe impl<T: PwmOps> AlwaysRefCounted for Chip<T> {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: `self.0.get()` points to a valid `pwm_chip` because `=
self` exists.
>          // The embedded `dev` is valid. `get_device` increments its refc=
ount.
>          unsafe { bindings::get_device(&raw mut (*self.0.get()).dev) };

[Severity: Low]
Will this cause a compilation error? The function parameter was renamed
to obj, but the function body still references self in self.0.get().

This isn't a bug on its own, but should the SAFETY comment also be
updated to reference obj instead of self?

[ ... ]

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 7aff0c82d0afc..c039059c18913 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -393,11 +393,11 @@ fn as_ref(&self) -> &Device {
> =20
>  // SAFETY: Instances of `Interface` are always reference-counted.
>  unsafe impl AlwaysRefCounted for Interface {
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The invariants of `Interface` guarantee that `self.as=
_raw()`
>          // returns a valid `struct usb_interface` pointer, for which we =
will
>          // acquire a new refcount.
> -        unsafe { bindings::usb_get_intf(self.as_raw()) };
> +        unsafe { bindings::usb_get_intf(obj.as_raw()) };

[Severity: Low]
This isn't a bug, but should the SAFETY comment here also be updated to
reference obj.as_raw() instead of self.as_raw()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628095132.4775=
3-1-trev@trevrosa.dev?part=3D1
