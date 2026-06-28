Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9F1C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA85510E63C;
	Sun, 28 Jun 2026 15:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GJxGawxY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B28710E63C
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:13:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 12D196001D;
 Sun, 28 Jun 2026 15:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C76C1F000E9;
 Sun, 28 Jun 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659597;
 bh=fzeGJEZil/zMvFXR71RXCAe/rqpuI04o9q4ehAIXbBw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GJxGawxYF/SiBZ9hXUeJjWn2Omh+PuWUaocArBw3x3wdvd9b0hYNsFLOp6lMln8a1
 OiOhAYE888ziJsR3W7JvLIfQC5mClDrOIemsSi9ytVUHMud78V1js+XdQdynEM0ZQE
 U5DuOh+YEBIdhE2Y30ltrc1496AX21FOvv00YbFOicn29ax88POe8wqYoSeb59/xcX
 m8PcQdV/G7q+HpcG3AAbfKgR3fftw9lA3GCEaV8Tbg0yn1TsQMN/O99+m6mLxaRwv1
 VDrmnXkX5iv4ESjtyuvi6UKLjoaVkwMLZAMSdbLpXG9gIa492s/UdEY01QNscgtdlx
 Vxy2PYLwH1Kxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/19] rust: drm: Pass registration data to ioctl
 handlers
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260628145406.2107056-19-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-19-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:13:17 +0000
Message-Id: <20260628151317.7C76C1F000E9@smtp.kernel.org>
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
- [Critical] Unsound lifetime shortening of the associated type `Registrati=
onData<'a>` allows safe code to cause a use-after-free.
--

commit b0c6a9cfef59ba2cf3ed097deb2601fbd756cc0d
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Pass registration data to ioctl handlers
   =20
This commit updates the DRM ioctl macro to pass registration data to the io=
ctl
handlers using a closure-based HRTB pattern.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index f24cf7b146a8e..9b45b741db1b9 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs

[ ... ]

> @@ -193,7 +195,9 @@ macro_rules! declare_drm_ioctls {
>                              // SAFETY: This is just the DRM file structu=
re
>                              let file =3D unsafe { $crate::drm::File::fro=
m_raw(raw_file) };
> =20
> -                            match $func(&*guard, data, file) {
> +                            match guard.registration_data_with(|reg_data=
| {
> +                                $func(&*guard, reg_data, data, file)
> +                            }) {
=20
[Severity: Critical]
Does this HRTB closure pattern safely handle invariant types for
RegistrationData<'a>?

The commit message states that the HRTB ties the lifetime to the closure sc=
ope
and the internal pointer cast shortens it from 'static. However, if a driver
uses an invariant type for RegistrationData<'a> (for example, something like
Mutex<Option<&'a mut SomeStruct>>), couldn't this allow safe code to store =
the
short-lived `data` or `file` reference into the underlying 'static
registration data?

While the HRTB prevents references from returning out of the closure, it
might not prevent storing external, longer-lived references into an invaria=
nt
type provided by the closure. Once the ioctl returns and the local variable=
 is
dropped, the 'static registration data could still hold a dangling pointer =
to
it, potentially leading to a use-after-free.

>                                  Err(e) =3D> e.to_errno(),
>                                  Ok(i) =3D> i.try_into()
>                                              .unwrap_or($crate::error::co=
de::ERANGE.to_errno()),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D18
