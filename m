Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E19DF8DFFF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 19:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D38110E060;
	Fri, 17 Apr 2026 19:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Su+q52wJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FBC10E060
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 19:33:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A7C542A29;
 Fri, 17 Apr 2026 19:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9EFC19425;
 Fri, 17 Apr 2026 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776454415;
 bh=Tet6Rc0AhaKkw8kMLWsoQjdQnxj3YjRwWwPskMIq3JY=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=Su+q52wJqo2+rXOC5N0b1r4a1DbMbTVYqSwexy/I4fQeH83jmRh1t+GKAJvVKXwo4
 1Lr2FHz0K0lTlfO/+6vz2ILRbxQ/lkATLAvTfah8iUdNOsyHqlm2qt+kAPhTO2b6D/
 nqvQAhAHahizFnTJC59zCeLXjVnk1HLekeokGYQ1NIrELLwyyMYZ28o1iB6c9nCkFr
 W1E32YTxRe8PGuYbh/KxumPENhEMXHoKJqCFWYu1orlN9sFQrV8sNXN2ex49RnJq04
 QOHjNfveTr/CoR/AP9wlAU2hrZr2d33qE5LeB+FZU4qRnYe1APa5w11DPliBmNAHC3
 mm5WZ/4Y9SOyw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 21:33:31 +0200
Message-Id: <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
 <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
In-Reply-To: <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
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

On Fri Apr 17, 2026 at 4:41 PM CEST, Thomas Hellstr=C3=B6m wrote:
> This is problematic since typically you also need a module reference
> when taking a drm device reference.
>
> The reason for this is that the devres reference on the drm device
> expects to be the last one, since it might be called from the module
> exit function of the driver.

No, this is not how it works; if this would be true then drmm_* would be pr=
etty
pointless in the first place, as one could just use devm_* for everything.

Citing the commit introducing drmm_* APIs:

	"The biggest wrong pattern is that developers use devm_, which ties the
	release action to the underlying struct device, whereas all the
	userspace visible stuff attached to a drm_device can long outlive that
	one (e.g. after a hotunplug while userspace has open files and mmap'ed
	buffers)."

> Now if there is an additional reference held at that point the driver mod=
ule
> can be unloaded with a dangling reference to the drm device.
>
> On the other hand, if you in addition take a module reference then that
> blocks the driver module from being unloaded while held, just like a
> drm file reference. This leads to complicated module release schemes
> like the one in drm_pagemap where the module refcount is released from
> a work item that is waited on in the drm_pagemap exit function.
>
> I'm working to lift the module refcount requirement, but meanwhile I'd
> recommend that in the file close callback, we'd make sure all
> drm_gpuvms have called their drm_gpuvm_free() function, because then we
> are sure that the drm_device is still alive and the module still
> pinned.

If GPUVM has a pointer to the DRM device, it implies shared ownership and h=
ence
GPUVM should account for this shared ownership and take a reference count.

The fact that GPUVM must not outlive module unload when it has driver callb=
acks
attached is an orthogonal requirement.

The module lifetime / callback issue is a separate problem that exists
regardless of whether you hold a device refcount. Not taking the refcount
doesn't make the module problem go away, it just adds a second, independent=
 bug.

If struct drm_device itself, e.g. due to drm_dev_release() requires a modul=
e
refcount, then this is on struct drm_device to ensure this constraint (or r=
emove
the requirement).

IOW, if I get to choose between a DRM component that has a pointer to a DRM
device stalls module unload and a DRM component that has a pointer to a DRM
device oopses the kernel when used wrongly, I prefer the former.

- Danilo
