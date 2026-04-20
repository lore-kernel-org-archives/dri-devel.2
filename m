Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E8FF557F4
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:29:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3231510E484;
	Mon, 20 Apr 2026 09:29:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hXpQbZ40";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2944A10E484
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776677343; x=1808213343;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=IOIIi6BpyEQxc8UGvmrUSxbmwGNgl1HgV0zF2Gewvfk=;
 b=hXpQbZ40sOK2E+OjW7BoCvV2wALgZ4SnjcMQbrtLcfqNd+sLl9tQ05xG
 yBprDWrl/cLdAKsSS/1VAyW8UA8/2HCV/mNHd1eAlYKWIIqYmuschQggw
 JLdJp9tiJoeGN5AnKzDj5TZX5KYjjxNFLQdBKvWtDwNLm/zw1AktTVqkg
 ngywDmi4TOkJsmiTnuAmGBS2+fO/2N8SWlqZdO3TFImx9vNyYR3VwjErx
 HNkq2IC+VADjx4lCatIIf17dcHaDTRi3vYotdjWDYMdwNwGZXQqZyVA0p
 zMDVY6xJ8VNWdHZQKdph6rpt35bGULXDej/Z/krTEdia0chP5bmyBzkFj w==;
X-CSE-ConnectionGUID: EY/9Kn6RQLSvgO+OLD5qrA==
X-CSE-MsgGUID: lgSMBD7HQ8Gf1Gj+/m6YhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81460454"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="81460454"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 02:29:03 -0700
X-CSE-ConnectionGUID: 7pHbgv0DRyKnv1FRobpATw==
X-CSE-MsgGUID: 2XYOGYhESaeTRvXTn5ORDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="227041892"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.133])
 ([10.245.244.133])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 02:29:00 -0700
Message-ID: <215f305ff04ddf8a426871e895aaf520b02e89bf.camel@linux.intel.com>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 11:28:48 +0200
In-Reply-To: <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
 <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
 <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Fri, 2026-04-17 at 21:33 +0200, Danilo Krummrich wrote:
> On Fri Apr 17, 2026 at 4:41 PM CEST, Thomas Hellstr=C3=B6m wrote:
> > This is problematic since typically you also need a module
> > reference
> > when taking a drm device reference.
> >=20
> > The reason for this is that the devres reference on the drm device
> > expects to be the last one, since it might be called from the
> > module
> > exit function of the driver.
>=20
> No, this is not how it works; if this would be true then drmm_* would
> be pretty
> pointless in the first place, as one could just use devm_* for
> everything.
>=20
> Citing the commit introducing drmm_* APIs:
>=20
> 	"The biggest wrong pattern is that developers use devm_,
> which ties the
> 	release action to the underlying struct device, whereas all
> the
> 	userspace visible stuff attached to a drm_device can long
> outlive that
> 	one (e.g. after a hotunplug while userspace has open files
> and mmap'ed
> 	buffers)."

Yeah, I was a bit unclear and partly incorrect. This only happens *if
there are no other holders of the driver module reference. (But see
below WRT potential other holders)-

driver_module_unload()->...->pci_dev_remove -> devm_release->
drm_dev_put-><module is unloaded>.

So if, at this point there are additional drm device references,
they'd point to dangling devices.

>=20
> > Now if there is an additional reference held at that point the
> > driver module
> > can be unloaded with a dangling reference to the drm device.
> >=20
> > On the other hand, if you in addition take a module reference then
> > that
> > blocks the driver module from being unloaded while held, just like
> > a
> > drm file reference. This leads to complicated module release
> > schemes
> > like the one in drm_pagemap where the module refcount is released
> > from
> > a work item that is waited on in the drm_pagemap exit function.
> >=20
> > I'm working to lift the module refcount requirement, but meanwhile
> > I'd
> > recommend that in the file close callback, we'd make sure all
> > drm_gpuvms have called their drm_gpuvm_free() function, because
> > then we
> > are sure that the drm_device is still alive and the module still
> > pinned.
>=20
> If GPUVM has a pointer to the DRM device, it implies shared ownership
> and hence
> GPUVM should account for this shared ownership and take a reference
> count.
>=20
> The fact that GPUVM must not outlive module unload when it has driver
> callbacks
> attached is an orthogonal requirement.
>=20
> The module lifetime / callback issue is a separate problem that
> exists
> regardless of whether you hold a device refcount. Not taking the
> refcount
> doesn't make the module problem go away, it just adds a second,
> independent bug.
>=20
> If struct drm_device itself, e.g. due to drm_dev_release() requires a
> module
> refcount, then this is on struct drm_device to ensure this constraint
> (or remove
> the requirement).
>=20
> IOW, if I get to choose between a DRM component that has a pointer to
> a DRM
> device stalls module unload and a DRM component that has a pointer to
> a DRM
> device oopses the kernel when used wrongly, I prefer the former.

I agree with your reasoning here, but current fact is that most (if not
all) holders of a drm device reference (files, pagemaps, dma-bufs)
currently also hold a module reference to protect against this, and
drm_gpuvm would be an outlier.

To fix this properly (lifting that requirement) one could introduce a
drm device count in the module and have the module exit function wait
for it to become zero, *and* that the code that did the last decrement
finished executing.

https://patchwork.freedesktop.org/patch/712146/?series=3D163298&rev=3D1

Or one could also have the drm device hold a reference count on the
driver module, but that would block unloading without previous unbind
which is not typical driver behaviour and would likely be seen as a
regression.

/Thomas







>=20
> - Danilo
