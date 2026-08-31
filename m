Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3066C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00C510E60F;
	Mon, 31 Aug 2026 05:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nP7Pj3E3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F8210E602
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 05:51:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 207A842DBD;
 Mon, 31 Aug 2026 05:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF71F000E9;
 Mon, 31 Aug 2026 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788155465;
 bh=A1jHxH1MhMyINxh+jZocV7LCYQuCYj2eZGq2PaaWQy8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nP7Pj3E3tsk+g85fHAMYHqfGEW050hQQd0irB14dfh0bOJDlUbdhxo27kybNyS9GB
 Tvi5NmOtrTcfQs2Ovrqi4txNiPB1UPaLBLV5tJqAjtq/T1t8cymSayaFu6zhCvGyJT
 6wvEmefvDDADGoL2PUG/fepWOQ0H5aTi4Ld7DyiTJRMXgfvjNTqIuir5s/fUDW4u1j
 xXFNlW1criS2/9sjVM/hk58e5SDbIfJVoZMVaHs1ow8BztrRE28jQyii4cJMSdC19R
 KOsLl7d5HDYuMOn6ETM6UJzRGHvLypS9t1qAnUkT9FV1sPLam/yj369NLAStgnDWyn
 lElIODFyKEIQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] drm: Add per-signal compare functionality to
 drm_user_fence
To: "Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831054154.107602-5-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831054154.107602-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 05:51:04 +0000
Message-Id: <20260831055104.E3CF71F000E9@smtp.kernel.org>
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
- [High] Blocking workqueue threads indefinitely via get_user() and userfau=
ltfd/FUSE.
--

commit ca21d7e20dc2d16871f1fee93d9a731a24dbe2fa
Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
drm: Add per-signal compare functionality to drm_user_fence

This commit adds optional compare fields to drm_user_fence and a helper
function to configure them. When configured, the worker reads a value from
userspace via get_user() upon fence signaling, and executes the callback
only if the comparison passes.

> diff --git a/drivers/gpu/drm/drm_user_fence.c b/drivers/gpu/drm/drm_user_=
fence.c
> index 664178e2d74cf..9e141533622e7 100644
> --- a/drivers/gpu/drm/drm_user_fence.c
> +++ b/drivers/gpu/drm/drm_user_fence.c
[ ... ]
> @@ -12,21 +12,68 @@
[ ... ]
>  static void drm_user_fence_do_work(struct drm_work_fence *wfence)
>  {
[ ... ]
> +	if (ufence->cmp_op !=3D DRM_USER_FENCE_CMP_NONE) {
> +		if (!mm_ok) {
> +			call_worker =3D false;
> +		} else {
> +			u64 cur_val;
> +
> +			if (get_user(cur_val, ufence->cmp_addr) ||

[Severity: High]
Can a malicious userspace application configure cmp_addr to point to a memo=
ry
region monitored by userfaultfd or a slow FUSE filesystem, and intentionally
never resolve the page fault?

Since drm_user_fence_do_work() runs on a kernel workqueue thread, blocking
indefinitely in get_user() without pagefault protections could stall the
workqueue. If this workqueue is shared, ordered, or thread-pool constrained,
this could prevent other kernel tasks from executing and lead to a denial of
service.

> +			    !drm_user_fence_cmp_match(cur_val,
> +						      ufence->cmp_value,
> +						      ufence->cmp_op))
> +				call_worker =3D false;
> +		}
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827062142.4038=
272-1-srinivasan.shanmugam@amd.com?part=3D4
