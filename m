Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16627CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8224A10E1F3;
	Fri, 22 May 2026 10:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nXG6ZvjM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3097910E1F3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:14:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3EB2760136;
 Fri, 22 May 2026 10:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5601F000E9;
 Fri, 22 May 2026 10:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779444892;
 bh=+eWdPqbw9hijCK3kUnucObPuKy2/QFassSDTi9MvW1w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nXG6ZvjMkL4RnuznluSVfMxziUgYDGWEo/8JJIuAyvynQ9L4UP3As0XhSQn9oz5VY
 OlTRs9/rmRISvVCOnTxwZK2r3Fm81kDDf0f3wG58me5MIw+eyTDIMyOyO/GHGdO0w7
 HYylR9uWY2Vy+gvLx++GoZLYPzz7Vto7Ujxrxfwg=
Date: Fri, 22 May 2026 12:14:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org,
 viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com,
 markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, igor.korotin@linux.dev,
 daniel.almeida@collabora.com, pcolberg@redhat.com,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 00/27] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Message-ID: <2026052242-geranium-disfigure-cfaf@gregkh>
References: <20260521233501.1191842-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
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

On Fri, May 22, 2026 at 01:34:26AM +0200, Danilo Krummrich wrote:
> Currently, Rust device drivers access device resources such as PCI BAR mappings
> and I/O memory regions through Devres<T>.
> 
> Devres::access() provides zero-overhead access by taking a &Device<Bound>
> reference as proof that the device is still bound. Since a &Device<Bound> is
> available in almost all contexts by design, Devres is mostly a type-system level
> proof that the resource is valid, but it can also be used from scopes without
> this guarantee through its try_access() accessor.
> 
> This works well in general, but has a few limitations:
> 
>   - Every access to a device resource goes through Devres::access(), which
>     despite zero cost, adds boilerplate to every access site.
> 
>   - Destructors do not receive a &Device<Bound>, so they must use try_access(),
>     which can fail. In practice the access succeeds if teardown ordering is
>     correct, but the type system can't express this, forcing drivers to handle a
>     failure path that should never be taken.
> 
>   - Sharing a resource across components (e.g. passing a BAR to a sub-component)
>     requires Arc<Devres<T>>.
> 
>   - Device references must be stored as ARef<Device> rather than plain &Device
>     borrows.
> 
> These limitations stem from the driver's bus device private data being 'static
> -- the driver struct cannot borrow from the device reference it receives in
> probe(), even though it structurally cannot outlive the device binding.
> 
> This series introduces Higher-Ranked Lifetime Types (HRT) for Rust device
> drivers. An HRT is a type that is generic over a lifetime -- it does not have a
> fixed lifetime, but can be instantiated with any lifetime chosen by the caller.
> 
> Bus driver traits use a Generic Associated Type (GAT) type Data<'bound> to
> introduce the lifetime on the private data, rather than parameterizing the
> Driver trait itself. This avoids a driver trait global lifetime and avoids the
> need for ForLt for bus device private data, making the bus implementations much
> simpler. ForLt is only needed for auxiliary registration data, where the
> lifetime is not introduced by a trait callback but must be threaded through
> Registration.
> 
> With HRT, driver structs carry a lifetime parameter tied to the device binding
> scope -- the interval of a bus device being bound to a driver. Device resources
> like pci::Bar<'bound> and IoMem<'bound> are handed out with this lifetime, so
> the compiler enforces at build time that they do not escape the binding scope.
> 
> Before:
> 
> 	struct MyDriver {
> 	    pdev: ARef<pci::Device>,
> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
> 	}
> 
> 	let io = self.bar.access(dev)?;
> 	io.read32(OFFSET);
> 
> After:
> 
> 	struct MyDriver<'bound> {
> 	    pdev: &'bound pci::Device,
> 	    bar: pci::Bar<'bound, BAR_SIZE>,
> 	}
> 
> 	self.bar.read32(OFFSET);
> 
> Lifetime-parameterized device resources can be put into a Devres at any point
> via Bar::into_devres() / IoMem::into_devres(), providing the exact same
> semantics as before. This is useful for resources shared across subsystem
> boundaries where revocation is needed.
> 
> This also synergizes with the upcoming self-referential initialization support
> in pin-init, which allows one field of the driver struct to borrow another
> during initialization without unsafe code.
> 
> The same pattern is applied to auxiliary device registration data as a first
> example beyond bus device private data. Registration<F: ForLt> can hold
> lifetime-parameterized data tied to the parent driver's binding scope. Since the
> auxiliary bus guarantees that the parent remains bound while the auxiliary
> device is registered, the registration data can safely borrow the parent's
> device resources.
> 
> More generally, binding resource lifetimes to a registration scope applies to
> every registration that is scoped to a driver binding -- auxiliary devices,
> class devices, IRQ handlers, workqueues.
> 
> A follow-up series extends this to class device registrations, starting with
> DRM, so that class device callbacks (IOCTLs, etc.) can safely access device
> resources through the separate registration data bound to the registration's
> lifetime without Devres indirection.
> 
> The series contains a few driver patches for reference, indicated by the REF
> suffix.
> 
> Thanks to Gary for coming up with the ForLt implementation; thanks to Alice for
> the early discussions around lifetime-parameterized private data that helped
> shape the direction of this work.

Looks nice!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
