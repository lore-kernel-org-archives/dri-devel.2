Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB2606AA04
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jR75QdVl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7D110E89E;
	Fri, 30 Oct 2026 10:46:26 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A36E10E89E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:46:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 783F76022F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FB01F00A15;
 Fri, 30 Oct 2026 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793357179;
 bh=84qPjXWwBvUcyX4eaQoPMb0cx5SJeY+Q+prjA+9xvQY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jR75QdVlKTiA1E7tJoraRuTuPf3OU1PpUhNHtbMc6mVH22RPeVIzYBWeHAX348Wte
 ZT9LTLTBKWuFua5vsbV6KzpCF+KI6GhpxjB701D6iw3clagU/g3MoeRLwQvqWCzW+N
 9xXhJl+bJhyPaeurb0B9UsX6edg6Fvq6PXpTYoal2htenmCjNjCOUpkwU6MPHTNUEr
 g4PBA09Bw3pJC/Eyr+9FWqtSKVo6NNyXy5kvTJsnwRR0dbqBzby9KqB8QfXAAk6CB5
 UtmCURsa9z7TwuaIWhKqQkb0c19mWbb1IU+St8i5o/PCuMJud6EzMSgqYhNa9n5+za
 PFDxiirBpzYtg==
Message-ID: <sashiko-outbox-190870@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] drm/msm/a6xx: Add A6xx IFPC support
To: "Konrad Dybcio" <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-4-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
 <20261030-topic-a6xx_ifpc-v1-4-6992841a9a32@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:46:18 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/a6xx: missing IFPC CP_SET_MARKER packets in a6xx_submit()
- [Medium] drm/msm/a6xx: perfcntr SELECT regs lost on IFPC in a6xx_perfcntr=
_configure()
--

commit bfad38c351383c6a537cd26f28ef21f13067df68
Author: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

drm/msm/a6xx: Add A6xx IFPC support

This commit adds A6xx-specific IFPC plumbing, including GMU WFI
configuration, power-up register list patching, CP_ME_INIT register list
programming, and skipping the A7xx HFI IFPC enable message on A6xx.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index e7c3da5d3ac64..8ea9ab5b98861 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c

[ ... ]

> @@ -878,6 +887,43 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu =
*gpu)
>  	a6xx_gpu->dynamic_sel_reglist_offset =3D dyn_pwrup_reglist_count;
>  }
> =20
> +static void a6xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> +{
> +	struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> +	struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> +	const struct adreno_reglist_list *reglist;
> +	void *ptr =3D a6xx_gpu->pwrup_reglist_ptr;
> +	struct cpu_gpu_lock *lock =3D ptr;
> +	u32 *dest =3D (u32 *)&lock->regs[0];
> +	int i;
> +
> +	lock->gpu_req =3D lock->cpu_req =3D lock->turn =3D 0;
> +	lock->list_length =3D 0;
> +
> +	/* Static IFPC-only registers */
> +	reglist =3D adreno_gpu->info->a6xx->ifpc_reglist;
> +	if (reglist) {
> +		for (i =3D 0; i < reglist->count; i++) {
> +			*dest++ =3D reglist->regs[i];
> +			*dest++ =3D gpu_read(gpu, reglist->regs[i]);
> +		}
> +		lock->list_length +=3D reglist->count * 2;
> +	}
> +
> +	/* The CP sees IFPC-only and IFPC + preemption as one list from list_of=
fset */
> +	lock->list_offset =3D lock->list_length;
> +
> +	/* Static IFPC + preemption registers */
> +	reglist =3D adreno_gpu->info->a6xx->pwrup_reglist;
> +	if (reglist) {
> +		for (i =3D 0; i < reglist->count; i++) {
> +			*dest++ =3D reglist->regs[i];
> +			*dest++ =3D gpu_read(gpu, reglist->regs[i]);
> +		}
> +		lock->list_length +=3D reglist->count * 2;
> +	}
> +}

[Severity: Medium]
When a performance counter stream is configured via
DRM_IOCTL_MSM_PERFCNTR_CONFIG, msm_gpu_sysprof_no_ifpc() allows the GPU to
enter IFPC between samples under the assumption that a6xx_perfcntr_configur=
e()
appends the configured SELECT registers to pwrup_reglist_ptr.

However, a6xx_perfcntr_configure() only populates pwrup_reglist_ptr when
info->family >=3D ADRENO_7XX_GEN1:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a6xx_perfcntr_configure() {
	if (to_adreno_gpu(gpu)->info->family >=3D ADRENO_7XX_GEN1) {
		WARN_ON(!a6xx_gpu->pwrup_reglist_emitted);

		struct cpu_gpu_lock *lock =3D a6xx_gpu->pwrup_reglist_ptr;
		int off =3D (2 * lock->ifpc_list_len) +
			  (2 * lock->preemption_list_len) +
			  (3 * a6xx_gpu->dynamic_sel_reglist_offset);
...

On A6xx, a6xx_patch_pwrup_reglist() uses the A6xx cpu_gpu_lock layout
(lock->list_length and lock->list_offset with register/value pairs) without
recording the base static offset in dynamic_sel_reglist_offset, and
a6xx_perfcntr_configure() leaves reglist as NULL.

Will entering IFPC on A6xx while a performance counter stream is active lose
the GX-domain performance counter SELECT registers when the GX power domain
collapses?

[ ... ]

> @@ -1485,8 +1564,12 @@ static int hw_init(struct msm_gpu *gpu)
>  	/* Enable the SQE_to start the CP engine */
>  	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
> =20
> -	if (adreno_is_a7xx(adreno_gpu) && !a6xx_gpu->pwrup_reglist_emitted) {
> -		a7xx_patch_pwrup_reglist(gpu);
> +	if (!a6xx_gpu->pwrup_reglist_emitted) {
> +		if (adreno_is_a7xx(adreno_gpu))
> +			a7xx_patch_pwrup_reglist(gpu);
> +		else
> +			a6xx_patch_pwrup_reglist(gpu);
> +
>  		a6xx_gpu->pwrup_reglist_emitted =3D true;
>  	}

[Severity: High]
In a7xx_submit(), the driver emits CP_SET_MARKER packets around command
submissions to disable IFPC before indirect buffers execute and re-enable it
after completion:

drivers/gpu/drm/msm/adreno/a6xx_gpu.c:a7xx_submit() {
	...
	OUT_PKT7(ring, CP_SET_MARKER, 1);
	OUT_RING(ring, 0x101); /* IFPC disable */
	...
	OUT_PKT7(ring, CP_SET_MARKER, 1);
	OUT_RING(ring, 0x100); /* IFPC enable */
}

However, a6xx_submit() in drivers/gpu/drm/msm/adreno/a6xx_gpu.c does not em=
it
these CP_SET_MARKER packets before the indirect buffer loop or after the
CACHE_FLUSH_TS event write.

Should a6xx_submit() also emit CP_SET_MARKER(0x101) and CP_SET_MARKER(0x100)
so that REG_A6XX_CP_CP2GMU_STATUS properly tracks IFPC eligibility across
submissions on A6xx?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-topic-a6xx=
_ifpc-v1-0-6992841a9a32@oss.qualcomm.com?part=3D4
