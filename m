Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44105606A338
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckZGvWA5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB941127F4;
	Thu,  5 Nov 2026 15:57:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D911128E5;
 Thu,  5 Nov 2026 15:57:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FD8D40DEC;
 Thu,  5 Nov 2026 15:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516401F000C1;
 Thu,  5 Nov 2026 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793894255;
 bh=qpdR6K2g9g6lnk81BF/YfSgP2W7Zk1QblKyohooqVm8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ckZGvWA5kOAk0uyCyX0/33KupS/oF7tNc4vBOPn9tYmFI/swZbpEbXInB4tOFzJz3
 diK06JFEv7ygAkwin81G1dyTErRLhxFHXlLveMm8EVF2Wn266ehuciSL3ZdckS8GBl
 oYN90HUmEI02w+XcmYfKujhS72J0GQcZD3IjxgIWv6C3AU7XHxf2kt3kDB9DgKWrBE
 es1oaafo5HoX2IGUTUreMyVmu94OCI9mrnJzqS/ifTU516JLWaz7iS7oxS5o1oXqTC
 IjQRbU+1SQbUrbAlSbUd3v9Vim8aYKuf7Bc2JchWe1qKysst2lT2syHFmsHjq/91PG
 1/idm/l4Vab2g==
Message-ID: <sashiko-outbox-199387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/selftests: read the seqno before dropping the
 request
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104025345.1527509-1-vulab@iscas.ac.cn>
References: <20261104025345.1527509-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:57:34 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/i915/selftests: rq->hwsp_seqno[] read after retire in perf_m=
i_bb_start()
--

commit 50caf80a061d2ff30673d4eea9e27e211c297b1d
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/i915/selftests: read the seqno before dropping the request

This commit moves the read of rq->hwsp_seqno[] in perf_mi_bb_start()
before i915_request_put(rq) so the request reference is held while
sampling the cycle counts.

> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/d=
rm/i915/gt/selftest_engine_cs.c
> index 5ffa5e30f4192..1846f1c7e77ee 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> @@ -196,11 +196,17 @@ static int perf_mi_bb_start(void *arg)
> =20
>  			if (i915_request_wait(rq, 0, HZ / 5) < 0)
>  				err =3D -EIO;
> +
> +			/*
> +			 * The request can be freed as soon as its last
> +			 * reference is dropped, so read the seqno first.
> +			 */
> +			if (!err)
> +				cycles[i] =3D rq->hwsp_seqno[3] - rq->hwsp_seqno[2];

[Severity: Medium]
Does holding a reference on rq prevent rq->hwsp_seqno from being
redirected away from the timeline HWSP when i915_request_retire() runs?

In the scenario described by the commit message, where
i915_request_retire() runs before or concurrently with
i915_request_wait() returning, i915_request_retire() calls
i915_request_mark_complete() before signaling rq->fence and dropping the
initial request reference:

drivers/gpu/drm/i915/i915_request.c:i915_request_retire() {
	...
	trace_i915_request_retire(rq);
	i915_request_mark_complete(rq);
	...
	if (!i915_request_signaled(rq)) {
		spin_lock_irq(&rq->lock);
		dma_fence_signal_locked(&rq->fence);
		spin_unlock_irq(&rq->lock);
	}
	...
	i915_request_put(rq);
}

And i915_request_mark_complete() rewrites rq->hwsp_seqno to point at the
64-bit rq->fence.seqno field inside struct dma_fence:

drivers/gpu/drm/i915/i915_request.h:
static inline void i915_request_mark_complete(struct i915_request *rq)
{
	WRITE_ONCE(rq->hwsp_seqno, /* decouple from HWSP */
		   (u32 *)&rq->fence.seqno);
}

Once i915_request_mark_complete() has executed, indexing
rq->hwsp_seqno[2] and rq->hwsp_seqno[3] in perf_mi_bb_start() reads out
of bounds past rq->fence.seqno into adjacent fields of struct dma_fence
(rq->fence.flags and rq->fence.refcount) rather than reading the
timestamps written by write_timestamp(rq, 2) and write_timestamp(rq, 3)
in the timeline HWSP.

Should perf_mi_bb_start() save const u32 *hwsp =3D rq->hwsp_seqno before
calling i915_request_add(rq) (similar to __live_rc6_ctx() in
drivers/gpu/drm/i915/gt/selftest_rc6.c), or read from
ce->timeline->hwsp_seqno directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104025345.1527=
509-1-vulab@iscas.ac.cn?part=3D1
