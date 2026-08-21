Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8AAC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 09:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18B8D10E276;
	Fri, 21 Aug 2026 09:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mfCCA3nY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEBEF10E269
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 09:01:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D415661895;
 Fri, 21 Aug 2026 09:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D191F00A3A;
 Fri, 21 Aug 2026 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787302885;
 bh=U96uS63WKoYKo3Hwy4qDTYpU0Khy/+mTzukbkrRZk18=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mfCCA3nYirEC1gn07C1zEr2KbxOie6fbnHKvPSKrIyRDhODbjOn/eVTBjk3rU9G8u
 XnhRCiJPHihTwuYI7PF1PqvAKpNwRVbh8UyTjQbosYQgSRRI/u499IODOuDyZPrmp9
 jgNppeHSXt8aR+Hl6uWFnaZ2JWpaI7VM6IhCLu/5wbYyY2VMAVbVsIL3yFHPbGY7z2
 i7sFWNolGBEcxUNcZIK3StIMYUFERuu8pJMagllgZ4Aagh5CTQxItGZPPnNXz8cEhP
 zGkrmxhpdVC3mHJ7q42jxKPV09nGSw39IeySfmDO7UORkwz+VDghSx8cE1m4kFidjq
 u/mKXtKsweLJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Guard against NULL dev in drm_sched_job
 trace event
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821084748.543645-1-oushixiong1025@163.com>
References: <20260821084748.543645-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 09:01:24 +0000
Message-Id: <20260821090125.62D191F00A3A@smtp.kernel.org>
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
- [High] The `dev_WARN()` macro is called on `sched->dev` without a NULL ch=
eck, which results in a NULL pointer dereference when `sched->dev` is NULL.
--

--- Patch [1]: [PATCH] drm/sched: Guard against NULL dev in drm_sched_job t=
race event ---
commit de5fa30e87a362a3ba489dd802b3a479152bf969
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sched: Guard against NULL dev in drm_sched_job trace event

This commit fixes a NULL pointer dereference in the drm_sched_job trace
event class. It adds a check for sched->dev before calling dev_name()
since the dev field is optional and left NULL in KUnit tests.

> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gp=
u/drm/scheduler/gpu_scheduler_trace.h
> index 261713dd7d5a1..319a3ec54becf 100644
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
> @@ -61,7 +61,8 @@ DECLARE_EVENT_CLASS(drm_sched_job,
>  			     __string(name, sched_job->sched->name)
>  			     __field(u32, job_count)
>  			     __field(int, hw_job_count)
> -			     __string(dev, dev_name(sched_job->sched->dev))
> +			     __string(dev, sched_job->sched->dev ?
> +				      dev_name(sched_job->sched->dev) : "none")

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing NULL poi=
nter
dereferences for sched->dev when it is omitted by KUnit tests, does a simil=
ar
crash happen in drm_sched_can_queue()?

If a job is submitted with credits exceeding sched->credit_limit, we
call dev_WARN() on the same optional sched->dev field:

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_can_queue() {
	...
	if (s_job->credits > sched->credit_limit) {
		dev_WARN(sched->dev,
			 "Jobs may not exceed the credit limit, truncate.\n");
		s_job->credits =3D sched->credit_limit;
	}
	...
}

Unlike dev_err() or drm_dev_printk() which safely handle a NULL device
pointer by printing '(NULL device *)', dev_WARN() is a macro that expands
to include dev_driver_string(dev) and dev_name(dev). Both of these will
unconditionally dereference the dev pointer, leading to a kernel oops.

Could this dev_WARN() be triggered during testing and cause the same oops?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084748.5436=
45-1-oushixiong1025@163.com?part=3D1
