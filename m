Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A1BCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 182CA10E2D1;
	Tue, 29 Sep 2026 17:44:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EUA4IlBN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA99C10E2D1;
 Tue, 29 Sep 2026 17:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 929AB407E6;
 Tue, 29 Sep 2026 17:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD8B1F000FF;
 Tue, 29 Sep 2026 17:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790703897;
 bh=PJ8QwMmbJvef1GOGqKP7q6xyZbH9Aaxew31ujZXXMd8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EUA4IlBNIZTIvaUedG8Ir51wkyb+XckmWkDQNi2GYtQZU6CebtnguZKhhh3HLQY9l
 7aKjorflzpK+PkktesZlbEs5JApUVzUDEGv/v1RmpBQGcpGE5aUjenS/lZqf2L2s0R
 iz/3podlvgR9DyypOBObdWPHY+Ek/D5aoe6j7s3XiPReB+POFXq10t7vEGE94bb9KS
 cKUvZx02rNs0ix1Ttt4m3NYhfTFWZyIHaNA5FI468CbLe3skibcasxlYbTxLSX+e4E
 qWWhnO5H/mummfFnJla9lG/+LZFKL7r7LFzYwg6C00qgDceMB1WuQ5mIug2dX16re/
 Yi8h8AQLj1nuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11] drm/i915/dg2: Add per-client control for
 Wa_22013059131
To: "Jia Yao" <jia.yao@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260929172320.3481617-1-jia.yao@intel.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260929172320.3481617-1-jia.yao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:44:56 +0000
Message-Id: <20260929174457.3FD8B1F000FF@smtp.kernel.org>
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
- [High] drm/i915: Use-after-free of gem_ctx->client in ctx_needs_wa_220130=
59131()
--

commit 8ca882421f7da98e7f060c85d4cf71902e7198d0
Author: Jia Yao <jia.yao@intel.com>

    drm/i915/dg2: Add per-client control for Wa_22013059131
   =20
    Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT=
_0
    at engine init, but this is known to cause GPU hangs in certain workloa=
ds.
    Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
    workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
    kernel know bit 15 programming is not needed.

Link: https://github.com/intel/compute-runtime/pull/919

> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/g=
t/intel_lrc.c
> index 147d22907960b..4cb8496290638 100644
> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
[ ... ]
> @@ -1348,6 +1349,60 @@ gen12_invalidate_state_cache(u32 *cs)
>  	return cs;
>  }
> =20
> +static bool ctx_needs_wa_22013059131(const struct intel_context *ce)
> +{
> +	struct i915_gem_context *gem_ctx;
> +	bool needed =3D false;
> +
> +	/*
> +	 * Kernel-internal contexts (gem_context =3D=3D NULL) never run the
> +	 * shader workloads that require this workaround.
> +	 *
> +	 * For userspace contexts the choice belongs to the client, so latch
> +	 * the kernel as the owner unless the client has already opted out.
> +	 * This batchbuffer is what programs the register, and it is built
> +	 * only once per context (see lrc_pin()), so from here on the client
> +	 * can no longer opt out and set_client_wa_22013059131() will reject
> +	 * any attempt to.
> +	 */
> +	rcu_read_lock();
> +	gem_ctx =3D rcu_dereference(ce->gem_context);
> +	if (gem_ctx) {
> +		int owner =3D I915_WA_22013059131_KERNEL;
> +
> +		if (gem_ctx->client)
> +			owner =3D i915_drm_client_latch_wa_22013059131(gem_ctx->client, owner=
);

[Severity: High]
Does this introduce a use-after-free regression for gem_ctx->client?

The RCU read lock protects gem_ctx from being freed via kfree_rcu(), but it
does not protect gem_ctx->client. During context release,
i915_gem_context_release_work() synchronously frees the client before the R=
CU
grace period begins:

i915_gem_context_release_work()
    if (ctx->client)
        i915_drm_client_put(ctx->client);
    ...
    kfree_rcu(ctx, rcu);

If a user submits a hanging workload and immediately closes the context, the
context close drops the gem_ctx refcount to zero. This triggers the release
work and synchronously frees gem_ctx->client.

Concurrently, if the reset worker calls guc_reset_state() ->
lrc_update_regs() -> ctx_needs_wa_22013059131(), it can attempt to read and
modify the already-freed client memory via atomic_cmpxchg().

Would acquiring a strong reference via kref_get_unless_zero(&gem_ctx->ref)
be required here to safely access the client?

> +
> +		needed =3D owner !=3D I915_WA_22013059131_USERSPACE;
> +	}
> +	rcu_read_unlock();
> +
> +	return needed;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929172320.3481=
617-1-jia.yao@intel.com?part=3D1
