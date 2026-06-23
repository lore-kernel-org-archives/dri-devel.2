Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186ABCDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC3110EC8E;
	Tue, 23 Jun 2026 20:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZbLD1DCM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7278010EC8E
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:21:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AF56437CD;
 Tue, 23 Jun 2026 20:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D161F000E9;
 Tue, 23 Jun 2026 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782246095;
 bh=pHH1PrpJDch6KEEeOBE+hFet0zj2Xl34d92I9ingdGE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZbLD1DCMeS81WbEYv9iWjxdh889R4lVxhE2oHKjjMV/gR0itaSeEFwtBI9yhkdiOO
 AYnhHNrtF5ouH98b//1nKHDO+/z0xJ6dpfk8DIC7R3VsSeBA4s+0zSr+wHecqD770i
 NwA2mhWhD8YT+quAb8jGVg4Ib7ptlUW0jJ8hKHcQk/4721qN40EqeLt8dTVVqMZhk0
 n8bs4+NUBWxb9TA72dzJ0vvKRZ8JjstdceWbENSjh3ifuJqqFKXCMheyBLBtIftW/+
 tDQ0zxkUOsvvWmHZxrvOBaY7uxuuj36xRMlifmCFZVLECzpdsUoF8SlaDosSkFPuRR
 jlDjf/s/dmphw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/v3d: Associate BOs with every job that
 accesses them
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260618-v3d-cpu-job-fixes-v2-1-fec132484fc4@igalia.com>
References: <20260618-v3d-cpu-job-fixes-v2-0-fec132484fc4@igalia.com>
 <20260618-v3d-cpu-job-fixes-v2-1-fec132484fc4@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:21:34 +0000
Message-Id: <20260623202135.23D161F000E9@smtp.kernel.org>
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
- [High] Incomplete fix: `bin` job lacks implicit synchronization dependenc=
ies due to missing BO attachment.
--

commit 847118b5a0479c86d14ca61360fb6fc43c737179
Author: Ma=C3=ADra Canal <mcanal@igalia.com>

drm/v3d: Associate BOs with every job that accesses them

This patch modifies the V3D driver to attach buffer objects (BOs) to every
job in a submission chain rather than just the last job. This is intended to
ensure all jobs receive the proper implicit synchronization dependencies
during reservation locking.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index ee2ac2540ed50..18467e448c91f 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c

[ ... ]

> @@ -1085,6 +1081,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *=
data,
>  	if (ret)
>  		goto fail;
> =20
> +	ret =3D v3d_lookup_bos(submit.file_priv, &render->base,
> +			     args->bo_handles, args->bo_handle_count);
> +	if (ret)
> +		goto fail;
> +

[Severity: High]
This is a pre-existing issue, but does the bin job also need to have BOs
attached to pick up the correct implicit dependencies?

The commit message indicates that v3d_lookup_bos() should be called for
each job that references the submission's BOs. However, it looks like
v3d_lookup_bos() is only being called for the render job here.

If a userspace client submits a binner command list, the bin job is created
earlier in v3d_submit_cl_ioctl() via v3d_submit_add_job(). Because
v3d_lookup_bos() is not called for it, bin->base.bo_count remains 0.

Could this cause the hardware to execute the bin job without implicit
synchronization, potentially leading to corrupted data if another context
is still writing to the BOs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-v3d-cpu-jo=
b-fixes-v2-0-fec132484fc4@igalia.com?part=3D1
