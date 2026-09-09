Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9107C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA6E10EF73;
	Wed,  9 Sep 2026 06:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hfDHutVc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47FC010EF6C
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:56:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 289C740944;
 Wed,  9 Sep 2026 06:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9BF1F00A3A;
 Wed,  9 Sep 2026 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788937003;
 bh=//c2JdLZmTskYDr27rgcJwyc4UOZMl4+6G1By36h2/Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hfDHutVct0KAX1cwsDLgUD9wkHomep9C4XNCwKKvaSTIGSqF8FfGhJ0b5FI26N1oA
 DGeoGd1m7mrigubt4k5hDbqqNT0LVwS8VC0rtwq4LiajnojjtkZGeYICGFiKSgiI1m
 k6ZFEFC3JuSd6hV0DoUmY8Rn5+LCA2/FB5iuxXr4Lkmoy/S2w9Ql18WAFwY9r0JO3x
 rl1DdXCT27c9eC3GHWvp3dHFbWYRITZwd1ZbFTf6lfUikBHC4KtOc9hzIxf1l2Ni/W
 5FaeeA2cf9cRlDUNGFV5JwIZ/OfEzJ+xXbmqVRzpC0eMsdIid5vaD5RF34/3y4bBJC
 67E8G1lCQRbFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 06/13] rust: uaccess: add
 UserSliceWriter::write_truncated()
To: "Alistair Popple" <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, gary@garyguo.net, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260909064506.910162-7-apopple@nvidia.com>
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260909064506.910162-7-apopple@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:56:42 +0000
Message-Id: <20260909065642.AA9BF1F00A3A@smtp.kernel.org>
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
- [Low] The small abstraction function `write_truncated` is missing the `#[=
inline]` attribute.
--

commit e02911d12d3fe66c588f96439e4940e145b90f1e
Author: Alistair Popple <apopple@nvidia.com>

rust: uaccess: add UserSliceWriter::write_truncated()

This commit adds a new write_truncated() helper to UserSliceWriter that
writes as much of an AsBytes value as fits in the remaining userspace
buffer. It avoids requiring callers to manually truncate values for
versioned UAPIs.

> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 5f6c4d7a1a516..c63b919426315 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -624,6 +624,20 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Re=
sult {
>          self.length -=3D len;
>          Ok(())
>      }
> +
> +    /// Writes as much of the provided value as fits in the remaining bu=
ffer.
> +    ///
> +    /// Copies `min(size_of::<T>(), self.len())` bytes to userspace. Ret=
urns the number of bytes
> +    /// actually written. This is useful for versioned structs where an =
older userspace may provide
> +    /// a smaller buffer than the current kernel struct.
> +    ///
> +    /// Fails with [`EFAULT`] if the write happens on a bad address. Thi=
s call may modify the
> +    /// associated userspace slice even if it returns an error.
> +    pub fn write_truncated<T: AsBytes>(&mut self, value: &T) -> Result<u=
size> {

[Severity: Low]
This isn't a bug, but should this abstraction function include the #[inline]
attribute?=20

According to the Rust subsystem guidelines, small functions in abstractions
like the kernel crate should be annotated with #[inline] to allow the
compiler to optimally inline them across crate boundaries.

> +        let len =3D self.length.min(size_of::<T>());
> +        self.write_slice(&value.as_bytes()[..len])?;
> +        Ok(len)
> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064506.9101=
62-1-apopple@nvidia.com?part=3D6
