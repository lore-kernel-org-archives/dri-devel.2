Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5191210F92F9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B61B210EB20;
	Tue, 31 Mar 2026 19:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KA1Q0myu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F19710EAF3;
 Tue, 31 Mar 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774986771; x=1806522771;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=nbUNWnhxtD9uSl+kq+z3SJo1UKV3e6wBk/X6kxEHQeI=;
 b=KA1Q0myuVimi2olWP8/6kDwP2AyjZf8QSDPgan3uH3eSwS2JW8U7+vWA
 DozGbRn8mnixKlhaMFfXm3Qjw586O2wWZz9QHfOriYnKmJzaOie1q136S
 xSP/Vewrz5FoFPlmMpws/9UE+qYynsiym0QAGihYjVj/DRp7Df4PHsZXP
 IdLUnlp22s9zDjfrx01zYbz6Ob4q6otAP1eWiiR369cg84Vl8Rw1C2ly2
 U7MnQ5y5lyek7CT9aEZUfVS/WXOQ1XWu7vfrR5B5mV8o+hH/lbfqOwGYx
 NbscFBc9NCPs0zwzXBsO6DlT9pxTBW85iPwPetXr5iVch8h5FH3iqS+TF w==;
X-CSE-ConnectionGUID: Qwy2Py7XRKWmhOgohICkkw==
X-CSE-MsgGUID: dDf2B6muS3mSPRFUzjOERw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="86627320"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="86627320"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 12:52:51 -0700
X-CSE-ConnectionGUID: 4wP6lwCxTUSbpUETu8DyVg==
X-CSE-MsgGUID: /K6c4WzVTHGmpaA0jZ9tfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; d="scan'208";a="225461106"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.28])
 ([10.245.244.28])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 12:52:46 -0700
Message-ID: <bd45632be1a5bcd2ce34834b45a35254e23f7679.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] drm/msm: Remove abuse of drm_exec internals
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: rob.clark@oss.qualcomm.com
Cc: intel-xe@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Danilo Krummrich
 <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,  Alice Ryhl
 <aliceryhl@google.com>, Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar	
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, Sean
 Paul	 <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Date: Tue, 31 Mar 2026 21:52:43 +0200
In-Reply-To: <CACSVV03FFvi0c4XMEShmH5ou4OKKZcvvni2j=0DBoYnuT55ecQ@mail.gmail.com>
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-3-thomas.hellstrom@linux.intel.com>
 <CACSVV03FFvi0c4XMEShmH5ou4OKKZcvvni2j=0DBoYnuT55ecQ@mail.gmail.com>
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

On Tue, 2026-03-31 at 12:08 -0700, Rob Clark wrote:
> On Tue, Mar 31, 2026 at 2:21=E2=80=AFAM Thomas Hellstr=C3=B6m
> <thomas.hellstrom@linux.intel.com> wrote:
> >=20
> > The code was reading drm_exec internal state to determine whether
> > the drm_exec structure had been initialized or not, and therefore
> > needed cleaning up, relying on undocumented behaviour.
> >=20
> > Instead add a bool to struct msm_gem_submit to indicate whether
> > drm_exec cleaning up is needed.
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
>=20
> Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>
>=20
> This is pretty stand-alone, so I can pick it up for v7.1.=C2=A0 Or ack fo=
r
> landing it via drm-misc with the rest of the series if that is easier
> for you.=C2=A0 It shouldn't conflict with anything in flight.

Thanks Rob. Please pick it up and I'll exclude it from the next
iteration of the series.

Thanks,
Thomas

>=20
> BR,
> -R
>=20
> > ---
> > =C2=A0drivers/gpu/drm/msm/msm_gem.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 1 +
> > =C2=A0drivers/gpu/drm/msm/msm_gem_submit.c | 4 +++-
> > =C2=A02 files changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/msm/msm_gem.h
> > b/drivers/gpu/drm/msm/msm_gem.h
> > index cb32093fda47..762e546d25ef 100644
> > --- a/drivers/gpu/drm/msm/msm_gem.h
> > +++ b/drivers/gpu/drm/msm/msm_gem.h
> > @@ -452,6 +452,7 @@ struct msm_gem_submit {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool bos_pinned : 1;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool fault_dumped:1;/* Limit=
 devcoredump dumping to one per
> > submit */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool in_rb : 1;=C2=A0=C2=A0=
=C2=A0=C2=A0 /* "sudo" mode, copy cmds into RB */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_exec : 1;=C2=A0 /* @exec=
 is initialized. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct msm_ringbuffer *ring;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int nr_cmds;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int nr_bos;
> > diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c
> > b/drivers/gpu/drm/msm/msm_gem_submit.c
> > index 75d9f3574370..26ea8a28be47 100644
> > --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> > +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> > @@ -278,6 +278,7 @@ static int submit_lock_objects_vmbind(struct
> > msm_gem_submit *submit)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D 0;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_exec_init(&submit->exec,=
 flags, submit->nr_bos);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit->has_exec =3D true;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_exec_until_all_locked (&=
submit->exec) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D drm_gpuvm_prepare_vm(submit->vm, exec, 1);
> > @@ -304,6 +305,7 @@ static int submit_lock_objects(struct
> > msm_gem_submit *submit)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return submit_lock_objects_vmbind(submit);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_exec_init(&submit->exec,=
 flags, submit->nr_bos);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 submit->has_exec =3D true;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_exec_until_all_locked (&=
submit->exec) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D drm_exec_lock_obj(&submit->exec,
> > @@ -523,7 +525,7 @@ static void submit_cleanup(struct
> > msm_gem_submit *submit, bool error)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (error)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 submit_unpin_objects(submit);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (submit->exec.objects)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (submit->has_exec)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 drm_exec_fini(&submit->exec);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* if job wasn't enqueued to=
 scheduler, early retirement:
> > */
> > --
> > 2.53.0
> >=20
