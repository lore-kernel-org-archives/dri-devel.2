Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65331C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B2B10E025;
	Wed, 29 Jul 2026 16:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MMre3tzh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F11310E025
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:21:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E4A7E41715;
 Wed, 29 Jul 2026 16:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5B11F000E9;
 Wed, 29 Jul 2026 16:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785342107;
 bh=mpKl1yrKpRwzs/OwwlkKbdLE1MxKzQ65vcUABt86wX8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MMre3tzhVKgU6IKyFDsosG+Q1bWM3Bpqo80DNQ9XYrG2/UC450IJ3aGLyf+XI1qsb
 QMCKq7bt7ZjmoFbLhhlopUgRuIrc0r2jQ9MxQiCgbJVrln4fRTk0FH8LaEwagv1rNl
 kCbd5xAXFUWLtYgl8RR2zsZcrDrfCKpd69DoQhg2sbVUv2z2yPwcLxtOnlPczyr4Ui
 c/h3UNhHl851hJYpnGRn4Y87kxY9IFl0Z3iqygwhFkJQ7Ung9hN8gQXKj08+mSnKCa
 607dlSNztdoIZ97CfyQ28wk61qV3UxxqJva4cuOMuVX6aawFmhuXxpzgTTNG/bTskF
 B9lVMm8FG+xYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/17] drm/msm: Rework queuelock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-3-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-3-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:21:47 +0000
Message-Id: <20260729162147.9D5B11F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the return value=
 of `drm_sched_entity_init()` is ignored when creating a VM_BIND submitqueu=
e, which can lead to a kernel crash if the allocation fails.
--

--- Patch [2]: [PATCH v7 02/17] drm/msm: Rework queuelock ---
commit 1fecfbcd368f21f80f7078762ebd5da9fae4c122
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Rework queuelock

This commit renames queuelock to ctxlock and transitions it to use cleanup
guards. The change is intended to allow the lock to be reused for other
per-context read/write serialization tasks such as VM creation.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 1a5a77b280163..8b5980d5a6a79 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c

[ ... ]

> @@ -237,7 +234,7 @@ int msm_submitqueue_create(struct drm_device *drm, st=
ruct msm_context *ctx,
>  		return ret;
>  	}
> =20
> -	write_lock(&ctx->queuelock);
> +	guard(rwsem_write)(&ctx->ctxlock);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential bug in
the VM_BIND queue initialization just above this locking change in
msm_submitqueue_create().

Does this code fail to catch allocation errors from drm_sched_entity_init()?

	if (flags & MSM_SUBMITQUEUE_VM_BIND) {
		...
		drm_sched_entity_init(queue->entity, DRM_SCHED_PRIORITY_KERNEL,
				      &sched, 1, NULL);
	} else {
		...
	}

	if (IS_ERR(queue->entity)) {
		ret =3D PTR_ERR(queue->entity);
		...

If drm_sched_entity_init() fails, it returns an error but the return value =
is
silently ignored. The subsequent check for IS_ERR(queue->entity) will evalu=
ate
to false because queue->entity points to a valid inline struct array element
(&queue->_vm_bind_entity[0]).

Could this result in a NULL pointer dereference later on if a job is submit=
ted
to this partially initialized scheduler entity?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D2
