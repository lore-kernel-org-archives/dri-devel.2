Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58369CA5FEC
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 14:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F91010E0E2;
	Sat,  3 Oct 2026 14:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bif7+x+D";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490DF10E0D7;
 Sat,  3 Oct 2026 14:08:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 010F6433BF;
 Sat,  3 Oct 2026 14:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C81F0089C;
 Sat,  3 Oct 2026 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791036517;
 bh=qEHnNgHl6Utuo0Yg67pBnePzE8jinMcZX2WPmLe8Mro=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=bif7+x+DqzNjs2X7CY/CPmtejxOgzW0Ng0gidGTZK5352SXDhtUoniF3Qxm+3XIFO
 c5raHqQ36dZLbY2OLh2FNuKt0N4aE6Z3th+3vkZIUoObG0mEwPnPGhtpEpkIh/j7Yi
 tWoaencFLhM7gNE4qTYmYj009CzKk7bz5+4pxJp6WuTiOjfqIqnpHXN32CRZYVwmsB
 5iFDr1uarqAMjJFaZ6IUmSjiUPYsu62hlAhRRrkWVKL6zLnGhITkYTrM9hNm/ywPvM
 2+jRvdRnUhMQF1PhUtOzT1pg/JI6RlTh9t+rgwpjyyRa7yTN5OabrmvdyExXWz4GHc
 wEASpzmYEtLgA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 16:08:34 +0200
Message-Id: <DLV9GFX4NNUB.153H8Q8R27VVW@kernel.org>
Subject: Re: [PATCH v3 0/3] drm, drm/xe: Protect against premature module
 unloads
Cc: <intel-xe@lists.freedesktop.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Matthew Auld" <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
 <7fc614d0b666fb5ae9777c29ea2e79647030b198.camel@linux.intel.com>
 <DLQVBJX4PK5G.2AK3E5K8U8UY7@kernel.org>
 <fdbc3d2ed7b23b09216df023e2be9ed707820c75.camel@linux.intel.com>
 <DLQYY4O71Q54.2FZ1ZV8G5ZZPN@kernel.org>
 <3389776905c6ef2c20b2b3dd78041ea5db638a96.camel@linux.intel.com>
In-Reply-To: <3389776905c6ef2c20b2b3dd78041ea5db638a96.camel@linux.intel.com>
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

On Mon Sep 28, 2026 at 3:37 PM CEST, Thomas Hellstr=C3=B6m wrote:
> It doesn't have to in a model where all users are removed before the
> drm device is freed. Following your argument, shouldn't that drm_device
> reference should also be accompanied by a module reference? Except that
> will block rmmod?

Yes, if we establish that a DRM device must outlive a GPUVM (which by conve=
ntion
we implicitly do by storing a pointer) then you don't need a reference coun=
t.

However, there's nothing that ensures the caller sticks to the convention. =
And
given that the DRM device is reference counted already, taking the referenc=
e
count is the correct thing to do.

(As a side note, in Rust you can actually model and enforce this lifetime
relationship at compile time without a reference count. You can even establ=
ish
more granular lifetime relationships. For instance, you could have:

	struct GpuVm<'a> {
		drm: &'a drm::Device<Registered>,
	}

and establish that a GPUVM can only ever live as long as the DRM device is
registered and therefore implicitly also establish that the GPUVM can't out=
live
driver unbind, as a DRM device can't be registered beyond driver unbind and
hence the lifetime 'a is guaranteed to end before driver unbind.

In C you can only establish this by convention, and at least take the refer=
ence
count.)

The module reference seems orthogonal though, GPUVM is not actively emittin=
g
calls into anything (unlike a workqueue for instance), it's a passive data
structure. So, there's no need for any defensive measure AFAICS.

> Without knowing for sure, I think this was the route taken with
> hotplugging.

Sure, both approaches are there to cover hotplugging. Almost all class devi=
ce
implementations have to consider hotplugging as it is depends on the bus th=
e
physical device sits on whether hot(un)plug can happen.

> But isn't essentially what you describe a design where we release all
> dma_buf, file- and drm_pagemap references of struct drm_device at
> module_unload time. That would replace their references with SRCU
> protecting the drm_device pointer, falling back to a stub behaviour
> when unbind has been called. So the "Can I access hardware?" would be
> replaced by a "Can I access the DRM device?".

I think the question is not "Can I access the DRM device?", the question is=
 "Is
the DRM device still registered?", or IOW, "Is the DRM device still backed =
by a
driver?".

There's a bounded lifetime when a driver is allowed to operated a device, w=
hich
is between probe and remove. This is (typically) the same scope as the clas=
s
device (e.g. DRM) is registered.

After the driver is unbound from it's (physical) bus device, there's no val=
ue
anymore in letting the driver operate the class device (which is exactly wh=
at
register() / unregister() describes) in the first place.

There's nothing hardware specific left at this point, so it is not a driver=
 job
anymore; the lifetime decoupling can be at subsystem / component level (e.g=
. DMA
fence).

> That's an interesting idea, but would probably need careful work so
> fence waits etc. doesn't block the SRCU read sections. And ofc to avoid
> user-space regressing.

For the fence waits specifically, this can (or should) never happen. Driver
fences must be signaled on driver unbind. The hardware is gone at this poin=
t,
there's nothing left that could signal them otherwise.

> FWIW, IIRC that SRCU is only strictly needed when non-driver code
> (pagemap, files and dma-buf) drops the last drm_device reference
> without having a module reference. And there is no such code (yet)
> AFAIK, so I can drop that patch to when we think it's necessary and we
> have other driver buy-ins.

I think those components should do the lifetime decoupling work instead. On=
ce
the driver is unbound, none of the driver callbacks are "special" anymore a=
s
there's nothing hardware specific left at this point.
