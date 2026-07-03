Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABC5C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 15:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E2010E627;
	Fri,  3 Jul 2026 15:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lZGbLtmN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B7210E627
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 15:43:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 035DE6014B;
 Fri,  3 Jul 2026 15:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE3C1F000E9;
 Fri,  3 Jul 2026 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783093429;
 bh=Oefk5/ZKZ2aiGmx8xwcRh0OMHauTDPlkyGLY0AH1/XY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lZGbLtmNivaK9w2Hk5a4EYfxRe4VfCw6QXwmXqp0yj709Z3hVBNrWyYgBevy9+L4N
 jyAcJQ9WF8Pv9sImi0wMOZBwukTaEYLa/MQ29rMz6j8HvKO7tJPmB1IRrsSh1xYqDm
 czbce5F1E98xPaTz01Xi8iiw9EvFTULyLWE5maVCf27quiaGV7HOR10nMDNB062Ilt
 0p/zgLSUcwAMdcT+8x4iUG+n08lIwOSR6qqqdRDTOhc9S2ieMFy8SnU+EFjxT8t8Jm
 Q4foFdahHcDOPz05WdUv9fXMjwvrWPQCZMIsASeCYf4+y8HoezUzVpItHyi7MIU7TJ
 XPdP1pndR4oiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/v3d: Use write_to_buffer() helper in
 performance query copy
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-v3d-cpu-job-fixes-v3-3-bc51b1f3eeb5@igalia.com>
References: <20260703-v3d-cpu-job-fixes-v3-0-bc51b1f3eeb5@igalia.com>
 <20260703-v3d-cpu-job-fixes-v3-3-bc51b1f3eeb5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 15:43:48 +0000
Message-Id: <20260703154349.5FE3C1F000E9@smtp.kernel.org>
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
- [Critical] The V3D CPU job execution functions do not validate userspace-=
provided offsets, strides, and query counts against the GEM buffer size, al=
lowing trivial out-of-bounds kernel memory reads and writes.
--

commit bccb8e9eddf193e4beeaa67eb00038b0dc9bc030
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Use write_to_buffer() helper in performance query copy

This commit updates the performance query result copy logic to use the
write_to_buffer() helper. This replaces the open-coded 32-bit and 64-bit
selection loops with a single simplified loop.

> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sc=
hed.c
> index e950cee31bcba..21ab9cd836856 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -605,15 +605,8 @@ v3d_write_performance_query_result(struct v3d_cpu_jo=
b *job, void *data,
> =20
>  		v3d_perfmon_stop(v3d, perfmon, true);
> =20
> -		if (job->copy.do_64bit) {
> -			for (j =3D 0; j < perfmon->ncounters; j++)
> -				write_to_buffer_64(data, offset + j,
> -						   perfmon->values[j]);
> -		} else {
> -			for (j =3D 0; j < perfmon->ncounters; j++)
> -				write_to_buffer_32(data, offset + j,
> -						   perfmon->values[j]);
> -		}
> +		for (j =3D 0; j < perfmon->ncounters; j++)
> +			write_to_buffer(data, offset + j, job->copy.do_64bit, perfmon->values=
[j]);

[Severity: High]
This is a pre-existing issue, but does this code properly validate the boun=
ds
of the destination buffer before writing?

Looking at v3d_write_performance_query_result() and the surrounding job
execution functions like v3d_copy_performance_query(), it appears the offse=
t,
stride, and count values provided by userspace are used without being check=
ed
against the GEM object size.

For example, when calculating the initial data pointer and incrementing it:

    data =3D ((u8 *)bo->vaddr) + copy->offset;
    for (int i =3D 0; i < performance_query->count; i++) {
        // ...
        data +=3D copy->stride;
    }

The same pattern seems to exist in v3d_copy_query_results() for timestamp
queries:

    data =3D ((u8 *)bo->vaddr) + copy->offset;

Since these userspace-provided parameters are added directly to the buffer's
kernel virtual address, could this allow an out-of-bounds memory access if
large offset, stride, or count parameters are passed via the CPU job ioctl?

> =20
>  		v3d_perfmon_put(perfmon);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v3d-cpu-jo=
b-fixes-v3-0-bc51b1f3eeb5@igalia.com?part=3D3
