Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFA7CD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C6410ECB8;
	Thu, 11 Jun 2026 05:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lAPNXsoc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B5A10ECB8
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:41:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 83E5C60209;
 Thu, 11 Jun 2026 05:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F991F00893;
 Thu, 11 Jun 2026 05:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781156490;
 bh=dKQBJjOrKln7yEILKhnW2pgfTvc47Eg6VIbvmnw2hsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lAPNXsochqKkYVg/iOQWIhAuRECcx5ecQNA0m1IWfxX5JORmNKIomwc/Zw56VKEiX
 rY2adMGM9BKGvV1Ok3Bq+JL+zYquu1WGvYHLCS5+/2kERV9s4JAyWTyKw8wrRK3HS3
 yuZWBwlG3MUGZTmR+fQ0LoYrG1p2hz7nHH85Y41KY4RpoU0nIM5WgVSMmvWZYk93RT
 X+7PIe8E1egWcx5sWABckrNKtfdsVvDCA/lhA21HKtLYtWSajTs0yvJJ3ysNmvQJZP
 ut2h3TnX7DiNaekJzoiYNmtgniaZObtD0TeCPWwgnBoTv9Lp3ObMqKYrCUxCj/UNQn
 6iPzTyMT91tjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/imagination: Fix double call to
 drm_sched_entity_fini()
To: "Brajesh Gupta" <brajesh.gupta@imgtec.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-b4-sched_fix-v2-1-17a93be86fcd@imgtec.com>
References: <20260611-b4-sched_fix-v2-1-17a93be86fcd@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 05:41:29 +0000
Message-Id: <20260611054130.11F991F00893@smtp.kernel.org>
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
- [High] Missing `drm_sched_entity_fini()` on the context creation error pa=
th leaks the scheduler entity and can cause a use-after-free.
- [Low] Missing semicolon in `pvr_context_destroy_queues()` causes a syntax=
 error.
--

commit 7864ceeaa41cde8bf7fefb9b24c11520d33badc2
Author: Brajesh Gupta <brajesh.gupta@imgtec.com>

drm/imagination: Fix double call to drm_sched_entity_fini()

This commit resolves a double call to drm_sched_entity_fini() that was
causing a refcount underflow use-after-free. It removes the
drm_sched_entity_fini() call from pvr_queue_destroy() and introduces a
boolean flag to conditionally call it in pvr_context_destroy_queues().

> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/=
imagination/pvr_context.c
> index eba4694400b5a..f11a45d046326 100644
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c
> @@ -161,21 +161,36 @@ ctx_fw_data_init(void *cpu_ptr, void *priv)
>  /**
>   * pvr_context_destroy_queues() - Destroy all queues attached to a conte=
xt.
>   * @ctx: Context to destroy queues on.
> + * @queue_entity_fini: Corresponding queues of context to be released for
> + *                     failure path in context creation.
>   *
>   * Should be called when the last reference to a context object is dropp=
ed.
>   * It releases all resources attached to the queues bound to this contex=
t.
>   */
> -static void pvr_context_destroy_queues(struct pvr_context *ctx)
> +static void pvr_context_destroy_queues(struct pvr_context *ctx, bool que=
ue_entity_fini)
>  {
>  	switch (ctx->type) {
>  	case DRM_PVR_CTX_TYPE_RENDER:
> +		if (queue_entity_fini) {
> +			drm_sched_entity_fini(&ctx->queues.fragment->entity);
> +			drm_sched_entity_fini(&ctx->queues.geometry->entity)

[Severity: Low]
Is a semicolon missing at the end of this line? This will cause a compiler
syntax error.

[Severity: High]
Could this cause a crash on partial allocation failure if true was passed?
The queues are unconditionally accessed here in pvr_context_destroy_queues(=
),
so if ctx->queues.fragment or ctx->queues.geometry is NULL, evaluating the
address of the entity member on a NULL pointer and passing it to the fini
function will cause a crash.

> +		}
> +
>  		pvr_queue_destroy(ctx->queues.fragment);
>  		pvr_queue_destroy(ctx->queues.geometry);
>  		break;

[ ... ]

> @@ -240,7 +255,7 @@ static int pvr_context_create_queues(struct pvr_conte=
xt *ctx,
>  	return -EINVAL;
> =20
>  err_destroy_queues:
> -	pvr_context_destroy_queues(ctx);
> +	pvr_context_destroy_queues(ctx, false);

[Severity: High]
Does this leak the scheduler entity of successfully created queues during a
partial allocation failure?

If pvr_context_create_queues() successfully creates the geometry queue but =
fails
to create the fragment queue, it jumps to err_destroy_queues. By passing fa=
lse,
the successfully created geometry queue's scheduler entity is never finaliz=
ed
since pvr_queue_destroy() no longer does it unconditionally.

This leaks the entity's internal resources and frees the queue memory while
the scheduler might still hold references to the entity, potentially leading
to a use-after-free.

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-sched_f=
ix-v2-1-17a93be86fcd@imgtec.com?part=3D1
