Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BF8C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 04:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A23B10E650;
	Thu, 30 Jul 2026 04:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lb9QhpZk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3394410E650
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 04:58:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3890C600B0;
 Thu, 30 Jul 2026 04:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAF31F000E9;
 Thu, 30 Jul 2026 04:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785387511;
 bh=OIKSffr8NekJUo5G/UqX3sowcFhUn6AyJJNn4q/WiEs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Lb9QhpZkB73nYio2CTU+MKX9l6q6HABGqrvD+fwQwfVU2yEz2Srlg26lpj/0YPvwD
 iCZm9BM0sBpSGmW5WDVkYO7OHS7iG96G3wBiUxxEg6ptH/lgkoG6RgecIOuWLsQIG8
 RLmsdxVQbnKVPr9kT0momU7SQwp24DAuzxQr+UgaHavKQPSRs32IPzMTElm5nbi06/
 cSUzcciWhy9IyTUUAwKs+6ATzsyaZaYL6xp/TbCRJQUBVWd/RqXWgdRCVxlYu7nHkE
 RsLpkP6Ny6AqJaQ2IqHYLcSX9VwtWq5enIXYXjgAWzAXpqYHtbqWneAq8bMzcbd5c7
 iJLkZAnXTb/5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] drm/tegra: Fix syncobj_in wait return value check
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260730-b4-host1x-syncobj-wait-v1-1-afa730410392@nvidia.com>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
 <20260730-b4-host1x-syncobj-wait-v1-1-afa730410392@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:58:31 +0000
Message-Id: <20260730045831.BEAF31F000E9@smtp.kernel.org>
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
- [Critical] If `host1x_fence_create()` fails, it returns an error pointer =
which is passed to `drm_syncobj_replace_fence()` due to a missing early ret=
urn, causing a kernel crash when dereferenced.
- [High] The initial reference to the `dma_fence` allocated by `host1x_fenc=
e_create()` is leaked on the success path.
--

--- Patch [1]: [PATCH 1/6] drm/tegra: Fix syncobj_in wait return value chec=
k ---
commit 250614410b887862e5e7b49b5d80c8b53c8aa353
Author: Mikko Perttunen <mperttunen@nvidia.com>

drm/tegra: Fix syncobj_in wait return value check

dma_fence_wait_timeout() returns the remaining timeout in jiffies on
success, zero on timeout, and a negative error code if interrupted. The
return value was assigned to 'err' and checked as if it were an errno,
the opposite of the correct logic.

Fix the code to use a properly typed variable and check each condition
correctly.

Closes: https://lore.kernel.org/all/aJM_te551jUwnRv7@stanley.mountain/

> diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submi=
t.c
> index e5841857c9378..5dad6dc4eb8c3 100644
> --- a/drivers/gpu/drm/tegra/submit.c
> +++ b/drivers/gpu/drm/tegra/submit.c

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential problem in
tegra_drm_ioctl_channel_submit() when handling syncobj_out:

	if (syncobj) {
		struct dma_fence *fence =3D host1x_fence_create(job->syncpt, job->syncpt_=
end, true);
		if (IS_ERR(fence)) {
			err =3D PTR_ERR(fence);
			SUBMIT_ERR(context, "failed to create postfence: %d", err);
		}

		drm_syncobj_replace_fence(syncobj, fence);
	}

If host1x_fence_create() fails, it returns an error pointer. Since there is
no early return or goto in the error handling block, the error pointer falls
through and is passed to drm_syncobj_replace_fence().

Looking at drm_syncobj_replace_fence() in drm_syncobj.c, it calls
dma_fence_get(fence) which checks 'if (fence)'. This would evaluate to true
for an error pointer, causing an attempt to increment the reference count on
the invalid pointer.

Should there be a 'goto put_job' or similar return path inside the
IS_ERR(fence) block to avoid this panic?

[Severity: High]
This is also a pre-existing issue, but in the same block of code, does
this leak the fence on the success path?=20

host1x_fence_create() returns a new dma_fence with a reference count of 1.
drm_syncobj_replace_fence() then takes its own reference to the fence by
calling dma_fence_get().

However, I don't see a matching dma_fence_put(fence) in this function
after drm_syncobj_replace_fence(). Will the initial reference to the fence
be leaked for every successful ioctl call using syncobj_out?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-b4-host1x-=
syncobj-wait-v1-0-afa730410392@nvidia.com?part=3D1
