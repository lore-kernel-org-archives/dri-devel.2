Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A46CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:19:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA30510EB4C;
	Tue, 23 Jun 2026 13:19:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kNZqHuXc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4892910EB4B;
 Tue, 23 Jun 2026 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782220763; x=1813756763;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=zRt4PstC5KTXFsdIS3uKUmKdUiGxXQ3iKom9s1I/IzU=;
 b=kNZqHuXcRnC9hnHHq2Z+yIGdm1xRkv5dVPO4HC+//vrNQyKjuQmDkIoI
 jCXd5JBvzFhFhz1QF3FHohAG3pqYdRCmnTC/hlWraal5hoJZqdzahtYbS
 Uy9y6SxRznlL9CEi8KTFTdm4rzuRyPXexAb4a+1zI7cD3bzENbhawdHQd
 2ypJ+xKO+pxZuIkfrxNqjY5fZc8fHt/Ux+t7ykU+W5AZTuqZziDJFnJIh
 LgZq8tyVOwu5DRuaRiaCBFHwUONXyDYvirAcSNkwe4xH8XwyGGgIuZmai
 6VNZYjw+GcQxADmggd+N8Fs8qdzH8PlotauLUhog55NSa+pHwvzSJqrPT A==;
X-CSE-ConnectionGUID: rhrLLrI5Rz6RxLLHzavRlw==
X-CSE-MsgGUID: uS2RfGsAQlqQf8mOXdjgAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83152013"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="83152013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 06:19:22 -0700
X-CSE-ConnectionGUID: xqcQ8rDJR/eOrFdlYay0YQ==
X-CSE-MsgGUID: fFcqSlpyRAWK7EdJ//qBBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="279698522"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.242])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 06:19:21 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <df9cd80e8fac232ff8d338c262f1f6613358a743.camel@intel.com>
References: <20260617152500.108597-1-jose.souza@intel.com>
 <178212422953.110786.15960772731280455512@jlahtine-mobl>
 <df9cd80e8fac232ff8d338c262f1f6613358a743.camel@intel.com>
