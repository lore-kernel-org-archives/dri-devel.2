Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F129BCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:07:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5692010F5A9;
	Fri, 26 Jun 2026 12:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BEIRRi6J";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3925010F5A9
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:07:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 154CE4388E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DAB1F000E9;
 Fri, 26 Jun 2026 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782475630;
 bh=ppjgt+FXUa/Fw0EA5nU9+z5Wr4fLZ76N/w51kvSjYxI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BEIRRi6JApGaVMdkrpeErFC0eXmVIGx2JHrKWoAoKplgsv8QTFDmVM7tVBhYt0fJH
 XzJnNvWLAz/JOrDu4JhbnDzcOdp8T1NPQ30NtmPCJup1ECrMgJ/acXWA7eJq+p2W1m
 Wy3T8bQkU9Tlm57CfTyvw1kBKlnt6UQV7JjfAlJWIaKT6ZA5hIkMfPErzo8lIC/+qn
 v8juTac1hTBhhmtFcET4P8VnDZvSmsSzG5YSVoqkj7E4L4r+xqw5WTVknrOMMeO2GY
 kQhhbbjzJVByzdPmeGdwEAwHPIBLvVzUPtLfAHJ/yHjYiOxniRA7+sOJ7qxUeJAHh/
 2Q0YMqZDzg/Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:07:08 +0000
Message-Id: <20260626120709.A8DAB1F000E9@smtp.kernel.org>
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
- [Low] Use of `kernel::` instead of `crate::` for intra-crate imports and =
paths.
--

commit 5d83778cf519ec33130e7eef0e627d3e0a92700a
Author: Andreas Hindborg <a.hindborg@kernel.org>

rust: implement ForeignOwnable for Owned

This commit implements ForeignOwnable for Owned<T>, which allows it to be
used in places such as the XArray.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index 7fe9ec3e55126..93a5dfcc1e6f5 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -15,6 +15,8 @@
>      ptr::NonNull, //
>  };
> =20
> +use kernel::types::ForeignOwnable;

[Severity: Low]
This isn't a bug, but should this import use crate::types::ForeignOwnable
instead of kernel::types::ForeignOwnable for an intra-crate reference?

[ ... ]

> +    #[inline]
> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {

[Severity: Low]
This is also a minor style detail, but is there a reason to use kernel::
instead of crate:: for the c_void path here?

Would it be better to use crate::ffi::c_void for the return type, as well
as for the ptr arguments in from_foreign(), borrow(), and borrow_mut() belo=
w?

> +        Owned::into_raw(self).as_ptr().cast()
> +    }
> +
> +    #[inline]
> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
> +        // SAFETY: By function safety contract, `ptr` came from `into_fo=
reign` and cannot be null.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D3
