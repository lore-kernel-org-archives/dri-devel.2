Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A03AC88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B989410E8C6;
	Mon, 14 Sep 2026 14:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RR+IW2no";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0474310EED3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:11:57 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dba3fa388so309865a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 07:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395116; cv=none;
 d=google.com; s=arc-20260327;
 b=FRV61opkRNH/NrPe0pbx2M+8OpwLHLnfyzYx3TFacO6DZmw8lOAnAxrjvIBsiVI8Tg
 X/umggBzn04qoVSgLiDbFNJiVoQYWiSZKz4A21J10LLOZLbg5tLpofMyhbRw9Cu74qFf
 igsjccgzXsx2/UYNcdvwUJCJEMb78cwa44Gfm5Fd25bx5qdlg8G18DKPpYl0HTHvbczG
 GKcCglHOFEMljPdFHjce2Hiz7b7ySlZtbeW5Rk0mn1FdOzBwcwlt+g6DoVfd08trlny5
 crT2P1H92/Pr63ztDXNwnfBkyNwCaYHrlK0pTV2orrZ6BC/5YW55AxN67Zsf5V4JBl55
 NArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
 fh=IpuqayY3gTR5PZ9Da56I2/OToJNf0Md4dJvi+n/0ciw=;
 b=F/Z1WGpMsm1orpn6/Eaxe7VQkCPVp/YrGz7MRFALldWyWO6cgTpbCDTUL60yfmdWdL
 FaXKJfXW8+95bvEcADfDrVFAJPTVuO2kwbr2GQJps2E7uSiv78I1MFDxcrqzeVMOaQBm
 Lx1wLLvPxzJF5JXaoR+qYzC59tAgUdT9TtoTau2Ib1O5/QRrixpXyd7WV13r3a0zrDHh
 vD1PpWR4KbcFaoVrMfzMbBIZlavH+1wzfvqS+Z043tInSfogXgK+IcFgyDRGshglblAG
 DqwLoEQ59KR+t4mi4zcjtQbRanh9Igbs4vNi4rxT0v5DLg1WkZp2mIWm0q2nuw+FkB/l
 MCnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789395116; x=1789999916; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
 b=RR+IW2nofCjAlirBSZkMODluabgsIYiIIuvWSr8xp/Q9bRvFjPIk/x25178fySVlkG
 q5jndsW6+JbCe6B4plgRv9JUQZYpPUxDca3N7BbE5yLEJ6x1CJVbegczgd09UfCEd3yD
 p3FDJnJHkFMTxjKd6KKxD2x7ZCpvk8VtM6t6Cn83ythVXSlARuDV01j1+dj+0EdGB47V
 HfWyUznnwwqZrzzQMTBZ9FhS2Dbp+PC4znBx3PU1OAncomto2BsoVU83vb5p1H6e1Fo8
 qyTnYkhFPic4KgS714BAedaGf2wFu3uZfJcryovO8vtM7Z9X+9cz3JO2tKSFnkU9Zwjf
 Wwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395116; x=1789999916;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4rj/r25LyFLXL2H83H1Ljh+5fD7NhfkZssLHdM2663E=;
 b=mMwoe7DY6GGQ/vRJxa8AUpqicaIIQrA0XuqIYGB3R2cTtu8jwDfMZz/N/ezk2B8k4K
 l3qnX3T/i+uoHM3VjlAfOXMHMMUSdbkX2dU1bY/1TzrNJqZEoRyWVLlF/qBnLpOXvRus
 8axTOOf2934XW59gANdojpZf0dLAV64+qRPVigYhFX16Ok49DbnJfYlCIr9rM7+MhW9x
 ZZds2YLLjoGGrhu+B4Srw9r7XPdXF//Tmm4CVqpa2SRMLZlwJgIoQeeViC3rMnc3CBQV
 qbnVKGcxSSl8SPp3QYnZiVHX0E17hZ6K4hNqFm/CRSS/QJe1K4F9jjaVjkP8DAR4b0xO
 jpsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwvMVCy+RLZNUMxZwgJND5eMCzppP2ZD0GFW2NNG/Q5ZiTYEEYKHd2bTCOZyMOC2NHEteSKTGAJ8jY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ml9KmjEJJUs7tR6u9mf+h/VkSat3UBRl1pBrhSuTXUQGbQFjPe
 f1Xxq7US9y+Gubi9FY9ej6NLhwlPZqPZoYRm0tWGlhZLDJYY3K0uvheSMdCVbF2/w+brfiaBXq4
 crgFxT7GyuKOQDlm3045ymnQXW9VhQuw=
X-Gm-Gg: AYBFou1V0lTzey5B6hbuWsV64wgnXgxCVR0ofcDyVRPY0yXSUHnV5VhdfKpqxRM1vtr
 oqZpsgqRwAI2BV6/CCmnhwRQflnsTgnpOO9n1+b9Nw0YaIRdZD9OmqZIORfpTJ/xPgaqHiqEZB8
 HNXcmew8Z2gpQ5pWUc7CbhDHu8UjHaQ5XAgb0ux/qBIXeKCloqbfBmJt/ZCu3QsH7KT3gBXmT5K
 X8zETpUyvQAIayNiyj10Cd0HpRrScbX+F0akoYQFSrz34cUvqjm7Y1mUtFLjG0Of08W+DeIIB0E
 aOMdxkeDeNajWeba67/CVRgCSroHVA+2aybV51yfswzkNxLlpm1zVnS7yKgx1RjxX5BHu0znCOs
 ImbOG5e5JuhUBD6XBjegL3jv/HCYfyoCKQuYlWuWamg==
