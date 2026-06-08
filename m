Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFF9CD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:39:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E655410F93B;
	Mon,  8 Jun 2026 19:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ApgWblR+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2437810F936
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:39:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43359601E1;
 Mon,  8 Jun 2026 19:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7AC1F00893;
 Mon,  8 Jun 2026 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780947579;
 bh=oSWY8A1chMA1dfnwx2DpasFksIGrUh2kCAGZX5dPobg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ApgWblR+9lUCo/B789aHUwZJSWe37FvA3FNn1XWKH7rBUmy3CBpZOp7VuUH+vJPme
 kc04NYS7bdskmaQu6jE0YDFg/jjcM3+KiJ1mfyw+him6ytwpyha4LrTcbzUjhgUBs/
 AeK1lfwODA94evrcElobFHPRIJ1ZvhTSIcc7dtk9bkFqkCTYHrOB9RPo/kEoze8Nrn
 LxYOAcwdsVVTPR/06c7qf4bm0bpkTAta31aLTxrl5UZTkC8dcCSx3JAYhnXUdydWqa
 ZI/Rw7kfuwg5Ydy9egXqdoklELGq4jFlf+ATgxYzbgQycSAVEqPGTecbGD2KmoC9Ft
 qCDZJopTiXkWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: initialize irq.lock spinlock earlier
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-amdgpu-mutex-fix-2-v1-1-1d850180ed19@igalia.com>
References: <20260608-amdgpu-mutex-fix-2-v1-1-1d850180ed19@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:39:38 +0000
Message-Id: <20260608193938.CE7AC1F00893@smtp.kernel.org>
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
- [High] The IH work queues (ih1_work, ih2_work, ih_soft_work) are not canc=
elled before freeing the IH ring buffers during hardware teardown, leading =
to a potential use-after-free or NULL pointer dereference.
--

commit d96f9c222586fdd4fb9ac2385c6edc335ba11a51
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm/amdgpu: initialize irq.lock spinlock earlier

If there is an early failure during amdgpu probe, it will end up calling
amdgpu_irq_disable_all, which takes irq.lock spinlock without it being
initialized. Initializing irq.lock earlier at amdgpu_device_init fixes
the issue.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 82bc6d657e5a0..836ba07713649 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -309,8 +309,6 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>  	unsigned int irq, flags;
>  	int r;
> =20
> -	spin_lock_init(&adev->irq.lock);
> -

[Severity: High]
This isn't a bug introduced by this patch, but looking at the driver
teardown, are the IH work queues ever cancelled?

In amdgpu_irq_init(), ih1_work, ih2_work, and ih_soft_work are initialized
and can be scheduled by the interrupt handler. However, during teardown:

drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:amdgpu_irq_fini_hw() {
	if (adev->irq.installed) {
		free_irq(adev->irq.irq, adev_to_drm(adev));
		adev->irq.installed =3D false;
...
	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
}

The driver frees the IRQ and the IH ring buffers, but does not explicitly
cancel the pending work items using cancel_work_sync().

If a scheduled work item executes concurrently with or after teardown, could
it dereference the freed adev or ih->ring pointers, leading to a
use-after-free or NULL pointer dereference?

Should the work items be cancelled synchronously before the ring buffers are
freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-amdgpu-mut=
ex-fix-2-v1-1-1d850180ed19@igalia.com?part=3D1
