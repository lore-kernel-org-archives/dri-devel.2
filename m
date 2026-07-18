Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6924C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 08:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 027F310E545;
	Sat, 18 Jul 2026 08:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kijq75al";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC78A10E545
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 08:59:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF9226001A;
 Sat, 18 Jul 2026 08:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9206C1F000E9;
 Sat, 18 Jul 2026 08:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784365144;
 bh=IeQ80O3zfq5bA8zB/Nt4pxJTzDJ76GaxvcP/TlCumrY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kijq75al1nigEcVCl7Acr1x1NfYRZ19X3Eg77j3kvgPO1Qb/pxwHDaGhvmtFanvaS
 Y5pmhnsQPfKTgF+OBq3r3gRLgglKvk55aTzZORygHPgzFWDaH3k73tpb3rhBFLGP9w
 z5tbgv2oZ7JTNXP4TB3WEqklGouweb93bxtVv4vpqZ2fjiousNyOnmKPCkjUgqm9nU
 vyVFWOzn7zSAraeQ/uT0sIx/UbyI/+TJp5Z4EnqIihvw92KkA+SC4eNm98NAPqsE/V
 5iPh604B9XSnd6J5RW/oBN8D8WsgYlvr9J+jtu5rxEpq3Ld+n1CSbJrK0QMQfLhwwG
 0q9sHMRPFDXAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix command timeout race
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260718083409.1825940-1-lizhi.hou@amd.com>
References: <20260718083409.1825940-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 08:59:04 +0000
Message-Id: <20260718085904.9206C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Setting tdr_timeout_ms =3D 0 causes an infinite workqueue spin loo=
p, pegging a CPU core at 100%.
- [Medium] Non-deterministic timeout duration doubling due to strict time_a=
fter() check.

Pre-existing issues:
- [Critical] DRM scheduler is restarted before the hardware context is full=
y reinitialized during TDR, causing a race condition that leads to a kernel=
 panic.
- [High] Device-global TDR timestamp tracking masks per-context (hardware c=
ontext) hangs, preventing recovery.
--

--- Patch [1]: [PATCH V1] accel/amdxdna: Fix command timeout race ---
commit fd4b8a27528eea23d910e8bac5083a3f93093603
Author: Wendy Liang <wendy.liang@amd.com>
Date:   Sat Jul 18 08:34:09 2026 +0000

accel/amdxdna: Fix command timeout race

This commit replaces the TDR status state machine with a timestamp check to
prevent race conditions when multiple jobs time out concurrently. It uses
last_signal_ts to record the timestamp of the last driver signal.

> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie=
2_ctx.c
> --- a/drivers/accel/amdxdna/aie2_ctx.c
> +++ b/drivers/accel/amdxdna/aie2_ctx.c
> @@ -43,20 +43,22 @@ struct aie2_ctx_health {
> =20
>  static inline void aie2_tdr_signal(struct amdxdna_dev *xdna)
>  {
> -	WRITE_ONCE(xdna->dev_handle->tdr_status, AIE2_TDR_SIGNALED);
> +	WRITE_ONCE(xdna->dev_handle->last_signal_ts, jiffies);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for the global
timestamp tracking to mask per-context hangs?

If Context A hangs, but Context B continues to run and update last_signal_ts
via aie2_tdr_signal(), Context A's scheduler timeout in
aie2_sched_job_timedout() will call aie2_tdr_detect(). That function reads
the updated global timestamp and returns false, causing the DRM scheduler to
see NO_HANG and re-arm the timer forever, preventing recovery for Context A.

>  static bool aie2_tdr_detect(struct amdxdna_dev *xdna)
>  {
>  	struct amdxdna_dev_hdl *ndev =3D xdna->dev_handle;
> +	unsigned long last =3D READ_ONCE(ndev->last_signal_ts);
> =20
> -	if (READ_ONCE(ndev->tdr_status) =3D=3D AIE2_TDR_WAIT) {
> -		XDNA_ERR(xdna, "TDR timeout detected");
> -		return true;
> -	}
> +	if (!tdr_timeout_ms)
> +		return false;

[Severity: High]
Can setting tdr_timeout_ms to 0 cause an infinite spin loop?

If an administrator sets tdr_timeout_ms =3D 0 to disable TDR, the DRM sched=
uler
is initialized with a 0-jiffy timeout. The delayed work fires immediately,
and since aie2_tdr_detect() returns false, the scheduler sees a NO_HANG
result and unconditionally re-arms the delayed work with a 0 timeout. This
pegs a CPU core at 100%.

> +	if (!time_after(jiffies, last + msecs_to_jiffies(tdr_timeout_ms)))
> +		return false;

[Severity: Medium]
Might this strict time_after() check cause the timeout duration to double?

If the DRM scheduler timer fires precisely when jiffies equals
last + msecs_to_jiffies(tdr_timeout_ms), the time_after() check evaluates
to false. This makes the driver return NO_HANG, which causes the DRM
scheduler to restart the wait for another full timeout period.

> -	WRITE_ONCE(ndev->tdr_status, AIE2_TDR_WAIT);
> -	return false;
> +	XDNA_ERR(xdna, "TDR timeout detected");
> +	return true;
>  }

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but does aie2_sched_job_timedout() have a race
condition that leads to an uninitialized pointer dereference?

During a TDR event, aie2_sched_job_timedout() calls aie2_hwctx_stop()
followed by aie2_hwctx_restart(). If aie2_hwctx_stop() prematurely calls
drm_sched_start() before the hardware context is fully reinitialized, the
scheduler kthread is unparked early.

This allows the scheduler to pull new jobs and execute aie2_sched_job_run()
concurrently while the TDR thread is still running aie2_hwctx_restart().
If the scheduler thread observes hwctx->priv->mbox_chann as non-NULL before
its internal xarray is fully initialized via xdna_mailbox_start_channel(),
it will attempt to access the uninitialized memory when submitting a job.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718083409.1825=
940-1-lizhi.hou@amd.com?part=3D1
