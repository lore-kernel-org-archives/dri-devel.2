Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EA2FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA1810E987;
	Mon, 27 Apr 2026 22:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jq/7jo+a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6C010E987
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:15:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A7E2060121;
 Mon, 27 Apr 2026 22:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8302C19425;
 Mon, 27 Apr 2026 22:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777328099;
 bh=jKCbYSmsGSQtb8z472IdJt0wtsbMXXU4FOygbGFvB9I=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=jq/7jo+ayvGw9P4xqGszsECHGAmSYk/Y0GbzMSiOfaNV1f520wAdrEOggaW5pJisY
 ZzXAJW4LCoyAOzIO5JJp+aqLFu6tXyS0jUXNiB1kXczf20busfVnrRv80JeUDTOLDC
 lM6YQCmUnSoH8VwyS3iHhc1/ysFWsLE6qI7rVNBG5grV42DMTMlm10RcfKeSQvQpU3
 2F5b6mpX+vSdBI3GNqXygFOjJyHHoOebj9vr3XlMOWFPCQ6+Ri03GqQx5IEihteT74
 kZhAUWer7UwyImNSJy3aSGFmICbze7ulG38PpUIN/DDKwOVVfBHHkRfyziFEpxWNjT
 izJEtsuA85SMA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 00:14:54 +0200
Message-Id: <DI4A86QOY8BW.10B14POU8D2XA@kernel.org>
Subject: Re: [PATCH 0/2] rust: auxiliary: replace drvdata() with
 registration data
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221002.2143861-1-dakr@kernel.org>
In-Reply-To: <20260427221002.2143861-1-dakr@kernel.org>
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

On Tue Apr 28, 2026 at 12:09 AM CEST, Danilo Krummrich wrote:
> When drvdata() was introduced in commit 6f61a2637abe ("rust: device: intr=
oduce
> Device::drvdata()"), its commit message already noted that a direct acces=
sor to
> the driver's bus device private data is not commonly required -- bus call=
backs
> provide access through &self, and other entry points (IRQs, workqueues, I=
OCTLs,
> etc.) carry their own private data.
>
> The sole motivation for drvdata() was inter-driver interaction, e.g. a pa=
rent
> driver deriving its bus device private data from the child driver via the
> auxiliary bus.
>
> However, drvdata() exposes the driver's bus device private data beyond th=
e
> driver's own scope. This creates ordering constraints -- drvdata may not =
be set
> yet when the first caller of drvdata() can appear -- and forces the drive=
r's bus
> device private data to outlive all registrations that access it; a requir=
ement
> that causes unnecessary complications.
>
> Private data should be private to the entity that issues it; bus device p=
rivate
> data belongs to bus callbacks, class device private data to class callbac=
ks, IRQ
> private data to the IRQ handler, etc.
>
> This series replaces drvdata() with a dedicated registration_data pointer=
 on
> struct auxiliary_device. The parent stores its private data explicitly du=
ring
> registration; the data is private to the registration and lives as long a=
s the
> Registration object.
>
> On teardown, Registration::drop() first triggers auxiliary_device_delete(=
)
> (unbinding the child), then frees the registration data. Ordering constra=
ints
> are structural -- the child's lifecycle is scoped to the registration by
> construction, not by convention.
>
> With no remaining use case for drvdata(), drvdata(), match_type_id(),
> set_type_id() and struct driver_type are removed.
>
> This is a prerequisite for [1], which builds on the removal of drvdata() =
to
> enable Higher-Ranked Lifetime Types (HRT) for Rust device drivers.
>
> [1] Posted as a reply to this series.

https://lore.kernel.org/driver-core/20260427221155.2144848-1-dakr@kernel.or=
g/

>
> Danilo Krummrich (2):
>   rust: auxiliary: add registration data to auxiliary devices
>   rust: driver core: remove drvdata() and driver_type
>
>  drivers/base/base.h                   |  16 --
>  drivers/gpu/nova-core/driver.rs       |  10 +-
>  include/linux/auxiliary_bus.h         |   4 +
>  rust/kernel/auxiliary.rs              | 208 ++++++++++++++++++--------
>  rust/kernel/device.rs                 |  60 --------
>  samples/rust/rust_driver_auxiliary.rs |  40 +++--
>  6 files changed, 180 insertions(+), 158 deletions(-)
>
>
> base-commit: a7cc262a11354ab104b8e55c21200d099d141bc7
> --=20
> 2.54.0

