Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F0C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C1310E460;
	Fri, 28 Aug 2026 05:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ggjg++bd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1158C10E460
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:19:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B4D2601F5;
 Fri, 28 Aug 2026 05:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73101F000E9;
 Fri, 28 Aug 2026 05:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787894366;
 bh=EmoAUNlRnafWN89JvxUxFolfWr2AGTtq+VafFn3Yh38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ggjg++bdcXEjcZym9CEOZZDTb+ybbRWgubxWgGngLp82a8IYhjM5stcYSJ2oivbLr
 cgJoRWDiMM1SJhf6N++/uqJ44ICEBvGnKLrindP2rODcEJ9EcPM/OHMrC//vKdusdg
 H0mv40l3cIUsffjrTbPs+TXk8mOMzJjNbUQ7NK9NVsYEZoZpC9eOUQjjCcPpkJ8406
 5LBANtt07NvSPWxZs9tHItPGo4ugi7O+xWwKu5N+8+l+Hi/8EXhIbLpsZdL646CK5j
 xZvcPZcugV5jkAwsY0SriwzSLViKCDbGxIss80CwoDCOjXWI0pBERAdIp0Y6bqK8nf
 vI6MnpYd3tNTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] accel/rocket: Propagate job submission errors
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828050805.38548-4-Naixumogu@whut.edu.cn>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-4-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 05:19:26 +0000
Message-Id: <20260828051926.C73101F000E9@smtp.kernel.org>
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
- [High] Unrecoverable partial job submission due to missing progress repor=
ting.
--

commit 62a6d62ce92d524109acbfd3cf943820e07879c2
Author: MoGGuU <Naixumogu@whut.edu.cn>

accel/rocket: Propagate job submission errors

This commit updates rocket_ioctl_submit() to return the first error
encountered during job submission and stop processing remaining jobs.
Previously, errors from individual job submissions were ignored.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index b55e12aecfe64..8f1bdf4a57f20 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -646,8 +646,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void=
 *data, struct drm_file *fil
>  	}
> =20
> -	for (i =3D 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i =3D 0; i < args->job_count; i++) {
> +		ret =3D rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;
> +	}
> =20
>  exit:
>  	kvfree(jobs);

[Severity: High]
How does userspace determine how many jobs were successfully submitted befo=
re
the error occurred?

When rocket_ioctl_submit() halts on the first error, the previously submitt=
ed=20
jobs remain queued, giving ordered partial-submit semantics. However, looki=
ng
at the UAPI struct drm_rocket_submit in include/uapi/drm/rocket_accel.h:

struct drm_rocket_submit {
        __u64 jobs;
        __u32 job_count;
        __u32 job_struct_size;
        __u64 reserved;
};

There is no output field (like jobs_submitted) to communicate the partial
success state back to userspace, and the kernel does not modify the incoming
job_count.

Without knowing the index of the failed job, if a user application encounte=
rs
an error (for example, due to an invalid BO handle or memory allocation
failure), how can it safely recover?=20

If userspace retries the submission, it risks double-submitting already
queued jobs, which can corrupt hardware state. If it aborts entirely, it may
hang waiting for implicit fences on BOs that were successfully submitted.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828050805.3854=
8-1-Naixumogu@whut.edu.cn?part=3D3