Subject: Re: IOCTL feature detection #2 (Was: Re: [PATCH v2] drm/xe/uapi: Add
 flag to tell if VM_GET_PROPERTY_FAULTS is supported)
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "Brost, Matthew" <matthew.brost@intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>
To: "Souza, Jose" <jose.souza@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>
Date: Tue, 23 Jun 2026 16:19:17 +0300
Message-ID: <178222075755.41312.4764816601536168701@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Souza, Jose (2026-06-22 16:43:11)
> On Mon, 2026-06-22 at 13:30 +0300, Joonas Lahtinen wrote:
> > (+ Sima and dri-devel)
> >=20
> > This goes very much against the previously discussed and agreed
> > direction[1].
> >=20
> > The QUERY style IOCTL (like xe_vm_get_property_ioctl here) were
> > specifically
> > designed to have built-in feature-checking to avoid need for anything
> > like this check.
> >=20
> > Executing the query with size zero would be a pretty much no-overhead
> > call (there's one spinlock there) as we can see from the body of
> > xe_vm_get_property_helper:
> >=20
> >       if (!args->size) {
> >               args->size =3D size;
> >               return 0;
> >       }
> >=20
> > That trait got added to the QUERY style IOCTLs exactly to address the
> > requirement for low-overhead feature checking by Mesa folks back
> > then.
> >=20
> > So you execute all the validity checks, but avoid actual data
> > copying.
>=20
> There is a kernel context switch cost to consider.
> Also, because this only checks one feature, we would eventually need
> multiple uAPI calls to check all the features support.

This discussion has also been covered to the maximum in the past.

It'll hardly keep the driver simple if we are adding a more complex
multiplexer IOCTL for basically everything in order to save in CPU
context switch time.

If this becomes a measurable issue, it's better to look into something
io_uring style to allow N IOCTL to be executed in batch. There have been
prototypes and discussions around this dating years back. I don't think
anyone has yet presented the concrete measurement data that we're
actually CPU context switch bound in probing the system capabilities.

If we have such data, I'd rather we spend the time to fix it for
multiple IOCTLs at once in uring style rather than making every IOCTL
into unnecessarily complex multiplexer call.

> We could avoid this by adding a single flag to an existing query,
> allowing us to check support for all features in a single uAPI call.

This is specifically called out in the discussion in [1] as a no-no.

What the userspace thinks they are checking here based on name is if
the running kernel is new enough to have VM_GET_PROPERTY_FAULTS
property to query, and instead they get information if the running
SKU supports USM.

There's two problems with that, it will only indirectly indicate if
non-zero faults will be reported in the *current* state of the codebase.
There's no reason why USM/SVM capability of SKU would ultimately decide
if page-faults can happen. It's just how things happen to be today.

Second, there's the tendency for such uAPIs to become implicitly used
to infer different information about the SKU. So in the future, if
has_usm and faults get detangled in the codebase, we'd have to add
DRM_XE_QUERY_CONFIG_FLAG_HAS_VM_GET_PROPERTY_FAULTS_REALLY_THIS_TIME
to indicate the availability of faults. The old one would have to remain
in the current state to actually mean "DRM_XE_QUERY_CONFIG_FLAG_HAS_USM"
because changing it might break existing userspace.

I'd rather we would avoid running into same uAPI design problems that
we've struggled in the past.

> > Quoting Jos=C3=A9 Roberto de Souza (2026-06-17 18:25:00)

<SNIP>

> > > +++ b/drivers/gpu/drm/xe/xe_query.c
> > > @@ -354,6 +354,10 @@ static int query_config(struct xe_device *xe,
> > > struct drm_xe_device_query *query)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> > > DRM_XE_QUERY_CONFIG_FLAG_HAS_DISABLE_STATE_CACHE_PERF_FIX;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config->info[DRM_XE_QUERY_=
CONFIG_FLAGS] |=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 DRM_XE_QUERY_CONFIG_FLAG_HAS_PURGING_SUPPORT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (xe->info.has_usm) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 config->info[DRM_XE_QUERY_CONFIG_FLAGS] |=3D
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > DRM_XE_QUERY_CONFIG_FLAG_HAS_VM_GET_PROPERTY_FAULTS;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > I think it kind of proves the validness of concerns in [1] that the
> > has_usm check you add here doesn't have much relevance to the actual
> > VM_GET_PROPERTY_FAULTS IOCTL being available or functional.
> >=20
> > If you think the VM_GET_PROPERTY_FAULTS should be gated by the
> > has_usm
> > condition, then you should have updated the actual IOCTL, no?
>=20
> VM_GET_PROPERTY_FAULTS call would work in any platform but would only
> only return fault information in platforms with has_usm support.

That's just how the codebase is today, there's no inherent dependence
here when approached from GPU/EU debugging angle of things.

> > The whole point of the original discussions resulting in [1] was that
> > it is such an easy error to make the capability flag check and the
> > actual IOCTL availability differ that it should be avoided.
>=20
> Someone just reading xe_drm.h would understand that they need to check
> for DRM_XE_QUERY_CONFIG_FLAG_HAS before using a feature.

The proposed name is literally about HAS_VM_GET_PROPERTY_FAULTS, not
HAS_USM or HAS_FAULTS. So reasonable developer is bound to assume it's
really about the question of the availability of that property.

And for availability the QUERY IOCTL idiom already has a solution in it.

> Without that,
> a person lacking historical context might blindly call
> VM_GET_PROPERTY_FAULTS, unaware that some KMD versions don't even
> support it.

If that is the problem, I think we'd be better off by documenting how
IOCTL based feature detection works, as that has been the de-facto
method for DRM subsystem for years as explained in [1], too.

Regards, Joonas

> > The fact that such an error is in this very patch still after reading
> > through the original reasoning from Sima kind of underlines why the
> > point still stands strongly.
> >=20
> > Regards, Joonas
> >=20
> > [1] https://www.spinics.net/lists/intel-gfx/msg325342.html
