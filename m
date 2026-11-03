Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F14B606D81A
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZV3WDYp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891D010F476;
	Tue,  3 Nov 2026 09:28:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1840A10F46C;
 Tue,  3 Nov 2026 09:28:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5277560098;
 Tue,  3 Nov 2026 09:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD01F0093A;
 Tue,  3 Nov 2026 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793698093;
 bh=Q+bB5gmDGLtqPIJ6y2fMdQitLLU/dGXPtbUy8Xl3+Hk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=EZV3WDYplktXctFCMYyT618gYz0Xu7ZJHjQx0nxAh44OtIaJZBovtV50QHEST8B3s
 cURX+VAt5OzRXmfmjqKSr9otL2KIcmmwEkYpR1rbw+Pc0dc4aJsL5YSa5NRTjIiBH6
 I968Q/LKV5H8tdsJPJ/J0gyKgewMPtS8RXk4D/BDKsyO3bj+GIA4KKI67i6SkKCBla
 PbvTNuacY4v9lEMYCu/eVXMUDbQlWK+5G2XLZi/rWlXgP8hKHQWXG3jaGyQgzCnUwO
 gGZtzKVXNMP0OQzi9tIDylUzuoNCgfQGonHkJWqAolwYRUp3cQ2GKYTzsLAaEUS1A+
 ZAf/m/74x54Kw==
Date: Tue, 3 Nov 2026 10:28:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, tursulin@ursulin.net, 
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 intel-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jani.nikula@linux.intel.com
Subject: Re: [PATCH] drm/i915/selftests: Unpin the context in the LRC garbage
 test
Message-ID: <20261103-resourceful-bullfinch-of-strength-5a54aa@quoll>
References: <20261103080434.1127682-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103080434.1127682-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 08:04:34 +0000, Wentao Liang wrote:
> garbage() explicitly pins the context to corrupt its register state, but
> only releases that pin when request creation fails. On success, its caller
> waits for the request and drops the context reference without unpinning.
> The request's own context pin does not account for this extra pin.
> 
> Release the explicit pin immediately after creating the request, on both
> success and failure. A successful request already holds the context pin
> it needs until retirement, as in the other context selftests.
> 
> Fixes: 24eba7a9981d ("drm/i915/selftests: Check recovery from corrupted LRC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gt/selftest_lrc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
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




