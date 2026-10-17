Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73378CCF2CC
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 21:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82FB810E3A0;
	Sat, 17 Oct 2026 21:31:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8997B10E00A;
 Sat, 17 Oct 2026 21:31:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4209C417AE;
 Sat, 17 Oct 2026 21:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4A61F000C4;
 Sat, 17 Oct 2026 21:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792272674;
 bh=JCM777W62X35EsMgX76DsM7ri9s3eX3wfzZra9xZqz4=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=H6ZFjKDc66Ox3D9m8kZhiCmc8zjvAULT8ZHHXueuaoCx1nxUK/ehey8Exxwaq/l8Y
 iwYoJxm4DT8KcoWF9UmjMoh7n5ahOQKPWc+ZyHz7tVTQ6AN7ad3AeG3Z9nNaeCN/Fd
 Mk7RS/GeLJJe4Tn1Ak/iNONr2plItn5Jed29b2mRkiyz/To090ZMcj0xUtEsSPqFZV
 PiGhGjR6fK62a9NIfJxaUYZiURFL9egvFM919DhKDDNOvY3Rz/s4oiWZnNTmX0Eai9
 qx5jV4twmLnXV+KAvusCU/odAH6pLlLSCJRRpOFIIpAa0/uh75gILG5JEiYUKPDnTg
 CUCW9TmpD6Wxw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 17 Oct 2026 23:31:06 +0200
Message-Id: <DM7FMW8WTN5C.FSW38EU72RAI@kernel.org>
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
In-Reply-To: <20261001220632.3190896-8-matthew.brost@intel.com>
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

On Fri Oct 2, 2026 at 12:06 AM CEST, Matthew Brost wrote:
> @@ -1187,6 +1187,27 @@ bind_validate_region(struct nouveau_job *job)
>  	return 0;
>  }
> =20
> +/*
> + * Lock the VM's common dma-resv together with the one of @obj, as neede=
d to
> + * drop what may be the last reference of a &drm_gpuvm_bo.
> + */
> +static void
> +nouveau_uvmm_lock_vm_and_obj(struct nouveau_uvmm *uvmm, struct drm_exec =
*exec,
> +			     struct drm_gem_object *obj)
> +{
> +	int ret;
> +
> +	drm_exec_init(exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> +	drm_exec_until_all_locked(exec) {
> +		ret =3D drm_exec_lock_obj(exec, drm_gpuvm_resv_obj(&uvmm->base));
> +		if (!ret)
> +			ret =3D drm_exec_lock_obj(exec, obj);

What happens if we reach this with ENOMEM? In such a case we may return wit=
hout
any locks being held and nouveau would just continue calling into function =
that
expect locks to be held and hence produced UB, right?

(I think there is a similar case in MSM, but it was pre-existing, so I pick=
ed all
other patches.)

> +		drm_exec_retry_on_contention(exec);
> +		if (drm_WARN_ON(uvmm->base.drm, ret))
> +			break;
> +	}
> +}
