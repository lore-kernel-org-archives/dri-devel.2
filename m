Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82676C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D519B10E631;
	Sun, 28 Jun 2026 15:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OtlPB8hZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E5A10E631
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:03:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DCBF6001D;
 Sun, 28 Jun 2026 15:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C131F000E9;
 Sun, 28 Jun 2026 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659024;
 bh=KCI45b/0h+Lyko/crCqha+wz1GUlyH81GE7r8E/gGRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OtlPB8hZt/bfPfkTACgJYztiAOxa3o/eV4wP8a5ZTAMXQqoj6y8dshq1NJ8NPENND
 QkyOp8OfGmjzlrN7QaCIPCM5nxzO3mzJRvVSR+GBIGB7WnWMiwrEKqkuYyQyrwZsNh
 uFIG7G2Wfp5yXTFjBGhQ0xjComXbZBXE61EqjiLoq+xTakSSpkMFSPDtDZnGenMize
 D9iaCYeoRdeRx1D/mOsBJje9Y0UCmdFTZOdmr+YzbBw8XGW86K34DMb4X4iPDD8RAb
 EGdwZ4FkF6BSR8dN6deyGZgSYyAaRTLBUy3E7SYxZTtKzwG+sdr+3Kt0t5b31Stu/S
 Abfo868JotBjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/19] rust: drm: ioctl: fix unbounded lifetimes in
 ioctl handler arguments
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org
In-Reply-To: <20260628145406.2107056-2-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:03:43 +0000
Message-Id: <20260628150343.E7C131F000E9@smtp.kernel.org>
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
- [High] The `declare_drm_ioctls!` macro is unsound because it allows type =
inference to dictate the generic `Driver` type for `Device` and `File`, ena=
bling potential cross-type downcasts (type confusion).
--

commit 541a4b9cfa288156f9ba5c6b0436d72c3dc130fe
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: ioctl: fix unbounded lifetimes in ioctl handler arguments

This commit fixes unbounded lifetimes created by unsafe pointer dereferences
in the declare_drm_ioctls! macro. It introduces a higher-ranked function
pointer coercion to ensure that handlers accept universally quantified
lifetimes, preventing them from improperly demanding static references.

Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kernel=
.org/

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index cf328101dde4e..ccf4150d83b69 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -135,6 +135,12 @@ macro_rules! declare_drm_ioctls {
>                              // dev/file match the current driver these i=
octls are being declared
>                              // for, and it's not clear how to enforce th=
is within the type system.
>                              let dev =3D $crate::drm::device::Device::fro=
m_raw(raw_dev);

[Severity: High]
This is a pre-existing issue, but does this instantiation of
Device::from_raw() leave the generic driver type parameter unbounded?

Since type inference can dictate the generic driver type for the device bas=
ed
on the handler's signature, is it possible for a handler expecting
&Device<DriverB> to be passed for an IOCTL declared in DriverA?

If that happens, type inference might instantiate Device::from_raw<DriverB>.
The DRM core would later pass a DriverA device, but the safe handler might
access it assuming DriverB's layout, potentially causing type confusion.

Is there a way to strictly bind the driver type in the macro so we prevent
potential cross-type downcasts?

> +
> +                            // Enforce that the handler accepts higher-r=
anked
> +                            // lifetimes, preventing it from requiring '=
static
> +                            // references that could escape this scope.
> +                            let _: for<'a> fn(&'a _, &'a mut _, &'a _) -=
> _ =3D $func;
> +
>                              // SAFETY: The ioctl argument has size `_IOC=
_SIZE(cmd)`, which we
>                              // asserted above matches the size of this t=
ype, and all bit patterns of
>                              // UAPI structs must be valid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D1
