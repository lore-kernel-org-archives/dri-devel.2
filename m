Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465C4606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAULB+Wz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0B8110E2AE;
	Thu, 22 Oct 2026 09:27:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0052B10E2AE;
 Thu, 22 Oct 2026 09:27:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE783601F1;
 Thu, 22 Oct 2026 09:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4741F000C1;
 Thu, 22 Oct 2026 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792661219;
 bh=ZmPB/v9tM4KF5zLghO8YC3xqrkWiPWbC0/Vuu64P2zc=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=gAULB+WzMFf2g6TfXl9xO1Ups/0MyP52OxVeJrz/JE9VEPyNqF63NcriZwfEx8bQg
 4oFm2itv3EwCPwOZDHDKipyMAAHEA27oTbiadgFk7lnbttx5KN2GbIZ3jDBe1hluKb
 mHWY5x0JFN2U/uF6doUay4fdXnqKqu4YkYyh/jxezi0VMjScVbWQ6WKVph6Uw8TanI
 StCxRzcPMoPonsvWyK+uLSCMu7hu3zfmbV736BWsA+qfX0LDqegn1rsbbOpeh8+3Hf
 1YRI9gK6cX+uLNtRSSwS5uFqEBd4G6r/dAJOeiSVF0Wnl3oMOAnTaGrV79s/F0AFzF
 pfJfoR+SJ3u1A==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 11:26:51 +0200
Message-Id: <DMB9D3I91CP4.QAGAM8GT7MA0@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 7/8] drm/nouveau: use DRM_GPUVM_RESV_PROTECTED
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Alice Ryhl"
 <aliceryhl@google.com>, "Anna Maniscalco" <anna.maniscalco2000@gmail.com>,
 "Antonino Maniscalco" <antomani103@gmail.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "David Airlie" <airlied@gmail.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>, "Liviu Dudau"
 <liviu.dudau@arm.com>, "Lyude Paul" <lyude@redhat.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Marijn Suijten"
 <marijn.suijten@somainline.org>, "Maxime Ripard" <mripard@kernel.org>,
 "Randy Dunlap" <rdunlap@infradead.org>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Sean Paul" <sean@poorly.run>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Steven Price" <steven.price@arm.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
To: "Matthew Brost" <matthew.brost@intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
 <20261001220632.3190896-8-matthew.brost@intel.com>
 <DM7FMW8WTN5C.FSW38EU72RAI@kernel.org>
 <atQaohqqhgHArD/M@gsse-cloud1.jf.intel.com>
 <atQhrkC+F5xgn4A5@gsse-cloud1.jf.intel.com>
In-Reply-To: <atQhrkC+F5xgn4A5@gsse-cloud1.jf.intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Oct 18, 2026 at 3:32 AM CEST, Matthew Brost wrote:
> On Sat, Oct 17, 2026 at 06:02:26PM -0700, Matthew Brost wrote:
>> On Sat, Oct 17, 2026 at 11:31:06PM +0200, Danilo Krummrich wrote:
>> > On Fri Oct 2, 2026 at 12:06 AM CEST, Matthew Brost wrote:
>> > > @@ -1187,6 +1187,27 @@ bind_validate_region(struct nouveau_job *job)
>> > >  	return 0;
>> > >  }
>> > > =20
>> > > +/*
>> > > + * Lock the VM's common dma-resv together with the one of @obj, as =
needed to
>> > > + * drop what may be the last reference of a &drm_gpuvm_bo.
>> > > + */
>> > > +static void
>> > > +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_=
exec *exec,
>> > > +			     struct drm_gem_object *obj)
>> > > +{
>> > > +	int ret;
>> > > +
>> > > +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
>> > > +	drm_exec_until_all_locked(exec) {
>> > > +		ret =3D drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
>> > > +		if (!ret)
>> > > +			ret =3D drm_exec_lock_obj(exec, obj);
>> >=20
>> > What happens if we reach this with ENOMEM? In such a case we may retur=
n without
>>=20
>> Right, valid issue. Sashiko flagged this too.
>>=20
>> Originally, I thought we would need to open-code the WW transaction, but
>> instead I ended up fixing drm_exec [1].
>>=20
>> So I think we should merge [1] and run the MSM and Nouveau work in a
>> no-failure mode.
>>=20
>> One thing I'd add is an assert(!ret) if Nouveau has support for that
>> (see xe_assert.h for what we do in Xe so our CI can catch things we
>> believe are impossible). I suppose the open-coded version would be a
>> WARN_ON() or WARN_ON_ONCE().
>>=20
>> Also likey a BUILD_BUG_ON(2 <=3D DRM_EXEC_INLINE_OBJECTS).
>>=20
>
> Ugh, logic inversion.
>
> Rather:
>
> BUILD_BUG_ON(2 > DRM_EXEC_INLINE_OBJECTS)
>
> Matt
>
>> Let me know if you want me to respin with these changes.

That'd be great, thanks!

Please prefer BUILD_BUG_ON(), I'd like to avoid the need for any WARN_ON() =
in
this code path.

>>=20
>> Matt=20
>>=20
>> [1] https://patchwork.freedesktop.org/series/175390/
>>=20
>> > any locks being held and nouveau would just continue calling into func=
tion that
>> > expect locks to be held and hence produced UB, right?
>> >=20
>> > (I think there is a similar case in MSM, but it was pre-existing, so I=
 picked all
>> > other patches.)
>> >=20
>> > > +		drm_exec_retry_on_contention(exec);
>> > > +		if (drm_WARN_ON(uvmm->base.drm, ret))
>> > > +			break;
>> > > +	}
>> > > +}

