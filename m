Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33888CD5BA4
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 11:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9880110E492;
	Thu, 21 May 2026 11:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iS1QQwPB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BE2810E492;
 Thu, 21 May 2026 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779363956; x=1810899956;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=NQFPplxomD0x/n8n9y9LQN4H3w76sftdXd7q8RgP6wo=;
 b=iS1QQwPBEuLq1ZWk+Mba3CQmxRAIhpyykGt2G6Juyl69Z/AlElLsc8VX
 aXCwniQadbgYvramlvRPTFzXDvWvlZ8xRjDgBmn/o7lMFRqXn9C1uNczE
 iFyucKm4toBsHb5Af4mw+lUPSrwBTgmVgG0L5RoMqDiYW4nnEoBgQpJF5
 OUuHMCK7uLP5hEqe3p4XJPC150fonwoc3aau18gLcp6bgQEBZYPaCinsL
 aVZw72d9aS/oL8A5A/IzSDmJb25OVNJVjZOc3UvK3TyX252Yh+AatUWFp
 nw4LybXQVUU+SZ0GZ2LosJ8puC82gtYZVR1OjKobhtv+JuuNGkz+3x48+ w==;
X-CSE-ConnectionGUID: rgOQV+sBSzO0TV+TCeCJGQ==
X-CSE-MsgGUID: rXJZsNyyQj+uhgJMx+Z47A==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="91670947"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="91670947"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:45:55 -0700
X-CSE-ConnectionGUID: efRim4avTweoDSsfFU1U7g==
X-CSE-MsgGUID: S9fI+i6jSiWPJtQNsUY7BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="240533509"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.105])
 ([10.245.244.105])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:45:49 -0700
Message-ID: <9266d1f9615d942c2472f5b9846247a71ab62dc7.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/4] drm/exec: drm_exec polishing
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher	
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter	 <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Danilo Krummrich
 <dakr@kernel.org>,  Matthew Brost <matthew.brost@intel.com>, Alice Ryhl
 <aliceryhl@google.com>, Rob Clark	 <robin.clark@oss.qualcomm.com>, Dmitry
 Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul	 <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, Natalie
 Vock	 <natalie.vock@gmx.de>
Date: Thu, 21 May 2026 13:45:35 +0200
In-Reply-To: <da49f6c2-5b6e-4bd6-8940-84206b5913f8@amd.com>
References: <20260520101616.41284-1-thomas.hellstrom@linux.intel.com>
 <da49f6c2-5b6e-4bd6-8940-84206b5913f8@amd.com>
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

Hi,

On Wed, 2026-05-20 at 13:34 +0200, Christian K=C3=B6nig wrote:
> On 5/20/26 12:16, Thomas Hellstr=C3=B6m wrote:
> > During the work towards enabling exhaustive eviction using full
> > ww locking in TTM, Christian indicated that the path for the
> > drm_exec moving forward was to be a full drm_exec helper with
> > things like userptr validation rather than a WW transaction
> > abstraction. The idea was then briefly discussed to craft a
> > WW transaction helper and then subclass that with drm_exec
> > with the idea that the WW transaction helper could be used in
> > TTM for eviction and for other uses that didn't mandate a full
> > exec sequence.
>=20
> BTW Natalie is now trying to polish my TTM patches for doing that
> because some test case for the SteamDeck is running
>  into issues with pinning buffers for display.

Thanks for the review, Christian.

FWIW I did a POC implementation moving drm_exec as a transaction helper
to the dma-buf layer, and then re-implemented drm_exec on top as a
wrapper here:

https://gitlab.freedesktop.org/thomash/xe-vibe/-/commits/ww_transaction?ref=
_type=3Dheads

Since this would work on any object with a refererence count and a
dma_resv, and even mixing them, it would solve a couple of issues:

1) Decouple the ttm object refcount issue from the TTM exhaustive
eviction (Not saying we shouldn't get rid of the ttm object refcount
anyway).

2) Implement any eviction locking modes (like snapshotting, object
release after slow-lock and similar) separate from drm_exec, and keep
exec as a pure exec-buf helper.

3) Facilitate ww locking in dma_buf_map().

4) Directly lock VMs instead of vm objects.

I haven't posted the patches yet since I wanted to get some feedback
first of whether this is a reasonable direction.

Thanks,
Thomas

>=20
> > Regardless whether that actually happens or not, this series
> > aims to clean up abuses of drm_exec internals in drivers
> > so that future development of drm_exec isn't blocked by
> > such driver usage.
>=20
> Yeah completely agree, going to review those patches now.
>=20
> Regards,
> Christian.
>=20
> >=20
> > Except for patch 2 which is a small cleanup only.
> >=20
> > v2:
> > - An drm/msm patch was already merged.
> > - Use a unique id for the loop variable (patch 1) (Christian)
> > - Move assignment to declaration (patch 2) (Christian)
> > - Declare the retry pointer as void *const. (patch 2)
> > - Only allow if the drm_exec context is newly initialized. (patch
> > 3)
> > =C2=A0 (Christian)
> > - Fix amdgpu compile error (patch 4) (Intel CI)
> > - Update the commit message (patch 4)
> >=20
> > Thomas Hellstr=C3=B6m (4):
> > =C2=A0 drm/exec: Remove the index parameter from
> > =C2=A0=C2=A0=C2=A0 drm_exec_for_each_locked_obj[_reverse]
> > =C2=A0 drm/exec: Make the drm_exec_until_all_locked() macro more
> > readable
> > =C2=A0 drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer
> > =C2=A0 drm/exec, drm/xe, drm/amdgpu: Add an accessor for struct
> > =C2=A0=C2=A0=C2=A0 drm_exec::ticket
> >=20
> > =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c=C2=A0 |=C2=A0 4 +-
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 15 ++--
> > =C2=A0.../drm/amd/amdgpu/amdgpu_eviction_fence.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +-
> > =C2=A0drivers/gpu/drm/drm_exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 9 +--
> > =C2=A0drivers/gpu/drm/drm_gpuvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 3 +-
> > =C2=A0drivers/gpu/drm/xe/xe_validation.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> > =C2=A0drivers/gpu/drm/xe/xe_validation.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 3 +-
> > =C2=A0include/drm/drm_exec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 71 ++++++++++++++-
> > ----
> > =C2=A09 files changed, 70 insertions(+), 44 deletions(-)
> >=20
