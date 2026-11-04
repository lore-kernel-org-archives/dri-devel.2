Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535B8606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FMOQCjmg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9486F10F9EE;
	Wed,  4 Nov 2026 07:10:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D6F210F9E4;
 Wed,  4 Nov 2026 07:10:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E594422BA;
 Wed,  4 Nov 2026 07:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8F21F00A02;
 Wed,  4 Nov 2026 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793776250;
 bh=ARVX0Sr8zUMgzAZ201rrYM7GskA++Ru7w4lbEXXfQ2s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=FMOQCjmgZtgeD4O+vpj8LkWGEwtIVyLpnNPFzIe8ok9teqUjEtXw7TwuihKMG6liA
 2FxxfSnYI4hrYH7F2RG7LDo93GYwaPsAttSTQ4ol/KtlOdgSY13vIeNiP+FqIfy1bN
 OD60gHEvVGiMMaLiAWSJBKRtLqKjG44iB0FqbhJRbX4hEaZ40dcJUln3NYw6Ozgybw
 xLIKASIw+H+EMbH8R8AChPnQKnk9VTcyhxiAReTkMeR6wU+jXrzpvBJ4+iQKFWdOqi
 YFb7tLEDFyQtMHxvBqsyrxo/hycPbCpDqp8n8fYQpnZWCWskrFtB9WvKAd7VXEAHXh
 A1uUJsh8fDEHQ==
Date: Wed, 4 Nov 2026 08:10:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 David Airlie <airlied@gmail.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
 dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, 
 intel-gfx@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] drm/i915/selftests: read the seqno before dropping the
 request
Message-ID: <20261104-prompt-quirky-pigeon-0ff0fa@quoll>
References: <20261104025345.1527509-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104025345.1527509-1-vulab@iscas.ac.cn>
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 04 Nov 2026 02:53:45 +0000, Wentao Liang wrote:
> perf_mi_bb_start() waits for the request it has just submitted, drops the
> reference taken with i915_request_get() and only then reads
> rq->hwsp_seqno[].
> 
> i915_request_wait() returns as soon as the fence is signaled, which
> happens in i915_request_retire() before it puts the request's initial
> reference.  If retirement has already run, the put in this loop is the
> last one and i915_request_put() frees the request, so the seqno is read
> from an object that the SLAB_TYPESAFE_BY_RCU slab cache can already have
> handed out to another user.
> 
> Sample the seqno while the reference is still held.
> 
> Fixes: 3c7a44bbbfa7 ("drm/i915/selftests: Perform some basic cycle counting of MI ops")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gt/selftest_engine_cs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




