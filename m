Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0D26070CB2
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hAWryTDf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42DE10E06E;
	Mon,  2 Nov 2026 16:16:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C9C10E62F
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:16:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2C0460233;
 Mon,  2 Nov 2026 16:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430A01F00A16;
 Mon,  2 Nov 2026 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793636208;
 bh=WrHrqovE99G5yoJxmiTPYnCRumVysLieV6WQGkt1RA4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hAWryTDf7J+8CEWJ7/rMPRzUtaiDCFA3pBTBJazoKw73R65IC+F99VcD4FEa0oidZ
 Z+sRSTDV/Owk3um3HdMJt0l2eTIV3mmvGxtTd5wf+EqdMk68ADM21ncpPTriNFnPFb
 wZuMH0s/f/omO1P5S1kD2In62I4XJePXvgWnFNwbQI5D9eiQmPYW892aIwlPoTtZuF
 xI0LzxMR/4CJmHUUqKhbLtSBTe3oFmujyVQD7ZaURTe7omEebrEbzC8pW2SXTUGZ8Z
 +3tbiMN0hNHDT1/Wev7U9NZ/e34wCIixybt8BPGHdixrVfFNTGAzHdKMyN42hSXajH
 q/nVCer8sAFug==
Message-ID: <sashiko-outbox-193742@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] drm/msm/gem: Decrement loop idx if handle lookup
 fails
To: "Rob Clark" <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261102161002.497152-4-robin.clark@oss.qualcomm.com>
References: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
 <20261102161002.497152-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:16:47 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] drm/msm/gem: invalid pointer deref in msm_vma_job_free() on lo=
okup failure
--

commit 0d94fd96560aa90ec37575d957f23c1d0f49e11c
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/gem: Decrement loop idx if handle lookup fails

This commit decrements the loop index i when idr_find() fails in
vm_bind_job_lookup_ops() so that the out_unlock cleanup loop skips the entry
that still holds a GEM handle rather than a GEM object pointer.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 922285537dee0..4413db0644a29 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -1110,6 +1110,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job,=
 struct drm_msm_vm_bind *args
>  		obj =3D idr_find(&file->object_idr, op->handle);
>  		if (!obj) {
>  			ret =3D UERR(EINVAL, dev, "invalid handle %u at index %u\n", op->hand=
le, i);
> +			i--;
>  			goto out_unlock;
>  		}

[Severity: Critical]
Does skipping the failed op here without resetting job->nr_ops =3D 0 in the
out_unlock error path leave un-looked-up GEM handles in job->ops[] for
msm_vma_job_free() to dereference?

In struct msm_vm_bind_op, obj and handle share an anonymous union:

	struct msm_vm_bind_op {
		uint32_t op;
		uint32_t flags;
		union {
			struct drm_gem_object *obj;
			uint32_t handle;
		};
		...
	} ops[];

During the first loop in vm_bind_job_lookup_ops(), lookup_op() increments
job->nr_ops and stores each operation's handle in job->ops[i].handle.

When idr_find() fails (or when the subsequent size_add() range check fails
before remaining ops are converted), the out_unlock error block only zeroes
op->obj for indices <=3D i and does not reset job->nr_ops =3D 0:

out_unlock:
	spin_unlock(&file->table_lock);

	if (ret) {
		for (; i >=3D 0; i--) {
			struct msm_vm_bind_op *op =3D &job->ops[i];

			if (!op->obj)
				continue;

			drm_gem_object_put(op->obj);
			op->obj =3D NULL;
		}
	}

When vm_bind_job_lookup_ops() returns an error to msm_ioctl_vm_bind(), it
calls msm_vma_job_free(&job->base):

msm_ioctl_vm_bind()
  -> msm_vma_job_free()
       -> job_foreach_bo(obj, job)
            drm_gem_object_put(obj);

Because job_foreach_bo() iterates up to job->nr_ops, won't
drm_gem_object_put() be called on the raw 32-bit GEM handle left in the
union for the failed op (and any subsequent ops in the array)? Should the
if (ret) block at out_unlock also set job->nr_ops =3D 0, just like the earl=
ier
lookup_op() error path does?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102161002.4971=
52-1-robin.clark@oss.qualcomm.com?part=3D3
