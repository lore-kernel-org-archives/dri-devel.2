Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADA606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7c7CvoB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A55910E5C3;
	Fri, 30 Oct 2026 17:40:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DC810E573
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:40:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB6C260202;
 Fri, 30 Oct 2026 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455D01F000C1;
 Fri, 30 Oct 2026 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793382025;
 bh=MoYlMLKOK1BGRJJir6/w8mlA28bFNCiZedRdsOjepxw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S7c7CvoBJxaZN72XgSeuCsm6C/QJ5TKMCs10wiLgPrg9ep4YWR+VRJFmZreqV6DkQ
 OAk5Bl68PdH/N9zI+JvPvYz/xaUM4Ofludfylg9ANKRhOG643ZEWTtumcbEAuf0rOP
 uKL6XzJSzJk4SlzaHqWAuGnUmmeBs3GQ8XILXZEUmDVTUrMZ84IEomOasmcA6X4Lco
 UwNIpMuppyoG4pc1lI0a2Q/uiPK1q5cft/dWbFnXW+cwnu53heuqW2nixzWj+X2T+Y
 F1Xnko87Nw63kGSVBstlYKYWmqlGz8l1prSxTWEdSrroywj7hzjFEC4gV9DegjHBfM
 /pw6es3Sv8RUQ==
Message-ID: <sashiko-outbox-191354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] drm/msm: Attach a driver to the GMU
To: "Akhil P Oommen" <akhilpo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261030-gmu-sync-state-fix-v2-6-89d3082d97af@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
 <20261030-gmu-sync-state-fix-v2-6-89d3082d97af@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:40:24 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] drm/msm/adreno: uninitialized GMU in a6xx_gpu_init() if GMU node i=
s absent
- [High] drm/msm/adreno: preemption GEM BO and GPUVM leak in a6xx_destroy()
- [High] drm/msm/adreno: use-after-destroy in adreno_unbind() via adreno_sy=
stem_suspend()
- [Medium] drm/msm/adreno: missing DL_FLAG_STATELESS on gmu_mx_link in a6xx=
_gmu.c
- [Medium] drm/msm: wrong teardown order in msm_devfreq_cleanup()
--

commit 49c34de4e2ea2b4f8e8e635b9b2c18d24a4a790e
Author: Akhil P Oommen <akhilpo@oss.qualcomm.com>

drm/msm: Attach a driver to the GMU

This commit attaches a platform driver to the GMU and registers it as a
component of the DRM master device to resolve genpd sync_state warnings. It
also moves devfreq initialization and cleanup to the master device bind and
unbind paths so that both the GPU and GMU are bound before devfreq requests
are handled.

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gmu.c
> index 5d96b55a624a6..715d70a510046 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
[ ... ]
> @@ -2531,6 +2512,7 @@ int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct=
 device_node *node)
>  	/* Initialize RPMh */
>  	a6xx_gmu_rpmh_init(gmu);
> =20
> +	mutex_init(&gmu->lock);
>  	gmu->initialized =3D true;
> =20
>  	return 0;

[Severity: Medium]
Now that gmu->dev is bound to adreno_gmu_driver, does gmu_mx_link in
a6xx_gmu_pdev_bind() also need DL_FLAG_STATELESS?

In a6xx_gmu_pdev_bind(), gmu->gmu_mxpd is a driverless virtual genpd device
attached via dev_pm_domain_attach_by_name(gmu->dev, "gmu_mx"), and the devi=
ce
link is created without DL_FLAG_STATELESS:

	if (gmu->gmu_mxpd) {
		gmu_mx_link =3D device_link_add(gmu->dev, gmu->gmu_mxpd, DL_FLAG_PM_RUNTI=
ME);
		if (!gmu_mx_link) {
			ret =3D -ENODEV;
			goto detach_gmu_mxpd;
		}
	}

Unlike cx_link, which was given DL_FLAG_STATELESS in commit 64cbd6086a48,
gmu_mx_link is created as a managed link in DL_STATE_DORMANT. When
a6xx_gmu_probe() finishes binding gmu->dev, driver_bound() ->
device_links_driver_bound() checks managed consumer links and triggers
WARN_ON(link->status !=3D DL_STATE_CONSUMER_PROBE) before transitioning the
link to DL_STATE_ACTIVE.

