Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B21CD8CAC
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7982B10E1A4;
	Tue,  9 Jun 2026 08:29:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HdV7jFTF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 539C810E1A4
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:29:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1714A416C6;
 Tue,  9 Jun 2026 08:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C693F1F00893;
 Tue,  9 Jun 2026 08:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780993748;
 bh=KoiUgA6e0+WiyPSaC0WbA+wzbxNPIszzpZJoQQ5I0o4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HdV7jFTFR+MK0xDMxDzeAApRFYUpKFg4FQeDsuXf6OWW+hCUlpZO/HZZYmR1korqN
 L0gCPYBG2yJ2j0Fxy36EIeJCYtbE5YKO58mjFEwM3M4xpXmVfTODkWHhVdH7kchWer
 YMPBKYVRdCImlU0VBokkip3U97NfsIEyjM1B8Dv35X27lkDatM2NLzyTqekfABEJqF
 M2dNsnrrOoLiI5Zr+WNsLqpfu7U7X8rEwVDP/fg3Sf3rNR2kcrGowpLeKngQFdTxkx
 oqAk8RkhMOJR8NtvkY/N3757JbU+B08cJX1ux2sut+g0kp4v4pUOf0rIaDkbapDK+Z
 89ORLBaj+nxGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] gpu: host1x: Change pin_job() return type to int
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-b4-host1x-small-fixes-a-v1-5-7c1131c0b3ad@nvidia.com>
References: <20260609-b4-host1x-small-fixes-a-v1-5-7c1131c0b3ad@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:29:06 +0000
Message-Id: <20260609082907.C693F1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An integer overflow in copy_gathers() leads to a massive heap =
buffer overflow during memcpy.
- [High] Silent failure when iommu_map_sgtable() returns a negative error c=
ode.
- [High] Multiple error paths in pin_job() leak host1x_bo references and pi=
nned host1x_bo_mapping objects.
- [High] Missing or incorrect validation of host1x_bo_mmap() return value c=
auses kernel panic.
--

commit 49509dd1b9a9c195fff52b9936852ca75bde12b1
Author: Mikko Perttunen <mperttunen@nvidia.com>

gpu: host1x: Change pin_job() return type to int

pin_job() returns negative errno values on error paths (-EINVAL,
-ENOMEM, PTR_ERR() of mapping) but was declared as unsigned int.
The caller would immediately cast back to int, so there was no
functional issue, but it still warrants fixing.

> diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
> index 3ed49e1fd9332..1659793195991 100644
> --- a/drivers/gpu/host1x/job.c
> +++ b/drivers/gpu/host1x/job.c
[ ... ]
> @@ -138,7 +138,7 @@ void host1x_job_add_wait(struct host1x_job *job, u32 =
id, u32 thresh,
>  }
>  EXPORT_SYMBOL(host1x_job_add_wait);
> =20
> -static unsigned int pin_job(struct host1x *host, struct host1x_job *job)
> +static int pin_job(struct host1x *host, struct host1x_job *job)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing pin_job(),
does this code silently ignore mapping failures?

drivers/gpu/host1x/job.c:pin_job() {
    ...
			err =3D iommu_map_sgtable(host->domain,
						iova_dma_addr(&host->iova, alloc),
						map->sgt, IOMMU_READ);
			if (err =3D=3D 0) {
				__free_iova(&host->iova, alloc);
				err =3D -EINVAL;
				goto put;
			}
    ...
}

iommu_map_sgtable() returns a positive mapped size on success and a negative
error code (like -EINVAL or -ENOMEM) on failure.

Since the check is exactly if (err =3D=3D 0), a negative error code evaluat=
es
to false, skipping the error path (goto put;).

This allows the code to proceed with an unmapped IOVA, which would cause the
IOMMU to block hardware memory access and trigger faults during execution.

Is this check intended to be if (err <=3D 0)?


[Severity: High]
This is a pre-existing issue, but do these error paths leak host1x_bo
references and mappings?

drivers/gpu/host1x/job.c:pin_job() {
    ...
		map =3D host1x_bo_pin(dev, bo, direction, NULL);
		if (IS_ERR(map)) {
			err =3D PTR_ERR(map);
			goto unpin;
		}

		if (map->chunks > 1) {
			err =3D -EINVAL;
			goto unpin;
		}

		job->addr_phys[job->num_unpins] =3D map->phys;
		job->unpins[job->num_unpins].map =3D map;
		job->num_unpins++;
    ...
}

In the loop, job->num_unpins is only incremented at the end of each iterati=
on.

If an error occurs midway (e.g., map->chunks > 1), the loop jumps to unpin.

The cleanup routine host1x_job_unpin() iterates strictly up to job->num_unp=
ins,
failing to release the BO reference and unpin the memory allocated during t=
he
currently failing iteration.

Could a malicious user repeatedly trigger this error path to exhaust kernel
memory?


[Severity: High]
This is a pre-existing issue, but does this code dereference an error
pointer if host1x_bo_mmap() fails?

drivers/gpu/host1x/job.c:do_relocs() {
    ...
		if (!cmdbuf_addr) {
			cmdbuf_addr =3D host1x_bo_mmap(cmdbuf);

			if (unlikely(!cmdbuf_addr)) {
    ...
}

And similarly in copy_gathers():

drivers/gpu/host1x/job.c:copy_gathers() {
    ...
		gather =3D host1x_bo_mmap(g->bo);
		memcpy(job->gather_copy_mapped + offset, gather + g->offset,
		       g->words * sizeof(u32));
    ...
}

host1x_bo_mmap() returns an ERR_PTR() on failure (e.g., -ENOMEM), not NULL.

In do_relocs(), the check !cmdbuf_addr fails to detect an error pointer.
In copy_gathers(), the result is passed directly to memcpy() without any
checks.

Could this lead to a page fault and kernel panic if userspace triggers a
vmap failure?


[Severity: Critical]
This isn't a bug introduced by this patch, but can this size calculation
overflow on 32-bit platforms?

drivers/gpu/host1x/job.c:copy_gathers() {
    ...
	for (i =3D 0; i < job->num_cmds; i++) {
		struct host1x_job_gather *g;

		if (job->cmds[i].is_wait)
			continue;

		g =3D &job->cmds[i].gather;

		size +=3D g->words * sizeof(u32);
	}
    ...
}

On 32-bit platforms, size_t size is 32 bits.

If an ioctl is submitted with a large number of command buffers
(e.g., num_cmdbufs =3D 65541 and words =3D 16383), the size calculation res=
ults
in 4,295,027,340, wrapping around to 60,044.

dma_alloc_wc() then allocates this undersized buffer, and the subsequent
memcpy() loop would copy out of bounds.

Could this lead to a massive heap buffer overflow?

>  	unsigned long mask =3D HOST1X_RELOC_READ | HOST1X_RELOC_WRITE;
>  	struct host1x_client *client =3D job->client;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-b4-host1x-=
small-fixes-a-v1-0-7c1131c0b3ad@nvidia.com?part=3D5
