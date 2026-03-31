Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1991061B26
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDF510E9F8;
	Tue, 31 Mar 2026 11:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aD2dlTwb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5F610E9F8;
 Tue, 31 Mar 2026 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774955404; x=1806491404;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=S/YMK+Slo64Pl27uOtdErMDxgZRg/+RbqxMRJWMNB3o=;
 b=aD2dlTwbwDrZZbWo+eEv+00ct5cFRBunfifjUms6vtC7/LTc3utxE/fs
 s5iSVZ25z+Lj2IG4cN1pFVtYxcJyUfA/csjZLjsYa5TYxGmEo9uF6JM0C
 NjEK0HTkkpP/cL49rQGBxa6B5Ir8FjTAWqg+5J3Esjq3ASroUU+pwEDDN
 u+IlpexkAbQniFqZ8/wR4bt2SrhYswWmWKwQGOxDQzg5tno3k+T2xNoCM
 QtaF8AbGt3aBOtyNUIFSHLLbPraABkzshIOl/4D9MFl/dsdKq84MSKJC/
 WHZ2bS95RO5XN2t7dELPLHsB4poh5aRKfvkN/ffDnmHqCIDVU/Cs/8Nnt A==;
X-CSE-ConnectionGUID: WA6FvUT3Q0mMosE6UZ7PoQ==
X-CSE-MsgGUID: DzMakB5pR/Kiu7xMNaxOHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93352719"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="93352719"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 04:10:04 -0700
X-CSE-ConnectionGUID: pUOxKPQLTd6RLmiM9z/DZg==
X-CSE-MsgGUID: LxULi2sPRgmiTuKJOjKLrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="231160488"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.28])
 ([10.245.244.28])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 04:09:58 -0700
Message-ID: <0e73b7e6dbcec756332f672c443ff127c1707fa4.camel@linux.intel.com>
Subject: Re: [PATCH 4/5] drm/exec, drm/xe: Avoid abusing the drm_exec retry
 pointer
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
Date: Tue, 31 Mar 2026 13:09:56 +0200
In-Reply-To: <e4855d379990345e47e1175ff4b20a757888ff42.camel@linux.intel.com>
References: <20260331092023.81616-1-thomas.hellstrom@linux.intel.com>
 <20260331092023.81616-5-thomas.hellstrom@linux.intel.com>
 <916ac7fc-d699-453f-af60-5cb3b15c1156@amd.com>
 <e4855d379990345e47e1175ff4b20a757888ff42.camel@linux.intel.com>
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

On Tue, 2026-03-31 at 12:13 +0200, Thomas Hellstr=C3=B6m wrote:
> On Tue, 2026-03-31 at 11:44 +0200, Christian K=C3=B6nig wrote:
> > On 3/31/26 11:20, Thomas Hellstr=C3=B6m wrote:
> > > The xe driver was using the drm_exec retry pointer directly to
> > > restart the locking loop after out-of-memory errors. This is
> > > relying on documented behaviour.
> > >=20
> > > Instead add a drm_exec_retry() macro that can be used in this
> > > situation, and that also asserts that the struct drm_exec is
> > > in a state that is compatible with retrying:
> > > Either newly initialized or in a contended state with all locks
> > > dropped.
> > >=20
> > > Use that macro in xe.
> > >=20
> > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > <thomas.hellstrom@linux.intel.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/xe/xe_validation.h |=C2=A0 2 +-
> > > =C2=A0include/drm/drm_exec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++++++++
> > > =C2=A02 files changed, 14 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/xe/xe_validation.h
> > > b/drivers/gpu/drm/xe/xe_validation.h
> > > index a30e732c4d51..4cd955ce6cd2 100644
> > > --- a/drivers/gpu/drm/xe/xe_validation.h
> > > +++ b/drivers/gpu/drm/xe/xe_validation.h
> > > @@ -146,7 +146,7 @@ bool xe_validation_should_retry(struct
> > > xe_validation_ctx *ctx, int *ret);
> > > =C2=A0#define xe_validation_retry_on_oom(_ctx,
> > > _ret)				\
> > > =C2=A0	do
> > > {								\
> > > =C2=A0		if (xe_validation_should_retry(_ctx,
> > > _ret))		\
> > > -			goto
> > > *__drm_exec_retry_ptr;			\
> > > +			drm_exec_retry((_ctx)-
> > > > exec);			\
> >=20
> > Oh, that goto is extremely questionable to begin with.
> >=20
> > > =C2=A0	} while (0)
> > > =C2=A0
> > > =C2=A0/**
> > > diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
> > > index fc95a979e253..5ed5be1f8244 100644
> > > --- a/include/drm/drm_exec.h
> > > +++ b/include/drm/drm_exec.h
> > > @@ -138,6 +138,19 @@ static inline bool
> > > drm_exec_is_contended(struct drm_exec *exec)
> > > =C2=A0	return !!exec->contended;
> > > =C2=A0}
> > > =C2=A0
> > > +/**
> > > + * drm_exec_retry() - Unconditionally restart the loop to grab
> > > all
> > > locks.
> > > + * @exec: drm_exec object
> > > + *
> > > + * Unconditionally retry the loop to lock all objects. For
> > > consistency,
> > > + * the exec object needs to be newly initialized or contended.
> > > + */
> > > +#define drm_exec_retry(_exec)				\
> > > +	do {						\
> > > +		WARN_ON(!drm_exec_is_contended(_exec)); \
> >=20
> > This warning would trigger!
> >=20
> > See the code in xe_bo_notifier_prepare_pinned() for example:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_e=
xec_retry_on_contention(&exec);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D PTR_ERR(backup);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xe_va=
lidation_retry_on_oom(&ctx, &ret);
> >=20
> > Without contention we would just skip the loop and never lock
> > anything.
> >=20
> > What XE does here just doesn't work as far as I can see.
>=20
> So if the xe_validation_retry_on_oom() is actually retrying it
> internally call drm_exec_fini() and drm_exec_init() first, which
> means
> that the warning doesn't trigger, due to the dummy value of
> contended.
>=20
> So the warning does its job, and xe is safe.

So the xe stuff is actually basically an outer loop to
drm_exec_until_all_locked().

We could ofc explicitly code that implementing an
xe_validation_until_all_valid() and have a separate goto ptr, but I'm
not sure that is cleaner, really. They'd point to the same address
anyway.

In the end, the WARN_ON in drm_exec_retry() would ensure drm_exec is
not in an awkward state anyway.

Thanks,
Thomas
=20


>=20
> Thanks,
> Thomas
>=20
>=20
>=20
> >=20
> > Regards,
> > Christian.
> >=20
> > > +		goto *__drm_exec_retry_ptr;		\
> > > +	} while (0)
> > > +
> > > =C2=A0void drm_exec_init(struct drm_exec *exec, u32 flags, unsigned
> > > nr);
> > > =C2=A0void drm_exec_fini(struct drm_exec *exec);
> > > =C2=A0bool drm_exec_cleanup(struct drm_exec *exec);
