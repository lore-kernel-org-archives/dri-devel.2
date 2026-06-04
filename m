Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52981CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:51:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9371125B5;
	Thu,  4 Jun 2026 02:51:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z4Yn0tC0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F7AD1125B5
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:51:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 68BEB41735;
 Thu,  4 Jun 2026 02:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241CE1F00893;
 Thu,  4 Jun 2026 02:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541466;
 bh=kh6xJcmQbIQ3MBkTAqhJxFpsGUXZG/Y/9No3BJ7SzFs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z4Yn0tC0Hh1fTE0MZmY3o+nFtSb8mA4XIfDhsPm8SktBHJBWRxysOhlk3BOfNgbqc
 l5Hua07R90+UOos7QLssB49NxhmzJMLU5FDS/bQiJ1qA/YQ1FdfTEx4Nx0Tg/gdYp/
 uVHilPDTkY9ngQVSk79Mu7S3ARCLJ7NZDpo6KOgTM8kExsLRK1EY+yzjbGChDuUytE
 odRWxHgxnnge6tR0ZaTtr6avWT3+RlVGtmJEHk+U03jsiGuxwaxzlYHW55I1ecFjYy
 M/kvD+JuLIRb8meLyCGyhGnRMBKJD4wmYqK6I23SNLoIO3SSKA99rAkez/Nso7SnTs
 hnCPrSenu/WIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/14] drm/v3d: Reject invalid syncobj handles in
 submit ioctls
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-6-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-6-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:51:05 +0000
Message-Id: <20260604025106.241CE1F00893@smtp.kernel.org>
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
- [High] Missing bounds check on userspace-controlled `in_sync_count` and `=
out_sync_count`, potentially leading to soft lockups or unbounded memory al=
location attempts.
--

commit 99860a2dd307ceb7455992b876495c7efeeb7909
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Reject invalid syncobj handles in submit ioctls

This commit modifies v3d_job_add_syncobjs() to properly propagate error
codes when a non-zero syncobj handle doesn't resolve, while continuing to
ignore zero handles.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 8250376d104c5..0babe2e672660 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -208,11 +207,13 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct dr=
m_file *file_priv,
>  				return -EFAULT;
>  			}
> =20
> -			ret =3D drm_sched_job_add_syncobj_dependency(&job->base,
> -								   file_priv, in.handle, 0);
> -			// TODO: Investigate why this was filtered out for the IOCTL.
> -			if (ret && ret !=3D -ENOENT)
> -				return ret;
> +			/* Ignore syncobj if its handle is zero */
> +			if (in.handle) {
> +				ret =3D drm_sched_job_add_syncobj_dependency(&job->base,
> +									   file_priv, in.handle, 0);
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but is se->in_sync_count bounded by any=20
upper limit?

This code is executing inside a loop over the userspace-supplied=20
se->in_sync_count:

v3d_job_add_syncobjs() {
    ...
    for (int i =3D 0; i < se->in_sync_count; i++) {
        struct drm_v3d_sem in;

        if (copy_from_user(&in, handle++, sizeof(in))) {
    ...
}

Since there is no cond_resched() in this loop, could a maliciously large=20
in_sync_count value allow a user to monopolize the processor and cause a=20
soft lockup?

Similarly, is se->out_sync_count bounded before it is used for memory=20
allocation in v3d_get_multisync_post_deps()?

v3d_get_multisync_post_deps() {
    ...
    se->out_syncs =3D (struct v3d_submit_outsync *)
        kvmalloc_objs(struct v3d_submit_outsync, count);
    if (!se->out_syncs)
    ...
}

Could an unbounded out_sync_count lead to a massive memory allocation=20
request, potentially exhausting physical memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D6
