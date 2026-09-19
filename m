Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C75C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3038510E1B6;
	Sat, 19 Sep 2026 22:02:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AgbvWm1D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57D810E1B6
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:02:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BF76601FB;
 Sat, 19 Sep 2026 22:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD041F000FF;
 Sat, 19 Sep 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789855363;
 bh=9B/a6L3cbpLZJ1oc6CcZJ+hz9X4+eWzFgD+2BpRW+i0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AgbvWm1DQnGpn7rkuppxt6XbEyVfS4MPidUJnjBPlmyWTvn/GhGlc6M8GUMWfRFht
 Fk74nuLT7lHIFHyPEObTTfuFced75I8OZkS+048Oh+r2djzSHrlaIEIxBx0ObRBXiZ
 X9PLjSLXsOTRBJQovH2+rqTGulQZ30WNNZkhbzNPjeq8sHMm26YjQUr2/fOEmXQWJk
 3b9//dC1M+T/sgOdqb5tl5PwUGfFnai6ij56O9/Ml3ggZtsAbB5S3CPk3ESdR1W3m2
 qt41qbxnpP6yvoRcyt4YUUqB5to/G6EOI5wXEknXhgd0XviRyTa+Y+rg1MqVgxYef4
 uzwpG2DO1LdYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: fix 0-byte blob ZERO_SIZE_PTR, GEM leak,
 and context_init rollback
To: "Hui Peng" <benquike@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
In-Reply-To: <20260919215232.3470178-1-benquike@gmail.com>
References: <20260919215232.3470178-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:02:42 +0000
Message-Id: <20260919220242.EFD041F000FF@smtp.kernel.org>
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

> Fix multiple issues in virtio-gpu VRAM mapping, blob creation, and context
> initialization:
>=20
> 1. In virtio_gpu_vram_mmap(), set vram->map_state =3D STATE_ERR if deferr=
ed
>    virtio_gpu_vram_map() fails so callers do not treat an unmapped VRAM
>    node as valid.
> 2. In verify_blob(), reject rc_blob->size =3D=3D 0 or size values that wr=
ap
>    PAGE_ALIGN() to prevent kvmalloc_array(0, ...) from returning
>    ZERO_SIZE_PTR.
> 3. In virtio_gpu_gem_create(), virtio_gpu_resource_create_ioctl(), and
>    virtio_gpu_resource_create_blob_ioctl(), use drm_gem_object_put()
>    instead of drm_gem_object_release() on error so the BO's free callback
>    is properly invoked.
> 4. In virtio_gpu_context_init_ioctl(), stage context parameters into local
>    variables and only commit them to vfpriv after all parameters and
>    ring_idx_mask have been validated.
>=20
> Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vra=
m object")
> Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an arr=
ay of fence contexts")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919215232.3470=
178-1-benquike@gmail.com?part=3D1

