Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDC5C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B43A10E394;
	Thu,  2 Jul 2026 21:47:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YxFTIjT0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8444510E394
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 21:47:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D17CA436B9;
 Thu,  2 Jul 2026 21:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED501F000E9;
 Thu,  2 Jul 2026 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783028833;
 bh=KT5HdsNfDV/GF6jjLE9pPi+2j+UMB4nG5h2CmRBqWMo=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=YxFTIjT0Owbu7L6cLqITHQ3wj+b1b7kmmi1DGamwmMCBXFIJhjUUU1pJaym7fFb4D
 aT9lsziOwhoBrCXO4M/hIe5S4uLx6MEzltbv7WL0fITNQr3XFD1h33YryHjapOCCgU
 5gxBqgp398u8cTy4abPLdXPR1EKKEAqgGRCAVEzcplvjZ/nmtlooxVI5w+TVaHQm/B
 fbpDhUYCdHQOAXByoz1UDdYCRcz844a3i9M91z+CxR7Xe7zgpl+OOriZP4SubAfVQC
 +eXP+3YaXf5VX6F9OtN8RipaKCYNy/iLT1poUHpbTk06wFbFS9uywdgqNrCahLGBM/
 eXSF8a0yDvAcQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Jul 2026 23:47:07 +0200
Message-Id: <DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org>
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pci: rework device enabling API
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Beata Michalska"
 <beata.michalska@arm.com>
References: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>
In-Reply-To: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

(Cc: Beata, runtime PM consideration at the end)

On Thu Jul 2, 2026 at 11:32 AM CEST, Maurice Hieronymus wrote:
> - `enable_device_managed()`, wrapping `pcim_enable_device()`, which
>   registers a `pci_disable_device()` cleanup that runs on unbind; this
>   is what drivers should normally call in `probe()`.

The concern pointed out by Sashiko that pcim_enable_device() silently also =
sets
pdev->is_managed =3D true, which also influences the behavior of other unma=
nged
PCI paths is valid.

Of course, we could easily overcome this if we have to, but on second thoug=
ht I
think it would be nice to just not have the managed version at all.

(Note that I also have a patch in my queue to convert IrqVectorRegistration=
 to
use lifetimes instead of Devres, which will also address the topic in [1].)

The advantage of not having to store another object in the bus device priva=
te
data is minor, and a lifetime annotated guard is the more idiomatic solutio=
n
anyway.

	pub struct DeviceEnableGuard<'a> {
	    dev: &'a pci::Device<Bound>,
	}

Note that obtaining this guard would still require a &Device<Core>, but dro=
pping
it can only be ensured from a bound scope, which &'a pci::Device<Bound> ens=
ures.

This is the tricky part, as this would imply that pci_disable_device() can =
be
called concurrently with another DeviceEnableGuard being acquired and
concurrently with pci_set_master() and pci_clear_master(), etc., which give=
n the
current implementation on the C side would be UB.

It would be interesting to dig into this and see if we can find a solution =
to
this problem (which might also include improvements on the C side).

For instance, struct pci_dev has a C bitfield that also includes the
is_busmaster field, which can race with all the other bits being accessed i=
n the
same bitfield.

I think (most of) the fields should be in the same locking domain (the devi=
ce
lock, which is held in bus callbacks and in Rust represented by the Core de=
vice
context state).

But there might already be issues with this, e.g. it seems to me that
block_cfg_access is protected through a different locking domain, the same =
goes
for a few other fields I think.

Bjorn, any insights on this?

(We had a similar C bitfield in the driver core, which we recently replaced=
 by
using bitops, as there were subtle race conditions.)

> - an unmanaged `enable_device()`/`disable_device()` pair, wrapping
>   `pci_enable_device()`/`pci_disable_device()`, e.g. for runtime PM
>   paths.

If we could find a solution to the above, we could probably avoid having "r=
aw"
accessors that can potentially lead to an unbalanced enable count and inste=
ad
could consider something like a DeviceDisableGuard<'a> which could be deriv=
ed
from a DeviceEnableGuard<'a> for the duration of a suspend.

The runtime PM Rust infrastructure could provide a storage container which
lifetime wise spans suspend =3D> resume, where this guard (and other data t=
hat
must be restored on resume) could be stored.

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/top=
ic/Re-configuring.20interrupt.20vectors/with/577596401
