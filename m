Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A76606A32E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVxPIqn+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267DA10FFB3;
	Wed,  4 Nov 2026 23:14:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D5C10FFA0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:14:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 58F8D4328A;
 Wed,  4 Nov 2026 23:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF9A1F000C1;
 Wed,  4 Nov 2026 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793834067;
 bh=Vie7/XBwPUSIruM6K3Am8aeBNqqM1hC+6rhracHSbGY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TVxPIqn+AhEz5ydNwmugzcs/6BDfj5mZusM+Zvl5bpqoYfO0Z6vfTQLvtasnZLNG1
 kGdlbFGB/8WJPneRrS2rN3M9cXPYYZOo54G7eGbviYzsd3rS4/LL6jRDmE38ijciLi
 uKkdJ1qwHlsw4cJbZ3OSpXWVWninwEqkgs31n0gLB4ijjwegAK84GH/Wd9g2vhz5PV
 tCNUTGnsvE6nFx8837pbO1yP3yHE2LBs3I2I9YG0a4jF9T8GbBZfBWi4igzqx6Qrzl
 yddXtP2lSPwQkYu7Txoa2OWXMINNfUUbYClHrYLSlPQuyu9LvGi3sEc/Y1HmaDPWOf
 OsnJjklzbWGbg==
Message-ID: <sashiko-outbox-198281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] rust: pci: rework device enabling API
To: "Maurice Hieronymus" <mhi@mailbox.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>,
 =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, 
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "Lyude
 Paul" <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, linux-pci@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-2-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-2-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:14:25 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: missing #[inline] on DeviceEnableGuard::drop()
--

commit 74e19693f9a2d2ce6a2ed986dc5fdc9a88535014
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: pci: rework device enabling API

This commit replaces Device::enable_device_mem() with
Device::enable_device(), returning a DeviceEnableGuard<'a> that calls
pci_disable_device() on drop to keep the PCI device enable count balanced.
It also updates the nova-core driver to store the guard in NovaCore.

Link: https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@ker=
nel.org

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 769d01d234296..75efd5c5ee97f 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -469,6 +469,25 @@ pub fn pci_class(&self) -> Class {
>      }
>  }
> =20
> +/// A guard that keeps the device's I/O and memory resources enabled.
> +///
> +/// # Invariants
> +///
> +/// The device's enable count was incremented once for this guard; dropp=
ing the guard decrements
> +/// it again.
> +#[must_use =3D "if unused, the device will be immediately disabled"]
> +pub struct DeviceEnableGuard<'a> {
> +    dev: &'a Device<device::Bound>,
> +}
> +
> +impl Drop for DeviceEnableGuard<'_> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`, and by the type
> +        // invariant this guard holds one increment of the device's enab=
le count.
> +        unsafe { bindings::pci_disable_device(self.dev.as_raw()) };
> +    }
> +}

[Severity: Low]
This isn't a bug, but since DeviceEnableGuard::drop() in rust/kernel/pci.rs
is a small non-generic abstraction method in the kernel crate that forwards
directly to bindings::pci_disable_device() when a DeviceEnableGuard is
dropped on driver unbind or probe error unwind, should it be marked with
#[inline] to allow cross-crate inlining into drivers (matching
Device::enable_device() below and IrqVectorRegistration::drop() in
rust/kernel/pci/irq.rs)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D2
