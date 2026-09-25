Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C26C98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EB310E1D1;
	Fri, 25 Sep 2026 16:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SEwbo7cX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9363D10E1D1;
 Fri, 25 Sep 2026 16:18:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60522405E3;
 Fri, 25 Sep 2026 16:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F291F000FF;
 Fri, 25 Sep 2026 16:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790353130;
 bh=l/EOOpDu4elY4P01g5S2YkynazluBd403L+RfYMQhwo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=SEwbo7cXvF1KP4D12i+jVO7huonQJAN9xrzNS1ajCI/rho+UaundCECyF365FdpXa
 jRrnIQ5XC/cPoeRRtKO45vD4u654RFa15zYojBxizMS9NYAVoVS8net1tp/C8bWd1p
 77mYQMCZaCRaUtrThDMcAb+lKRwAnrxNrPXgk9yrnTnePoEUnxxPHvHvjIrvf588BV
 s/O6ihHWYRXG5chrAtqKDuZAfMt30Lr2sKIrPxhiapmYXlRyL5uY+nmIzoDbCqzFSV
 0NE+b4jI6+QFzNoMTTtiRipHO3R/jHS4dZmmxV99e5nowIBYVfdJxdSCpWWtlIWXA6
 viN395m7A+Hhw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 18:18:46 +0200
Message-Id: <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
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
In-Reply-To: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
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

On Fri Sep 25, 2026 at 3:33 PM CEST, Thomas Hellstr=C3=B6m wrote:
> Driver and shared DRM helper code is increasingly relying on bare
> drm_device references (drm_dev_get()/drm_dev_put()) to keep a device's
> software state around, without also pairing that with a reference on
> the owning kernel module. Xe itself does this in several places, and
> so does drm_gpuvm for the lifetime of a GPU VM. None of these
> references currently prevent the owning module from being unloaded
> while they, or the teardown work they can still trigger, are
> outstanding, meaning driver code can end up executing after its own
> module's text has already been freed.

Since you mention DRM GPUVM in a couple of places, how can this ever happen=
? It
wouldn't make sense to keep a VM alive beyond driver unbind. I.e. it can't =
make
its drm_device reference count reach module unload in the first place.

Besides that, can you please remind me whether there are any other reasons =
than
the release() callback why a DRM device must not outlive module unload?

I don't think the correct solution is to constrain module unload. The relea=
se()
callback shouldn't really do anything other than free the memory of the
drm_device allocation. All other resources a driver may have should be rele=
ased
on driver unbind.

There may be shared resources, such as e.g. a common workqueue, but those a=
re
module level things that have nothing to do with the DRM device.

I am aware that a few drivers implement release(), but TBH it looks pretty
broken. qxl_drm_release() is a great example, and it already calls it out
itself.

> This series closes that gap for xe:
>
> - Patch 1 adds core DRM infrastructure allowing a driver to wait for
>   its outstanding device-release callbacks to finish before
>   proceeding with module unload.

Please see above; I also wonder why Xe cares in the first place. Xe doesn't
implement release(), no?

> - Patch 2 makes xe use this infrastructure to hold up module unload
>   until every xe_device instance has actually been released, rather
>   than only until the module's own refcount happens to reach zero,
>   with a diagnostic if this ends up taking an unexpectedly long time.
>
> - Patch 3 fixes a related, previously unprotected case where the
>   teardown of a GPU VM or its address space mappings can be deferred
>   to run at an arbitrary later time, including after module unload has
>   already completed.

Huh? GPUVM tracks the GPU's VA space mappings, but after driver unbind ther=
e's
no access to the GPU to manage anything anymore. How can this even work?

Thanks,
Danilo
