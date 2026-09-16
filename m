Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FED7C982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05D310E1F8;
	Wed, 16 Sep 2026 22:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PCnJB/oJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5813A10E1F8
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 22:51:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1300E4020D;
 Wed, 16 Sep 2026 22:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8A41F000FF;
 Wed, 16 Sep 2026 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789599080;
 bh=N9lWvhKmNtndIXUwha639JZXAqv13aiGsDOv1MIY6rU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PCnJB/oJCYKho5scGQ0fzve5RnncYXAn0HHN07A+DKGSHhS3Onh+WbxqaiNDO1xI8
 sejyjN2pC/ZYW4u+SdN/NwGLgj1btVrq+4mcloqmY4iASK1lUYVeiqD3i3JHGz2Jyi
 tgH7fhH0n1o356RSXTG/Jppi8QzVN3TvV/sGUyMs8VBSi3D2PwJxnEDV5JxPVUONmB
 lpgmiuU443RuAvUuUQbyDXcSNsmH+3LBo+VKU1kzamUOx4Ke1VEshTxNiyCSzOlFTC
 aNtdnLg3fEmIMAvKzgtWflrT6rW6aTHgqUlcUG3BXRDT1SCDf4fZn1Wy5DWIZf1e08
 Kr1SQDuKHMxEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] drm/nouveau/gsp/r570: Start saving comptag
 backing stores
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260916223358.507351-5-lyude@redhat.com>
References: <20260916223358.507351-1-lyude@redhat.com>
 <20260916223358.507351-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 22:51:19 +0000
Message-Id: <20260916225119.BF8A41F000FF@smtp.kernel.org>
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
- [High] nouveau: integer truncation allows heap overflow via GSP compbit s=
ize
--

commit 9c4d2d77f428ab0f70d6ac1a683c604ade884fd2
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Start saving comptag backing stores

This commit implements support for saving and restoring comptag backing
stores during the OpenRM fbsr process. It fetches the required space for the
compbit backing stores from the GSP and adds it to the memory allocated for
fbsr.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
[ ... ]
> @@ -26,6 +26,23 @@ r570_fbsr_suspend_channels(struct nvkm_gsp *gsp, bool =
suspend)
>  	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
>  }
> =20
> +static int
> +r570_fb_get_compbit_store_size(struct nvkm_gsp *gsp, u64 *size)
> +{
> +	NV0080_CTRL_FB_GET_COMPBIT_STORE_INFO_PARAMS *ctrl;
> +
> +	ctrl =3D nvkm_gsp_rm_ctrl_rd(&gsp->internal.device.object,
> +				   NV0080_CTRL_CMD_FB_GET_COMPBIT_STORE_INFO,
> +				   sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	*size =3D ctrl->Size;

[Severity: High]
Does this code need to validate the untrusted 64-bit value returned from the
GSP firmware?

If a compromised or malicious GSP firmware provides a crafted value, it can=
 be
used to exploit integer truncations during allocation.

> +
> +	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.object, ctrl);
> +	return 0;
> +}
[ ... ]
> @@ -174,6 +197,8 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  	size  =3D gsp->fb.heap.size;
>  	size +=3D gsp->fb.rsvd_size;
>  	size +=3D gsp->fb.bios.vga_workspace.size;
> +	size +=3D compbit_store_size;

[Severity: High]
Can this unvalidated addition allow an attacker to craft a specific size
that perfectly aligns for integer truncation in the allocator?

When nvkm_gsp_sg() receives this size, it computes pages and passes it to
sg_alloc_table():

nvkm_gsp_sg(device, size, &gsp->sr.fbsr)
   const u64 pages =3D DIV_ROUND_UP(size, PAGE_SIZE);
   ...
   ret =3D sg_alloc_table(sgt, pages, GFP_KERNEL);

Since sg_alloc_table() takes a 32-bit unsigned int nents, a crafted size
(like 4TB + 1 bytes) would truncate to a tiny non-zero value, allowing a
massive allocation request to succeed by allocating only a few pages.

Additionally, when this size reaches r535_fbsr_memlist():

r535_fbsr_memlist()
   const u32 pages =3D size / GSP_PAGE_SIZE;
   ...
   rpc =3D nvkm_gsp_rpc_get(gsp, NV_VGPU_MSG_FUNCTION_ALLOC_MEMORY,
                          sizeof(*rpc) + pages * sizeof(rpc->pteDesc.pte_pd=
e[0]));

The 32-bit truncation results in a 0-PTE buffer allocation. The subsequent =
loop
then writes PTEs based on the actual SG table length, causing an out-of-bou=
nds
heap write.

> +
>  	nvkm_debug(subdev, "fbsr: size: 0x%llx bytes\n", size);
> =20
>  	ret =3D nvkm_gsp_sg(device, size, &gsp->sr.fbsr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916223358.5073=
51-1-lyude@redhat.com?part=3D4