X-Received: by 2002:a17:90b:390f:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-39dec1aa1cbmr3754762a91.4.1789395116294; Mon, 14 Sep 2026
 07:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
 <20260911183825.935140-1-mike@fireburn.co.uk>
 <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
In-Reply-To: <afb6cf0f-ca0b-4fb9-b7f7-2355ed45386c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 10:11:44 -0400
X-Gm-Features: AcwNN1VTuk_e5gAg5i1SrKs6UFcqZjBHCJ6WW0AE0n88d1R64cVdkQO01fkBy4Y
Message-ID: <CADnq5_Ngcrfh4m5fHs4R-S8kRHVf-9qT1_wPwBcV6OsXfigDrA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P
 dma-buf attachments
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, kevinyang.wang@amd.com, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Sep 14, 2026 at 6:51=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/11/26 20:38, Mike Lothian wrote:
> > amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
> > attachment.  GTT is only a fallback placement when VRAM is preferred, s=
o
> > ttm_bo_validate() migrates the buffer from GTT into VRAM.  While the
> > exporting device is runtime suspended its SDMA rings are down and the
> > move fails:
> >
> >   amdgpu: Move buffer fallback to memcpy unavailable
> >
> > An importer on a second GPU reaches this holding no runtime PM
> > reference on the exporter, e.g. a compositor on the APU submitting a
> > frame that references a buffer exported by an idle dGPU:
> >
> >   amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
> >     -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
> >       -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move
> >
> > Pinning a dma-buf into VRAM has the same requirement, which
> > commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
> > when we attach a buffer" v2") called out as the one case that would
> > need the reference back.
> >
> > Take it in attach and drop it in detach.  pm_runtime_get_if_active()
> > never resumes the device, so it cannot deadlock against the reservation
> > taken during resume, which is why the old pm_runtime_get_sync() had to
> > go.  If the device is not active, clear peer2peer instead: the buffer
> > then stays in GTT, which remains accessible while the GPU is powered
> > down.
> >
> > Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference whe=
n we attach a buffer" v2")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > Assisted-by: Claude:Opus-5 [Claude Code]
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >
> > v3: take the reference in attach and drop it in detach, clearing
> >     peer2peer when the device is not active, as suggested by Christian.
> >     v2 only covered amdgpu_dma_buf_map() and left VRAM pinning exposed.
> > v2: use pm_runtime_get_if_active() instead of testing
> >     adev->mman.buffer_funcs_enabled, which was racy against a
> >     concurrent suspend.  Reported by Sashiko AI review.
> >
> > Reproduced on a HawkPoint APU [1002:1900] driving the display with a
> > Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
> > offload.  Without the patch kwin_wayland hits the call chain above
> > within a minute of the dGPU autosuspending and the desktop stops
> > repainting until it resumes.
> >
> > Tested with v3: Chromium rendering on the dGPU and composited by kwin
> > 6.7.5 for five minutes, then closed.  The dGPU stayed active while the
> > window was on screen and suspended six seconds after Chromium exited,
> > with no fallback errors or runtime PM usage count underflows.  After
> > an hour of yuzu render offload the dGPU also suspended once yuzu
> > exited.
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 ++++++++++++++++++++-
> >  1 file changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_dma_buf.c
> > index b33c300e26e2..fae695c3e531 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-fence-array.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pm_runtime.h>
> >
> >  static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
> >
> > @@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *=
dmabuf,
> >           pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> >               attach->peer2peer =3D false;
> >
> > +     /*
> > +      * P2P access needs the exporter awake for the lifetime of the
> > +      * attachment.  pm_runtime_get_if_active() never resumes the devi=
ce,
> > +      * so it cannot deadlock against the reservation taken during res=
ume.
> > +      * A negative return means runtime PM is disabled and the device
> > +      * cannot suspend, in which case the put in detach is a no-op.
> > +      */
> > +     if (attach->peer2peer &&
> > +         !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
> > +             attach->peer2peer =3D false;
> > +
> >       r =3D dma_resv_lock(bo->tbo.base.resv, NULL);
> >       if (r)
> > -             return r;
> > +             goto err_pm_put;
> >
> >       amdgpu_vm_bo_update_shared(bo);
> >
> >       dma_resv_unlock(bo->tbo.base.resv);
> >
> >       return 0;
> > +
> > +err_pm_put:
> > +     if (attach->peer2peer)
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > +     return r;
> > +}
> > +
> > +/**
> > + * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
> > + *
> > + * @dmabuf: DMA-buf where we remove the attachment from
> > + * @attach: the attachment to remove
> > + *
> > + * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
> > + */
> > +static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
> > +                               struct dma_buf_attachment *attach)
> > +{
> > +     struct drm_gem_object *obj =3D dmabuf->priv;
> > +     struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> > +     struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > +
> > +     if (attach->peer2peer)
> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >  }
> >
> >  /**
> > @@ -350,6 +386,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *d=
ma_buf, struct iosys_map *map
> >
> >  const struct dma_buf_ops amdgpu_dmabuf_ops =3D {
> >       .attach =3D amdgpu_dma_buf_attach,
> > +     .detach =3D amdgpu_dma_buf_detach,
> >       .pin =3D amdgpu_dma_buf_pin,
> >       .unpin =3D amdgpu_dma_buf_unpin,
> >       .map_dma_buf =3D amdgpu_dma_buf_map,
>
