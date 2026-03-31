Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37506FF60FF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D6210E92F;
	Tue, 31 Mar 2026 11:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fCIQTZx8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BC2110E92F;
 Tue, 31 Mar 2026 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774954989; x=1806490989;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=CXKoAy7O5Rpwmv3YWsWhSdf1a0F4IU82daIfMAP2+1w=;
 b=fCIQTZx8ZNSZLWIROqlSQDwHgj4rP9a0cdy0iYY43XsGCUlJJ7Gs79Ma
 v8g3PNy8dAdzBKjhuFrfzWYczMJPPvLL0bKxSy6VaMd4xucdhMLfiHPdM
 Uvk/Pn+oGAIU1EtwKUNXNmTFTrljhcTA9rEb8jYqgfAuRy1Db+iB4hFd9
 Ib54X2jHUu/darbGj2vGMctuBgLC+J3+PJw5Jw/2h3tbKQCooRPiFIyiU
 yfrNeYlNZ4/Tx1MaBPx/htBDKr5X3OBvP87EtDpV7+80p77rZKVgF92cY
 2eY1ivt7NLoihPL+BABmop3zzuaRO7ddqzleN5CzqcOpLKxeog4RGYn3y A==;
X-CSE-ConnectionGUID: g0GsapvARK+t8TVk5MKUYA==
X-CSE-MsgGUID: YU8d5ZbyQLefYR0mPNZ8uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87040458"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="87040458"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 04:03:08 -0700
X-CSE-ConnectionGUID: z9/dny+NQpCVQjTWng+qnA==
X-CSE-MsgGUID: tkbCaRf9SKW72Bb5vOGUQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="219688900"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.28])
 ([10.245.244.28])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 04:03:03 -0700
Message-ID: <30209daf9db82c0c96e64989b3ade704904c5bc9.camel@linux.intel.com>
Subject: Re: [PATCH 3/5] drm/exec: Make the drm_exec_until_all_locked()
 macro more readable
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
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Date: Tue, 31 Mar 2026 13:03:00 +0200
In-Reply-To: <dc8f24ed-be2a-470e-a092-f461503cde71@amd.com>
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-4-thomas.hellstrom@linux.intel.com>
 <dc8f24ed-be2a-470e-a092-f461503cde71@amd.com>
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

On Tue, 2026-03-31 at 11:39 +0200, Christian K=C3=B6nig wrote:
>=20
>=20
> On 3/31/26 11:20, Thomas Hellstr=C3=B6m wrote:
> > Use __UNIQUE_ID as done elsewhere in the kernel rather than a
> > hand-rolled __PASTE to craft a unique id.
> >=20
> > Also use __maybe_unused rather than (void) to signify that a
> > variable, althrough written to, may not actually be used.
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0include/drm/drm_exec.h | 23 ++++++++++++++---------
> > =C2=A01 file changed, 14 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> > index 25db52dd2af0..fc95a979e253 100644
> > --- a/include/drm/drm_exec.h
> > +++ b/include/drm/drm_exec.h
> > @@ -89,6 +89,19 @@ drm_exec_obj(struct drm_exec *exec, unsigned
> > long index)
> > =C2=A0	for (unsigned long _index =3D (exec)->num_objects -
> > 1;				\
> > =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 ((obj) =3D drm_exec_obj(exec, _index));=
 --_index)
> > =C2=A0
> > +/*
> > + * Helper to drm_exec_until_all_locked(). Don't use directly.
> > + *
> > + * Since labels can't be defined local to the loop's body we use a
> > jump pointer
> > + * to make sure that the retry is only used from within the loop's
> > body.
> > + */
> > +#define __drm_exec_until_all_locked(exec,
> > _label)			\
> > +_label:						=09
> > 		\
> > +	for (void * __maybe_unused __drm_exec_retry_ptr;
> > ({		\
> > +		__drm_exec_retry_ptr =3D
> > &&_label;			\
>=20
> I think when using __maybe_unused we could also move assigning the
> variable to the deceleration and drop the extra ({}).

Sure. Looks even better.

Thanks,
Thomas



>=20
> Apart from that looks good to me.
>=20
> Regards,
> Christian.
>=20
> > +		drm_exec_cleanup(exec);		=09
> > 		\
> > +	});)
> > +
> > =C2=A0/**
> > =C2=A0 * drm_exec_until_all_locked - loop until all GEM objects are
> > locked
> > =C2=A0 * @exec: drm_exec object
> > @@ -96,17 +109,9 @@ drm_exec_obj(struct drm_exec *exec, unsigned
> > long index)
> > =C2=A0 * Core functionality of the drm_exec object. Loops until all GEM
> > objects are
> > =C2=A0 * locked and no more contention exists. At the beginning of the
> > loop it is
> > =C2=A0 * guaranteed that no GEM object is locked.
> > - *
> > - * Since labels can't be defined local to the loops body we use a
> > jump pointer
> > - * to make sure that the retry is only used from within the loops
> > body.
> > =C2=A0 */
> > =C2=A0#define
> > drm_exec_until_all_locked(exec)					\
> > -__PASTE(__drm_exec_,
> > __LINE__):						\
> > -	for (void *__drm_exec_retry_ptr;
> > ({				\
> > -		__drm_exec_retry_ptr =3D &&__PASTE(__drm_exec_,
> > __LINE__);\
> > -
> > 		(void)__drm_exec_retry_ptr;				\
> > -
> > 		drm_exec_cleanup(exec);					\
> > -	});)
> > +	__drm_exec_until_all_locked(exec, __UNIQUE_ID(drm_exec))
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * drm_exec_retry_on_contention - restart the loop to grap all
> > locks
