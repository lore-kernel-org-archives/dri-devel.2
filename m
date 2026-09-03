Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57779C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 11:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAE010F51E;
	Thu,  3 Sep 2026 11:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqonJ+nv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EEB10F51E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:30:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC06041A98;
 Thu,  3 Sep 2026 11:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840121F000E9;
 Thu,  3 Sep 2026 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788435059;
 bh=s+6YpgMEDH7pANfw5ovx3Hlrf/eoGxTO5i+pQNqPTa4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fqonJ+nv+ps2Ltl/cqPs83NQQGgtDY4ujIIjxZhPpraJfMOjuyHU4+w7l6jrNwPAv
 OfNovvntElJKP5mXYkct0ryNzUFq549YhkFehhiHdy2igrS9EM1g1UvqAPYsyJr/Xr
 IC51PY+KUxINQsJuGYxKaRbuOlCWgXueH3RzUM9f64eNb6J7zXUlNisiYGB2uUJMpa
 GM/hPRW7mwyo0d1YhfMwZcH7VM7eBWLGQHrkc3QtloUXjI2i0z66KzOiFVxOIqnapy
 pSw1PQMCuVlya4VA2FrVQ8hhl7KEQif4YJp37wwpevuT0NR5J8LYG+S0vogEDiX/ls
 kvus9IvFzkS7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] fbdev: fsl-diu-fb: Don't use GFP_DMA when calling
 dmam_alloc_coherent()
To: "Baoquan He" <hebaoquan@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903111836.1777265-6-hebaoquan@kylinos.cn>
References: <20260903111836.1777265-1-hebaoquan@kylinos.cn>
 <20260903111836.1777265-6-hebaoquan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:30:59 +0000
Message-Id: <20260903113059.840121F000E9@smtp.kernel.org>
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
- [High] Missing `GFP_KERNEL` (or other `__GFP_RECLAIM` bits) in memory all=
ocations, causing large allocations to act as non-blocking `GFP_NOWAIT` ato=
mic allocations which are highly prone to failure.
- [High] Video memory is freed while the LCDC hardware is still performing =
DMA reads from it, and error paths can leave the hardware permanently readi=
ng freed memory.
- [High] Concurrent mode setting can lead to a double free of video memory =
because sysfs accesses do not take the necessary locks.
- [High] The struct fb_info is embedded in a devres-managed structure, lead=
ing to a Use-After-Free if a process holds the device open during unbind.
--

commit 719f5155a18f433533c0efd3851ce4c2f8cf3732
Author: Baoquan He <hebaoquan@kylinos.cn>
fbdev: fsl-diu-fb: Don't use GFP_DMA when calling dmam_alloc_coherent()

This commit removes the redundant GFP_DMA flag from the dmam_alloc_coherent=
()
call in fsl_diu_probe(), as the DMA core ignores it and picks the zone from
the device's coherent DMA mask.

> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-d=
iu-fb.c
> index b71d15794ce8b..d7ed007915c18 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -1690,7 +1690,7 @@ static int fsl_diu_probe(struct platform_device *pd=
ev)
>  	int ret;
> =20
>  	data =3D dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
> -				   &dma_addr, GFP_DMA | __GFP_ZERO);
> +				   &dma_addr, __GFP_ZERO);

[Severity: High]
This isn't a bug introduced by this patch, but removing the redundant flag
highlights that this allocation lacks GFP_KERNEL (and thus __GFP_RECLAIM
bits). Does this multi-page allocation for the driver data structure act as
an atomic non-blocking allocation because it lacks GFP_KERNEL, making it
highly prone to failure?

The same pattern appears in map_video_memory(), where a massive multi-megab=
yte
framebuffer allocation is requested:

drivers/video/fbdev/fsl-diu-fb.c:map_video_memory() {
    ...
    p =3D alloc_pages_exact(smem_len, GFP_DMA | __GFP_ZERO);
    ...
}

Could this lack of GFP_KERNEL cause these large allocations to fail during
uptime mode setting via ioctl(FBIOPUT_VSCREENINFO) due to fragmentation?

[Severity: High]
This is a pre-existing issue, but does using a devres-managed lifecycle for
struct fsl_diu_data bypass the reference counting required by the framebuff=
er
core?

The data pointer returned by dmam_alloc_coherent() contains an array of
fb_info structures:

drivers/video/fbdev/fsl-diu-fb.c:fsl_diu_probe() {
    ...
    for (i =3D 0; i < NUM_AOIS; i++) {
        struct fb_info *info =3D &data->fsl_diu_info[i];
    ...
}

If a user process holds /dev/fb0 open during driver unbind, the driver core
will free struct fsl_diu_data upon return from fsl_diu_remove(). Will this
lead to a use-after-free when the process subsequently closes the descriptor
and VFS calls into fbmem.c to access the already-freed fb_info struct?

[Severity: High]
This is a pre-existing issue, but could fsl_diu_set_par() leave the LCDC
hardware permanently reading freed memory?

drivers/video/fbdev/fsl-diu-fb.c:fsl_diu_set_par() {
        ...
        if (info->fix.smem_start)
            unmap_video_memory(info);

        /* Memory allocation for framebuffer */
        if (map_video_memory(info)) {
            fb_err(info, "unable to allocate fb memory 1\n");
            return -ENOMEM;
        }
        ...
}

Since unmap_video_memory() frees the active display buffer pages via
free_pages_exact() before the hardware is disabled, the hardware continues
fetching from these physical addresses. If map_video_memory() fails (which
is highly likely due to missing GFP_KERNEL), it returns -ENOMEM early. Does
this mean the hardware is never stopped and its DMA descriptor is never
updated, persistently leaking the contents of arbitrary newly-allocated ker=
nel
pages to the screen?

[Severity: High]
This is a pre-existing issue, but can concurrent mode setting lead to a
double free of video memory?

In store_monitor(), fsl_diu_set_par() is called locklessly:

drivers/video/fbdev/fsl-diu-fb.c:store_monitor() {
        ...
        for (i=3D0; i < NUM_AOIS; i++)
            fsl_diu_set_par(&data->fsl_diu_info[i]);
        ...
}

If ioctl(FBIOPUT_VSCREENINFO) concurrently updates info->var and calls
fb_set_par() (holding info->lock), both threads could simultaneously evalua=
te
len !=3D info->fix.smem_len as true and call unmap_video_memory().

Inside unmap_video_memory():

drivers/video/fbdev/fsl-diu-fb.c:unmap_video_memory() {
    ...
    void *p =3D info->screen_base;
    size_t l =3D info->fix.smem_len;

    mutex_lock(&info->mm_lock);
    info->screen_base =3D NULL;
    info->fix.smem_start =3D 0;
    info->fix.smem_len =3D 0;
    mutex_unlock(&info->mm_lock);

    if (p)
        free_pages_exact(p, l);
    ...
}

Since the pointer p =3D info->screen_base is read outside the lock, couldn't
both racing threads capture the same pointer, clear the base inside the lock
sequentially, and then unconditionally execute a double free on the identic=
al
pointer?

>  	if (!data)
>  		return -ENOMEM;
>  	data->dma_addr =3D dma_addr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903111836.1777=
265-1-hebaoquan@kylinos.cn?part=3D5
