Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77411CC6B2D
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 01:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3436112039;
	Thu, 15 Oct 2026 01:08:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C5A112039
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:08:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C256B423CA;
 Thu, 15 Oct 2026 01:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBC61F000C4;
 Thu, 15 Oct 2026 01:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792026501;
 bh=XU/ajx17kJoEEbdMt7+Yla8trLKhzXktu75oajyi1fU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cORgRdvfc2HbZ0CWsRkVjVI8xruLuNIyIQYbwdHjM4uNTigduXO98aOdnkBsqjB2c
 jJQDk+NhqYU8P3NJ1o2KBaKK7ydI3y5Cyvqen/+gd/4AyWknicLfkD1XWfNol13xAv
 s5KI+VrVZBvqKxyKBtZhO5waqk5f3+GYzDifbfL7RtrfC/CO9rtEle7vwHHlQRpRSl
 zeNu40MVQARo2eCZ1I6cT5jKj8jW4P7m1zsVBnzpqhVLtJUo3H1YUv9AUmFSxngExV
 fOdc1WgxR1u0K1obWdHL0UIW6r6O5bQCzCi7MN4oABF/mWQCaH99nEqCiq/+5znIHM
 q8afybRtVDwHg==
Message-ID: <sashiko-outbox-172076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rust: uaccess: add UserSliceWriter::clear()
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261014-b4-dev_query_fixes-v1-1-92043100b472@collabora.com>
References: <20261014-b4-dev_query_fixes-v1-0-92043100b472@collabora.com>
 <20261014-b4-dev_query_fixes-v1-1-92043100b472@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:08:21 +0000
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
- [Low] rust: uaccess: UserSliceWriter::clear() missing #[inline] attribute
--

commit 3db28db591b863b3412fb9ace61521aee539bc5a
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

rust: uaccess: add UserSliceWriter::clear()

This commit adds a clear() method to UserSliceWriter to zero out the remain=
ing
buffer in userspace, preventing uninitialized memory consumption. It also
introduces a rust_helper_clear_user() wrapper for the architecturally defin=
ed
clear_user() C function so it can be called from Rust.

> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index f1aecda7a90ce..6838e7f90abb5 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
[ ... ]
> @@ -638,6 +638,29 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Re=
sult {
>      pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<u=
size> {
>          self.write_slice_partial(value.as_bytes(), 0)
>      }
> +
> +    /// Zeros remaining bytes in the userspace buffer.
> +    ///
> +    /// Fails with [`EFAULT`] if the userspace memory cannot be cleared.
> +    pub fn clear(&mut self) -> Result {

[Severity: Low]
This isn't a bug, but should this method be marked with the #[inline]
attribute? Small wrapper functions in abstractions that primarily forward to
C bindings (like bindings::clear_user in this case) typically include the
#[inline] annotation as recommended by the Rust subsystem coding guidelines.

> +        let len =3D self.length;
> +
> +        if len =3D=3D 0 {
> +            return Ok(());
> +        }
> +        // SAFETY: `clear_user` checks the userspace address and range a=
nd handles
> +        // faults when accessing userspace memory
> +        let res =3D unsafe { bindings::clear_user(self.ptr.as_mut_ptr(),=
 len) };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-dev_que=
ry_fixes-v1-0-92043100b472@collabora.com?part=3D1
