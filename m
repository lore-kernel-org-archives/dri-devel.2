Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0620FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 22:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6259610EA78;
	Mon, 29 Jun 2026 22:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HyOTtrcT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF0F10EA78
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 22:56:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B11843418;
 Mon, 29 Jun 2026 22:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A791F000E9;
 Mon, 29 Jun 2026 22:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782773790;
 bh=+O8BXkUHnkdYWK3MPMj392yLwDTu46USoIFiw66XA+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HyOTtrcTMuNNqAdsPa/l8bEcc//Tz8DprA5Rvs1IpqTP3u+kll2dF00NaOOm0jnri
 KrmMKbw6y8Ufdu5BavELL1n2Qz0B8y7Qsy8yYgvwphsul0PCZqw/IjWuSY1+NkLfIR
 B/QfLLkOFvxWM4LR1wgIYriQPWAam46Yu8h0jDw+95/23cwiZFL2CjfkuhQ9wqy255
 ExlX5mvu5sPqycsur86AqsSWx9DqnHgtylvMslXHyMsrDjGvh0NuMDDpOkffh71E9i
 wndMcAmlAOW7dPFwDqrFvLfiol2niz4zRNtF/9BVEgWSnpnXtehNDB5e+YPiFtRvLY
 RyAClAi028HUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] Revert "nouveau/gsp: fix suspend/resume
 regression on r570 firmware"
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629224350.2870201-2-lyude@redhat.com>
References: <20260629224350.2870201-1-lyude@redhat.com>
 <20260629224350.2870201-2-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:56:29 +0000
Message-Id: <20260629225630.33A791F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failing to restore hardware state if `r570_fbsr_suspend` encounter=
s an error midway through execution.
--

commit b9938c05e690ef9ccc55ef6c3f7541c371717b40
Author: Lyude Paul <lyude@redhat.com>

Revert "nouveau/gsp: fix suspend/resume regression on r570 firmware"

This reverts commit 8302d0afeaec0bc57d951dd085e0cffe997d4d18. It turns out
this looked like the right fix on some systems, but it causes runtime PM to
actually fail on many laptops.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 8ef8b4f655883..2945d5b4e5707 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
[ ... ]
> @@ -92,7 +92,7 @@ r570_fbsr_init(struct nvkm_gsp *gsp, struct sg_table *s=
gt, u64 size, bool runtim
>  }
> =20
>  static int
> -r570_fbsr_suspend(struct nvkm_gsp *gsp, bool runtime)
> +r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  {
>  	struct nvkm_subdev *subdev =3D &gsp->subdev;
>  	struct nvkm_device *device =3D subdev->device;

[Severity: High]
This is a pre-existing issue, but does r570_fbsr_suspend() need to
unwind hardware state changes if an error occurs?

Looking at the function body, hardware state is mutated upfront:

r570_fbsr_suspend() {
        ...
        /* Stop channel scheduling. */
        r570_fbsr_suspend_channels(gsp, true);

        /* Save BAR2 allocations to system memory. */
        list_for_each_entry(iobj, &imem->list, head) {
                if (iobj->preserve) {
                        ret =3D nvkm_instobj_save(iobj);
                        if (ret)
                                return ret;
                }
        }
        ...
        /* Disable BAR2 access. */
        device->bar->bar2 =3D false;
        ...
}

If a failure occurs (such as memory allocation failure in nvkm_instobj_save=
()
or later in nvkm_gsp_sg()), the function returns an error without reverting
these hardware changes.

The error propagates to nvkm_subdev_fini(), returning early without setting
subdev->use.enabled to false. During a suspend abort recovery,
nvkm_device_fini() attempts to restart failed devices via nvkm_subdev_init(=
).

However, because use.enabled is still true, the restart is skipped, meaning
the device's init and resume callbacks are never executed.

Could this leave the GPU permanently unusable with suspended channels and
disabled BAR2 access if a failure happens during suspend?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629224350.2870=
201-1-lyude@redhat.com?part=3D1
