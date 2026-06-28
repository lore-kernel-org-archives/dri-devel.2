Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE1DC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4A5710E632;
	Sun, 28 Jun 2026 15:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dzs47Aa6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C25910E632
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:05:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 74E286001D;
 Sun, 28 Jun 2026 15:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95701F000E9;
 Sun, 28 Jun 2026 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659142;
 bh=jFk3MRgbXpEyygOUtJ07x58OP9ay5zLOBg04Vbvat6o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dzs47Aa6R5D2pUKn5ptuN0zKYErpki7F3GThbiMRT35mfiW95GEgQbE/KeGYP8ESx
 evGtl2DrnMRUYICJuVViUMILBZPBuBo9pE+AX31AHkq08tbXoHyOd+ipCf/fc02L2G
 BidoNzsJzZ5v0Aqd61WhI1Ifc3wRFKENyXrbHen3tHyRRZHm994HFRNcT40ms6pf6A
 UgiHpAlNK2qECNOyNTZ7XekXsC5c8e07h7fnQV+UZueqNnR0XuPdZ+uElZEvgk00JR
 JAfIIpPL5Jlexk+eJrR2DpZBMwrEYjR31nZWmhh2z05UUVLa+53Ce6DBo1wUQnYEvu
 LWD9arSw6FRJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/19] rust: faux: add Device type with AsBusDevice
 support
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260628145406.2107056-4-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:05:41 +0000
Message-Id: <20260628150541.E95701F000E9@smtp.kernel.org>
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
- [Low] Missing standard bus device infrastructure for `faux::Device` (`Alw=
aysRefCounted`, `Send`, `Sync`, `impl_device_context_deref!`, `impl_device_=
context_into_aref!`).
--

commit e85bef2071c929034918bb94467777aee21de70f
Author: Danilo Krummrich <dakr@kernel.org>

rust: faux: add Device type with AsBusDevice support

This commit introduces a faux::Device type wrapping struct faux_device and
implements AsBusDevice for it. This allows faux devices to be used as parent
devices for subsystems that require a bus device like DRM.

> diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
> index 36c92ae2943c0..cd0724af446be 100644
> --- a/rust/kernel/faux.rs
> +++ b/rust/kernel/faux.rs

[ ... ]

> +/// A faux device.
> +///
> +/// A faux device is a virtual device backed by the faux bus, primarily =
used for scenarios where a
> +/// real hardware device is not available or for testing.
> +///
> +/// # Invariants
> +///
> +/// The underlying `struct faux_device` is valid and the embedded `struc=
t device` is initialized.
> +#[repr(transparent)]
> +pub struct Device<Ctx: device::DeviceContext =3D device::Normal>(
> +    Opaque<bindings::faux_device>,
> +    PhantomData<Ctx>,
> +);

[Severity: Low]
Is faux::Device missing the standard bus device infrastructure here?

Since it wraps Opaque (which is neither Send nor Sync by default), should
this type explicitly implement Send and Sync so that it can be safely shared
across threads?

Additionally, to fully participate in the standard device context and
reference counting hierarchy, should this also implement AlwaysRefCounted a=
nd
use the standard device macros (impl_device_context_deref! and
impl_device_context_into_aref!)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D3
