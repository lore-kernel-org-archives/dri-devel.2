Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2BC606A321
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGtGOFXd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D1B810E725;
	Fri, 23 Oct 2026 23:38:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C56310E725
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:38:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CB1F44079;
 Fri, 23 Oct 2026 23:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175D61F0115E;
 Fri, 23 Oct 2026 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792798728;
 bh=Iex8tGyUEonxQzzBfo08sYJpfkyFVrSge2bvSSMKjNQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gGtGOFXd1s68DepEWjfDLHs9YuF3Rg68Pd/80TwsGmq85/ZvPkX1g8NBT0CmWdk7z
 bKvrRbzyEM0Y1UYsm72poVLWctO2q6kPtsl/672jr4XsWa/ZzgYgK77ffjHIKl9B7e
 +p6O7Q41846mAmFD2tNbSh1LsZtDDXIityIEn9X3i1s2QxS4rpv5TlRYaguW2Tdd0u
 ltDtzUDCnEth6McaL+L+z9En4CyEgfK9xjlV4h9uSK+fbUtkmGjw3bUhKabuEr158k
 O0A0OYy8HptnhTxmyQ1uVmzFDSs1s2sCEIykdNgjDgysvx9ZSwK2XVKWzuc9TBROwQ
 elaNWo1TAJw6w==
Message-ID: <sashiko-outbox-183421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/10] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-2-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
 <20261024-fd-kms-fix-smmu-v5-2-a5b0b284aead@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 23:38:47 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dpu: prepare_count underflow on writeback prepare failure
--

commit 32d0ff950383106de0523f200d999646b3523a0a
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: fix framebuffer pin refcount leak on prepare failure

This commit unwinds framebuffer preparation state on failure in
msm_framebuffer_prepare(), unpinning any already-pinned planes, dropping
VMA references, zeroing iova[], and decrementing prepare_count and dirtyfb.

> diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
> index a38e5b3a1d1e9..792d47b4acc43 100644
> --- a/drivers/gpu/drm/msm/msm_fb.c
> +++ b/drivers/gpu/drm/msm/msm_fb.c
> @@ -80,6 +80,18 @@ void msm_framebuffer_describe(struct drm_framebuffer *=
fb, struct seq_file *m)
>  }
>  #endif
> =20
> +static void msm_framebuffer_unpin_planes(struct drm_framebuffer *fb, int=
 n)
> +{
> +	struct msm_drm_private *priv =3D fb->dev->dev_private;
> +	struct drm_gpuvm *vm =3D priv->kms->vm;
> +	int i;
> +
> +	for (i =3D 0; i < n; i++) {
> +		msm_gem_unpin_iova(fb->obj[i], vm);
> +		msm_gem_vma_put(fb->obj[i]);
> +	}
> +}
> +
>  /* prepare/pin all the fb's bo's for scanout.
>   */
>  int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirty=
fb)
> @@ -102,8 +114,17 @@ int msm_framebuffer_prepare(struct drm_framebuffer *=
fb, bool needs_dirtyfb)
>  		ret =3D msm_gem_get_and_pin_iova(fb->obj[i], vm, &msm_fb->iova[i]);
>  		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
>  			      fb->base.id, i, msm_fb->iova[i], ret);
> -		if (ret)
> +		if (ret) {
> +			msm_gem_vma_put(fb->obj[i]);
> +			msm_framebuffer_unpin_planes(fb, i);
> +			memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
> +			msm_fb->prepare_count--;
> +
> +			if (needs_dirtyfb)
> +				refcount_dec(&msm_fb->dirtyfb);
> +
>  			return ret;
> +		}

[Severity: High]
Can this underflow msm_fb->prepare_count when msm_framebuffer_prepare() is
called from the DPU writeback path?

During atomic commit preparation, drm_atomic_helper_prepare_planes() calls:

  drm_writeback_prepare_job()
    dpu_wb_conn_prepare_job()
      dpu_encoder_prepare_wb_job()
        dpu_encoder_phys_wb_prepare_wb_job()

In drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c,
dpu_encoder_phys_wb_prepare_wb_job() drops the error returned by
msm_framebuffer_prepare():

	wb_enc->wb_job =3D job;
	wb_enc->wb_conn =3D job->connector;

	wb_cfg =3D &wb_enc->wb_cfg;

	memset(wb_cfg, 0, sizeof(struct dpu_hw_wb_cfg));

	ret =3D msm_framebuffer_prepare(job->fb, false);
	if (ret) {
		DPU_ERROR("prep fb failed, %d\n", ret);
		return;
	}

And in drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c,
dpu_wb_conn_prepare_job() unconditionally returns 0:

	dpu_encoder_prepare_wb_job(dpu_wb_conn->wb_enc, job);

	return 0;

Because dpu_wb_conn_prepare_job() returns 0, drm_writeback_prepare_job()
sets job->prepared =3D true, and the commit proceeds with wb_cfg->dest.plan=
e_addr[]
left at 0.

When drm_writeback_cleanup_job() later runs (either on commit completion or
if a subsequent plane's prepare_fb() fails), job->prepared is true, so it
calls:

  dpu_wb_conn_cleanup_job()
    dpu_encoder_cleanup_wb_job()
      dpu_encoder_phys_wb_cleanup_wb_job()
        msm_framebuffer_cleanup(job->fb, false)

Since msm_framebuffer_prepare() now decrements msm_fb->prepare_count back to
0 on error, won't the subsequent call to msm_framebuffer_cleanup() decrement
msm_fb->prepare_count a second time, underflowing it to UINT_MAX (or
prematurely unpinning the framebuffer if another plane prepared it in the
meantime)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-fd-kms-fix=
-smmu-v5-0-a5b0b284aead@oss.qualcomm.com?part=3D2
