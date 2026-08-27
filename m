Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE473C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 15:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82F210E593;
	Thu, 27 Aug 2026 15:35:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QfoNqk8U";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50DCA10E513;
 Thu, 27 Aug 2026 15:35:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64AEC600D2;
 Thu, 27 Aug 2026 15:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6891F000E9;
 Thu, 27 Aug 2026 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787844949;
 bh=XuJh8vYrMtuHfTomWGayuzo7xAj76LVxx+0A002eeBA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QfoNqk8UrIpo+Pm/+P986ReNiMIufnHOQsOCYd5IRe2VoHuXQw8GOElljGSm+HimD
 ACsy4lSs1JMXy++2G1ryIp/5ww58zomTXV36vn/amd3QCFBzkTiH3h+p+4DF5AtjET
 ceN2csFQqrsM1IrEY/IEADyy/AP5HzF6ZoQ10WTeG87PmjRpZkehgVzAWkoi+8zgto
 8+hZ6q4sriNxNB0P9bzuEEaavkQj0TQ9Q5vtwvQbT/5Obd/MMbG/dzduZhMthjejOb
 hx62P8aVqSc5ocz87D54zY21kKnDznUXrx1oSEzxfzykUyVgEWOhXenMT001g68zw8
 4l36W5kr6J3bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/xe: Convert xe_user_fence to drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 media-ci@linuxtv.org
In-Reply-To: <20260827151950.4080674-3-srinivasan.shanmugam@amd.com>
References: <20260827151950.4080674-1-srinivasan.shanmugam@amd.com>
 <20260827151950.4080674-3-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 15:35:48 +0000
Message-Id: <20260827153548.CC6891F000E9@smtp.kernel.org>
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
- [High] Canceling a queued drm_user_fence work item leaks a reference to t=
he user fence, its mm_struct, and the stored dma_fence.
- [High] Unconditional cancellation of user fences in xe_sync_entry_cleanup=
() completely breaks VM_BIND user fences.
--

commit 0c5a87e71dfa22fb04a23aa8d1dc27d00d244cde
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

drm/xe: Convert xe_user_fence to drm_user_fence

This patch replaces the open-coded user fence implementation in the xe driv=
er
with the new common drm_user_fence helper. It moves the local destruction a=
nd
worker logic into xe_ufence_ops callbacks which are executed by the core he=
lper.

> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
> --- a/drivers/gpu/drm/xe/xe_sync.c
> +++ b/drivers/gpu/drm/xe/xe_sync.c

[ ... ]

> @@ -310,8 +295,10 @@ void xe_sync_entry_cleanup(struct xe_sync_entry *syn=
c)
>  	dma_fence_put(sync->fence);
>  	dma_fence_chain_free(sync->chain_fence);
>  	dma_fence_chain_free(sync->ufence_chain_fence);
> -	if (!IS_ERR_OR_NULL(sync->ufence))
> +	if (!IS_ERR_OR_NULL(sync->ufence)) {
> +		drm_user_fence_cancel_sync(&sync->ufence->base);

[Severity: High]
Does this unconditionally cancel the user fence worker during the ioctl's
teardown path?

During the normal, successful execution of xe_vm_bind_ioctl() in
drivers/gpu/drm/xe/xe_vm.c, the function falls through to the free_syncs
label and calls xe_sync_entry_cleanup() for all parsed sync entries:

    free_syncs:
        ...
        while (num_syncs--)
            xe_sync_entry_cleanup(&syncs[num_syncs]);

If the worker is canceled immediately after the ioctl submits the GPU work,
it appears the user fence is disarmed before the GPU finishes. Could this
cause userspace applications using VM_BIND with user fences to hang
indefinitely, as the completion signal is never delivered?

[Severity: High]
Additionally, when drm_user_fence_cancel_sync() is called here, can it leak
a reference to the user fence?

Looking at the implementation of drm_user_fence_cancel_sync() in
drivers/gpu/drm/drm_user_fence.c:

    void drm_user_fence_cancel_sync(struct drm_user_fence *ufence)
    {
        drm_user_fence_cancel(ufence);
        cancel_work_sync(&ufence->work);
    }

The return value of cancel_work_sync() is ignored. If it returns true
(meaning the work was queued but hadn't started yet), the=20
drm_user_fence_work() worker function is bypassed.=20

Since the work item owns a reference to the user fence (acquired during
drm_user_fence_add_callback()), skipping the worker means
drm_user_fence_put() is never called. Could this result in a memory leak of
the drm_user_fence structure, its mmgrab() reference, and its stored=20
dma_fence?

>  		user_fence_put(sync->ufence);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827151950.4080=
674-1-srinivasan.shanmugam@amd.com?part=3D2
