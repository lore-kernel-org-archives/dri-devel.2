Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CBECDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E09310EF6A;
	Wed, 24 Jun 2026 14:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h5l6UepJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587B510EF6A
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:59:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 977CD60018;
 Wed, 24 Jun 2026 14:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8B41F000E9;
 Wed, 24 Jun 2026 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782313188;
 bh=AZEn7YlLZZ3X+5MENOsGvvnrwvW+b10dLjwAopKBy0Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h5l6UepJq0D1oNpaixyTlIEecG93t6sx162Yw2KVg7cLO7N5GimL4Ee/5Kv0Bki6s
 OduWWqOCoKOKErE4ANGmi8cNbO71Ini0f7xa8QmgnibgtLO+cIC+5ifUPCD55eM9gv
 n1lp1NY55pWZ30hNsbEJTOxtwksE1DNHlslqWXhw/Z+3zAMHu3cSKNrkhRamLim9VD
 cGRpDxW5SH61r+AXYooqFzwGMA6Ukq/m7QBTjcvVubawDLhd3r25dSaB0M1mei0LWS
 GS/eupw42yY8NH5XhWFcNZLk94vbQxDBtUYK7vTq4ma2iKIo2l35jXhLvhabPZQc/M
 F5BIV37yjGlxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fbdev: via: return an error when DMA copy times out
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624144313.79291-1-pengpeng@iscas.ac.cn>
References: <20260624144313.79291-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 14:59:47 +0000
Message-Id: <20260624145948.3B8B41F000E9@smtp.kernel.org>
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
- [High] The function returns -ETIMEDOUT and frees DMA descriptors on timeo=
ut without safely aborting the active DMA transfer, leading to hardware use=
-after-free, memory corruption, and spurious completion races.
- [High] The newly added -ETIMEDOUT return value is ignored by the caller, =
causing failed DMA transfers to be reported as successfully completed to us=
erspace.
- [High] Interrupt enablement state is modified without holding the require=
d subsystem spinlock, causing a data race with other subdevices.
- [High] The exported generic DMA copy function unconditionally writes to d=
escr[-1], resulting in a buffer underflow.
--

commit 9ab471ce4cf985645becf738f0f42716441159d1
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

    fbdev: via: return an error when DMA copy times out
   =20
    viafb_dma_copy_out_sg() logs a VIA DMA timeout when the DONE bit is not
    set after the completion wait and grace delay, but still returns success
    to the caller.
   =20
    Preserve the existing cleanup sequence and return -ETIMEDOUT when the D=
MA
    engine did not report completion.

> diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via=
/via-core.c
> index a8d4a3e2c65ed..1632a669941ab 100644
> --- a/drivers/video/fbdev/via/via-core.c
> +++ b/drivers/video/fbdev/via/via-core.c
> @@ -234,6 +234,7 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct=
 scatterlist *sg, int nsg)
>  	dma_addr_t descr_handle;
>  	unsigned long flags;
>  	int i;
> +	int ret =3D 0;
>  	struct scatterlist *sgentry;
>  	dma_addr_t nextdesc;

[Severity: High]
This is a pre-existing issue, but does viafb_dma_copy_out_sg() unconditiona=
lly
write to descr[-1] here?

If viafb_dma_copy_out_sg() is called with nsg =3D=3D 0, the for_each_sg loo=
p is
bypassed and the descr pointer remains at the start of the allocation. The
function then does:

    descr[-1].next_desc_low =3D VIAFB_DMA_FINAL_SEGMENT|VIAFB_DMA_MAGIC;

Because dma_alloc_coherent() can successfully allocate memory and not return
NULL for size 0, does this proceed and corrupt the memory immediately prece=
ding
the allocation?

> =20
> @@ -290,8 +291,10 @@ int viafb_dma_copy_out_sg(unsigned int offset, struc=
t scatterlist *sg, int nsg)
>  	 */
>  	wait_for_completion_timeout(&viafb_dma_completion, 1);
>  	msleep(1);
> -	if ((viafb_mmio_read(VDMA_CSR0)&VDMA_C_DONE) =3D=3D 0)
> +	if ((viafb_mmio_read(VDMA_CSR0) & VDMA_C_DONE) =3D=3D 0) {
>  		printk(KERN_ERR "VIA DMA timeout!\n");
> +		ret =3D -ETIMEDOUT;
> +	}
>  	/*
>  	 * Clean up and we're done.
>  	 */
> @@ -301,7 +304,7 @@ int viafb_dma_copy_out_sg(unsigned int offset, struct=
 scatterlist *sg, int nsg)
>  	dma_free_coherent(&global_dev.pdev->dev,
>  			nsg*sizeof(struct viafb_vx855_dma_descr), descrpages,
>  			descr_handle);

[Severity: High]
This isn't a bug introduced by this patch, but if
wait_for_completion_timeout() times out, is the DMA hardware still actively
reading from memory?

The error path proceeds to dma_free_coherent() to unmap and free the descri=
ptor
pages without explicitly aborting the DMA transfer (e.g. using VDMA_C_ABORT=
).

Could the running hardware continue reading from the freed memory, leading =
to
physical memory corruption and falsely complete a subsequent DMA transfer v=
ia
the global viafb_dma_completion variable?

> -	return 0;
> +	return ret;

[Severity: High]
This isn't a bug introduced by this patch, but is this newly added -ETIMEDO=
UT
return value ignored by the caller in drivers/media/platform/via/via-camera=
.c?

Looking at viacam_irq():

    viafb_dma_copy_out_sg(cam->cb_offsets[bufn], sgt->sgl, sgt->nents);
    vb->vbuf.sequence =3D cam->sequence++;
    ...
    vb2_buffer_done(&vb->vbuf, VB2_BUF_STATE_DONE);

When the DMA times out, viacam_irq() silently ignores the newly added error
code and unconditionally passes the buffer to userspace. Will userspace
erroneously receive incomplete or corrupted video frames, defeating the
purpose of this patch?

>  }
>  EXPORT_SYMBOL_GPL(viafb_dma_copy_out_sg);

[Severity: High]
This is a pre-existing issue, but do viafb_request_dma() and viafb_release_=
dma()
in drivers/video/fbdev/via/via-core.c modify the interrupt enablement state
without holding global_dev.reg_lock?

Looking at viafb_request_dma():

    viafb_irq_enable(VDE_I_DMA0TDEN);

and viafb_release_dma():

    viafb_irq_disable(VDE_I_DMA0TDEN);

Does this create a data race with other subdevices that correctly hold the
lock, potentially corrupting the interrupt enablement register and permanen=
tly
disabling other subdevices' interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624144313.7929=
1-1-pengpeng@iscas.ac.cn?part=3D1
