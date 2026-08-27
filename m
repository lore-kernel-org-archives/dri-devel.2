Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B3BC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 20:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0613410F1BE;
	Thu, 27 Aug 2026 20:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S7Eql4aK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BE910F1BE
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:46:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FFF241A6E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 20:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234FF1F000E9;
 Thu, 27 Aug 2026 20:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787863577;
 bh=my7CA58FhcHQJAfdG3+erMAP+U9Zp04aLzW2/KEt5rI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S7Eql4aKFXtCYbsXutpdtOOUF16KkdEeFvtVW4NvUojB9Tp2wk+zsS3dGbZdhBNRj
 EABYi22MTAgNXXb1/p48E9pzme70R09r51slckgvfR70CLXJ4vQOxQSCq5c6JzSuaK
 jyKF6nrSUeCzI43/psye9RA7+t+UmLlWJUzRA2yhVPNrYgNc//Em5bdJYvlC722dUO
 txfCvyGpAd7q+F3yf24QkiMOoq4iA6z2EN0NrCmHmKsO3Oz7QvbJHEhESbQqDWzfDJ
 ltYgNubz1wRYzuvqBSWuci5HnOR4pkyevfGJeBrjIzgURKgl3fvLtCs24LjXat/zOa
 29EbdXmLkuivw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] accel: ethosu: Fix ethosu_job_open() return value
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827-ethosu-fixes-v1-1-346f9ea8791c@kernel.org>
References: <20260827-ethosu-fixes-v1-0-346f9ea8791c@kernel.org>
 <20260827-ethosu-fixes-v1-1-346f9ea8791c@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 20:46:16 +0000
Message-Id: <20260827204617.234FF1F000E9@smtp.kernel.org>
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
- [High] The dynamically allocated `done_fence` is leaked on error paths du=
ring job submission in `ethosu_ioctl_submit_job`.
- [High] NULL pointer dereference in `ethosu_ioctl_submit_job` error path d=
ue to premature cleanup of an uninitialized scheduler job.
--

commit f1366d3916a7ec335127047da47dbe3724095b0c
Author: Rob Herring (Arm) <robh@kernel.org>

    accel: ethosu: Fix ethosu_job_open() return value
   =20
    A WARN_ON() returns a 0 or 1, not the original negative errno. Just drop
    the WARN_ON() as the FD open will pass the return code to userspace and
    there's only one possible source of the error (drm_sched_entity_init()).

> diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/eth=
osu_job.c
> index 6a038c0384ccd..99c8812691e55 100644
> --- a/drivers/accel/ethosu/ethosu_job.c
> +++ b/drivers/accel/ethosu/ethosu_job.c

[ ... ]

While reviewing this file, I noticed a couple of pre-existing issues in the
job submission error paths.

If the ejob->done_fence allocation fails, it bypasses job initialization but
still attempts cleanup:

drivers/accel/ethosu/ethosu_job.c:ethosu_ioctl_submit_job() {
    ...
	ejob->done_fence =3D kzalloc_obj(*ejob->done_fence);
	if (!ejob->done_fence) {
		ret =3D -ENOMEM;
		goto out_cleanup_job;
	}

	ret =3D drm_sched_job_init(&ejob->base,
				 &file_priv->sched_entity,
				 1, NULL, file->client_id);
    ...
out_cleanup_job:
	if (ret)
		drm_sched_job_cleanup(&ejob->base);
out_put_job:
	ethosu_job_err_cleanup(ejob);

	return ret;
}

[Severity: High]
This isn't a bug introduced by this patch, but does calling
drm_sched_job_cleanup(&ejob->base) cause a NULL pointer dereference here?

Since drm_sched_job_init() hasn't been called yet, ejob->base.s_fence is
completely zero-initialized. drm_sched_job_cleanup() unconditionally
dereferences job->s_fence when checking the reference count, which would
trigger a panic on this memory allocation failure path.

Additionally, looking at the cleanup function called further down that same
error path:

drivers/accel/ethosu/ethosu_job.c:ethosu_job_err_cleanup() {
	unsigned int i;

	ethosu_perfmon_put(job->perfmon);

	for (i =3D 0; i < job->region_cnt; i++)
		drm_gem_object_put(job->region_bo[i]);

	drm_gem_object_put(job->cmd_bo);

	kfree(job);
}

[Severity: High]
This is a pre-existing issue, but will this leak ejob->done_fence?

If ethosu_ioctl_submit_job() fails later in the function (for example, if
drm_gem_object_lookup() returns an error), it jumps to out_cleanup_job and
eventually calls ethosu_job_err_cleanup(). The cleanup function frees the
job container and BOs, but appears to miss freeing the dynamically allocated
ejob->done_fence pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-ethosu-fix=
es-v1-0-346f9ea8791c@kernel.org?part=3D1
