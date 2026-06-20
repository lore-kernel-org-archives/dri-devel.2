Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D3ECD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE1E10E270;
	Sat, 20 Jun 2026 19:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o2k7DTkT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A56C410E270
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D2F8601E1;
 Sat, 20 Jun 2026 19:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E021F000E9;
 Sat, 20 Jun 2026 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982087;
 bh=M4cZrRZipZ64Zj+8igbsv5yMbtrwG08sm/mtN+mJWoo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=o2k7DTkTKxZ0HsAhvbpYkiqGCEoHtmKJ69pjwyCUY0C1PfxKwyQKcIJyNIrj2VBQP
 7BZkJDEy0JqP3NMBOX9Azh0HWE689Ir7b9W4dkUoThnqIjcAuwQ1ab6p5+2S9ISgub
 wN3ILbNK3pVXoy1U9LvDebXQLSAKnoGKZw/tv0cbdn93MEAGRd4lRFckjEP6uyKeQh
 2djswGl4CY/Yfv32bBmUfYytQuhPCKchPbxGg8TefQuNr4tlWMiftGvBQ1wfgGau2d
 2BE1dDLenJhAyuAZTtzWdZElwOcpwHjQER1zWpWThyGSuTeo2KVvAbFhe56kdzYuYA
 cONegabsS8xOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/16] rust: drm: return ParentDevice from Device AsRef
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org
In-Reply-To: <20260620184924.2247517-13-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-13-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:01:27 +0000
Message-Id: <20260620190127.88E021F000E9@smtp.kernel.org>
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
- [Low] Safety comment relies on an undocumented type invariant regarding t=
he parent device.
--

commit b94604b443e7e44bdf48a3790177f869613bf287
Author: Danilo Krummrich <dakr@kernel.org>
rust: drm: return ParentDevice from Device AsRef

This commit changes the AsRef implementation for drm::Device to return
a reference to the typed parent bus device rather than the raw base device.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index c32cc0f0eba03..45bacd7b227f0 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs

[ ... ]

> @@ -450,11 +450,15 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>      }
>  }
> =20
> -impl<T: drm::Driver, C: DeviceContext> AsRef<device::Device> for Device<=
T, C> {
> -    fn as_ref(&self) -> &device::Device {
> +impl<T: drm::Driver> AsRef<T::ParentDevice<device::Normal>> for Device<T=
> {
> +    fn as_ref(&self) -> &T::ParentDevice<device::Normal> {
>          // SAFETY: `bindings::drm_device::dev` is valid as long as the D=
RM device itself is valid,
>          // which is guaranteed by the type invariant.
> -        unsafe { device::Device::from_raw((*self.as_raw()).dev) }
> +        let dev =3D unsafe { device::Device::from_raw((*self.as_raw()).d=
ev) };
> +
> +        // SAFETY: By the type invariant of `Device`, the parent device =
is embedded in
> +        // `T::ParentDevice`.
> +        unsafe { device::AsBusDevice::from_device(dev) }

[Severity: Low]
This isn't a bug, but the SAFETY comment references a type invariant of
Device that doesn't appear to be documented.

Looking at the # Invariants section for the Device struct, it only states
that self.dev is a valid instance of a struct device, its data layout
remains the same across contexts, and context invariants apply.

Should the # Invariants section of Device be updated to explicitly state
that the parent device is embedded in T::ParentDevice to properly support
this safety proof?

>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D12
