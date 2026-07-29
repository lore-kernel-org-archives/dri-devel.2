Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38861C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7015110E098;
	Wed, 29 Jul 2026 18:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RutC/e9+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BC310E098
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:14:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B2636001D;
 Wed, 29 Jul 2026 18:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A2B1F000E9;
 Wed, 29 Jul 2026 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785348880;
 bh=KYcHAp0wLOCkCIFS4jynpP5AOj7HQ6wwPCm5iKrwxVo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RutC/e9+zxA7aK4/Pl+4hARXMFT3BRUBXzVhpDCAJjguZ9xXAEhJ1xBG8ad3GekCH
 KRZ7ud4kUytcw/eV3nSYvCmoQBEczDW+N76uLjAzp1cjgSlnXCu8bpKCqffdtqhG/m
 a9siB3pGXTy9zlab8QUj0W96e55s3Fl5BVPgHgO/01UTaM1PZw4UzwR5qehpp7AWVK
 REl3qk2buxmqQErv961GKS1Gkm3lbwD6dR9peitBsHzK25KawpMdCaCVZTK96mrR/V
 K6X0Dk0XPROkkC5Q0KZPeOfINt4SZ7AUFmdTO+deMSKBF5dRQ9N4v1Tnm65NIQGBO1
 A8EyCoCRIvt0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/17] drm/msm: Move nr_cmds initialization
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-6-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:14:39 +0000
Message-Id: <20260729181439.E7A2B1F000E9@smtp.kernel.org>
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
- [Critical] Direct access to lazy-initialized `ctx->vm` without ensuring i=
t exists causes a NULL pointer dereference.
- [Critical] The overflow check `sz > SIZE_MAX` after using `struct_size()`=
 is dead code on 64-bit architectures, providing no protection against inte=
ger overflows.
--

--- Patch [5]: [PATCH v7 05/17] drm/msm: Move nr_cmds initialization ---
commit cc137d18d60eae340c7d4959cae7bc281443d450
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Move nr_cmds initialization

Previously if we entered an error path between these two points, we
could leak the relocs tables due to submit->nr_cmds still being zero.

In practice, relocs are disallowed on a6xx+, and non-ancient userspace
will not use relocs on earlier gens unless running on an ancient kernel.
But userspace could use this to trigger a memory leak.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

> diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/m=
sm_gem_submit.c
> index 3c6bc90c3d486..aa48ea4e7f584 100644
> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c

[Severity: Critical]
This is a pre-existing issue, but does submit_create() have a dead code
overflow check?

In drivers/gpu/drm/msm/msm_gem_submit.c:submit_create():

	sz =3D struct_size(submit, bos, nr_bos) +
			((u64)nr_cmds * sizeof(submit->cmd[0]));

	if (sz > SIZE_MAX)
		return ERR_PTR(-ENOMEM);

On 64-bit architectures, sz (a uint64_t) cannot exceed SIZE_MAX. If
struct_size() overflows, it returns SIZE_MAX, and adding to it wraps
around to a small value.

This bypasses the size check and causes an undersized allocation, which
could lead to a heap buffer overflow since nr_bos and nr_cmds are
user-controlled via the MSM_GEM_SUBMIT ioctl.

[Severity: Critical]
This is a pre-existing issue, but does msm_ioctl_gem_submit() dereference
an uninitialized pointer?

In drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit():

	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");

Since ctx->vm uses lazy initialization, it can be NULL if the DRM context
was just created.

Accessing ctx->vm without calling msm_context_vm() first can lead to a
NULL pointer dereference if a userspace application calls the
MSM_GEM_SUBMIT ioctl immediately after context creation.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D5
