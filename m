Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6ADC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E4FB10E2C8;
	Mon, 31 Aug 2026 15:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KTxpRTM6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BB210E2C8
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:53:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F265437F0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B2B1F000E9;
 Mon, 31 Aug 2026 15:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788191619;
 bh=n5pgDRagTyumxZIW7bh2F12MtSaaXBeDrIpk48t5JOM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KTxpRTM6OJTreSIhQNl4PZS+7t5yczcTN3FhlEm9zuZGpUZVF9qX8FZg96zi0j2F8
 FliqYsJE0Y8o4fE1zTF8FBr5iQU8qTBTHiqSQUHELhhhVmLX1AF7ZkLRIr18/3ZjW+
 SImjOJRC7tdu4yOZCIVxl2ci4baAv01z0W3z5VNxrfy4SfQHMMGQjW0D+nnkJVBfgB
 QHAY+zBuidnkiD03WM+1Vs242N9e54bn0GNJNp311NiqAvzCY0SICSg+AI1XWfJEBm
 vpo3OYjh/4cEY3UH7hb9ZEuS+c5BbZvrfn9pIg9QvBlBvScKp4c06Uz7GXVVYwE+1A
 97TkEpHZ+4rbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amdgpu: Use system unbound
 workqueue for soft IH ring
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-351-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-351-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:53:38 +0000
Message-Id: <20260831155339.21B2B1F000E9@smtp.kernel.org>
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
- [High] Missing work cancellation for soft IH ring (and ih1/ih2) causes us=
e-after-free and NULL pointer dereference on device teardown.
--

commit b817b565b60c4bf0d6715436c240de40fe4ce255
Author: Timur Krist=C3=B3f <timur.kristof@gmail.com>

drm/amdgpu: Use system unbound workqueue for soft IH ring

This commit allows the kernel to dispatch the soft IH work on other CPUs.
This prevents the soft IH ring from filling up before it starts processing
work items during retry page fault storms.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 8112ffc85995e..2522285e1ab23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -514,7 +514,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>  			 unsigned int num_dw)
>  {
>  	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
> -	schedule_work(&adev->irq.ih_soft_work);
> +	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);

[Severity: High]
This isn't a bug introduced by this patch, but changing the workqueue to
system_unbound_wq removes CPU-binding, which might increase the likelihood
of the work running concurrently with the device teardown thread on SMP
systems.

During teardown, amdgpu_irq_fini_hw() frees the ring buffer and shadow
pointers via amdgpu_ih_ring_fini() without flushing or cancelling the
pending ih_soft_work:

drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:amdgpu_irq_fini_hw() {
	...
	free_irq(adev->irq.irq, adev);
	...
	amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
	...
}

If ih_soft_work (amdgpu_ih_process) was preempted right after evaluating
that the device is not yet shutting down, and then resumes after the
teardown path has freed the ring, could it dereference the freed
ih->wptr_cpu and ih->ring?

drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:amdgpu_ih_process() {
	...
	if (!ih->enabled || adev->shutdown)
		return -ENOENT;
	/* Preempted here, teardown frees the ring */
	wptr =3D amdgpu_ih_get_wptr(adev, ih);
	...
}

Should there be a cancel_work_sync(&adev->irq.ih_soft_work) or similar
synchronization added during the teardown sequence before the ring
buffers are freed?

>  }
> =20
>  /**

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-351-sashal@kernel.org?part=3D1
