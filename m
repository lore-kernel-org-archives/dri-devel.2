Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29007606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHR1QXCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A50310F3EA;
	Tue,  3 Nov 2026 07:27:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F1D10F3EB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 07:27:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EE2C605CE;
 Tue,  3 Nov 2026 07:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4011F000C1;
 Tue,  3 Nov 2026 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793690844;
 bh=xM3fZ0DeX/mIM0tXabGWnukqQCpCqfaj/WoRQI2M76A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BHR1QXCPq21cyEaTcSEtOMw/y9NQh+fLQxxtBdepNjhYEbM3Sh+rHoShJh7K5Zgh2
 +C85UKOPVr1aNp81RealW7rDfru9iukd0+s1S20WpyfmUd1Qzittzh+lSSQqXeMjQ8
 26oyxQFEW9PHYLDGzwrP6VkzmS9CNOJVoF0RS6qBqJ50k0yNIZfqbqVZva4wHzYgWx
 ZgmKC/rSI7yCLfhnHF3EVr3J+J0x7WEHLGsgcGijy4AslEMs5WLjY5zjiEtZyIaVIx
 KKUpbF78PtiM6xHgp97lvfj8T8O8y1ayCLem/7D1V2ZLk1Zs9aYZkv9L7D9C1D/zyo
 cM5JyqMKWLKsA==
Date: Tue, 3 Nov 2026 08:27:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, zack.rusin@broadcom.com, 
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/vmwgfx: Put the buffer object when handle creation
 fails
Message-ID: <20261103-violet-goldfish-of-enthusiasm-1afde0@quoll>
References: <20261103071527.1091375-1-vulab@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103071527.1091375-1-vulab@iscas.ac.cn>
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


On Tue, 03 Nov 2026 07:15:27 +0000, Wentao Liang wrote:
> vmw_gem_object_create_with_handle() leaves the allocation reference with
> its caller, including when drm_gem_handle_create() fails. The allocation
> ioctl currently skips dropping that reference on this error path, leaking
> the buffer object and its backing storage.
> 
> Drop the allocation reference at the common exit when an object was
> allocated. Keep the helper ownership rules unchanged, as its other callers
> already release the returned object on failure.
> 
> Fixes: 9ef8d83e8e25 ("drm/vmwgfx: Do not drop the reference to the handle too soon")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
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




