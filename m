Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5145EC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FD910EC74;
	Tue, 30 Jun 2026 12:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="brljn1eC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F133D10EC5C
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 12:40:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D657F43F23;
 Tue, 30 Jun 2026 12:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2281F00A3A;
 Tue, 30 Jun 2026 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782823221;
 bh=o/9CMvHy5knN9q2s+eDnWZgo8nVwDSb8fRgIcBA1kL4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=brljn1eCSKnTLR7lA66U3D+P/mcfwfnk5r08rZNtM/BE6wt39RQpGqO3m74DOohJu
 Y5AsKwRzHf6WewncNP+GblW6WcDCU+44UtLKOs4MWRUWdGT9XwIsHDynUzya58tbsW
 Een59qj7l5Gg/AzW8ivmzpNfOIt+d46pv+Xu4Bl6lUnAo1NJDQDOs8EteJMOX6fZjR
 m9oG7HSY5iuO8XHOZL4tkqJQ7MIbuiCypz4HyZZfNnRNpUvbDgSR7XEEgFAe/mUVzS
 USizrum3mHFYrakd8Pje13+ltayE9fiRJoQoiVuc7BhbdM+MBx+qIu2mdwvGbLYz5o
 q2B0fvszEZacA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] rust: driver: remove open-coded matching logic
To: "Gary Guo" <gary@garyguo.net>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 "Danilo Krummrich" <dakr@kernel.org>, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260629-id_info-v2-9-56fccbe9c5ef@garyguo.net>
References: <20260629-id_info-v2-0-56fccbe9c5ef@garyguo.net>
 <20260629-id_info-v2-9-56fccbe9c5ef@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 12:40:20 +0000
Message-Id: <20260630124021.3E2281F00A3A@smtp.kernel.org>
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
- [High] Data race and NULL pointer dereference due to lockless access of `=
dev->driver` in `Adapter::id_info`.
--

commit 228e0cfe9ec1514c36d9085e1b3070934920f9ab
Author: Gary Guo <gary@garyguo.net>

rust: driver: remove open-coded matching logic

This commit replaces the open-coded ACPI and OF matching logic in the Rust
driver abstractions with a single call to device_get_match_data(). It remov=
es
the acpi_of_match_device() helper and updates the Adapter::id_info() functi=
on
to use the C API directly.

> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 824899d76fed2..c9c74c4dde8fa 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs

[ ... ]

> @@ -325,117 +304,23 @@ pub trait Adapter {
[ ... ]
> -    fn id_info(dev: &device::Device) -> Option<&'static Self::IdInfo> {
[ ... ]
> +    /// Returns the driver's private data from the matching entry of any=
 of the ID tables, if any.
> +    ///
> +    /// If this returns `None`, it means that there is no match in any o=
f the ID tables directly
> +    /// associated with a [`device::Device`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the `dev` matched data is of type `S=
elf::IdInfo`.
> +    #[inline]
> +    unsafe fn id_info(dev: &device::Device) -> Option<&'static Self::IdI=
nfo> {
> +        // SAFETY: `dev` is guaranteed to be valid while it's alive, and=
 so is `dev.as_raw()`.
> +        let data =3D unsafe { bindings::device_get_match_data(dev.as_raw=
()) };

[Severity: High]
Does this introduce a potential NULL pointer dereference if dev->driver is
not set?=20

Previously, id_info() performed a table lookup that did not depend on the
device being bound to a driver. By switching to device_get_match_data(), the
underlying C implementations (such as of_device_get_match_data() or
acpi_device_get_match_data()) will unconditionally dereference dev->driver.

If a Rust driver calls Adapter::id_info() on a device::Device that is not
currently bound (for example, from a concurrent sysfs attribute or a
workqueue), could this lead to a panic?=20

Should this lifecycle precondition (that the device must be bound to a driv=
er)
be explicitly documented in the # Safety contract to prevent unsoundness, or
should we ensure dev->driver is valid before calling this function?

> +
> +        // SAFETY: Per safety requirement, `data` is of type `Self::IdIn=
fo`.
> +        unsafe { data.cast::<Self::IdInfo>().as_ref() }
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-id_info-v2=
-0-56fccbe9c5ef@garyguo.net?part=3D9
