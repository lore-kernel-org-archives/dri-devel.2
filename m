Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=oosci6Cw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71E911216D;
	Thu, 12 Nov 2026 15:10:03 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 265F1112174
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794496195;
 bh=0pqkyv52W8cT2CNDX3Fstz+dEUo69dSq5koL79skhbs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oosci6Cw6jg2tYtFuKiZWJV0vXp20ioBtPvrFgrw2JmpMqTECsBuMw3HWobq760dL
 7MQckm711lLFkp+DA80Fs0FKYYT/WHTchwOxk16GblooR2KceHQHiuJoyCjAghX8n1
 2gFS/GDueV9EAdoHcWDXa0jP6th+bjGtDjGt2yJ6dTOwDiBbsjVL6TW2kS3WAbRzjo
 UJbMLfbKyWLbKDxM4ua+pxeh/oINrBg0OQAfmxdziQsrW4gSQqfXlxphXd7qFUFj0r
 H4RvM2LMVASJpZDQnMFiZ67YRJhFKXbDSKbE1e+f3YRQXjvsdTe+Igey0huwaPt5PI
 vTsQj3Dct1v6g==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E5C5F17E07EC;
 Thu, 12 Nov 2026 16:09:54 +0100 (CET)
Date: Thu, 12 Nov 2026 16:09:47 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: "=?UTF-8?B?TWHDrXJh?= Canal" <mcanal@igalia.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob Herring"
 <robh@kernel.org>, "Steven Price" <steven.price@arm.com>, "=?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Larumbe" <adrian.larumbe@collabora.com>, "Liviu Dudau"
 <liviu.dudau@arm.com>, "Alex Deucher" <alexander.deucher@amd.com>,
 "Christian =?UTF-8?B?S8O2bmln?=" <ckoenig.leichtzumerken@gmail.com>,
 "Melissa Wen" <mwen@igalia.com>, "Iago Toral" <itoral@igalia.com>, "JaeHoon
 Lee" <dlwognsdc610@gmail.com>, "kernel-dev" <kernel-dev@igalia.com>,
 "dri-devel" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH RFC 00/12] drm/v3d: Add support for write-back cacheable
 BOs
Message-ID: <20261112160947.44e88c66@fedora1.home>
In-Reply-To: <1a1d009dddd.60725d0c103197.2638865837867497355@collabora.com>
References: <20261030-v3d-cached-maps-v1-0-0a6a6b363382@igalia.com>
 <1a1d009dddd.60725d0c103197.2638865837867497355@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 08:54:29 -0500
Faith Ekstrand <faith.ekstrand@collabora.com> wrote:

> From: Ma=C3=ADra Canal <mcanal@igalia.com>
> To: "Maarten Lankhorst"<maarten.lankhorst@linux.intel.com>, "Maxime
> Ripard"<mripard@kernel.org>, "Thomas
> Zimmermann"<tzimmermann@suse.de>, "David Airlie"<airlied@gmail.com>,
> "Simona Vetter"<simona@ffwll.ch>, "Faith
> Ekstrand"<faith.ekstrand@collabora.com>, "Boris
> Brezillon"<boris.brezillon@collabora.com>, "Rob
> Herring"<robh@kernel.org>, "Steven Price"<steven.price@arm.com>,
> "Adri=C3=A1n Larumbe"<adrian.larumbe@collabora.com>, "Liviu
> Dudau"<liviu.dudau@arm.com>, "Alex
> Deucher"<alexander.deucher@amd.com>, "Christian
> K=C3=B6nig"<ckoenig.leichtzumerken@gmail.com>, "Melissa
> Wen"<mwen@igalia.com>, "Iago Toral"<itoral@igalia.com>, "JaeHoon
> Lee"<dlwognsdc610@gmail.com> Cc: <kernel-dev@igalia.com>,
> <dri-devel@lists.freedesktop.org>, "Ma=C3=ADra Canal"<mcanal@igalia.com>
> Date: Fri., 30 Oct. 2026 16:50:18 -0400 Subject: [PATCH RFC 00/12]
> drm/v3d: Add support for write-back cacheable BOs
>=20
>  > This series aims to implement cached maps and explicit flushing
>  > for the V3D driver, which is mostly motivated by Vulkan's host
>  > cached memory.=20
>  > V3D's implementation of cached maps is quite similar to Panfrost's
>  > and therefore, I decided to revamp Panthor/Panfrost's efforts [1]
>  > to implement common shmem helpers for CPU cache maintenance. The
>  > other option would be copying the same code in V3D, so I preferred
>  > to retake the discussion and see if we can reach some consensus.=20
>  > =20
>  > The most controversial part of this series are the first three
>  > patches, which were extensively discussed in Boris' series.=20
>  > =20
>  > Patch 1 lets the PRIME helpers work with custom dma_buf_ops,
>  > following Thomas' feedback on [1]: drm_gem_prime_export_with_ops()
>  > exports with driver-provided ops, and gem_prime_is_exporter() lets
>  > a driver recognize its own DMA-BUFs on import, without adding
>  > buffer callbacks to struct drm_driver, as requested by Thomas.=20
>  >
>  > Patches 2-3 are taken from [1], rebased on top of drm-misc-next
>  > with some minor kernel-doc fixes.  =20
>=20
> Not entirely included in the mailing list discussion was why we
> abandon this approach for panfrost/panthor:  CPU mapping shared
> dma-bufs is tricky, especialy with non-coherent caching.  Gone are
> the days when we dma-buf had an ownership concept and clients
> properly bookended usage with begin/end.  With explicit cache
> management, there are too many ways that one client can screw up
> another if the BO is shared.
>=20
> The solution was to disallow BO sharing for any BOs that weren't
> mapped write-combined or uncached. A number of DRM drivers already
> have a concept of non-sharable BOs for locking reasons.  We simply
> required that for write-back caching.

Hm, I think the confusion comes from the fact I kept this logic in
panthor/panfrost, just made it panfrost/panthor specific. We also don't
enforce !WB_MMAP on shareable at the KMD level, but we have it filtered
out in panvk.

Honestly, I still have a hard time making sense of how this whole
dma-buf sharing can work if importers/exporter clients are free to CPU
map the thing without proper signalling of CPU accesses, and
importers/exporter devices are not IO coherent (which is often the case
on Arm SoCs). Yes, making the CPU mapping non-cached ensures that two
CPU accesses from two clients can't step on each other, but there's
still device <-> CPU synchronization I can't make sense of, especially
if the importer doesn't know about CPU accesses done by the exporter
and has device accesses that weren't flushed for some reason.

Anyway, I'm happy to drop all the cpu_start/end implementation in
panfrost/panthor if that helps clearing the confusion.


>=20
> This wasn't obvious from the ML discussions because a lot of the
> back-and-forth happened in chat or in meetings inside Collabora.
>=20
> ~Faith Ekstrand
>=20
>=20

