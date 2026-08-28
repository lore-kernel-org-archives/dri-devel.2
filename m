Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C55C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC66E10F25C;
	Fri, 28 Aug 2026 06:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e3L4QJ/I";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7789C10E47B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:29:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 295BA4189F;
 Fri, 28 Aug 2026 06:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F1E1F000E9;
 Fri, 28 Aug 2026 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787898559;
 bh=6cn45GuH49htG204wLwlPAvQHel1RPlEvGnfQHHMNfM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e3L4QJ/IBh61rlSLIWuwUJVP9jqK7C+jfn4I5zgNyWXKIO+bsOtGMHsceI8H2aRFb
 YvIuOhQoR0r9N9oAF5RETqX3FHwYxbqbs2VMbGHKlcDBRz0/Lc5xSZzOQYTfEPqN/j
 q9vgnv7VJ7Jv3RxE8ecdERsbpbIyzfH2+T9KPGqKPu5j9Ax2S305igvNVYfmjhR59I
 flv42gzxliFKvIIHX3XlMU0BD9ybvY+Hn4wSPHKGhlEdnCrh9jP/GlzlxZegR5iP/8
 1KBPLQ5cZ6n+H6Zh9+C5AmzihTVIl8HB5leopN0UTyKcF8fzwJ5WivsS9m6pCAUbYY
 gZgGly64SOlgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] accel/rocket: Propagate job submission errors
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828061916.20405-4-Naixumogu@whut.edu.cn>
References: <20260828061916.20405-1-Naixumogu@whut.edu.cn>
 <20260828061916.20405-4-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:29:18 +0000
Message-Id: <20260828062918.E1F1E1F000E9@smtp.kernel.org>
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

New issues:
- [High] The ioctl introduces ordered partial-submit semantics but fails to=
 report how many jobs were successfully submitted, making error recovery im=
possible for userspace.

Pre-existing issues:
- [High] Unbounded memory allocation due to missing limit on args->job_coun=
t.
--

commit 41a2028e803565dfe6bad77987c577fafe68aee4
Author: MoGGuU <Naixumogu@whut.edu.cn>
accel/rocket: Propagate job submission errors

The patch updates rocket_ioctl_submit() to check the return value of each
job submission instead of discarding it. It now returns the first error
encountered and stops submitting the remaining jobs, providing ordered
partial-submit semantics.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 1634c30ede456..cd2ae1def74d1 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -647,8 +647,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void=
 *data, struct drm_file *fil
>  	}
> =20
> =20

[Severity: High]
This is a pre-existing issue, but is there a missing limit on args->job_cou=
nt
before the loop?

Looking at rocket_ioctl_submit(), there is an unbounded allocation based on
this user-controlled parameter earlier in the function:

	jobs =3D kvmalloc_objs(*jobs, args->job_count);
	if (!jobs) {
		drm_dbg(dev, "Failed to allocate incoming job array\n");
		return -ENOMEM;
	}

Could an untrusted user supply a maliciously large args->job_count to cause
system memory exhaustion and invoke the OOM killer?

> -	for (i =3D 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i =3D 0; i < args->job_count; i++) {
> +		ret =3D rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;

[Severity: High]
Does this code fail to report how many jobs were successfully submitted when
it aborts partially through?

When a job fails partway through the submission loop, the ioctl aborts and
propagates the error, leaving any previously queued jobs in place (ordered
partial-submit semantics). But without returning the progress state (e.g.,
which index failed) to userspace, doesn't this create an unrecoverable
job state ambiguity? If userspace retries, they might duplicate execution
of the already-submitted jobs.

> +	}
> =20
>  exit:
>  	kvfree(jobs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828061916.2040=
5-1-Naixumogu@whut.edu.cn?part=3D3
