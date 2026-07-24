Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5163C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481EF10F26E;
	Fri, 24 Jul 2026 00:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VxI3yOCB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16DD10F26E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:14:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99F16408A9;
 Fri, 24 Jul 2026 00:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A8B1F000E9;
 Fri, 24 Jul 2026 00:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784852046;
 bh=Br3YJDvcs147saHeG3xC+OqsoNRGJ9HQr+bCi3X3EfY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VxI3yOCBVD9BFi/IwRFcvkjy1+Q3Q0xudaLAF2dvgpaSnoFt3064BxK4x2wVdw0If
 f75sFk8DpdaLiPGsWcdIXVN+WBfre7k5LdVEfc67EHLX/6DN+pAjwiWx8bF+U/3gwn
 SMt6a2Df4HNNds1i/PGXFITIaqsVRnc7lrCb+4TnkKSI18eV5mufE0x4soA7tCKJEy
 FJdKhre7gFkbECvYhS3K7JAk7xOWIFbsQsandujZeOWjCOeYNhBHxwjUajpXzyCO59
 FG+xeLOzRR821UlL3hFJEnX0pr0pnRlrF8whNOCznTncDB1Gj7wayCW6PrpLzkp7gt
 2kUyFQgJkFRkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/13] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-9-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-9-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:14:05 +0000
Message-Id: <20260724001406.52A8B1F000E9@smtp.kernel.org>
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
- [High] The return value of `pm_runtime_get_if_in_use()` is evaluated as a=
 boolean, which incorrectly treats negative error codes (e.g., `-EINVAL`) a=
s success, leading to a PM usage count underflow and unsafe hardware access.
- [High] Dropping the runtime PM reference prematurely when `wait_event_int=
erruptible_timeout()` times out or is interrupted allows the device to susp=
end while the asynchronous hardware reset is still executing.
- [Medium] The return value of `wait_event_interruptible_timeout()` is igno=
red, masking failures from userspace.
--

--- Patch [9]: [PATCH v3 09/13] drm/panfrost: Add debugfs knob for manually=
 triggering a GPU reset ---
commit 30e9d18cee2bcd687cf4536c70ee21485ca931d0
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This commit introduces a new debugfs file "reset" to the panfrost driver.
It allows userspace to manually trigger a GPU reset by writing to it, and
to read whether a reset is currently pending.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index cf115db9cebfd..80746e3754100 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -631,3 +632,40 @@ void panfrost_device_reset(struct panfrost_device *p=
fdev, bool enable_job_int)
[ ... ]
> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +
> +	if (pm_runtime_get_if_in_use(pfdev->base.dev)) {

[Severity: High]
Does this incorrectly treat negative error codes as success?

If runtime PM is disabled (e.g., CONFIG_PM is disabled or during unbind),
pm_runtime_get_if_in_use() returns -EINVAL. This condition will evaluate to
true, causing the code to schedule a reset and call pm_runtime_put() without
an actual reference being taken.=20

This can lead to a PM usage counter underflow and potential hardware access
on an unpowered device. Should this explicitly check for a return value > 0?

> +		panfrost_device_schedule_reset(pfdev);
> +		wait_event_interruptible_timeout(pfdev->reset.wait,
> +						 !atomic_read(&pfdev->reset.pending),
> +						 msecs_to_jiffies(60));

[Severity: Medium]
Is it intentional to ignore the return value of the wait?

If the wait is interrupted by a signal (-ERESTARTSYS) or times out (0), the
function unconditionally returns 0, falsely indicating success to userspace.

[Severity: High]
Can dropping the PM reference on timeout or signal interruption cause the
device to suspend while the reset is still executing?

If the wait is interrupted or times out, the code proceeds to pm_runtime_pu=
t()
even though the reset work might still be pending or running.=20

Because panfrost_reset() drops PM references for active jobs before the
hardware reset, dropping this reference can drop the usage counter to zero.
If the device suspends while the async reset work is concurrently accessing
MMIO registers, could this trigger a synchronous external abort?

> +		pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D9
