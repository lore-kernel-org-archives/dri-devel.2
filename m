Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704F2C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC7F10EA68;
	Wed, 29 Jul 2026 03:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kk5JvxbY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 069CA10EA68
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:07:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3F23407BF;
 Wed, 29 Jul 2026 03:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F6E1F000E9;
 Wed, 29 Jul 2026 03:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294448;
 bh=Wt16MBsw/hQfrZAxCZwhR6XV/2WVtkjPW3se7B4RViw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kk5JvxbYTyEGE+u0/VC5awaW1U9/bNt4aBxmTWU709baytNsJeYjzoIhOcSoKkgYf
 XTDgzplmMA+625le/gqfJnrmejNy8JE+iI+prW1K9j0oDghCi6b9RbTCg7uGawtaFG
 gzQ5ehrnI+mH1ZL+OitkHIhY0wlvgBUWQnLe9Vn0LgBp9Ptm4g0VUDJp7d1HKP2fAg
 WXsJ6ca1St7d7KS3rmSXh74U+LuzXvc7Q/bFmKtQjjBDYwP2WzH+XQ5uQZdD2wwkkL
 mBW8KYInXb5vuavXd92M529gCjeq36HKY8fkgU7IWoNp00xJvKBW5XKpsQ2Ur0DtoJ
 BTPRwJm9ZzlTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/13] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-9-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-9-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:07:28 +0000
Message-Id: <20260729030728.B3F6E1F000E9@smtp.kernel.org>
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

New issues:
- [High] Debugfs `reset_set` drops the PM runtime reference on wait timeout=
 or signal before the reset work completes, leading to hardware access whil=
e the device is suspended.
- [Medium] Incorrect return value logic in `reset_set` masks signal interru=
ptions and suspended PM states by unconditionally returning `-ETIMEDOUT`.

Pre-existing issues:
- [High] The GPU reset sequence drops PM runtime references from stuck jobs=
 before accessing hardware registers, risking a crash if the device suspend=
s concurrently.
--

--- Patch [9]: [PATCH v4 09/13] drm/panfrost: Add debugfs knob for manually=
 triggering a GPU reset ---
commit f19b1f8bf36d92ef2c4bcc1bdcf953c6bd32d4fd
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This commit adds a debugfs file to manually trigger a GPU reset. This is
intended to help test potential race conditions between the GPU reset
sequence and other parts of the code accessing hardware registers.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index a51f1ef8563ce..c0334b72c70b3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> @@ -629,3 +630,43 @@ void panfrost_device_reset(struct panfrost_device *p=
fdev, bool enable_job_int)
>  	if (!panfrost_device_started(pfdev) && !ret)
>  		pfdev->gpu_started =3D true;
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int reset_get(void *data, u64 *val)
> +{

[ ... ]

> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_if_in_use(pfdev->base.dev);
> +
> +	if (ret > 0) {
> +		panfrost_device_schedule_reset(pfdev);
> +		ret =3D wait_event_interruptible_timeout(pfdev->reset.wait,
> +						       !atomic_read(&pfdev->reset.pending),
> +						       msecs_to_jiffies(60));
> +		pm_runtime_put(pfdev->base.dev);

[Severity: High]
If the wait is interrupted by a signal (like Ctrl-C) or times out, does
this immediately drop the PM usage count to 0 and queue a suspend request?

Since the scheduled reset work continues executing asynchronously without a
PM reference, could it access the GPU registers via panfrost_device_reset()
while the device is already powered down, leading to a system crash?

> +	}
> +
> +	return (ret > 0) ? 0 : -ETIMEDOUT;

[Severity: Medium]
Does this ternary return statement mask signal interruptions and PM runtime
errors?

If wait_event_interruptible_timeout() is interrupted, it returns -ERESTARTS=
YS.
Converting this negative error code to -ETIMEDOUT prevents the kernel from
correctly restarting the syscall or returning -EINTR to user space. It also
masks legitimate errors if pm_runtime_get_if_in_use() returned 0 initially.

> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(panfrost_reset_debugfs_fops,
> +			 reset_get, reset_set,
> +			 "0x%08llx\n");

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the reset
sequences, I noticed a potential race condition in the existing
panfrost_reset() handler in drivers/gpu/drm/panfrost/panfrost_job.c:

panfrost_job.c:panfrost_reset() {
    ...
    for (i =3D 0; i < NUM_JOB_SLOTS; i++) {
        if (pfdev->jobs[i][0])
            pm_runtime_put_noidle(pfdev->base.dev);
        ...
    }
    memset(pfdev->jobs, 0, sizeof(pfdev->jobs));
    ...
    panfrost_device_reset(pfdev, true);
}

Does dropping the PM runtime references for all jobs before executing the
hardware reset risk a crash?

By dropping the usage count and clearing the jobs array, panfrost_jm_is_idl=
e()
will return true. If a concurrent thread had triggered a PM autosuspend tim=
er,
could the device be suspended before panfrost_device_reset() accesses the G=
PU
registers? Should panfrost_reset() acquire its own PM reference before
dropping the job references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D9
