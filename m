Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91362CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0520C10EF90;
	Mon,  8 Jun 2026 08:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ADNrHD/o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD1C10EF90
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 08:50:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA84A417B4;
 Mon,  8 Jun 2026 08:50:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688141F00893;
 Mon,  8 Jun 2026 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780908643;
 bh=BJF0y6xWfvpmDUzHhswGd2EIqoyTRaj3U3VOes97wCE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ADNrHD/o+jHirE7w1H6ltfNFUqLzxkeLiIyZ1ox6cBpqzfFSvQcg/KNPqDCTJypDx
 uk6RUvOns/x7kWSlze87TbwUnVXH6er9JNjG/i21s4PaZ7h3dUq01E/bpjVnKZOqUQ
 fJwcJl3HZABmcpkK4PVSZL+PX7W1sLPNcv3Bzfzcd9mpdVg4z9uSGuPci2aKzQWjr5
 eqd2k2r3P51m5tzh+G6zzefWtz5n2eReGI9pFFHdwOjFF8lME6pBTza81Ltge5aRrV
 KneXyOriH3YWnpz/t/C6fTsYOE32N6IIrNLK7T/5qI/sNXmSnpF4TP5wze4I5yMpdI
 exCaPQ4rEDpZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: Fix dma_fence reference leak on error
 paths in rocket_job_run()
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org
In-Reply-To: <20260608083824.775261-1-zhaojinming@uniontech.com>
References: <20260608083824.775261-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:50:43 +0000
Message-Id: <20260608085043.688141F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `pm_runtime_get_sync()` error path fails to decrement the runt=
ime PM usage counter, permanently leaking the reference.
- [High] Returning an unsignaled dma_fence instead of an error pointer on j=
ob submission failure triggers a kernel WARN.
--

commit f0df2d483139ad216e9d43923cbf9543a8f4e81c
Author: ZhaoJinming <zhaojinming@uniontech.com>

accel/rocket: Fix dma_fence reference leak on error paths in rocket_job_run=
()

In rocket_job_run(), after creating a fence at line 305 and taking an
extra reference for job->done_fence at line 311 via dma_fence_get(),
two error paths fail to release that extra reference before returning.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f960ccb..fc10703534e37 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -311,12 +311,19 @@ static struct dma_fence *rocket_job_run(struct drm_=
sched_job *sched_job)
>  	job->done_fence =3D dma_fence_get(fence);
> =20
>  	ret =3D pm_runtime_get_sync(core->dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak the
runtime PM usage counter?=20

pm_runtime_get_sync() increments the device's usage counter before attempti=
ng
to resume the device. If the resume fails, it returns a negative error code
but the usage counter remains incremented.=20

Without explicitly dropping this usage counter (e.g., using
pm_runtime_put_noidle()), could repeated failures prevent the NPU from ever
suspending again?

>  		return fence;

[Severity: High]
This is also a pre-existing issue, but will returning the valid, unsignaled
fence instead of ERR_PTR(ret) trigger a kernel WARN?

Since the hardware wasn't submitted, the fence refcount immediately hits 0
after the DRM scheduler drops its initial reference. dma_fence_release()
detects pending callbacks on an unsignaled fence and triggers a loud kernel
WARN(1, "Fence ... released with pending signals!\n"), forcibly signaling it
with -EDEADLK.

Should this path destroy the fence and return ERR_PTR(ret) so the scheduler
cleanly aborts the job?

> +	}
> =20
>  	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(core->dev);
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
>  		return fence;

[Severity: High]
This is a pre-existing issue, but similar to the above, does returning the
unsignaled fence here instead of ERR_PTR(ret) cause the same DRM scheduler
WARN when the fence is released?

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608083824.7752=
61-1-zhaojinming@uniontech.com?part=3D1
