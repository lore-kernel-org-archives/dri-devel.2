Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F44C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE8710ED40;
	Fri, 14 Aug 2026 23:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EW+FNqX6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A948810ED40
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:22:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4859A432CA;
 Fri, 14 Aug 2026 23:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C081F000E9;
 Fri, 14 Aug 2026 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786749752;
 bh=V3iAkika8Vxpxtn/hvoHmba54ys+dfaaTeYZGL5vwO4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EW+FNqX6cAvXQpLXiH8OwTaBsh1suqdCg82en5ATp4APMmB94Nf2yn9WQkspKeI/x
 1256Erl3NOzE7FPGzgTVduwP7GxQdsM+72A+hRuZPHJ+E24/9SjRIK8AVs1UVcN/83
 bngO++7L7X2oTaRvkiM0L5gDcKakCKbvY8lasmB7rxW5UJOO4HHqv+0YjFvbHhR73T
 IzcD1SZMp/yN0mvcGQni/uPQhNNAOPYTwZ/7xAKWm0dmg9T3RLDN5i21EwtiD9Qz/D
 dQm1FZWpkoPF/3a7pQlsuH9nNL8UBdXpp9Qux+trCi2HNBTI5wMyvLqrDlwD1OHX4I
 nGRsG+aOeTeHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] rust: drm: move file_operations from gem to device
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260814230923.1292966-4-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:22:31 +0000
Message-Id: <20260814232231.D3C081F000E9@smtp.kernel.org>
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
- [High] Missing module reference counting allows driver unload while files=
 are open, leading to Use-After-Free
--

--- Patch [3]: [PATCH 3/7] rust: drm: move file_operations from gem to devi=
ce ---
commit b811d43b7a27d7b6e1655586be106750c9eefba2
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: move file_operations from gem to device

Move the file_operations definition from drm::gem::create_fops() into
UnregisteredDevice in drm::device. This is the file_operations of the
DRM minor device, set through the drm_driver struct. It is not specific
to GEM.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index be83287fe161d..a2940e172073a 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -195,10 +195,28 @@ const fn compute_features() -> u32 {
>          driver_features: Self::compute_features(),
>          ioctls: T::IOCTLS.as_ptr(),
>          num_ioctls: T::IOCTLS.len() as i32,
> -        fops: &Self::GEM_FOPS,
> +        fops: &Self::FOPS,
>      };
> =20
> -    const GEM_FOPS: bindings::file_operations =3D drm::gem::create_fops(=
);
> +    const FOPS: bindings::file_operations =3D {
> +        let mut fops: bindings::file_operations =3D pin_init::zeroed();
> +
> +        fops.owner =3D core::ptr::null_mut();

[Severity: High]
This is a pre-existing issue, but does setting fops.owner to null_mut()
allow the driver module to be unloaded while file descriptors remain open?

If fops.owner is null, fops_get() in drm_stub_open() won't increment the
driver module's reference count. A user could open the DRM device node,
the module could be unloaded via rmmod (unmapping its .rodata section
where FOPS resides), and subsequent ioctl or close operations would
dereference filp->f_op into unmapped memory, causing a panic.

Should this be updated to use the Rust equivalent of THIS_MODULE
instead of null_mut() to ensure VFS module reference counting works
correctly?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814230923.1292=
966-1-dakr@kernel.org?part=3D3
