Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770C7C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D631B10E0CA;
	Tue,  7 Jul 2026 09:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mVQWpZCX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BC110E0CA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 09:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 641EB41272;
 Tue,  7 Jul 2026 09:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E81F000E9;
 Tue,  7 Jul 2026 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783417947;
 bh=B3Uu+WOg2k7no/qenTtrh0MMfxHZJ7gzljjdbgyTxHw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mVQWpZCXVuMOxbAZRCiB2PyW8sazjescoZZmQ3bAVsH7UfRFEWoBxyVvHF5YPzFCM
 Z48xC0IhSNG9ncuroQBaItkNDCJ+2f8gYVGF9f931Drny0ku6yZ6VGh/6QLtR1xZOy
 b5gsfVF7/O3jcBKgmFsLJjivGhsPpZIdZtbGv+EvFG7lOlxau7GjuyesN+YnqFCUAy
 84HkuQXtcijsWnYob0TMJabyiNYu3w6Lu7z5o5pWCnqhmy9W0EeclCtoCaDBbVlNml
 04t4z3V1K5RYb6i+m1kpVHBMzesQtK7LK+MWTl9H6DIq0hJEyvM8XZoG5+kuI2jdvy
 5EcNUBCsM/8Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl_wq
To: "Marco Crivellari" <marco.crivellari@suse.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707093812.109176-1-marco.crivellari@suse.com>
References: <20260707093812.109176-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 09:52:26 +0000
Message-Id: <20260707095227.1D3E81F000E9@smtp.kernel.org>
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
- [High] Missing explicit cancellation of asynchronous interrupt work items=
 (ih_soft_work, ih1_work, ih2_work) during device teardown, leading to a Us=
e-After-Free.
--

--- Patch [1]: [PATCH] drm/amdgpu: Change system_unbound_wq with system_dfl=
_wq ---
commit 65cddcba7474a0c152afd7f127fd2e2ad98c63ac
Author: Marco Crivellari <marco.crivellari@suse.com>

drm/amdgpu: Change system_unbound_wq with system_dfl_wq

This commit replaces the deprecated system_unbound_wq with the newer
system_dfl_wq to avoid deprecation warnings. The patch aims to keep the
existing workqueue behavior intact.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -547,7 +547,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>  			 unsigned int num_dw)
>  {
>  	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
> -	queue_work(system_unbound_wq, &adev->irq.ih_soft_work);
> +	queue_work(system_dfl_wq, &adev->irq.ih_soft_work);

[Severity: High]
This is a pre-existing issue, but since we are modifying the workqueue
submission here, does the teardown path leave ih_soft_work pending?

If a hardware interrupt fires just before device unbind or module unload,
adev->irq.ih_soft_work can be queued onto the global system workqueue. When
the driver proceeds with teardown, it frees the interrupt handler and the
ring buffers:

drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:amdgpu_irq_fini_hw() {
        if (adev->irq.installed) {
                free_irq(adev->irq.irq, adev_to_drm(adev));
        ...
        amdgpu_ih_ring_fini(adev, &adev->irq.ih_soft);
}

However, it doesn't appear to explicitly call cancel_work_sync() for the
pending work items before freeing the adev structure. Could this result
in a use-after-free if the global workqueue asynchronously executes the
amdgpu_irq_handle_ih_soft() work item after the device memory is freed?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707093812.1091=
76-1-marco.crivellari@suse.com?part=3D1
