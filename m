Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2839CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFBA10E26B;
	Sat, 20 Jun 2026 18:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cmj5HfLi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E789910E26B
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:57:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37A40601E2;
 Sat, 20 Jun 2026 18:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777631F00A3A;
 Sat, 20 Jun 2026 18:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981868;
 bh=G/XS2IWwb4Ly283F1TX0sI4qgXMXX9bLcECqVRSIfdw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cmj5HfLiHXTtnI+7PAgvtkG55U06GTp92N8OuvdZGy3FXHmvI+KaMuCWjT2zYdGWm
 lEbeuyMBUbfQ65Y3m331YyJ30wvq0lIiB90z7n7lWHardIhgx7+g7ll55zcHsi9dyi
 9N+2MaQkmuN0A9J9CoBT6RJ8hsDYuMHF5baB0HRcnOL/xsfKdUK/65FfgS5hTQOWPu
 FD583abrf8BCExifNiFEH1aHyd6nx07Qw954/RrHEtVKiqUI0Aj+hJFjTdRaNRc2Kq
 +7TVeRqNCq3fw14d0ohweuXS0MY4SD2gZFyS4UbistsOQyIO6cX6P5thvxD1TVolpE
 ZzigsxDjK4nfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/16] rust: drm: ioctl: fix unbounded lifetimes in
 ioctl handler arguments
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260620184924.2247517-2-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 18:57:48 +0000
Message-Id: <20260620185748.777631F00A3A@smtp.kernel.org>
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
- [High] The patch routes the ioctl data buffer to `__call_ioctl` as a gene=
ric void pointer, inferring the type of `Data` purely from the user-provide=
d handler closure rather than enforcing it matches the UAPI struct. This re=
moves compile-time type safety and allows an incorrect handler signature to=
 cause a silent heap out-of-bounds access.
--

commit cb52c14a04f657a72b41bd28dae4125aa6d86907
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments

This patch fixes unbounded lifetimes in declare_drm_ioctls! by routing
references through a helper function __call_ioctl tied to a local anchor
variable.

Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kernel=
.org/

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index cf328101dde4e..023e6da5c1e4b 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -70,6 +70,39 @@ pub mod internal {

[ ... ]

> +    pub unsafe fn __call_ioctl<
> +        'a,
> +        Dev: 'a,
> +        Data: 'a,
> +        F: super::super::file::DriverFile + 'a,
> +        Ret,
> +    >(
> +        _anchor: &'a (),
> +        dev: &'a Dev,
> +        raw_data: *mut ::core::ffi::c_void,
> +        raw_file: *mut drm_file,
> +        f: impl FnOnce(&'a Dev, &'a mut Data, &'a super::super::File<F>)=
 -> Ret,
> +    ) -> Ret {
> +        // SAFETY: Caller guarantees raw_data points to a valid instance=
 of Data with the correct
> +        // size and alignment, exclusively owned for the duration of the=
 ioctl call.
> +        let data =3D unsafe { &mut *(raw_data.cast::<Data>()) };

[Severity: High]
Does this type inference break the macro's memory safety guarantees?

Because Data is a generic type parameter and isn't explicitly specified, the
Rust compiler will infer it from the signature of the handler function. If a
driver author mistakenly writes an ioctl handler that takes a differently
sized or larger UAPI struct, Data will be inferred as that larger type.

Since raw_data points to a kernel buffer of size _IOC_SIZE(cmd) matching the
original macro struct, dereferencing it as a larger type would create a
reference that extends past the end of the allocated memory, leading to a
silent heap out-of-bounds access.

> +        // SAFETY: Caller guarantees raw_file is a valid pointer to a `s=
truct drm_file`.
> +        let file =3D unsafe { super::super::File::<F>::from_raw(raw_file=
) };
> +        f(dev, data, file)
> +    }
>  }
> =20
>  /// Declare the DRM ioctls for a driver.

[ ... ]

> @@ -135,19 +168,19 @@ macro_rules! declare_drm_ioctls {
> -                            let data =3D unsafe { &mut *(raw_data.cast::=
<$crate::uapi::$struct>()) };
> -                            // SAFETY: This is just the DRM file structu=
re
> -                            let file =3D unsafe { $crate::drm::File::fro=
m_raw(raw_file) };
> -
> -                            match $func(dev, data, file) {
> +                            let __anchor =3D ();
> +
> +                            // SAFETY:
> +                            // - The ioctl argument has size `_IOC_SIZE(=
cmd)`, which we asserted
> +                            //   above matches the size of this type, an=
d all bit patterns of UAPI
> +                            //   structs must be valid. The argument is =
exclusively owned by this
> +                            //   handler, guaranteed by `drm_ioctl()` to=
 remain valid for the
> +                            //   duration of the call.
> +                            // - `raw_file` is a valid `struct drm_file`=
 pointer provided by the
> +                            //   DRM core.
> +                            match unsafe { $crate::drm::ioctl::internal:=
:__call_ioctl(
> +                                &__anchor, dev, raw_data, raw_file, $fun=
c,
> +                            ) } {

[Severity: High]
Is there a way to enforce the UAPI $struct type here?

Prior to this patch, declare_drm_ioctls! explicitly cast raw_data to the
declared UAPI struct, which forced a compile-time error if the user-provided
handler expected a different type.

By passing the handler function directly to __call_ioctl without constraini=
ng
the Data type to $crate::uapi::$struct, the compile-time type safety checki=
ng
appears to be bypassed, allowing the inference issue described above.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D1
