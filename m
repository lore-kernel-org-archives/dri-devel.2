Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B134C5CFDB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BD910E457;
	Wed, 12 Aug 2026 19:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1La/WXy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D8F10E457
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:56:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCEBE40033;
 Wed, 12 Aug 2026 19:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529001F000E9;
 Wed, 12 Aug 2026 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786564604;
 bh=Lj46nO8gk4wR4wgDl7pdJxE9rj4hp6cnYU03iloW+ss=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D1La/WXySOc6Gpt+tp5Rjzh2Xya7NIWle1vQPIhc0OZyV18uos3E1Q52DJBGgCFuL
 hjul1w7hFR6cPOwMgcUKJeWspV/gW2579A+3+Y0jjoF9xWZNSSLLkydTEWPUpiIXkv
 qqZJJ6N3HHdL7wAonIXM7qyPeLc7yRN6l0POgiJc9K9wlcIYcyTI2+S8guWDtAJdWe
 d0rMEkE/y3GGs+hzbQaE/dcC2Ds0V/4kjUyxH5gBgkDQ8MZB+wTTsjv4YbJYSS1A1g
 4Mi5eXZIFQCgOb05zgHaGLEVfU2AyJo6L7Qv6psK8G3LCd4ChA/o33ufk1i6VBTMoY
 Uz5S17AtCImug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/5] rust: pci: make Vendor::from_raw() public
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260812-b4-rust-pci-edu-driver-v3-3-5d0b5594e52b@mailbox.org>
References: <20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org>
 <20260812-b4-rust-pci-edu-driver-v3-3-5d0b5594e52b@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 19:56:43 +0000
Message-Id: <20260812195644.529001F000E9@smtp.kernel.org>
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

> `Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be
> obtained through the named constants generated from the
> `PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore
> cannot match a device whose vendor ID has no symbolic name.
>=20
> Such devices exist. QEMU's "edu" educational device and the legacy
> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
> `pci_ids.h`. Per the policy stated at the top of that header, IDs are
> only added there when shared between multiple drivers; a single-driver
> ID is expected to be open-coded in the driver instead. C drivers already
> do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare
> ".vendor =3D 0x1234".
>=20
> The Rust abstraction has no equivalent escape hatch: there is no public
> way to express an unregistered vendor. Make `Vendor::from_raw()` public
> (and const, so it can be used in the const device-ID tables built by
> `pci_device_table!`) so that drivers can construct a Vendor from a raw
> ID, matching what C drivers can already do.
>=20
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-b4-rust-pc=
i-edu-driver-v3-0-5d0b5594e52b@mailbox.org?part=3D3

