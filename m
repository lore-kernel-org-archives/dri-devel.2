Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39D606D80C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NIiyxDSn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C48A510F3E7;
	Tue,  3 Nov 2026 07:27:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47EAE10F3C9;
 Tue,  3 Nov 2026 07:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3DB7405A7;
 Tue,  3 Nov 2026 07:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCB21F000C1;
 Tue,  3 Nov 2026 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793690823;
 bh=2UnuvNTwSNhA/b6GJllR0EE5L47EKTxjsVEy/FAQlXI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NIiyxDSnojE1F4PCwK7yqKFa+jsgtfS5tsZ52Il6MxHOgyuEgSdh4TI8GPt9M6uJm
 52ZHO5L0CImM4bwOnbMppBktyOrU+4rs/Y3zFtjs7JB3Nj5fJ4f8a6y2tnj9igylnj
 PtC/51vZJ06PyYvXKUQteHnWeJgg3dyXtKqC7dlLTvmQdokfMQSc4XxhxlDP7vzXSF
 2aFDKKWCAj54sPez+fvBoQ/Yyr+KmRnpGVM0e9X97vAtw6VSaOpC16d973rW5iNdcU
 fGNPl97f/lq/27kXaKbbu4iNVDNbPLPXqcRxnm1BtaahCP82hbhpf4yUXfbJ67ec+N
 nRtY/EvAt2Dyg==
Date: Tue, 3 Nov 2026 08:27:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: tursulin@ursulin.net, jani.nikula@linux.intel.com, 
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/selftests: Put GuC test contexts on early
 failures
Message-ID: <20261103-careful-honorable-earwig-cee583@quoll>
References: <20261103065554.1073445-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103065554.1073445-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 06:55:54 +0000, Wentao Liang wrote:
> intel_hang_guc() creates an intel_context before changing the heartbeat
> interval and initializing the spinner. If either operation fails, it
> jumps to err without dropping that context. intel_guc_fast_request()
> also skips the context put when spinner initialization fails.
> 
> Release the context on these failure paths. The existing put after
> igt_spinner_create_request() handles the later paths.
> 
> Fixes: 69142c0a5f9a ("drm/i915/guc: Add selftest for a hung GuC")
> Fixes: 706785c19fe9 ("drm/i915/guc: Add a selftest for FAST_REQUEST errors")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gt/uc/selftest_guc.c           | 1 +
>  drivers/gpu/drm/i915/gt/uc/selftest_guc_hangcheck.c | 2 ++
>  2 files changed, 3 insertions(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

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
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




