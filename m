Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B824F588F5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924D210E24B;
	Mon, 20 Apr 2026 16:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k1VGY+20";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251EE10E24B;
 Mon, 20 Apr 2026 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776702541; x=1808238541;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=+gVX3UOSPwoyymXhgo+gjJ+g4VoiOsc5z7Zps3kfqUg=;
 b=k1VGY+20KXhqjTwR4wLxBzmfKF3/PXxBHoPFour+zJ1ETvxPpPzohCbz
 8DByfvay2BYdUKeA6yYAGp6JAcSq3/ZDh0+1UGUP2apl9nIXpdn+rPF3g
 FZU99fA7QUwa0hRs9k9eJGRukJ24fFBY9RBW1JBvDnAMBdUG5BgkmDEwR
 aHj3rZOTusynNvJHOSnxxtPM3uywaTKeW0uUXS7PE+LskCisHhK6vsgR+
 7nJu81ccv5GMUh3NC7wFxf93cEAhQPJJVL9z5eZMCW1cphOskzfQETYIj
 rGYk66eHI3+Q3qpGKBvgkkOvayRA4YBUc3EdP2yHWygs3NzcjzOMeKIyX w==;
X-CSE-ConnectionGUID: prGzIehvSniAKo3U5u/UKw==
X-CSE-MsgGUID: kCnr5OIoRV6n+abcAecQbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77498200"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="77498200"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:28:59 -0700
X-CSE-ConnectionGUID: 8283j0diQhuhlbRCi5UrTQ==
X-CSE-MsgGUID: +05YG3k6QAq70gzjMJJMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="227130085"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.133])
 ([10.245.244.133])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:28:53 -0700
Message-ID: <c8c05759c23d8befd3034b35d63c1de22c1c0d3e.camel@linux.intel.com>
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>
Cc: "Huang, Honglei1" <honghuan@amd.com>, Alexander.Deucher@amd.com, 
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com, 
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com, 
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, rodrigo.vivi@intel.com,
 dakr@kernel.org, 	aliceryhl@google.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Date: Mon, 20 Apr 2026 18:28:50 +0200
In-Reply-To: <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
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

