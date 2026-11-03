Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F986606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYPHNe7Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A414510F491;
	Tue,  3 Nov 2026 09:28:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6323310F46C;
 Tue,  3 Nov 2026 09:28:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB49460098;
 Tue,  3 Nov 2026 09:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E1A1F0093A;
 Tue,  3 Nov 2026 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793698099;
 bh=ij4pfawAIRW/R6iIROir5Bacygd6lNvKMKgQO8Yp+JI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WYPHNe7ZvTdgRYfHSEy1NJjaWvcZ26yHXR7t3Ip8hyIA+z1hJDA5hSUxMESCv71ic
 RqgihqSPEfMPxw+ABjgT0UHoiHG/8G6G6+RcqqraijEdY13LinVuLaUQJjsjMUcC+m
 zhJb70LE+ieUwrENJXkrBTrl/4BaOWMwTsIO+syrsCATQDVBx3iFqU9seqolHGboPj
 ehG4Ayy6etBetGZzSwdiv2WmaGd3qIheguXyFKNnE8d5b9GGWl7kX45YHZvHKd52Bh
 63Tem4Ce/o/HNevQnQpVNjHmpUDRnxVQnGQ81hFMPCDivhWSE6LR6t4grHUV5zJJW8
 yNu2kV57ouFKw==
Date: Tue, 3 Nov 2026 10:28:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
 dri-devel@lists.freedesktop.org, 
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, rodrigo.vivi@intel.com
Subject: Re: [PATCH] drm/i915/selftests: Balance batch VMA pins in the
 preemption gang test
Message-ID: <20261103-slick-wapiti-of-snow-e9dc0d@quoll>
References: <20261103080030.1124149-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103080030.1124149-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 08:00:30 +0000, Wentao Liang wrote:
> create_gang() pins each batch VMA before mapping and submitting it. The
> mapping and request allocation error paths drop the object without
> unpinning the VMA. Later errors drop the request references but also leave
> the pin behind. On success, live_preempt_gang() releases the batch
> reference after waiting for each request, again without unpinning it.
> 
> Unpin on every error after a successful pin. Keep the batch pinned while
> the gang is in use, and unpin it when the caller releases each batch.
> This preserves the fixed addresses used by the semaphore chain while
> balancing the pin before the final object reference is dropped.
> 
> Fixes: 2d19a71ce68f ("drm/i915/selftests: Exercise long preemption chains")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gt/selftest_execlists.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
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