In addition, if a6xx_gmu_pdev_bind() fails at the detach_gxpd label,
device_link_del(gmu_mx_link) is called on a managed link, which triggers
WARN(1, "Unable to drop a managed device link reference\n") in
device_link_put_kref() without deleting the link. And when a6xx_gmu_destroy=
()
later calls dev_pm_domain_detach(gmu->gmu_mxpd, false), device_links_purge()
triggers WARN_ON(link->status !=3D DL_STATE_DORMANT && link->status !=3D
DL_STATE_NONE).

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 92e8c8abb86da..0bdab662dafac 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
[ ... ]
> @@ -2705,7 +2703,6 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_dev=
ice *dev)
>  		gpu->num_perfcntr_groups =3D a8xx_num_perfcntr_groups;
>  	}
> =20
> -	mutex_init(&a6xx_gpu->gmu.lock);
>  	spin_lock_init(&a6xx_gpu->aperture_lock);
> =20
>  	adreno_gpu->registers =3D NULL;
> @@ -2713,10 +2710,9 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_de=
vice *dev)
>  	/* Check if there is a GMU phandle and set it up */
>  	struct device_node *node __free(device_node) =3D
>  		of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
> -	/* FIXME: How do we gracefully handle this? */
> -	BUG_ON(!node);
> -
> -	adreno_gpu->gmu_is_wrapper =3D of_device_is_compatible(node, "qcom,adre=
no-gmu-wrapper");
> +	WARN_ON(!node);
> +	adreno_gpu->gmu_is_wrapper =3D of_device_is_compatible(node,
> +							     "qcom,adreno-gmu-wrapper");

[Severity: High]
As reported by Sashiko on v1 [1], what happens in a6xx_gpu_init() if the
qcom,gmu property is missing or points to a disabled node?

In add_gpu_components(), the GMU component is only added to the match list
when of_device_is_available(gmu_np) is true. If the node is absent or
disabled, component_bind_all() in msm_drm_init() succeeds after running
adreno_bind() -> a6xx_gpu_init() without ever calling a6xx_gmu_bind().

Because mutex_init(&a6xx_gpu->gmu.lock) and the GMU initialization were mov=
ed
to a6xx_gmu_pdev_bind() and a6xx_gmu_wrapper_pdev_bind(), msm_drm_init() th=
en
calls msm_devfreq_init() -> msm_devfreq_target() -> a6xx_gpu_set_freq(),
which locks the uninitialized a6xx_gpu->gmu.lock mutex and calls
a6xx_gmu_set_freq():

	for (perf_index =3D 0; perf_index < gmu->nr_gpu_freqs - 1; perf_index++)
		if (gpu_freq =3D=3D gmu->gpu_freqs[perf_index])
			break;

With gmu->nr_gpu_freqs still 0, gmu->nr_gpu_freqs - 1 underflows in the
unsigned comparison with perf_index and reads out of bounds past
gmu->gpu_freqs[], and subsequent runtime PM resume calls dereference NULL
gmu->dev and gmu->mmio pointers. Should a6xx_gpu_init() return an error when
!of_device_is_available(node)?

>  	adreno_gpu->base.hw_apriv =3D
>  		!!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> @@ -2769,15 +2765,6 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_de=
vice *dev)
>  	if (adreno_is_a618(adreno_gpu) || adreno_is_7c3(adreno_gpu))
>  		priv->gpu_clamp_to_idle =3D true;
> =20
> -	if (adreno_has_gmu_wrapper(adreno_gpu) || adreno_has_rgmu(adreno_gpu))
> -		ret =3D a6xx_gmu_wrapper_init(a6xx_gpu, node);
> -	else
> -		ret =3D a6xx_gmu_init(a6xx_gpu, node);
> -	if (ret) {
> -		a6xx_destroy(&(a6xx_gpu->base.base));
> -		return ERR_PTR(ret);
> -	}
> -
>  	adreno_gpu->uche_trap_base =3D 0x1fffffffff000ull;
> =20
>  	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,

[Severity: High]
By moving GMU initialization out of a6xx_gpu_init() into a separate
component bound after adreno_bind(), can a6xx_destroy() leak the preemption
GEM buffer objects and gpu->vm when a6xx_gmu_bind() fails or defers probe?

Previously, if a6xx_gmu_init() or a6xx_gmu_wrapper_init() returned an error
such as -EPROBE_DEFER, a6xx_gpu_init() failed before reaching
a6xx_preempt_init(gpu).