On Mon, 2026-04-20 at 09:06 -0700, Matthew Brost wrote:
> On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian K=C3=B6nig wrote:
> > On 4/20/26 15:30, Huang, Honglei1 wrote:
> > > On 4/20/2026 8:15 PM, Christian K=C3=B6nig wrote:
> > > >=20
> > > >=20
> > > > On 4/20/26 14:07, Honglei Huang wrote:
> > > > > From: Honglei Huang <honghuan@amd.com>
> > > > >=20
> > > > > Add amdgpu drm SVM API definitions built on the
> > > > > DRM GPUSVM framework.
> > > > >=20
> > > > > This includes:
> > > > > - DRM_AMDGPU_GEM_SVM ioctl
> > > > > - AMDGPU_SVM_FLAG_* flags
> > > > > - AMDGPU_SVM_OP_SET_ATTR / AMDGPU_SVM_OP_GET_ATTR operations
> > > > > - AMDGPU_SVM_ATTR_* attribute types
> > > > > - AMDGPU_SVM_LOCATION_SYSMEM / AMDGPU_SVM_LOCATION_UNDEFINED
> > > > > - struct drm_amdgpu_svm_attribute and struct
> > > > > drm_amdgpu_gem_svm
> > > > >=20
> > > > > Signed-off-by: Honglei Huang <honghuan@amd.com>
> > > > > ---
> > > > > =C2=A0 include/uapi/drm/amdgpu_drm.h | 39
> > > > > +++++++++++++++++++++++++++++++++++
> > > > > =C2=A0 1 file changed, 39 insertions(+)
> > > > >=20
> > > > > diff --git a/include/uapi/drm/amdgpu_drm.h
> > > > > b/include/uapi/drm/amdgpu_drm.h
> > > > > index 406a42be4..bed71ed9b 100644
> > > > > --- a/include/uapi/drm/amdgpu_drm.h
> > > > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > > > @@ -58,6 +58,7 @@ extern "C" {
> > > > > =C2=A0 #define DRM_AMDGPU_USERQ_SIGNAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x17
> > > > > =C2=A0 #define DRM_AMDGPU_USERQ_WAIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x18
> > > > > =C2=A0 #define DRM_AMDGPU_GEM_LIST_HANDLES=C2=A0=C2=A0=C2=A0 0x19
> > > > > +#define DRM_AMDGPU_GEM_SVM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 0x1a
> > > > > =C2=A0 =C2=A0 #define DRM_IOCTL_AMDGPU_GEM_CREATE=C2=A0=C2=A0=C2=
=A0
> > > > > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
> > > > > drm_amdgpu_gem_create)
> > > > > =C2=A0 #define DRM_IOCTL_AMDGPU_GEM_MMAP=C2=A0=C2=A0=C2=A0
> > > > > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union
> > > > > drm_amdgpu_gem_mmap)
> > > > > @@ -79,6 +80,7 @@ extern "C" {
> > > > > =C2=A0 #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL=C2=A0=C2=A0=C2=A0
> > > > > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct
> > > > > drm_amdgpu_userq_signal)
> > > > > =C2=A0 #define DRM_IOCTL_AMDGPU_USERQ_WAIT=C2=A0=C2=A0=C2=A0
> > > > > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct
> > > > > drm_amdgpu_userq_wait)
> > > > > =C2=A0 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
> > > > > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES,
> > > > > struct drm_amdgpu_gem_list_handles)
> > > > > +#define DRM_IOCTL_AMDGPU_GEM_SVM=C2=A0=C2=A0=C2=A0
> > > > > DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_SVM, struct
> > > > > drm_amdgpu_gem_svm)
> > > > > =C2=A0 =C2=A0 /**
> > > > > =C2=A0=C2=A0 * DOC: memory domains
> > > > > @@ -1665,6 +1667,43 @@ struct drm_color_ctm_3x4 {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u64 matrix[12];
> > > > > =C2=A0 };
> > > > > =C2=A0 +#define AMDGPU_SVM_FLAG_HOST_ACCESS=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x00000001
> > > > > +#define AMDGPU_SVM_FLAG_COHERENT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x00000002
> > > > > +#define AMDGPU_SVM_FLAG_HIVE_LOCAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x00000004
> > > > > +#define AMDGPU_SVM_FLAG_GPU_RO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x00000008
> > > > > +#define AMDGPU_SVM_FLAG_GPU_EXEC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0x00000010
> > > > > +#define AMDGPU_SVM_FLAG_GPU_READ_MOSTLY=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x00000020
> > > > > +#define AMDGPU_SVM_FLAG_GPU_ALWAYS_MAPPED=C2=A0=C2=A0=C2=A0 0x00=
000040
> > > > > +#define AMDGPU_SVM_FLAG_EXT_COHERENT=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x00000080
> > > > > +
> > > > > +#define AMDGPU_SVM_OP_SET_ATTR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 0
> > > > > +#define AMDGPU_SVM_OP_GET_ATTR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1
> > > > > +
> > > > > +#define AMDGPU_SVM_ATTR_PREFERRED_LOC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0
> > > > > +#define AMDGPU_SVM_ATTR_PREFETCH_LOC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 1
> > > >=20
> > > > Up till here the interface makes perfect sense, but then it
> > > > becomes a bit fuzzy.
> > > >=20
> > > > > +#define AMDGPU_SVM_ATTR_ACCESS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2
> > > > > +#define AMDGPU_SVM_ATTR_ACCESS_IN_PLACE=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 3
> > > > > +#define AMDGPU_SVM_ATTR_NO_ACCESS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 4
> > > >=20
> > > > Why are those separate attributes? What is the difference
> > > > between those?
> > >=20
> > > Really thanks for the comments, I have some content mistaken in
> > > V2, so I updated the V3 to fix that. For the header they are
> > > same. for other content please review the V3, sorry about that.
> > > And will fix the concern you raised in next version.
> > >=20
> > > So the meaning of AMDGPU_SVM_ATTR_ACCESS and
> > > AMDGPU_SVM_ATTR_NO_ACCESS are clear, GPU can access it or not,
> > > and the SVM can set the preferred location, it can be in VRAM or
> > > system, for AMDGPU_SVM_ATTR_ACCESS it can be migrated between RAM
> > > and VRAM. For AMDGPU_SVM_ATTR_ACCESS_IN_PLACE,
> > > it can not migrate, GPU only can access it in the initial place.
> >=20
> > Yeah but that doesn't then the interface doesn't seem to make sense
> > since such states are mutual exclusive.
> >=20
> > It would make sense when you have some attribute which is named
> > (for example) AMDGPU_SVM_ATTR_ACCESS which can have the values
> > INACCESSIBLE, IN_PLACE, MIGRATE.
> >=20
> > > > > +#define AMDGPU_SVM_ATTR_SET_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 5
> > > > > +#define AMDGPU_SVM_ATTR_CLR_FLAGS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 6
> > > >=20
> > > > Why is that separated into set and clear flags?
> > >=20
> > > This method inherits from KFD and is also designed to be
> > > compatible with upper layer applications such as ROCR.
> >=20
> > That is *not* sufficient as justification. We need to document why
> > that is necessary and *not* just say ROCR works that way.
> >=20
> > As far as I can see just a SET_FLAGS should be sufficient.
> >=20
> > > > > +#define AMDGPU_SVM_ATTR_GRANULARITY=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 7
> > > > > +
> > > > > +#define AMDGPU_SVM_LOCATION_SYSMEM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 0
> > > > > +#define AMDGPU_SVM_LOCATION_UNDEFINED=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0xffffffff
> > > >=20
> > > > No location for device local memory?
> > >=20
> > > Vaule > 0 means for device memory, in xe_svm, it seems like it
> > > uses fd for device local memory.
>=20
> I have no stake in AMD=E2=80=99s uAPI, but I can at least explain how Xe=
=E2=80=99s
> uAPI
> works here=E2=80=94and admittedly, it=E2=80=99s somewhat goofy.
>=20
> 0 =3D=3D device-local memory, with first-touch placement on whichever
> device/tile touches the memory first
>=20
> -1 =3D=3D system memory
>=20
> =E2=89=A5 0 =3D=3D a render-node FD (which could refer to a local or remo=
te
> device),
> paired with a region instance to extract the pgmap for the desired
> placement
>=20

The first UAPI implementation here actually took a "pagemap fd"
somewhat analogous to a dma-buf fd and that were created using a
separate ioctl on the pagemap device.

IIRC when the RFC was posted, Christian had some concerns with that.
And also when presented to the UMD team they, as Matt writes, preferred
the current approach for simplicity.

The benefit of a pagemap fd is that it would be easily possible to
share other driver's pagemaps, and that the UMD would have explicit
control over the pagemap lifetime. With the current approach a pagemap
may be created during a gpu_madvise() call resulting in an unexpected
(to the app) rather long delay.

That said, it would be easy to support "pagemap fds" as well by just
checking the file type in the gpu_madvise() ioctl.

/Thomas



