Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB55606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7YaLmxD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06D410F36C;
	Tue, 20 Oct 2026 08:09:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 577D110F36C
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:09:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2874941A85;
 Tue, 20 Oct 2026 08:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA87A1F000C4;
 Tue, 20 Oct 2026 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483775;
 bh=PWlx/Vuh6oFuKA/S0KvTXxS61rcQXfBwyRa+Pc16cjA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e7YaLmxDiSbCXH2Eh7myOfk6eGQL5M2GIWE1Nw62YTgg9mtTc3MU4ujOjIdO/y9jo
 WNuaYnbVi4xtrAumUu685Imuk2N6eU+1Zocf2Fj9PJqkFNLiKmiygkbLanxLJvXTW3
 pS9zgjcfTFbsXgtEycDhmkKVhnsz7GbO89i5Wn0PULyADOpJkMnvaGVvQcdsLBt1yl
 H9JLH/REHclS3T+yZklz+LHZPC2AZJI0UgcSf9w0MrooJgQzCCSdbM2zORB+F2XtlR
 eYvqrGQ3ZOYHu2wMaSQ90ZS+z9jsSK0Yl3Ucjlc9I1LptpenaRRubAJ1mPlAdOCcxr
 bHajBh0joi/mA==
Message-ID: <sashiko-outbox-178483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drm/msm/a5xx: Hold a CPU latency request while
 the GPU is powered
To: "Fabricio Akio" <fabricioakio@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-a5xx-gpu-pm-v2-2-457aafbb28da@gmail.com>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
 <20261019-a5xx-gpu-pm-v2-2-457aafbb28da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:09:34 +0000
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
- [High] drm/msm/a5xx: premature pm_qos_req removal in a5xx_destroy() befor=
e cleanup
--

commit fc8618fd147137559c55740f177ada72c5eca286
Author: Fabricio Akio <fabricioakio@gmail.com>

drm/msm/a5xx: Hold a CPU latency request while the GPU is powered

This patch holds a CPU latency QoS request while A508, A509, and A512 GPUs
are powered on so the SoC does not enter system-level power collapse while
GPU work is active. The request is added on GPU resume and removed on GPU
suspend or destruction.

> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a5xx_gpu.c
> index 0aff8252a00f9..1d4993f8cb7c4 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -1060,6 +1060,10 @@ static void a5xx_destroy(struct msm_gpu *gpu)
>  		drm_gem_object_put(a5xx_gpu->shadow_bo);
>  	}
> =20
> +	/* Still held if suspending the GPU failed before it was destroyed */
> +	if (cpu_latency_qos_request_active(&a5xx_gpu->pm_qos_req))
> +		cpu_latency_qos_remove_request(&a5xx_gpu->pm_qos_req);
> +
>  	adreno_gpu_cleanup(adreno_gpu);
>  	kfree(a5xx_gpu);
>  }

[Severity: High]
Should the removal of a5xx_gpu->pm_qos_req in a5xx_destroy() happen after
adreno_gpu_cleanup(adreno_gpu) rather than before it?

In adreno_unbind(), if adreno_system_suspend() fails (for example, timing
out with -EBUSY because a GPU submission is hung or still active, or if
pm_runtime_force_suspend() fails), adreno_system_suspend() restarts the
scheduler and returns with runtime PM still enabled:

drivers/gpu/drm/msm/adreno/adreno_device.c:adreno_system_suspend() {
	remaining =3D wait_event_timeout(gpu->retire_event,
				       gpu->active_submits =3D=3D 0,
				       msecs_to_jiffies(1000));
	if (remaining =3D=3D 0) {
		dev_err(dev, "Timeout waiting for GPU to suspend\n");
		ret =3D -EBUSY;
		goto out;
	}

	ret =3D pm_runtime_force_suspend(dev);
out:
	if (ret)
		resume_scheduler(gpu);
}

adreno_unbind() then proceeds directly into gpu->funcs->destroy(gpu) ->
a5xx_destroy() while runtime PM and gpu->worker are still running.

Runtime PM is only disabled and gpu->worker is only stopped inside
adreno_gpu_cleanup() -> msm_gpu_cleanup():

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_gpu_cleanup() {
	...
	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);

	if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
		pm_runtime_disable(&priv->gpu_pdev->dev);

	msm_gpu_cleanup(&adreno_gpu->base);
}

Meanwhile, recover_worker on gpu->worker runs a5xx_recover() ->
adreno_recover(), which directly calls gpu->funcs->pm_suspend(gpu) and
gpu->funcs->pm_resume(gpu).

If cpu_latency_qos_remove_request(&a5xx_gpu->pm_qos_req) runs before
adreno_gpu_cleanup(adreno_gpu), can recover_worker or runtime PM execute
a5xx_pm_suspend() or a5xx_pm_resume() concurrently with or after the
removal, re-adding &a5xx_gpu->pm_qos_req to cpu_latency_constraints right
before kfree(a5xx_gpu) frees it?

[ ... ]

>
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64

Boris
=E5=9C=A8=E8=BF=9B=E8=A1=8C=E6=B7=B1=E5=85=A5=E5=AE=A1=E6=9F=A5=E6=97=B6=EF=
=BC=8C=E6=88=91=E5=8F=91=E7=8E=B0=E4=BA=86=E4=B8=80=E4=B8=AA=E6=BD=9C=E5=9C=
=A8=E7=9A=84=E9=87=8A=E6=94=BE=E5=90=8E=E4=BD=BF=E7=94=A8=EF=BC=88Use-After=
-Free=EF=BC=89=E9=97=AE=E9=A2=98=EF=BC=8C=E5=B7=B2=E5=9C=A8=E4=B8=8A=E9=9D=
=A2=E7=9A=84=E5=86=85=E8=81=94=E8=AF=84=E8=AE=BA=E4=B8=AD=E8=AF=A6=E7=BB=86=
=E8=AF=B4=E6=98=8E=E3=80=82

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-a5xx-gpu-p=
m-v2-0-457aafbb28da@gmail.com?part=3D2
