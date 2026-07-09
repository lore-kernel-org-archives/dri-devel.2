Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74060C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D881510E036;
	Thu,  9 Jul 2026 11:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iTPmXS/x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EE010F522
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:49:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B109E43EB6;
 Thu,  9 Jul 2026 11:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696611F000E9;
 Thu,  9 Jul 2026 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783597766;
 bh=EWlxjEE3kHiiVbrVPpklwznyFyG17ezbF10VGFVstkA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iTPmXS/xScOv5p6Rq+yvxnjJU3dhToghBnODIcLOsximf0irEkkPQDWKR6m1alXfM
 mmcemn8me369csf8aw4IrrAKiwl6m6AewAIADlYggRlpbZYYPRnI2OpN6bZuggBVoR
 K3vpXikWUNEJgulzf/byu4s7CtctlAcxY8Htm6icqzM40o/GiEFXHIEZPdoGB/wVVx
 QV5cbsGk6wX30EdMz7yj8IuOvbaz6pWKBicW4iCZyEc7mQZ/1SwH0OLunLXlEJcayt
 czAsz73vvlOcAzA5PE6vYQ47BEjHyjnYSZFxmX23ifFPkersim+BUrhWKOpmS6XNss
 h87SY4k3JcSQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
To: "Evgenii Burenchev" <evg28bur@yandex.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709112825.40016-1-evg28bur@yandex.ru>
References: <20260709112825.40016-1-evg28bur@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:49:25 +0000
Message-Id: <20260709114926.696611F000E9@smtp.kernel.org>
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
- [High] Double unlock of `adev->mes` mutex in error path.
- [High] Unchecked NULL fence pointers passed to `dma_fence_wait()`.
--

--- Patch [1]: [PATCH 6.1] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ri=
ng() ---
commit a3f6095725ba7df26135d6b5a8b649631f54d76e
Author: Evgenii Burenchev <evg28bur@yandex.ru>

drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()

Replace sprintf() with scnprintf() to prevent a potential buffer overflow
when writing to ring->name.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 0c546245793b9..41e699f4b5d2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1053,13 +1053,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *ade=
v, int gang_id,
>  	ring->doorbell_index =3D qprops.doorbell_off;
> =20
>  	if (queue_type =3D=3D AMDGPU_RING_TYPE_GFX)

[Severity: High]
This is a pre-existing issue, but I noticed a potential NULL pointer
dereference just before this code in amdgpu_mes_add_ring():

	dma_fence_wait(gang->process->vm->last_update, false);
	dma_fence_wait(ctx_data->meta_data_va->last_pt_update, false);

If the fences are unallocated, these pointers might be NULL. The
dma_fence_wait() function does not check for NULL inputs before dereferenci=
ng.
Could this result in a kernel oops during normal process/gang queue creatio=
n?

[Severity: High]
This is a pre-existing issue, but I also noticed a potential double unlock
of the adev->mes mutex. Before the new scnprintf() code, we unlock it here:

	amdgpu_mes_unlock(&adev->mes);

	r =3D amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
	if (r)
		goto clean_up_ring;

If amdgpu_mes_add_hw_queue() fails, it jumps to clean_up_ring, which falls
through to clean_up_memory:

clean_up_memory:
	kfree(ring);
	amdgpu_mes_unlock(&adev->mes);
	return r;

Will this second call to amdgpu_mes_unlock() cause a double unlock panic or
state corruption since the mutex was already dropped?

> -		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
> +		scnprintf(ring->name, sizeof(ring->name), "gfx_%d.%d.%d",
> +			pasid, gang_id, queue_id);
>  	else if (queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE)
> -		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
> -			queue_id);
> +		scnprintf(ring->name, sizeof(ring->name), "compute_%d.%d.%d",
> +			pasid, gang_id, queue_id);
>  	else if (queue_type =3D=3D AMDGPU_RING_TYPE_SDMA)
> -		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
> -			queue_id);
> +		scnprintf(ring->name, sizeof(ring->name), "sdma_%d.%d.%d",
> +			pasid, gang_id, queue_id);
>  	else
>  		BUG();
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709112825.4001=
6-1-evg28bur@yandex.ru?part=3D1
