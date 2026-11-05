Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB303606BE89
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHf0qfX2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C174E10E03B;
	Thu,  5 Nov 2026 15:57:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DB510E03B;
 Thu,  5 Nov 2026 15:57:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DED9600E4;
 Thu,  5 Nov 2026 15:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026511F000C1;
 Thu,  5 Nov 2026 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793894238;
 bh=WFbJnHUJthqWoKQwnspd3YYpoedebL6dISXVoLtDI4c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CHf0qfX2Fr+3T/kPFZcz3JZWuzWH6IBQ0yoIPjVnIv8B+9B1VNVcZjPBhtZK/warG
 y91I+fsWqcb3PFsxzws918aZ5knxKjkSVQD2Sczsl4mJlxMRoI2ImGJexM5cr5eanM
 yGd1QEeoECBCqlrTh+9zMp2uvNTc4z5QdQ5iNUNc3yVtiyvU5NRX1V01kJWR2oNcUj
 WsUCia7SAl9a6qP5tgL+H8Y5AvZLWEj5+nlgEmb62QKB4b/ZQNwl+gqeXucFpZJG7w
 9frkwHhH1rapBggj8lKEHpkhHeTodzhPUevYdeC9KpMo/jHzFjxbL0TArwUTqfR7RS
 PSAT0e9sHUi9Q==
Message-ID: <sashiko-outbox-199383@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/selftests: read the noop seqno before dropping
 the request
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261104025344.1527492-1-vulab@iscas.ac.cn>
References: <20261104025344.1527492-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 15:57:17 +0000
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
- [Medium] drm/i915/selftests: rq->hwsp_seqno overwrite on retire in perf_m=
i_noop()
--

commit 00425305585429060b5834586fddd6fa9a9e06c4
Author: Wentao Liang <vulab@iscas.ac.cn>

drm/i915/selftests: read the noop seqno before dropping the request

This commit moves the read of rq->hwsp_seqno[] in perf_mi_noop() before
i915_request_put(rq) so that the request is not freed before the seqno slots
are sampled.

> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c b/drivers/gpu/d=
rm/i915/gt/selftest_engine_cs.c
> index 5ffa5e30f4192..cfe73b51557a1 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_cs.c
> @@ -351,13 +351,19 @@ static int perf_mi_noop(void *arg)
> =20
>  			if (i915_request_wait(rq, 0, HZ / 5) < 0)
>  				err =3D -EIO;
> +
> +			/*
> +			 * The request can be freed as soon as its last
> +			 * reference is dropped, so read the seqno first.
> +			 */
> +			if (!err)
> +				cycles[i] =3D
> +					(rq->hwsp_seqno[4] - rq->hwsp_seqno[3]) -
> +					(rq->hwsp_seqno[3] - rq->hwsp_seqno[2]);

[Severity: Medium]
If i915_request_retire(rq) has already run (or runs concurrently), will
reading rq->hwsp_seqno[2..4] here still read out of bounds of
rq->fence.seqno instead of reading the timeline HWSP?

At the start of i915_request_retire(), before signaling rq->fence or
dropping the request reference, it calls i915_request_mark_complete():

drivers/gpu/drm/i915/i915_request.c:i915_request_retire() {
	...
	trace_i915_request_retire(rq);
	i915_request_mark_complete(rq);
	...
}

drivers/gpu/drm/i915/i915_request.h:i915_request_mark_complete() {
	WRITE_ONCE(rq->hwsp_seqno, /* decouple from HWSP */
		   (u32 *)&rq->fence.seqno);
}

Holding a reference via i915_request_get(rq) keeps the request object alive,
but once i915_request_mark_complete(rq) executes, rq->hwsp_seqno points to
rq->fence.seqno inside struct dma_fence rather than the timeline HWSP where
write_timestamp() wrote slots 2, 3, and 4. Indexing rq->hwsp_seqno[2..4]
then reads past the 64-bit rq->fence.seqno field into adjacent fields of
struct dma_fence.

Should perf_mi_noop() save the timeline HWSP pointer (for example from
rq->hwsp_seqno or ce->timeline->hwsp_seqno) before calling
i915_request_add(rq), similar to __live_rc6_ctx() in
drivers/gpu/drm/i915/gt/selftest_rc6.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104025344.1527=
492-1-vulab@iscas.ac.cn?part=3D1
