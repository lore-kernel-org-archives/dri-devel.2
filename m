Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DC5C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 10:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640028825B;
	Sun, 28 Jun 2026 10:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d0WIkhQi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE3610E0C2
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 10:14:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 77ADF6001D;
 Sun, 28 Jun 2026 10:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29EC1F000E9;
 Sun, 28 Jun 2026 10:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782641648;
 bh=Uq2uDvPhJDtgq3rP59hSeLR14Qtx2QYFNGSyZ8FixPo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d0WIkhQibFgJolyOH++upFHMDLtx0UCSTHyePZR3d/GCItPHWTE40DbIiOdbee959
 yfRjxHGHz15J9c21LZkI2irNveY8C3hDWCE/SfBysubb3XEpgczqCM92gS7gWVwK9l
 yleQ9osPY+H7L0nO59ANha43BpGX2hucv7cC/NQkXjM2lVbotzrMBjkDhNpmOglVjm
 n3ox1gNrT74E3c3/ve14rBJkePSBsdrnF/CDGzWOzMTxlvBI6rGfZpCyIUZRyMsNMR
 pcY6yNLDmGsH9CNhVRTEFcXBwSzqVd0gdTraW+FyQMPhyCY6gliotjEp5NxnZcM0lB
 LqqFYoUg7t8Pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: "Trevor Chan" <trev@trevrosa.dev>
Cc: ojeda@kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>
References: <20260628100731.64885-1-trev@trevrosa.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 10:14:07 +0000
Message-Id: <20260628101407.D29EC1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] `I2cAdapter::inc_ref` calls `i2c_get_adapter()` which sleeps and c=
an fail, leading to sleep-in-atomic panics and Use-After-Free.
--

commit dcdb7e5879ef4f6a18646d7f509abd59ae6f10db
Author: Trevor Chan <trev@trevrosa.dev>

rust: aref: make AlwaysRefCounted::inc_ref an associated function

This commit changes the AlwaysRefCounted::inc_ref trait method to be an
associated function rather than taking a self reference. This prevents
accidental calls to inc_ref on types that implement it, and updates all
implementors across various kernel subsystems to match the new signature.

Link: https://github.com/Rust-for-Linux/linux/issues/1177

[ ... ]

> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 624b971ca8b0b..1a9882a64c4b8 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -425,9 +425,9 @@ pub fn get(index: i32) -> Result<ARef<Self>> {
> =20
>  // SAFETY: Instances of `I2cAdapter` are always reference-counted.
>  unsafe impl AlwaysRefCounted for I2cAdapter {
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> -        unsafe { bindings::i2c_get_adapter(self.index()) };
> +        unsafe { bindings::i2c_get_adapter(obj.index()) };

[Severity: High]
This isn't a bug introduced by this patch, but is it safe for
I2cAdapter::inc_ref to call i2c_get_adapter here?

Since i2c_get_adapter acquires a mutex (core_lock), won't cloning an
ARef<I2cAdapter> in an atomic context (such as under a spinlock) trigger
a sleep-in-atomic panic?

Additionally, does this code handle the case where i2c_get_adapter fails?
If the adapter has been unregistered (e.g., the device is hot-unplugged or
the driver unbound) while the ARef is still held, the IDR lookup fails and
i2c_get_adapter returns NULL.

Because this return value is ignored in inc_ref, the underlying device
and module refcounts wouldn't actually be incremented. When the cloned ARef
is subsequently dropped, dec_ref will unconditionally decrement the
refcounts, which could underflow and cause a use-after-free while other
ARef instances still point to it.

>      }
> =20
>      unsafe fn dec_ref(obj: NonNull<Self>) {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628100731.6488=
5-1-trev@trevrosa.dev?part=3D1
