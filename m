Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41085606EE9C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kT2qId1Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CABA10F480;
	Tue,  3 Nov 2026 09:28:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D4310F474;
 Tue,  3 Nov 2026 09:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EC90D601EF;
 Tue,  3 Nov 2026 09:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E4D1F00919;
 Tue,  3 Nov 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793698096;
 bh=kHLZywTsZAKLRgvfxdfCZJOqF7Eh2MWorebcjzuhWEU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kT2qId1Zp9eYvDrck79F70FvBP101HDFX//4Pvj9xn3JTEnrEDayWXWHeI1D+Gdhp
 Bp+b9GeK0b5cB4MoKfoSHG+0DYvcfXO8+B2dwfwFjRV953OF6TYp4VlxNDjQOYreUW
 ufrDUKu0UxNYQm/29EmCnAgo/XBbtGA0NXz+FYICiQDftRU8RxNQU+7YXKMvcZ0A8a
 reAxiFNwgjsjjUV2ivevXRhIqLxxTB8e1NsjrV0wyeSOZTgrTIqYWrLVu2q90+D4Jm
 Tc81C9K7HqCCMb6nyk6RYK6J1ks3LuY1pfahYUNgWYZP/CqyzzZbvxDYfSxAesJr/Z
 ispKMN6o3Xn1A==
Date: Tue, 3 Nov 2026 10:28:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, umesh.nerlige.ramappa@intel.com, 
 intel-gfx@lists.freedesktop.org, tursulin@ursulin.net,
 jani.nikula@linux.intel.com, 
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/perf: Unpin the context if reading its GuC ID
 fails
Message-ID: <20261103-charming-pygmy-elk-eded62@quoll>
References: <20261103080237.1126027-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103080237.1126027-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 08:02:37 +0000, Wentao Liang wrote:
> oa_get_render_ctx_id() pins the context before obtaining its hardware ID.
> With GuC submission, gen12_get_render_context_id() can fail while
> allocating or accessing the scratch buffer used to read that ID. The
> error is returned without releasing the context pin.
> 
> i915_oa_stream_init() immediately returns this error, and its caller
> frees the stream without invoking the stream destroy callback. There is
> therefore no later opportunity to release the pin.
> 
> Unpin and clear pinned_ctx before returning this error. Also clear the
> pointer on the existing context-control-offset error path, so failed
> initialization consistently leaves no pinned context in the stream.
> 
> Fixes: 682aa4373f15 ("drm/i915/perf: Fix OA filtering logic for GuC mode")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/i915_perf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
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




