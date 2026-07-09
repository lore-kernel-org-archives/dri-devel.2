Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EFEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC6210F56D;
	Thu,  9 Jul 2026 12:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bdb92Yde";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E39F10F56D
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:10:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A12E942E8D;
 Thu,  9 Jul 2026 12:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8AE1F000E9;
 Thu,  9 Jul 2026 12:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599018;
 bh=Vqzl+lQD180UA90kFJISJn6a3OIGK6qpKyWgFtkYgjo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bdb92YdeUxPGOZrtyDskLwJyMSTUD8ytjbrn2otE5E6o1/ZqM4gXmyirzBtpT4tRw
 +J/8rY3EEgjthdn4fX2fPbK19vIvYy9XEPRqDWc3q57O1hP9joE6kJ+F8pxu9DjUw9
 Sf8FSDlMb83JoRHRGjfD7nAiSHADhykd4XaCU7c1TxI8IRAHFzULX8SBNE0xCQ5NL4
 QvVNzid57Ar5cYeK5nHEaG77sr8OMg13YWEj1iUe+DKkPI40vgNk+sZkQSZPvqkPFf
 7FQF+YT/0AS4Rbi5Wd0HtADkDlWn24g0uiyWZDbGt4syRVM/cuyJTJKAqgClqrFgEz
 O1/JNlx1ZFlgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
To: "Evgenii Burenchev" <evg28bur@yandex.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709120049.42048-1-evg28bur@yandex.ru>
References: <20260709120049.42048-1-evg28bur@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:10:17 +0000
Message-Id: <20260709121018.5A8AE1F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but there is a doubl=
e unlock of `adev->mes` in the error handling path of `amdgpu_mes_add_ring(=
)`.
--

--- Patch [1]: [PATCH 6.6] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ri=
ng() ---
commit 44ecf76b72a68dfa86323d985780462c9ca485b7
Author: Evgenii Burenchev <evg28bur@yandex.ru>

drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()

This commit replaces sprintf() with scnprintf() to prevent a potential buff=
er
overflow when writing to ring->name.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b6015157763af..d2128bcf9844f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
[ ... ]
> @@ -1023,13 +1023,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *ade=
v, int gang_id,
>  	ring->doorbell_index =3D qprops.doorbell_off;
> =20
>  	if (queue_type =3D=3D AMDGPU_RING_TYPE_GFX)
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
> =20

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a double
unlock of adev->mes in the error handling path of amdgpu_mes_add_ring().

Earlier in amdgpu_mes_add_ring(), the lock is explicitly released before ca=
lling
amdgpu_mes_add_hw_queue():

	amdgpu_mes_unlock(&adev->mes);

	r =3D amdgpu_mes_add_hw_queue(adev, gang_id, &qprops, &queue_id);
	if (r)
		goto clean_up_ring;

If amdgpu_mes_add_hw_queue() fails, it jumps to clean_up_ring, which falls
through to clean_up_memory where it unconditionally unlocks again:

clean_up_ring:
	amdgpu_ring_fini(ring);
clean_up_memory:
	kfree(ring);
	amdgpu_mes_unlock(&adev->mes);
	return r;

Could this result in a double unlock when the hardware queue allocation fai=
ls?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709120049.4204=
8-1-evg28bur@yandex.ru?part=3D1
