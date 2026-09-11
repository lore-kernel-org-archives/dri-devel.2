Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B7BC79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9772F10E16C;
	Fri, 11 Sep 2026 06:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Injc52pe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B8CB10E16C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 06:24:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B924601EF;
 Fri, 11 Sep 2026 06:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BFB1F000FF;
 Fri, 11 Sep 2026 06:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789107847;
 bh=dYvCKz5DeA07CbOMaCNvDOOIzTM9msnppU/M7VobgzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Injc52peb/PCcZbOyp+mX4qxHf5rerkT+uBptY0C8rAtpxwuQnIIcxJJKIJ+vPUwa
 6+IBP8c2awvN0IPURr+h+DbmJ+OJ/hr+S37Vmb4HYvMlJ13HhzHwh+ybsda3xadWYC
 ysYLa73qYW8oDbAQJkljgkclXYQ4N9/MN+P5RUagE4dCTipkU+auaekDw8+kMYYvWe
 KVg24d7CW/TSnOiIjq2Vwr4V/gMocUd2AEjU+HNLZIufavknzUbHF8K7iJZ92OYVw6
 FyOWPsUuKaJB9KVRWptJEpWXMBvsw2mzeUXWukjrZcltU3nObplzP+I/SIQIHvLDxj
 0gCtixw0oUZZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] gpu: host1x: validate the firewall source mapping
To: "Slavin Liu" <bolin.liu@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260911060933.94619-1-bolin.liu@seu.edu.cn>
References: <20260911060933.94619-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 06:24:07 +0000
Message-Id: <20260911062407.B2BFB1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IS_ERR() check for host1x_bo_mmap() return values across m=
ultiple functions.
- [High] BO reference and mapping leak on failure paths in pin_job()
- [High] Passing ERR_PTR to drm_syncobj_replace_fence() after host1x_fence_=
create() fails.
--

commit 1a11db6d4b6dd9dc137819f2fb17f9728ae00690
Author: Slavin Liu <bolin.liu@seu.edu.cn>

gpu: host1x: validate the firewall source mapping

This commit adds missing validation for the firewall source mapping in
copy_gathers(). It correctly rejects an ERR_PTR or NULL source mapping
before copying gather commands, fixing a potential out-of-bounds dereferenc=
e.

> diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
> --- a/drivers/gpu/host1x/job.c
> +++ b/drivers/gpu/host1x/job.c
> @@ -575,6 +575,10 @@ static inline int copy_gathers(struct device *host, =
struct host1x_job *job,
> =20
>  		/* Copy the gather */
>  		gather =3D host1x_bo_mmap(g->bo);
> +		if (IS_ERR(gather))
> +			return PTR_ERR(gather);
> +		if (!gather)
> +			return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but while this adds the proper
validation here, there are a few other pre-existing locations that only
check for NULL when calling host1x_bo_mmap().

For instance, in do_relocs() in the same file:

	cmdbuf_addr =3D host1x_bo_mmap(cmdbuf);
	if (unlikely(!cmdbuf_addr)) {

Could this also evaluate as true for an ERR_PTR and cause an out-of-bounds
pointer dereference when patching relocations?

Similarly, trace_write_gather() in drivers/gpu/host1x/hw/channel_hw.c:

	mem =3D host1x_bo_mmap(bo);
	if (mem) {

And show_channel_gathers() in drivers/gpu/host1x/hw/debug_hw.c:

	mapped =3D host1x_bo_mmap(g->bo);
	if (!mapped) {
		host1x_debug_output(o, "[could not mmap]\n");
		continue;
	}

Do these paths also need IS_ERR() checks to prevent error pointers from
falling through to be dereferenced?

[Severity: High]
This is another pre-existing issue in the same file, but looking at
pin_job(), do the failure paths leak BO references or mappings?

When iterating over job->relocs, if host1x_bo_pin() fails:

		map =3D host1x_bo_pin(dev, bo, direction, NULL);
		if (IS_ERR(map)) {
			err =3D PTR_ERR(map);
			goto unpin;
		}

Since the jump to the unpin label calls host1x_job_unpin(job), which only
processes items already added to the job->unpins array, does this skip
releasing the BO reference acquired by the host1x_bo_get() just above it?

Also in pin_job(), within the gathers loop, if alloc_iova() fails:

			alloc =3D alloc_iova(&host->iova, gather_size >> shift,
					   host->iova_end >> shift, true);
			if (!alloc) {
				err =3D -ENOMEM;
				goto put;
			}

Does jumping to the put label leave the successfully created map orphaned
without calling host1x_bo_unpin(map)?

[Severity: High]
This is also a pre-existing issue, but I noticed a potential problem with
fence creation error handling in drivers/gpu/drm/tegra/submit.c.

In tegra_drm_ioctl_channel_submit(), if host1x_fence_create() fails:

	if (IS_ERR(fence)) {
		err =3D PTR_ERR(fence);
		SUBMIT_ERR(context, "failed to create postfence: %d", err);
	}

	drm_syncobj_replace_fence(syncobj, fence);

Does execution fall through after the failure and pass the error pointer
directly to drm_syncobj_replace_fence()? It appears
drm_syncobj_replace_fence() evaluates the pointer as true and calls
dma_fence_get(fence), which will dereference the error pointer during
kref_get().

>  		memcpy(job->gather_copy_mapped + offset, gather + g->offset,
>  		       g->words * sizeof(u32));
>  		host1x_bo_munmap(g->bo, gather);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911060933.9461=
9-1-bolin.liu@seu.edu.cn?part=3D1