Now, adreno_bind() runs a6xx_gpu_init() all the way through
a6xx_preempt_init(gpu), which allocates and pins preempt_bo[],
preempt_smmu_bo[], and preempt_postamble_bo in gpu->vm on preemption-enabled
GPUs. If the subsequent a6xx_gmu_bind() returns -EPROBE_DEFER,
component_bind_all() unwinds by calling adreno_unbind() -> a6xx_destroy().

However, a6xx_destroy() never calls a6xx_preempt_fini(gpu), and
a6xx_preempt_fini() itself only releases preempt_bo[i] while leaving
preempt_smmu_bo[i] and preempt_postamble_bo pinned in gpu->vm when
msm_gpu_cleanup() calls drm_gpuvm_put(gpu->vm).

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm=
/msm/adreno/adreno_device.c
> index 6b694b8bf8e3d..7066be3b8e156 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -250,7 +250,6 @@ static int adreno_bind(struct device *dev, struct dev=
ice *master, void *data)
>  	return 0;
>  }
> =20
> -static int adreno_system_suspend(struct device *dev);
>  static void adreno_unbind(struct device *dev, struct device *master,
>  		void *data)
>  {

[Severity: High]
Was the call to adreno_system_suspend(dev) in adreno_unbind() meant to be
removed when moving it to msm_drm_uninit()?

In adreno_unbind(), we still have:

	if (pm_runtime_enabled(dev))
		WARN_ON_ONCE(adreno_system_suspend(dev));
	gpu->funcs->destroy(gpu);

Because add_gpu_components() registers the GPU component before the GMU
component, component_unbind_all() in msm_drm_uninit() unbinds the GMU first
(a6xx_gmu_unbind() -> a6xx_gmu_destroy()) and the GPU second
(adreno_unbind()).

If the earlier adreno_system_suspend(gpu_dev) call in msm_drm_uninit() times
out waiting for gpu->active_submits =3D=3D 0 and returns -EBUSY,
pm_runtime_force_suspend() is skipped and pm_runtime_enabled(dev) remains
true. Then component_unbind_all() runs a6xx_gmu_destroy(), which unmaps
gmu->mmio, detaches gmu->cxpd and gmu->gxpd, and frees the GMU interrupts,
before adreno_unbind() calls adreno_system_suspend(dev) again and attempts =
to
suspend the GPU using the already-destroyed GMU.

> diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/=
msm_gpu_devfreq.c
> index 2e1d5c3432728..025e608f45b42 100644
> --- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> +++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
> @@ -221,8 +221,13 @@ void msm_devfreq_cleanup(struct msm_gpu *gpu)
>  	if (!has_devfreq(gpu))
>  		return;
> =20
> +	cancel_idle_work(df);
> +	cancel_boost_work(df);
> +
>  	devfreq_cooling_unregister(gpu->cooling);
>  	dev_pm_qos_remove_request(&df->boost_freq);
> +	devm_devfreq_remove_device(&gpu->pdev->dev, df->devfreq);
> +	df->devfreq =3D NULL;
>  }

[Severity: Medium]
Should devm_devfreq_remove_device() be called before
dev_pm_qos_remove_request(&df->boost_freq) in msm_devfreq_cleanup()?

When msm_devfreq_boost() sets a non-zero df->boost_freq, a subsequent
msm_devfreq_suspend() or cancel_boost_work() cancels the delayed work witho=
ut
resetting df->boost_freq to 0.

If dev_pm_qos_remove_request(&df->boost_freq) is called while df->devfreq is
still registered, removing the non-zero QoS request fires devfreq's
nb_min notifier (qos_min_notifier_call() -> update_devfreq() ->
devfreq_set_target() -> msm_devfreq_target()). On GPUs where
gpu->funcs->gpu_set_freq is NULL (such as A3xx-A5xx and GMU-wrapper targets=
),
msm_devfreq_target() calls dev_pm_opp_set_rate() without checking
df->suspended, which re-votes clocks and OPPs after adreno_system_suspend()
in msm_drm_uninit() has already suspended the GPU.

[1] https://lore.kernel.org/r/20260513-gmu-sync-state-fix-v1-5-6e33e6aa9b4f=
@oss.qualcomm.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-gmu-sync-s=
tate-fix-v2-0-89d3082d97af@oss.qualcomm.com?part=3D6
