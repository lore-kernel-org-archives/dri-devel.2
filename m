Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84B606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mbp3AaRE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5EE210F3BB;
	Tue,  3 Nov 2026 07:27:15 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3228410F3BB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:27:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16E2A42EA8;
 Tue,  3 Nov 2026 07:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618EC1F00919;
 Tue,  3 Nov 2026 07:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793690830;
 bh=qBkNWuQjMxbzb8GowBbFRJH6mDDvu8/YycY80DV4sxg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mbp3AaREA+dLIfDpOdOXAGyEEA626RN4qLobmzleU2aNSNM8/td25Nk8pMOCoctTr
 jMYzKWgtxYkeWB2zS4y34iOmaLVOlYna9L5JnyPf1Bol4+gECftZJhKqJ7xOKtFHiN
 p0r00AkQFS5639OZM3rtdgjKV0z5vgOn6xQ7eOmI2k/JAg+1XHR8t20ihuh1HCYzsf
 aVHklt2yyd34Vhi+xXnafR0gRb1QJavkbn8D/dSBJBBzYb1GR929qrC+ohqBfcMQBf
 T1yFgRQK2gTjn31ot/vydkN/h3FAPrZRCkbSmBybSk2tp6Zpu/usET66v+b+9+aw3w
 csJhG2pw1nNiQ==
Date: Tue, 3 Nov 2026 08:27:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org, 
 linux-media@vger.kernel.org, stable@vger.kernel.org, christian.koenig@amd.com, 
 phasta@kernel.org, sumit.semwal@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Release input fences in the unwrap merge order
 test
Message-ID: <20261103-spiritual-archetypal-jellyfish-2f8fdd@quoll>
References: <20261103064457.1056056-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103064457.1056056-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 06:44:57 +0000, Wentao Liang wrote:
> The merge order test creates an array and a chain as inputs to
> dma_fence_unwrap_merge(). The merge takes references to the underlying
> fences but does not consume the input containers. The success path only
> puts the merged result, leaking both the input array and the outer chain,
> which owns the inner chain.
> 
> Put the outer chain after checking the merged result and fall through to
> the existing array cleanup on success as well as failure.
> 
> The dma-buf-fence-unwrap KUnit suite passes all 11 tests under UML.
> 
> Fixes: b1cce631e61f ("dma-buf: add selftest for fence order after merge")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/dma-buf/st-dma-fence-unwrap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
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




