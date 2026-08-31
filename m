Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DF6C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F295F10E9FF;
	Mon, 31 Aug 2026 16:48:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SgpYdf8q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD12710E9FE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:48:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2DB360120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF1C1F000E9;
 Mon, 31 Aug 2026 16:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788194892;
 bh=we74B2Kzv9tIG2/B1bQYnkXCNF+IqjdLPvXlxGPeStk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SgpYdf8qGIsuCmX2wgUvASd/KAfDOXwaW1vn7BxwVMqQUWsRghYExeO6GjmP/rBsr
 PdfOd+PID+wO7Dv8FHl1sMJuUPgcApt8kpvjivRveQJkK3li+qHvl1BmhN5tANJpvT
 SFEfIp4/hgUCBU/0m/JVG1YVWRKGvdsWYHu9e8c/TM3RroMXpxk9PY9GRr6CRu18UX
 bxF8W4fBD6UFIfCbMwyZ1dcJ0PCRgz6qV/jiPkamNRwiT9s1ik3un9cOjZEQTINmiR
 fJS4p4q/lwJYYCeC0j2J+Hk0QGE9YPxdXO4rwl/nJTHtQuOkrJ0JVYm40wSLHc0aAX
 Y01C2JCpt0Hsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdkfd: check find_first_zero_bit
 before __set_bit on kfd->doorbell_bitmap
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-498-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-498-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:48:12 +0000
Message-Id: <20260831164812.8BF1C1F000E9@smtp.kernel.org>
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
- [High] kfd_get_kernel_doorbell returns an out-of-bounds memory pointer wh=
en inx >=3D PAGE_SIZE / 8 (e.g. inx >=3D 512 for 4K pages) despite the newl=
y added limit check.
- [High] Unconditional `inx *=3D 2` scaling causes the CPU doorbell mapping=
 to desynchronize from the hardware offset for pre-SOC15 devices where door=
bell_size is 4 bytes.
--

commit 894bc38c1ebdc7976cba92108cb9d3988e5b0bcd
Author: Xiaogang Chen <xiaogang.chen@amd.com>

drm/amdkfd: check find_first_zero_bit before __set_bit on kfd->doorbell_bit=
map

This commit fixes an issue where the doorbell bitmap could be written
out-of-bounds by moving the bounds check to occur before the __set_bit
operation.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index 05c74887fd6fd..fdcf7f2d1b5b4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -153,14 +153,16 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_de=
v *kfd,
>  	u32 inx;
> =20
>  	mutex_lock(&kfd->doorbell_mutex);
> +
>  	inx =3D find_first_zero_bit(kfd->doorbell_bitmap, PAGE_SIZE / sizeof(u3=
2));
> +	if (inx >=3D KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {

[Severity: High]
This is a pre-existing issue, but does this bounds check adequately protect
the final pointer calculation from overflowing the allocation?

KFD_MAX_NUM_OF_QUEUES_PER_PROCESS is 1024. If we look at how inx is used
later in kfd_get_kernel_doorbell():

    inx *=3D 2;
    ...
    return kfd->doorbell_kernel_ptr + inx;

If inx is 512 or greater (but less than 1024), multiplying it by 2 yields an
index of 1024 or more. Since the doorbell allocation is PAGE_SIZE (4096
bytes, or 1024 u32 elements), returning kfd->doorbell_kernel_ptr + inx
results in an out-of-bounds memory pointer and potential memory corruption
upon write.

> +		mutex_unlock(&kfd->doorbell_mutex);
> +		return NULL;
> +	}
> =20
>  	__set_bit(inx, kfd->doorbell_bitmap);
>  	mutex_unlock(&kfd->doorbell_mutex);
> =20
> -	if (inx >=3D KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
> -		return NULL;
> -
>  	*doorbell_off =3D amdgpu_doorbell_index_on_bar(kfd->adev,
>  						     kfd->doorbells,
>  						     inx,

[Severity: High]
This isn't a bug introduced by this patch, but does the unconditional scali=
ng
of inx cause the CPU doorbell mapping to desynchronize from the hardware
offset for legacy devices?

Immediately following this context in kfd_get_kernel_doorbell():

    *doorbell_off =3D amdgpu_doorbell_index_on_bar(kfd->adev,
                                                 kfd->doorbells,
                                                 inx,
                                                 kfd->device_info.doorbell_=
size);
    inx *=3D 2;

The hardware offset calculation via amdgpu_doorbell_index_on_bar() uses
the device-specific doorbell sizes (e.g. 4 bytes on pre-SOC15 devices).

However, the CPU virtual pointer applies a hardcoded multiplication by 2
(advancing by 8 bytes unconditionally).=20

Can this lead to hardware functionality loss or device hangs on legacy
pre-SOC15 devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-498-sashal@kernel.org?part=3D1
