Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F096C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 956A810E63A;
	Sun, 28 Jun 2026 15:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyXLDDT6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7B8510E63A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:11:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B094043780;
 Sun, 28 Jun 2026 15:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C5E1F000E9;
 Sun, 28 Jun 2026 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659506;
 bh=YeRpvIqkwwUqzked7es5DPwWyU56/gVfYyOgZUTcWgc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WyXLDDT6lqHXRKcExeJ4Zstk+PVTarjxtYV3YMDtGRYfBCFWa+qJYkvizjqtvn0Az
 WU2FmHVWjZjIXuSly4/OVu+DQShCZ9LzCTfH0OlylKE14NH3bf6eb+DJXZ9R+4tU6B
 WVNe1BSDCD7X27pEYj+h0vOQUaqldyJoUkTP5ksnQ8dsaY/FmBIPf/t+eaNksU1Gvj
 R9cV3duxE8+NDv+ZS0fi6saSuQKcII+J68GlpEYSP56TOHz/+oq0KzXpsSdMfKDLzE
 sXT1zJblBJCIHqlIJFs53uOvLXOMAeEwguKSS/rlGHYDLD4ZIZu/sVtK5z3qEmYvXc
 LSzDeJXMtNZgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/19] rust: drm: Wrap ioctl dispatch in
 RegistrationGuard
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260628145406.2107056-14-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-14-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:11:45 +0000
Message-Id: <20260628151146.51C5E1F000E9@smtp.kernel.org>
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
- [High] Wrapping the entire DRM ioctl dispatch in a RegistrationGuard hold=
s the SRCU read lock (drm_dev_enter) for the entire duration of the ioctl h=
andler, which will deadlock device hot-unplug.
--

commit e380f2be4330be05befae4edf318decdc7aa75d1
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Wrap ioctl dispatch in RegistrationGuard

This commit wraps the DRM ioctl dispatch in registration_guard() to ensure
that handlers only receive a reference to a registered device. If the device
has already been unplugged, it intercepts the call and returns -ENODEV.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 6f5a9877bdae0..f24cf7b146a8e 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
[ ... ]
> @@ -131,17 +143,44 @@ macro_rules! declare_drm_ioctls {
[ ... ]
> +                            let Some(guard) =3D dev.registration_guard()=
 else {
> +                                return $crate::error::code::ENODEV.to_er=
rno();
> +                            };
> +
>                              // SAFETY: The ioctl argument has size `_IOC=
_SIZE(cmd)`, which we
>                              // asserted above matches the size of this t=
ype, and all bit patterns of
>                              // UAPI structs must be valid.
> @@ -154,7 +193,7 @@ macro_rules! declare_drm_ioctls {
>                              // SAFETY: This is just the DRM file structu=
re
>                              let file =3D unsafe { $crate::drm::File::fro=
m_raw(raw_file) };
> =20
> -                            match $func(dev, data, file) {
> +                            match $func(&*guard, data, file) {
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Will this deadlock device hot-unplug if the ioctl handler performs an
unbounded wait?

The RegistrationGuard acquires the SRCU read lock via drm_dev_enter().
Because this guard is held across the entire execution of $func, any
unbounded wait inside the ioctl (such as waiting for a hardware fence)
will hold the SRCU read-side critical section indefinitely.

If the device is hot-unplugged during this wait, the driver's remove
callback calls drm_dev_unplug(). This blocks on synchronize_srcu()
waiting for the ioctl to drop the lock. The ioctl will remain blocked
forever because the stalled remove callback cannot force-signal the
fences, leading to a permanent hang.

>                                  Err(e) =3D> e.to_errno(),
>                                  Ok(i) =3D> i.try_into()
>                                              .unwrap_or($crate::error::co=
de::ERANGE.to_errno()),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D13
