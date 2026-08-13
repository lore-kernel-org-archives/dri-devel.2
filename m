Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F549C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658D610F190;
	Thu, 13 Aug 2026 07:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IeY+OdxM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9CAE10F1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 04D594077B;
 Thu, 13 Aug 2026 07:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA91F000E9;
 Thu, 13 Aug 2026 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786606807;
 bh=tdnH2aMs5ivF0TTfsTacmzPMPMyv9Bcd3eavdVCL1PU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IeY+OdxM7hPlEbYwckI1xy66hxQinWJsjFq2MCWYXgW9P9p3A015w4ddt9puQcv4v
 s/9q4A30Y41nnZtRtNAGRj7B6ORMBwI8CrdSgv22ezocmOtKppTT30hJtl6rGzNMk0
 j1d+gGPdZgOwi6/bBgf5W3A5wM1RMnCVBokTf6thvbd1+TPMWLEF7Mn1VKrLYUPBfq
 7H+ktM+h8ApEVSSGhZokmlyF+gvl5h9b4d2FbpuKSiE1OD038KUwZbJZS/m2FBk3T8
 7KiDyYZr3pWBkDpeNEVRcRQthxlF3Wzwktx+jGGcYF/5+Fs7yRzn5KXtC5S43wW7VW
 qzy2wZYDSSqYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] rust: id_pool: take a NonZero capacity in
 with_capacity
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260813-chid-v6-5-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
 <20260813-chid-v6-5-160be5dfb5bd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 07:40:07 +0000
Message-Id: <20260813074007.AEEA91F000E9@smtp.kernel.org>
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
- [Low] The new imports in the documentation tests violate the kernel verti=
cal import style.
--

--- Patch [5]: [PATCH v6 5/7] rust: id_pool: take a NonZero capacity in wit=
h_capacity ---
commit e9e2e8ccc28f355c2c0d256d428875b948d75705
Author: Eliot Courtney <ecourtney@nvidia.com>

rust: id_pool: take a NonZero capacity in with_capacity

This commit updates IdPool::with_capacity to take a NonZero capacity,
as an IdPool should not be allocated with zero capacity.

> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -29,10 +29,11 @@
>  /// Basic usage
>  ///
>  /// ```
> +/// use core::num::NonZero;
>  /// use kernel::alloc::AllocError;

[Severity: Low]
This isn't a bug, but should there be a blank line between the core:: and
kernel:: imports to follow the kernel vertical import style?

>  /// use kernel::id_pool::{IdPool, UnusedId};
>  ///
> -/// let mut pool =3D IdPool::with_capacity(64, GFP_KERNEL)?;
> +/// let mut pool =3D IdPool::with_capacity(NonZero::new(64).unwrap(), GF=
P_KERNEL)?;

[ ... ]

> @@ -138,6 +139,7 @@ pub fn capacity(&self) -> usize {
>  /// # Examples
>  ///
>  /// ```
> +/// use core::num::NonZero;
>  /// use kernel::{

[Severity: Low]
This isn't a bug, but could we add a blank line here as well to separate the
core imports from the kernel imports?

>  ///     alloc::AllocError,
>  ///     bitmap::BitmapVec,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-chid-v6-0-=
160be5dfb5bd@nvidia.com?part=3D5
