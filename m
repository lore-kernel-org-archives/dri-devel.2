Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D15C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5282E10E2AA;
	Mon, 31 Aug 2026 14:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tcp77cZU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A8CD10E29F;
 Mon, 31 Aug 2026 14:54:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F2A2860120;
 Mon, 31 Aug 2026 14:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0EB1F000E9;
 Mon, 31 Aug 2026 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788188066;
 bh=Z8y2MKYpXb55BMe0iCdawN7MmYc9BaYZAV4pa/Ar9/0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tcp77cZUyLx8TOMOSmv3teKf92P5DCgTcSOw+jIv8jLi6cl+xBwjTtt4I8R6dhf7E
 9QzVXjbtKVFGfFlVSmML59kNncd7AIijEyX34GN0PUbLM6ez84BHMLcfAUWtRFdG+Q
 t3/BG9EYMXWcG2lCmkgmf8GWNMW1sh1imeiRUObty2JhFbk3ZPCpHqcquRVr8er41G
 6X7OiAjD1yLxcKOAgHX/YEqBvcD4V6OYLvf8ol7gjoosxkEzTU6yVT0GOx3QdBuIT7
 59LtKefm6JY7yvuYNzH8njexAJD+qeBuCyH2oJN1vMWofd+buIVpTnMWvDmeWBMrgd
 XnXj2jB86bppA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/xe: Fix null pointer dereference in
 devcoredump cleanup
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-170-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-170-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:54:26 +0000
Message-Id: <20260831145426.8B0EB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing cancellation of deferred snapshot work during driver u=
nload leads to a use-after-free.
- [High] Calling cancel_work_sync() from within the work item itself causes=
 a self-deadlock on the dev_coredumpm_timeout() error path.
- [High] dev_coredumpm_timeout() synchronous error path clears the snapshot=
 memory, causing a NULL pointer dereference in the worker thread.
--

commit 9607c0ac0490954ce494b7fd2f2026e574352b10
Author: Zhanjun Dong <zhanjun.dong@intel.com>
Subject: drm/xe: Fix null pointer dereference in devcoredump cleanup

In xe_devcoredump_snapshot_free(), ss->gt may be NULL when the snapshot
was never fully populated. Guard the xe_guc_capture_put_matched_nodes()
call with IS_ERR_OR_NULL() to prevent a null dereference.

Link: https://patch.msgid.link/20260326181017.2060209-1-zhanjun.dong@intel.=
com

> diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_=
devcoredump.c
> index 203e3038cc817..26a294f79e79f 100644
> --- a/drivers/gpu/drm/xe/xe_devcoredump.c
> +++ b/drivers/gpu/drm/xe/xe_devcoredump.c
[ ... ]
> @@ -255,7 +256,8 @@ static void xe_devcoredump_free(void *data)
>  	if (!data || !coredump_to_xe(coredump))
>  		return;
> =20
> -	cancel_work_sync(&coredump->snapshot.work);
> +	if (coredump->captured)
> +		cancel_work_sync(&coredump->snapshot.work);

[Severity: High]
This is a pre-existing issue, but does calling cancel_work_sync() from with=
in
the work item itself cause a self-deadlock?

In xe_devcoredump_deferred_snap_work(), which executes on the workqueue, th=
ere
is a call to dev_coredumpm_timeout(). If dev_coredumpm_timeout() fails (for
example, if devcoredump is disabled via sysfs or memory allocation fails), =
it
synchronously invokes the free callback, xe_devcoredump_free().

Because coredump->captured is true while this work is executing,
xe_devcoredump_free() calls cancel_work_sync() on the same work item. Since
this executes in the context of the work item itself, it blocks forever
waiting for the work to complete, deadlocking the system_unbound_wq worker.

[Severity: High]
This isn't a bug introduced by this patch, but can the synchronous error pa=
th
described above also result in a null pointer dereference within the worker
thread?

Assuming the deadlock in cancel_work_sync() is bypassed, xe_devcoredump_fre=
e()
will clear the snapshot memory:

	/* To prevent stale data on next snapshot, clear everything */
	memset(&coredump->snapshot, 0, sizeof(coredump->snapshot));

Once dev_coredumpm_timeout() returns control to
xe_devcoredump_deferred_snap_work(), the worker thread immediately attempts
to evaluate gt_to_fw(ss->gt). Since ss->gt was just zeroed out, this results
in an invalid pointer offset, which is then dereferenced by
xe_force_wake_get(), crashing the kernel.

[Severity: Critical]
This is another pre-existing issue in the devcoredump lifecycle, but is the=
re
a risk of a use-after-free here due to missing cancellation of deferred
snapshot work during driver unload?

When the driver is unloaded or unbound, xe_driver_devcoredump_fini() execut=
es:

static void xe_driver_devcoredump_fini(void *arg)
{
	struct drm_device *drm =3D arg;

	dev_coredump_put(drm->dev);
}

If a GPU hang recently queued xe_devcoredump_deferred_snap_work() on the
system workqueue, and the driver is unloaded before this work executes,
dev_coredumpm_timeout() hasn't been called yet. This means the devcd device
does not exist, so dev_coredump_put() does nothing.

The driver teardown completes and frees the xe_device memory. The workqueue
subsequently executes the pending work, dereferencing the freed coredump
structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-170-sashal@kernel.org?part=3D1
